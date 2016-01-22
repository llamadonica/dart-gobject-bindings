library gobject.gdart;

import "gdart.dart";

import "dart:async";

import "glib.dart" hide initLibrary;
import "glib.dart" as glib;

typedef void BaseFinalizeFunc();
typedef void BaseInitFunc();
class Binding extends GObjectObject {
  Binding.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'Binding');

  void set flags(BindingFlags value) => setGProperty('flags', value);
  static const String FLAGS_PROPERTY = 'flags';
  void set source(GObjectObject value) => setGProperty('source', value);
  static const String SOURCE_PROPERTY = 'source';
  void set sourceProperty(String value) => setGProperty('source-property', value);
  static const String SOURCE_PROPERTY_PROPERTY = 'source-property';
  void set target(GObjectObject value) => setGProperty('target', value);
  static const String TARGET_PROPERTY = 'target';
  void set targetProperty(String value) => setGProperty('target-property', value);
  static const String TARGET_PROPERTY_PROPERTY = 'target-property';
  BindingFlags get flags_ => _staticInfo.callMethodOnReceiver('get_flags', this, []);
  GObjectObject get source_ => _staticInfo.callMethodOnReceiver('get_source', this, []);
  String get sourceProperty_ => _staticInfo.callMethodOnReceiver('get_source_property', this, []);
  GObjectObject get target_ => _staticInfo.callMethodOnReceiver('get_target', this, []);
  String get targetProperty_ => _staticInfo.callMethodOnReceiver('get_target_property', this, []);
  void unbind() => _staticInfo.callMethodOnReceiver('unbind', this, []);
}

