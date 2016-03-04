import 'dart:async';
import 'dart:math';
import 'dart:io';

import 'girepository.dart' hide initLibrary;
import 'girepository.dart' as girepository;

bool runMainLoop = true;

Future main(List<String> args) async {
  girepository.initLibrary();
  var repo = new Repository.getDefault();
  List<Future> futures = [];
  for (var arg in args) {
    print('Processing $arg');
    final result = globalVisitNamespace(repo, arg);
    final outputFile = '${arg.toLowerCase()}.dart';
    var file = new File(outputFile);
    futures.add(file.writeAsString(result));
  }
  try {
    await Future.wait(futures);
    exit(0);
  } catch(err) {
    print(err);
    exit(1);
  }
}

String globalVisitNamespace(Repository repo, String name) {
  var gtk = new Namespace(repo, name);
  var visitor = new GINamespaceVisitor();
  var buffer = new StringBuffer();
  visitor.visitNamespace(gtk, repo, buffer);
  return buffer.toString();
}

class Pair<S, T> {
  final S lft;
  final T rgt;
  Pair(S this.lft, T this.rgt);

  int get hashCode => lft.hashCode * 63 + rgt.hashCode;
  bool operator==(Object other) => other is Pair && lft == other.lft && rgt
      == other.rgt;
}

class GINamespaceVisitor {
  Namespace rootNamespace;

  List<String> collectedNames;
  Map<String, Set<String>> hiddenNames = {};
  Map<Pair<List,List>, String> registeredTypes = {};
  Map<String, String> registeredErrorDomains = {};
  bool usesDartAsync = false;
  Map<String, String> namespacesByName = {};

  static final RegExp _underscoreToCamel = new RegExp('_([a-z])');
  static final RegExp _hyphenatedToCamel = new RegExp('-([a-z])');

  static const PROTECTED_NAMES = const ['String', 'Object', 'List', 'Pattern', 'DateTime'];
  static const PROTECTED_IDENTIFIERS = const [
    'abstract',
    'continue',
    'false',
    'new',
    'this',
    'as',
    'default',
    'final',
    'null',
    'throw',
    'assert',
    'deferred',
    'finally',
    'operator',
    'true',
    'async',
    'do',
    'for',
    'part',
    'try',
    'dynamic',
    'get',
    'rethrow',
    'typedef',
    'await',
    'else',
    'if',
    'return',
    'var',
    'break',
    'enum',
    'implements',
    'set',
    'void',
    'case',
    'export',
    'import',
    'static',
    'while',
    'catch',
    'external',
    'in',
    'super',
    'with',
    'class',
    'extends',
    'is',
    'switch',
    'yield',
    'const',
    'factory',
    'library',
    'int',
    'num',
  ];

  static String sanitizeIdentifier(String identifier) {
    while (PROTECTED_IDENTIFIERS.contains(identifier)) identifier =
        identifier + '_';
    return identifier;
  }

  visitNamespace(Namespace namespace, Repository repo, StringBuffer buffer) {
    buffer.write('library ${namespace.name.toLowerCase()}.gdart;\n\n');
    buffer.write('import "gdart.dart";\n\n');
    collectedNames = collectTypes(namespace);
    rootNamespace = namespace;
    var infoBuffer = new StringBuffer();

    visitInfos(namespace.infos, namespace.name, infoBuffer);
    visitDependenciesToImport(namespace.dependencies, repo, buffer);
    buffer.write('\n');
    buffer.write(infoBuffer);
    buffer.write("""
bool _initLibraryStarted = false;

void initLibrary() {
  if (_initLibraryStarted) return;
  _initLibraryStarted = true;
"""
    );
    for (var dependency in namespace.immediateDependencies) {
      var regex = new RegExp('-.*?\$');
      var libraryName = dependency.replaceAll(regex, '').toLowerCase();
      buffer.write('  $libraryName.initLibrary();\n');

    }
    for (var namespaceEntityPair in registeredTypes.keys) {
      buffer.write('  registerInterceptorTypeForNamedType'
          '("${namespaceEntityPair.lft}", "${namespaceEntityPair.rgt}",'
          '${registeredTypes[namespaceEntityPair]});\n');
    }
    for (var errorDomain in registeredErrorDomains.keys) {
      buffer.write('  registerInterceptorTypeForErrorDomain("$errorDomain", '
          '${registeredErrorDomains[errorDomain]});\n');
    }
    buffer.write('}\n');

    rootNamespace = null;
  }

  visitDependenciesToImport(List<String> dependencies, Repository repo, StringBuffer buffer) {
    if (usesDartAsync) {
      buffer.write('import "dart:async";\n\n');
    }
    for (var dependency
        in dependencies) visitDependencyToImport(dependency, repo, buffer);
    buffer.write('');
  }

  visitDependencyToImport(String dependency, Repository repo, StringBuffer buffer) {
    var regex = new RegExp('-.*?\$');
    final giLibraryName = dependency.replaceAll(regex, '');
    final namespaceObject = new Namespace(repo, giLibraryName);
    Set<String> namesToHide = hiddenNames[giLibraryName] ?? new Set();
    namesToHide.add('initLibrary');
    for (var hideableName in namespacesByName.keys) {
      if (namespacesByName[hideableName] == giLibraryName) continue;
      if (namespaceObject.findByName(hideableName) != null) {
        namesToHide.add(hideableName);
      }
    }

    var libraryName = giLibraryName.toLowerCase();
    buffer.write('import "$libraryName.dart" hide ${namesToHide.join(", ")};\n');
    buffer.write('import "$libraryName.dart" as $libraryName;\n');
  }

