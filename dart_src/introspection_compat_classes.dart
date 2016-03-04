/// This library contains the code to write your own native function
/// specifications in dart.
///
/// Internally, the gdart library can use GObject Introspection data provided
/// by glib, but for libraries that don't provide this information, you can
/// write your own introspection information and use that as well. The code
/// is parallel to the GObject Introspection library.
library introspection_compat_classes.gdart;

import 'girepository.dart';
import 'gdart.dart' as gdart;

/// The ffi-type that is passed into ffi functions.
enum FFIType {
  void_,
  uint8,
  sint8,
  uint16,
  sint16,
  uint32,
  sint32,
  uint64,
  sint64,
  float,
  double,
  longdouble,
  pointer,
  uchar,
  schar,
  ushort,
  sshort,
  uint,
  sint,
  ulong,
  slong
}

/// A utility class that tells the handler where to find a specified function.
///
/// The strings are passed into dlopen() and dlsym() respectively.
class FunctionSymbol {
  final String dlFilename;
  final String dlSym;
  FunctionSymbol(String this.dlFilename, String this.dlSym);
}

/// The base class for all introspection information.
abstract class InterfaceInfo implements HasInfoType {
  /// The name of the symbol, argument, etc.
  String get name;

  /// An enum that tells what "kind" of information this contains.
  InfoType get type;

  /// The namespace that this symbol exists in. This is only used for error
  /// reporting.
  String get namespace;
}

/// The class for a introspection type, such as the type of a field, an
/// argument, or a return value.
abstract class TypeInfo extends InterfaceInfo {
  /// The "tag" of the data, which is the first thing that is looked at
  /// when reading the type info.
  ///
  /// This is the only data needed for common types, such as integers and
  /// strings.
  TypeTag get tag;

  /// If the type is an interface type, such as an object, this tells you what\
  /// the interface is.
  ///
  /// This will be a [RegisteredTypeInfo] or a [CallbackInfo].
  HasInfoType get interface; //this can also be a GIObjectInfo
  /// The rest of this info is for arrays.
  ///
  /// If the array is an array with a length parameter that is passed along with
  /// it, then use [arrayLength] to specify where to look for the length. If
  /// it's a null-terminated array, then [isZeroTerminated] will be set to
  /// [true]. Lastly, if it's an array of a known size (or that size can be
  /// determined before calling the function but isn't returned/passed as a
  /// parameter) and the array isn't null-terminated, then [arrayFixedSize] will
  /// be set to the absolute length.
  int get arrayLength;
  bool get isZeroTerminated;
  int get arrayFixedSize;

  /// The parameter of the generic type
  ///
  /// This is currently only used for arrays.
  TypeInfo getParamType(int n);

  InfoType get type => InfoType.TYPE;

  factory TypeInfo.array(TypeInfo type, int n) =>
      new _TypeInfoArrayImpl(type, n);
  factory TypeInfo.nullTerminatedArray(TypeInfo type) =>
      new _TypeInfoArrayImpl.nullTerminated(type);
  factory TypeInfo.fixedSizeArray(TypeInfo type, int n) =>
      new _TypeInfoArrayImpl(type, n);
  factory TypeInfo(TypeTag tag) => new _TypeInfoBaseImpl(tag);
  factory TypeInfo.forInterface(interface) =>
      new _TypeInfoInterfaceImpl(interface);

  static final TypeInfo void_ = new TypeInfo(TypeTag.VOID);
  static final TypeInfo boolean = new TypeInfo(TypeTag.BOOLEAN);
  static final TypeInfo int8 = new TypeInfo(TypeTag.INT8);
  static final TypeInfo uint8 = new TypeInfo(TypeTag.UINT8);
  static final TypeInfo int16 = new TypeInfo(TypeTag.INT16);
  static final TypeInfo uint16 = new TypeInfo(TypeTag.UINT16);
  static final TypeInfo int32 = new TypeInfo(TypeTag.INT32);
  static final TypeInfo uint32 = new TypeInfo(TypeTag.UINT32);
  static final TypeInfo int64 = new TypeInfo(TypeTag.INT64);
  static final TypeInfo uint64 = new TypeInfo(TypeTag.UINT64);
  static final TypeInfo float = new TypeInfo(TypeTag.FLOAT);
  static final TypeInfo double = new TypeInfo(TypeTag.DOUBLE);
  static final TypeInfo gtype = new TypeInfo(TypeTag.GTYPE);
  static final TypeInfo string = new TypeInfo(TypeTag.UTF8);
}