class BindingFlags extends GEnumBase {
  const BindingFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'BindingFlags');

  static const BindingFlags DEFAULT = const BindingFlags(0);
  bool get default_ => (value & 0) == 0;
  static const BindingFlags BIDIRECTIONAL = const BindingFlags(1);
  bool get bidirectional => (value & 1) == 1;
  static const BindingFlags SYNC_CREATE = const BindingFlags(2);
  bool get syncCreate => (value & 2) == 2;
  static const BindingFlags INVERT_BOOLEAN = const BindingFlags(4);
  bool get invertBoolean => (value & 4) == 4;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'BindingFlags.BIDIRECTIONAL';
      case 2: return 'BindingFlags.SYNC_CREATE';
      case 4: return 'BindingFlags.INVERT_BOOLEAN';
      default: return 'new BindingFlags($value)';
    }
  }
  String toString() {
    if (value == 0) {
      return 'BindingFlags.DEFAULT';
    }
    List codes = [];
    for (var i=1; i <= 4; i <<= 1) {
      if (value & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  BindingFlags operator|(BindingFlags other) =>
    new BindingFlags(value | other.value);
  BindingFlags operator&(BindingFlags other) =>
    new BindingFlags(value & other.value);
}

typedef bool BindingTransformFunc(Binding binding, Value fromValue, Value toValue);
typedef void BoxedFreeFunc();
class CClosure extends GObjectBase {
  CClosure.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'CClosure');

  static void marshal_BOOLEAN__BOXED_BOXED(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => _staticInfo.callStatic('marshal_BOOLEAN__BOXED_BOXED', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);
  static void marshal_BOOLEAN__FLAGS(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => _staticInfo.callStatic('marshal_BOOLEAN__FLAGS', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);
  static void marshal_STRING__OBJECT_POINTER(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => _staticInfo.callStatic('marshal_STRING__OBJECT_POINTER', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);
  static void marshal_VOID__BOOLEAN(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => _staticInfo.callStatic('marshal_VOID__BOOLEAN', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);
  static void marshal_VOID__BOXED(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => _staticInfo.callStatic('marshal_VOID__BOXED', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);
  static void marshal_VOID__CHAR(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => _staticInfo.callStatic('marshal_VOID__CHAR', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);
  static void marshal_VOID__DOUBLE(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => _staticInfo.callStatic('marshal_VOID__DOUBLE', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);
  static void marshal_VOID__ENUM(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => _staticInfo.callStatic('marshal_VOID__ENUM', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);
  static void marshal_VOID__FLAGS(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => _staticInfo.callStatic('marshal_VOID__FLAGS', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);
  static void marshal_VOID__FLOAT(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => _staticInfo.callStatic('marshal_VOID__FLOAT', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);
  static void marshal_VOID__INT(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => _staticInfo.callStatic('marshal_VOID__INT', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);
  static void marshal_VOID__LONG(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => _staticInfo.callStatic('marshal_VOID__LONG', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);
  static void marshal_VOID__OBJECT(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => _staticInfo.callStatic('marshal_VOID__OBJECT', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);
  static void marshal_VOID__PARAM(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => _staticInfo.callStatic('marshal_VOID__PARAM', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);
  static void marshal_VOID__POINTER(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => _staticInfo.callStatic('marshal_VOID__POINTER', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);
  static void marshal_VOID__STRING(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => _staticInfo.callStatic('marshal_VOID__STRING', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);
  static void marshal_VOID__UCHAR(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => _staticInfo.callStatic('marshal_VOID__UCHAR', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);
  static void marshal_VOID__UINT(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => _staticInfo.callStatic('marshal_VOID__UINT', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);
  static void marshal_VOID__UINT_POINTER(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => _staticInfo.callStatic('marshal_VOID__UINT_POINTER', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);
  static void marshal_VOID__ULONG(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => _staticInfo.callStatic('marshal_VOID__ULONG', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);
  static void marshal_VOID__VARIANT(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => _staticInfo.callStatic('marshal_VOID__VARIANT', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);
  static void marshal_VOID__VOID(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => _staticInfo.callStatic('marshal_VOID__VOID', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);
  static void marshalGeneric(Closure closure, Value returnGvalue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => _staticInfo.callStatic('marshal_generic', [closure, returnGvalue, nParamValues, paramValues, invocationHint, marshalData]);
  Closure get closure => getFieldOfObject('closure', 0);
  void set closure(Closure value) => setFieldOfObject('closure', 0, value);
  dynamic /* this will fail */ get callback => getFieldOfObject('callback', 1);
  void set callback(dynamic value /* this will fail */) => setFieldOfObject('callback', 1, value);
}

typedef void Callback();
typedef void ClassFinalizeFunc(dynamic gClass /* this will fail */);
typedef void ClassInitFunc(dynamic gClass /* this will fail */);
class Closure extends GObjectBase {
  Closure.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'Closure');

  factory Closure.object(int sizeofClosure, GObjectObject object) => _staticInfo.callStatic('new_object', [sizeofClosure, object]);
  factory Closure.simple(int sizeofClosure, dynamic data /* this will fail */) => _staticInfo.callStatic('new_simple', [sizeofClosure, data]);
  void invalidate() => _staticInfo.callMethodOnReceiver('invalidate', this, []);
  void invoke(Value returnValue, List<Value> paramValues, dynamic invocationHint /* this will fail */) => _staticInfo.callMethodOnReceiver('invoke', this, [returnValue, paramValues, invocationHint]);
  Closure ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  void sink() => _staticInfo.callMethodOnReceiver('sink', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
  int get refCount => getFieldOfObject('ref_count', 0);
  int get metaMarshalNouse => getFieldOfObject('meta_marshal_nouse', 1);
  int get nGuards => getFieldOfObject('n_guards', 2);
  int get nFnotifiers => getFieldOfObject('n_fnotifiers', 3);
  int get nInotifiers => getFieldOfObject('n_inotifiers', 4);
  int get inInotify => getFieldOfObject('in_inotify', 5);
  int get floating => getFieldOfObject('floating', 6);
  int get derivativeFlag => getFieldOfObject('derivative_flag', 7);
  int get inMarshal => getFieldOfObject('in_marshal', 8);
  void set inMarshal(int value) => setFieldOfObject('in_marshal', 8, value);
  int get isInvalid => getFieldOfObject('is_invalid', 9);
  void set isInvalid(int value) => setFieldOfObject('is_invalid', 9, value);
  dynamic /* this will fail */ get data => getFieldOfObject('data', 11);
  ClosureNotifyData get notifiers => getFieldOfObject('notifiers', 12);
}

typedef void ClosureMarshal(Closure closure, Value returnValue, List<Value> paramValues, dynamic invocationHint /* this will fail */);
typedef void ClosureNotify(dynamic data /* this will fail */, Closure closure);
class ClosureNotifyData extends GObjectBase {
  ClosureNotifyData.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'ClosureNotifyData');

  dynamic /* this will fail */ get data => getFieldOfObject('data', 0);
  void set data(dynamic value /* this will fail */) => setFieldOfObject('data', 0, value);
  ClosureNotify get notify => getFieldOfObject('notify', 1);
  void set notify(ClosureNotify value) => setFieldOfObject('notify', 1, value);
}

class ConnectFlags extends GEnumBase {
  const ConnectFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'ConnectFlags');

  static const ConnectFlags NULL = const ConnectFlags(0);
  static const ConnectFlags AFTER = const ConnectFlags(1);
  bool get after => (value & 1) == 1;
  static const ConnectFlags SWAPPED = const ConnectFlags(2);
  bool get swapped => (value & 2) == 2;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'ConnectFlags.AFTER';
      case 2: return 'ConnectFlags.SWAPPED';
      default: return 'new ConnectFlags($value)';
    }
  }
  String toString() {
    if (value == 0) {
      return 'ConnectFlags.NULL';
    }
    List codes = [];
    for (var i=1; i <= 2; i <<= 1) {
      if (value & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  ConnectFlags operator|(ConnectFlags other) =>
    new ConnectFlags(value | other.value);
  ConnectFlags operator&(ConnectFlags other) =>
    new ConnectFlags(value & other.value);
}

class EnumClass extends GObjectBase {
  EnumClass.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'EnumClass');

  TypeClass get gTypeClass => getFieldOfObject('g_type_class', 0);
  void set gTypeClass(TypeClass value) => setFieldOfObject('g_type_class', 0, value);
  int get minimum => getFieldOfObject('minimum', 1);
  void set minimum(int value) => setFieldOfObject('minimum', 1, value);
  int get maximum => getFieldOfObject('maximum', 2);
  void set maximum(int value) => setFieldOfObject('maximum', 2, value);
  int get nValues => getFieldOfObject('n_values', 3);
  void set nValues(int value) => setFieldOfObject('n_values', 3, value);
  EnumValue get values => getFieldOfObject('values', 4);
  void set values(EnumValue value) => setFieldOfObject('values', 4, value);
}

class EnumValue extends GObjectBase {
  EnumValue.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'EnumValue');

  int get value => getFieldOfObject('value', 0);
  void set value(int value) => setFieldOfObject('value', 0, value);
  String get valueName => getFieldOfObject('value_name', 1);
  void set valueName(String value) => setFieldOfObject('value_name', 1, value);
  String get valueNick => getFieldOfObject('value_nick', 2);
  void set valueNick(String value) => setFieldOfObject('value_nick', 2, value);
}

class FlagsClass extends GObjectBase {
  FlagsClass.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'FlagsClass');

  TypeClass get gTypeClass => getFieldOfObject('g_type_class', 0);
  void set gTypeClass(TypeClass value) => setFieldOfObject('g_type_class', 0, value);
  int get mask => getFieldOfObject('mask', 1);
  void set mask(int value) => setFieldOfObject('mask', 1, value);
  int get nValues => getFieldOfObject('n_values', 2);
  void set nValues(int value) => setFieldOfObject('n_values', 2, value);
  FlagsValue get values => getFieldOfObject('values', 3);
  void set values(FlagsValue value) => setFieldOfObject('values', 3, value);
}

class FlagsValue extends GObjectBase {
  FlagsValue.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'FlagsValue');

  int get value => getFieldOfObject('value', 0);
  void set value(int value) => setFieldOfObject('value', 0, value);
  String get valueName => getFieldOfObject('value_name', 1);
  void set valueName(String value) => setFieldOfObject('value_name', 1, value);
  String get valueNick => getFieldOfObject('value_nick', 2);
  void set valueNick(String value) => setFieldOfObject('value_nick', 2, value);
}

class InitiallyUnowned extends GObjectObject {
  InitiallyUnowned.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'InitiallyUnowned');

  int get refCount => getFieldOfObject('ref_count', 1);
  Data get qdata => getFieldOfObject('qdata', 2);
}

typedef void InstanceInitFunc(TypeInstance instance);
typedef void InterfaceFinalizeFunc(dynamic gIface /* this will fail */);
class InterfaceInfo extends GObjectBase {
  InterfaceInfo.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'InterfaceInfo');

  InterfaceInitFunc get interfaceInit => getFieldOfObject('interface_init', 0);
  void set interfaceInit(InterfaceInitFunc value) => setFieldOfObject('interface_init', 0, value);
  InterfaceFinalizeFunc get interfaceFinalize => getFieldOfObject('interface_finalize', 1);
  void set interfaceFinalize(InterfaceFinalizeFunc value) => setFieldOfObject('interface_finalize', 1, value);
  dynamic /* this will fail */ get interfaceData => getFieldOfObject('interface_data', 2);
  void set interfaceData(dynamic value /* this will fail */) => setFieldOfObject('interface_data', 2, value);
}

typedef void InterfaceInitFunc(dynamic gIface /* this will fail */);
class GObjectObject extends GObjectBase {
  GObjectObject.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'Object');

  factory GObjectObject(int objectType, List<Parameter> parameters) => _staticInfo.callStatic('new', [objectType, parameters]);
  static int compatControl(int what, dynamic data /* this will fail */) => _staticInfo.callStatic('compat_control', [what, data]);
  static ParamSpec interfaceFindProperty(dynamic gIface /* this will fail */, String propertyName) => _staticInfo.callStatic('interface_find_property', [gIface, propertyName]);
  static void interfaceInstallProperty(dynamic gIface /* this will fail */, ParamSpec pspec) => _staticInfo.callStatic('interface_install_property', [gIface, pspec]);
  static List interfaceListProperties(dynamic gIface /* this will fail */) => _staticInfo.callStatic('interface_list_properties', [gIface]);
  Binding bindProperty(String sourceProperty, GObjectObject target, String targetProperty, BindingFlags flags) => _staticInfo.callMethodOnReceiver('bind_property', this, [sourceProperty, target, targetProperty, flags]);
  Binding bindPropertyFull(String sourceProperty, GObjectObject target, String targetProperty, BindingFlags flags, Closure transformTo, Closure transformFrom) => _staticInfo.callMethodOnReceiver('bind_property_full', this, [sourceProperty, target, targetProperty, flags, transformTo, transformFrom]);
  void forceFloating() => _staticInfo.callMethodOnReceiver('force_floating', this, []);
  void freezeNotify() => _staticInfo.callMethodOnReceiver('freeze_notify', this, []);
  void getData(String key) => _staticInfo.callMethodOnReceiver('get_data', this, [key]);
  void getProperty(String propertyName, Value value) => _staticInfo.callMethodOnReceiver('get_property', this, [propertyName, value]);
  void getQdata(int quark) => _staticInfo.callMethodOnReceiver('get_qdata', this, [quark]);
  bool isFloating() => _staticInfo.callMethodOnReceiver('is_floating', this, []);
  void notify(String propertyName) => _staticInfo.callMethodOnReceiver('notify', this, [propertyName]);
  void notifyByPspec(ParamSpec pspec) => _staticInfo.callMethodOnReceiver('notify_by_pspec', this, [pspec]);
  GObjectObject ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  GObjectObject refSink() => _staticInfo.callMethodOnReceiver('ref_sink', this, []);
  bool replaceData(String key, dynamic oldval /* this will fail */, dynamic newval /* this will fail */, DestroyNotify destroy, DestroyNotify oldDestroy) => _staticInfo.callMethodOnReceiver('replace_data', this, [key, oldval, newval, destroy, oldDestroy]);
  bool replaceQdata(int quark, dynamic oldval /* this will fail */, dynamic newval /* this will fail */, DestroyNotify destroy, DestroyNotify oldDestroy) => _staticInfo.callMethodOnReceiver('replace_qdata', this, [quark, oldval, newval, destroy, oldDestroy]);
  void runDispose() => _staticInfo.callMethodOnReceiver('run_dispose', this, []);
  void setData(String key, dynamic data /* this will fail */) => _staticInfo.callMethodOnReceiver('set_data', this, [key, data]);
  void setProperty(String propertyName, Value value) => _staticInfo.callMethodOnReceiver('set_property', this, [propertyName, value]);
  void stealData(String key) => _staticInfo.callMethodOnReceiver('steal_data', this, [key]);
  void stealQdata(int quark) => _staticInfo.callMethodOnReceiver('steal_qdata', this, [quark]);
  void thawNotify() => _staticInfo.callMethodOnReceiver('thaw_notify', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
  void watchClosure(Closure closure) => _staticInfo.callMethodOnReceiver('watch_closure', this, [closure]);
  TypeInstance get gTypeInstance => getFieldOfObject('g_type_instance', 0);
  int get refCount => getFieldOfObject('ref_count', 1);
  Data get qdata => getFieldOfObject('qdata', 2);
  int _connectToNotify(bool after, void func(ParamSpec pspec)) => signalConnect('notify', func, after);
  Stream<ParamSpec> get onNotify {
    int signalId;
    StreamController<ParamSpec> controller;
    controller = new StreamController<ParamSpec>(
      onListen: () {
          signalId = _connectToNotify(false, (ParamSpec pspec) {
              controller.add(pspec);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<ParamSpec> get afterNotify {
    int signalId;
    StreamController<ParamSpec> controller;
    controller = new StreamController<ParamSpec>(
      onListen: () {
          signalId = _connectToNotify(true, (ParamSpec pspec) {
              controller.add(pspec);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
}

class ObjectConstructParam extends GObjectBase {
  ObjectConstructParam.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'ObjectConstructParam');

  ParamSpec get pspec => getFieldOfObject('pspec', 0);
  void set pspec(ParamSpec value) => setFieldOfObject('pspec', 0, value);
  Value get value => getFieldOfObject('value', 1);
  void set value(Value value) => setFieldOfObject('value', 1, value);
}

typedef void ObjectFinalizeFunc(GObjectObject object);
typedef void ObjectGetPropertyFunc(GObjectObject object, int propertyId, Value value, ParamSpec pspec);
typedef void ObjectSetPropertyFunc(GObjectObject object, int propertyId, Value value, ParamSpec pspec);
class ParamFlags extends GEnumBase {
  const ParamFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'ParamFlags');

  static const ParamFlags NULL = const ParamFlags(0);
  static const ParamFlags READABLE = const ParamFlags(1);
  bool get readable => (value & 1) == 1;
  static const ParamFlags WRITABLE = const ParamFlags(2);
  bool get writable => (value & 2) == 2;
  static const ParamFlags READWRITE = const ParamFlags(3);
  bool get readwrite => (value & 3) == 3;
  static const ParamFlags CONSTRUCT = const ParamFlags(4);
  bool get construct => (value & 4) == 4;
  static const ParamFlags CONSTRUCT_ONLY = const ParamFlags(8);
  bool get constructOnly => (value & 8) == 8;
  static const ParamFlags LAX_VALIDATION = const ParamFlags(16);
  bool get laxValidation => (value & 16) == 16;
  static const ParamFlags STATIC_NAME = const ParamFlags(32);
  bool get staticName => (value & 32) == 32;
  static const ParamFlags PRIVATE = const ParamFlags(32);
  bool get private => (value & 32) == 32;
  static const ParamFlags STATIC_NICK = const ParamFlags(64);
  bool get staticNick => (value & 64) == 64;
  static const ParamFlags STATIC_BLURB = const ParamFlags(128);
  bool get staticBlurb => (value & 128) == 128;
  static const ParamFlags EXPLICIT_NOTIFY = const ParamFlags(1073741824);
  bool get explicitNotify => (value & 1073741824) == 1073741824;
  static const ParamFlags DEPRECATED = const ParamFlags(2147483648);
  bool get deprecated => (value & 2147483648) == 2147483648;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'ParamFlags.READABLE';
      case 2: return 'ParamFlags.WRITABLE';
      case 4: return 'ParamFlags.CONSTRUCT';
      case 8: return 'ParamFlags.CONSTRUCT_ONLY';
      case 16: return 'ParamFlags.LAX_VALIDATION';
      case 32: return 'ParamFlags.STATIC_NAME';
      case 64: return 'ParamFlags.STATIC_NICK';
      case 128: return 'ParamFlags.STATIC_BLURB';
      default: return 'new ParamFlags($value)';
    }
  }
  String toString() {
    if (value == 0) {
      return 'ParamFlags.NULL';
    }
    List codes = [];
    for (var i=1; i <= 2147483648; i <<= 1) {
      if (value & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  ParamFlags operator|(ParamFlags other) =>
    new ParamFlags(value | other.value);
  ParamFlags operator&(ParamFlags other) =>
    new ParamFlags(value & other.value);
}

class ParamSpec extends GObjectBase {
  ParamSpec.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'ParamSpec');

  String get blurb => _staticInfo.callMethodOnReceiver('get_blurb', this, []);
  Value get defaultValue => _staticInfo.callMethodOnReceiver('get_default_value', this, []);
  String get name => _staticInfo.callMethodOnReceiver('get_name', this, []);
  int get nameQuark => _staticInfo.callMethodOnReceiver('get_name_quark', this, []);
  String get nick => _staticInfo.callMethodOnReceiver('get_nick', this, []);
  void getQdata(int quark) => _staticInfo.callMethodOnReceiver('get_qdata', this, [quark]);
  ParamSpec get redirectTarget => _staticInfo.callMethodOnReceiver('get_redirect_target', this, []);
  void setQdata(int quark, dynamic data /* this will fail */) => _staticInfo.callMethodOnReceiver('set_qdata', this, [quark, data]);
  void sink() => _staticInfo.callMethodOnReceiver('sink', this, []);
  void stealQdata(int quark) => _staticInfo.callMethodOnReceiver('steal_qdata', this, [quark]);
  TypeInstance get gTypeInstance => getFieldOfObject('g_type_instance', 0);
  ParamFlags get flags => getFieldOfObject('flags', 2);
  int get valueType => getFieldOfObject('value_type', 3);
  int get ownerType => getFieldOfObject('owner_type', 4);
  String get Nick => getFieldOfObject('_nick', 5);
  String get Blurb => getFieldOfObject('_blurb', 6);
  Data get qdata => getFieldOfObject('qdata', 7);
  int get refCount => getFieldOfObject('ref_count', 8);
  int get paramId => getFieldOfObject('param_id', 9);
}

class ParamSpecBoolean extends GObjectBase {
  ParamSpecBoolean.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'ParamSpecBoolean');

  ParamSpec get parentInstance => getFieldOfObject('parent_instance', 0);
  bool get defaultValue => getFieldOfObject('default_value', 1);
}

class ParamSpecBoxed extends GObjectBase {
  ParamSpecBoxed.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'ParamSpecBoxed');

}

class ParamSpecChar extends GObjectBase {
  ParamSpecChar.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'ParamSpecChar');

  ParamSpec get parentInstance => getFieldOfObject('parent_instance', 0);
  int get minimum => getFieldOfObject('minimum', 1);
  int get maximum => getFieldOfObject('maximum', 2);
  int get defaultValue => getFieldOfObject('default_value', 3);
}

class ParamSpecDouble extends GObjectBase {
  ParamSpecDouble.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'ParamSpecDouble');

  ParamSpec get parentInstance => getFieldOfObject('parent_instance', 0);
  num get minimum => getFieldOfObject('minimum', 1);
  num get maximum => getFieldOfObject('maximum', 2);
  num get defaultValue => getFieldOfObject('default_value', 3);
  num get epsilon => getFieldOfObject('epsilon', 4);
}

class ParamSpecEnum extends GObjectBase {
  ParamSpecEnum.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'ParamSpecEnum');

  ParamSpec get parentInstance => getFieldOfObject('parent_instance', 0);
  EnumClass get enumClass => getFieldOfObject('enum_class', 1);
  int get defaultValue => getFieldOfObject('default_value', 2);
}

class ParamSpecFlags extends GObjectBase {
  ParamSpecFlags.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'ParamSpecFlags');

  ParamSpec get parentInstance => getFieldOfObject('parent_instance', 0);
  FlagsClass get flagsClass => getFieldOfObject('flags_class', 1);
  int get defaultValue => getFieldOfObject('default_value', 2);
}

class ParamSpecFloat extends GObjectBase {
  ParamSpecFloat.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'ParamSpecFloat');

  ParamSpec get parentInstance => getFieldOfObject('parent_instance', 0);
  num get minimum => getFieldOfObject('minimum', 1);
  num get maximum => getFieldOfObject('maximum', 2);
  num get defaultValue => getFieldOfObject('default_value', 3);
  num get epsilon => getFieldOfObject('epsilon', 4);
}

class ParamSpecGType extends GObjectBase {
  ParamSpecGType.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'ParamSpecGType');

  ParamSpec get parentInstance => getFieldOfObject('parent_instance', 0);
  int get isAType => getFieldOfObject('is_a_type', 1);
}

class ParamSpecInt extends GObjectBase {
  ParamSpecInt.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'ParamSpecInt');

  ParamSpec get parentInstance => getFieldOfObject('parent_instance', 0);
  int get minimum => getFieldOfObject('minimum', 1);
  int get maximum => getFieldOfObject('maximum', 2);
  int get defaultValue => getFieldOfObject('default_value', 3);
}

class ParamSpecInt64 extends GObjectBase {
  ParamSpecInt64.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'ParamSpecInt64');

  ParamSpec get parentInstance => getFieldOfObject('parent_instance', 0);
  int get minimum => getFieldOfObject('minimum', 1);
  int get maximum => getFieldOfObject('maximum', 2);
  int get defaultValue => getFieldOfObject('default_value', 3);
}

class ParamSpecLong extends GObjectBase {
  ParamSpecLong.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'ParamSpecLong');

  ParamSpec get parentInstance => getFieldOfObject('parent_instance', 0);
  int get minimum => getFieldOfObject('minimum', 1);
  int get maximum => getFieldOfObject('maximum', 2);
  int get defaultValue => getFieldOfObject('default_value', 3);
}

class ParamSpecObject extends GObjectBase {
  ParamSpecObject.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'ParamSpecObject');

}

class ParamSpecOverride extends GObjectBase {
  ParamSpecOverride.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'ParamSpecOverride');

  ParamSpec get parentInstance => getFieldOfObject('parent_instance', 0);
  ParamSpec get overridden => getFieldOfObject('overridden', 1);
}

class ParamSpecParam extends GObjectBase {
  ParamSpecParam.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'ParamSpecParam');

}

class ParamSpecPointer extends GObjectBase {
  ParamSpecPointer.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'ParamSpecPointer');

}

class ParamSpecPool extends GObjectBase {
  ParamSpecPool.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'ParamSpecPool');

  void insert(ParamSpec pspec, int ownerType) => _staticInfo.callMethodOnReceiver('insert', this, [pspec, ownerType]);
  List list(int ownerType) => _staticInfo.callMethodOnReceiver('list', this, [ownerType]);
  GLibList /* this will fail */ listOwned(int ownerType) => _staticInfo.callMethodOnReceiver('list_owned', this, [ownerType]);
  ParamSpec lookup(String paramName, int ownerType, bool walkAncestors) => _staticInfo.callMethodOnReceiver('lookup', this, [paramName, ownerType, walkAncestors]);
  void remove(ParamSpec pspec) => _staticInfo.callMethodOnReceiver('remove', this, [pspec]);
  static ParamSpecPool new_(bool typePrefixing) => _staticInfo.callStatic('new', [typePrefixing]);
}

class ParamSpecString extends GObjectBase {
  ParamSpecString.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'ParamSpecString');

  ParamSpec get parentInstance => getFieldOfObject('parent_instance', 0);
  String get defaultValue => getFieldOfObject('default_value', 1);
  String get csetFirst => getFieldOfObject('cset_first', 2);
  String get csetNth => getFieldOfObject('cset_nth', 3);
  int get substitutor => getFieldOfObject('substitutor', 4);
  int get nullFoldIfEmpty => getFieldOfObject('null_fold_if_empty', 5);
  int get ensureNonNull => getFieldOfObject('ensure_non_null', 6);
}

class ParamSpecTypeInfo extends GObjectBase {
  ParamSpecTypeInfo.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'ParamSpecTypeInfo');

  int get instanceSize => getFieldOfObject('instance_size', 0);
  void set instanceSize(int value) => setFieldOfObject('instance_size', 0, value);
  int get nPreallocs => getFieldOfObject('n_preallocs', 1);
  void set nPreallocs(int value) => setFieldOfObject('n_preallocs', 1, value);
  int get valueType => getFieldOfObject('value_type', 3);
  void set valueType(int value) => setFieldOfObject('value_type', 3, value);
}

class ParamSpecUChar extends GObjectBase {
  ParamSpecUChar.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'ParamSpecUChar');

  ParamSpec get parentInstance => getFieldOfObject('parent_instance', 0);
  int get minimum => getFieldOfObject('minimum', 1);
  int get maximum => getFieldOfObject('maximum', 2);
  int get defaultValue => getFieldOfObject('default_value', 3);
}

class ParamSpecUInt extends GObjectBase {
  ParamSpecUInt.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'ParamSpecUInt');

  ParamSpec get parentInstance => getFieldOfObject('parent_instance', 0);
  int get minimum => getFieldOfObject('minimum', 1);
  int get maximum => getFieldOfObject('maximum', 2);
  int get defaultValue => getFieldOfObject('default_value', 3);
}

class ParamSpecUInt64 extends GObjectBase {
  ParamSpecUInt64.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'ParamSpecUInt64');

  ParamSpec get parentInstance => getFieldOfObject('parent_instance', 0);
  int get minimum => getFieldOfObject('minimum', 1);
  int get maximum => getFieldOfObject('maximum', 2);
  int get defaultValue => getFieldOfObject('default_value', 3);
}

class ParamSpecULong extends GObjectBase {
  ParamSpecULong.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'ParamSpecULong');

  ParamSpec get parentInstance => getFieldOfObject('parent_instance', 0);
  int get minimum => getFieldOfObject('minimum', 1);
  int get maximum => getFieldOfObject('maximum', 2);
  int get defaultValue => getFieldOfObject('default_value', 3);
}

class ParamSpecUnichar extends GObjectBase {
  ParamSpecUnichar.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'ParamSpecUnichar');

  ParamSpec get parentInstance => getFieldOfObject('parent_instance', 0);
  int get defaultValue => getFieldOfObject('default_value', 1);
}

class ParamSpecValueArray extends GObjectBase {
  ParamSpecValueArray.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'ParamSpecValueArray');

  ParamSpec get parentInstance => getFieldOfObject('parent_instance', 0);
  ParamSpec get elementSpec => getFieldOfObject('element_spec', 1);
  int get fixedNElements => getFieldOfObject('fixed_n_elements', 2);
}

class ParamSpecVariant extends GObjectBase {
  ParamSpecVariant.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'ParamSpecVariant');

  ParamSpec get parentInstance => getFieldOfObject('parent_instance', 0);
  VariantType get type => getFieldOfObject('type', 1);
  Variant get defaultValue => getFieldOfObject('default_value', 2);
  List<dynamic /* this will fail */> get padding => getFieldOfObject('padding', 3);
}

