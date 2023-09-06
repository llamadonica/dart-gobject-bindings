import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart' as ffi;

import '../discovery/discovery.dart';

final class GLibLibraryAdapter {
  final ffi.DynamicLibrary _glib;
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName) _lookup;

  GLibLibraryAdapter() : this._(ffi.DynamicLibrary.open(libraryFinder.findLibrary('glib-2.0')));

  GLibLibraryAdapter._(this._glib) : _lookup = _glib.lookup;

  late final _gErrorFreePtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<_GError>)>>('g_error_free');

  late final _gErrorFree = _gErrorFreePtr.asFunction<void Function(ffi.Pointer<_GError>)>();

  late final _gMallocPtr = _lookup<ffi.NativeFunction<ffi.Pointer<ffi.Void> Function(ffi.Int64)>>('g_malloc');

  late final _gMalloc = _gMallocPtr.asFunction<ffi.Pointer<ffi.Void> Function(int)>();

  late final _gFreePtr = _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Void>)>>('g_free');

  late final _gFree = _gFreePtr.asFunction<void Function(ffi.Pointer<ffi.Void>)>();

  late final _gAlignedAllocPtr = _lookup<ffi.NativeFunction<ffi.Pointer<ffi.Void> Function(ffi.Int64, ffi.Int64, ffi.Int64)>>('g_aligned_alloc');

  late final _gAlignedAlloc = _gAlignedAllocPtr.asFunction<ffi.Pointer<ffi.Void> Function(int, int, int)>();
}

GLibLibraryAdapter? _glib;
GLibLibraryAdapter get glib => _glib ??= GLibLibraryAdapter();

typedef GErrorBuilder = GError Function(int domain, int code, String message);

class GError {
  final int domain;
  final int code;
  final String message;

  static Map<int, GErrorBuilder> _errorBuilders = {};

  static void registerError(int domain, GErrorBuilder builder) {
    _errorBuilders[domain] = builder;
  }

  GError(this.domain, this.code, this.message);

  @override
  String toString() => 'GError: $message ($domain, $code)';

  static GError? $fromGError(ffi.Pointer<ffi.Void> ptr) {
    if (ptr == ffi.nullptr) {
      return null;
    }

    final error = ptr.cast<_GError>().ref;
    final message = error.message.cast<ffi.Utf8>().toDartString();
    final domain = error.domain;
    final code = error.code;
    glib._gErrorFree(ptr.cast<_GError>());
    var builder = _errorBuilders[domain];
    if (builder == null) {
      return GError(domain, code, message);
    }
    return builder(domain, code, message);
  }
}

final class _GError extends ffi.Struct {
  @ffi.Uint32()
  external int domain;

  @ffi.Int32()
  external int code;

  external ffi.Pointer<ffi.Char> message;
}

class GMalloc implements ffi.Allocator {
  const GMalloc();

  @override
  ffi.Pointer<T> allocate<T extends ffi.NativeType>(int byteCount, {int? alignment}) {
    if (alignment == null) {
      return glib._gMalloc(byteCount).cast();
    }
    return glib._gAlignedAlloc(1, byteCount, alignment).cast();
  }

  @override
  void free(ffi.Pointer<ffi.NativeType> pointer) {
    glib._gFree(pointer.cast());
  }

  ffi.Pointer<ffi.NativeFinalizerFunction> get freeFunction => glib._gFreePtr;

}

final gMalloc = const GMalloc();