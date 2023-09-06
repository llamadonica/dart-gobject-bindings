import 'package:gir_binding_gen/src/print_visitor.dart';
import 'package:gir_bootstrapper/gir_bootstrapper.dart';

abstract class BaseVisitor<T> implements Visitor<T> {
  @override
  T visitNamespacesInfo(NamespacesEntity info);

  @override
  T visitNamespaceInfo(NamespaceEntity info);

  @override
  T visitBaseInfo(BaseInfoVisitable info);

  @override
  T visitRegisteredTypeInfo(RegisteredTypeInfoVisitable info) {
    return visitBaseInfo(info);
  }

  @override
  T visitBaseInfoAttribute(BaseInfoAttributeVisitable attribute);

  @override
  T visitCallableInfo(CallableInfoVisitable info) {
    return visitBaseInfo(info);
  }

  @override
  T visitCallbackInfo(CallbackInfoVisitable info) {
    return visitCallableInfo(info);
  }

  @override
  T visitEnumInfo(EnumInfoVisitable info) {
    return visitRegisteredTypeInfo(info);
  }

  @override
  T visitStructInfo(StructInfoVisitable info) {
    return visitRegisteredTypeInfo(info);
  }

  @override
  T visitBoxedInfo(BoxedInfoVisitable info) {
    return visitBaseInfo(info);
  }

  @override
  T visitObjectInfo(ObjectInfoVisitable info) {
    return visitRegisteredTypeInfo(info);
  }

  @override
  T visitInterfaceInfo(InterfaceInfoVisitable info) {
    return visitRegisteredTypeInfo(info);
  }

  @override
  T visitConstantInfo(ConstantInfoVisitable info) {
    return visitBaseInfo(info);
  }

  @override
  T visitUnionInfo(UnionInfoVisitable info) {
    return visitRegisteredTypeInfo(info);
  }

  @override
  T visitValueInfo(ValueInfoVisitable info) {
    return visitBaseInfo(info);
  }

  @override
  T visitVFuncInfo(VFuncInfoVisitable info) {
    return visitCallableInfo(info);
  }

  @override
  T visitSignalInfo(SignalInfoVisitable info) {
    return visitCallableInfo(info);
  }

  @override
  T visitPropertyInfo(PropertyInfoVisitable info) {
    return visitBaseInfo(info);
  }

  @override
  T visitFieldInfo(FieldInfoVisitable info) {
    return visitBaseInfo(info);
  }

  @override
  T visitArgInfo(ArgInfoVisitable info) {
    return visitBaseInfo(info);
  }

  @override
  T visitTypeInfo(TypeInfoVisitable info) {
    return visitBaseInfo(info);
  }

  @override
  T visitFunctionInfo(FunctionInfoVisitable info) {
    return visitCallableInfo(info);
  }

  @override
  T visitFlagsInfo(FlagsInfoVisitable info) {
    return visitEnumInfo(info);
  }

  @override
  T visitEnumConstantValue(EnumConstantValueVisitable enumConstantValueVisitable) {
    return visitConstantValue(enumConstantValueVisitable);
  }

  @override
  T visitIntegerConstantValue(IntegerConstantValueVisitable integerConstantValueVisitable) {
    return visitConstantValue(integerConstantValueVisitable);
  }

  @override
  T visitStringConstantValue(StringConstantValueVisitable stringConstantValueVisitable) {
    return visitConstantValue(stringConstantValueVisitable);
  }

  @override
  T visitFloatConstantValue(FloatConstantValueVisitable floatConstantValueVisitable) {
    return visitConstantValue(floatConstantValueVisitable);
  }

  @override
  T visitBooleanConstantValue(BooleanConstantValueVisitable booleanConstantValueVisitable) {
    return visitConstantValue(booleanConstantValueVisitable);
  }

  @override
  T visitListConstantValue(ListConstantValueVisitable listConstantValueVisitable) {
    return visitConstantValue(listConstantValueVisitable);
  }

  @override
  T visitUnknownConstantValue(UnknownConstantValueVisitable unknownConstantInfoVisitable) {
    return visitConstantValue(unknownConstantInfoVisitable);
  }
}

abstract interface class Visitor<T> {
  T visitNamespacesInfo(NamespacesEntity info);