class Parameter extends GObjectBase {
  Parameter.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'Parameter');

  String get name => getFieldOfObject('name', 0);
  void set name(String value) => setFieldOfObject('name', 0, value);
  Value get value => getFieldOfObject('value', 1);
  void set value(Value value) => setFieldOfObject('value', 1, value);
}

typedef bool SignalAccumulator(SignalInvocationHint ihint, Value returnAccu, Value handlerReturn);
typedef bool SignalEmissionHook(SignalInvocationHint ihint, List<Value> paramValues);
class SignalFlags extends GEnumBase {
  const SignalFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'SignalFlags');

  static const SignalFlags NULL = const SignalFlags(0);
  static const SignalFlags RUN_FIRST = const SignalFlags(1);
  bool get runFirst => (value & 1) == 1;
  static const SignalFlags RUN_LAST = const SignalFlags(2);
  bool get runLast => (value & 2) == 2;
  static const SignalFlags RUN_CLEANUP = const SignalFlags(4);
  bool get runCleanup => (value & 4) == 4;
  static const SignalFlags NO_RECURSE = const SignalFlags(8);
  bool get noRecurse => (value & 8) == 8;
  static const SignalFlags DETAILED = const SignalFlags(16);
  bool get detailed => (value & 16) == 16;
  static const SignalFlags ACTION = const SignalFlags(32);
  bool get action => (value & 32) == 32;
  static const SignalFlags NO_HOOKS = const SignalFlags(64);
  bool get noHooks => (value & 64) == 64;
  static const SignalFlags MUST_COLLECT = const SignalFlags(128);
  bool get mustCollect => (value & 128) == 128;
  static const SignalFlags DEPRECATED = const SignalFlags(256);
  bool get deprecated => (value & 256) == 256;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'SignalFlags.RUN_FIRST';
      case 2: return 'SignalFlags.RUN_LAST';
      case 4: return 'SignalFlags.RUN_CLEANUP';
      case 8: return 'SignalFlags.NO_RECURSE';
      case 16: return 'SignalFlags.DETAILED';
      case 32: return 'SignalFlags.ACTION';
      case 64: return 'SignalFlags.NO_HOOKS';
      case 128: return 'SignalFlags.MUST_COLLECT';
      default: return 'new SignalFlags($value)';
    }
  }
  String toString() {
    if (value == 0) {
      return 'SignalFlags.NULL';
    }
    List codes = [];
    for (var i=1; i <= 256; i <<= 1) {
      if (value & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  SignalFlags operator|(SignalFlags other) =>
    new SignalFlags(value | other.value);
  SignalFlags operator&(SignalFlags other) =>
    new SignalFlags(value & other.value);
}

class SignalInvocationHint extends GObjectBase {
  SignalInvocationHint.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'SignalInvocationHint');

  int get signalId => getFieldOfObject('signal_id', 0);
  void set signalId(int value) => setFieldOfObject('signal_id', 0, value);
  int get detail => getFieldOfObject('detail', 1);
  void set detail(int value) => setFieldOfObject('detail', 1, value);
  SignalFlags get runType => getFieldOfObject('run_type', 2);
  void set runType(SignalFlags value) => setFieldOfObject('run_type', 2, value);
}

class SignalMatchType extends GEnumBase {
  const SignalMatchType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'SignalMatchType');

  static const SignalMatchType NULL = const SignalMatchType(0);
  static const SignalMatchType ID = const SignalMatchType(1);
  bool get id => (value & 1) == 1;
  static const SignalMatchType DETAIL = const SignalMatchType(2);
  bool get detail => (value & 2) == 2;
  static const SignalMatchType CLOSURE = const SignalMatchType(4);
  bool get closure => (value & 4) == 4;
  static const SignalMatchType FUNC = const SignalMatchType(8);
  bool get func => (value & 8) == 8;
  static const SignalMatchType DATA = const SignalMatchType(16);
  bool get data => (value & 16) == 16;
  static const SignalMatchType UNBLOCKED = const SignalMatchType(32);
  bool get unblocked => (value & 32) == 32;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'SignalMatchType.ID';
      case 2: return 'SignalMatchType.DETAIL';
      case 4: return 'SignalMatchType.CLOSURE';
      case 8: return 'SignalMatchType.FUNC';
      case 16: return 'SignalMatchType.DATA';
      case 32: return 'SignalMatchType.UNBLOCKED';
      default: return 'new SignalMatchType($value)';
    }
  }
  String toString() {
    if (value == 0) {
      return 'SignalMatchType.NULL';
    }
    List codes = [];
    for (var i=1; i <= 32; i <<= 1) {
      if (value & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  SignalMatchType operator|(SignalMatchType other) =>
    new SignalMatchType(value | other.value);
  SignalMatchType operator&(SignalMatchType other) =>
    new SignalMatchType(value & other.value);
}

class SignalQuery extends GObjectBase {
  SignalQuery.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'SignalQuery');

  int get signalId => getFieldOfObject('signal_id', 0);
  void set signalId(int value) => setFieldOfObject('signal_id', 0, value);
  String get signalName => getFieldOfObject('signal_name', 1);
  void set signalName(String value) => setFieldOfObject('signal_name', 1, value);
  int get itype => getFieldOfObject('itype', 2);
  void set itype(int value) => setFieldOfObject('itype', 2, value);
  SignalFlags get signalFlags => getFieldOfObject('signal_flags', 3);
  void set signalFlags(SignalFlags value) => setFieldOfObject('signal_flags', 3, value);
  int get returnType => getFieldOfObject('return_type', 4);
  void set returnType(int value) => setFieldOfObject('return_type', 4, value);
  int get nParams => getFieldOfObject('n_params', 5);
  void set nParams(int value) => setFieldOfObject('n_params', 5, value);
  List<int> get paramTypes => getFieldOfObject('param_types', 6);
  void set paramTypes(List<int> value) => setFieldOfObject('param_types', 6, value);
}

typedef void ToggleNotify(dynamic data /* this will fail */, GObjectObject object, bool isLastRef);
class TypeCValue extends GObjectBase {
  TypeCValue.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'TypeCValue');

  int get vInt => getFieldOfObject('v_int', 0);
  void set vInt(int value) => setFieldOfObject('v_int', 0, value);
  int get vLong => getFieldOfObject('v_long', 1);
  void set vLong(int value) => setFieldOfObject('v_long', 1, value);
  int get vInt64 => getFieldOfObject('v_int64', 2);
  void set vInt64(int value) => setFieldOfObject('v_int64', 2, value);
  num get vDouble => getFieldOfObject('v_double', 3);
  void set vDouble(num value) => setFieldOfObject('v_double', 3, value);
  dynamic /* this will fail */ get vPointer => getFieldOfObject('v_pointer', 4);
  void set vPointer(dynamic value /* this will fail */) => setFieldOfObject('v_pointer', 4, value);
}

