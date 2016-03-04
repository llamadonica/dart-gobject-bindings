library girepository.gdart;

import 'gdart.dart';

void initLibrary() {
  registerInterceptorTypeForNamedType("GIRepository", "BaseInfo", _BaseInfo);
  registerCopyFuncForNamedType("GIRepository", "BaseInfo", "g_base_info_ref");
  registerFreeFuncForNamedType("GIRepository", "BaseInfo", "g_base_info_unref");

  registerInterceptorTypeForNamedType("GIRepository", "Direction", Direction);
  registerInterceptorTypeForNamedType("GIRepository", "Repository", Repository);
  registerInterceptorTypeForNamedType("GIRepository", "Typelib", Typelib);
  registerInterceptorTypeForNamedType("GIRepository", "InfoType", InfoType);
  registerInterceptorTypeForNamedType("GIRepository", "TypeTag", TypeTag);
  registerInterceptorTypeForNamedType("GIRepository", "FunctionInfoFlags",
      FunctionInfoFlags);
  registerInterceptorTypeForNamedType("GIRepository", "FieldInfoFlags",
      FieldInfoFlags);
  registerInterceptorTypeForNamedType("GObject", "ParamFlags", ParamFlags);
}

abstract class HasInfoType {
  InfoType get type;
  HasInfoType realize();
}

abstract class HasStorageType {
  TypeTag get storageType;
}

class _BaseInfo extends GObjectBase with GIObjectInfo implements HasInfoType {
  _BaseInfo.fromNative();

  InfoType _getType() => callMethod('get_type', []);
  String _getName() => callMethod('get_name', []);
  String _getNamespace() => callMethod('get_namespace', []);
  bool _equal(_BaseInfo other) => callMethod('equal', [other]);

  InfoType get type => _getType();
  HasInfoType realize() => new BaseInfo(this);
}

class BaseInfo implements GIObjectInfo, HasInfoType {
  final _BaseInfo _baseInfo;
  BaseInfo._fromNative(_BaseInfo this._baseInfo);

  factory BaseInfo(_BaseInfo baseInfo) {
    if (baseInfo == null) return null;
    switch(baseInfo._getType().index) {
    case 1: return new FunctionInfo._fromNative(baseInfo);
    case 2: return new CallbackInfo._fromNative(baseInfo);
    case 3: return new StructInfo._fromNative(baseInfo);
    case 4: return new BoxedInfo._fromNative(baseInfo);
    case 5: return new EnumInfo._fromNative(baseInfo);
    case 6: return new FlagsInfo._fromNative(baseInfo);
    case 7: return new ObjectInfo._fromNative(baseInfo);
    case 8: return new InterfaceInfo._fromNative(baseInfo);
    case 9: return new ConstantInfo._fromNative(baseInfo);
    case 11: return new UnionInfo._fromNative(baseInfo);
    case 12: return new ValueInfo._fromNative(baseInfo);
    case 13: return new SignalInfo._fromNative(baseInfo);
    case 14: return new VFuncInfo._fromNative(baseInfo);
    case 15: return new PropertyInfo._fromNative(baseInfo);
    case 16: return new FieldInfo._fromNative(baseInfo);
    case 17: return new ArgInfo._fromNative(baseInfo);
    case 18: return new TypeInfo._fromNative(baseInfo);
      case 1: return new FunctionInfo._fromNative(baseInfo);
      default: return new BaseInfo._fromNative(baseInfo);
    }
  }

  InfoType get type => _baseInfo._getType();
  String get name => _baseInfo._getName();
  String get namespace => _baseInfo._getNamespace();
  bool operator==(Object other) => other is BaseInfo && _baseInfo._equal(other._baseInfo);


  @override
  callMethodOnReceiver(String name, receiver, List args) => _baseInfo.callMethodOnReceiver(name, receiver, args);

  @override
  callStatic(String name, List args) => _baseInfo.callStatic(name, args);

  @override
  getGPropertyOnReceiver(String name, receiver) => _baseInfo.getGPropertyOnReceiver(name, receiver);

  @override
  void setGPropertyOnReceiver(String name, receiver, value) => _baseInfo.setGPropertyOnReceiver(name, receiver, value);

  HasInfoType realize() => this;
}

class CallableInfo extends BaseInfo {
  CallableInfo._fromNative(_BaseInfo baseInfo) : super._fromNative(baseInfo);

