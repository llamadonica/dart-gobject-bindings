import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart' as ffi;

import '../discovery/discovery.dart';
import '../glib/ffi.dart';

final class GObjectLibraryDepends {
  final GLibLibraryAdapter glib;

  GObjectLibraryDepends({required this.glib});
}

final class GObjectLibraryAdapter {
  final ffi.DynamicLibrary _gobject;
  final GObjectLibraryDepends depends;
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName) _lookup;

  GObjectLibraryAdapter() : this._(ffi.DynamicLibrary.open(libraryFinder.findLibrary('gobject-2.0')), GObjectLibraryDepends(glib: glib));
  GObjectLibraryAdapter._(this._gobject, this.depends)
      : _lookup = _gobject.lookup,
        _gObjectUnrefPtr = _gobject.lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Void>)>>('g_object_unref'),
        _gObjectRefPtr = _gobject.lookup<ffi.NativeFunction<ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>)>>('g_object_ref'),
        _gObjectRefSinkPtr = _gobject.lookup<ffi.NativeFunction<ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>)>>('g_object_ref_sink'),
        _gInitiallyUnownedGetTypePtr = _gobject.lookup<ffi.NativeFunction<ffi.UnsignedLong Function()>>('g_initially_unowned_get_type'),
        _gObjectGetTypePtr = _gobject.lookup<ffi.NativeFunction<ffi.UnsignedLong Function()>>('g_object_get_type'),
        _gTypeIsAPtr = _gobject.lookup<ffi.NativeFunction<ffi.Bool Function(ffi.UnsignedLong, ffi.UnsignedLong)>>('g_type_is_a'),
        _gTypeParentPtr = _gobject.lookup<ffi.NativeFunction<ffi.UnsignedLong Function(ffi.UnsignedLong)>>('g_type_parent'),
        _gTypeNamePtr = _gobject.lookup<ffi.NativeFunction<ffi.Pointer<ffi.Utf8> Function(ffi.UnsignedLong)>>('g_type_name');

  final ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Void>)>> _gObjectUnrefPtr;
  void Function(ffi.Pointer<ffi.Void>) get _gObjectUnref => _gObjectUnrefPtr.asFunction<void Function(ffi.Pointer<ffi.Void>)>();
  final ffi.Pointer<ffi.NativeFunction<ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>)>> _gObjectRefPtr;
  ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>) get _gObjectRef => _gObjectRefPtr.asFunction<ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>)>();
  final ffi.Pointer<ffi.NativeFunction<ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>)>> _gObjectRefSinkPtr;
  ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>) get _gObjectRefSink => _gObjectRefSinkPtr.asFunction<ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>)>();
  final ffi.Pointer<ffi.NativeFunction<ffi.UnsignedLong Function()>> _gInitiallyUnownedGetTypePtr;
  int Function() get _gInitiallyUnownedGetType => _gInitiallyUnownedGetTypePtr.asFunction<int Function()>();
  final ffi.Pointer<ffi.NativeFunction<ffi.UnsignedLong Function()>> _gObjectGetTypePtr;
  int Function() get _gObjectGetType => _gObjectGetTypePtr.asFunction<int Function()>();
  final ffi.Pointer<ffi.NativeFunction<ffi.Bool Function(ffi.UnsignedLong, ffi.UnsignedLong)>> _gTypeIsAPtr;
  bool Function(int, int) get _gTypeIsA => _gTypeIsAPtr.asFunction<bool Function(int, int)>();
  final ffi.Pointer<ffi.NativeFunction<ffi.UnsignedLong Function(ffi.UnsignedLong)>> _gTypeParentPtr;
  int Function(int) get _gTypeParent => _gTypeParentPtr.asFunction<int Function(int)>();
  final ffi.Pointer<ffi.NativeFunction<ffi.Pointer<ffi.Utf8> Function(ffi.UnsignedLong)>> _gTypeNamePtr;
  ffi.Pointer<ffi.Utf8> Function(int) get _gTypeName => _gTypeNamePtr.asFunction<ffi.Pointer<ffi.Utf8> Function(int)>();
}

final class GType {
  final int value;

  const GType(this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GType &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  static bool isA(GType type, GType isAType) =>
    type == isAType || gobject._gTypeIsA(type.value, isAType.value);

  @override
  String toString() {
    return 'GType($name)';
  }

  String get name => gobject._gTypeName(value).toDartString();
}

GObjectLibraryAdapter? _gobject;
GObjectLibraryAdapter get gobject => _gobject ??= GObjectLibraryAdapter();

final class _GTypeClass extends ffi.Struct {
  @ffi.UnsignedLong()
  external int gType;
}

final class _GData extends ffi.Opaque {}

final class _GTypeInstance extends ffi.Struct {
  external ffi.Pointer<_GTypeClass> gClass;
}

final class _GObject extends ffi.Struct {
  external _GTypeInstance gTypeInstance;