  visitInfos(Iterable<BaseInfo> infos, String namespace, StringBuffer buffer) {
    var suppressedStructs = new Set<String>();
    for (var info
        in infos) visitInfo(info, namespace, buffer, suppressedStructs);
  }

  void visitInfo(BaseInfo info, String namespace, StringBuffer buffer,
      Set<String> suppressedStructs) {
    if (info is ObjectInfo) {
      visitObjectInfo(info, buffer, suppressedStructs);
      return;
    }
    if (info is InterfaceInfo) {
      visitInterfaceInfo(info, buffer);
      return;
    }
    if (info is StructInfo) {
      if (suppressedStructs.contains(info.name)) return;
      visitStructInfo(info, buffer);
      return;
    }
    if (info is FlagsInfo) {
      visitFlagsInfo(info, buffer);
      return;
    }
    if (info is EnumInfo) {
      visitEnumInfo(info, buffer);
      return;
    }
    if (info is CallbackInfo) {
      visitCallbackInfo(info, buffer);
      return;
    }
    if (info is ConstantInfo) {
      visitConstantInfo(info, buffer);
      return;
    }
    if (info is FunctionInfo) {
      visitFunctionInfo(info, namespace, buffer);
      return;
    }
    if (info is UnionInfo) {
      visitUnionInfo(info, buffer);
      return;
    }
    print('// $info');
  }

  void visitFunctionInfo(
      FunctionInfo method, String namespace, StringBuffer buffer) {
    var arguments = collectMethodArgumentsIn(method);
    var methodName = method.name;
    String finalName = sanitizeIdentifier( methodName.replaceAllMapped(
        _underscoreToCamel, (match) => match.group(1).toUpperCase()));

    String typeName;
    var outArgs =
        new List<Pair<String, String>>.from(collectMethodArgumentsOut(method));
    if (outArgs.length == 0) {
      typeName = 'void';
    } else if (outArgs.length > 1) {
      typeName = 'List';
    } else {
      typeName = outArgs[0].rgt;
    }
    buffer.write('$typeName $finalName');
    buffer.write("(");
    buffer.writeAll(arguments.map((pair) => pair.rgt), ', ');
    buffer.write(")");
    buffer.write(" => callStaticGlobal('$namespace', '${method.name}', [");
    buffer.writeAll(arguments.map((pair) => pair.lft), ', ');
    buffer.write(']);\n\n');
  }

  void visitConstantInfo(ConstantInfo info, StringBuffer buffer) {
    print('//Skipping constant ${info.name}');
  }

  void visitCallbackInfo(CallbackInfo info, StringBuffer buffer) {
    String typeName;
    var outArgs =
        new List<Pair<String, String>>.from(collectMethodArgumentsOut(info));
    if (outArgs.length == 0) {
      typeName = 'void';
    } else if (outArgs.length > 1) {
      typeName = 'List';
    } else {
      typeName = outArgs[0].rgt;
    }
    buffer.write('typedef $typeName ${info.name}');
    buffer.write("(");
    buffer.writeAll(
        collectMethodArgumentsIn(info, isCallback: true)
            .map((pair) => pair.rgt),
        ', ');
    buffer.write(");\n");
  }

  void visitEnumInfo(EnumInfo info, StringBuffer buffer) {
    var className = reifyName(info.namespace, info.name);
    var errorDomain = info.errorDomain;
    if (errorDomain != null) {
      className += 'Code';
    }
    registeredTypes[new Pair(info.namespace, info.name)] = className;
    buffer.write('''
class $className extends GEnumBase {
  const $className(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('${info.namespace}', '${info.name}');

''');
    var valueMap = new Map<int, String>();
    visitValuesOfEnum(info.values, className, buffer, valueMap);
    buffer.write("""
  String toString() {
    switch(value) {
""");
    for (var key in valueMap.keys) {
      buffer.write("      case $key: return '$className.${valueMap[key]}';\n");
    }
    buffer.write("""
      default: return 'new $className(\$value)';
    }
  }
""");
    visitMethodsOfEnum(info.methods, className, buffer);
    buffer.write("}\n\n");
    if (errorDomain != null) {
      var errorName = reifyName(info.namespace, info.name);
      registeredErrorDomains[errorDomain] = errorName;
      buffer.write("""
class $errorName extends GErrorBase {
  static final int _quark = lookupErrorQuarkFromString('$errorDomain');
  $errorName($className code, String message)
      : super.fromFields(_quark, code, message);
}

""");
    }
  }

  void visitValuesOfEnum(Iterable<ValueInfo> values, String className,
      StringBuffer buffer, Map valueMap) {
    for (var value in values) {
      visitValueOfEnum(value, className, buffer, valueMap);
    }
  }

  void visitValueOfEnum(
      ValueInfo value, String className, StringBuffer buffer, Map valueMap) {
    var valueName = value.name.toUpperCase();
    var numericValue = value.value;

    valueMap[numericValue] = valueName;
    buffer.write("  static const $className $valueName = const $className"
        "($numericValue);\n");
  }