  T visitNamespaceInfo(NamespaceEntity info);

  T visitBaseInfo(BaseInfoVisitable info);

  T visitRegisteredTypeInfo(RegisteredTypeInfoVisitable info);

  T visitBaseInfoAttribute(BaseInfoAttributeVisitable attribute);

  T visitCallableInfo(CallableInfoVisitable info);

  T visitCallbackInfo(CallbackInfoVisitable info);

  T visitEnumInfo(EnumInfoVisitable info);

  T visitStructInfo(StructInfoVisitable info);

  T visitBoxedInfo(BoxedInfoVisitable info);

  T visitObjectInfo(ObjectInfoVisitable info);

  T visitInterfaceInfo(InterfaceInfoVisitable info);

  T visitConstantInfo(ConstantInfoVisitable info);

  T visitUnionInfo(UnionInfoVisitable info);

  T visitValueInfo(ValueInfoVisitable info);

  T visitVFuncInfo(VFuncInfoVisitable info);

  T visitSignalInfo(SignalInfoVisitable info);

  T visitPropertyInfo(PropertyInfoVisitable info);

  T visitFieldInfo(FieldInfoVisitable info);

  T visitArgInfo(ArgInfoVisitable info);

  T visitTypeInfo(TypeInfoVisitable info);

  T visitFunctionInfo(FunctionInfoVisitable info);

  T visitFlagsInfo(FlagsInfoVisitable info);

  T visitParameterizedType(ParameterizedType parameterizedType);

  T visitConstantValue(ConstantValueVisitable constantValueVisitable);

  T visitEnumConstantValue(EnumConstantValueVisitable enumConstantValueVisitable);

  T visitIntegerConstantValue(IntegerConstantValueVisitable integerConstantValueVisitable);

  T visitStringConstantValue(StringConstantValueVisitable stringConstantValueVisitable);

  T visitFloatConstantValue(FloatConstantValueVisitable floatConstantValueVisitable);

  T visitBooleanConstantValue(BooleanConstantValueVisitable booleanConstantValueVisitable);

  T visitListConstantValue(ListConstantValueVisitable listConstantValueVisitable);

  T visitUnknownConstantValue(UnknownConstantValueVisitable unknownConstantInfoVisitable);
}

abstract interface class GirNode extends Visitable {
  Iterable<GirNode> get children;

  String? get name;

  String get shortTypeName;

  void visitChildren(Visitor visitor) {
    for (final child in children) {
      child.accept(visitor);
    }
  }
}

class NamespacesEntity extends GirNode {
  final Repository repository;

  final List<String> namespaces;

  NamespacesEntity(this.repository, this.namespaces);

  @override
  T accept<T>(Visitor<T> visitor) {
    return visitor.visitNamespacesInfo(this);
  }

  @override
  Iterable<NamespaceEntity> get children sync* {
    yield* namespaces.map((namespace) => NamespaceEntity(repository, namespace));
  }

  @override
  String get shortTypeName => 'global';

  @override
  String? get name => '';
}

class NamespaceEntity extends GirNode {
  final Repository repository;

  final String namespace;

  NamespaceEntity(this.repository, this.namespace);

  @override
  T accept<T>(Visitor<T> visitor) {
    return visitor.visitNamespaceInfo(this);
  }

  @override
  Iterable<BaseInfoVisitable> get children sync* {
    yield* repository.getInfos(namespace).map((info) => BaseInfoVisitable.create(info));
  }
  
  @override
  String get shortTypeName => 'namespace';
  
  @override
  String? get name => namespace;
}

abstract interface class Visitable {
  T accept<T>(Visitor<T> visitor);
}

final class BaseInfoVisitable<T extends BaseInfo> extends GirNode {
  T info;

  BaseInfoVisitable._(this.info);

