library introspection_compat_classes.gdart;

import 'girepository.dart';

enum FFIType {
  void_, uint8, sint8, uint16, sint16, uint32, sint32, uint64, sint64,
  float, double, longdouble, pointer, uchar, schar, ushort, sshort,
  uint, sint, ulong, slong
}

enum FFIAbi {
  default_,
  sysv, //various
  unix, //ia64, tile
  unix64, win64, stdCall, thisCall, fastCall, msCdecl, pascal, register, //x86
  osf, //alpha
  arCompact, //arc
  vfp, //arm
  o32SoftFloat, n32SoftFloat, n64SoftFloat, o32, n32, n64, //mips
  eabi, //frv
  obsd, //m88k
  pa32, pa64, paLinux, //pa
  aix, darwin, gccSysv, linux64, liux, linuxSoftFloat, linuxStructAlign, linuxLongDouble128, sysvSoftFloat, sysvStructRet, sysvIbmLongDouble, sysvLongDouble128, //powerPc
  v8, v9, //sparc
  elfBsd, //vax
}

abstract class InterfaceInfo {
  String get name;
  InfoType get type;
  String get namespace;
}

abstract class TypeInfo extends InterfaceInfo {
  TypeTag get tag;
  InterfaceInfo get interface; //this can also be a GIObjectInfo
  int get arrayLength;
  bool get isZeroTerminated;
  int get arrayFixedSize;
  TypeInfo getParamType(int n);

  InfoType get type => InfoType.TYPE;
}

abstract class ArgInfo extends InterfaceInfo {
  TypeInfo get argType;
  int get closure;
  int get destroy;
  Direction get direction;
  ScopeType get scope;
  Transfer get ownershipTransfer;
  bool isCallerAllocates;
  InfoType get type => InfoType.ARG;
}

abstract class CallableInfo extends InterfaceInfo {
  FFIType get ffiReturnType;
  List<FFIType> get ffiArgumentTypes;
  List<ArgInfo> get args;
  bool get isMethod;
  Transfer get callerOwns;
  bool get canThrowError;
  TypeInfo get returnType;
}

abstract class FunctionInfo extends CallableInfo {
 dynamic get function; // a functionSymbol or some other type that resolves to a function
 InfoType get type => InfoType.FUNCTION;
}

abstract class VFuncInfo extends CallableInfo {
  dynamic getFunction(int gtype);
  InfoType get type => InfoType.VFUNC;
}

abstract class RegisteredTypeInfo extends InterfaceInfo {
  int get gtype;
}

abstract class EnumInfo extends RegisteredTypeInfo {
  TypeTag get storageType;
}

class FunctionSymbol {
  final String dlFilename;
  final String dlSym;
  FunctionSymbol(String this.dlFilename, String this.dlSym);
}

abstract class ObjectInfo extends RegisteredTypeInfo {
  dynamic get refFunction;
  dynamic get unrefFunction;
  InfoType get type => InfoType.OBJECT;
}

abstract class StructUnionUnionInfo extends RegisteredTypeInfo {
  int get size;
}