  Iterable<ArgInfo> get args => new Iterable.generate(
      _callableInfoGetNArgs(_baseInfo),
          (i) => new BaseInfo(_callableInfoGetArg(_baseInfo, i)));
  TypeInfo get returnType => new BaseInfo(_callableInfoGetReturnType(_baseInfo));
  bool get canThrowGerror => _callableInfoCanThrowGerror(_baseInfo);
}

class FunctionInfo extends CallableInfo {
  FunctionInfo._fromNative(_BaseInfo baseInfo) : super._fromNative(baseInfo);

  FunctionInfoFlags get flags => _functionInfoGetFlags(_baseInfo);
}

class CallbackInfo extends CallableInfo {
  CallbackInfo._fromNative(_BaseInfo baseInfo)  : super._fromNative(baseInfo);
}

class StructInfo extends BaseInfo {
  StructInfo._fromNative(_BaseInfo baseInfo)  : super._fromNative(baseInfo);
  Iterable<FunctionInfo> get methods => new Iterable.generate(
      _structInfoGetNMethods(_baseInfo),
      (i) => new BaseInfo(_structInfoGetMethod(_baseInfo, i)));
  Iterable<FieldInfo> get fields => new Iterable.generate(
      _structInfoGetNFields(_baseInfo),
      (i) => new BaseInfo(_structInfoGetField(_baseInfo, i)));
  bool get isGtypeStruct => _structInfoIsGtypeStruct(_baseInfo);
}

class BoxedInfo extends BaseInfo {
  BoxedInfo._fromNative(_BaseInfo baseInfo)  : super._fromNative(baseInfo);
}

class EnumInfo extends BaseInfo implements HasStorageType {
  EnumInfo._fromNative(_BaseInfo baseInfo)  : super._fromNative(baseInfo);
  Iterable<ValueInfo> get values => new Iterable.generate(
      _enumInfoGetNValues(_baseInfo),
      (i) => new BaseInfo(_enumInfoGetValue(_baseInfo, i)));
  Iterable<FunctionInfo> get methods => new Iterable.generate(
      _enumInfoGetNMethods(_baseInfo),
      (i) => new BaseInfo(_enumInfoGetMethod(_baseInfo, i)));
  String get errorDomain => _enumInfoGetErrorDomain(_baseInfo);
  TypeTag get storageType => _enumInfoGetStorageType(_baseInfo);
}

class FlagsInfo extends BaseInfo implements HasStorageType {
  FlagsInfo._fromNative(_BaseInfo baseInfo)  : super._fromNative(baseInfo);
  Iterable<ValueInfo> get values => new Iterable.generate(
      _enumInfoGetNValues(_baseInfo),
      (i) => new BaseInfo(_enumInfoGetValue(_baseInfo, i)));
  Iterable<FunctionInfo> get methods => new Iterable.generate(
      _enumInfoGetNMethods(_baseInfo),
      (i) => new BaseInfo(_enumInfoGetMethod(_baseInfo, i)));
  TypeTag get storageType => _enumInfoGetStorageType(_baseInfo);
}

class ObjectInfo extends BaseInfo {
  ObjectInfo._fromNative(_BaseInfo baseInfo)  : super._fromNative(baseInfo);

  bool get fundamental => _objectInfoGetFundamental(_baseInfo);
  ObjectInfo get parent => new BaseInfo(_objectInfoGetParent(_baseInfo));
  Iterable<InterfaceInfo> get interfaces => new Iterable.generate(
      _objectInfoGetNInterfaces(_baseInfo),
          (i) => new BaseInfo(_objectInfoGetInterface(_baseInfo, i)));
  Iterable<FunctionInfo> get methods => new Iterable.generate(
      _objectInfoGetNMethods(_baseInfo),
      (i) => new BaseInfo(_objectInfoGetMethod(_baseInfo, i)));
  Iterable<PropertyInfo> get properties => new Iterable.generate(
      _objectInfoGetNProperties(_baseInfo),
      (i) => new BaseInfo(_objectInfoGetProperty(_baseInfo, i)));
  Iterable<SignalInfo> get signals => new Iterable.generate(
      _objectInfoGetNSignals(_baseInfo),
      (i) => new BaseInfo(_objectInfoGetSignal(_baseInfo, i)));
  Iterable<ConstantInfo> get constants => new Iterable.generate(
      _objectInfoGetNConstants(_baseInfo),
      (i) => new BaseInfo(_objectInfoGetConstant(_baseInfo, i)));
  Iterable<FieldInfo> get fields => new Iterable.generate(
      _objectInfoGetNFields(_baseInfo),
      (i) => new BaseInfo(_objectInfoGetField(_baseInfo, i)));
  FunctionInfo findMethod(String name) => new BaseInfo(_objectInfoFindMethod(_baseInfo, name));
}