  static BaseInfoVisitable create(BaseInfo info) {
    if (info is CallbackInfo) {
      return CallbackInfoVisitable(info);
    }
    if (info is FlagsInfo) {
      return FlagsInfoVisitable(info);
    }
    if (info is FunctionInfo) {
      return FunctionInfoVisitable(info);
    }
    if (info is EnumInfo) {
      return EnumInfoVisitable<EnumInfo>._(info);
    }
    if (info is StructInfo) {
      return StructInfoVisitable(info);
    }
    if (info is BoxedInfo) {
      return BoxedInfoVisitable(info);
    }
    if (info is ObjectInfo) {
      return ObjectInfoVisitable(info);
    }
    if (info is InterfaceInfo) {
      return InterfaceInfoVisitable(info);
    }
    if (info is ConstantInfo) {
      return ConstantInfoVisitable(info);
    }
    if (info is UnionInfo) {
      return UnionInfoVisitable(info);
    }
    if (info is ValueInfo) {
      return ValueInfoVisitable(info);
    }
    if (info is VFuncInfo) {
      return VFuncInfoVisitable(info);
    }
    if (info is SignalInfo) {
      return SignalInfoVisitable(info);
    }
    if (info is PropertyInfo) {
      return PropertyInfoVisitable(info);
    }
    if (info is FieldInfo) {
      return FieldInfoVisitable(info);
    }
    if (info is ArgInfo) {
      return ArgInfoVisitable(info);
    }
    if (info is TypeInfo) {
      return TypeInfoVisitable(info);
    }
    if (info is RegisteredTypeInfo) {
      return RegisteredTypeInfoVisitable._(info);
    }
    if (info is CallableInfo) {
      return CallableInfoVisitable._(info);
    }

    return BaseInfoVisitable._(info);
  }

  String? getAttribute(String name) {
    return info.getAttribute(name);
  }

  BaseInfoVisitable? get container => info.container == null ? null : create(info.container!);

  @override
  String? get name => info.name;

  String? get namespace => info.namespace;

  bool get isDeprecated => info.isDeprecated;

  Iterable<BaseInfoAttributeVisitable> get attributes => info.attributes.map((attribute) => BaseInfoAttributeVisitable(attribute));

  @override
  TI accept<TI>(Visitor<TI> visitor) {
    return visitor.visitBaseInfo(this);
  }

  @override
  bool operator ==(Object other) {
    if (other is BaseInfoVisitable) {
      return info == other.info;
    }
    return false;
  }

  @override
  int get hashCode => info.hashCode;

  @override
  Iterable<GirNode> get children sync* {
    yield* attributes;
  }
  
  @override
  String get shortTypeName => 'unknown';
}

final class RegisteredTypeInfoVisitable<T extends RegisteredTypeInfo> extends BaseInfoVisitable<T> {
  RegisteredTypeInfoVisitable._(T info) : super._(info);

  int get gType => info.gType;

  String? get typeName => info.typeName;

  String? get typeInit => info.typeInit;

  @override
  TI accept<TI>(Visitor<TI> visitor) {
    return visitor.visitRegisteredTypeInfo(this);
  }

  @override
  String get shortTypeName => 'registeredType';
}

final class CallableInfoVisitable<T extends CallableInfo> extends BaseInfoVisitable<T> {
  CallableInfoVisitable._(T info) : super._(info);

  Transfer get callerOwns => info.callerOwns;

  bool get canThrowGError => info.canThrowGerror;

  bool get isMethod => info.isMethod;

  TypeInfoVisitable? get returnType => info.returnType == null ? null : TypeInfoVisitable(info.returnType!);

  Iterable<ArgInfoVisitable> get args => info.args.map((arg) => ArgInfoVisitable(arg));

  bool get skipReturn => info.skipReturn;

  bool get mayReturnNull => info.mayReturnNull;

  Iterable<BaseInfoAttributeVisitable> get returnAttributes => info.returnAttributes.map((attribute) => BaseInfoAttributeVisitable(attribute));

  @override
  TI accept<TI>(Visitor<TI> visitor) {
    return visitor.visitCallableInfo(this);
  }

  @override
  Iterable<GirNode> get children sync* {
    if (returnType != null) {
      yield returnType!;
      yield* returnAttributes;
    }
    yield* args;
    yield* attributes;
  }
  
  @override
  String get shortTypeName => 'callable';
}

final class CallbackInfoVisitable extends CallableInfoVisitable<CallbackInfo> {
  CallbackInfoVisitable(CallbackInfo info) : super._(info);

  @override
  TI accept<TI>(Visitor<TI> visitor) {
    return visitor.visitCallbackInfo(this);
  }
  
  @override
  String get shortTypeName => 'callback';
}