  void visitFlagsInfo(FlagsInfo info, StringBuffer buffer) {
    var className = reifyName(info.namespace, info.name);
    registeredTypes[new Pair(info.namespace, info.name)] = className;
    buffer.write('''
class $className extends GEnumBase {
  const $className(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('${info.namespace}', '${info.name}');

''');
    var valueMap = new Map<int, String>();
    var valuesBuffer = new StringBuffer();
    var maxValue =
        visitValuesOfFlags(info.values, className, valuesBuffer, valueMap);
    if (!valueMap.containsKey(0)) {
      buffer.write("  static const $className NULL = const $className(0);\n");
      valueMap[0] = 'NULL';
    }
    buffer.write(valuesBuffer);
    buffer.write("  static _valueToString(int value) {\n"
        "    switch(value) {\n");
    for (var key in valueMap.keys) {
      if (key == 0) continue;
      buffer.write("      case $key: return '$className.${valueMap[key]}';\n");
    }
    buffer.write("      default: return 'new $className(\$value)';\n"
        "    }\n"
        "  }\n");
    int i;
    for (i = 1; i <= maxValue; i <<= 1);
    i >>= 1;
    buffer.write("""
  String toString() {
    if (value == 0) {
      return '$className.${valueMap[0]}';
    }
    List codes = [];
    for (var i=1; i <= $i; i <<= 1) {
      if (value & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  $className operator|($className other) =>
    new $className(value | other.value);
  $className operator&($className other) =>
    new $className(value & other.value);
""");
    visitMethodsOfEnum(info.methods, className, buffer);
    buffer.write("}\n\n");
  }

  int visitValuesOfFlags(Iterable<ValueInfo> values, String className,
      StringBuffer buffer, Map valueMap) {
    int maxValue = 0;
    for (var value in values) {
      maxValue =
          max(maxValue, visitValueOfFlags(value, className, buffer, valueMap));
    }
    return maxValue;
  }

  int visitValueOfFlags(
      ValueInfo value, String className, StringBuffer buffer, Map valueMap) {
    var valueName = value.name.toUpperCase();
    var valueNameAsGetter = sanitizeIdentifier(value.name.replaceAllMapped(
        _underscoreToCamel, (match) => match.group(1).toUpperCase()));
    var numericValue = value.value;

    int hammingWeight = numericValue;
    hammingWeight = hammingWeight -
        ((hammingWeight >> 1) & 0x55555555); // reuse input as temporary
    hammingWeight = (hammingWeight & 0x33333333) +
        ((hammingWeight >> 2) & 0x33333333); // temp
    hammingWeight = ((hammingWeight + (hammingWeight >> 4) & 0xF0F0F0F) *
            0x1010101) >>
        24; // count
    if (hammingWeight <= 1 && !valueMap.containsKey(numericValue)) {
      valueMap[numericValue] = valueName;
    }
    buffer.write("  static const $className $valueName = const $className"
        "($numericValue);\n");
    buffer.write("  bool get $valueNameAsGetter => (value & $numericValue) =="
        " $numericValue;\n");
    return numericValue;
  }

  void visitUnionInfo(UnionInfo info, StringBuffer buffer) {
    var className = reifyName(info.namespace, info.name);
    registeredTypes[new Pair(info.namespace, info.name)] = className;
    String extendsClause = 'extends GObjectBase';
    buffer.write('''
class $className $extendsClause {
  ${reifyName(info.namespace, info.name)}.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('${info.namespace}', '${info.name}');

''');
    var objectNamespace = new Set();
    visitMethods(info.methods, className, buffer, objectNamespace);
    visitFieldsOfStruct(info.fields, buffer, objectNamespace);
    buffer.write('}\n\n');
  }

  void visitStructInfo(StructInfo info, StringBuffer buffer) {
    if (info.isGtypeStruct) return;
    var className = reifyName(info.namespace, info.name);
    registeredTypes[new Pair(info.namespace, info.name)] = className;
    String extendsClause = 'extends GObjectBase';
    buffer.write('''
class $className $extendsClause {
  ${reifyName(info.namespace, info.name)}.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('${info.namespace}', '${info.name}');

''');
    var objectNamespace = new Set();
    visitMethods(info.methods, className, buffer, objectNamespace);
    visitFieldsOfStruct(info.fields, buffer, objectNamespace);
    buffer.write('}\n\n');
  }

  void visitFieldsOfStruct(Iterable<FieldInfo> fields, StringBuffer buffer, Set objectNamespace) {
    int i = 0;
    for (var field in fields) {
      visitField(field, i, buffer, objectNamespace);
      i++;
    }
  }

  void visitInterfaceInfo(InterfaceInfo info, StringBuffer buffer) {
    List<String> prerequisites = collectPrerequisites(info);
    var className = reifyName(info.namespace, info.name);
    String extendsClause = 'extends GObjectBase';
    String withClause =
        prerequisites.isEmpty ? '' : ' implements ${prerequisites.join(', ')}';
    buffer.write('''
abstract class $className $extendsClause$withClause {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('${info.namespace}', '${info.name}');

''');
    var objectNamespace = new Set();
    Set<String> overridenGetters = new Set();
    Set<String> overridenSetters = new Set();
    visitConstants(info.constants, buffer);
    visitProperties(info.properties, buffer, objectNamespace, info, overridenGetters, overridenSetters);
    visitMethods(info.methods, className, buffer, objectNamespace, overridenGetters, overridenSetters);
    var helperClassBuffer = new StringBuffer();
    visitSignals(info.signals, className, buffer, helperClassBuffer);
    buffer.write('}\n\n');
    buffer.write(helperClassBuffer);
  }

  List<String> collectPrerequisites(InterfaceInfo info) {
    List parents = [];
    for (var interface in info.prerequisites) {
      parents.add(reifyName(interface.namespace, interface.name));
    }
    return parents;
  }

