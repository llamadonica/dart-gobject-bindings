library gdart_base_impl;

import 'dart-ext:gdart';

void registerInterceptorTypeForGtype(int gtype, String namespace, String symbol,
    Type interceptor) native "gdart_bridge_context_register_interceptor_type_for_gtype";
void registerCopyFuncForGtype(int gtype, String namespace, String type_name,
    String symbol) native "gdart_bridge_context_register_copy_func_for_gtype";
void registerFreeFuncForGtype(int gtype, String namespace, String type_name,
    String symbol) native "gdart_bridge_context_register_free_func_for_gtype";

int lookupGtypeFromNamedType(String namespace, String symbol)
    native "gdart_bridge_context_lookup_gtype_from_named_type";
callStaticGlobal(String namespace, String symbol, List arguments)
    native "gdart_bridge_context_call_static_global";

void registerInterceptorTypeForNamedType(
        String namespace, String symbol, Type interceptor) =>
    registerInterceptorTypeForGtype(lookupGtypeFromNamedType(namespace, symbol),
        namespace, symbol, interceptor);
void registerCopyFuncForNamedType(
        String namespace, String symbol, String functionSymbol) =>
    registerCopyFuncForGtype(lookupGtypeFromNamedType(namespace, symbol),
        namespace, symbol, functionSymbol);
void registerFreeFuncForNamedType(
        String namespace, String symbol, String functionSymbol) =>
    registerFreeFuncForGtype(lookupGtypeFromNamedType(namespace, symbol),
        namespace, symbol, functionSymbol);

int lookupErrorQuarkFromString(String errorDomain)
    native "gdart_bridge_context_lookup_error_quark_from_string";
String lookupErrorStringFromQuark(int gquark)
    native "gdart_bridge_context_lookup_error_string_from_quark";
void registerInterceptorTypeForErrorQuark(int gquark, Type interceptor)
    native "gdart_bridge_context_register_interceptor_type_for_error_quark";
void registerInterceptorTypeForErrorDomain(
        String errorDomain, Type interceptor) =>
    registerInterceptorTypeForErrorQuark(
        lookupErrorQuarkFromString(errorDomain), interceptor);

dynamic _lookupObjectInfo(String namespace, String symbol)
    native "gdart_bridge_context_lookup_object_info";

class GDartException {
  final String message;
  GDartException(String this.message);
  String toString() => "DartException($message)";
}

class GObjectBase {
  var _internal;
  get internal => _internal;

  String toString() => "Instance of '$runtimeType' [${stringRepresentation()}]";

  String stringRepresentation()
      native "gdart_bridge_context_object_get_string_representation";
  callMethod(String name, List args)
      native "gdart_bridge_context_object_call_method";
  int signalConnect(String detailedName, callback, bool after)
      native "gdart_bridge_context_object_signal_connect";
  dynamic getFieldOfObject(String giRepositoryName, int index) => _structUnionGetFieldOfObject(this, giRepositoryName, index);

  void setFieldOfObject(String giRepositoryName, int index, dynamic value) {
    throw new Exception('Not implemented yet!');
  }

  void signalDisconnect(int signalId)
      native "gdart_bridge_context_object_signal_disconnect";
}

class GEnumBase {
  final int index;
  const GEnumBase(int this.index);

  toString() => "Instance of '$runtimeType' ($index)";
  bool operator ==(Object other) =>
      runtimeType == other.runtimeType && index == (other as GEnumBase).index;
}

class GErrorBase {
  final int errorDomain;
  final GEnumBase errorCode;
  final String message;

  GErrorBase.fromFields(
      int this.errorDomain, GEnumBase this.errorCode, String this.message);
  String toString() =>
      "Instance of '$runtimeType' {errorDomain: '${lookupErrorStringFromQuark(errorDomain)}',"
      " errorCode: $errorCode, message: \"$message\"}";
}

class UnknownObject extends GObjectBase {
  UnknownObject.fromNative();
}

/// TODO: It would be nice if this was unified with the GIRepository code.
class GIObjectInfo {
  factory GIObjectInfo(String namespace, String symbol) => _lookupObjectInfo(namespace, symbol);

  callStatic(String name, List args) =>
      _registeredTypeInfoCallStatic(this, name, args);
  callMethodOnReceiver(String name, dynamic receiver, List args) =>
      _registeredTypeInfoCallMethodOnReceiver(this, name, receiver, args);
  getGPropertyOnReceiver(String name, dynamic receiver) =>
      _registeredTypeInfoGetGPropertyOnReceiver(this, name, receiver);
  setGPropertyOnReceiver(String name, dynamic receiver, dynamic value) =>
      _registeredTypeInfoSetGPropertyOnReceiver(this, name, receiver, value);
  allocateNew() => structUnionAllocateNew(this);
}

_registeredTypeInfoCallStatic(dynamic objectInfo, String name, List args)
    native "gdart_bridge_context_object_info_call_static";
_registeredTypeInfoCallMethodOnReceiver(
    dynamic objectInfo,
    String name,
    dynamic receiver,
    List args) native "gdart_bridge_context_object_info_call_method_on_receiver";
_registeredTypeInfoGetGPropertyOnReceiver(dynamic objectInfo, String name,
    dynamic receiver) native "gdart_bridge_context_object_info_get_g_property_on_receiver";
void _registeredTypeInfoSetGPropertyOnReceiver(dynamic objectInfo, String name, dynamic receiver,
    dynamic value) native "gdart_bridge_context_object_info_set_g_property_on_receiver";
dynamic _structUnionGetFieldOfObject(dynamic structInfoReceiver, String name, int expectedIndex)
    native "gdart_bridge_context_struct_union_get_field_of_object";

class GdartFunctionInfo {
  call(List args) => callDartFunctionInfo(this, args);
}

callDartFunctionInfo(GdartFunctionInfo self, List args)
    native "gdart_bridge_context_call_dart_function_info";

structUnionAllocateNew(dynamic receiver)
  native "gdart_bridge_context_struct_union_info_allocate_new";