final class FunctionInfoVisitable extends CallableInfoVisitable<FunctionInfo> {
  FunctionInfoVisitable(FunctionInfo info) : super._(info);

  String get symbol => info.symbol;

  VFuncInfoVisitable? get vfunc => info.vfunc == null ? null : VFuncInfoVisitable(info.vfunc!);

  PropertyInfoVisitable? get property => info.property == null ? null : PropertyInfoVisitable(info.property!);

  @override
  TI accept<TI>(Visitor<TI> visitor) {
    return visitor.visitFunctionInfo(this);
  }
  
  @override
  String get shortTypeName => 'function';
}

final class EnumInfoVisitable<T extends EnumInfo> extends RegisteredTypeInfoVisitable<T> {
  EnumInfoVisitable._(T info) : super._(info);

  String? get errorDomain => info.errorDomain;

  TypeTag get storageType => info.storageType;

  Iterable<ValueInfoVisitable> get values => info.values.map((value) => ValueInfoVisitable(value));

  Iterable<FunctionInfoVisitable> get methods => info.methods.map((method) => FunctionInfoVisitable(method));

  @override
  Iterable<GirNode> get children sync* {
    yield* values;
    yield* methods;
    yield* attributes;
  }
  
  @override
  String get shortTypeName => 'enum';
}

final class FlagsInfoVisitable extends EnumInfoVisitable<FlagsInfo> {
  FlagsInfoVisitable(FlagsInfo info) : super._(info);

  @override
  TI accept<TI>(Visitor<TI> visitor) {
    return visitor.visitFlagsInfo(this);
  }
  
  @override
  String get shortTypeName => 'flags';
}

final class StructInfoVisitable extends RegisteredTypeInfoVisitable<StructInfo> {
  StructInfoVisitable(StructInfo info) : super._(info);

  int get alignment => info.alignment;

  int get size => info.size;

  bool get isGtypeStruct => info.isGtypeStruct;

  bool get isForeign => info.isForeign;

  String? get freeFunction => info.freeFunction;

  String? get copyFunction => info.copyFunction;

  Iterable<FieldInfoVisitable> get fields => info.fields.map((field) => FieldInfoVisitable(field));

  Iterable<FunctionInfoVisitable> get methods => info.methods.map((method) => FunctionInfoVisitable(method));

  @override
  Iterable<GirNode> get children sync* {
    yield* fields;
    yield* methods;
    yield* attributes;
  }
  
  @override
  String get shortTypeName => 'struct';
}

final class BoxedInfoVisitable extends BaseInfoVisitable<BoxedInfo> {
  BoxedInfoVisitable(BoxedInfo info) : super._(info);

  @override
  TI accept<TI>(Visitor<TI> visitor) {
    return visitor.visitBoxedInfo(this);
  }
  
  @override
  String get shortTypeName => 'boxed';
}

final class ObjectInfoVisitable extends RegisteredTypeInfoVisitable<ObjectInfo> {
  ObjectInfoVisitable(ObjectInfo info) : super._(info);

  bool get abstract => info.abstract;

  StructInfoVisitable? get classStruct => info.classStruct == null ? null : StructInfoVisitable(info.classStruct!);

  bool get isFinal => info.isFinal;

  bool get fundamental => info.fundamental;

  String? get getValueFunction => info.getValueFunction;

  ObjectInfoVisitable? get parent => info.parent == null ? null : ObjectInfoVisitable(info.parent!);

  @override
  String get typeInit => info.typeInit;

  @override
  String get typeName => info.typeName;

  String? get setValueFunction => info.setValueFunction;

  String? get refFunction => info.refFunction;

  String? get unrefFunction => info.unrefFunction;

  Iterable<FunctionInfoVisitable> get methods => info.methods.map((method) => FunctionInfoVisitable(method));

  Iterable<PropertyInfoVisitable> get properties => info.properties.map((property) => PropertyInfoVisitable(property));

  Iterable<SignalInfoVisitable> get signals => info.signals.map((signal) => SignalInfoVisitable(signal));

  Iterable<VFuncInfoVisitable> get vfuncs => info.vfuncs.map((vfunc) => VFuncInfoVisitable(vfunc));

  Iterable<ConstantInfoVisitable> get constants => info.constants.map((constant) => ConstantInfoVisitable(constant));