  void visitObjectInfo(
      ObjectInfo info, StringBuffer buffer, Set<String> suppressedStructs) {
    List<String> parents = collectParent(info);
    List<String> interfaces = collectInterfaces(info);
    var className = reifyName(info.namespace, info.name);
    registeredTypes[new Pair(info.namespace, info.name)] = className;
    String extendsClause =
        parents.isEmpty ? 'extends GObjectBase' : 'extends ${parents[0]}';
    String withClause =
        interfaces.isEmpty ? '' : ' with ${interfaces.join(', ')}';
    buffer.write('''
class $className $extendsClause$withClause {
  ${reifyName(info.namespace, info.name)}.fromNative()${parents.isEmpty ? '' : ' : super.fromNative()'};
  static final GIObjectInfo _staticInfo = new GIObjectInfo('${info.namespace}', '${info.name}');

''');
    visitConstants(info.constants, buffer);
    Set<String> objectNamespace = new Set();
    Set<String> overridenGetters = new Set();
    Set<String> overridenSetters = new Set();
    visitProperties(info.properties, buffer, objectNamespace, info, overridenGetters, overridenSetters);
    visitMethods(info.methods, className, buffer, objectNamespace, overridenGetters, overridenSetters);
    visitFieldsOfObject(
        info.fields, buffer, parents.length > 0, suppressedStructs, objectNamespace);
    var helperClassBuffer = new StringBuffer();
    visitSignals(info.signals, className, buffer, helperClassBuffer);
    buffer.write('}\n\n');
    buffer.write(helperClassBuffer);
  }

  void visitFieldsOfObject(Iterable<FieldInfo> fields, StringBuffer buffer,
      bool isInherited, Set<String> suppressedStructs, Set<String> objectNamespace) {
    int i = 0;
    List<FieldInfo> fieldsList = new List<FieldInfo>.from(fields);

    if (isInherited &&
        fieldsList.length == 2 &&
        fieldsList[1].type.tag == TypeTag.INTERFACE) {
      suppressedStructs.add(fieldsList[1].type.interface.name);
    } else if (fieldsList.length == 1 &&
        fieldsList[0].type.tag == TypeTag.INTERFACE) {
      suppressedStructs.add(fieldsList[0].type.interface.name);
    }

    for (var field in fields) {
      if (isInherited && i == 0) {
        i++;
        continue;
      } else if (isInherited && i == 1 && fieldsList.length == 2) {
        i++;
        continue;
      } else if (!isInherited && i == 0 && fieldsList.length == 1) {
        i++;
        continue;
      }
      visitField(field, i, buffer, objectNamespace);
      i++;
    }
  }

  void visitField(FieldInfo field, int i, StringBuffer buffer, [Set<String> objectNamespace]) {
    var flags = field.flags;
    var propertyName = sanitizeIdentifier(field.name.replaceAllMapped(
        _underscoreToCamel, (match) => match.group(1).toUpperCase()));
    if (objectNamespace != null && objectNamespace.contains(propertyName)) return;

    if (flags.isReadable) {
      var typeName = loadTypeName(field.type, null);
      buffer.write("  $typeName get $propertyName => "
          "getFieldOfObject('${field.name}', $i);\n");
    }
    if (flags.isWritable) {
      var typeName = loadTypeName(field.type, 'value');
      buffer.write("  void set $propertyName($typeName) => "
          "setFieldOfObject('${field.name}', $i, value);\n");
    }
  }

  void visitConstants(Iterable<ConstantInfo> constants, StringBuffer buffer) {
    for (var constant in constants) {
      visitConstant(constant, buffer);
    }
  }

  void visitConstant(ConstantInfo constant, StringBuffer buffer) {
    print('  //constant ${constant.name}');
  }

  void visitSignals(Iterable<SignalInfo> signals, String className,
      StringBuffer buffer, StringBuffer helperClassBuffer) {
    for (var signal in signals) {
      visitSignal(signal, className, buffer, helperClassBuffer);
    }
  }