class InterfaceInfo extends BaseInfo {
  InterfaceInfo._fromNative(_BaseInfo baseInfo)  : super._fromNative(baseInfo);

  Iterable<ConstantInfo> get prerequisites => new Iterable.generate(
      _interfaceInfoGetNPrerequisites(_baseInfo),
      (i) => new BaseInfo(_interfaceInfoGetPrerequisite(_baseInfo, i)));
  Iterable<FunctionInfo> get methods => new Iterable.generate(
      _interfaceInfoGetNMethods(_baseInfo),
      (i) => new BaseInfo(_interfaceInfoGetMethod(_baseInfo, i)));
  Iterable<PropertyInfo> get properties => new Iterable.generate(
      _interfaceInfoGetNProperties(_baseInfo),
      (i) => new BaseInfo(_interfaceInfoGetProperty(_baseInfo, i)));
  Iterable<SignalInfo> get signals => new Iterable.generate(
      _interfaceInfoGetNSignals(_baseInfo),
      (i) => new BaseInfo(_interfaceInfoGetSignal(_baseInfo, i)));
  Iterable<ConstantInfo> get constants => new Iterable.generate(
      _interfaceInfoGetNConstants(_baseInfo),
      (i) => new BaseInfo(_interfaceInfoGetConstant(_baseInfo, i)));
  FunctionInfo findMethod(String name) => new BaseInfo(_interfaceInfoFindMethod(_baseInfo, name));
}

class ConstantInfo extends BaseInfo {
  ConstantInfo._fromNative(_BaseInfo baseInfo)  : super._fromNative(baseInfo);

  List get value => _constantInfoGetValue(_baseInfo);
}

class UnionInfo extends BaseInfo {
  UnionInfo._fromNative(_BaseInfo baseInfo)  : super._fromNative(baseInfo);
  Iterable<FunctionInfo> get methods => new Iterable.generate(
      _unionInfoGetNMethods(_baseInfo),
      (i) => new BaseInfo(_unionInfoGetMethod(_baseInfo, i)));
  Iterable<FieldInfo> get fields => new Iterable.generate(
      _unionInfoGetNFields(_baseInfo),
      (i) => new BaseInfo(_unionInfoGetField(_baseInfo, i)));
}

class ValueInfo extends BaseInfo {
  ValueInfo._fromNative(_BaseInfo baseInfo)  : super._fromNative(baseInfo);

  int get value => _valueInfoGetValue(_baseInfo);
}

class SignalInfo extends CallableInfo {
  SignalInfo._fromNative(_BaseInfo baseInfo)  : super._fromNative(baseInfo);

  bool get trueStopsEmit => _signalInfoTrueStopsEmit(_baseInfo);
}

class VFuncInfo extends CallableInfo {
  VFuncInfo._fromNative(_BaseInfo baseInfo)  : super._fromNative(baseInfo);
}

class PropertyInfo extends BaseInfo {
  PropertyInfo._fromNative(_BaseInfo baseInfo)  : super._fromNative(baseInfo);

  ParamFlags get flags => _propertyInfoGetFlags(_baseInfo);
  TypeInfo get propertyType => new BaseInfo(_propertyInfoGetType(_baseInfo));
}

class FieldInfo extends BaseInfo {
  FieldInfo._fromNative(_BaseInfo baseInfo)  : super._fromNative(baseInfo);
  FieldInfoFlags get flags => _fieldInfoGetFlags(_baseInfo);
  int get offset => _fieldInfoGetOffset(_baseInfo);
  TypeInfo get type => new BaseInfo(_fieldInfoGetType(_baseInfo));
}

class ArgInfo extends BaseInfo {
  ArgInfo._fromNative(_BaseInfo baseInfo)  : super._fromNative(baseInfo);

  Direction get direction => _argInfoGetDirection(_baseInfo);
  TypeInfo get argType => new BaseInfo(_argInfoGetType(_baseInfo));
  int get closure => _argInfoGetClosure(_baseInfo);
  int get destroy => _argInfoGetDestroy(_baseInfo);
}

class TypeInfo extends BaseInfo {
  TypeInfo._fromNative(_BaseInfo baseInfo)  : super._fromNative(baseInfo);