  Iterable<FieldInfoVisitable> get fields => info.fields.map((field) => FieldInfoVisitable(field));

  @override
  TI accept<TI>(Visitor<TI> visitor) {
    return visitor.visitObjectInfo(this);
  }

  @override
  Iterable<GirNode> get children sync* {
    yield* methods;
    yield* properties;
    yield* signals;
    yield* vfuncs;
    yield* constants;
    yield* fields;
    yield* attributes;
  }
  
  @override
  String get shortTypeName => 'object';
}

final class InterfaceInfoVisitable extends RegisteredTypeInfoVisitable<InterfaceInfo> {
  InterfaceInfoVisitable(InterfaceInfo info) : super._(info);

  StructInfoVisitable get ifaceStruct => StructInfoVisitable(info.ifaceStruct);

  Iterable<FunctionInfoVisitable> get methods => info.methods.map((method) => FunctionInfoVisitable(method));

  Iterable<PropertyInfoVisitable> get properties => info.properties.map((property) => PropertyInfoVisitable(property));

  Iterable<SignalInfoVisitable> get signals => info.signals.map((signal) => SignalInfoVisitable(signal));

  Iterable<VFuncInfoVisitable> get vfuncs => info.vfuncs.map((vfunc) => VFuncInfoVisitable(vfunc));

  Iterable<ConstantInfoVisitable> get constants => info.constants.map((constant) => ConstantInfoVisitable(constant));

  @override
  TI accept<TI>(Visitor<TI> visitor) {
    return visitor.visitInterfaceInfo(this);
  }

  @override
  Iterable<GirNode> get children sync* {
    yield* methods;
    yield* properties;
    yield* signals;
    yield* vfuncs;
    yield* constants;
    yield* attributes;
  }
}

final class ConstantInfoVisitable extends BaseInfoVisitable<ConstantInfo> {
  ConstantInfoVisitable(ConstantInfo info) : super._(info);

  TypeInfoVisitable get type => TypeInfoVisitable(info.type);

  ConstantValueVisitable get value => ConstantValueVisitable(info.value);

  @override
  String get shortTypeName => 'constant';

  @override
  Iterable<GirNode> get children sync* {
    yield type;
    yield value;
    yield* attributes;
  }

  @override
  T accept<T>(Visitor<T> visitor) {
    return visitor.visitConstantInfo(this);
  }
}

sealed class ConstantValueVisitable extends GirNode {
  ConstantValueVisitable._();

  factory ConstantValueVisitable(ConstantValue info) {
    if (info is BooleanConstantValue) {
      return BooleanConstantValueVisitable(info);
    }
    if (info is EnumConstantValue) {
      return EnumConstantValueVisitable(info);
    }
    if (info is IntegerConstantValue) {
      return IntegerConstantValueVisitable(info);
    }
    if (info is StringConstantValue) {
      return StringConstantValueVisitable(info);
    }
    if (info is FloatConstantValue) {
      return FloatConstantValueVisitable(info);
    }
    if (info is ListConstantValue) {
      return ListConstantValueVisitable(info);
    }
    return UnknownConstantValueVisitable(info as UnknownConstantValue);
  }

  @override
  final Iterable<GirNode> children = const [];

  @override
  String? get name => null;

  @override
  String get shortTypeName => 'constantValue';

  String renderValue();
}

class EnumConstantValueVisitable extends ConstantValueVisitable {
  final EnumConstantValue info;

  EnumConstantValueVisitable(this.info) : super._();

  BaseInfoVisitable get enumInfo => BaseInfoVisitable.create(info.enumInfo);

  int get value => info.value;

  @override
  T accept<T>(Visitor<T> visitor) {
    return visitor.visitEnumConstantValue(this);
  }

  @override
  String renderValue() {
    return '(${enumInfo.namespace}.${enumInfo.name})$value';
  }

}

class IntegerConstantValueVisitable extends ConstantValueVisitable {
  final IntegerConstantValue info;

  IntegerConstantValueVisitable(this.info) : super._();

  int get value => info.value;

  @override
  T accept<T>(Visitor<T> visitor) {
    return visitor.visitIntegerConstantValue(this);
  }

  @override
  String renderValue() {
    return '$value';
  }
}

class StringConstantValueVisitable extends ConstantValueVisitable {
  final StringConstantValue info;