  void visitSignal(SignalInfo signal, String className, StringBuffer buffer,
      StringBuffer helperClassBuffer) {
    var signalName = signal.name.replaceAllMapped(
        _hyphenatedToCamel, (match) => match.group(1).toUpperCase());
    var signalNameUppercase = signalName.replaceFirstMapped(
        new RegExp('^([a-z])'), (ma) => ma.group(0).toUpperCase());
    List<Pair<String, String>> argumentsIn =
        new List<Pair<String, String>>.from(collectMethodArgumentsIn(signal, unavailableArgs: ['result']));
    var argumentsOut =
        new List<Pair<String, String>>.from(collectMethodArgumentsOut(signal));
    String outArgName;

    if (argumentsOut.length == 0) {
      outArgName = 'void';
    } else if (argumentsOut.length > 1) {
      outArgName = 'List';
    } else {
      outArgName = argumentsOut[0].rgt;
    }
    var inArgsJoined = argumentsIn.map((pair) => pair.rgt).join(', ');
    var inArgsJoinedOut = argumentsIn.map((pair) => pair.lft).join(', ');

    bool isValidEvent = argumentsOut.length == 0 ||
        (argumentsOut.length == 1 && argumentsOut[0].rgt == 'bool');
    if (isValidEvent) {
      usesDartAsync = true;
      String eventName;
      String preAddStatement = '';
      if (argumentsIn.length == 0 && argumentsOut.length == 0) {
        eventName = null;
        if (inArgsJoinedOut == '') inArgsJoinedOut = 'null';
      } else if (argumentsIn.length == 1 && argumentsOut.length == 0) {
        eventName = argumentsIn[0].rgt.replaceFirst(new RegExp(' .*\$'), '');
      } else {
        eventName = '$className${signalNameUppercase}Event';
        preAddStatement = """
var result = new $className${signalNameUppercase}Event($inArgsJoinedOut);
              """;
        var inArgsJoinedField =
            argumentsIn.map((pair) => 'final ' + pair.rgt + ';').join('\n  ');
        var inArgsJoinedCons =
            argumentsIn.map((pair) => 'this.' + pair.lft).join(', ');
        String tagResult = '';
        if (argumentsOut.length == 1) {
          tagResult = """
  bool _cancelPropagation = false;
  void cancelPropagation() {
    _cancelPropagation = true;
  }""";
        }
        inArgsJoinedOut = 'result';
        helperClassBuffer.write("""
class $className${signalNameUppercase}Event {
  $inArgsJoinedField
$tagResult
  $className${signalNameUppercase}Event($inArgsJoinedCons);
}

""");
      }
      buffer.write("  int _connectTo$signalNameUppercase(bool after, "
          "$outArgName func($inArgsJoined)) => "
          "signalConnect('${signal.name}', func, after);\n");
      String specificType = eventName == null ? '' : '<$eventName>';
      String returnStatement = (argumentsOut.length == 1)
          ? """
    return result._cancelPropagation;
          """
          : '';
      buffer.write("""
  Stream$specificType get on$signalNameUppercase {
    int signalId;
    StreamController$specificType controller;
    controller = new StreamController$specificType(
      onListen: () {
          signalId = _connectTo$signalNameUppercase(false, ($inArgsJoined) {
              ${preAddStatement}controller.add($inArgsJoinedOut);
          ${returnStatement}});
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream$specificType get after$signalNameUppercase {
    int signalId;
    StreamController$specificType controller;
    controller = new StreamController$specificType(
      onListen: () {
          signalId = _connectTo$signalNameUppercase(true, ($inArgsJoined) {
              ${preAddStatement}controller.add($inArgsJoinedOut);
          ${returnStatement}});
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
""");
    } else {
      buffer.write("  int connectTo$signalNameUppercase(bool after, "
          "$outArgName func($inArgsJoined)) => "
          "signalConnect('${signal.name}', func, after);\n");
    }
  }

  void visitProperties(Iterable<PropertyInfo> properties, StringBuffer buffer, Set<String> objectNamespace, dynamic methodHolder, Set overridenGetters, Set<String> overridenSetters) {
    for (var property in properties) {
      visitProperty(property, buffer, objectNamespace, methodHolder, overridenGetters, overridenSetters);
    }
  }

  void visitProperty(PropertyInfo property, StringBuffer buffer, Set<String> objectNamespace, dynamic methodHolder, Set overridenGetters, Set overridenSetters) {
    var flags = property.flags;
    var propertyName = sanitizeIdentifier(property.name.replaceAllMapped(
        _hyphenatedToCamel, (match) => match.group(1).toUpperCase()));

    var giPropertyName = property.name.replaceAllMapped(_hyphenatedToCamel, (match) => '_' + match.group(1));
    bool takesNamespace = false;

    if (flags.readable) {
      var typeName = loadTypeName(property.propertyType, null);
      if (methodHolder.findMethod('get_' + giPropertyName) == null) {
        buffer.write("  $typeName get $propertyName => "
            "_staticInfo.getGPropertyOnReceiver('${property.name}', this);\n");
        takesNamespace = true;
      } else {
        overridenGetters.add('get_' + giPropertyName);
      }
    }
    if (flags.writable) {
      var typeName = loadTypeName(property.propertyType, 'value');
      if (methodHolder.findMethod('set_' + giPropertyName) == null) {
        buffer.write("  void set $propertyName($typeName) => "
            "_staticInfo.setGPropertyOnReceiver('${property.name}', this, value);\n");
        takesNamespace = true;
      } else {
        overridenSetters.add('set_' + giPropertyName);
      }
    }
    if (takesNamespace) {
      //At this phase, no property names should overlap.
      objectNamespace.add(propertyName);
    }
    if (!flags.explicitNotify) {
      var propertyDescName = property.name.replaceAll('-', '_').toUpperCase();
      buffer.write("  static const String ${propertyDescName}_PROPERTY = "
          "'${property.name}';\n");
    }
  }

  List<String> collectParent(ObjectInfo info) {
    List parents = [];
    if (info.fundamental) return [];
    if (info.parent == null) return [];
    parents.add(reifyName(info.parent.namespace, info.parent.name));
    return parents;
  }

  List<String> collectInterfaces(ObjectInfo info) {
    List parents = [];
    for (var interface in info.interfaces) {
      parents.add(reifyName(interface.namespace, interface.name));
    }
    return parents;
  }

  void visitMethodsOfEnum(
      Iterable<FunctionInfo> methods, String className, StringBuffer buffer) {
    for (var method in methods) {
      visitMethodOfEnum(method, className, buffer);
    }
  }