  TypeTag get tag => _typeInfoGetTag(_baseInfo);
  int get arrayLength => _typeInfoGetArrayLength(_baseInfo);
  BaseInfo get interface => new BaseInfo(_typeInfoGetInterface(_baseInfo));
  TypeInfo getParamType(int n) => new BaseInfo(_typeInfoGetParamType(_baseInfo, n));
}

class Typelib extends GObjectBase {
  Typelib.fromNative();
}

class Direction extends GEnumBase {
  const Direction(int value) : super(value);

  static const Direction IN = const Direction(0);
  static const Direction OUT = const Direction(1);
  static const Direction INOUT = const Direction(2);

  static const List<Direction> values = const <Direction>[IN, OUT, INOUT];

  String toString() {
    switch(index) {
      case 0: return 'Direction.IN';
      case 1: return 'Direction.OUT';
      case 2: return 'Direction.INOUT';
      default: return super.toString();
    }
  }
}

class InfoType extends GEnumBase {
  const InfoType(int value) : super(value);

  static const InfoType INVALID = const InfoType(0);
  static const InfoType FUNCTION = const InfoType(1);
  static const InfoType CALLBACK = const InfoType(2);
  static const InfoType STRUCT = const InfoType(3);
  static const InfoType BOXED = const InfoType(4);
  static const InfoType ENUM = const InfoType(5);
  static const InfoType FLAGS = const InfoType(6);
  static const InfoType OBJECT = const InfoType(7);
  static const InfoType INTERFACE = const InfoType(8);
  static const InfoType CONSTANT = const InfoType(9);
  static const InfoType UNION = const InfoType(11);
  static const InfoType VALUE = const InfoType(12);
  static const InfoType SIGNAL = const InfoType(13);
  static const InfoType VFUNC = const InfoType(14);
  static const InfoType PROPERTY = const InfoType(15);
  static const InfoType FIELD = const InfoType(16);
  static const InfoType ARG = const InfoType(17);
  static const InfoType TYPE = const InfoType(18);
}

class TypeTag extends GEnumBase {
  const TypeTag(int value) : super(value);

  static const TypeTag VOID = const TypeTag(0);
  static const TypeTag BOOLEAN = const TypeTag(1);
  static const TypeTag INT8 = const TypeTag(2);
  static const TypeTag UINT8 = const TypeTag(3);
  static const TypeTag INT16 = const TypeTag(4);
  static const TypeTag UINT16 = const TypeTag(5);
  static const TypeTag INT32 = const TypeTag(6);
  static const TypeTag UINT32 = const TypeTag(7);
  static const TypeTag INT64 = const TypeTag(8);
  static const TypeTag UINT64 = const TypeTag(9);
  static const TypeTag FLOAT = const TypeTag(10);
  static const TypeTag DOUBLE = const TypeTag(11);
  static const TypeTag GTYPE = const TypeTag(12);
  static const TypeTag UTF8 = const TypeTag(13);
  static const TypeTag FILENAME = const TypeTag(14);
  static const TypeTag ARRAY = const TypeTag(15);
  static const TypeTag INTERFACE = const TypeTag(16);
  static const TypeTag GLIST = const TypeTag(17);
  static const TypeTag GSLIST = const TypeTag(18);
  static const TypeTag GHASH = const TypeTag(19);
  static const TypeTag ERROR = const TypeTag(20);
  static const TypeTag UNICHAR = const TypeTag(21);
}

class ScopeType  extends GEnumBase {
  const ScopeType(int value) : super(value);

  static const ScopeType INVALID = const ScopeType(0);
  static const ScopeType CALL = const ScopeType(1);
  static const ScopeType ASYNC = const ScopeType(2);
  static const ScopeType NOTIFIED = const ScopeType(3);

  static const List<ScopeType> values = const <ScopeType>[INVALID, CALL, ASYNC, NOTIFIED];

  String toString() {
    switch(index) {
      case 0: return 'ScopeType.INVALID';
      case 1: return 'ScopeType.CALL';
      case 2: return 'ScopeType.ASYNC';
      case 3: return 'ScopeType.NOTIFIED';
      default: return super.toString();
    }
  }
}

class Transfer  extends GEnumBase {
  const Transfer(int value) : super(value);

  static const Transfer NOTHING = const Transfer(0);
  static const Transfer CONTAINER = const Transfer(1);
  static const Transfer EVERYTHING = const Transfer(2);

  static const List<Transfer> values = const <Transfer>[NOTHING, CONTAINER, EVERYTHING];

  String toString() {
    switch(index) {
      case 0: return 'Transfer.NOTHING';
      case 1: return 'Transfer.CONTAINER';
      case 2: return 'Transfer.EVERYTHING';
      default: return super.toString();
    }
  }
}