  StringConstantValueVisitable(this.info) : super._();

  String get value => info.value;

  @override
  T accept<T>(Visitor<T> visitor) {
    return visitor.visitStringConstantValue(this);
  }

  @override
  String renderValue() {
    final escapeRegex = RegExp(r"[\x00-\x1F'\x7F-\uFFFF\\]");
    final escaped = value.replaceAllMapped(escapeRegex, (match) {
      final char = match.group(0)!;
      final code = char.codeUnitAt(0);
      switch (code) {
        case 0x07:
          return '\\a';
        case 0x08:
          return '\\b';
        case 0x09:
          return '\\t';
        case 0x0A:
          return '\\n';
        case 0x0B:
          return '\\v';
        case 0x0C:
          return '\\f';
        case 0x0D:
          return '\\r';
        case 0x5C:
          return '\\\\';
      }
      if (code < 0x100) {
        return '\\x${code.toRadixString(16).padLeft(2, '0')}';
      }
      return '\\u${code.toRadixString(16).padLeft(4, '0')}';

    });
    return "'$escaped'";

  }
}

class FloatConstantValueVisitable extends ConstantValueVisitable {
  final FloatConstantValue info;

  FloatConstantValueVisitable(this.info) : super._();

  double get value => info.value;

  @override
  T accept<T>(Visitor<T> visitor) {
    return visitor.visitFloatConstantValue(this);
  }

  @override
  String renderValue() {
    return '$value';
  }
}

class BooleanConstantValueVisitable extends ConstantValueVisitable {
  final BooleanConstantValue info;

  BooleanConstantValueVisitable(this.info) : super._();

  bool get boolValue => info.boolValue;

  @override
  T accept<T>(Visitor<T> visitor) {
    return visitor.visitBooleanConstantValue(this);
  }

  @override
  String renderValue() {
    return '$boolValue';
  }
}

class ListConstantValueVisitable extends ConstantValueVisitable {
  final ListConstantValue info;

  ListConstantValueVisitable(this.info) : super._();

  Iterable<ConstantValueVisitable> get values => info.values.map((element) => ConstantValueVisitable(element));

  @override
  T accept<T>(Visitor<T> visitor) {
    return visitor.visitListConstantValue(this);
  }

  @override
  Iterable<GirNode> get children sync* {
    yield* values;
  }

  @override
  String renderValue() {
    return '[${values.map((value) => value.renderValue()).join(', ')}]';
  }
}

class UnknownConstantValueVisitable extends ConstantValueVisitable {
  final UnknownConstantValue info;

  UnknownConstantValueVisitable(this.info) : super._();

  @override
  T accept<T>(Visitor<T> visitor) {
    return visitor.visitUnknownConstantValue(this);
  }

  @override
  String get shortTypeName => 'unknownConstantValue';

  @override
  String renderValue() {
    return 'unknown';
  }
}



final class UnionInfoVisitable extends RegisteredTypeInfoVisitable<UnionInfo> {
  UnionInfoVisitable(UnionInfo info) : super._(info);

  int get alignment => info.alignment;

  int get size => info.size;

  TypeInfoVisitable? get discriminatorType => info.discriminatorType == null ? null : TypeInfoVisitable(info.discriminatorType!);

  int get discriminatorOffset => info.discriminatorOffset;

  String? get freeFunction => info.freeFunction;

  String? get copyFunction => info.copyFunction;

  Iterable<FieldInfoVisitable> get fields => info.fields.map((field) => FieldInfoVisitable(field));

  Iterable<FunctionInfoVisitable> get methods => info.methods.map((method) => FunctionInfoVisitable(method));

  Iterable<ConstantInfoVisitable> get discriminators => info.discriminators.map((constant) => ConstantInfoVisitable(constant));

  @override
  Iterable<GirNode> get children sync* {
    yield* fields;
    yield* methods;
    yield* attributes;
  }

  @override
  String get shortTypeName => 'union';

  @override
  T accept<T>(Visitor<T> visitor) {
    return visitor.visitUnionInfo(this);
  }
}

final class ValueInfoVisitable extends BaseInfoVisitable<ValueInfo> {
  ValueInfoVisitable(ValueInfo info) : super._(info);

  int get value => info.value;