  void visitMethodOfEnum(
      FunctionInfo method, String className, StringBuffer buffer) {
    if (!method.flags.isMethod) {
      String finalName = sanitizeIdentifier(method.name.replaceAllMapped(
          _underscoreToCamel, (match) => match.group(1).toUpperCase()));
      var type = method.returnType;
      String typeName;
      if (type.tag == TypeTag.VOID) {
        typeName = 'void';
      } else {
        typeName = loadTypeName(type, null);
      }
      buffer.write('  static $typeName $finalName(');
      var arguments = collectMethodArgumentsIn(method);
      buffer.writeAll(arguments.map((pair) => pair.rgt), ', ');
      buffer.write(") => _staticInfo.callStatic('${method.name}', [");
      buffer.writeAll(arguments.map((pair) => pair.lft), ', ');
      buffer.write(']);\n');
    } else if (method.flags.isGetter) {
      String methodName;
      bool isGetter = false;
      var arguments = collectMethodArgumentsIn(method);
      var type = method.returnType;
      if (arguments.length == 0 && type.tag != TypeTag.VOID) {
        methodName = method.name.replaceFirst('get_', '');
        isGetter = true;
      } else {
        methodName = method.name;
      }
      String finalName = sanitizeIdentifier(methodName.replaceAllMapped(
          _underscoreToCamel, (match) => match.group(1).toUpperCase()));

      String typeName;
      if (type.tag == TypeTag.VOID) {
        typeName = 'void';
      } else {
        typeName = loadTypeName(type, null);
      }
      buffer.write('  $typeName ${isGetter? "get " : ""}$finalName');
      if (!isGetter) {
        buffer.write("(");
        buffer.writeAll(arguments.map((pair) => pair.rgt), ', ');
        buffer.write(")");
      }
      buffer.write(" => _staticInfo.callMethodOnReceiver('${method.name}', "
          "this, [");
      buffer.writeAll(arguments.map((pair) => pair.lft), ', ');
      buffer.write(']);\n');
    } else if (method.flags.isSetter) {
      String methodName;
      bool isSetter = false;
      var arguments = collectMethodArgumentsIn(method);
      var type = method.returnType;
      if (arguments.length == 1 && type.tag == TypeTag.VOID) {
        methodName = method.name.replaceFirst('set_', '');
        isSetter = true;
      } else {
        methodName = method.name;
      }
      String finalName = sanitizeIdentifier(methodName.replaceAllMapped(
          _underscoreToCamel, (match) => match.group(1).toUpperCase()));

      String typeName;
      var outArgs = new List<Pair<String, String>>.from(
          collectMethodArgumentsOut(method));
      if (outArgs.length == 0) {
        typeName = 'void';
      } else if (outArgs.length > 1) {
        typeName = 'List';
      } else {
        typeName = outArgs[0].rgt;
      }
      buffer.write('  $typeName ${isSetter? "set " : ""}$finalName');
      buffer.write("(");
      buffer.writeAll(arguments.map((pair) => pair.rgt), ', ');
      buffer.write(")");
      buffer.write(" => _staticInfo.callMethodOnReceiver('${method.name}', this, [");
      buffer.writeAll(arguments.map((pair) => pair.lft), ', ');
      buffer.write(']);\n');
    } else {
      var arguments = collectMethodArgumentsIn(method);
      var type = method.returnType;
      String finalName = sanitizeIdentifier(method.name.replaceAllMapped(
          _underscoreToCamel, (match) => match.group(1).toUpperCase()));
      String typeName;
      if (type.tag == TypeTag.VOID) {
        typeName = 'void';
      } else {
        typeName = loadTypeName(type, null);
      }
      buffer.write('  $typeName $finalName');
      buffer.write("(");
      buffer.writeAll(arguments.map((pair) => pair.rgt), ', ');
      buffer.write(")");
      buffer.write(" => _staticInfo.callMethodOnReceiver('${method.name}', this, [");
      buffer.writeAll(arguments.map((pair) => pair.lft), ', ');
      buffer.write(']);\n');
    }
  }

  void visitMethods(
      Iterable<FunctionInfo> methods, String className, StringBuffer buffer,
      Set<String> objectNamespace, [Set<String> overridenGetters, Set<String> overridenSetters]) {
    for (var method in methods) {
      visitMethod(method, className, buffer, objectNamespace, overridenGetters, overridenSetters);
    }
  }