class _TypeInfoBaseImpl implements TypeInfo {
  @override
  final int arrayFixedSize = -1;
  @override
  final int arrayLength = -1;

  _TypeInfoBaseImpl(this.tag) {
    if (tag == TypeTag.ARRAY || tag == TypeTag.INTERFACE)
      throw new ArgumentError("tag can't be $tag for a base type info");
  }
  TypeInfo getParamType(int n) => null;
  @override
  final InterfaceInfo interface = null;
  @override
  final bool isZeroTerminated = false;
  @override
  final String name = null;
  @override
  final String namespace = null;
  @override
  final TypeTag tag;

  @override
  final InfoType type = InfoType.TYPE;
  @override HasInfoType realize() => this;
}

class _TypeInfoArrayImpl implements TypeInfo {
  final int arrayFixedSize;

  @override
  final int arrayLength;

  final TypeInfo _paramType;

  TypeInfo getParamType(int n) {
    if (n == 0) return _paramType;
    return null;
  }

  @override
  final InterfaceInfo interface = null;

  @override
  final bool isZeroTerminated;

  @override
  final String name = null;

  @override
  final String namespace = null;

  @override
  final TypeTag tag = TypeTag.ARRAY;
  @override HasInfoType realize() => this;

  @override
  final InfoType type = InfoType.TYPE;
  _TypeInfoArrayImpl(this._paramType, this.arrayLength)
      : arrayFixedSize = -1,
        isZeroTerminated = false;

  _TypeInfoArrayImpl.fixedSize(this._paramType, this.arrayFixedSize)
      : arrayLength = -1,
        isZeroTerminated = false;

  _TypeInfoArrayImpl.nullTerminated(this._paramType)
      : arrayLength = -1,
        arrayFixedSize = -1,
        isZeroTerminated = true;
}

class _TypeInfoInterfaceImpl implements TypeInfo {
  @override
  final int arrayFixedSize = -1;

  @override
  final int arrayLength = -1;

  _TypeInfoInterfaceImpl(HasInfoType this.interface) {}

  TypeInfo getParamType(int n) => null;

  @override
  final HasInfoType interface;

  @override
  final bool isZeroTerminated = false;

  @override
  final String name = null;

  @override
  final String namespace = null;

  @override
  final TypeTag tag = TypeTag.INTERFACE;

  @override
  final InfoType type = InfoType.TYPE;
  @override HasInfoType realize() => this;
}

/// The class for an argument to a function.
abstract class ArgInfo extends InterfaceInfo {
  /// The type of the argument.
  TypeInfo get argType;

  /// If the argument is a callback, the location in the function argument-list
  /// of the userdata argument.
  ///
  /// Userdata is not used in dart, except when needed for the [destroy]
  /// parameter. Its type must be a (void*)
  int get closure;

  /// If the argument is a callback *and* the the [scope] is [ScopeType.NOTIFIED]
  /// the function that is called when userdata is no referenced (i.e., it may
  /// be garbage collected).
  ///
  /// If used for non-glib based libraries, its type must be void(*)(void*)
  int get destroy;

  /// Whether the argument is in, out, or in-out.
  Direction get direction;

  /// If the argument is a callback, *when* that callback may be called.
  ///
  /// If [scope] is [ScopeType.CALL], then the callback will be used, if at all,
  /// before the call returns. If [scope] is [ScopeType.ASYNC] then the function
  /// will be called exactly once. If [scope] is [ScopeType.NOTIFIED], then the
  /// function may be called multiple times before and after the call is
  /// returned, but the destroy function will be called when the callback is no
  /// longer needed.
  ///
  /// Note that all this information is used exclusively by the memory
  /// management system.
  ScopeType get scope;

  /// How the argument is transfered.
  ///
  /// For an in parameter, if set to [Transfer.EVERYTHING], gdart will make a
  /// copy of the object (or in the case of [String]s and [List]s, simply not
  /// clear the memory after the call completes. [Transfer.NOTHING] means that
  /// the function just gets the copy that Dart uses, and gdart is responsible
  /// for cleanup.
  ///
  /// For an out parameter, whether the dart routine gets a new copy or reference
  /// to data. If set to [Transfer.EVERYTHING], gdart gets a copy of the
  /// information which it must clear when done. If set to [Transfer.NOTHING]
  /// then gdart must make a copy of the data.
  ///
  /// This presents special issues when gdart receives an owned copy that it
  /// doesn't know how to deallocate, or an unowned copy, that it doesn't know
  /// when to invalidate. Those issues are also present in callbacks. The
  /// arguments may only be valid for the duration of the callback, but gdart
  /// has no way to know that.
  Transfer get ownershipTransfer;