class TypeClass extends GObjectBase {
  TypeClass.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'TypeClass');

  TypeClass peekParent() => _staticInfo.callMethodOnReceiver('peek_parent', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
  static void addPrivate(dynamic gClass /* this will fail */, int privateSize) => _staticInfo.callStatic('add_private', [gClass, privateSize]);
  static void adjustPrivateOffset(dynamic gClass /* this will fail */, int privateSizeOrOffset) => _staticInfo.callStatic('adjust_private_offset', [gClass, privateSizeOrOffset]);
  static TypeClass peek(int type) => _staticInfo.callStatic('peek', [type]);
  static TypeClass peekStatic(int type) => _staticInfo.callStatic('peek_static', [type]);
  static TypeClass ref(int type) => _staticInfo.callStatic('ref', [type]);
  int get gType => getFieldOfObject('g_type', 0);
}

typedef bool TypeClassCacheFunc(dynamic cacheData /* this will fail */, TypeClass gClass);
class TypeDebugFlags extends GEnumBase {
  const TypeDebugFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'TypeDebugFlags');

  static const TypeDebugFlags NONE = const TypeDebugFlags(0);
  bool get none => (value & 0) == 0;
  static const TypeDebugFlags OBJECTS = const TypeDebugFlags(1);
  bool get objects => (value & 1) == 1;
  static const TypeDebugFlags SIGNALS = const TypeDebugFlags(2);
  bool get signals => (value & 2) == 2;
  static const TypeDebugFlags INSTANCE_COUNT = const TypeDebugFlags(4);
  bool get instanceCount => (value & 4) == 4;
  static const TypeDebugFlags MASK = const TypeDebugFlags(7);
  bool get mask => (value & 7) == 7;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'TypeDebugFlags.OBJECTS';
      case 2: return 'TypeDebugFlags.SIGNALS';
      case 4: return 'TypeDebugFlags.INSTANCE_COUNT';
      default: return 'new TypeDebugFlags($value)';
    }
  }
  String toString() {
    if (value == 0) {
      return 'TypeDebugFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 4; i <<= 1) {
      if (value & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  TypeDebugFlags operator|(TypeDebugFlags other) =>
    new TypeDebugFlags(value | other.value);
  TypeDebugFlags operator&(TypeDebugFlags other) =>
    new TypeDebugFlags(value & other.value);
}

class TypeFlags extends GEnumBase {
  const TypeFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'TypeFlags');

  static const TypeFlags NULL = const TypeFlags(0);
  static const TypeFlags ABSTRACT = const TypeFlags(16);
  bool get abstract_ => (value & 16) == 16;
  static const TypeFlags VALUE_ABSTRACT = const TypeFlags(32);
  bool get valueAbstract => (value & 32) == 32;
  static _valueToString(int value) {
    switch(value) {
      case 16: return 'TypeFlags.ABSTRACT';
      case 32: return 'TypeFlags.VALUE_ABSTRACT';
      default: return 'new TypeFlags($value)';
    }
  }
  String toString() {
    if (value == 0) {
      return 'TypeFlags.NULL';
    }
    List codes = [];
    for (var i=1; i <= 32; i <<= 1) {
      if (value & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  TypeFlags operator|(TypeFlags other) =>
    new TypeFlags(value | other.value);
  TypeFlags operator&(TypeFlags other) =>
    new TypeFlags(value & other.value);
}

class TypeFundamentalFlags extends GEnumBase {
  const TypeFundamentalFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'TypeFundamentalFlags');

  static const TypeFundamentalFlags NULL = const TypeFundamentalFlags(0);
  static const TypeFundamentalFlags CLASSED = const TypeFundamentalFlags(1);
  bool get classed => (value & 1) == 1;
  static const TypeFundamentalFlags INSTANTIATABLE = const TypeFundamentalFlags(2);
  bool get instantiatable => (value & 2) == 2;
  static const TypeFundamentalFlags DERIVABLE = const TypeFundamentalFlags(4);
  bool get derivable => (value & 4) == 4;
  static const TypeFundamentalFlags DEEP_DERIVABLE = const TypeFundamentalFlags(8);
  bool get deepDerivable => (value & 8) == 8;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'TypeFundamentalFlags.CLASSED';
      case 2: return 'TypeFundamentalFlags.INSTANTIATABLE';
      case 4: return 'TypeFundamentalFlags.DERIVABLE';
      case 8: return 'TypeFundamentalFlags.DEEP_DERIVABLE';
      default: return 'new TypeFundamentalFlags($value)';
    }
  }
  String toString() {
    if (value == 0) {
      return 'TypeFundamentalFlags.NULL';
    }
    List codes = [];
    for (var i=1; i <= 8; i <<= 1) {
      if (value & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  TypeFundamentalFlags operator|(TypeFundamentalFlags other) =>
    new TypeFundamentalFlags(value | other.value);
  TypeFundamentalFlags operator&(TypeFundamentalFlags other) =>
    new TypeFundamentalFlags(value & other.value);
}

class TypeFundamentalInfo extends GObjectBase {
  TypeFundamentalInfo.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'TypeFundamentalInfo');

  TypeFundamentalFlags get typeFlags => getFieldOfObject('type_flags', 0);
  void set typeFlags(TypeFundamentalFlags value) => setFieldOfObject('type_flags', 0, value);
}

class TypeInfo extends GObjectBase {
  TypeInfo.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'TypeInfo');

  int get classSize => getFieldOfObject('class_size', 0);
  void set classSize(int value) => setFieldOfObject('class_size', 0, value);
  BaseInitFunc get baseInit => getFieldOfObject('base_init', 1);
  void set baseInit(BaseInitFunc value) => setFieldOfObject('base_init', 1, value);
  BaseFinalizeFunc get baseFinalize => getFieldOfObject('base_finalize', 2);
  void set baseFinalize(BaseFinalizeFunc value) => setFieldOfObject('base_finalize', 2, value);
  ClassInitFunc get classInit => getFieldOfObject('class_init', 3);
  void set classInit(ClassInitFunc value) => setFieldOfObject('class_init', 3, value);
  ClassFinalizeFunc get classFinalize => getFieldOfObject('class_finalize', 4);
  void set classFinalize(ClassFinalizeFunc value) => setFieldOfObject('class_finalize', 4, value);
  dynamic /* this will fail */ get classData => getFieldOfObject('class_data', 5);
  void set classData(dynamic value /* this will fail */) => setFieldOfObject('class_data', 5, value);
  int get instanceSize => getFieldOfObject('instance_size', 6);
  void set instanceSize(int value) => setFieldOfObject('instance_size', 6, value);
  int get nPreallocs => getFieldOfObject('n_preallocs', 7);
  void set nPreallocs(int value) => setFieldOfObject('n_preallocs', 7, value);
  InstanceInitFunc get instanceInit => getFieldOfObject('instance_init', 8);
  void set instanceInit(InstanceInitFunc value) => setFieldOfObject('instance_init', 8, value);
  TypeValueTable get valueTable => getFieldOfObject('value_table', 9);
  void set valueTable(TypeValueTable value) => setFieldOfObject('value_table', 9, value);
}

class TypeInstance extends GObjectBase {
  TypeInstance.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'TypeInstance');

  TypeClass get gClass => getFieldOfObject('g_class', 0);
}

class TypeInterface extends GObjectBase {
  TypeInterface.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'TypeInterface');

  TypeInterface peekParent() => _staticInfo.callMethodOnReceiver('peek_parent', this, []);
  static void addPrerequisite(int interfaceType, int prerequisiteType) => _staticInfo.callStatic('add_prerequisite', [interfaceType, prerequisiteType]);
  static TypePlugin getPlugin(int instanceType, int interfaceType) => _staticInfo.callStatic('get_plugin', [instanceType, interfaceType]);
  static TypeInterface peek(TypeClass instanceClass, int ifaceType) => _staticInfo.callStatic('peek', [instanceClass, ifaceType]);
  static List prerequisites(int interfaceType) => _staticInfo.callStatic('prerequisites', [interfaceType]);
  int get gType => getFieldOfObject('g_type', 0);
  int get gInstanceType => getFieldOfObject('g_instance_type', 1);
}