  void visitMethod(FunctionInfo method, String className, StringBuffer buffer, Set<String> objectNamespace, Set<String> overridenGetters, Set<String> overridenSetters) {
    if (method.flags.isConstructor) {
      String finalName;
      if (method.name == 'new') {
        finalName = null;
      } else {
        var newTrimmer = new RegExp('^new_');
        var tempName = method.name.replaceFirst(newTrimmer, '');
        finalName = sanitizeIdentifier(tempName.replaceAllMapped(
            _underscoreToCamel, (match) => match.group(1).toUpperCase()));
        if (objectNamespace.contains(finalName)) {
          final fromIzer = new RegExp('^[a-z]');
          finalName = finalName.replaceFirstMapped(fromIzer, (match) => 'from' + match.group(0).toUpperCase());
        }
        objectNamespace.add(finalName);
      }

      buffer.write(
          '  factory $className${finalName == null ? "" : ".$finalName"}(');
      var arguments = collectMethodArgumentsIn(method);
      buffer.writeAll(arguments.map((pair) => pair.rgt), ', ');
      buffer.write(") => _staticInfo.callStatic('${method.name}', [");
      buffer.writeAll(arguments.map((pair) => pair.lft), ', ');
      buffer.write(']);\n');
    } else if (!method.flags.isMethod) {
      String finalName = sanitizeIdentifier(method.name.replaceAllMapped(
          _underscoreToCamel, (match) => match.group(1).toUpperCase()));
      String typeName;
      var outArgs = new List<Pair<String, String>>.from(
          collectMethodArgumentsOut(method));
      if (outArgs.length == 0) {
        typeName = 'void';
      } else if (outArgs.length > 1) {
        typeName = 'List';
      } else {
        typeName = outArgs[0].rgt;
      }
      while (objectNamespace.contains(finalName)) {
        finalName = finalName + '_';
      }
      objectNamespace.add(finalName);
      buffer.write('  static $typeName $finalName(');
      var arguments = collectMethodArgumentsIn(method);
      buffer.writeAll(arguments.map((pair) => pair.rgt), ', ');
      buffer.write(") => _staticInfo.callStatic('${method.name}', [");
      buffer.writeAll(arguments.map((pair) => pair.lft), ', ');
      buffer.write(']);\n');
    } else if (method.flags.isGetter || method.name.startsWith('get_')) {
      String methodName;
      String typeName;
      bool isGetter = false;
      var arguments = collectMethodArgumentsIn(method);
      var outArgs = new List<Pair<String, String>>.from(
          collectMethodArgumentsOut(method));
      if (outArgs.length == 0) {
        typeName = 'void';
      } else if (outArgs.length > 1) {
        typeName = 'List';
      } else {
        typeName = outArgs[0].rgt;
      }
      if (arguments.length == 0 && outArgs.length == 1) {
        methodName = method.name.replaceFirst('get_', '');
        isGetter = true;
      } else {
        methodName = method.name;
      }
      String finalName = sanitizeIdentifier(methodName.replaceAllMapped(
          _underscoreToCamel, (match) => match.group(1).toUpperCase()));

      while (objectNamespace.contains(finalName)) {
        finalName = finalName + '_';
      }
      objectNamespace.add(finalName);
      buffer.write('  $typeName ${isGetter? "get " : ""}$finalName');
      if (!isGetter) {
        buffer.write("(");
        buffer.writeAll(arguments.map((pair) => pair.rgt), ', ');
        buffer.write(")");
      }
      buffer.write(" => _staticInfo.callMethodOnReceiver('${method.name}', this, [");
      buffer.writeAll(arguments.map((pair) => pair.lft), ', ');
      buffer.write(']);\n');
    } else if (method.flags.isSetter || (method.name.startsWith('set_') && objectNamespace.contains(method.name.replaceFirst('set_', '').replaceAllMapped(_underscoreToCamel, (match) => match.group(1).toUpperCase()))) || (overridenSetters != null && overridenSetters.contains(method.name))) {
      String methodName;
      bool isSetter = false;
      var arguments = collectMethodArgumentsIn(method);
      String typeName;
      var outArgs = new List<Pair<String, String>>.from(
          collectMethodArgumentsOut(method));
      if (outArgs.length == 0) {
        typeName = 'void';
      } else if (outArgs.length > 1) {
        typeName = 'List';
      } else {
        typeName = outArgs[0].rgt;
      }
      if (arguments.length == 1 && outArgs.length == 0) {
        methodName = method.name.replaceFirst('set_', '');
        isSetter = true;
      } else {
        methodName = method.name;
      }
      String finalName = sanitizeIdentifier(methodName.replaceAllMapped(
          _underscoreToCamel, (match) => match.group(1).toUpperCase()));
      buffer.write('  $typeName ${isSetter? "set " : ""}$finalName');
      buffer.write("(");
      buffer.writeAll(arguments.map((pair) => pair.rgt), ', ');
      buffer.write(")");
      buffer.write(" => _staticInfo.callMethodOnReceiver('${method.name}', this, [");
      buffer.writeAll(arguments.map((pair) => pair.lft), ', ');
      buffer.write(']);\n');
    } else {
      var arguments = collectMethodArgumentsIn(method);
      String finalName = sanitizeIdentifier(method.name.replaceAllMapped(
          _underscoreToCamel, (match) => match.group(1).toUpperCase()));
      String typeName;
      var outArgs = new List<Pair<String, String>>.from(
          collectMethodArgumentsOut(method));
      if (outArgs.length == 0) {
        typeName = 'void';
      } else if (outArgs.length > 1) {
        typeName = 'List';
      } else {
        typeName = outArgs[0].rgt;
      }
      final matchesIs = new RegExp('^is[A-Z]');
      if (objectNamespace.contains(finalName) && finalName.startsWith(matchesIs)) {
        final fromIzer = new RegExp('^[a-z]');
        finalName = finalName.replaceFirstMapped(fromIzer, (match) => 'get' + match.group(0).toUpperCase());
      }
      while (objectNamespace.contains(finalName)) {
        finalName = finalName + '_';
      }
      objectNamespace.add(finalName);
      buffer.write('  $typeName $finalName');
      buffer.write("(");
      buffer.writeAll(arguments.map((pair) => pair.rgt), ', ');
      buffer.write(")");
      buffer.write(" => _staticInfo.callMethodOnReceiver('${method.name}', this, [");
      buffer.writeAll(arguments.map((pair) => pair.lft), ', ');
      buffer.write(']);\n');
    }
  }