  /// If true, the caller (in this case gdart) creates a struct container which
  /// receive the data. The size of the struct must be known.
  bool get isCallerAllocates;
  InfoType get type => InfoType.ARG;

  factory ArgInfo (argType, String name,
          {Direction direction: Direction.IN,
          String namespace: "",
          Transfer ownershipTransfer: Transfer.NOTHING,
          bool isCallerAllocates: false}) =>
      new _ArgInfoImpl(argType, name,
          direction: direction,
          namespace: namespace,
          ownershipTransfer: ownershipTransfer,
          isCallerAllocates: isCallerAllocates);
  factory ArgInfo.fromCallback(CallbackInfo info, String name,
          {Direction direction: Direction.IN,
          String namespace: "",
          Transfer ownershipTransfer: Transfer.NOTHING,
          int closure: -1,
          int destroy: -1,
          ScopeType scope: ScopeType.CALL}) =>
      new _ArgInfoImpl.forCallback(info, name,
          direction: direction,
          namespace: namespace,
          ownershipTransfer: ownershipTransfer,
          closure: closure,
          destroy: destroy);
}

class _ArgInfoImpl implements ArgInfo {
  @override
  final TypeInfo argType;
  @override
  final int closure;
  @override
  final int destroy;
  @override
  final Direction direction;
  @override
  final String name;
  @override
  final String namespace;
  @override
  final Transfer ownershipTransfer;
  @override
  final ScopeType scope;
  @override HasInfoType realize() => this;

  _ArgInfoImpl(TypeInfo this.argType, String this.name,
      {Direction this.direction: Direction.IN,
      String this.namespace: "",
      Transfer this.ownershipTransfer: Transfer.NOTHING,
      this.isCallerAllocates: false})
      : closure = -1,
        destroy = -1,
        scope = ScopeType.INVALID;
  _ArgInfoImpl.forCallback(CallbackInfo info, String this.name,
      {Direction this.direction: Direction.IN,
      String this.namespace: "",
      Transfer this.ownershipTransfer: Transfer.NOTHING,
      int this.closure: -1,
      int this.destroy: -1,
      ScopeType this.scope: ScopeType.CALL,
      this.isCallerAllocates: false})
      : argType = new TypeInfo.forInterface(info) {
    if (scope == ScopeType.NOTIFIED && (destroy == -1 || closure == -1)) {
      throw new ArgumentError("If scope is ScopeType.NOTIFIED, both"
          "destroy and notified must be set.");
    }
    if (info.closureArgument != -1 && closure == -1) {
      throw new ArgumentError("The callback type has a closure argument, but "
          "the argument didn't have a corresponding closure argument.");
    }
    if (info.closureArgument == -1 && closure != -1) {
      throw new ArgumentError("The callback type didn't have a closure "
          "argument, but the argument had a closure argument.");
    }
  }

  final bool isCallerAllocates;

  @override
  final InfoType type = InfoType.ARG;
}

/// The base class that's used by all callable classes, such as callbacks and
/// functions.
abstract class CallableInfo extends InterfaceInfo {
  /// The ffi type that's passed into the ffi functions.
  FFIType get ffiReturnType;

  /// The type of ffi arguments.
  List<FFIType> get ffiArgumentTypes;

  /// The list of arguments for the function, in introspection format.
  List<ArgInfo> get args;

  /// Whether the function is a method of an object. For hand-written
  /// introspection info, I recommend you set this to false.
  bool get isMethod;

  /// As [ArgInfo.ownershipTransfer] above, who owns the result value.
  Transfer get callerOwns;

  /// Whether the function can throw a GError-compatible error.
  bool get canThrowError;

  /// The return type of the function.
  TypeInfo get returnType;