  EnumConstantValueVisitable get enumValue {
    final enumInfo = info.container as EnumInfo;
    return EnumConstantValueVisitable(EnumConstantValue(enumInfo, IntegerConstantValue(value)));
  }

  @override
  String get shortTypeName => 'value';

  @override
  T accept<T>(Visitor<T> visitor) {
    return visitor.visitValueInfo(this);
  }

  @override
  Iterable<GirNode> get children sync* {
    yield enumValue;
    yield* attributes;
  }
}

final class VFuncInfoVisitable extends CallableInfoVisitable<VFuncInfo> {
  VFuncInfoVisitable(VFuncInfo info) : super._(info);

  VFuncInfoFlags get flags => info.flags;

  int get offset => info.offset;

  SignalInfoVisitable? get signal => info.signal == null ? null : SignalInfoVisitable(info.signal!);

  FunctionInfoVisitable? get invoker => info.invoker == null ? null : FunctionInfoVisitable(info.invoker!);

  @override
  String get shortTypeName => 'vfunc';

  @override
  T accept<T>(Visitor<T> visitor) {
    return visitor.visitVFuncInfo(this);
  }
}

final class SignalInfoVisitable extends CallableInfoVisitable<SignalInfo> {
  SignalInfoVisitable(SignalInfo info) : super._(info);

  SignalFlags get flags => info.flags;

  bool get trueStopsEmit => info.trueStopsEmit;

  VFuncInfoVisitable? get classClosure => info.classClosure == null ? null : VFuncInfoVisitable(info.classClosure!);

  @override
  String get shortTypeName => 'signal';

  @override
  T accept<T>(Visitor<T> visitor) {
    return visitor.visitSignalInfo(this);
  }

}

final class PropertyInfoVisitable extends BaseInfoVisitable<PropertyInfo> {
  PropertyInfoVisitable(PropertyInfo info) : super._(info);

  ParamFlags get flags => info.flags;

  TypeInfoVisitable get type => TypeInfoVisitable(info.type);

  FunctionInfoVisitable? get getter => info.getter == null ? null : FunctionInfoVisitable(info.getter!);

  FunctionInfoVisitable? get setter => info.setter == null ? null : FunctionInfoVisitable(info.setter!);

  Transfer get ownershipTransfer => info.ownershipTransfer;

  @override
  Iterable<GirNode> get children sync* {
    yield type;
    yield* attributes;
  }

  @override
  String get shortTypeName => 'property';

  @override
  T accept<T>(Visitor<T> visitor) {
    return visitor.visitPropertyInfo(this);
  }
}

final class FieldInfoVisitable extends BaseInfoVisitable<FieldInfo> {
  FieldInfoVisitable(FieldInfo info) : super._(info);

  FieldInfoFlags get flags => info.flags;

  int get offset => info.offset;

  TypeInfoVisitable get type => TypeInfoVisitable(info.type);

  int get size => info.size;

  @override
  Iterable<GirNode> get children sync* {
    yield type;
    yield* attributes;
  }

  @override
  String get shortTypeName => 'field';

  @override
  T accept<T>(Visitor<T> visitor) {
    return visitor.visitFieldInfo(this);
  }
}

final class ArgInfoVisitable extends BaseInfoVisitable<ArgInfo> {
  ArgInfoVisitable(ArgInfo info) : super._(info);

  int get closure => info.closure;

  int get destroy => info.destroy;

  Direction get direction => info.direction;

  Transfer get ownershipTransfer => info.ownershipTransfer;

  ScopeType get scope => info.scope;

  bool get isCallerAllocates => info.isCallerAllocates;

  bool get isOptional => info.isOptional;

  bool get isReturnValue => info.isReturnValue;

  bool get isSkip => info.isSkip;

  bool get mayBeNull => info.mayBeNull;

  TypeInfoVisitable get type => TypeInfoVisitable(info.type);

  @override
  Iterable<GirNode> get children sync* {
    yield type;
    yield* attributes;
  }

  @override
  String get shortTypeName => 'arg';

  @override
  T accept<T>(Visitor<T> visitor) {
    return visitor.visitArgInfo(this);
  }
}

final class TypeInfoVisitable extends BaseInfoVisitable<TypeInfo> {
  TypeInfoVisitable(TypeInfo info) : super._(info);