typedef void TypeInterfaceCheckFunc(dynamic checkData /* this will fail */);
class TypeModule extends GObjectObject with TypePlugin {
  TypeModule.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'TypeModule');

  void addInterface(int instanceType, int interfaceType, InterfaceInfo interfaceInfo) => _staticInfo.callMethodOnReceiver('add_interface', this, [instanceType, interfaceType, interfaceInfo]);
  int registerEnum(String name, EnumValue constStaticValues) => _staticInfo.callMethodOnReceiver('register_enum', this, [name, constStaticValues]);
  int registerFlags(String name, FlagsValue constStaticValues) => _staticInfo.callMethodOnReceiver('register_flags', this, [name, constStaticValues]);
  int registerType(int parentType, String typeName, TypeInfo typeInfo, TypeFlags flags) => _staticInfo.callMethodOnReceiver('register_type', this, [parentType, typeName, typeInfo, flags]);
  void setName(String name) => _staticInfo.callMethodOnReceiver('set_name', this, [name]);
  void unuse() => _staticInfo.callMethodOnReceiver('unuse', this, []);
  bool use() => _staticInfo.callMethodOnReceiver('use', this, []);
  int get useCount => getFieldOfObject('use_count', 1);
  SList /* this will fail */ get typeInfos => getFieldOfObject('type_infos', 2);
  SList /* this will fail */ get interfaceInfos => getFieldOfObject('interface_infos', 3);
  String get name => getFieldOfObject('name', 4);
}

abstract class TypePlugin extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'TypePlugin');



  void completeInterfaceInfo(int instanceType, int interfaceType, InterfaceInfo info) => _staticInfo.callMethodOnReceiver('complete_interface_info', this, [instanceType, interfaceType, info]);
  void completeTypeInfo(int gType, TypeInfo info, TypeValueTable valueTable) => _staticInfo.callMethodOnReceiver('complete_type_info', this, [gType, info, valueTable]);
  void unuse() => _staticInfo.callMethodOnReceiver('unuse', this, []);
  void use() => _staticInfo.callMethodOnReceiver('use', this, []);
}

class TypePluginClass extends GObjectBase {
  TypePluginClass.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'TypePluginClass');

  TypeInterface get baseIface => getFieldOfObject('base_iface', 0);
  TypePluginUse get usePlugin => getFieldOfObject('use_plugin', 1);
  void set usePlugin(TypePluginUse value) => setFieldOfObject('use_plugin', 1, value);
  TypePluginUnuse get unusePlugin => getFieldOfObject('unuse_plugin', 2);
  void set unusePlugin(TypePluginUnuse value) => setFieldOfObject('unuse_plugin', 2, value);
  TypePluginCompleteTypeInfo get completeTypeInfo => getFieldOfObject('complete_type_info', 3);
  void set completeTypeInfo(TypePluginCompleteTypeInfo value) => setFieldOfObject('complete_type_info', 3, value);
  TypePluginCompleteInterfaceInfo get completeInterfaceInfo => getFieldOfObject('complete_interface_info', 4);
  void set completeInterfaceInfo(TypePluginCompleteInterfaceInfo value) => setFieldOfObject('complete_interface_info', 4, value);
}

typedef void TypePluginCompleteInterfaceInfo(TypePlugin plugin, int instanceType, int interfaceType, InterfaceInfo info);
typedef void TypePluginCompleteTypeInfo(TypePlugin plugin, int gType, TypeInfo info, TypeValueTable valueTable);
typedef void TypePluginUnuse(TypePlugin plugin);
typedef void TypePluginUse(TypePlugin plugin);
class TypeQuery extends GObjectBase {
  TypeQuery.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'TypeQuery');

  int get type => getFieldOfObject('type', 0);
  void set type(int value) => setFieldOfObject('type', 0, value);
  String get typeName => getFieldOfObject('type_name', 1);
  void set typeName(String value) => setFieldOfObject('type_name', 1, value);
  int get classSize => getFieldOfObject('class_size', 2);
  void set classSize(int value) => setFieldOfObject('class_size', 2, value);
  int get instanceSize => getFieldOfObject('instance_size', 3);
  void set instanceSize(int value) => setFieldOfObject('instance_size', 3, value);
}

class TypeValueTable extends GObjectBase {
  TypeValueTable.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'TypeValueTable');

  dynamic /* this will fail */ get valuePeekPointer => getFieldOfObject('value_peek_pointer', 3);
  String get collectFormat => getFieldOfObject('collect_format', 4);
  void set collectFormat(String value) => setFieldOfObject('collect_format', 4, value);
  String get lcopyFormat => getFieldOfObject('lcopy_format', 6);
  void set lcopyFormat(String value) => setFieldOfObject('lcopy_format', 6, value);
}

class Value extends GObjectBase {
  Value.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'Value');

  void copy(Value destValue) => _staticInfo.callMethodOnReceiver('copy', this, [destValue]);
  GObjectObject dupObject() => _staticInfo.callMethodOnReceiver('dup_object', this, []);
  String dupString() => _staticInfo.callMethodOnReceiver('dup_string', this, []);
  Variant dupVariant() => _staticInfo.callMethodOnReceiver('dup_variant', this, []);
  bool fitsPointer() => _staticInfo.callMethodOnReceiver('fits_pointer', this, []);
  bool get boolean => _staticInfo.callMethodOnReceiver('get_boolean', this, []);
  void getBoxed() => _staticInfo.callMethodOnReceiver('get_boxed', this, []);
  int get char => _staticInfo.callMethodOnReceiver('get_char', this, []);
  num get double => _staticInfo.callMethodOnReceiver('get_double', this, []);
  int get enum_ => _staticInfo.callMethodOnReceiver('get_enum', this, []);
  int get flags => _staticInfo.callMethodOnReceiver('get_flags', this, []);
  num get float => _staticInfo.callMethodOnReceiver('get_float', this, []);
  int get gtype => _staticInfo.callMethodOnReceiver('get_gtype', this, []);
  int get int_ => _staticInfo.callMethodOnReceiver('get_int', this, []);
  int get int64 => _staticInfo.callMethodOnReceiver('get_int64', this, []);
  int get long => _staticInfo.callMethodOnReceiver('get_long', this, []);
  GObjectObject get object => _staticInfo.callMethodOnReceiver('get_object', this, []);
  ParamSpec get param => _staticInfo.callMethodOnReceiver('get_param', this, []);
  void getPointer() => _staticInfo.callMethodOnReceiver('get_pointer', this, []);
  int get schar => _staticInfo.callMethodOnReceiver('get_schar', this, []);
  String get string => _staticInfo.callMethodOnReceiver('get_string', this, []);
  int get uchar => _staticInfo.callMethodOnReceiver('get_uchar', this, []);
  int get uint => _staticInfo.callMethodOnReceiver('get_uint', this, []);
  int get uint64 => _staticInfo.callMethodOnReceiver('get_uint64', this, []);
  int get ulong => _staticInfo.callMethodOnReceiver('get_ulong', this, []);
  Variant get variant => _staticInfo.callMethodOnReceiver('get_variant', this, []);
  Value init(int gType) => _staticInfo.callMethodOnReceiver('init', this, [gType]);
  void initFromInstance(dynamic instance /* this will fail */) => _staticInfo.callMethodOnReceiver('init_from_instance', this, [instance]);
  void peekPointer() => _staticInfo.callMethodOnReceiver('peek_pointer', this, []);
  Value reset() => _staticInfo.callMethodOnReceiver('reset', this, []);
  void set boolean(bool vBoolean) => _staticInfo.callMethodOnReceiver('set_boolean', this, [vBoolean]);
  void setBoxed(dynamic vBoxed /* this will fail */) => _staticInfo.callMethodOnReceiver('set_boxed', this, [vBoxed]);
  void setBoxedTakeOwnership(dynamic vBoxed /* this will fail */) => _staticInfo.callMethodOnReceiver('set_boxed_take_ownership', this, [vBoxed]);
  void set char(int vChar) => _staticInfo.callMethodOnReceiver('set_char', this, [vChar]);
  void set double(num vDouble) => _staticInfo.callMethodOnReceiver('set_double', this, [vDouble]);
  void setEnum(int vEnum) => _staticInfo.callMethodOnReceiver('set_enum', this, [vEnum]);
  void set flags(int vFlags) => _staticInfo.callMethodOnReceiver('set_flags', this, [vFlags]);
  void set float(num vFloat) => _staticInfo.callMethodOnReceiver('set_float', this, [vFloat]);
  void set gtype(int vGtype) => _staticInfo.callMethodOnReceiver('set_gtype', this, [vGtype]);
  void setInstance(dynamic instance /* this will fail */) => _staticInfo.callMethodOnReceiver('set_instance', this, [instance]);
  void setInt(int vInt) => _staticInfo.callMethodOnReceiver('set_int', this, [vInt]);
  void set int64(int vInt64) => _staticInfo.callMethodOnReceiver('set_int64', this, [vInt64]);
  void set long(int vLong) => _staticInfo.callMethodOnReceiver('set_long', this, [vLong]);
  void set object(GObjectObject vObject) => _staticInfo.callMethodOnReceiver('set_object', this, [vObject]);
  void set param(ParamSpec param) => _staticInfo.callMethodOnReceiver('set_param', this, [param]);
  void setPointer(dynamic vPointer /* this will fail */) => _staticInfo.callMethodOnReceiver('set_pointer', this, [vPointer]);
  void set schar(int vChar) => _staticInfo.callMethodOnReceiver('set_schar', this, [vChar]);
  void setStaticBoxed(dynamic vBoxed /* this will fail */) => _staticInfo.callMethodOnReceiver('set_static_boxed', this, [vBoxed]);
  void setStaticString(String vString) => _staticInfo.callMethodOnReceiver('set_static_string', this, [vString]);
  void set string(String vString) => _staticInfo.callMethodOnReceiver('set_string', this, [vString]);
  void setStringTakeOwnership(String vString) => _staticInfo.callMethodOnReceiver('set_string_take_ownership', this, [vString]);
  void set uchar(int vUchar) => _staticInfo.callMethodOnReceiver('set_uchar', this, [vUchar]);
  void set uint(int vUint) => _staticInfo.callMethodOnReceiver('set_uint', this, [vUint]);
  void set uint64(int vUint64) => _staticInfo.callMethodOnReceiver('set_uint64', this, [vUint64]);
  void set ulong(int vUlong) => _staticInfo.callMethodOnReceiver('set_ulong', this, [vUlong]);
  void set variant(Variant variant) => _staticInfo.callMethodOnReceiver('set_variant', this, [variant]);
  void takeBoxed(dynamic vBoxed /* this will fail */) => _staticInfo.callMethodOnReceiver('take_boxed', this, [vBoxed]);
  void takeString(String vString) => _staticInfo.callMethodOnReceiver('take_string', this, [vString]);
  void takeVariant(Variant variant) => _staticInfo.callMethodOnReceiver('take_variant', this, [variant]);
  bool transform(Value destValue) => _staticInfo.callMethodOnReceiver('transform', this, [destValue]);
  void unset() => _staticInfo.callMethodOnReceiver('unset', this, []);
  static bool typeCompatible(int srcType, int destType) => _staticInfo.callStatic('type_compatible', [srcType, destType]);
  static bool typeTransformable(int srcType, int destType) => _staticInfo.callStatic('type_transformable', [srcType, destType]);
  int get gType => getFieldOfObject('g_type', 0);
  List<_Value__data__union> get data => getFieldOfObject('data', 1);
  void set data(List<_Value__data__union> value) => setFieldOfObject('data', 1, value);
}