  /// Create a list of FFIType that are compatible with the introspection
  /// arguments.
  static List<FFIType> visitArgs(TypeInfo returnType, List<ArgInfo> args,
      bool isMethod, int closureArgument, bool canThrowError) {
    final ffiTypes = new List();
    final setOfClosures = new Set();
    final setOfDestroyers = new Set();
    final setOfLengths = new Set();
    final setOfOutLength = new Set();

    if (isMethod) ffiTypes.add(FFIType.pointer);
    if (returnType.tag == TypeTag.ARRAY && returnType.arrayLength != -1) {
      setOfOutLength.add(returnType.arrayLength);
    }
    var argsIterator = args.iterator;
    while (argsIterator.moveNext()) {
      final argType = argsIterator.current;
      if (argType.argType.tag == TypeTag.INTERFACE &&
          argType.argType.interface.type == InfoType.CALLBACK) {
        if (argType.closure != -1) {
          setOfClosures.add(argType.closure);
        }
        if (argType.destroy != -1) {
          setOfDestroyers.add(argType.destroy);
        }
      }
      if (argType.argType.tag == TypeTag.ARRAY &&
          argType.argType.arrayLength != -1) {
        if (argType.direction == Direction.IN) {
          setOfLengths.add(argType.argType.arrayLength);
        } else {
          setOfOutLength.add(argType.argType.arrayLength);
        }
      }
    }
    //reset the iterator
    var garg = 0;
    argsIterator = args.iterator;
    while (true) {
      if (setOfOutLength.contains(garg)) {
        ffiTypes.add(FFIType.pointer);
        setOfOutLength.remove(garg);
        garg++;
        continue;
      }
      if (setOfClosures.contains(garg)) {
        ffiTypes.add(FFIType.pointer);
        setOfClosures.remove(garg);
        garg++;
        continue;
      }
      if (setOfDestroyers.contains(garg)) {
        ffiTypes.add(FFIType.pointer);
        setOfDestroyers.remove(garg);
        garg++;
        continue;
      }
      if (setOfLengths.contains(garg)) {
        ffiTypes.add(FFIType.sint);
        setOfLengths.remove(garg);
        garg++;
        continue;
      }
      if (closureArgument == garg) {
        ffiTypes.add(FFIType.pointer);
        closureArgument = -1;
        garg++;
        continue;
      }
      if (!argsIterator.moveNext()) break;
      final argType = argsIterator.current;
      if (argType.direction == Direction.IN) {
        ffiTypes.add(ffiTypeForArgInfo(argType.argType));
        garg++;
      } else {
        ffiTypes.add(FFIType.pointer);
        garg++;
      }
    }
    if (setOfOutLength.isNotEmpty) {
      throw new StateError("When filling argument types, we never reached "
          "${setOfOutLength.first}, which was set aside for an length-out value.");
    }
    if (setOfLengths.isNotEmpty) {
      throw new StateError("When filling argument types, we never reached "
          "${setOfOutLength.first}, which was set aside for an length value.");
    }
    if (setOfClosures.isNotEmpty) {
      throw new StateError("When filling argument types, we never reached "
          "${setOfOutLength.first}, which was set aside for the userdata part "
          "of a closure.");
    }
    if (setOfDestroyers.isNotEmpty) {
      throw new StateError("When filling argument types, we never reached "
          "${setOfOutLength.first}, which was set aside for the destroy notify "
          "of a closure.");
    }
    if (closureArgument != -1) {
      throw new StateError("When filling argument types, we never reached "
          "$closureArgument, which was set aside for the userdata part of a "
          "of a closure callback.");
    }
    if (canThrowError) ffiTypes.add(FFIType.pointer);
    return ffiTypes;
  }

  /// Get the FFIType that's compatible with the specific argument.
  static FFIType ffiTypeForArgInfo(TypeInfo argType) {
    var tag = argType.tag;
    if (tag == TypeTag.INTERFACE &&
        (argType.interface.type == InfoType.ENUM ||
            argType.interface.type == InfoType.FLAGS)) {
      tag = (argType.interface as HasStorageType).storageType;
    }
    if (tag == TypeTag.VOID) {
      return FFIType.void_;
    }
    if (tag == TypeTag.ARRAY ||
        tag == TypeTag.ERROR ||
        tag == TypeTag.FILENAME ||
        tag == TypeTag.GHASH ||
        tag == TypeTag.GLIST ||
        tag == TypeTag.GSLIST ||
        tag == TypeTag.UTF8) {
      return FFIType.pointer;
    } else if (tag == TypeTag.INT8) {
      return FFIType.sint8;
    } else if (tag == TypeTag.UINT8) {
      return FFIType.uint8;
    } else if (tag == TypeTag.INT16) {
      return FFIType.sint16;
    } else if (tag == TypeTag.UINT16) {
      return FFIType.uint16;
    } else if (tag == TypeTag.INT32) {
      return FFIType.sint32;
    } else if (tag == TypeTag.UINT32) {
      return FFIType.uint32;
    } else if (tag == TypeTag.INT64) {
      return FFIType.sint64;
    } else if (tag == TypeTag.UINT64) {
      return FFIType.uint64;
    } else if (tag == TypeTag.FLOAT) {
      return FFIType.float;
    } else if (tag == TypeTag.DOUBLE) {
      return FFIType.double;
    } else if (tag == TypeTag.GTYPE) {
      return FFIType.pointer;
    } else if (tag == TypeTag.BOOLEAN) {
      return FFIType.sint;
    } else if (tag == TypeTag.INTERFACE) {
      return FFIType.pointer;
    } else if (tag == TypeTag.UNICHAR) {
      return FFIType.uint32;
    } else {
      assert(false);
      return null;
    }
  }
}