class RepositoryLoadFlags extends GEnumBase {
  const RepositoryLoadFlags(int value) : super(value);

  static const RepositoryLoadFlags NULL = const RepositoryLoadFlags(0);
  static const RepositoryLoadFlags LAZY = const RepositoryLoadFlags(1);

  static const List<RepositoryLoadFlags> values = const <RepositoryLoadFlags>[NULL, LAZY];

  String toString() {
    switch(index) {
      case 0: return 'RepositoryLoadFlags.NULL';
      case 1: return 'RepositoryLoadFlags.LAZY';
      default: return super.toString();
    }
  }
}

class FunctionInfoFlags extends GEnumBase {
  const FunctionInfoFlags(int value) : super(value);

  static const FunctionInfoFlags NULL = const FunctionInfoFlags(0);
  static const FunctionInfoFlags IS_METHOD = const FunctionInfoFlags(1);
  static const FunctionInfoFlags IS_CONSTRUCTOR = const FunctionInfoFlags(2);
  static const FunctionInfoFlags IS_GETTER = const FunctionInfoFlags(4);
  static const FunctionInfoFlags IS_SETTER = const FunctionInfoFlags(8);
  static const FunctionInfoFlags WRAPS_VFUNC = const FunctionInfoFlags(16);
  static const FunctionInfoFlags THROWS = const FunctionInfoFlags(32);

  bool get isMethod => index & 1 != 0;
  bool get isConstructor => index & 2 != 0;
  bool get isGetter => index & 4 != 0;
  bool get isSetter => index & 8 != 0;
  bool get wrapsVFunc => index & 16 != 0;
  bool get throws => index & 32 != 0;

  String toString() {
    if (index == 0) {
      return 'FunctionInfoFlags.NULL';
    }
    List codes = [];
    for (var i=1; i <= 32; i *= 2) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  static _valueToString(int value) {
    switch(value) {
      case 0: return 'FunctionInfoFlags.NULL';
      case 1: return 'FunctionInfoFlags.IS_METHOD';
      case 2: return 'FunctionInfoFlags.IS_CONSTRUCTOR';
      case 4: return 'FunctionInfoFlags.IS_GETTER';
      case 8: return 'FunctionInfoFlags.IS_SETTER';
      case 16: return 'FunctionInfoFlags.WRAPS_VFUNC';
      case 32: return 'FunctionInfoFlags.THROWS';
    }
  }
  FunctionInfoFlags operator|(FunctionInfoFlags other) =>
    new FunctionInfoFlags(index | other.index);
  FunctionInfoFlags operator&(FunctionInfoFlags other) =>
    new FunctionInfoFlags(index & other.index);

}

class ParamFlags extends GEnumBase {
  const ParamFlags(int value) : super(value);

  static const ParamFlags NULL = const ParamFlags(0);
  static const ParamFlags READABLE = const ParamFlags(1);
  static const ParamFlags WRITABLE = const ParamFlags(2);
  static const ParamFlags READWRITE = const ParamFlags(3);
  static const ParamFlags CONSTRUCT = const ParamFlags(4);
  static const ParamFlags CONSTRUCT_ONLY = const ParamFlags(8);
  static const ParamFlags LAX_VALIDATION = const ParamFlags(16);
  static const ParamFlags STATIC_NAME = const ParamFlags(32);
  static const ParamFlags PRIVATE = const ParamFlags(32);
  static const ParamFlags STATIC_NICK = const ParamFlags(64);
  static const ParamFlags STATIC_BLURB = const ParamFlags(128);
  static const ParamFlags EXPLICIT_NOTIFY = const ParamFlags(1073741824);

  bool get readable => index & 1 != 0;
  bool get writable=> index & 2 != 0;
  bool get construct => index & 4 != 0;
  bool get constructOnly => index & 8 != 0;
  bool get laxValidations => index & 16 != 0;
  bool get staticName => index & 32 != 0;
  bool get private => index & 32 != 0;
  bool get staticNick => index & 64 != 0;
  bool get staticBlurb => index & 128 != 0;
  bool get explicitNotify => index & 1073741824 != 0;