class ValueArray extends GObjectBase {
  ValueArray.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'ValueArray');

  factory ValueArray(int nPrealloced) => _staticInfo.callStatic('new', [nPrealloced]);
  ValueArray append(Value value) => _staticInfo.callMethodOnReceiver('append', this, [value]);
  ValueArray copy() => _staticInfo.callMethodOnReceiver('copy', this, []);
  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
  Value getNth(int index_) => _staticInfo.callMethodOnReceiver('get_nth', this, [index_]);
  ValueArray insert(int index_, Value value) => _staticInfo.callMethodOnReceiver('insert', this, [index_, value]);
  ValueArray prepend(Value value) => _staticInfo.callMethodOnReceiver('prepend', this, [value]);
  ValueArray remove(int index_) => _staticInfo.callMethodOnReceiver('remove', this, [index_]);
  ValueArray sort(CompareDataFunc compareFunc) => _staticInfo.callMethodOnReceiver('sort', this, [compareFunc]);
  int get nValues => getFieldOfObject('n_values', 0);
  void set nValues(int value) => setFieldOfObject('n_values', 0, value);
  Value get values => getFieldOfObject('values', 1);
  void set values(Value value) => setFieldOfObject('values', 1, value);
  int get nPrealloced => getFieldOfObject('n_prealloced', 2);
}

typedef void ValueTransform(Value srcValue, Value destValue);
typedef void WeakNotify(dynamic data /* this will fail */, GObjectObject whereTheObjectWas);
class WeakRef extends GObjectBase {
  WeakRef.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', 'WeakRef');

}

class _Value__data__union extends GObjectBase {
  _Value__data__union.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GObject', '_Value__data__union');

  int get vInt => getFieldOfObject('v_int', 0);
  void set vInt(int value) => setFieldOfObject('v_int', 0, value);
  int get vUint => getFieldOfObject('v_uint', 1);
  void set vUint(int value) => setFieldOfObject('v_uint', 1, value);
  int get vLong => getFieldOfObject('v_long', 2);
  void set vLong(int value) => setFieldOfObject('v_long', 2, value);
  int get vUlong => getFieldOfObject('v_ulong', 3);
  void set vUlong(int value) => setFieldOfObject('v_ulong', 3, value);
  int get vInt64 => getFieldOfObject('v_int64', 4);
  void set vInt64(int value) => setFieldOfObject('v_int64', 4, value);
  int get vUint64 => getFieldOfObject('v_uint64', 5);
  void set vUint64(int value) => setFieldOfObject('v_uint64', 5, value);
  num get vFloat => getFieldOfObject('v_float', 6);
  void set vFloat(num value) => setFieldOfObject('v_float', 6, value);
  num get vDouble => getFieldOfObject('v_double', 7);
  void set vDouble(num value) => setFieldOfObject('v_double', 7, value);
  dynamic /* this will fail */ get vPointer => getFieldOfObject('v_pointer', 8);
  void set vPointer(dynamic value /* this will fail */) => setFieldOfObject('v_pointer', 8, value);
}

void boxedCopy(int boxedType, dynamic srcBoxed /* this will fail */) => callStaticGlobal('GObject', 'boxed_copy', [boxedType, srcBoxed]);

void boxedFree(int boxedType, dynamic boxed /* this will fail */) => callStaticGlobal('GObject', 'boxed_free', [boxedType, boxed]);