  Iterable<Pair<String, String>> collectMethodArgumentsIn(CallableInfo method,
      {bool isCallback: false, List unavailableArgs: const []}) {
    List<ArgInfo> args = new List.from(method.args);
    Set<ArgInfo> skippedArgs = loadSkippedArgs(method, args);
    if (isCallback &&
        args.length > 0 &&
        args[args.length - 1].argType.tag.index == 0) {
      skippedArgs.add(args[args.length - 1]);
    }
    return args
        .where((arg) =>
            (!skippedArgs.contains(arg) && arg.direction != Direction.OUT))
        .map((arg) {
      var finalName = sanitizeIdentifier(arg.name.replaceAllMapped(
          _underscoreToCamel, (match) => match.group(1).toUpperCase()));
      while (unavailableArgs.contains(finalName)) {
        finalName += '_';
      }
      var right = loadTypeName(arg.argType, finalName);
      return new Pair<String, String>(finalName, right);
    });
  }

  Iterable<Pair<String, String>> collectMethodArgumentsOut(
      CallableInfo method) {
    List<ArgInfo> args = new List.from(method.args);
    Set<ArgInfo> skippedArgs = loadSkippedArgs(method, args);
    return new Iterable.generate(2, (ix) => ix).expand((ix) {
      switch (ix) {
        case 0:
          if (method.returnType.tag == TypeTag.VOID ||
              (method.canThrowGerror &&
                  method.returnType.tag == TypeTag.BOOLEAN)) {
            return [];
          }
          var right = loadTypeName(method.returnType, null);
          return [new Pair<String, String>(null, right)];
        case 1:
          return method.args
              .where((arg) =>
                  (!skippedArgs.contains(arg) && arg.direction != Direction.IN))
              .map((arg) {
            var finalName = sanitizeIdentifier(arg.name.replaceAllMapped(
                _underscoreToCamel, (match) => match.group(1).toUpperCase()));
            var right = loadTypeName(arg.argType, null);
            return new Pair<String, String>(finalName, right);
          });
      }
    });
  }

  String loadTypeName(TypeInfo typeInfo, String argName) {
    var tag = typeInfo.tag;
    if (argName != null) {
      argName = ' ' + argName;
    } else {
      argName = '';
    }
    if (tag == TypeTag.VOID) {
      return 'dynamic$argName /* this will fail */';
    }
    if (tag == TypeTag.FLOAT || tag == TypeTag.DOUBLE) {
      return 'num$argName';
    }
    if (tag == TypeTag.BOOLEAN) {
      return 'bool$argName';
    }
    if (tag == TypeTag.ERROR) {
      return 'GErrorBase$argName';
    }
    if (tag == TypeTag.GLIST) {
      return 'GLibList$argName /* this will fail */';
    }
    if (tag == TypeTag.GSLIST) {
      return 'SList$argName /* this will fail */';
    }
    if (tag == TypeTag.GHASH) {
      return 'HashTable$argName';
    }
    if (tag == TypeTag.UTF8 || tag == TypeTag.FILENAME) {
      return 'String$argName';
    }
    if (tag == TypeTag.ARRAY) {
      var innerType = loadTypeName(typeInfo.getParamType(0), null);
      return 'List<$innerType>$argName';
    }
    if (tag == TypeTag.INTERFACE) {
      var interface = typeInfo.interface;
      return '${reifyName(interface.namespace, interface.name)}$argName';
    }
    return 'int$argName';
  }

  Set<ArgInfo> loadSkippedArgs(CallableInfo method, List<ArgInfo> args) {
    var skippedArgs = new Set<ArgInfo>();
    loadSkippedType(null, method.returnType, skippedArgs, args);
    for (var arg in args) {
      loadSkippedType(arg, arg.argType, skippedArgs, args);
    }
    return skippedArgs;
  }

  void loadSkippedType(ArgInfo arg /*null if the arg is the return value */,
      TypeInfo type, Set<ArgInfo> skippedArgs, List<ArgInfo> args) {
    if (type.tag == TypeTag.ARRAY) {
      var arrayLength = type.arrayLength;
      if (arrayLength != -1) {
        skippedArgs.add(args[arrayLength]);
      }
    }
    if (type.tag == TypeTag.INTERFACE && arg != null) {
      if (type.interface is CallbackInfo) {
        var destroy = arg.destroy;
        var closure = arg.closure;
        if (closure != -1) {
          skippedArgs.add(args[closure]);
        }
        if (closure != -1 && destroy != -1) {
          skippedArgs.add(args[destroy]);
        }
      }
    }
  }

  String reifyName(String namespace, String typeName) {
    var searchName =
        (PROTECTED_NAMES.contains(typeName)) ? '$namespace$typeName' : typeName;
    if (collectedNames == null || namespace == rootNamespace.name) {
      return searchName;
    }
    if (collectedNames.contains(searchName) || (
        namespacesByName.containsKey(searchName) && namespacesByName[searchName] != namespace)) {
      if (!hiddenNames.containsKey(namespace)) {
        hiddenNames[namespace] = new Set();
      }
      if (!hiddenNames[namespace].contains(searchName)) {
        hiddenNames[namespace].add(searchName);
      }
      return '${namespace.toLowerCase()}.$searchName';
    }
    namespacesByName[searchName] = namespace;
    return searchName;
  }

  List<String> collectTypes(Namespace namespace) =>
      visitInfosCollectType(namespace.infos);
  visitInfosCollectType(Iterable<BaseInfo> infos) {
    List<String> names = [];
    for (var info in infos) {
      var name = visitInfoCollectType(info);
      if (name != null) names.add(name);
    }
    return names;
  }

  String visitInfoCollectType(BaseInfo info) {
    if (info is ObjectInfo) {
      return reifyName(info.namespace, info.name);
    }
    return null;
  }
}