  @ffi.UnsignedInt()
  external int refCount;

  external ffi.Pointer<_GData> qdata;
}

final class DisposableState {
  bool disposed = false;
}

final class _GObjectWeakRef {
  final WeakReference<GObject> object;
  final ffi.Pointer<_GObject> pointer;
  GObject? strongReference;
  bool isRef;
  final bool isStatic;

  _GObjectWeakRef(GObject object, this.pointer, {this.isRef = true}) : isStatic = false, object = WeakReference(object);

  _GObjectWeakRef.strong(GObject object, this.pointer, {this.isRef = true, this.isStatic = false}) : strongReference = object, object = WeakReference(object);

  void makeStrong() {
    if (strongReference != null) {
      return;
    }
    strongReference = object.target;
  }

  void makeWeak() {
    if (isStatic) {
      return;
    }

    strongReference = null;
  }

  bool get isAlive => object.target != null;

  bool get isDead => !isAlive;

  bool get isStrong => strongReference != null;

  bool get isWeak => !isStrong;
}

enum ReferenceType {
  // a [staticLifeSpan] reference is one that is a global that will never be
  // destroyed.
  staticLifespan,

  // a [containedLifespan] reference is one that is contained within another
  // object, and will be destroyed when that object is destroyed.
  containedLifespan,

  // a [floating] reference is one that is not owned by any other object, and
  // must be sunk in order to be kept alive.
  floating,

  // an [owned] reference is one where a reference is owned by the caller,
  // and must be unrefed by the caller, in this case during garbage collection.
  owned,

  // an [unowned] reference is one where a reference is owned by the callee.
  // The caller must [ref] the object if they want to keep it alive.
  unowned,
}

class GObjectTypeBuilder {
  final int gType;
  final bool useDispose;
  final GObject Function(ffi.Pointer<ffi.Void> ptr, [ReferenceType? refType, Object? container]) fromPointer;

  GObjectTypeBuilder({required this.gType, required this.fromPointer, this.useDispose = false});
}

class GObjectTypeModule {
  final Iterable<GObjectTypeModule> depends;
  final Iterable<GObjectTypeBuilder> builders;

  GObjectTypeModule({Iterable<GObjectTypeModule>? depends, required this.builders}) : depends = depends ?? <GObjectTypeModule>[];
}

/// This is the implementation of the `GObject` class for use in the `gir-bootstrapper`
/// library. Please note that it is not quite complete, because it doesn't implement the
/// full `g_object_add_toggle_ref`/`g_object_remove_toggle_ref` functionality.
/// which is needed when passing dart callbacks / handles to the C side.
class GObject implements ffi.Finalizable {
  static final Map<int, _GObjectWeakRef> _instancesByPointer = <int, _GObjectWeakRef>{};
  static final Set<GObjectTypeModule> _modules = <GObjectTypeModule>{};
  static final Map<int, GObjectTypeBuilder> _registeredTypes = <int, GObjectTypeBuilder>{};
  static final GObjectTypeBuilder _defaultTypeBuilder = GObjectTypeBuilder(
    gType: gobject._gObjectGetType(),
    fromPointer: (ffi.Pointer<ffi.Void> ptr, [ReferenceType? refType, Object? container]) {
      refType ??= ReferenceType.owned;
      return refType == ReferenceType.owned
          ? GObject.$fromOwnedRef(ptr)
          : refType == ReferenceType.floating
              ? GObject.$fromFloatingRef(ptr)
              : refType == ReferenceType.containedLifespan
                  ? GObject.$fromOwnedRef(ptr, container)
                  : refType == ReferenceType.staticLifespan
                      ? GObject.$fromStaticLifespanRef(ptr)
                      : throw ArgumentError.value(refType, 'refType', 'Invalid value');

    },
  );

  static void registerType(GObjectTypeBuilder builder) {
    _registeredTypes[builder.gType] = builder;
  }

  static void registerModule(GObjectTypeModule module) {
    if (_modules.contains(module)) {
      return;
    }

    _modules.add(module);
    for (final builder in module.builders) {
      registerType(builder);
    }
  }

  static final Finalizer<ffi.Pointer<ffi.Void>> _finalizer = Finalizer<ffi.Pointer<ffi.Void>>(_finalize);