void cclosureMarshal_BOOLEAN__BOXED_BOXED(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => callStaticGlobal('GObject', 'cclosure_marshal_BOOLEAN__BOXED_BOXED', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);

void cclosureMarshal_BOOLEAN__FLAGS(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => callStaticGlobal('GObject', 'cclosure_marshal_BOOLEAN__FLAGS', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);

void cclosureMarshal_STRING__OBJECT_POINTER(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => callStaticGlobal('GObject', 'cclosure_marshal_STRING__OBJECT_POINTER', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);

void cclosureMarshal_VOID__BOOLEAN(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => callStaticGlobal('GObject', 'cclosure_marshal_VOID__BOOLEAN', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);

void cclosureMarshal_VOID__BOXED(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => callStaticGlobal('GObject', 'cclosure_marshal_VOID__BOXED', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);

void cclosureMarshal_VOID__CHAR(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => callStaticGlobal('GObject', 'cclosure_marshal_VOID__CHAR', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);

void cclosureMarshal_VOID__DOUBLE(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => callStaticGlobal('GObject', 'cclosure_marshal_VOID__DOUBLE', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);

void cclosureMarshal_VOID__ENUM(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => callStaticGlobal('GObject', 'cclosure_marshal_VOID__ENUM', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);

void cclosureMarshal_VOID__FLAGS(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => callStaticGlobal('GObject', 'cclosure_marshal_VOID__FLAGS', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);

void cclosureMarshal_VOID__FLOAT(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => callStaticGlobal('GObject', 'cclosure_marshal_VOID__FLOAT', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);

void cclosureMarshal_VOID__INT(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => callStaticGlobal('GObject', 'cclosure_marshal_VOID__INT', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);

void cclosureMarshal_VOID__LONG(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => callStaticGlobal('GObject', 'cclosure_marshal_VOID__LONG', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);

void cclosureMarshal_VOID__OBJECT(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => callStaticGlobal('GObject', 'cclosure_marshal_VOID__OBJECT', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);

void cclosureMarshal_VOID__PARAM(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => callStaticGlobal('GObject', 'cclosure_marshal_VOID__PARAM', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);

void cclosureMarshal_VOID__POINTER(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => callStaticGlobal('GObject', 'cclosure_marshal_VOID__POINTER', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);

void cclosureMarshal_VOID__STRING(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => callStaticGlobal('GObject', 'cclosure_marshal_VOID__STRING', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);

void cclosureMarshal_VOID__UCHAR(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => callStaticGlobal('GObject', 'cclosure_marshal_VOID__UCHAR', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);

void cclosureMarshal_VOID__UINT(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => callStaticGlobal('GObject', 'cclosure_marshal_VOID__UINT', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);

void cclosureMarshal_VOID__UINT_POINTER(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => callStaticGlobal('GObject', 'cclosure_marshal_VOID__UINT_POINTER', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);

void cclosureMarshal_VOID__ULONG(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => callStaticGlobal('GObject', 'cclosure_marshal_VOID__ULONG', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);

void cclosureMarshal_VOID__VARIANT(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => callStaticGlobal('GObject', 'cclosure_marshal_VOID__VARIANT', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);

void cclosureMarshal_VOID__VOID(Closure closure, Value returnValue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => callStaticGlobal('GObject', 'cclosure_marshal_VOID__VOID', [closure, returnValue, nParamValues, paramValues, invocationHint, marshalData]);

void cclosureMarshalGeneric(Closure closure, Value returnGvalue, int nParamValues, Value paramValues, dynamic invocationHint /* this will fail */, dynamic marshalData /* this will fail */) => callStaticGlobal('GObject', 'cclosure_marshal_generic', [closure, returnGvalue, nParamValues, paramValues, invocationHint, marshalData]);

TypeInfo enumCompleteTypeInfo(int gEnumType, EnumValue constValues) => callStaticGlobal('GObject', 'enum_complete_type_info', [gEnumType, constValues]);

EnumValue enumGetValue(EnumClass enumClass, int value) => callStaticGlobal('GObject', 'enum_get_value', [enumClass, value]);

EnumValue enumGetValueByName(EnumClass enumClass, String name) => callStaticGlobal('GObject', 'enum_get_value_by_name', [enumClass, name]);

EnumValue enumGetValueByNick(EnumClass enumClass, String nick) => callStaticGlobal('GObject', 'enum_get_value_by_nick', [enumClass, nick]);

int enumRegisterStatic(String name, EnumValue constStaticValues) => callStaticGlobal('GObject', 'enum_register_static', [name, constStaticValues]);

TypeInfo flagsCompleteTypeInfo(int gFlagsType, FlagsValue constValues) => callStaticGlobal('GObject', 'flags_complete_type_info', [gFlagsType, constValues]);

FlagsValue flagsGetFirstValue(FlagsClass flagsClass, int value) => callStaticGlobal('GObject', 'flags_get_first_value', [flagsClass, value]);

FlagsValue flagsGetValueByName(FlagsClass flagsClass, String name) => callStaticGlobal('GObject', 'flags_get_value_by_name', [flagsClass, name]);

FlagsValue flagsGetValueByNick(FlagsClass flagsClass, String nick) => callStaticGlobal('GObject', 'flags_get_value_by_nick', [flagsClass, nick]);

int flagsRegisterStatic(String name, FlagsValue constStaticValues) => callStaticGlobal('GObject', 'flags_register_static', [name, constStaticValues]);

int gtypeGetType() => callStaticGlobal('GObject', 'gtype_get_type', []);

ParamSpec paramSpecBoolean(String name, String nick, String blurb, bool defaultValue, ParamFlags flags) => callStaticGlobal('GObject', 'param_spec_boolean', [name, nick, blurb, defaultValue, flags]);

ParamSpec paramSpecBoxed(String name, String nick, String blurb, int boxedType, ParamFlags flags) => callStaticGlobal('GObject', 'param_spec_boxed', [name, nick, blurb, boxedType, flags]);

ParamSpec paramSpecChar(String name, String nick, String blurb, int minimum, int maximum, int defaultValue, ParamFlags flags) => callStaticGlobal('GObject', 'param_spec_char', [name, nick, blurb, minimum, maximum, defaultValue, flags]);

ParamSpec paramSpecDouble(String name, String nick, String blurb, num minimum, num maximum, num defaultValue, ParamFlags flags) => callStaticGlobal('GObject', 'param_spec_double', [name, nick, blurb, minimum, maximum, defaultValue, flags]);

ParamSpec paramSpecEnum(String name, String nick, String blurb, int enumType, int defaultValue, ParamFlags flags) => callStaticGlobal('GObject', 'param_spec_enum', [name, nick, blurb, enumType, defaultValue, flags]);

ParamSpec paramSpecFlags(String name, String nick, String blurb, int flagsType, int defaultValue, ParamFlags flags) => callStaticGlobal('GObject', 'param_spec_flags', [name, nick, blurb, flagsType, defaultValue, flags]);

ParamSpec paramSpecFloat(String name, String nick, String blurb, num minimum, num maximum, num defaultValue, ParamFlags flags) => callStaticGlobal('GObject', 'param_spec_float', [name, nick, blurb, minimum, maximum, defaultValue, flags]);

ParamSpec paramSpecGtype(String name, String nick, String blurb, int isAType, ParamFlags flags) => callStaticGlobal('GObject', 'param_spec_gtype', [name, nick, blurb, isAType, flags]);

ParamSpec paramSpecInt(String name, String nick, String blurb, int minimum, int maximum, int defaultValue, ParamFlags flags) => callStaticGlobal('GObject', 'param_spec_int', [name, nick, blurb, minimum, maximum, defaultValue, flags]);

ParamSpec paramSpecInt64(String name, String nick, String blurb, int minimum, int maximum, int defaultValue, ParamFlags flags) => callStaticGlobal('GObject', 'param_spec_int64', [name, nick, blurb, minimum, maximum, defaultValue, flags]);

ParamSpec paramSpecLong(String name, String nick, String blurb, int minimum, int maximum, int defaultValue, ParamFlags flags) => callStaticGlobal('GObject', 'param_spec_long', [name, nick, blurb, minimum, maximum, defaultValue, flags]);

ParamSpec paramSpecObject(String name, String nick, String blurb, int objectType, ParamFlags flags) => callStaticGlobal('GObject', 'param_spec_object', [name, nick, blurb, objectType, flags]);

ParamSpec paramSpecParam(String name, String nick, String blurb, int paramType, ParamFlags flags) => callStaticGlobal('GObject', 'param_spec_param', [name, nick, blurb, paramType, flags]);

ParamSpec paramSpecPointer(String name, String nick, String blurb, ParamFlags flags) => callStaticGlobal('GObject', 'param_spec_pointer', [name, nick, blurb, flags]);

ParamSpecPool paramSpecPoolNew(bool typePrefixing) => callStaticGlobal('GObject', 'param_spec_pool_new', [typePrefixing]);

ParamSpec paramSpecString(String name, String nick, String blurb, String defaultValue, ParamFlags flags) => callStaticGlobal('GObject', 'param_spec_string', [name, nick, blurb, defaultValue, flags]);

ParamSpec paramSpecUchar(String name, String nick, String blurb, int minimum, int maximum, int defaultValue, ParamFlags flags) => callStaticGlobal('GObject', 'param_spec_uchar', [name, nick, blurb, minimum, maximum, defaultValue, flags]);

ParamSpec paramSpecUint(String name, String nick, String blurb, int minimum, int maximum, int defaultValue, ParamFlags flags) => callStaticGlobal('GObject', 'param_spec_uint', [name, nick, blurb, minimum, maximum, defaultValue, flags]);

ParamSpec paramSpecUint64(String name, String nick, String blurb, int minimum, int maximum, int defaultValue, ParamFlags flags) => callStaticGlobal('GObject', 'param_spec_uint64', [name, nick, blurb, minimum, maximum, defaultValue, flags]);

ParamSpec paramSpecUlong(String name, String nick, String blurb, int minimum, int maximum, int defaultValue, ParamFlags flags) => callStaticGlobal('GObject', 'param_spec_ulong', [name, nick, blurb, minimum, maximum, defaultValue, flags]);

ParamSpec paramSpecUnichar(String name, String nick, String blurb, int defaultValue, ParamFlags flags) => callStaticGlobal('GObject', 'param_spec_unichar', [name, nick, blurb, defaultValue, flags]);

ParamSpec paramSpecVariant(String name, String nick, String blurb, VariantType type, Variant defaultValue, ParamFlags flags) => callStaticGlobal('GObject', 'param_spec_variant', [name, nick, blurb, type, defaultValue, flags]);

int paramTypeRegisterStatic(String name, ParamSpecTypeInfo pspecInfo) => callStaticGlobal('GObject', 'param_type_register_static', [name, pspecInfo]);

bool paramValueConvert(ParamSpec pspec, Value srcValue, Value destValue, bool strictValidation) => callStaticGlobal('GObject', 'param_value_convert', [pspec, srcValue, destValue, strictValidation]);

bool paramValueDefaults(ParamSpec pspec, Value value) => callStaticGlobal('GObject', 'param_value_defaults', [pspec, value]);

void paramValueSetDefault(ParamSpec pspec, Value value) => callStaticGlobal('GObject', 'param_value_set_default', [pspec, value]);

bool paramValueValidate(ParamSpec pspec, Value value) => callStaticGlobal('GObject', 'param_value_validate', [pspec, value]);

int paramValuesCmp(ParamSpec pspec, Value value1, Value value2) => callStaticGlobal('GObject', 'param_values_cmp', [pspec, value1, value2]);

int pointerTypeRegisterStatic(String name) => callStaticGlobal('GObject', 'pointer_type_register_static', [name]);

bool signalAccumulatorFirstWins(SignalInvocationHint ihint, Value returnAccu, Value handlerReturn, dynamic dummy /* this will fail */) => callStaticGlobal('GObject', 'signal_accumulator_first_wins', [ihint, returnAccu, handlerReturn, dummy]);

bool signalAccumulatorTrueHandled(SignalInvocationHint ihint, Value returnAccu, Value handlerReturn, dynamic dummy /* this will fail */) => callStaticGlobal('GObject', 'signal_accumulator_true_handled', [ihint, returnAccu, handlerReturn, dummy]);

int signalAddEmissionHook(int signalId, int detail, SignalEmissionHook hookFunc) => callStaticGlobal('GObject', 'signal_add_emission_hook', [signalId, detail, hookFunc]);

void signalChainFromOverridden(List<Value> instanceAndParams, Value returnValue) => callStaticGlobal('GObject', 'signal_chain_from_overridden', [instanceAndParams, returnValue]);

int signalConnectClosure(GObjectObject instance, String detailedSignal, Closure closure, bool after) => callStaticGlobal('GObject', 'signal_connect_closure', [instance, detailedSignal, closure, after]);

int signalConnectClosureById(GObjectObject instance, int signalId, int detail, Closure closure, bool after) => callStaticGlobal('GObject', 'signal_connect_closure_by_id', [instance, signalId, detail, closure, after]);

Value signalEmitv(List<Value> instanceAndParams, int signalId, int detail, Value returnValue) => callStaticGlobal('GObject', 'signal_emitv', [instanceAndParams, signalId, detail, returnValue]);

SignalInvocationHint signalGetInvocationHint(GObjectObject instance) => callStaticGlobal('GObject', 'signal_get_invocation_hint', [instance]);

void signalHandlerBlock(GObjectObject instance, int handlerId) => callStaticGlobal('GObject', 'signal_handler_block', [instance, handlerId]);

void signalHandlerDisconnect(GObjectObject instance, int handlerId) => callStaticGlobal('GObject', 'signal_handler_disconnect', [instance, handlerId]);

int signalHandlerFind(GObjectObject instance, SignalMatchType mask, int signalId, int detail, Closure closure, dynamic func /* this will fail */, dynamic data /* this will fail */) => callStaticGlobal('GObject', 'signal_handler_find', [instance, mask, signalId, detail, closure, func, data]);

bool signalHandlerIsConnected(GObjectObject instance, int handlerId) => callStaticGlobal('GObject', 'signal_handler_is_connected', [instance, handlerId]);

void signalHandlerUnblock(GObjectObject instance, int handlerId) => callStaticGlobal('GObject', 'signal_handler_unblock', [instance, handlerId]);

int signalHandlersBlockMatched(GObjectObject instance, SignalMatchType mask, int signalId, int detail, Closure closure, dynamic func /* this will fail */, dynamic data /* this will fail */) => callStaticGlobal('GObject', 'signal_handlers_block_matched', [instance, mask, signalId, detail, closure, func, data]);

void signalHandlersDestroy(GObjectObject instance) => callStaticGlobal('GObject', 'signal_handlers_destroy', [instance]);

int signalHandlersDisconnectMatched(GObjectObject instance, SignalMatchType mask, int signalId, int detail, Closure closure, dynamic func /* this will fail */, dynamic data /* this will fail */) => callStaticGlobal('GObject', 'signal_handlers_disconnect_matched', [instance, mask, signalId, detail, closure, func, data]);

int signalHandlersUnblockMatched(GObjectObject instance, SignalMatchType mask, int signalId, int detail, Closure closure, dynamic func /* this will fail */, dynamic data /* this will fail */) => callStaticGlobal('GObject', 'signal_handlers_unblock_matched', [instance, mask, signalId, detail, closure, func, data]);

bool signalHasHandlerPending(GObjectObject instance, int signalId, int detail, bool mayBeBlocked) => callStaticGlobal('GObject', 'signal_has_handler_pending', [instance, signalId, detail, mayBeBlocked]);

List signalListIds(int itype) => callStaticGlobal('GObject', 'signal_list_ids', [itype]);

int signalLookup(String name, int itype) => callStaticGlobal('GObject', 'signal_lookup', [name, itype]);

String signalName(int signalId) => callStaticGlobal('GObject', 'signal_name', [signalId]);

void signalOverrideClassClosure(int signalId, int instanceType, Closure classClosure) => callStaticGlobal('GObject', 'signal_override_class_closure', [signalId, instanceType, classClosure]);

List signalParseName(String detailedSignal, int itype, bool forceDetailQuark) => callStaticGlobal('GObject', 'signal_parse_name', [detailedSignal, itype, forceDetailQuark]);

SignalQuery signalQuery(int signalId) => callStaticGlobal('GObject', 'signal_query', [signalId]);

void signalRemoveEmissionHook(int signalId, int hookId) => callStaticGlobal('GObject', 'signal_remove_emission_hook', [signalId, hookId]);

void signalStopEmission(GObjectObject instance, int signalId, int detail) => callStaticGlobal('GObject', 'signal_stop_emission', [instance, signalId, detail]);

void signalStopEmissionByName(GObjectObject instance, String detailedSignal) => callStaticGlobal('GObject', 'signal_stop_emission_by_name', [instance, detailedSignal]);

Closure signalTypeCclosureNew(int itype, int structOffset) => callStaticGlobal('GObject', 'signal_type_cclosure_new', [itype, structOffset]);

void sourceSetClosure(Source source, Closure closure) => callStaticGlobal('GObject', 'source_set_closure', [source, closure]);

void sourceSetDummyCallback(Source source) => callStaticGlobal('GObject', 'source_set_dummy_callback', [source]);

String strdupValueContents(Value value) => callStaticGlobal('GObject', 'strdup_value_contents', [value]);

void typeAddClassPrivate(int classType, int privateSize) => callStaticGlobal('GObject', 'type_add_class_private', [classType, privateSize]);

int typeAddInstancePrivate(int classType, int privateSize) => callStaticGlobal('GObject', 'type_add_instance_private', [classType, privateSize]);

void typeAddInterfaceDynamic(int instanceType, int interfaceType, TypePlugin plugin) => callStaticGlobal('GObject', 'type_add_interface_dynamic', [instanceType, interfaceType, plugin]);

void typeAddInterfaceStatic(int instanceType, int interfaceType, InterfaceInfo info) => callStaticGlobal('GObject', 'type_add_interface_static', [instanceType, interfaceType, info]);

bool typeCheckClassIsA(TypeClass gClass, int isAType) => callStaticGlobal('GObject', 'type_check_class_is_a', [gClass, isAType]);

bool typeCheckInstance(TypeInstance instance) => callStaticGlobal('GObject', 'type_check_instance', [instance]);

bool typeCheckInstanceIsA(TypeInstance instance, int ifaceType) => callStaticGlobal('GObject', 'type_check_instance_is_a', [instance, ifaceType]);

bool typeCheckInstanceIsFundamentallyA(TypeInstance instance, int fundamentalType) => callStaticGlobal('GObject', 'type_check_instance_is_fundamentally_a', [instance, fundamentalType]);

bool typeCheckIsValueType(int type) => callStaticGlobal('GObject', 'type_check_is_value_type', [type]);

bool typeCheckValue(Value value) => callStaticGlobal('GObject', 'type_check_value', [value]);

bool typeCheckValueHolds(Value value, int type) => callStaticGlobal('GObject', 'type_check_value_holds', [value, type]);

List typeChildren(int type) => callStaticGlobal('GObject', 'type_children', [type]);

void typeClassAddPrivate(dynamic gClass /* this will fail */, int privateSize) => callStaticGlobal('GObject', 'type_class_add_private', [gClass, privateSize]);

void typeClassAdjustPrivateOffset(dynamic gClass /* this will fail */, int privateSizeOrOffset) => callStaticGlobal('GObject', 'type_class_adjust_private_offset', [gClass, privateSizeOrOffset]);

TypeClass typeClassPeek(int type) => callStaticGlobal('GObject', 'type_class_peek', [type]);

TypeClass typeClassPeekStatic(int type) => callStaticGlobal('GObject', 'type_class_peek_static', [type]);

TypeClass typeClassRef(int type) => callStaticGlobal('GObject', 'type_class_ref', [type]);

TypeInterface typeDefaultInterfacePeek(int gType) => callStaticGlobal('GObject', 'type_default_interface_peek', [gType]);

TypeInterface typeDefaultInterfaceRef(int gType) => callStaticGlobal('GObject', 'type_default_interface_ref', [gType]);

void typeDefaultInterfaceUnref(TypeInterface gIface) => callStaticGlobal('GObject', 'type_default_interface_unref', [gIface]);

int typeDepth(int type) => callStaticGlobal('GObject', 'type_depth', [type]);

void typeEnsure(int type) => callStaticGlobal('GObject', 'type_ensure', [type]);

void typeFreeInstance(TypeInstance instance) => callStaticGlobal('GObject', 'type_free_instance', [instance]);

int typeFromName(String name) => callStaticGlobal('GObject', 'type_from_name', [name]);

int typeFundamental(int typeId) => callStaticGlobal('GObject', 'type_fundamental', [typeId]);

int typeFundamentalNext() => callStaticGlobal('GObject', 'type_fundamental_next', []);

int typeGetInstanceCount(int type) => callStaticGlobal('GObject', 'type_get_instance_count', [type]);

TypePlugin typeGetPlugin(int type) => callStaticGlobal('GObject', 'type_get_plugin', [type]);

void typeGetQdata(int type, int quark) => callStaticGlobal('GObject', 'type_get_qdata', [type, quark]);

int typeGetTypeRegistrationSerial() => callStaticGlobal('GObject', 'type_get_type_registration_serial', []);

void typeInit() => callStaticGlobal('GObject', 'type_init', []);

void typeInitWithDebugFlags(TypeDebugFlags debugFlags) => callStaticGlobal('GObject', 'type_init_with_debug_flags', [debugFlags]);

void typeInterfaceAddPrerequisite(int interfaceType, int prerequisiteType) => callStaticGlobal('GObject', 'type_interface_add_prerequisite', [interfaceType, prerequisiteType]);

TypePlugin typeInterfaceGetPlugin(int instanceType, int interfaceType) => callStaticGlobal('GObject', 'type_interface_get_plugin', [instanceType, interfaceType]);

TypeInterface typeInterfacePeek(TypeClass instanceClass, int ifaceType) => callStaticGlobal('GObject', 'type_interface_peek', [instanceClass, ifaceType]);

List typeInterfacePrerequisites(int interfaceType) => callStaticGlobal('GObject', 'type_interface_prerequisites', [interfaceType]);

List typeInterfaces(int type) => callStaticGlobal('GObject', 'type_interfaces', [type]);

bool typeIsA(int type, int isAType) => callStaticGlobal('GObject', 'type_is_a', [type, isAType]);

String typeName(int type) => callStaticGlobal('GObject', 'type_name', [type]);

String typeNameFromClass(TypeClass gClass) => callStaticGlobal('GObject', 'type_name_from_class', [gClass]);

String typeNameFromInstance(TypeInstance instance) => callStaticGlobal('GObject', 'type_name_from_instance', [instance]);

int typeNextBase(int leafType, int rootType) => callStaticGlobal('GObject', 'type_next_base', [leafType, rootType]);

int typeParent(int type) => callStaticGlobal('GObject', 'type_parent', [type]);

int typeQname(int type) => callStaticGlobal('GObject', 'type_qname', [type]);

TypeQuery typeQuery(int type) => callStaticGlobal('GObject', 'type_query', [type]);

int typeRegisterDynamic(int parentType, String typeName, TypePlugin plugin, TypeFlags flags) => callStaticGlobal('GObject', 'type_register_dynamic', [parentType, typeName, plugin, flags]);

int typeRegisterFundamental(int typeId, String typeName, TypeInfo info, TypeFundamentalInfo finfo, TypeFlags flags) => callStaticGlobal('GObject', 'type_register_fundamental', [typeId, typeName, info, finfo, flags]);

int typeRegisterStatic(int parentType, String typeName, TypeInfo info, TypeFlags flags) => callStaticGlobal('GObject', 'type_register_static', [parentType, typeName, info, flags]);

void typeSetQdata(int type, int quark, dynamic data /* this will fail */) => callStaticGlobal('GObject', 'type_set_qdata', [type, quark, data]);

bool typeTestFlags(int type, int flags) => callStaticGlobal('GObject', 'type_test_flags', [type, flags]);

bool valueTypeCompatible(int srcType, int destType) => callStaticGlobal('GObject', 'value_type_compatible', [srcType, destType]);

bool valueTypeTransformable(int srcType, int destType) => callStaticGlobal('GObject', 'value_type_transformable', [srcType, destType]);

bool _initLibraryStarted = false;

void initLibrary() {
  if (_initLibraryStarted) return;
  _initLibraryStarted = true;
  glib.initLibrary();
  registerInterceptorTypeForNamedType("GObject", "Binding",Binding);
  registerInterceptorTypeForNamedType("GObject", "BindingFlags",BindingFlags);
  registerInterceptorTypeForNamedType("GObject", "CClosure",CClosure);
  registerInterceptorTypeForNamedType("GObject", "Closure",Closure);
  registerInterceptorTypeForNamedType("GObject", "ClosureNotifyData",ClosureNotifyData);
  registerInterceptorTypeForNamedType("GObject", "ConnectFlags",ConnectFlags);
  registerInterceptorTypeForNamedType("GObject", "EnumClass",EnumClass);
  registerInterceptorTypeForNamedType("GObject", "EnumValue",EnumValue);
  registerInterceptorTypeForNamedType("GObject", "FlagsClass",FlagsClass);
  registerInterceptorTypeForNamedType("GObject", "FlagsValue",FlagsValue);
  registerInterceptorTypeForNamedType("GObject", "InitiallyUnowned",InitiallyUnowned);
  registerInterceptorTypeForNamedType("GObject", "InterfaceInfo",InterfaceInfo);
  registerInterceptorTypeForNamedType("GObject", "Object",GObjectObject);
  registerInterceptorTypeForNamedType("GObject", "ObjectConstructParam",ObjectConstructParam);
  registerInterceptorTypeForNamedType("GObject", "ParamFlags",ParamFlags);
  registerInterceptorTypeForNamedType("GObject", "ParamSpec",ParamSpec);
  registerInterceptorTypeForNamedType("GObject", "ParamSpecBoolean",ParamSpecBoolean);
  registerInterceptorTypeForNamedType("GObject", "ParamSpecBoxed",ParamSpecBoxed);
  registerInterceptorTypeForNamedType("GObject", "ParamSpecChar",ParamSpecChar);
  registerInterceptorTypeForNamedType("GObject", "ParamSpecDouble",ParamSpecDouble);
  registerInterceptorTypeForNamedType("GObject", "ParamSpecEnum",ParamSpecEnum);
  registerInterceptorTypeForNamedType("GObject", "ParamSpecFlags",ParamSpecFlags);
  registerInterceptorTypeForNamedType("GObject", "ParamSpecFloat",ParamSpecFloat);
  registerInterceptorTypeForNamedType("GObject", "ParamSpecGType",ParamSpecGType);
  registerInterceptorTypeForNamedType("GObject", "ParamSpecInt",ParamSpecInt);
  registerInterceptorTypeForNamedType("GObject", "ParamSpecInt64",ParamSpecInt64);
  registerInterceptorTypeForNamedType("GObject", "ParamSpecLong",ParamSpecLong);
  registerInterceptorTypeForNamedType("GObject", "ParamSpecObject",ParamSpecObject);
  registerInterceptorTypeForNamedType("GObject", "ParamSpecOverride",ParamSpecOverride);
  registerInterceptorTypeForNamedType("GObject", "ParamSpecParam",ParamSpecParam);
  registerInterceptorTypeForNamedType("GObject", "ParamSpecPointer",ParamSpecPointer);
  registerInterceptorTypeForNamedType("GObject", "ParamSpecPool",ParamSpecPool);
  registerInterceptorTypeForNamedType("GObject", "ParamSpecString",ParamSpecString);
  registerInterceptorTypeForNamedType("GObject", "ParamSpecTypeInfo",ParamSpecTypeInfo);
  registerInterceptorTypeForNamedType("GObject", "ParamSpecUChar",ParamSpecUChar);
  registerInterceptorTypeForNamedType("GObject", "ParamSpecUInt",ParamSpecUInt);
  registerInterceptorTypeForNamedType("GObject", "ParamSpecUInt64",ParamSpecUInt64);
  registerInterceptorTypeForNamedType("GObject", "ParamSpecULong",ParamSpecULong);
  registerInterceptorTypeForNamedType("GObject", "ParamSpecUnichar",ParamSpecUnichar);
  registerInterceptorTypeForNamedType("GObject", "ParamSpecValueArray",ParamSpecValueArray);
  registerInterceptorTypeForNamedType("GObject", "ParamSpecVariant",ParamSpecVariant);
  registerInterceptorTypeForNamedType("GObject", "Parameter",Parameter);
  registerInterceptorTypeForNamedType("GObject", "SignalFlags",SignalFlags);
  registerInterceptorTypeForNamedType("GObject", "SignalInvocationHint",SignalInvocationHint);
  registerInterceptorTypeForNamedType("GObject", "SignalMatchType",SignalMatchType);
  registerInterceptorTypeForNamedType("GObject", "SignalQuery",SignalQuery);
  registerInterceptorTypeForNamedType("GObject", "TypeCValue",TypeCValue);
  registerInterceptorTypeForNamedType("GObject", "TypeClass",TypeClass);
  registerInterceptorTypeForNamedType("GObject", "TypeDebugFlags",TypeDebugFlags);
  registerInterceptorTypeForNamedType("GObject", "TypeFlags",TypeFlags);
  registerInterceptorTypeForNamedType("GObject", "TypeFundamentalFlags",TypeFundamentalFlags);
  registerInterceptorTypeForNamedType("GObject", "TypeFundamentalInfo",TypeFundamentalInfo);
  registerInterceptorTypeForNamedType("GObject", "TypeInfo",TypeInfo);
  registerInterceptorTypeForNamedType("GObject", "TypeInstance",TypeInstance);
  registerInterceptorTypeForNamedType("GObject", "TypeInterface",TypeInterface);
  registerInterceptorTypeForNamedType("GObject", "TypeModule",TypeModule);
  registerInterceptorTypeForNamedType("GObject", "TypePluginClass",TypePluginClass);
  registerInterceptorTypeForNamedType("GObject", "TypeQuery",TypeQuery);
  registerInterceptorTypeForNamedType("GObject", "TypeValueTable",TypeValueTable);
  registerInterceptorTypeForNamedType("GObject", "Value",Value);
  registerInterceptorTypeForNamedType("GObject", "ValueArray",ValueArray);
  registerInterceptorTypeForNamedType("GObject", "WeakRef",WeakRef);
  registerInterceptorTypeForNamedType("GObject", "_Value__data__union",_Value__data__union);
}