  String toString() {
    if (index == 0) {
      return 'ParamFlags.NULL';
    }
    List codes = [];
    for (var i=1; i <= 1073741824; i *= 2) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  static _valueToString(int value) {
    switch(value) {
      case 0: return 'ParamFlags.NULL';
      case 1: return 'ParamFlags.READABLE';
      case 2: return 'ParamFlags.WRITABLE';
      case 4: return 'ParamFlags.CONSTRUCT';
      case 8: return 'ParamFlags.CONSTRUCT_ONLY';
      case 16: return 'ParamFlags.LAX_VALIDATION';
      case 32: return 'ParamFlags.STATIC_NAME';
      case 64: return 'ParamFlags.STATIC_NICK';
      case 128: return 'ParamFlags.STATIC_BLURB';
      case 1073741824: return 'ParamFlags.EXPLICIT_NOTIFY';
      default: return 'new ParamFlags($value)';
    }
  }
  ParamFlags operator|(ParamFlags other) =>
      new ParamFlags(index | other.index);
  ParamFlags operator&(ParamFlags other) =>
      new ParamFlags(index & other.index);

}

class FieldInfoFlags extends GEnumBase {
  const FieldInfoFlags(int value) : super(value);

  static const FieldInfoFlags NULL = const FieldInfoFlags(0);
  static const FieldInfoFlags IS_READABLE = const FieldInfoFlags(1);
  static const FieldInfoFlags IS_WRITABLE = const FieldInfoFlags(2);

  bool get isReadable => index & 1 != 0;
  bool get isWritable => index & 2 != 0;
  String toString() {
    if (index == 0) {
      return 'FieldInfoFlags.NULL';
    }
    List codes = [];
    for (var i=1; i <= 2; i *= 2) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  static _valueToString(int value) {
    switch(value) {
      case 0: return 'FieldInfoFlags.NULL';
      case 1: return 'FieldInfoFlags.IS_READABLE';
      case 2: return 'FieldInfoFlags.IS_WRITABLE';
    }
  }
  FieldInfoFlags operator|(FieldInfoFlags other) =>
      new FieldInfoFlags(index | other.index);
  FieldInfoFlags operator&(FieldInfoFlags other) =>
      new FieldInfoFlags(index & other.index);

}

class Repository extends GObjectBase {
  Repository.fromNative();

  static final _info = new GIObjectInfo("GIRepository", "Repository");
  factory Repository.getDefault() => _info.callStatic('get_default', []);

  Typelib require(String namespace, [String version, RepositoryLoadFlags loadFlags = RepositoryLoadFlags.NULL]) =>
    callMethod('require', [namespace, version, loadFlags]);
  List<String> _getImmediateDependencies(String namespace) =>
    callMethod('get_immediate_dependencies', [namespace]);
  List<String> _getDependencies(String namespace) =>
      callMethod('get_dependencies', [namespace]);
  BaseInfo findByName(String namespace, String name) =>
      new BaseInfo(callMethod('find_by_name', [namespace, name]));

  int _getNInfos(String namespace) =>
    callMethod('get_n_infos', [namespace]);
  BaseInfo _getInfo(String namespace, int n) =>
    new BaseInfo(callMethod('get_info', [namespace, n]));
}

class Namespace {
  final Repository repository;
  final String name;
  final String version;

  List<String> get immediateDependencies => repository._getImmediateDependencies(name);
  List<String> get dependencies => repository._getDependencies(name);
  Iterable<BaseInfo> get infos => new Iterable.generate(repository._getNInfos(name), (n) => repository._getInfo(name, n));
  BaseInfo findByName(String name_) => repository.findByName(name, name_);