  // when the last instance
  static void _finalize(ffi.Pointer<ffi.Void> self) {
    final _GObjectWeakRef? instance = _instancesByPointer[self.address];
    if (instance == null) {
      print('Finalized GObject that was not registered');
      return;
    }
    
    if (instance.isRef) {
      gobject._gObjectUnref(self);
      instance.isRef = false;
    }

    _instancesByPointer.remove(self.address);
  }

  static final Finalizer<DisposableState> _disposerCheckFinalizer = Finalizer<DisposableState>(_finalizeDisposableState);

  static void _finalizeDisposableState(DisposableState self) {
    if (self.disposed) return;
    print('Object was not disposed before being finalized');
  }

  final ffi.Pointer<ffi.Void> $ptr;
  final Object? _owner;
  final DisposableState? _disposerState;

  static GType? _initiallyUnownedType;
  static GType get initiallyUnownedType => _initiallyUnownedType ??= GType(gobject._gInitiallyUnownedGetType());
  static GType? _objectType;
  static final GType objectType = _objectType ??= GType(gobject._gObjectGetType());

  // Creates the object from a pointer, given a reference to the, which is either:
  //   * owned by the caller,
  //   * owned by the owner object (in which case
  GObject.$fromOwnedRef(this.$ptr, [this._owner]) : _disposerState = null  {
    _finalizer.attach(this, $ptr.cast<ffi.Void>());
    _instancesByPointer[$ptr.address] = _GObjectWeakRef(this, $ptr.cast<_GObject>(), isRef: _owner == null);
  }

  // Create the BASE class, given a reference to the GObject, which is known never
  // to be freed.
  GObject.$fromStaticLifespanRef(this.$ptr)  : _disposerState = null, _owner = null {
    _instancesByPointer[$ptr.address] = _GObjectWeakRef.strong(this, $ptr.cast<_GObject>(), isRef: false, isStatic: true);
  }

  GObject.$fromFloatingRef(this.$ptr) : _owner = null, _disposerState = null {
    var ptr = $ptr.cast<_GObject>();
    if (gobject._gTypeIsA(ptr.ref.gTypeInstance.gClass.ref.gType, initiallyUnownedType.value)) {
      ptr = gobject._gObjectRefSink(ptr.cast<ffi.Void>()).cast<_GObject>();
    }

    _instancesByPointer[$ptr.address] = _GObjectWeakRef(this, $ptr.cast<_GObject>());
    _finalizer.attach(this, $ptr.cast<ffi.Void>());
  }


  GObject.$fromDisposableRef(this.$ptr) : _owner = null, _disposerState = DisposableState() {
    _disposerCheckFinalizer.attach(this, _disposerState!, detach: this);
    _instancesByPointer[$ptr.address] = _GObjectWeakRef(this, $ptr.cast<_GObject>());
  }

  static GObject? $create(ffi.Pointer<ffi.Void> ptr, [ReferenceType? refType, Object? container]) {
    if (ptr == ffi.nullptr) {
      return null;
    }

    final ref = _instancesByPointer[ptr.address];
    if (ref != null && ref.isAlive) {
      if (refType == ReferenceType.owned) {
        gobject._gObjectUnref(ptr);
      }

      return ref.object.target;
    }

    _instancesByPointer.remove(ptr.address);
    refType ??= ReferenceType.owned;
    if (refType == ReferenceType.unowned) {
      ptr = gobject._gObjectRef(ptr);
      refType = ReferenceType.owned;
    }

    var gType = ptr.cast<_GObject>().ref.gTypeInstance.gClass.ref.gType;
    var builder = _registeredTypes[gType];
    while (builder == null) {
      gType = gobject._gTypeParent(gType);
      if (gType == 0) {
        builder = _defaultTypeBuilder;
        break;
      }

      builder = _registeredTypes[gType];
    }

    return builder.fromPointer(ptr, refType, container);
  }

  void dispose() {
    final disposable = _disposerState;
    if (disposable == null) {
      throw StateError('Object is not disposable');
    }
    if (disposable.disposed) {
      throw StateError('Object is already disposed');
    }

    disposable.disposed = true;
    _disposerCheckFinalizer.detach(this);
    gobject._gObjectUnref($ptr);
  }

  void checkDisposed() {
    if (_disposerState?.disposed ?? false) {
      throw StateError('Object is already disposed');
    }
  }

  GType get type => GType($ptr.cast<_GObject>().ref.gTypeInstance.gClass.ref.gType);

  @override
  bool operator ==(Object other) {
    if (other is GObject) {
      return identical(this, other) || $ptr.address == other.$ptr.address;
    }

    return false;
  }

  @override
  int get hashCode => $ptr.address.hashCode;

  @override
  String toString() => '${type.name} at address=0x${$ptr.address.toRadixString(16)}';
}