/// A type that represents a callback type.
abstract class CallbackInfo extends CallableInfo {
  int get closureArgument;
  InfoType get type => InfoType.CALLBACK;

  factory CallbackInfo(TypeInfo returnType, name, Iterable<ArgInfo> args,
          {closureArgument: -1,
          Transfer callerOwns: Transfer.EVERYTHING,
          bool canThrowError: false,
          isMethod: false,
          namespace: ""}) =>
      new _CallbackInfoImpl(returnType, name, args,
          closureArgument: closureArgument,
          callerOwns: callerOwns,
          canThrowError: canThrowError,
          isMethod: isMethod,
          namespace: namespace);
}

class _CallbackInfoImpl implements CallbackInfo {
  @override
  final List<ArgInfo> args;

  @override
  final Transfer callerOwns;

  @override
  final bool canThrowError;

  @override
  final int closureArgument;

  @override
  final List<FFIType> ffiArgumentTypes;

  @override
  final FFIType ffiReturnType;

  @override
  final bool isMethod;

  @override
  final String name;

  @override
  final String namespace;

  @override
  final TypeInfo returnType;

  @override
  final InfoType type = InfoType.CALLBACK;
  @override HasInfoType realize() => this;

  _CallbackInfoImpl(TypeInfo returnType, this.name, Iterable<ArgInfo> args,
      {closureArgument: -1,
      Transfer this.callerOwns: Transfer.EVERYTHING,
      bool canThrowError: false,
      isMethod: false,
      this.namespace: ""})
      : args = new List.from(args, growable: false),
        canThrowError = canThrowError,
        closureArgument = closureArgument,
        ffiArgumentTypes = CallableInfo.visitArgs(
            returnType, args, isMethod, closureArgument, canThrowError),
        ffiReturnType = CallableInfo.ffiTypeForArgInfo(returnType),
        isMethod = isMethod,
        returnType = returnType;
}

/// The type of a concrete function.
abstract class FunctionInfo extends CallableInfo with gdart.GdartFunctionInfo {
  /// The symbol (including the library file) where this function can be found.
  FunctionSymbol get function;
  InfoType get type => InfoType.FUNCTION;

  factory FunctionInfo(TypeInfo returnType, String name,
          Iterable<ArgInfo> args, FunctionSymbol function,
          {Transfer callerOwns: Transfer.EVERYTHING,
          bool canThrowError: false,
          isMethod: false,
          namespace: ""}) =>
      new _FunctionInfoImpl(returnType, name, args, function,
          callerOwns: callerOwns,
          canThrowError: canThrowError,
          isMethod: isMethod,
          namespace: namespace);
}

class _FunctionInfoImpl extends Object with gdart.GdartFunctionInfo implements FunctionInfo  {
  @override
  final List<ArgInfo> args;

  @override
  final Transfer callerOwns;

  @override
  final bool canThrowError;

  @override
  final List<FFIType> ffiArgumentTypes;

  @override
  final FFIType ffiReturnType;

  @override
  final bool isMethod;

  @override
  final String name;

  @override
  final String namespace;

  @override
  final TypeInfo returnType;

  @override
  final FunctionSymbol function;

  @override
  final InfoType type = InfoType.FUNCTION;
  @override HasInfoType realize() => this;

  _FunctionInfoImpl(TypeInfo returnType, String this.name,
      Iterable<ArgInfo> args, FunctionSymbol this.function,
      {Transfer this.callerOwns: Transfer.EVERYTHING,
      bool canThrowError: false,
      isMethod: false,
      this.namespace: ""})
      : args = new List.from(args, growable: false),
        canThrowError = canThrowError,
        ffiArgumentTypes = CallableInfo.visitArgs(
            returnType, args, isMethod, -1, canThrowError),
        ffiReturnType = CallableInfo.ffiTypeForArgInfo(returnType),
        isMethod = isMethod,
        returnType = returnType;
}