  TypeTag get tag => info.tag;

  int get arrayLength => info.arrayLength;

  int get arrayFixedSize => info.arrayFixedSize;

  bool get isPointer => info.isPointer;

  BaseInfoVisitable? get interface => info.interface == null ? null : BaseInfoVisitable.create(info.interface!);

  bool get _isReference {
    switch (tag) {
      case TypeTag.filename:
      case TypeTag.utf8:
      case TypeTag.array:
      case TypeTag.glist:
      case TypeTag.gslist:
      case TypeTag.ghash:
        return true;
      case TypeTag.interface:
        break;
      default:
        return false;
    }
    final interface = this.interface;
    if (interface is ObjectInfoVisitable) {
      return true;
    }
    if (interface is CallbackInfoVisitable) {
      return true;
    }
    return false;
  }

  TypeInfoVisitable? getParamType(int n) {
    final paramType = info.getParamType(n);
    if (paramType != null) {
      return TypeInfoVisitable(paramType);
    }
    return null;
  }

  TypeTag get storageType => info.storageType;

  bool get isZeroTerminated => info.isZeroTerminated;

  @override
  String get shortTypeName => 'type';

  @override
  T accept<T>(Visitor<T> visitor) {
    return visitor.visitTypeInfo(this);
  }

  @override
  Iterable<GirNode> get children sync* {
    yield* attributes;
    var i = 0;
    while (true) {
      final paramType = getParamType(i);
      if (paramType == null) {
        break;
      }
      yield ParameterizedType(i, paramType);
      i++;
    }
  }

  @override
  String get name {
    final buffer = StringBuffer();
    _describe(buffer);
    return buffer.toString();
  }

  void _describe(StringBuffer buffer) {
    if (tag == TypeTag.error) {
      buffer.write('GLib.GError');
    } else if (tag == TypeTag.filename) {
      buffer.write('String');
    } else if (tag == TypeTag.utf8) {
      buffer.write('String');
    } else if (tag == TypeTag.glist) {
      buffer.write('GLib.GList<');
      final paramType = getParamType(0);
      paramType?._describe(buffer);
      buffer.write('>');
    } else if (tag == TypeTag.gslist) {
      buffer.write('GLib.GSList<');
      final paramType = getParamType(0);
      paramType?._describe(buffer);
      buffer.write('>');
    } else if (tag == TypeTag.array) {
      final paramType = getParamType(0);
      paramType?._describe(buffer);
      buffer.write('[');
      if (arrayFixedSize > 0) {
        buffer.write(arrayFixedSize);
      }
      buffer.write(']');
    } else if (tag == TypeTag.ghash) {
      buffer.write('GLib.GHashTable<');
      final keyType = getParamType(0);
      final valueType = getParamType(1);
      keyType?._describe(buffer);
      buffer.write(',');
      valueType?._describe(buffer);
      buffer.write('>');
    } else if (tag == TypeTag.interface) {
      final interface = this.interface;
      if (interface != null) {
        buffer.write(interface.namespace);
        buffer.write('.');
        buffer.write(interface.name);
      } else {
        buffer.write('unknown');
      }
    } else if (tag == TypeTag.gtype) {
      buffer.write('GLib.GType');
    } else {
      buffer.write(tag);
    }
    if (isPointer && !_isReference) {
      buffer.write('*');
    }
  }
}

final class ParameterizedType extends GirNode {
  final int position;
  final TypeInfoVisitable typeInfo;

  ParameterizedType(this.position, this.typeInfo);

  @override
  T accept<T>(Visitor<T> visitor) {
    return visitor.visitParameterizedType(this);
  }

  @override
  Iterable<GirNode> get children => [typeInfo];

  @override
  String? get name => null;

  @override
  String get shortTypeName => 'parameterizedType';

}

final class BaseInfoAttributeVisitable extends GirNode {
  final BaseInfoAttribute attribute;

  BaseInfoAttributeVisitable(this.attribute);

  @override
  String get name => attribute.name;

  String get value => attribute.value;

  @override
  T accept<T>(Visitor<T> visitor) {
    return visitor.visitBaseInfoAttribute(this);
  }

  @override
  final Iterable<GirNode> children = const [];

  @override
  String get shortTypeName => 'attribute';
}