  Namespace(Repository this.repository, String this.name, [String this.version]) {
    repository.require(name, version);
  }

}

bool _objectInfoGetFundamental(_BaseInfo info) => callStaticGlobal(
    'GIRepository', 'object_info_get_fundamental', [info]);

_BaseInfo _objectInfoGetParent(_BaseInfo info) => callStaticGlobal(
    'GIRepository', 'object_info_get_parent', [info]);

int _objectInfoGetNInterfaces(_BaseInfo info) => callStaticGlobal(
    'GIRepository', 'object_info_get_n_interfaces', [info]);

_BaseInfo _objectInfoGetInterface(_BaseInfo info, int index) => callStaticGlobal(
    'GIRepository', 'object_info_get_interface', [info, index]);

int _objectInfoGetNMethods(_BaseInfo info) => callStaticGlobal(
    'GIRepository', 'object_info_get_n_methods', [info]);

_BaseInfo _objectInfoGetMethod(_BaseInfo info, int index) => callStaticGlobal(
    'GIRepository', 'object_info_get_method', [info, index]);

_BaseInfo _objectInfoFindMethod(_BaseInfo info, String name) => callStaticGlobal(
    'GIRepository', 'object_info_find_method', [info, name]);

_BaseInfo _interfaceInfoFindMethod(_BaseInfo info, String name) => callStaticGlobal(
    'GIRepository', 'interface_info_find_method', [info, name]);

int _objectInfoGetNProperties(_BaseInfo info) => callStaticGlobal(
    'GIRepository', 'object_info_get_n_properties', [info]);

_BaseInfo _objectInfoGetProperty(_BaseInfo info, int index) => callStaticGlobal(
    'GIRepository', 'object_info_get_property', [info, index]);

int _objectInfoGetNSignals(_BaseInfo info) => callStaticGlobal(
    'GIRepository', 'object_info_get_n_signals', [info]);

_BaseInfo _objectInfoGetSignal(_BaseInfo info, int index) => callStaticGlobal(
    'GIRepository', 'object_info_get_signal', [info, index]);


int _objectInfoGetNConstants(_BaseInfo info) => callStaticGlobal(
    'GIRepository', 'object_info_get_n_constants', [info]);

_BaseInfo _objectInfoGetConstant(_BaseInfo info, int index) => callStaticGlobal(
    'GIRepository', 'object_info_get_constant', [info, index]);

int _objectInfoGetNFields(_BaseInfo info) => callStaticGlobal(
    'GIRepository', 'object_info_get_n_fields', [info]);

_BaseInfo _objectInfoGetField(_BaseInfo info, int index) => callStaticGlobal(
    'GIRepository', 'object_info_get_field', [info, index]);

FunctionInfoFlags _functionInfoGetFlags(_BaseInfo info) => callStaticGlobal(
    'GIRepository', 'function_info_get_flags', [info]);

Direction _argInfoGetDirection(_BaseInfo info) => callStaticGlobal(
    'GIRepository', 'arg_info_get_direction', [info]);

int _callableInfoGetNArgs(_BaseInfo info) => callStaticGlobal(
    'GIRepository', 'callable_info_get_n_args', [info]);

_BaseInfo _callableInfoGetArg(_BaseInfo info, int index) => callStaticGlobal(
    'GIRepository', 'callable_info_get_arg', [info, index]);

_BaseInfo _argInfoGetType(_BaseInfo baseInfo) => callStaticGlobal(
    'GIRepository', 'arg_info_get_type', [baseInfo]);

TypeTag _typeInfoGetTag(_BaseInfo baseInfo) => callStaticGlobal(
    'GIRepository', 'type_info_get_tag', [baseInfo]);

int _typeInfoGetArrayLength(_BaseInfo baseInfo) => callStaticGlobal(
    'GIRepository', 'type_info_get_array_length', [baseInfo]);

_BaseInfo _typeInfoGetInterface(_BaseInfo baseInfo) => callStaticGlobal(
    'GIRepository', 'type_info_get_interface', [baseInfo]);

int _argInfoGetClosure(_BaseInfo baseInfo) => callStaticGlobal(
    'GIRepository', 'arg_info_get_closure', [baseInfo]);

int _argInfoGetDestroy(_BaseInfo baseInfo) => callStaticGlobal(
    'GIRepository', 'arg_info_get_destroy', [baseInfo]);

_BaseInfo _typeInfoGetParamType(_BaseInfo info, int n) => callStaticGlobal(
    'GIRepository', 'type_info_get_param_type', [info, n]);

_BaseInfo _callableInfoGetReturnType(_BaseInfo info) => callStaticGlobal(
    'GIRepository', 'callable_info_get_return_type', [info]);

bool _callableInfoCanThrowGerror(_BaseInfo info) => callStaticGlobal(
    'GIRepository', 'callable_info_can_throw_gerror', [info]);

ParamFlags _propertyInfoGetFlags(_BaseInfo info) => callStaticGlobal(
    'GIRepository', 'property_info_get_flags', [info]);

_BaseInfo _propertyInfoGetType(_BaseInfo info) => callStaticGlobal(
    'GIRepository', 'property_info_get_type', [info]);

bool _signalInfoTrueStopsEmit(_BaseInfo info) => callStaticGlobal(
    'GIRepository', 'signal_info_true_stops_emit', [info]);

int _interfaceInfoGetNPrerequisites(_BaseInfo info) => callStaticGlobal(
    'GIRepository', 'interface_info_get_n_prerequisites', [info]);

_BaseInfo _interfaceInfoGetPrerequisite(_BaseInfo info, int index) => callStaticGlobal(
    'GIRepository', 'interface_info_get_prerequisite', [info, index]);

int _interfaceInfoGetNMethods(_BaseInfo info) => callStaticGlobal(
    'GIRepository', 'interface_info_get_n_methods', [info]);

_BaseInfo _interfaceInfoGetMethod(_BaseInfo info, int index) => callStaticGlobal(
    'GIRepository', 'interface_info_get_method', [info, index]);

int _interfaceInfoGetNProperties(_BaseInfo info) => callStaticGlobal(
    'GIRepository', 'interface_info_get_n_properties', [info]);

_BaseInfo _interfaceInfoGetProperty(_BaseInfo info, int index) => callStaticGlobal(
    'GIRepository', 'interface_info_get_property', [info, index]);

int _interfaceInfoGetNSignals(_BaseInfo info) => callStaticGlobal(
    'GIRepository', 'interface_info_get_n_signals', [info]);

_BaseInfo _interfaceInfoGetSignal(_BaseInfo info, int index) => callStaticGlobal(
    'GIRepository', 'interface_info_get_signal', [info, index]);


int _interfaceInfoGetNConstants(_BaseInfo info) => callStaticGlobal(
    'GIRepository', 'interface_info_get_n_constants', [info]);

_BaseInfo _interfaceInfoGetConstant(_BaseInfo info, int index) => callStaticGlobal(
    'GIRepository', 'interface_info_get_constant', [info, index]);


int _structInfoGetNMethods(_BaseInfo info) => callStaticGlobal(
    'GIRepository', 'struct_info_get_n_methods', [info]);

_BaseInfo _structInfoGetMethod(_BaseInfo info, int index) => callStaticGlobal(
    'GIRepository', 'struct_info_get_method', [info, index]);

int _structInfoGetNFields(_BaseInfo info) => callStaticGlobal(
    'GIRepository', 'struct_info_get_n_fields', [info]);

_BaseInfo _structInfoGetField(_BaseInfo info, int index) => callStaticGlobal(
    'GIRepository', 'struct_info_get_field', [info, index]);

bool _structInfoIsGtypeStruct(_BaseInfo info) =>
    callStaticGlobal('GIRepository', 'struct_info_is_gtype_struct', [info]);

int _unionInfoGetNMethods(_BaseInfo info) => callStaticGlobal(
    'GIRepository', 'union_info_get_n_methods', [info]);

_BaseInfo _unionInfoGetMethod(_BaseInfo info, int index) => callStaticGlobal(
    'GIRepository', 'union_info_get_method', [info, index]);

int _unionInfoGetNFields(_BaseInfo info) => callStaticGlobal(
    'GIRepository', 'union_info_get_n_fields', [info]);

_BaseInfo _unionInfoGetField(_BaseInfo info, int index) => callStaticGlobal(
    'GIRepository', 'union_info_get_field', [info, index]);

FieldInfoFlags _fieldInfoGetFlags(_BaseInfo info) =>
    callStaticGlobal('GIRepository', 'field_info_get_flags', [info]);

int _fieldInfoGetOffset(_BaseInfo info) =>
    callStaticGlobal('GIRepository', 'field_info_get_offset', [info]);

_BaseInfo _fieldInfoGetType(_BaseInfo info) =>
    callStaticGlobal('GIRepository', 'field_info_get_type', [info]);

int _enumInfoGetNValues(_BaseInfo info) => callStaticGlobal(
    'GIRepository', 'enum_info_get_n_values', [info]);

_BaseInfo _enumInfoGetValue(_BaseInfo info, int index) => callStaticGlobal(
    'GIRepository', 'enum_info_get_value', [info, index]);

String _enumInfoGetErrorDomain(_BaseInfo info) => callStaticGlobal(
    'GIRepository', 'enum_info_get_error_domain', [info]);

int _enumInfoGetNMethods(_BaseInfo info) => callStaticGlobal(
    'GIRepository', 'enum_info_get_n_methods', [info]);

TypeTag _enumInfoGetStorageType(_BaseInfo info) => callStaticGlobal(
    'GIRepository', 'enum_info_get_storage_type', [info]);


_BaseInfo _enumInfoGetMethod(_BaseInfo info, int index) => callStaticGlobal(
    'GIRepository', 'enum_info_get_method', [info, index]);

int _valueInfoGetValue(_BaseInfo info) => callStaticGlobal(
    'GIRepository', 'value_info_get_value', [info]);

List _constantInfoGetValue(_BaseInfo info) => callStaticGlobal(
    'GIRepository', 'constant_info_get_value', [info]);