abstract class VFuncInfo extends CallableInfo {
  /// This function returns the function info for a specified type. Gdart
  /// doesn't use VFuncs yet.
  dynamic getFunction(int gtype);
  InfoType get type => InfoType.VFUNC;
}

/// This is the function that you can ovverride to implement your own VFuncInfo
///
/// It implements every member in the interface except for the [getFunction]
/// method, so you have to implement that.
abstract class VFuncInfoConcImpl implements VFuncInfo {
  @override
  final List<ArgInfo> args;

  @override
  final Transfer callerOwns;

  @override
  final bool canThrowError;

  @override
  final List<FFIType> ffiArgumentTypes;

  @override
  final FFIType ffiReturnType;

  @override
  final bool isMethod;

  @override
  final String name;

  @override
  final String namespace;

  @override
  final TypeInfo returnType;
  @override
  final InfoType type = InfoType.VFUNC;

  VFuncInfoConcImpl(TypeInfo returnType, this.name, Iterable<ArgInfo> args,
      {closureArgument: -1,
      Transfer this.callerOwns: Transfer.EVERYTHING,
      bool canThrowError: false,
      isMethod: false,
      this.namespace: ""})
      : args = new List.from(args, growable: false),
        canThrowError = canThrowError,
        ffiArgumentTypes = CallableInfo.visitArgs(
            returnType, args, isMethod, closureArgument, canThrowError),
        ffiReturnType = CallableInfo.ffiTypeForArgInfo(returnType),
        isMethod = isMethod,
        returnType = returnType;
}

/// A registered type info represents a type that can be registered with the
/// GType system.
///
/// Currently, there's no need to hav the gtype be meaningful.
abstract class RegisteredTypeInfo extends InterfaceInfo {
  int get gtype;
  Type get dartType;
}

abstract class EnumInfo extends RegisteredTypeInfo implements HasStorageType {
  TypeTag get storageType;

  factory EnumInfo(gtype, name, dartType,
      {namespace: "",
      storageType: TypeTag.INT32,
      type: InfoType.ENUM}) => new _EnumInfoImpl(gtype, name, dartType, namespace: namespace,storageType: storageType, type: type);
}

class _EnumInfoImpl implements EnumInfo {
  @override
  final int gtype;

  @override
  final String name;

  @override
  final String namespace;

  @override
  final TypeTag storageType;

  @override
  final InfoType type;
  @override HasInfoType realize() => this;

  @override
  final Type dartType;

  _EnumInfoImpl(this.gtype, this.name, this.dartType,
      {this.namespace: "",
      this.storageType: TypeTag.INT32,
      this.type: InfoType.ENUM}) {
    if (type != InfoType.ENUM && type != InfoType.FLAGS) {
      throw new ArgumentError("type must be ENUM or FLAGS");
    }
  }
}

abstract class ObjectInfo extends RegisteredTypeInfo {
  dynamic get refFunction;
  dynamic get unrefFunction;
  InfoType get type => InfoType.OBJECT;
}

abstract class StructUnionInfo extends RegisteredTypeInfo {
  int get size;
  dynamic get copyFunction;
  dynamic get freeFunction;

  factory StructUnionInfo(gtype, name, dartType,
          {namespace: "", size: 0, type: InfoType.STRUCT,
          copyFunction, freeFunction}) =>
      new _StructUnionInfoImpl(gtype, name, dartType,
          namespace: namespace, size: size, type: type,
          copyFunction: copyFunction, freeFunction: freeFunction);
}

class _StructUnionInfoImpl implements StructUnionInfo {
  @override
  final int gtype;

  @override
  final String name;

  @override
  final String namespace;

  @override
  final int size;

  @override
  final InfoType type;
  @override HasInfoType realize() => this;

  @override
  final Type dartType;

  @override
  final FunctionSymbol copyFunction;
  final FunctionSymbol freeFunction;

  _StructUnionInfoImpl(this.gtype, this.name, this.dartType,
      {this.namespace: "", this.size: 0, this.type: InfoType.STRUCT,
      this.copyFunction, this.freeFunction}) {
    if (type != InfoType.STRUCT && type != InfoType.UNION) {
      throw new ArgumentError("type must be STRUCT or UNION");
    }
  }
}
