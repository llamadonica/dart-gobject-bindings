import 'dart:collection';
import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart' as ffi;
import 'dart:io' show Platform;

import '../discovery/discovery.dart';
import '../glib/ffi.dart';
import '../gobject/ffi.dart';

final class GObjectIntrospectionLibraryDepends {
  final GLibLibraryAdapter glib;
  final GObjectLibraryAdapter gobject;

  GObjectIntrospectionLibraryDepends(
      {required this.glib, required this.gobject});
}

final class GObjectIntrospectionLibraryAdapter {
  final ffi.DynamicLibrary _gobjectIntrospection;
  final GObjectIntrospectionLibraryDepends depends;
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  GObjectIntrospectionLibraryAdapter()
      : this._(
            ffi.DynamicLibrary.open(
                libraryFinder.findLibrary('girepository-1.0')),
            GObjectIntrospectionLibraryDepends(glib: glib, gobject: gobject));

  GObjectIntrospectionLibraryAdapter._(this._gobjectIntrospection, this.depends)
      : _lookup = _gobjectIntrospection.lookup,
        _gIRepositoryGetTypePtr = _gobjectIntrospection
            .lookup<ffi.NativeFunction<ffi.UnsignedLong Function()>>(
                'g_irepository_get_type'),
        _gIRepositoryGetDefaultPtr = _gobjectIntrospection
            .lookup<ffi.NativeFunction<ffi.Pointer<ffi.Void> Function()>>(
                'g_irepository_get_default');

  final ffi.Pointer<ffi.NativeFunction<ffi.UnsignedLong Function()>>
      _gIRepositoryGetTypePtr;
  int Function() get _gIRepositoryGetType =>
      _gIRepositoryGetTypePtr.asFunction<int Function()>();
  final ffi.Pointer<ffi.NativeFunction<ffi.Pointer<ffi.Void> Function()>>
      _gIRepositoryGetDefaultPtr;
  ffi.Pointer<ffi.Void> Function() get _gIRepositoryGetDefault =>
      _gIRepositoryGetDefaultPtr.asFunction<ffi.Pointer<ffi.Void> Function()>();

  late final _getMajorVersionPtr =
      _lookup<ffi.NativeFunction<ffi.UnsignedInt Function()>>(
          'gi_get_major_version');
  late final _getMajorVersion =
      _getMajorVersionPtr.asFunction<int Function()>();

  late final _getMicroVersionPtr =
      _lookup<ffi.NativeFunction<ffi.UnsignedInt Function()>>(
          'gi_get_micro_version');
  late final _getMicroVersion =
      _getMicroVersionPtr.asFunction<int Function()>();

  late final _getMinorVersionPtr =
      _lookup<ffi.NativeFunction<ffi.UnsignedInt Function()>>(
          'gi_get_minor_version');
  late final _getMinorVersion =
      _getMinorVersionPtr.asFunction<int Function()>();

  late final _irepositoryDumpPtr = _lookup<
      ffi.NativeFunction<
          ffi.Int Function(ffi.Pointer<ffi.Char>,
              ffi.Pointer<ffi.Pointer<ffi.Void>>)>>('g_irepository_dump');

  late final _irepositoryDump = _irepositoryDumpPtr.asFunction<
      int Function(
          ffi.Pointer<ffi.Char>, ffi.Pointer<ffi.Pointer<ffi.Void>>)>();

  late final _irepositoryEnumerateVersionsPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<_GList> Function(ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Char>)>>('g_irepository_enumerateVersions');
  late final _irepositoryEnumerateVersions =
      _irepositoryEnumerateVersionsPtr.asFunction<
          ffi.Pointer<_GList> Function(
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Char>)>();

  late final _irepositoryErrorQuarkPtr =
      _lookup<ffi.NativeFunction<ffi.UnsignedInt Function()>>(
          'g_irepository_error_quark');
  late final _irepositoryErrorQuark =
      _irepositoryErrorQuarkPtr.asFunction<int Function()>();

  late final _irepositoryFindByError_domainPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>,
              ffi.UnsignedInt)>>('g_irepository_find_by_error_domain');
  late final _irepositoryFindByError_domain =
      _irepositoryFindByError_domainPtr.asFunction<
          ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>, int)>();


  late final _irepositoryFindByGtypePtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>,
              ffi.UnsignedLong)>>('g_irepository_find_by_gtype');
  late final _irepositoryFindByGtype = _irepositoryFindByGtypePtr
      .asFunction<ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>, int)>();


  late final _irepositoryFindByNamePtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Char>,
              ffi.Pointer<ffi.Char>)>>('g_irepository_find_by_name');
  late final _irepositoryFindByName =
      _irepositoryFindByNamePtr.asFunction<
          ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Char>, ffi.Pointer<ffi.Char>)>();


  late final _irepositoryGetCPrefixPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Char>)>>('g_irepository_get_c_prefix');
  late final _irepositoryGetCPrefix =
      _irepositoryGetCPrefixPtr.asFunction<
          ffi.Pointer<ffi.Char> Function(
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Char>)>();

  late final _irepositoryGetDependenciesPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Pointer<ffi.Char>> Function(ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Char>)>>('g_irepository_get_dependencies');
  late final _irepositoryGetDependencies =
      _irepositoryGetDependenciesPtr.asFunction<
          ffi.Pointer<ffi.Pointer<ffi.Char>> Function(
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Char>)>();

  late final _irepositoryGetImmediateDependenciesPtr = _lookup<
          ffi.NativeFunction<
              ffi.Pointer<ffi.Pointer<ffi.Char>> Function(
                  ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Char>)>>(
      'g_irepository_get_immediate_dependencies');
  late final _irepositoryGetImmediateDependencies =
      _irepositoryGetImmediateDependenciesPtr.asFunction<
          ffi.Pointer<ffi.Pointer<ffi.Char>> Function(
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Char>)>();


  late final _irepositoryGetInfoPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Char>, ffi.Int)>>('g_irepository_get_info');
  late final _irepositoryGetInfo = _irepositoryGetInfoPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(
          ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Char>, int)>();


  late final _irepositoryGetLoadedNamespacesPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Pointer<ffi.Char>> Function(
              ffi.Pointer<ffi.Void>)>>('g_irepository_get_loaded_namespaces');
  late final _irepositoryGetLoadedNamespaces =
      _irepositoryGetLoadedNamespacesPtr.asFunction<
          ffi.Pointer<ffi.Pointer<ffi.Char>> Function(ffi.Pointer<ffi.Void>)>();


  late final _irepositoryGetNInfosPtr = _lookup<
      ffi.NativeFunction<
          ffi.Int Function(ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Char>)>>('g_irepository_get_n_infos');
  late final _irepositoryGetNInfos = _irepositoryGetNInfosPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Char>)>();


  late final _irepositoryGetObjectGtype_interfacesPtr = _lookup<
          ffi.NativeFunction<
              ffi.Void Function(
                  ffi.Pointer<ffi.Void>,
                  ffi.UnsignedLong,
                  ffi.Pointer<ffi.UnsignedInt>,
                  ffi.Pointer<ffi.Pointer<ffi.Pointer<ffi.Void>>>)>>(
      'g_irepository_get_object_gtype_interfaces');
  late final _irepositoryGetObjectGtype_interfaces =
      _irepositoryGetObjectGtype_interfacesPtr.asFunction<
          void Function(
              ffi.Pointer<ffi.Void>,
              int,
              ffi.Pointer<ffi.UnsignedInt>,
              ffi.Pointer<ffi.Pointer<ffi.Pointer<ffi.Void>>>)>();


  late final _irepositoryGetOptionGroupPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<ffi.Void> Function()>>(
          'g_irepository_get_option_group');
  late final _irepositoryGetOptionGroup = _irepositoryGetOptionGroupPtr
      .asFunction<ffi.Pointer<ffi.Void> Function()>();

  late final _irepositoryGetSearchPathPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<ffi.Void> Function()>>(
          'g_irepository_get_search_path');
  late final _irepositoryGetSearchPath = _irepositoryGetSearchPathPtr
      .asFunction<ffi.Pointer<ffi.Void> Function()>();


  late final _irepositoryGetSharedLibraryPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Char>)>>('g_irepository_get_shared_library');
  late final _irepositoryGetSharedLibrary =
      _irepositoryGetSharedLibraryPtr.asFunction<
          ffi.Pointer<ffi.Char> Function(
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Char>)>();

  late final _irepositoryGetTypelibPathPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Char>)>>('g_irepository_get_typelibPath');
  late final _irepositoryGetTypelibPath =
      _irepositoryGetTypelibPathPtr.asFunction<
          ffi.Pointer<ffi.Char> Function(
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Char>)>();

  late final _irepositoryGetVersionPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Char>)>>('g_irepository_get_version');
  late final _irepositoryGetVersion = _irepositoryGetVersionPtr.asFunction<
      ffi.Pointer<ffi.Char> Function(
          ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Char>)>();

  late final _irepositoryIsRegisteredPtr = _lookup<
      ffi.NativeFunction<
          ffi.Int Function(ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Char>,
              ffi.Pointer<ffi.Char>)>>('g_irepository_is_registered');
  late final _irepositoryIsRegistered =
      _irepositoryIsRegisteredPtr.asFunction<
          int Function(ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Char>,
              ffi.Pointer<ffi.Char>)>();

  late final _irepositoryLoadTypelibPtr = _lookup<
          ffi.NativeFunction<
              ffi.Pointer<ffi.Char> Function(
                  ffi.Pointer<ffi.Void>,
                  ffi.Pointer<ffi.Void>,
                  ffi.Int32,
                  ffi.Pointer<ffi.Pointer<ffi.Void>>)>>(
      'g_irepository_load_typelib');
  late final _irepositoryLoadTypelib =
      _irepositoryLoadTypelibPtr.asFunction<
          ffi.Pointer<ffi.Char> Function(
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              int,
              ffi.Pointer<ffi.Pointer<ffi.Void>>)>();

  late final _irepositoryPrependLibraryPathPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Char>)>>(
          'g_irepository_prepend_library_path');
  late final _irepositoryPrependLibraryPath =
      _irepositoryPrependLibraryPathPtr
          .asFunction<void Function(ffi.Pointer<ffi.Char>)>();

  late final _irepositoryPrependSearchPathPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Char>)>>(
          'g_irepository_prepend_search_path');
  late final _irepositoryPrependSearchPath =
      _irepositoryPrependSearchPathPtr
          .asFunction<void Function(ffi.Pointer<ffi.Char>)>();

  late final _irepositoryRequirePtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Char>,
              ffi.Pointer<ffi.Char>,
              ffi.Int32,
              ffi.Pointer<ffi.Pointer<ffi.Void>>)>>('g_irepository_require');
  late final _irepositoryRequire = _irepositoryRequirePtr.asFunction<
      ffi.Pointer<ffi.Void> Function(
          ffi.Pointer<ffi.Void>,
          ffi.Pointer<ffi.Char>,
          ffi.Pointer<ffi.Char>,
          int,
          ffi.Pointer<ffi.Pointer<ffi.Void>>)>();

  late final _irepositoryRequirePrivatePtr = _lookup<
          ffi.NativeFunction<
              ffi.Pointer<ffi.Void> Function(
                  ffi.Pointer<ffi.Void>,
                  ffi.Pointer<ffi.Char>,
                  ffi.Pointer<ffi.Char>,
                  ffi.Pointer<ffi.Char>,
                  ffi.Int32,
                  ffi.Pointer<ffi.Pointer<ffi.Void>>)>>(
      'g_irepository_require_private');
  late final _irepositoryRequirePrivate =
      _irepositoryRequirePrivatePtr.asFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Char>,
              ffi.Pointer<ffi.Char>,
              ffi.Pointer<ffi.Char>,
              int,
              ffi.Pointer<ffi.Pointer<ffi.Void>>)>();

  late final _baseInfoEqualPtr = _lookup<
      ffi.NativeFunction<
          ffi.Int Function(ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>)>>('g_base_info_equal');
  late final _baseInfoEqual = _baseInfoEqualPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  late final _baseInfoGetAttributePtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Char>)>>('g_base_info_get_attribute');
  late final _baseInfoGetAttribute = _baseInfoGetAttributePtr.asFunction<
      ffi.Pointer<ffi.Char> Function(
          ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Char>)>();

  late final _baseInfoGetContainerPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>)>>('g_base_info_get_container');
  late final _baseInfoGetContainer = _baseInfoGetContainerPtr
      .asFunction<ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>)>();

  late final _baseInfoGetNamePtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Char> Function(
              ffi.Pointer<ffi.Void>)>>('g_base_info_get_name');
  late final _baseInfoGetName = _baseInfoGetNamePtr
      .asFunction<ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.Void>)>();

  late final _baseInfoGetNamespacePtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Char> Function(
              ffi.Pointer<ffi.Void>)>>('g_base_info_get_namespace');
  late final _baseInfoGetNamespace = _baseInfoGetNamespacePtr
      .asFunction<ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.Void>)>();

  late final _baseInfoGetTypePtr =
  _lookup<ffi.NativeFunction<ffi.Int32 Function(ffi.Pointer<ffi.Void>)>>(
      'g_base_info_get_type');
  late final _baseInfoGetType =
  _baseInfoGetTypePtr.asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _baseInfoGetTypelibPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>)>>('g_base_info_get_typelib');
  late final _baseInfoGetTypelib = _baseInfoGetTypelibPtr
      .asFunction<ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>)>();

  late final _baseInfoGtypeGetTypePtr =
  _lookup<ffi.NativeFunction<ffi.UnsignedLong Function()>>(
      'g_base_info_gtype_get_type');
  late final _baseInfoGtypeGetType =
  _baseInfoGtypeGetTypePtr.asFunction<int Function()>();

  late final _baseInfoIsDeprecatedPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_base_info_is_deprecated');
  late final _baseInfoIsDeprecated = _baseInfoIsDeprecatedPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _baseInfoIterateAttributesPtr = _lookup<
      ffi.NativeFunction<
          ffi.Int Function(
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<_AttributeIter>,
              ffi.Pointer<ffi.Pointer<ffi.Char>>,
              ffi.Pointer<ffi.Pointer<ffi.Char>>)>>(
      'g_base_info_iterate_attributes');
  late final _baseInfoIterateAttributes =
  _baseInfoIterateAttributesPtr.asFunction<
      int Function(
          ffi.Pointer<ffi.Void>,
          ffi.Pointer<_AttributeIter>,
          ffi.Pointer<ffi.Pointer<ffi.Char>>,
          ffi.Pointer<ffi.Pointer<ffi.Char>>)>();

  late final _baseInfoRefPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>)>>('g_base_info_ref');
  late final _baseInfoRef = _baseInfoRefPtr
      .asFunction<ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>)>();

  late final _baseInfoUnrefPtr =
  _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Void>)>>(
      'g_base_info_unref');
  late final _baseInfoUnref =
  _baseInfoUnrefPtr.asFunction<void Function(ffi.Pointer<ffi.Void>)>();

  late final _typelibGetNamespacePtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Char> Function(
              ffi.Pointer<ffi.Void>)>>('g_typelib_get_namespace');
  late final _typelibGetNamespace = _typelibGetNamespacePtr
      .asFunction<ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.Void>)>();

  late final _functionInfoGetFlagsPtr = _lookup<
      ffi.NativeFunction<ffi.Int32 Function(ffi.Pointer<ffi.Void>)>>(
      'g_function_info_get_flags');
  late final _functionInfoGetFlags = _functionInfoGetFlagsPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _functionInfoGetPropertyPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>)>>('g_function_info_get_property');
  late final _functionInfoGetProperty =
  _functionInfoGetPropertyPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>)>();

  late final _functionInfoGetSymbolPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Char> Function(
              ffi.Pointer<ffi.Void>)>>('g_function_info_get_symbol');
  late final _functionInfoGetSymbol = _functionInfoGetSymbolPtr
      .asFunction<ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.Void>)>();


  late final _functionInfoGetVfuncPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>)>>('g_function_info_get_vfunc');
  late final _functionInfoGetVfunc = _functionInfoGetVfuncPtr
      .asFunction<ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>)>();

  late final _callableInfoCanThrowGerrorPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_callable_info_can_throw_gerror');
  late final _callableInfoCanThrowGerror =
  _callableInfoCanThrowGerrorPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _callableInfoGetArgPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>, ffi.Int)>>('g_callable_info_get_arg');
  late final _callableInfoGetArg = _callableInfoGetArgPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>, int)>();

  late final _callableInfoGetCallerOwnsPtr = _lookup<
      ffi.NativeFunction<ffi.Int32 Function(ffi.Pointer<ffi.Void>)>>(
      'g_callable_info_get_caller_owns');
  late final _callableInfoGetCallerOwns = _callableInfoGetCallerOwnsPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _callableInfoGetInstanceOwnership_transferPtr = _lookup<
      ffi.NativeFunction<ffi.Int32 Function(ffi.Pointer<ffi.Void>)>>(
      'g_callable_info_get_instance_ownership_transfer');
  late final _callableInfoGetInstanceOwnership_transfer =
  _callableInfoGetInstanceOwnership_transferPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _callableInfoGetNArgsPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_callable_info_get_n_args');
  late final _callableInfoGetNArgs = _callableInfoGetNArgsPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _callableInfoGetReturnAttributePtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Char>)>>('g_callable_info_get_return_attribute');
  late final _callableInfoGetReturnAttribute =
  _callableInfoGetReturnAttributePtr.asFunction<
      ffi.Pointer<ffi.Char> Function(
          ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Char>)>();

  late final _callableInfoGetReturnTypePtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>)>>('g_callable_info_get_return_type');
  late final _callableInfoGetReturnType = _callableInfoGetReturnTypePtr
      .asFunction<ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>)>();

  late final _callableInfoInvokePtr = _lookup<
      ffi.NativeFunction<
          ffi.Int Function(
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<_GIArgument>,
              ffi.Int,
              ffi.Pointer<_GIArgument>,
              ffi.Int,
              ffi.Pointer<_GIArgument>,
              ffi.Int,
              ffi.Int,
              ffi.Pointer<ffi.Pointer<ffi.Void>>)>>('g_callable_info_invoke');
  late final _callableInfoInvoke = _callableInfoInvokePtr.asFunction<
      int Function(
          ffi.Pointer<ffi.Void>,
          ffi.Pointer<ffi.Void>,
          ffi.Pointer<_GIArgument>,
          int,
          ffi.Pointer<_GIArgument>,
          int,
          ffi.Pointer<_GIArgument>,
          int,
          int,
          ffi.Pointer<ffi.Pointer<ffi.Void>>)>();

  late final _callableInfoIsMethodPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_callable_info_is_method');
  late final _callableInfoIsMethod = _callableInfoIsMethodPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _callableInfoIterateReturnAttributesPtr = _lookup<
      ffi.NativeFunction<
          ffi.Int Function(
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<_AttributeIter>,
              ffi.Pointer<ffi.Pointer<ffi.Char>>,
              ffi.Pointer<ffi.Pointer<ffi.Char>>)>>(
      'g_callable_info_iterate_return_attributes');
  late final _callableInfoIterateReturnAttributes =
  _callableInfoIterateReturnAttributesPtr.asFunction<
      int Function(
          ffi.Pointer<ffi.Void>,
          ffi.Pointer<_AttributeIter>,
          ffi.Pointer<ffi.Pointer<ffi.Char>>,
          ffi.Pointer<ffi.Pointer<ffi.Char>>)>();

  late final _callableInfoLoadArgPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Pointer<ffi.Void>, ffi.Int,
              ffi.Pointer<ffi.Void>)>>('g_callable_info_load_arg');
  late final _callableInfoLoadArg = _callableInfoLoadArgPtr.asFunction<
      void Function(ffi.Pointer<ffi.Void>, int, ffi.Pointer<ffi.Void>)>();

  late final _callableInfoLoadReturnTypePtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>)>>('g_callable_info_load_return_type');
  late final _callableInfoLoadReturnType =
  _callableInfoLoadReturnTypePtr.asFunction<
      void Function(ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  late final _callableInfoMayReturnNullPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_callable_info_may_return_null');
  late final _callableInfoMayReturnNull = _callableInfoMayReturnNullPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _callableInfoSkipReturnPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_callable_info_skip_return');
  late final _callableInfoSkipReturn = _callableInfoSkipReturnPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _enumInfoGetErrorDomainPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Char> Function(
              ffi.Pointer<ffi.Void>)>>('g_enum_info_get_error_domain');
  late final _enumInfoGetErrorDomain = _enumInfoGetErrorDomainPtr
      .asFunction<ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.Void>)>();

  late final _enumInfoGetMethodPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>, ffi.Int)>>('g_enum_info_get_method');
  late final _enumInfoGetMethod = _enumInfoGetMethodPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>, int)>();

  late final _enumInfoGetNMethodsPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_enum_info_get_n_methods');
  late final _enumInfoGetNMethods = _enumInfoGetNMethodsPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _enumInfoGetNValuesPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_enum_info_get_n_values');
  late final _enumInfoGetNValues = _enumInfoGetNValuesPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _enumInfoGetStorageTypePtr =
  _lookup<ffi.NativeFunction<ffi.Int32 Function(ffi.Pointer<ffi.Void>)>>(
      'g_enum_info_get_storage_type');
  late final _enumInfoGetStorageType = _enumInfoGetStorageTypePtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _enumInfoGetValuePtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>, ffi.Int)>>('g_enum_info_get_value');
  late final _enumInfoGetValue = _enumInfoGetValuePtr.asFunction<
      ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>, int)>();
  
  late final _structInfoFindFieldPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Char>)>>('g_struct_info_find_field');
  late final _structInfoFindField = _structInfoFindFieldPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(
          ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Char>)>();

  late final _structInfoFindMethodPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Char>)>>('g_struct_info_find_method');
  late final _structInfoFindMethod = _structInfoFindMethodPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(
          ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Char>)>();

  late final _structInfoGetAlignmentPtr = _lookup<
      ffi
          .NativeFunction<ffi.UnsignedLong Function(ffi.Pointer<ffi.Void>)>>(
      'g_struct_info_get_alignment');
  late final _structInfoGetAlignment = _structInfoGetAlignmentPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _structInfoGetCopyFunctionPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Char> Function(
              ffi.Pointer<ffi.Void>)>>('g_struct_info_get_copy_function');
  late final _structInfoGetCopyFunction = _structInfoGetCopyFunctionPtr
      .asFunction<ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.Void>)>();

  late final _structInfoGetFieldPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>, ffi.Int)>>('g_struct_info_get_field');
  late final _structInfoGetField = _structInfoGetFieldPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>, int)>();

  late final _structInfoGetFreeFunctionPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Char> Function(
              ffi.Pointer<ffi.Void>)>>('g_struct_info_get_free_function');
  late final _structInfoGetFreeFunction = _structInfoGetFreeFunctionPtr
      .asFunction<ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.Void>)>();

  late final _structInfoGetMethodPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>, ffi.Int)>>('g_struct_info_get_method');
  late final _structInfoGetMethod = _structInfoGetMethodPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>, int)>();
  
  late final _structInfoGetNFieldsPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_struct_info_get_n_fields');
  late final _structInfoGetNFields = _structInfoGetNFieldsPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();
  
  late final _structInfoGetNMethodsPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_struct_info_get_n_methods');
  late final _structInfoGetNMethods = _structInfoGetNMethodsPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _structInfoGetSizePtr = _lookup<
      ffi
          .NativeFunction<ffi.UnsignedLong Function(ffi.Pointer<ffi.Void>)>>(
      'g_struct_info_get_size');
  late final _structInfoGetSize = _structInfoGetSizePtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _structInfoIsForeignPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_struct_info_is_foreign');
  late final _structInfoIsForeign = _structInfoIsForeignPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _structInfoIsGtypeStructPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_struct_info_is_gtype_struct');
  late final _structInfoIsGtypeStruct = _structInfoIsGtypeStructPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _objectInfoFindMethodPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Char>)>>('g_object_info_find_method');
  late final _objectInfoFindMethod = _objectInfoFindMethodPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(
          ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Char>)>();

  late final _objectInfoFindMethodUsingInterfacesPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Char>,
              ffi.Pointer<ffi.Pointer<ffi.Void>>)>>(
      'g_object_info_find_method_using_interfaces');
  late final _objectInfoFindMethodUsingInterfaces =
  _objectInfoFindMethodUsingInterfacesPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>,
          ffi.Pointer<ffi.Char>, ffi.Pointer<ffi.Pointer<ffi.Void>>)>();

  late final _objectInfoFindSignalPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Char>)>>('g_object_info_find_signal');
  late final _objectInfoFindSignal = _objectInfoFindSignalPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(
          ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Char>)>();

  late final _objectInfoFindVfuncPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Char>)>>('g_object_info_find_vfunc');
  late final _objectInfoFindVfunc = _objectInfoFindVfuncPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(
          ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Char>)>();

  late final _objectInfoFindVfuncUsingInterfacesPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Char>,
              ffi.Pointer<ffi.Pointer<ffi.Void>>)>>(
      'g_object_info_find_vfunc_using_interfaces');
  late final _objectInfoFindVfuncUsingInterfaces =
  _objectInfoFindVfuncUsingInterfacesPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>,
          ffi.Pointer<ffi.Char>, ffi.Pointer<ffi.Pointer<ffi.Void>>)>();

  late final _objectInfoGetAbstractPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_object_info_get_abstract');
  late final _objectInfoGetAbstract = _objectInfoGetAbstractPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _objectInfoGetClassStructPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>)>>('g_object_info_get_class_struct');
  late final _objectInfoGetClassStruct = _objectInfoGetClassStructPtr
      .asFunction<ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>)>();

  late final _objectInfoGetConstantPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>, ffi.Int)>>('g_object_info_get_constant');
  late final _objectInfoGetConstant =
  _objectInfoGetConstantPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>, int)>();

  late final _objectInfoGetFieldPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>, ffi.Int)>>('g_object_info_get_field');
  late final _objectInfoGetField = _objectInfoGetFieldPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>, int)>();

  late final _objectInfoGetFinalPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_object_info_get_final');
  late final _objectInfoGetFinal = _objectInfoGetFinalPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _objectInfoGetFundamentalPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_object_info_get_fundamental');
  late final _objectInfoGetFundamental = _objectInfoGetFundamentalPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _objectInfoGetGetValueFunctionPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.Void>)>>(
      'g_object_info_get_get_value_function');
  late final _objectInfoGetGetValueFunction =
  _objectInfoGetGetValueFunctionPtr.asFunction<
      ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.Void>)>();

  late final _objectInfoGetInterfacePtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>,
              ffi.Int)>>('g_object_info_get_interface');
  late final _objectInfoGetInterface =
  _objectInfoGetInterfacePtr.asFunction<
      ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>, int)>();

  late final _objectInfoGetMethodPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>, ffi.Int)>>('g_object_info_get_method');
  late final _objectInfoGetMethod = _objectInfoGetMethodPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>, int)>();

  late final _objectInfoGetNConstantsPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_object_info_get_n_constants');
  late final _objectInfoGetNConstants = _objectInfoGetNConstantsPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _objectInfoGetNFieldsPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_object_info_get_n_fields');
  late final _objectInfoGetNFields = _objectInfoGetNFieldsPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _objectInfoGetNInterfacesPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_object_info_get_n_interfaces');
  late final _objectInfoGetNInterfaces = _objectInfoGetNInterfacesPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _objectInfoGetNMethodsPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_object_info_get_n_methods');
  late final _objectInfoGetNMethods = _objectInfoGetNMethodsPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _objectInfoGetNPropertiesPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_object_info_get_n_properties');
  late final _objectInfoGetNProperties = _objectInfoGetNPropertiesPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _objectInfoGetNSignalsPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_object_info_get_n_signals');
  late final _objectInfoGetNSignals = _objectInfoGetNSignalsPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _objectInfoGetNVfuncsPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_object_info_get_n_vfuncs');
  late final _objectInfoGetNVfuncs = _objectInfoGetNVfuncsPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _objectInfoGetParentPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>)>>('g_object_info_get_parent');
  late final _objectInfoGetParent = _objectInfoGetParentPtr
      .asFunction<ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>)>();

  late final _objectInfoGetPropertyPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>, ffi.Int)>>('g_object_info_get_property');
  late final _objectInfoGetProperty =
  _objectInfoGetPropertyPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>, int)>();

  late final _objectInfoGetRefFunctionPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Char> Function(
              ffi.Pointer<ffi.Void>)>>('g_object_info_get_ref_function');
  late final _objectInfoGetRefFunction = _objectInfoGetRefFunctionPtr
      .asFunction<ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.Void>)>();

  late final _objectInfoGetSetValueFunctionPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.Void>)>>(
      'g_object_info_get_set_value_function');
  late final _objectInfoGetSetValueFunction =
  _objectInfoGetSetValueFunctionPtr.asFunction<
      ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.Void>)>();

  late final _objectInfoGetSignalPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>, ffi.Int)>>('g_object_info_get_signal');
  late final _objectInfoGetSignal = _objectInfoGetSignalPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>, int)>();

  late final _objectInfoGetTypeInitPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Char> Function(
              ffi.Pointer<ffi.Void>)>>('g_object_info_get_type_init');
  late final _objectInfoGetTypeInit = _objectInfoGetTypeInitPtr
      .asFunction<ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.Void>)>();

  late final _objectInfoGetTypeNamePtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Char> Function(
              ffi.Pointer<ffi.Void>)>>('g_object_info_get_type_name');
  late final _objectInfoGetTypeName = _objectInfoGetTypeNamePtr
      .asFunction<ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.Void>)>();

  late final _objectInfoGetUnrefFunctionPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Char> Function(
              ffi.Pointer<ffi.Void>)>>('g_object_info_get_unref_function');
  late final _objectInfoGetUnrefFunction =
  _objectInfoGetUnrefFunctionPtr.asFunction<
      ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.Void>)>();

  late final _objectInfoGetVfuncPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>, ffi.Int)>>('g_object_info_get_vfunc');
  late final _objectInfoGetVfunc = _objectInfoGetVfuncPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>, int)>();

  late final _interfaceInfoFindMethodPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Char>)>>('g_interface_info_find_method');
  late final _interfaceInfoFindMethod =
  _interfaceInfoFindMethodPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(
          ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Char>)>();


  late final _interfaceInfoFindSignalPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Char>)>>('g_interface_info_find_signal');
  late final _interfaceInfoFindSignal =
  _interfaceInfoFindSignalPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(
          ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Char>)>();

  late final _interfaceInfoFindVfuncPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Char>)>>('g_interface_info_find_vfunc');
  late final _interfaceInfoFindVfunc =
  _interfaceInfoFindVfuncPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(
          ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Char>)>();

  late final _interfaceInfoGetConstantPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>,
              ffi.Int)>>('g_interface_info_get_constant');
  late final _interfaceInfoGetConstant =
  _interfaceInfoGetConstantPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(
          ffi.Pointer<ffi.Void>, int)>();
  late final _interfaceInfoGetIfaceStructPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>)>>(
      'g_interface_info_get_iface_struct');
  late final _interfaceInfoGetIfaceStruct =
  _interfaceInfoGetIfaceStructPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>)>();

  late final _interfaceInfoGetMethodPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>,
              ffi.Int)>>('g_interface_info_get_method');
  late final _interfaceInfoGetMethod =
  _interfaceInfoGetMethodPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(
          ffi.Pointer<ffi.Void>, int)>();

  late final _interfaceInfoGetNConstantsPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_interface_info_get_n_constants');
  late final _interfaceInfoGetNConstants =
  _interfaceInfoGetNConstantsPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _interfaceInfoGetNMethodsPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_interface_info_get_n_methods');
  late final _interfaceInfoGetNMethods = _interfaceInfoGetNMethodsPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _interfaceInfoGetNPrerequisitesPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_interface_info_get_n_prerequisites');
  late final _interfaceInfoGetNPrerequisites =
  _interfaceInfoGetNPrerequisitesPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _interfaceInfoGetNPropertiesPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_interface_info_get_n_properties');
  late final _interfaceInfoGetNProperties =
  _interfaceInfoGetNPropertiesPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();


  late final _interfaceInfoGetNSignalsPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_interface_info_get_n_signals');
  late final _interfaceInfoGetNSignals = _interfaceInfoGetNSignalsPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _interfaceInfoGetNVfuncsPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_interface_info_get_n_vfuncs');
  late final _interfaceInfoGetNVfuncs = _interfaceInfoGetNVfuncsPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _interfaceInfoGetPrerequisitePtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>,
              ffi.Int)>>('g_interface_info_get_prerequisite');
  late final _interfaceInfoGetPrerequisite =
  _interfaceInfoGetPrerequisitePtr.asFunction<
      ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>, int)>();

  late final _interfaceInfoGetPropertyPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>,
              ffi.Int)>>('g_interface_info_get_property');
  late final _interfaceInfoGetProperty =
  _interfaceInfoGetPropertyPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(
          ffi.Pointer<ffi.Void>, int)>();

  late final _interfaceInfoGetSignalPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>,
              ffi.Int)>>('g_interface_info_get_signal');
  late final _interfaceInfoGetSignal =
  _interfaceInfoGetSignalPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>, int)>();

  late final _interfaceInfoGetVfuncPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>,
              ffi.Int)>>('g_interface_info_get_vfunc');
  late final _interfaceInfoGetVfunc =
  _interfaceInfoGetVfuncPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>, int)>();

  late final _constantInfoFreeValuePtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Pointer<ffi.Void>,
              ffi.Pointer<_GIArgument>)>>('g_constant_info_free_value');
  late final _constantInfoFreeValue =
  _constantInfoFreeValuePtr.asFunction<
      void Function(ffi.Pointer<ffi.Void>, ffi.Pointer<_GIArgument>)>();

  late final _constantInfoGetTypePtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>)>>('g_constant_info_get_type');
  late final _constantInfoGetType = _constantInfoGetTypePtr
      .asFunction<ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>)>();

  late final _constantInfoGetValuePtr = _lookup<
      ffi.NativeFunction<
          ffi.Int Function(ffi.Pointer<ffi.Void>,
              ffi.Pointer<_GIArgument>)>>('g_constant_info_get_value');
  late final _constantInfoGetValue = _constantInfoGetValuePtr.asFunction<
      int Function(ffi.Pointer<ffi.Void>, ffi.Pointer<_GIArgument>)>();

  late final _unionInfoFindMethodPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Char>)>>('g_union_info_find_method');
  late final _unionInfoFindMethod = _unionInfoFindMethodPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(
          ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Char>)>();

  late final _unionInfoGetAlignmentPtr = _lookup<
      ffi
          .NativeFunction<ffi.UnsignedLong Function(ffi.Pointer<ffi.Void>)>>(
      'g_union_info_get_alignment');
  late final _unionInfoGetAlignment = _unionInfoGetAlignmentPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _unionInfoGetCopyFunctionPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Char> Function(
              ffi.Pointer<ffi.Void>)>>('g_union_info_get_copy_function');
  late final _unionInfoGetCopyFunction = _unionInfoGetCopyFunctionPtr
      .asFunction<ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.Void>)>();

  late final _unionInfoGetDiscriminatorPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>,
              ffi.Int)>>('g_union_info_get_discriminator');
  late final _unionInfoGetDiscriminator =
  _unionInfoGetDiscriminatorPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>, int)>();

  late final _unionInfoGetDiscriminatorOffsetPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_union_info_get_discriminator_offset');
  late final _unionInfoGetDiscriminatorOffset =
  _unionInfoGetDiscriminatorOffsetPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _unionInfoGetDiscriminatorTypePtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>)>>('g_union_info_get_discriminator_type');
  late final _unionInfoGetDiscriminatorType =
  _unionInfoGetDiscriminatorTypePtr
      .asFunction<ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>)>();

  late final _unionInfoGetFieldPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>, ffi.Int)>>('g_union_info_get_field');
  late final _unionInfoGetField = _unionInfoGetFieldPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>, int)>();

  late final _unionInfoGetFreeFunctionPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Char> Function(
              ffi.Pointer<ffi.Void>)>>('g_union_info_get_free_function');
  late final _unionInfoGetFreeFunction = _unionInfoGetFreeFunctionPtr
      .asFunction<ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.Void>)>();
  
  late final _unionInfoGetMethodPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>, ffi.Int)>>('g_union_info_get_method');
  late final _unionInfoGetMethod = _unionInfoGetMethodPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>, int)>();
  
  late final _unionInfoGetNFieldsPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_union_info_get_n_fields');
  late final _unionInfoGetNFields = _unionInfoGetNFieldsPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _unionInfoGetNMethodsPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_union_info_get_n_methods');
  late final _unionInfoGetNMethods = _unionInfoGetNMethodsPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _unionInfoGetSizePtr = _lookup<
      ffi
          .NativeFunction<ffi.UnsignedLong Function(ffi.Pointer<ffi.Void>)>>(
      'g_union_info_get_size');
  late final _unionInfoGetSize = _unionInfoGetSizePtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _unionInfoIsDiscriminatedPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_union_info_is_discriminated');
  late final _unionInfoIsDiscriminated = _unionInfoIsDiscriminatedPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _valueInfoGetValuePtr =
  _lookup<ffi.NativeFunction<ffi.Long Function(ffi.Pointer<ffi.Void>)>>(
      'g_value_info_get_value');
  late final _valueInfoGetValue = _valueInfoGetValuePtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _signalInfoGetClassClosurePtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>)>>('g_signal_info_get_class_closure');
  late final _signalInfoGetClassClosure = _signalInfoGetClassClosurePtr
      .asFunction<ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>)>();

  late final _signalInfoGetFlagsPtr =
  _lookup<ffi.NativeFunction<ffi.Int32 Function(ffi.Pointer<ffi.Void>)>>(
      'g_signal_info_get_flags');
  late final _signalInfoGetFlags = _signalInfoGetFlagsPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _signalInfoTrueStopsEmitPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_signal_info_true_stops_emit');
  late final _signalInfoTrueStopsEmit = _signalInfoTrueStopsEmitPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _vfuncInfoGetAddressPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>,
              ffi.UnsignedLong,
              ffi.Pointer<ffi.Pointer<ffi.Void>>)>>('g_vfunc_info_get_address');
  late final _vfuncInfoGetAddress = _vfuncInfoGetAddressPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(
          ffi.Pointer<ffi.Void>, int, ffi.Pointer<ffi.Pointer<ffi.Void>>)>();

  late final _vfuncInfoGetFlagsPtr =
  _lookup<ffi.NativeFunction<ffi.Int32 Function(ffi.Pointer<ffi.Void>)>>(
      'g_vfunc_info_get_flags');
  late final _vfuncInfoGetFlags = _vfuncInfoGetFlagsPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();


  late final _vfuncInfoGetInvokerPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>)>>('g_vfunc_info_get_invoker');
  late final _vfuncInfoGetInvoker = _vfuncInfoGetInvokerPtr
      .asFunction<ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>)>();

  late final _vfuncInfoGetOffsetPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_vfunc_info_get_offset');
  late final _vfuncInfoGetOffset = _vfuncInfoGetOffsetPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _vfuncInfoGetSignalPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>)>>('g_vfunc_info_get_signal');
  late final _vfuncInfoGetSignal = _vfuncInfoGetSignalPtr
      .asFunction<ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>)>();

  late final _propertyInfoGetFlagsPtr = _lookup<
      ffi.NativeFunction<ffi.Int32 Function(ffi.Pointer<ffi.Void>)>>(
      'g_property_info_get_flags');
  late final _propertyInfoGetFlags = _propertyInfoGetFlagsPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _propertyInfoGetGetterPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>)>>('g_property_info_get_getter');
  late final _propertyInfoGetGetter =
  _propertyInfoGetGetterPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>)>();

  late final _propertyInfoGetOwnershipTransferPtr = _lookup<
      ffi.NativeFunction<ffi.Int32 Function(ffi.Pointer<ffi.Void>)>>(
      'g_property_info_get_ownership_transfer');
  late final _propertyInfoGetOwnershipTransfer =
  _propertyInfoGetOwnershipTransferPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _propertyInfoGetSetterPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>)>>('g_property_info_get_setter');
  late final _propertyInfoGetSetter =
  _propertyInfoGetSetterPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>)>();

  late final _propertyInfoGetTypePtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>)>>('g_property_info_get_type');
  late final _propertyInfoGetType = _propertyInfoGetTypePtr
      .asFunction<ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>)>();


  late final _fieldInfoGetFieldPtr = _lookup<
      ffi.NativeFunction<
          ffi.Int Function(ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>,
              ffi.Pointer<_GIArgument>)>>('g_field_info_get_field');
  late final _fieldInfoGetField = _fieldInfoGetFieldPtr.asFunction<
      int Function(ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>,
          ffi.Pointer<_GIArgument>)>();

  late final _fieldInfoGetFlagsPtr =
  _lookup<ffi.NativeFunction<ffi.Int32 Function(ffi.Pointer<ffi.Void>)>>(
      'g_field_info_get_flags');
  late final _fieldInfoGetFlags = _fieldInfoGetFlagsPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _fieldInfoGetOffsetPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_field_info_get_offset');
  late final _fieldInfoGetOffset = _fieldInfoGetOffsetPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();


  late final _fieldInfoGetSizePtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_field_info_get_size');
  late final _fieldInfoGetSize = _fieldInfoGetSizePtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _fieldInfoGetTypePtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>)>>('g_field_info_get_type');
  late final _fieldInfoGetType = _fieldInfoGetTypePtr
      .asFunction<ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>)>();

  late final _fieldInfoSetFieldPtr = _lookup<
      ffi.NativeFunction<
          ffi.Int Function(ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>,
              ffi.Pointer<_GIArgument>)>>('g_field_info_set_field');
  late final _fieldInfoSetField = _fieldInfoSetFieldPtr.asFunction<
      int Function(ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>,
          ffi.Pointer<_GIArgument>)>();

  late final _argInfoGetClosurePtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_arg_info_get_closure');
  late final _argInfoGetClosure =
  _argInfoGetClosurePtr.asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _argInfoGetDestroyPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_arg_info_get_destroy');
  late final _argInfoGetDestroy =
  _argInfoGetDestroyPtr.asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _argInfoGetDirectionPtr =
  _lookup<ffi.NativeFunction<ffi.Int32 Function(ffi.Pointer<ffi.Void>)>>(
      'g_arg_info_get_direction');
  late final _argInfoGetDirection = _argInfoGetDirectionPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();
  
  late final _argInfoGetOwnershipTransferPtr =
  _lookup<ffi.NativeFunction<ffi.Int32 Function(ffi.Pointer<ffi.Void>)>>(
      'g_arg_info_get_ownership_transfer');
  late final _argInfoGetOwnershipTransfer =
  _argInfoGetOwnershipTransferPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();
  
  late final _argInfoGetScopePtr =
  _lookup<ffi.NativeFunction<ffi.Int32 Function(ffi.Pointer<ffi.Void>)>>(
      'g_arg_info_get_scope');
  late final _argInfoGetScope =
  _argInfoGetScopePtr.asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _argInfoGetTypePtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>)>>('g_arg_info_get_type');
  late final _argInfoGetType = _argInfoGetTypePtr
      .asFunction<ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>)>();

  late final _argInfoIsCallerAllocatesPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_arg_info_is_caller_allocates');
  late final _argInfoIsCallerAllocates = _argInfoIsCallerAllocatesPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _argInfoIsOptionalPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_arg_info_is_optional');
  late final _argInfoIsOptional =
  _argInfoIsOptionalPtr.asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _argInfoIsReturnValuePtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_arg_info_is_return_value');
  late final _argInfoIsReturnValue = _argInfoIsReturnValuePtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _argInfoIsSkipPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_arg_info_is_skip');
  late final _argInfoIsSkip =
  _argInfoIsSkipPtr.asFunction<int Function(ffi.Pointer<ffi.Void>)>();
  
  late final _argInfoLoadTypePtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>)>>('g_arg_info_load_type');
  late final _argInfoLoadType = _argInfoLoadTypePtr
      .asFunction<void Function(ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  late final _argInfoMayBeNullPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_arg_info_may_be_null');
  late final _argInfoMayBeNull =
  _argInfoMayBeNullPtr.asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _typeInfoArgumentFromHashPointerPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>,
              ffi.Pointer<_GIArgument>)>>(
      'g_type_info_argument_from_hash_pointer');
  late final _typeInfoArgumentFromHashPointer =
  _typeInfoArgumentFromHashPointerPtr.asFunction<
      void Function(ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>,
          ffi.Pointer<_GIArgument>)>();

  late final _typeInfoGetArrayFixedSizePtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_type_info_get_array_fixed_size');
  late final _typeInfoGetArrayFixedSize =
  _typeInfoGetArrayFixedSizePtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();
  
  late final _typeInfoGetArrayLengthPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_type_info_get_array_length');
  late final _typeInfoGetArrayLength = _typeInfoGetArrayLengthPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _typeInfoGetArrayTypePtr =
  _lookup<ffi.NativeFunction<ffi.Int32 Function(ffi.Pointer<ffi.Void>)>>(
      'g_type_info_get_array_type');
  late final _typeInfoGetArrayType = _typeInfoGetArrayTypePtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _typeInfoGetInterfacePtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>)>>('g_type_info_get_interface');
  late final _typeInfoGetInterface = _typeInfoGetInterfacePtr
      .asFunction<ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>)>();

  late final _typeInfoGetParamTypePtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>, ffi.Int)>>('g_type_info_get_param_type');
  late final _typeInfoGetParamType = _typeInfoGetParamTypePtr
      .asFunction<ffi.Pointer<ffi.Void> Function(ffi.Pointer<ffi.Void>, int)>();

  late final _typeInfoGetStorageTypePtr =
  _lookup<ffi.NativeFunction<ffi.Int32 Function(ffi.Pointer<ffi.Void>)>>(
      'g_type_info_get_storage_type');
  late final _typeInfoGetStorageType = _typeInfoGetStorageTypePtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();
  
  late final _typeInfoGetTagPtr =
  _lookup<ffi.NativeFunction<ffi.Int32 Function(ffi.Pointer<ffi.Void>)>>(
      'g_type_info_get_tag');
  late final _typeInfoGetTag =
  _typeInfoGetTagPtr.asFunction<int Function(ffi.Pointer<ffi.Void>)>();
  
  late final _typeInfoHashPointerFromArgumentPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Void> Function(
              ffi.Pointer<ffi.Void>, ffi.Pointer<_GIArgument>)>>(
      'g_type_info_hash_pointer_from_argument');
  late final _typeInfoHashPointerFromArgument =
  _typeInfoHashPointerFromArgumentPtr.asFunction<
      ffi.Pointer<ffi.Void> Function(
          ffi.Pointer<ffi.Void>, ffi.Pointer<_GIArgument>)>();

  late final _typeInfoIsPointerPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_type_info_is_pointer');
  late final _typeInfoIsPointer = _typeInfoIsPointerPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _typeInfoIsZeroTerminatedPtr =
  _lookup<ffi.NativeFunction<ffi.Int Function(ffi.Pointer<ffi.Void>)>>(
      'g_type_info_is_zero_terminated');
  late final _typeInfoIsZeroTerminated = _typeInfoIsZeroTerminatedPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _registeredTypeInfoGetGTypePtr = _lookup<
      ffi.NativeFunction<
          ffi.UnsignedLong Function(ffi.Pointer<ffi.Void>)>>(
      'g_registered_type_info_get_g_type');
  late final _registeredTypeInfoGetGType =
  _registeredTypeInfoGetGTypePtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  late final _registeredTypeInfoGetTypeInitPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.Void>)>>(
      'g_registered_type_info_get_type_init');
  late final _registeredTypeInfoGetTypeInit =
  _registeredTypeInfoGetTypeInitPtr.asFunction<
      ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.Void>)>();

  late final _registeredTypeInfoGetTypeNamePtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.Void>)>>(
      'g_registered_type_info_get_type_name');
  late final _registeredTypeInfoGetTypeName =
  _registeredTypeInfoGetTypeNamePtr.asFunction<
      ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.Void>)>();



  // this is lazily initialized
  GObjectTypeModule? _typeModule;
  GObjectTypeModule get typeModule => _typeModule ??= GObjectTypeModule(
        builders: [Repository.defaultTypeBuilder],
      );
}


final class _GIArgument extends ffi.Union {
  @ffi.Int()
  external int v_boolean;

  @ffi.SignedChar()
  external int v_int8;

  @ffi.UnsignedChar()
  external int v_uint8;

  @ffi.Short()
  external int v_int16;

  @ffi.UnsignedShort()
  external int v_uint16;

  @ffi.Int()
  external int v_int32;

  @ffi.UnsignedInt()
  external int v_uint32;

  @ffi.Long()
  external int v_int64;

  @ffi.UnsignedLong()
  external int v_uint64;

  @ffi.Float()
  external double v_float;

  @ffi.Double()
  external double v_double;

  @ffi.Short()
  external int v_short;

  @ffi.UnsignedShort()
  external int v_ushort;

  @ffi.Int()
  external int v_int;

  @ffi.UnsignedInt()
  external int v_uint;

  @ffi.Long()
  external int v_long;

  @ffi.UnsignedLong()
  external int v_ulong;

  @ffi.Long()
  external int v_ssize;

  @ffi.UnsignedLong()
  external int v_size;

  external ffi.Pointer<ffi.Char> v_string;

  external ffi.Pointer<ffi.Void> v_pointer;
}

GObjectIntrospectionLibraryAdapter? _gobjectIntrospection;
GObjectIntrospectionLibraryAdapter get gobjectIntrospection =>
    _gobjectIntrospection ??= GObjectIntrospectionLibraryAdapter();

class _ImplicitList<E> extends ListMixin<E> {
  final int _length;
  final E Function(int index) _getter;

  @override
  int get length => _length;

  set length(int newLength) {
    throw UnsupportedError('Cannot change the length of an implicit list');
  }

  _ImplicitList(this._length, this._getter);

  @override
  E operator [](int index) {
    if (index < 0 || index >= _length) {
      throw RangeError.range(index, 0, _length - 1);
    }
    return _getter(index);
  }

  @override
  void operator []=(int index, E value) {
    throw UnsupportedError('Cannot change the length of an implicit list');
  }

}

final class Repository extends GObject {
  Repository._fromStaticLifespanRef(ffi.Pointer<ffi.Void> ptr)
      : super.$fromStaticLifespanRef(ptr);

  Repository._fromOwnedRef(ffi.Pointer<ffi.Void> ptr, [Object? owner])
      : super.$fromOwnedRef(ptr, owner);

  Repository._fromFloatingRef(ffi.Pointer<ffi.Void> ptr)
      : super.$fromFloatingRef(ptr);

  static GObjectTypeBuilder? _defaultTypeBuilder;
  static GObjectTypeBuilder get defaultTypeBuilder =>
      _defaultTypeBuilder ??= GObjectTypeBuilder(
        gType: gobjectIntrospection._gIRepositoryGetType(),
        fromPointer: (ffi.Pointer<ffi.Void> ptr,
            [ReferenceType? refType, Object? container]) {
          refType ??= ReferenceType.owned;
          return refType == ReferenceType.owned
              ? Repository._fromOwnedRef(ptr)
              : refType == ReferenceType.floating
                  ? Repository._fromFloatingRef(ptr)
                  : refType == ReferenceType.containedLifespan
                      ? Repository._fromOwnedRef(ptr, container)
                      : refType == ReferenceType.staticLifespan
                          ? Repository._fromStaticLifespanRef(ptr)
                          : throw ArgumentError.value(
                              refType, 'refType', 'Invalid value');
        },
      );

  static Repository getDefault() {
    GObject.registerModule(gobjectIntrospection.typeModule);

    final repo = gobjectIntrospection._gIRepositoryGetDefault();
    return GObject.$create(repo, ReferenceType.staticLifespan) as Repository;
  }

  List<String> getDependencies(String namespace) {
    final charPtrIn = namespace.toNativeUtf8(allocator: gMalloc).cast<ffi.Char>();
    final ptr = gobjectIntrospection._irepositoryGetDependencies(
      $ptr,
      charPtrIn,
    );

    gMalloc.free(charPtrIn);
    return _nullTerminatedStringArrayToDart(ptr);
  }

  List<String> getImmediateDependencies(String namespace) {
    final charPtrIn = namespace.toNativeUtf8(allocator: gMalloc).cast<ffi.Char>();
    final ptr = gobjectIntrospection._irepositoryGetImmediateDependencies(
      $ptr,
      charPtrIn,
    );

    gMalloc.free(charPtrIn);
    return _nullTerminatedStringArrayToDart(ptr);
  }

  int _getNInfos(String namespace) {
    final charPtrIn = namespace.toNativeUtf8(allocator: gMalloc).cast<ffi.Char>();
    final result = gobjectIntrospection._irepositoryGetNInfos(
      $ptr,
      charPtrIn,
    );

    gMalloc.free(charPtrIn);
    return result;
  }

  BaseInfo _getInfo(String namespace, int index) {
    final charPtrIn = namespace.toNativeUtf8(allocator: gMalloc).cast<ffi.Char>();
    final result = gobjectIntrospection._irepositoryGetInfo(
      $ptr,
      charPtrIn,
      index,
    );

    gMalloc.free(charPtrIn);
    return BaseInfo.$create(result)!;
  }

  List<BaseInfo> getInfos(String namespace) {
    final nInfos = _getNInfos(namespace);
    return _ImplicitList<BaseInfo>(nInfos, (i) => _getInfo(namespace, i));
  }

  List<String> getLoadedNamespaces() {
    final ptr = gobjectIntrospection._irepositoryGetLoadedNamespaces($ptr);
    return _nullTerminatedStringArrayToDart(ptr);
  }


  Typelib require(String namespace, [String? version, RepositoryLoadFlags flags = RepositoryLoadFlags.none]) {
    final charPtrIn = namespace.toNativeUtf8(allocator: gMalloc).cast<ffi.Char>();
    final charPtrIn2 = version == null ? ffi.nullptr.cast<ffi.Char>() : version.toNativeUtf8(allocator: gMalloc).cast<ffi.Char>();
    final gErrorOut = ffi.calloc<ffi.Pointer<ffi.Void>>();
    final ptr = gobjectIntrospection._irepositoryRequire(
      $ptr,
      charPtrIn,
      charPtrIn2,
      flags.index,
      gErrorOut
    );

    gMalloc.free(charPtrIn);
    gMalloc.free(charPtrIn2);

    if (ptr == ffi.nullptr) {
      final gError = GError.$fromGError(gErrorOut.value);
      ffi.calloc.free(gErrorOut);
      if (gError != null) {
        throw gError;
      }
      throw Exception('Unknown error');
    } else {
      ffi.calloc.free(gErrorOut);
    }

    return Typelib.$create(ptr)!;
  }

  Typelib requirePrivate(String typelibDir, String namespace, String? version, [RepositoryLoadFlags flags = RepositoryLoadFlags.none]) {
    final charPtrIn = typelibDir.toNativeUtf8(allocator: gMalloc).cast<ffi.Char>();
    final charPtrIn2 = namespace.toNativeUtf8(allocator: gMalloc).cast<ffi.Char>();
    final charPtrIn3 = version == null ? ffi.nullptr.cast<ffi.Char>() : version.toNativeUtf8(allocator: gMalloc).cast<ffi.Char>();
    final gErrorOut = gMalloc<ffi.Pointer<ffi.Void>>();
    final ptr = gobjectIntrospection._irepositoryRequirePrivate(
        $ptr,
        charPtrIn,
        charPtrIn2,
        charPtrIn3,
        flags.index,
        gErrorOut
    );

    gMalloc.free(charPtrIn);
    gMalloc.free(charPtrIn2);
    gMalloc.free(charPtrIn3);

    if (ptr == ffi.nullptr) {
      final gError = GError.$fromGError(gErrorOut.value);
      if (gError != null) {
        throw gError;
      }
      throw Exception('Unknown error');
    }

    return Typelib.$create(ptr)!;
  }

  List<String> enumerateVersions(String namespace) {
    final charPtrIn = namespace.toNativeUtf8(allocator: gMalloc).cast<ffi.Char>();
    final ptr = gobjectIntrospection._irepositoryEnumerateVersions(
      $ptr,
      charPtrIn,
    );

    gMalloc.free(charPtrIn);
    return _stringGListToDart(ptr);
  }

  BaseInfo? findByName(String namespace, String name) {
    final namespacePtrIn = namespace.toNativeUtf8(allocator: gMalloc).cast<ffi.Char>();
    final namePtrIn = name.toNativeUtf8(allocator: gMalloc).cast<ffi.Char>();
    final ptr = gobjectIntrospection._irepositoryFindByName(
      $ptr,
      namespacePtrIn,
      namePtrIn,
    );

    gMalloc.free(namespacePtrIn);
    gMalloc.free(namePtrIn);
    if (ptr == ffi.nullptr) {
      return null;
    }
    return BaseInfo.$create(ptr);
  }

}

/// GIInfoType:
/// @GI_INFO_TYPE_INVALID: invalid type
/// @GI_INFO_TYPE_FUNCTION: function, see #GIFunctionInfo
/// @GI_INFO_TYPE_CALLBACK: callback, see #GIFunctionInfo
/// @GI_INFO_TYPE_STRUCT: struct, see #GIStructInfo
/// @GI_INFO_TYPE_BOXED: boxed, see #GIStructInfo or #GIUnionInfo
/// @GI_INFO_TYPE_ENUM: enum, see #GIEnumInfo
/// @GI_INFO_TYPE_FLAGS: flags, see #GIEnumInfo
/// @GI_INFO_TYPE_OBJECT: object, see #GIObjectInfo
/// @GI_INFO_TYPE_INTERFACE: interface, see #GIInterfaceInfo
/// @GI_INFO_TYPE_CONSTANT: contant, see #GIConstantInfo
/// @GI_INFO_TYPE_INVALID_0: deleted, used to be GI_INFO_TYPE_ERROR_DOMAIN.
/// @GI_INFO_TYPE_UNION: union, see #GIUnionInfo
/// @GI_INFO_TYPE_VALUE: enum value, see #GIValueInfo
/// @GI_INFO_TYPE_SIGNAL: signal, see #GISignalInfo
/// @GI_INFO_TYPE_VFUNC: virtual function, see #GIVFuncInfo
/// @GI_INFO_TYPE_PROPERTY: GObject property, see #GIPropertyInfo
/// @GI_INFO_TYPE_FIELD: struct or union field, see #GIFieldInfo
/// @GI_INFO_TYPE_ARG: argument of a function or callback, see #GIArgInfo
/// @GI_INFO_TYPE_TYPE: type information, see #GITypeInfo
/// @GI_INFO_TYPE_UNRESOLVED: unresolved type, a type which is not present in
/// the typelib, or any of its dependencies.
///
/// The type of a GIBaseInfo struct.
abstract class InfoType {
  static const int GI_INFO_TYPE_INVALID = 0;
  static const int GI_INFO_TYPE_FUNCTION = 1;
  static const int GI_INFO_TYPE_CALLBACK = 2;
  static const int GI_INFO_TYPE_STRUCT = 3;
  static const int GI_INFO_TYPE_BOXED = 4;
  static const int GI_INFO_TYPE_ENUM = 5;
  static const int GI_INFO_TYPE_FLAGS = 6;
  static const int GI_INFO_TYPE_OBJECT = 7;
  static const int GI_INFO_TYPE_INTERFACE = 8;
  static const int GI_INFO_TYPE_CONSTANT = 9;
  static const int GI_INFO_TYPE_INVALID_0 = 10;
  static const int GI_INFO_TYPE_UNION = 11;
  static const int GI_INFO_TYPE_VALUE = 12;
  static const int GI_INFO_TYPE_SIGNAL = 13;
  static const int GI_INFO_TYPE_VFUNC = 14;
  static const int GI_INFO_TYPE_PROPERTY = 15;
  static const int GI_INFO_TYPE_FIELD = 16;
  static const int GI_INFO_TYPE_ARG = 17;
  static const int GI_INFO_TYPE_TYPE = 18;
  static const int GI_INFO_TYPE_UNRESOLVED = 19;
}

final class _BaseInfoWeakRef {
  final WeakReference<BaseInfo> object;
  final ffi.Pointer<ffi.Void> pointer;
  BaseInfo? strongReference;
  bool isRef;
  final bool isStatic;

  _BaseInfoWeakRef(BaseInfo object, this.pointer, {this.isRef = true}) : isStatic = false, object = WeakReference(object);

  _BaseInfoWeakRef.strong(BaseInfo object, this.pointer, {this.isRef = true, this.isStatic = false}) : strongReference = object, object = WeakReference(object);

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

final class _BaseInfo extends ffi.Opaque {}

/// GIAttributeIter:
///
/// An opaque structure used to iterate over attributes
/// in a #GIBaseInfo struct.
final class _AttributeIter extends ffi.Struct {
  external ffi.Pointer<ffi.Void> data;

  external ffi.Pointer<ffi.Void> data2;

  external ffi.Pointer<ffi.Void> data3;

  external ffi.Pointer<ffi.Void> data4;
}


typedef _BaseInfoTypeBuilder = BaseInfo Function(ffi.Pointer<ffi.Void> ptr);

sealed class BaseInfo {
  static final Map<int, _BaseInfoWeakRef> _instancesByPointer = <int, _BaseInfoWeakRef>{};

  static final Map<int, _BaseInfoTypeBuilder> _registeredTypes = <int, _BaseInfoTypeBuilder>{
    InfoType.GI_INFO_TYPE_FUNCTION: (ptr) => FunctionInfo._fromPtr(ptr),
    InfoType.GI_INFO_TYPE_CALLBACK: (ptr) => CallbackInfo._fromPtr(ptr),
    InfoType.GI_INFO_TYPE_STRUCT: (ptr) => StructInfo._fromPtr(ptr),
    InfoType.GI_INFO_TYPE_BOXED: (ptr) => BoxedInfo._fromPtr(ptr),
    InfoType.GI_INFO_TYPE_ENUM: (ptr) => EnumInfo._fromPtr(ptr),
    InfoType.GI_INFO_TYPE_FLAGS: (ptr) => FlagsInfo._fromPtr(ptr),
    InfoType.GI_INFO_TYPE_OBJECT: (ptr) => ObjectInfo._fromPtr(ptr),
    InfoType.GI_INFO_TYPE_INTERFACE: (ptr) => InterfaceInfo._fromPtr(ptr),
    InfoType.GI_INFO_TYPE_CONSTANT: (ptr) => ConstantInfo._fromPtr(ptr),
    InfoType.GI_INFO_TYPE_UNION: (ptr) => UnionInfo._fromPtr(ptr),
    InfoType.GI_INFO_TYPE_VALUE: (ptr) => ValueInfo._fromPtr(ptr),
    InfoType.GI_INFO_TYPE_SIGNAL: (ptr) => SignalInfo._fromPtr(ptr),
    InfoType.GI_INFO_TYPE_VFUNC: (ptr) => VFuncInfo._fromPtr(ptr),
    InfoType.GI_INFO_TYPE_PROPERTY: (ptr) => PropertyInfo._fromPtr(ptr),
    InfoType.GI_INFO_TYPE_FIELD: (ptr) => FieldInfo._fromPtr(ptr),
    InfoType.GI_INFO_TYPE_ARG: (ptr) => ArgInfo._fromPtr(ptr),
    InfoType.GI_INFO_TYPE_TYPE: (ptr) => TypeInfo._fromPtr(ptr),
  };

  static final Finalizer<ffi.Pointer<ffi.Void>> _finalizer = Finalizer<ffi.Pointer<ffi.Void>>(_finalize);

  // when the last instance
  static void _finalize(ffi.Pointer<ffi.Void> self) {
    final _BaseInfoWeakRef? instance = _instancesByPointer[self.address];
    if (instance == null) {
      print('Finalized GObject that was not registered');
      return;
    }

    if (instance.isRef) {
      gobjectIntrospection._baseInfoUnref(self);
      instance.isRef = false;
    }

    _instancesByPointer.remove(self.address);
  }

  final ffi.Pointer<ffi.Void> _ptr;

  BaseInfo._fromPtr(this._ptr) {
    _finalizer.attach(this, _ptr);
    _instancesByPointer[_ptr.address] = _BaseInfoWeakRef(this, _ptr);
  }

  static BaseInfo? $create(ffi.Pointer<ffi.Void> ptr, [ReferenceType? refType]) {
    if (ptr == ffi.nullptr) {
      return null;
    }

    final ref = _instancesByPointer[ptr.address];
    if (ref != null && ref.isAlive) {
      if (refType == ReferenceType.owned) {
        gobjectIntrospection._baseInfoUnref(ptr);
      }

      return ref.object.target;
    }

    _instancesByPointer.remove(ptr.address);
    refType ??= ReferenceType.owned;
    if (refType == ReferenceType.unowned) {
      ptr = gobjectIntrospection._baseInfoRef(ptr);
      refType = ReferenceType.owned;
    }

    assert(refType == ReferenceType.owned);
    var type = gobjectIntrospection._baseInfoGetType(ptr);
    var builder = _registeredTypes[type];
    builder ??= (ptr) => _UnknownInfo._fromPtr(ptr);
    return builder(ptr);
  }

  bool equal(BaseInfo? info) {
    if (info == null) {
      return false;
    }

    return gobjectIntrospection._baseInfoEqual(_ptr, info._ptr) != 0;
  }

  String? getAttribute(String name) {
    final ptr = gobjectIntrospection._baseInfoGetAttribute(_ptr, name.toNativeUtf8(allocator: gMalloc).cast());
    if (ptr == ffi.nullptr) {
      return null;
    }

    return ptr.cast<ffi.Utf8>().toDartString();
  }

  BaseInfo? get container {
    final ptr = gobjectIntrospection._baseInfoGetContainer(_ptr);
    return BaseInfo.$create(ptr, ReferenceType.unowned);
  }

  String? get name {
    final ptr = gobjectIntrospection._baseInfoGetName(_ptr);
    if (ptr == ffi.nullptr) {
      return null;
    }

    return ptr.cast<ffi.Utf8>().toDartString();
  }

  String get namespace {
    final ptr = gobjectIntrospection._baseInfoGetNamespace(_ptr);
    return ptr.cast<ffi.Utf8>().toDartString();
  }

  bool get isDeprecated {
    return gobjectIntrospection._baseInfoIsDeprecated(_ptr) != 0;
  }

  Iterable<BaseInfoAttribute> get attributes => _BaseInfoAttributeIterable(this);
}

abstract class RegisteredTypeInfo extends BaseInfo {
  RegisteredTypeInfo._fromPtr(ffi.Pointer<ffi.Void> ptr) : super._fromPtr(ptr);
  
  int get gType {
    return gobjectIntrospection._registeredTypeInfoGetGType(_ptr);
  }
  
  String? get typeInit {
    final ptr = gobjectIntrospection._registeredTypeInfoGetTypeInit(_ptr);
    return ptr.cast<ffi.Utf8>().toDartString();
  }

  String get typeName {
    final ptr = gobjectIntrospection._registeredTypeInfoGetTypeName(_ptr);
    return ptr.cast<ffi.Utf8>().toDartString();
  }
  
}

class BaseInfoAttribute {
  final String name;
  final String value;

  BaseInfoAttribute(this.name, this.value);

  @override

  String toString() {
    return '$name: $value';
  }
}

class _BaseInfoAttributeIterable extends Iterable<BaseInfoAttribute> {
  final BaseInfo _info;

  _BaseInfoAttributeIterable(this._info);

  @override
  Iterator<BaseInfoAttribute> get iterator => _BaseInfoAttributeIterator(_info);
}

class _BaseInfoAttributeIterator implements Iterator<BaseInfoAttribute>, ffi.Finalizable {
  static final ffi.NativeFinalizer _finalizer = ffi.NativeFinalizer(gMalloc.freeFunction);

  final ffi.Pointer<_AttributeIter> _ptr;
  final BaseInfo _info;
  BaseInfoAttribute? _current;

  _BaseInfoAttributeIterator(this._info) : _ptr = gMalloc<_AttributeIter>() {
    _ptr.ref.data = ffi.nullptr;
    _ptr.ref.data2 = ffi.nullptr;
    _ptr.ref.data3 = ffi.nullptr;
    _ptr.ref.data4 = ffi.nullptr;
    _finalizer.attach(this, _ptr.cast<ffi.Void>());
  }

  @override
  BaseInfoAttribute get current => _current ?? (throw StateError('No current attribute'));

  @override
  bool moveNext() {
    final attrNameOut = gMalloc<ffi.Pointer<ffi.Char>>();
    final attrValueOut = gMalloc<ffi.Pointer<ffi.Char>>();
    final result = gobjectIntrospection._baseInfoIterateAttributes(_info._ptr, _ptr, attrNameOut, attrValueOut);
    if (result == 0) {
      _current = null;
      return false;
    }

    final namePtr = attrNameOut.value;
    final valuePtr = attrValueOut.value;
    final name = namePtr.cast<ffi.Utf8>().toDartString();
    final value = valuePtr.cast<ffi.Utf8>().toDartString();
    _current = BaseInfoAttribute(name, value);
    return true;
  }
}

class _UnknownInfo extends BaseInfo {
  _UnknownInfo._fromPtr(ffi.Pointer<ffi.Void> ptr) : super._fromPtr(ptr);
}

class FunctionInfo extends CallableInfo {
  FunctionInfo._fromPtr(ffi.Pointer<ffi.Void> ptr) : super._fromPtr(ptr);

  FunctionInfoFlags get flags {
    return FunctionInfoFlags(gobjectIntrospection._functionInfoGetFlags(_ptr));
  }

  PropertyInfo? get property {
    final ptr = gobjectIntrospection._functionInfoGetProperty(_ptr);
    return BaseInfo.$create(ptr) as PropertyInfo?;
  }

  String get symbol {
    final ptr = gobjectIntrospection._functionInfoGetSymbol(_ptr);
    return ptr.cast<ffi.Utf8>().toDartString();
  }

  VFuncInfo? get vfunc {
    final ptr = gobjectIntrospection._functionInfoGetVfunc(_ptr);
    return BaseInfo.$create(ptr) as VFuncInfo?;
  }
}

class CallableInfo extends BaseInfo {
  CallableInfo._fromPtr(ffi.Pointer<ffi.Void> ptr) : super._fromPtr(ptr);

  int get nArgs {
    return gobjectIntrospection._callableInfoGetNArgs(_ptr);
  }

  ArgInfo _getArg(int index) {
    final ptr = gobjectIntrospection._callableInfoGetArg(_ptr, index);
    return BaseInfo.$create(ptr, ReferenceType.unowned) as ArgInfo;
  }

  List<ArgInfo> get args {
    return _ImplicitList(nArgs, _getArg);
  }

  Transfer get callerOwns {
    return Transfer(gobjectIntrospection._callableInfoGetCallerOwns(_ptr));
  }

  String getReturnAttribute(String name) {
    final strArg = name.toNativeUtf8(allocator: gMalloc).cast<ffi.Char>();
    final ptr = gobjectIntrospection._callableInfoGetReturnAttribute(_ptr, strArg);
    gMalloc.free(strArg);
    return ptr.cast<ffi.Utf8>().toDartString();
  }

  TypeInfo? get returnType {
    final ptr = gobjectIntrospection._callableInfoGetReturnType(_ptr);
    return BaseInfo.$create(ptr) as TypeInfo?;
  }

  bool get isMethod {
    return gobjectIntrospection._callableInfoIsMethod(_ptr) != 0;
  }
  
  Iterable<BaseInfoAttribute> get returnAttributes {
    return _CallableReturnAttributeIterable(this);
  }

  bool get skipReturn {
    return gobjectIntrospection._callableInfoSkipReturn(_ptr) != 0;
  }

  bool get mayReturnNull {
    return gobjectIntrospection._callableInfoMayReturnNull(_ptr) != 0;
  }

  bool get canThrowGerror {
    return gobjectIntrospection._callableInfoCanThrowGerror(_ptr) != 0;
  }
}

class _CallableReturnAttributeIterable extends Iterable<BaseInfoAttribute> {
  final CallableInfo _info;

  _CallableReturnAttributeIterable(this._info);

  @override
  Iterator<BaseInfoAttribute> get iterator => _CallableReturnAttributeIterator(_info);
}

class _CallableReturnAttributeIterator implements Iterator<BaseInfoAttribute>, ffi.Finalizable {
  static final ffi.NativeFinalizer _finalizer = ffi.NativeFinalizer(gMalloc.freeFunction);

  final ffi.Pointer<_AttributeIter> _ptr;
  final CallableInfo _info;
  BaseInfoAttribute? _current;

  _CallableReturnAttributeIterator(this._info) : _ptr = gMalloc<_AttributeIter>() {
    _ptr.ref.data = ffi.nullptr;
    _ptr.ref.data2 = ffi.nullptr;
    _ptr.ref.data3 = ffi.nullptr;
    _ptr.ref.data4 = ffi.nullptr;
    _finalizer.attach(this, _ptr.cast<ffi.Void>());
  }

  @override
  BaseInfoAttribute get current => _current ?? (throw StateError('No current attribute'));

  @override
  bool moveNext() {
    final attrNameOut = gMalloc<ffi.Pointer<ffi.Char>>();
    final attrValueOut = gMalloc<ffi.Pointer<ffi.Char>>();
    final result = gobjectIntrospection._callableInfoIterateReturnAttributes(_info._ptr, _ptr, attrNameOut, attrValueOut);
    if (result == 0) {
      _current = null;
      return false;
    }

    final namePtr = attrNameOut.value;
    final valuePtr = attrValueOut.value;
    final name = namePtr.cast<ffi.Utf8>().toDartString();
    final value = valuePtr.cast<ffi.Utf8>().toDartString();
    _current = BaseInfoAttribute(name, value);
    return true;
  }
}

class CallbackInfo extends CallableInfo {
  CallbackInfo._fromPtr(ffi.Pointer<ffi.Void> ptr) : super._fromPtr(ptr);
}

class EnumInfo extends RegisteredTypeInfo {
  EnumInfo._fromPtr(ffi.Pointer<ffi.Void> ptr) : super._fromPtr(ptr);

  String? get errorDomain {
    final ptr = gobjectIntrospection._enumInfoGetErrorDomain(_ptr);
    return ptr == ffi.nullptr ? null : ptr.cast<ffi.Utf8>().toDartString();
  }

  int get nValues {
    return gobjectIntrospection._enumInfoGetNValues(_ptr);
  }

  int get nMethods {
    return gobjectIntrospection._enumInfoGetNMethods(_ptr);
  }

  TypeTag get storageType {
    return TypeTag(gobjectIntrospection._enumInfoGetStorageType(_ptr));
  }

  List<FunctionInfo> get methods {
    return _ImplicitList(nMethods, _getMethod);
  }

  FunctionInfo _getMethod(int index) {
    final ptr = gobjectIntrospection._enumInfoGetMethod(_ptr, index);
    return BaseInfo.$create(ptr) as FunctionInfo;
  }

  List<ValueInfo> get values {
    return _ImplicitList(nValues, _getValue);
  }

  ValueInfo _getValue(int index) {
    final ptr = gobjectIntrospection._enumInfoGetValue(_ptr, index);
    return BaseInfo.$create(ptr) as ValueInfo;
  }
}

class StructInfo extends RegisteredTypeInfo {
  StructInfo._fromPtr(ffi.Pointer<ffi.Void> ptr) : super._fromPtr(ptr);

  FieldInfo? findField(String name) {
    final strArg = name.toNativeUtf8(allocator: gMalloc).cast<ffi.Char>();
    final ptr = gobjectIntrospection._structInfoFindField(_ptr, strArg);
    gMalloc.free(strArg);
    return BaseInfo.$create(ptr) as FieldInfo?;
  }

  FunctionInfo? findMethod(String name) {
    final strArg = name.toNativeUtf8(allocator: gMalloc).cast<ffi.Char>();
    final ptr = gobjectIntrospection._structInfoFindMethod(_ptr, strArg);
    gMalloc.free(strArg);
    return BaseInfo.$create(ptr) as FunctionInfo?;
  }

  int get alignment {
    return gobjectIntrospection._structInfoGetAlignment(_ptr);
  }

  FieldInfo _getField(int index) {
    final ptr = gobjectIntrospection._structInfoGetField(_ptr, index);
    return BaseInfo.$create(ptr) as FieldInfo;
  }

  int get nFields {
    return gobjectIntrospection._structInfoGetNFields(_ptr);
  }

  List<FieldInfo> get fields {
    return _ImplicitList(nFields, _getField);
  }

  int get nMethods {
    return gobjectIntrospection._structInfoGetNMethods(_ptr);
  }

  FunctionInfo _getMethod(int index) {
    final ptr = gobjectIntrospection._structInfoGetMethod(_ptr, index);
    return BaseInfo.$create(ptr) as FunctionInfo;
  }

  List<FunctionInfo> get methods {
    return _ImplicitList(nMethods, _getMethod);
  }

  String? get freeFunction {
    final ptr = gobjectIntrospection._structInfoGetFreeFunction(_ptr);
    return ptr == ffi.nullptr ? null : ptr.cast<ffi.Utf8>().toDartString();
  }

  String? get copyFunction {
    final ptr = gobjectIntrospection._structInfoGetCopyFunction(_ptr);
    return ptr == ffi.nullptr ? null : ptr.cast<ffi.Utf8>().toDartString();
  }

  int get size {
    return gobjectIntrospection._structInfoGetSize(_ptr);
  }

  bool get isForeign {
    return gobjectIntrospection._structInfoIsForeign(_ptr) != 0;
  }

  bool get isGtypeStruct {
    return gobjectIntrospection._structInfoIsGtypeStruct(_ptr) != 0;
  }
}

class BoxedInfo extends BaseInfo {
  BoxedInfo._fromPtr(ffi.Pointer<ffi.Void> ptr) : super._fromPtr(ptr);
}

class FlagsInfo extends EnumInfo {
  FlagsInfo._fromPtr(ffi.Pointer<ffi.Void> ptr) : super._fromPtr(ptr);
}

class ObjectInfo extends RegisteredTypeInfo {
  ObjectInfo._fromPtr(ffi.Pointer<ffi.Void> ptr) : super._fromPtr(ptr);

  FunctionInfo? findMethod(String name) {
    final strArg = name.toNativeUtf8(allocator: gMalloc).cast<ffi.Char>();
    final ptr = gobjectIntrospection._objectInfoFindMethod(_ptr, strArg);
    gMalloc.free(strArg);
    return BaseInfo.$create(ptr) as FunctionInfo?;
  }

  FindMethodUsingInterfacesResponse? findMethodUsingInterfaces(String name) {
    final strArg = name.toNativeUtf8(allocator: gMalloc).cast<ffi.Char>();
    final implementorOut = gMalloc<ffi.Pointer<ffi.Void>>();
    final ptr = gobjectIntrospection._objectInfoFindMethodUsingInterfaces(_ptr, strArg, implementorOut);
    gMalloc.free(strArg);
    var imlementor = BaseInfo.$create(implementorOut.value) as ObjectInfo?;
    gMalloc.free(implementorOut);
    if (ptr == ffi.nullptr) {
      return null;
    }
    return FindMethodUsingInterfacesResponse(BaseInfo.$create(ptr) as FunctionInfo, imlementor!);
  }

  SignalInfo? findSignal(String name) {
    final strArg = name.toNativeUtf8(allocator: gMalloc).cast<ffi.Char>();
    final ptr = gobjectIntrospection._objectInfoFindSignal(_ptr, strArg);
    gMalloc.free(strArg);
    return BaseInfo.$create(ptr) as SignalInfo?;
  }
  
  VFuncInfo? findVfunc(String name) {
    final strArg = name.toNativeUtf8(allocator: gMalloc).cast<ffi.Char>();
    final ptr = gobjectIntrospection._objectInfoFindVfunc(_ptr, strArg);
    gMalloc.free(strArg);
    return BaseInfo.$create(ptr) as VFuncInfo?;
  }

  FindVFuncUsingInterfacesResponse? findVfuncUsingInterfaces(String name) {
    final strArg = name.toNativeUtf8(allocator: gMalloc).cast<ffi.Char>();
    final implementorOut = gMalloc<ffi.Pointer<ffi.Void>>();
    final ptr = gobjectIntrospection._objectInfoFindVfuncUsingInterfaces(_ptr, strArg, implementorOut);
    gMalloc.free(strArg);
    var imlementor = BaseInfo.$create(implementorOut.value) as ObjectInfo?;
    gMalloc.free(implementorOut);
    if (ptr == ffi.nullptr) {
      return null;
    }
    return FindVFuncUsingInterfacesResponse(BaseInfo.$create(ptr) as VFuncInfo, imlementor!);
  }

  bool get abstract {
    return gobjectIntrospection._objectInfoGetAbstract(_ptr) != 0;
  }

  StructInfo? get classStruct {
    final ptr = gobjectIntrospection._objectInfoGetClassStruct(_ptr);
    return BaseInfo.$create(ptr) as StructInfo?;
  }

  ConstantInfo _getConstant(int index) {
    final ptr = gobjectIntrospection._objectInfoGetConstant(_ptr, index);
    return BaseInfo.$create(ptr) as ConstantInfo;
  }

  FieldInfo _getField(int index) {
    final ptr = gobjectIntrospection._objectInfoGetField(_ptr, index);
    return BaseInfo.$create(ptr) as FieldInfo;
  }

  bool get isFinal {
    return gobjectIntrospection._objectInfoGetFinal(_ptr) != 0;
  }

  bool get fundamental {
    return gobjectIntrospection._objectInfoGetFundamental(_ptr) != 0;
  }

  String? get getValueFunction {
    final ptr = gobjectIntrospection._objectInfoGetGetValueFunction(_ptr);
    return ptr == ffi.nullptr ? null : ptr.cast<ffi.Utf8>().toDartString();
  }

  InterfaceInfo _getInterface(int index) {
    final ptr = gobjectIntrospection._objectInfoGetInterface(_ptr, index);
    return BaseInfo.$create(ptr) as InterfaceInfo;
  }

  FunctionInfo _getMethod(int index) {
    final ptr = gobjectIntrospection._objectInfoGetMethod(_ptr, index);
    return BaseInfo.$create(ptr) as FunctionInfo;
  }

  int get nConstants {
    return gobjectIntrospection._objectInfoGetNConstants(_ptr);
  }

  int get nFields {
    return gobjectIntrospection._objectInfoGetNFields(_ptr);
  }

  int get nInterfaces {
    return gobjectIntrospection._objectInfoGetNInterfaces(_ptr);
  }

  int get nMethods {
    return gobjectIntrospection._objectInfoGetNMethods(_ptr);
  }

  int get nProperties {
    return gobjectIntrospection._objectInfoGetNProperties(_ptr);
  }

  int get nSignals {
    return gobjectIntrospection._objectInfoGetNSignals(_ptr);
  }

  int get nVfuncs {
    return gobjectIntrospection._objectInfoGetNVfuncs(_ptr);
  }

  ObjectInfo? get parent {
    final ptr = gobjectIntrospection._objectInfoGetParent(_ptr);
    return BaseInfo.$create(ptr) as ObjectInfo?;
  }

  PropertyInfo _getProperty(int index) {
    final ptr = gobjectIntrospection._objectInfoGetProperty(_ptr, index);
    return BaseInfo.$create(ptr) as PropertyInfo;
  }

  String? get refFunction {
    final ptr = gobjectIntrospection._objectInfoGetRefFunction(_ptr);
    return ptr == ffi.nullptr ? null : ptr.cast<ffi.Utf8>().toDartString();
  }

  SignalInfo _getSignal(int index) {
    final ptr = gobjectIntrospection._objectInfoGetSignal(_ptr, index);
    return BaseInfo.$create(ptr) as SignalInfo;
  }

  String get typeInit {
    final ptr = gobjectIntrospection._objectInfoGetTypeInit(_ptr);
    return ptr.cast<ffi.Utf8>().toDartString();
  }

  String get typeName {
    final ptr = gobjectIntrospection._objectInfoGetTypeName(_ptr);
    return ptr.cast<ffi.Utf8>().toDartString();
  }

  String? get setValueFunction {
    final ptr = gobjectIntrospection._objectInfoGetSetValueFunction(_ptr);
    return ptr == ffi.nullptr ? null : ptr.cast<ffi.Utf8>().toDartString();
  }

  String? get unrefFunction {
    final ptr = gobjectIntrospection._objectInfoGetUnrefFunction(_ptr);
    return ptr == ffi.nullptr ? null : ptr.cast<ffi.Utf8>().toDartString();
  }

  VFuncInfo _getVfunc(int index) {
    final ptr = gobjectIntrospection._objectInfoGetVfunc(_ptr, index);
    return BaseInfo.$create(ptr) as VFuncInfo;
  }

  List<ConstantInfo> get constants {
    return _ImplicitList(nConstants, _getConstant);
  }

  List<FieldInfo> get fields {
    return _ImplicitList(nFields, _getField);
  }

  List<InterfaceInfo> get interfaces {
    return _ImplicitList(nInterfaces, _getInterface);
  }

  List<FunctionInfo> get methods {
    return _ImplicitList(nMethods, _getMethod);
  }

  List<PropertyInfo> get properties {
    return _ImplicitList(nProperties, _getProperty);
  }

  List<SignalInfo> get signals {
    return _ImplicitList(nSignals, _getSignal);
  }

  List<VFuncInfo> get vfuncs {
    return _ImplicitList(nVfuncs, _getVfunc);
  }
}

class FindMethodUsingInterfacesResponse {
  final FunctionInfo? functionInfo;
  final ObjectInfo? implementor;

  const FindMethodUsingInterfacesResponse(this.functionInfo, this.implementor);
}

class FindVFuncUsingInterfacesResponse {
  final VFuncInfo? vfuncInfo;
  final ObjectInfo? implementor;

  const FindVFuncUsingInterfacesResponse(this.vfuncInfo, this.implementor);
}

class InterfaceInfo extends RegisteredTypeInfo {
  InterfaceInfo._fromPtr(ffi.Pointer<ffi.Void> ptr) : super._fromPtr(ptr);

  FunctionInfo? findMethod(String name) {
    final strArg = name.toNativeUtf8(allocator: gMalloc).cast<ffi.Char>();
    final ptr = gobjectIntrospection._interfaceInfoFindMethod(_ptr, strArg);
    gMalloc.free(strArg);
    return BaseInfo.$create(ptr) as FunctionInfo?;
  }

  SignalInfo? findSignal(String name) {
    final strArg = name.toNativeUtf8(allocator: gMalloc).cast<ffi.Char>();
    final ptr = gobjectIntrospection._interfaceInfoFindSignal(_ptr, strArg);
    gMalloc.free(strArg);
    return BaseInfo.$create(ptr) as SignalInfo?;
  }

  VFuncInfo? findVfunc(String name) {
    final strArg = name.toNativeUtf8(allocator: gMalloc).cast<ffi.Char>();
    final ptr = gobjectIntrospection._interfaceInfoFindVfunc(_ptr, strArg);
    gMalloc.free(strArg);
    return BaseInfo.$create(ptr) as VFuncInfo?;
  }

  ConstantInfo _getConstant(int index) {
    final ptr = gobjectIntrospection._interfaceInfoGetConstant(_ptr, index);
    return BaseInfo.$create(ptr) as ConstantInfo;
  }

  StructInfo get ifaceStruct {
    final ptr = gobjectIntrospection._interfaceInfoGetIfaceStruct(_ptr);
    return BaseInfo.$create(ptr) as StructInfo;
  }

  FunctionInfo _getMethod(int index) {
    final ptr = gobjectIntrospection._interfaceInfoGetMethod(_ptr, index);
    return BaseInfo.$create(ptr) as FunctionInfo;
  }

  int get nConstants {
    return gobjectIntrospection._interfaceInfoGetNConstants(_ptr);
  }

  int get nMethods {
    return gobjectIntrospection._interfaceInfoGetNMethods(_ptr);
  }

  int get nPrerequisites {
    return gobjectIntrospection._interfaceInfoGetNPrerequisites(_ptr);
  }

  int get nProperties {
    return gobjectIntrospection._interfaceInfoGetNProperties(_ptr);
  }

  int get nSignals {
    return gobjectIntrospection._interfaceInfoGetNSignals(_ptr);
  }

  int get nVfuncs {
    return gobjectIntrospection._interfaceInfoGetNVfuncs(_ptr);
  }

  BaseInfo _getPrerequisite(int index) {
    final ptr = gobjectIntrospection._interfaceInfoGetPrerequisite(_ptr, index);
    return BaseInfo.$create(ptr) as BaseInfo;
  }

  PropertyInfo _getProperty(int index) {
    final ptr = gobjectIntrospection._interfaceInfoGetProperty(_ptr, index);
    return BaseInfo.$create(ptr) as PropertyInfo;
  }

  SignalInfo _getSignal(int index) {
    final ptr = gobjectIntrospection._interfaceInfoGetSignal(_ptr, index);
    return BaseInfo.$create(ptr) as SignalInfo;
  }

  VFuncInfo _getVfunc(int index) {
    final ptr = gobjectIntrospection._interfaceInfoGetVfunc(_ptr, index);
    return BaseInfo.$create(ptr) as VFuncInfo;
  }

  List<ConstantInfo> get constants {
    return _ImplicitList(nConstants, _getConstant);
  }

  List<FunctionInfo> get methods {
    return _ImplicitList(nMethods, _getMethod);
  }

  List<BaseInfo> get prerequisites {
    return _ImplicitList(nPrerequisites, _getPrerequisite);
  }

  List<PropertyInfo> get properties {
    return _ImplicitList(nProperties, _getProperty);
  }

  List<SignalInfo> get signals {
    return _ImplicitList(nSignals, _getSignal);
  }

  List<VFuncInfo> get vfuncs {
    return _ImplicitList(nVfuncs, _getVfunc);
  }
}

class ConstantInfo extends BaseInfo {
  ConstantInfo._fromPtr(ffi.Pointer<ffi.Void> ptr) : super._fromPtr(ptr);

  TypeInfo get type {
    final ptr = gobjectIntrospection._constantInfoGetType(_ptr);
    return BaseInfo.$create(ptr) as TypeInfo;
  }

  ConstantValue get value {
    if (!_isConstType(type)) {
      return UnknownConstantValue();
    }
    final valueOut = ffi.calloc<_GIArgument>();
    gobjectIntrospection._constantInfoGetValue(_ptr, valueOut);
    try {
      return _readConstValue(type, valueOut.ref);
    } finally {
      ffi.calloc.free(valueOut);
    }
  }

  static bool _isConstType(TypeInfo info) {
    switch (info.tag) {
      case TypeTag.boolean:
      case TypeTag.int8:
      case TypeTag.uint8:
      case TypeTag.int16:
      case TypeTag.uint16:
      case TypeTag.int32:
      case TypeTag.uint32:
      case TypeTag.int64:
      case TypeTag.uint64:
      case TypeTag.float:
      case TypeTag.double:
      case TypeTag.utf8:
      case TypeTag.filename:
      case TypeTag.gtype:
      case TypeTag.unichar:
        return true;
      case TypeTag.array:
        return _isConstType(info.getParamType(0)!);
      case TypeTag.interface:
        return _isConstInterfaceType(info.interface);
      default:
        return false;
    }
  }

  static bool _isConstInterfaceType(BaseInfo? info) {
    if (info == null) {
      return false;
    }
    if (info is EnumInfo) {
      return true;
    }
    return false;
  }

  static ConstantValue _readConstValue(TypeInfo info, _GIArgument valueOut) {
      switch (info.tag) {
        case TypeTag.boolean:
        case TypeTag.int8:
        case TypeTag.uint8:
        case TypeTag.int16:
        case TypeTag.uint16:
        case TypeTag.int32:
        case TypeTag.uint32:
        case TypeTag.int64:
        case TypeTag.uint64:
        case TypeTag.float:
        case TypeTag.double:
        case TypeTag.utf8:
        case TypeTag.filename:
        case TypeTag.gtype:
        case TypeTag.unichar:
          return _readConstValueForBasicType(info.tag, valueOut);
        case TypeTag.array:
          final isZeroTerminated = info.isZeroTerminated;
          final arrayLength = info.arrayLength;
          final arrayType = info.getParamType(0)!;
          final List<ConstantValue> values = _readConstValuesFromPointer(arrayType, valueOut.v_pointer, arrayLength, isZeroTerminated);
          return ListConstantValue(values);
        case TypeTag.interface:
          final interfaceInfo = info.interface;
          if (interfaceInfo is EnumInfo) {
            final value = _readConstValueForBasicType(interfaceInfo.storageType, valueOut) as IntegerConstantValue;
            return EnumConstantValue(interfaceInfo, value);
          }
          return UnknownConstantValue();
        default:
          return UnknownConstantValue();
      }
  }

  static ConstantValue _readConstValueForBasicType(TypeTag tag, _GIArgument valueOut) {
    switch (tag) {
      case TypeTag.boolean:
        return BooleanConstantValue(valueOut.v_boolean != 0);
      case TypeTag.int8:
        return IntegerConstantValue(valueOut.v_int8);
      case TypeTag.uint8:
        return IntegerConstantValue(valueOut.v_uint8);
      case TypeTag.int16:
        return IntegerConstantValue(valueOut.v_int16);
      case TypeTag.uint16:
        return IntegerConstantValue(valueOut.v_uint16);
      case TypeTag.int32:
        return IntegerConstantValue(valueOut.v_int32);
      case TypeTag.uint32:
        return IntegerConstantValue(valueOut.v_uint32);
      case TypeTag.int64:
        return IntegerConstantValue(valueOut.v_int64);
      case TypeTag.uint64:
        return IntegerConstantValue(valueOut.v_uint64);
      case TypeTag.float:
        return FloatConstantValue(valueOut.v_float);
      case TypeTag.double:
        return FloatConstantValue(valueOut.v_double);
      case TypeTag.utf8:
        return StringConstantValue(
            valueOut.v_string.cast<ffi.Utf8>().toDartString());
      case TypeTag.filename:
        if (Platform.isWindows) {
          return StringConstantValue(
              valueOut.v_string.cast<ffi.Utf16>().toDartString());
        }
        return StringConstantValue(
            valueOut.v_string.cast<ffi.Utf8>().toDartString());
      case TypeTag.gtype:
        final info = Repository.getDefault().findByName("GLib", "GType");
        return EnumConstantValue(info!, IntegerConstantValue(valueOut.v_size));
      case TypeTag.unichar:
        return IntegerConstantValue(valueOut.v_uint32);
      default:
        return UnknownConstantValue();
    }
  }

  static List<ConstantValue> _readConstValuesFromPointer(TypeInfo innerType, ffi.Pointer<ffi.Void> vPointer, int arrayLength, bool isZeroTerminated) {
    final List<ConstantValue> values = [];
    for (var i = 0; isZeroTerminated || i < arrayLength; i++) {
      final ConstantValue? value = _readConstValueFromPointer(innerType, vPointer);
      if (isZeroTerminated && _constValueIsZeroish(innerType, value)) {
        break;
      }
      if (value == null) {
        throw StateError('Failed to read constant value');
      }
      values.add(value);
      vPointer = _pointerAdvance(innerType, vPointer);
    }
    return values;
  }

  static ConstantValue? _readConstValueFromPointerAndTag(TypeTag tag, ffi.Pointer<ffi.Void> vPointer) {
    switch (tag) {
      case TypeTag.boolean:
        return BooleanConstantValue(vPointer.cast<ffi.Int8>().value != 0);
      case TypeTag.int8:
        return IntegerConstantValue(vPointer.cast<ffi.Int8>().value);
      case TypeTag.uint8:
        return IntegerConstantValue(vPointer.cast<ffi.Uint8>().value);
      case TypeTag.int16:
        return IntegerConstantValue(vPointer.cast<ffi.Int16>().value);
      case TypeTag.uint16:
        return IntegerConstantValue(vPointer.cast<ffi.Uint16>().value);
      case TypeTag.int32:
        return IntegerConstantValue(vPointer.cast<ffi.Int32>().value);
      case TypeTag.uint32:
        return IntegerConstantValue(vPointer.cast<ffi.Uint32>().value);
      case TypeTag.int64:
        return IntegerConstantValue(vPointer.cast<ffi.Int64>().value);
      case TypeTag.uint64:
        return IntegerConstantValue(vPointer.cast<ffi.Uint64>().value);
      case TypeTag.float:
        return FloatConstantValue(vPointer.cast<ffi.Float>().value);
      case TypeTag.double:
        return FloatConstantValue(vPointer.cast<ffi.Double>().value);
      case TypeTag.utf8:
        if (vPointer == ffi.nullptr) {
          return null;
        }
        return StringConstantValue(vPointer.cast<ffi.Utf8>().toDartString());
      case TypeTag.filename:
        if (vPointer == ffi.nullptr) {
          return null;
        }
        if (Platform.isWindows) {
          return StringConstantValue(vPointer.cast<ffi.Utf16>().toDartString());
        }
        return StringConstantValue(vPointer.cast<ffi.Utf8>().toDartString());
      case TypeTag.gtype:
        final info = Repository.getDefault().findByName("GLib", "GType");
        return EnumConstantValue(info!, IntegerConstantValue(vPointer.cast<ffi.Size>().value));
      case TypeTag.unichar:
        return IntegerConstantValue(vPointer.cast<ffi.Uint32>().value);
      default:
        throw StateError('Unsupported type tag: $tag');
    }
  }

  static ConstantValue? _readConstValueFromPointer(TypeInfo type, ffi.Pointer<ffi.Void> vPointer) {
    switch (type.tag) {
      case TypeTag.boolean:
      case TypeTag.int8:
      case TypeTag.uint8:
      case TypeTag.int16:
      case TypeTag.uint16:
      case TypeTag.int32:
      case TypeTag.uint32:
      case TypeTag.int64:
      case TypeTag.uint64:
      case TypeTag.float:
      case TypeTag.double:
      case TypeTag.utf8:
      case TypeTag.filename:
      case TypeTag.gtype:
      case TypeTag.unichar:
        return _readConstValueFromPointerAndTag(type.tag, vPointer);
      case TypeTag.array:
        final isZeroTerminated = type.isZeroTerminated;
        final arrayLength = type.arrayLength;
        final arrayType = type.getParamType(0)!;
        final pointer = vPointer.cast<ffi.Pointer<ffi.Void>>().value;
        if (pointer == ffi.nullptr) {
          return null;
        }
        final List<ConstantValue> values = _readConstValuesFromPointer(arrayType, pointer, arrayLength, isZeroTerminated);
        return ListConstantValue(values);
      case TypeTag.interface:
        final interfaceInfo = type.interface;
        if (interfaceInfo is EnumInfo) {
          final value = _readConstValueFromPointerAndTag(interfaceInfo.storageType, vPointer)! as IntegerConstantValue;
          return EnumConstantValue(interfaceInfo, value);
        }
        throw StateError('Unsupported interface type: $interfaceInfo');
      default:
        throw StateError('Unsupported type: $type');
    }
  }

  static bool _constValueIsZeroish(TypeInfo innerType, ConstantValue? value) {
    if (value == null) {
      return true;
    }
    if (value is IntegerConstantValue) {
      return value.value == 0;
    }
    if (value is FloatConstantValue) {
      return value.value == 0.0;
    }
    return false;
  }

  static ffi.Pointer<ffi.Void> _pointerAdvance(TypeInfo innerType, ffi.Pointer<ffi.Void> vPointer) {
    final tag = innerType.tag;
    if (tag == TypeTag.array) {
      return vPointer.cast<ffi.Pointer<ffi.Void>>().elementAt(1).cast<ffi.Void>();
    }
    if (tag == TypeTag.interface) {
      final interfaceInfo = innerType.interface;
      if (interfaceInfo is EnumInfo) {
        return _pointerAdvanceFromTag(interfaceInfo.storageType, vPointer);
      }
      throw StateError('Unsupported interface type: $interfaceInfo');
    }
    return _pointerAdvanceFromTag(tag, vPointer);
  }

  static ffi.Pointer<ffi.Void> _pointerAdvanceFromTag(TypeTag tag, ffi.Pointer<ffi.Void> vPointer) {
    switch (tag) {
      case TypeTag.boolean:
        return vPointer.cast<ffi.Int>().elementAt(1).cast<ffi.Void>();
      case TypeTag.int8:
      case TypeTag.uint8:
        return vPointer.cast<ffi.Int8>().elementAt(1).cast<ffi.Void>();
      case TypeTag.int16:
      case TypeTag.uint16:
      case TypeTag.unichar:
        return vPointer.cast<ffi.Int16>().elementAt(1).cast<ffi.Void>();
      case TypeTag.int32:
      case TypeTag.uint32:
        return vPointer.cast<ffi.Int32>().elementAt(1).cast<ffi.Void>();
      case TypeTag.int64:
      case TypeTag.uint64:
        return vPointer.cast<ffi.Int64>().elementAt(1).cast<ffi.Void>();
      case TypeTag.float:
        return vPointer.cast<ffi.Float>().elementAt(1).cast<ffi.Void>();
      case TypeTag.double:
        return vPointer.cast<ffi.Double>().elementAt(1).cast<ffi.Void>();
      case TypeTag.utf8:
      case TypeTag.filename:
        return vPointer.cast<ffi.Pointer<ffi.Void>>().elementAt(1).cast<ffi.Void>();
      case TypeTag.gtype:
        return vPointer.cast<ffi.Size>().elementAt(1).cast<ffi.Void>();
      default:
        throw StateError('Unsupported type tag: $tag');
    }
  }
}

sealed class ConstantValue {}

final class IntegerConstantValue extends ConstantValue {
  final int value;

  IntegerConstantValue(this.value);
}

final class FloatConstantValue extends ConstantValue {
  final double value;

  FloatConstantValue(this.value);
}

final class StringConstantValue extends ConstantValue {
  final String value;

  StringConstantValue(this.value);
}

final class BooleanConstantValue extends ConstantValue implements IntegerConstantValue {
  final bool boolValue;

  @override
  int get value => boolValue ? 1 : 0;

  BooleanConstantValue(this.boolValue);
}

final class EnumConstantValue extends ConstantValue implements IntegerConstantValue {
  final BaseInfo enumInfo;
  final IntegerConstantValue innerValue;

  @override
  int get value => innerValue.value;

  EnumConstantValue(this.enumInfo, this.innerValue);
}

final class ListConstantValue extends ConstantValue {
  final List<ConstantValue> values;

  ListConstantValue(this.values);
}

final class UnknownConstantValue extends ConstantValue {
  UnknownConstantValue();
}



class UnionInfo extends RegisteredTypeInfo {
  UnionInfo._fromPtr(ffi.Pointer<ffi.Void> ptr) : super._fromPtr(ptr);

  FunctionInfo? findMethod(String name) {
    final strArg = name.toNativeUtf8(allocator: gMalloc).cast<ffi.Char>();
    final ptr = gobjectIntrospection._unionInfoFindMethod(_ptr, strArg);
    gMalloc.free(strArg);
    return BaseInfo.$create(ptr) as FunctionInfo?;
  }

  int get alignment {
    return gobjectIntrospection._unionInfoGetAlignment(_ptr);
  }

  String? get copyFunction {
    final ptr = gobjectIntrospection._unionInfoGetCopyFunction(_ptr);
    return ptr == ffi.nullptr ? null : ptr.cast<ffi.Utf8>().toDartString();
  }

  ConstantInfo _getDiscriminator(int index) {
    final ptr = gobjectIntrospection._unionInfoGetDiscriminator(_ptr, index);
    return BaseInfo.$create(ptr) as ConstantInfo;
  }

  TypeInfo? get discriminatorType {
    final ptr = gobjectIntrospection._unionInfoGetDiscriminatorType(_ptr);
    return BaseInfo.$create(ptr) as TypeInfo?;
  }

  int get discriminatorOffset {
    return gobjectIntrospection._unionInfoGetDiscriminatorOffset(_ptr);
  }

  FieldInfo _getField(int index) {
    final ptr = gobjectIntrospection._unionInfoGetField(_ptr, index);
    return BaseInfo.$create(ptr) as FieldInfo;
  }

  FunctionInfo _getMethod(int index) {
    final ptr = gobjectIntrospection._unionInfoGetMethod(_ptr, index);
    return BaseInfo.$create(ptr) as FunctionInfo;
  }

  String? get freeFunction {
    final ptr = gobjectIntrospection._unionInfoGetFreeFunction(_ptr);
    return ptr == ffi.nullptr ? null : ptr.cast<ffi.Utf8>().toDartString();
  }

  int get nFields {
    return gobjectIntrospection._unionInfoGetNFields(_ptr);
  }

  int get nMethods {
    return gobjectIntrospection._unionInfoGetNMethods(_ptr);
  }

  int get size {
    return gobjectIntrospection._unionInfoGetSize(_ptr);
  }

  bool get isDiscriminated {
    return gobjectIntrospection._unionInfoIsDiscriminated(_ptr) != 0;
  }

  List<FieldInfo> get fields {
    return _ImplicitList(nFields, _getField);
  }

  List<FunctionInfo> get methods {
    return _ImplicitList(nMethods, _getMethod);
  }

  List<ConstantInfo> get discriminators {
    if (!isDiscriminated) {
      throw StateError('Union is not discriminated');
    }
    return _ImplicitList(nFields, _getDiscriminator);
  }
}

class ValueInfo extends BaseInfo {
  ValueInfo._fromPtr(ffi.Pointer<ffi.Void> ptr) : super._fromPtr(ptr);

  int get value {
    return gobjectIntrospection._valueInfoGetValue(_ptr);
  }
}

class SignalInfo extends CallableInfo {
  SignalInfo._fromPtr(ffi.Pointer<ffi.Void> ptr) : super._fromPtr(ptr);

  VFuncInfo? get classClosure {
    final ptr = gobjectIntrospection._signalInfoGetClassClosure(_ptr);
    return BaseInfo.$create(ptr) as VFuncInfo?;
  }

  SignalFlags get flags {
    return SignalFlags(gobjectIntrospection._signalInfoGetFlags(_ptr));
  }

  bool get trueStopsEmit {
    return gobjectIntrospection._signalInfoTrueStopsEmit(_ptr) != 0;
  }
}

class VFuncInfo extends CallableInfo {
  VFuncInfo._fromPtr(ffi.Pointer<ffi.Void> ptr) : super._fromPtr(ptr);

  VFuncInfoFlags get flags {
    return VFuncInfoFlags(gobjectIntrospection._vfuncInfoGetFlags(_ptr));
  }

  FunctionInfo? get invoker {
    final ptr = gobjectIntrospection._vfuncInfoGetInvoker(_ptr);
    return BaseInfo.$create(ptr) as FunctionInfo?;
  }

  int get offset {
    return gobjectIntrospection._vfuncInfoGetOffset(_ptr);
  }

  SignalInfo? get signal {
    final ptr = gobjectIntrospection._vfuncInfoGetSignal(_ptr);
    return BaseInfo.$create(ptr) as SignalInfo?;
  }
}

class PropertyInfo extends BaseInfo {
  PropertyInfo._fromPtr(ffi.Pointer<ffi.Void> ptr) : super._fromPtr(ptr);
  
  ParamFlags get flags {
    return ParamFlags(gobjectIntrospection._propertyInfoGetFlags(_ptr));
  }
  
  FunctionInfo? get getter {
    final ptr = gobjectIntrospection._propertyInfoGetGetter(_ptr);
    return BaseInfo.$create(ptr) as FunctionInfo?;
  }
  
  Transfer get ownershipTransfer {
    return Transfer(gobjectIntrospection._propertyInfoGetOwnershipTransfer(_ptr));
  }

  FunctionInfo? get setter {
    final ptr = gobjectIntrospection._propertyInfoGetSetter(_ptr);
    return BaseInfo.$create(ptr) as FunctionInfo?;
  }

  TypeInfo get type {
    final ptr = gobjectIntrospection._propertyInfoGetType(_ptr);
    return BaseInfo.$create(ptr) as TypeInfo;
  }
}

class FieldInfo extends BaseInfo {
  FieldInfo._fromPtr(ffi.Pointer<ffi.Void> ptr) : super._fromPtr(ptr);

  FieldInfoFlags get flags {
    return FieldInfoFlags(gobjectIntrospection._fieldInfoGetFlags(_ptr));
  }

  int get offset {
    return gobjectIntrospection._fieldInfoGetOffset(_ptr);
  }

  TypeInfo get type {
    final ptr = gobjectIntrospection._fieldInfoGetType(_ptr);
    return BaseInfo.$create(ptr) as TypeInfo;
  }

  int get size {
    return gobjectIntrospection._fieldInfoGetSize(_ptr);
  }
}

class ArgInfo extends BaseInfo {
  ArgInfo._fromPtr(ffi.Pointer<ffi.Void> ptr) : super._fromPtr(ptr);

  int get closure {
    return gobjectIntrospection._argInfoGetClosure(_ptr);
  }

  int get destroy {
    return gobjectIntrospection._argInfoGetDestroy(_ptr);
  }

  Direction get direction {
    return Direction(gobjectIntrospection._argInfoGetDirection(_ptr));
  }

  Transfer get ownershipTransfer {
    return Transfer(gobjectIntrospection._argInfoGetOwnershipTransfer(_ptr));
  }

  ScopeType get scope {
    return ScopeType(gobjectIntrospection._argInfoGetScope(_ptr));
  }

  TypeInfo get type {
    final ptr = gobjectIntrospection._argInfoGetType(_ptr);
    return BaseInfo.$create(ptr) as TypeInfo;
  }

  bool get isCallerAllocates {
    return gobjectIntrospection._argInfoIsCallerAllocates(_ptr) != 0;
  }

  bool get isOptional {
    return gobjectIntrospection._argInfoIsOptional(_ptr) != 0;
  }

  bool get isReturnValue {
    return gobjectIntrospection._argInfoIsReturnValue(_ptr) != 0;
  }

  bool get isSkip {
    return gobjectIntrospection._argInfoIsSkip(_ptr) != 0;
  }

  bool get mayBeNull {
    return gobjectIntrospection._argInfoMayBeNull(_ptr) != 0;
  }
}

class TypeInfo extends BaseInfo {
  TypeInfo._fromPtr(ffi.Pointer<ffi.Void> ptr) : super._fromPtr(ptr);

  int get arrayFixedSize {
    return gobjectIntrospection._typeInfoGetArrayFixedSize(_ptr);
  }

  int get arrayLength {
    return gobjectIntrospection._typeInfoGetArrayLength(_ptr);
  }

  ArrayType get arrayType {
    return ArrayType(gobjectIntrospection._typeInfoGetArrayType(_ptr));
  }

  BaseInfo? get interface {
    final ptr = gobjectIntrospection._typeInfoGetInterface(_ptr);
    return BaseInfo.$create(ptr);
  }

  TypeInfo? getParamType(int n) {
    var typeTag = tag;
    if (typeTag != TypeTag.interface && typeTag != TypeTag.array && typeTag != TypeTag.glist && typeTag != TypeTag.gslist && typeTag != TypeTag.ghash) {
      return null;
    }
    if (typeTag != TypeTag.interface && typeTag != TypeTag.ghash && n > 0) {
      return null;
    }
    if (typeTag != TypeTag.interface && n > 1) {
      return null;
    }
    final ptr = gobjectIntrospection._typeInfoGetParamType(_ptr, n);
    if (ptr == ffi.nullptr) {
      return null;
    }
    return BaseInfo.$create(ptr) as TypeInfo;
  }

  TypeTag get storageType {
    return TypeTag(gobjectIntrospection._typeInfoGetStorageType(_ptr));
  }

  TypeTag get tag {
    return TypeTag(gobjectIntrospection._typeInfoGetTag(_ptr));
  }

  bool get isPointer {
    return gobjectIntrospection._typeInfoIsPointer(_ptr) != 0;
  }

  bool get isZeroTerminated {
    return gobjectIntrospection._typeInfoIsZeroTerminated(_ptr) != 0;
  }
}

final class Typelib {
  static final Map<int, Typelib> _typelibs = <int, Typelib>{};
  final ffi.Pointer<ffi.Void> _ptr;

  Typelib._fromPtr(this._ptr) {
    _typelibs[_ptr.address] = this;
  }

  static Typelib? $create(ffi.Pointer<ffi.Void> ptr) {
    return _typelibs[ptr.address] ??= Typelib._fromPtr(ptr);
  }

  String get namespace {
    final ptr = gobjectIntrospection._typelibGetNamespace(_ptr);
    return ptr.cast<ffi.Utf8>().toDartString();
  }

  @override
  String toString() {
    return 'Typelib(namespace: $namespace)';
  }
}

final class _GList extends ffi.Struct {
  external ffi.Pointer<ffi.Void> data;

  external ffi.Pointer<_GList> next;

  external ffi.Pointer<_GList> prev;
}

enum RepositoryLoadFlags {
  none,
  lazy,
}

int getMajorVersion() {
  return gobjectIntrospection._getMajorVersion();
}

int getMicroVersion() {
  return gobjectIntrospection._getMicroVersion();
}

int getMinorVersion() {
  return gobjectIntrospection._getMinorVersion();
}

List<String> _nullTerminatedStringArrayToDart(ffi.Pointer<ffi.Pointer<ffi.Char>> ptr) {
  final result = <String>[];
  var i = 0;
  while (true) {
    var strPointer = ptr.elementAt(i).value;
    if (strPointer == ffi.nullptr) {
      break;
    }
    result.add(strPointer.cast<ffi.Utf8>().toDartString());
    gMalloc.free(strPointer);
    i++;
  }

  gMalloc.free(ptr);
  return result;
}

List<String> _stringGListToDart(ffi.Pointer<_GList> ptr) {
  final result = <String>[];
  while (ptr != ffi.nullptr) {
    var strPointer = ptr.ref.data;
    result.add(strPointer.cast<ffi.Utf8>().toDartString());
    gMalloc.free(strPointer);
    ptr = ptr.ref.next;
  }

  gMalloc.free(ptr);
  return result;
}

final class FunctionInfoFlags {
  final int value;

  const FunctionInfoFlags(this.value);

  static const FunctionInfoFlags isMethod = FunctionInfoFlags(1 << 0);

  static const FunctionInfoFlags isConstructor = FunctionInfoFlags(1 << 1);

  static const FunctionInfoFlags isGetter = FunctionInfoFlags(1 << 2);

  static const FunctionInfoFlags isSetter = FunctionInfoFlags(1 << 3);

  static const FunctionInfoFlags wrapVFunc = FunctionInfoFlags(1 << 4);

  bool hasFlag(FunctionInfoFlags flag) {
    return (value & flag.value) != 0;
  }

  @override
  String toString() {
    return 'FunctionInfoFlags(value: $value)';
  }


  @override
  bool operator ==(Object other) {
    if (other is FunctionInfoFlags) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  FunctionInfoFlags operator|(FunctionInfoFlags other) {
    return FunctionInfoFlags(value | other.value);
  }



}

final class SignalFlags {
  static const int G_SIGNAL_RUN_FIRST = 1;
  static const int G_SIGNAL_RUN_LAST = 2;
  static const int G_SIGNAL_RUN_CLEANUP = 4;
  static const int G_SIGNAL_NO_RECURSE = 8;
  static const int G_SIGNAL_DETAILED = 16;
  static const int G_SIGNAL_ACTION = 32;
  static const int G_SIGNAL_NO_HOOKS = 64;
  static const int G_SIGNAL_MUST_COLLECT = 128;
  static const int G_SIGNAL_DEPRECATED = 256;
  static const int G_SIGNAL_ACCUMULATOR_FIRST_RUN = 131072;

  final int value;

  const SignalFlags(this.value);

  static const SignalFlags runFirst = SignalFlags(G_SIGNAL_RUN_FIRST);
  static const SignalFlags runLast = SignalFlags(G_SIGNAL_RUN_LAST);
  static const SignalFlags runCleanup = SignalFlags(G_SIGNAL_RUN_CLEANUP);
  static const SignalFlags noRecurse = SignalFlags(G_SIGNAL_NO_RECURSE);
  static const SignalFlags detailed = SignalFlags(G_SIGNAL_DETAILED);
  static const SignalFlags action = SignalFlags(G_SIGNAL_ACTION);
  static const SignalFlags noHooks = SignalFlags(G_SIGNAL_NO_HOOKS);
  static const SignalFlags mustCollect = SignalFlags(G_SIGNAL_MUST_COLLECT);
  static const SignalFlags deprecated = SignalFlags(G_SIGNAL_DEPRECATED);
  static const SignalFlags accumulatorFirstRun = SignalFlags(G_SIGNAL_ACCUMULATOR_FIRST_RUN);

  @override
  bool operator ==(Object other) {
    if (other is SignalFlags) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'SignalFlags($value)';

  SignalFlags operator|(SignalFlags other) {
    return SignalFlags(value | other.value);
  }

  bool hasFlag(SignalFlags flag) {
    return (value & flag.value) != 0;
  }
}

final class ParamFlags {
  static const int G_PARAM_READABLE = 1;
  static const int G_PARAM_WRITABLE = 2;
  static const int G_PARAM_READWRITE = 3;
  static const int G_PARAM_CONSTRUCT = 4;
  static const int G_PARAM_CONSTRUCT_ONLY = 8;
  static const int G_PARAM_LAX_VALIDATION = 16;
  static const int G_PARAM_STATIC_NAME = 32;
  static const int G_PARAM_PRIVATE = 32;
  static const int G_PARAM_STATIC_NICK = 64;
  static const int G_PARAM_STATIC_BLURB = 128;
  static const int G_PARAM_EXPLICIT_NOTIFY = 1073741824;
  static const int G_PARAM_DEPRECATED = -2147483648;

  final int value;
  const ParamFlags(this.value);

  static const ParamFlags readable = ParamFlags(G_PARAM_READABLE);
  static const ParamFlags writable = ParamFlags(G_PARAM_WRITABLE);
  static const ParamFlags readwrite = ParamFlags(G_PARAM_READWRITE);
  static const ParamFlags construct = ParamFlags(G_PARAM_CONSTRUCT);
  static const ParamFlags constructOnly = ParamFlags(G_PARAM_CONSTRUCT_ONLY);
  static const ParamFlags laxValidation = ParamFlags(G_PARAM_LAX_VALIDATION);
  static const ParamFlags staticName = ParamFlags(G_PARAM_STATIC_NAME);
  static const ParamFlags private = ParamFlags(G_PARAM_PRIVATE);
  static const ParamFlags staticNick = ParamFlags(G_PARAM_STATIC_NICK);
  static const ParamFlags staticBlurb = ParamFlags(G_PARAM_STATIC_BLURB);
  static const ParamFlags explicitNotify = ParamFlags(G_PARAM_EXPLICIT_NOTIFY);
  static const ParamFlags deprecated = ParamFlags(G_PARAM_DEPRECATED);

  @override
  bool operator ==(Object other) {
    if (other is ParamFlags) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'ParamFlags($value)';

  ParamFlags operator|(ParamFlags other) {
    return ParamFlags(value | other.value);
  }

  bool hasFlag(ParamFlags flag) {
    return (value & flag.value) != 0;
  }
}


final class VFuncInfoFlags {
  static const int GI_VFUNC_MUST_CHAIN_UP = 1;
  static const int GI_VFUNC_MUST_OVERRIDE = 2;
  static const int GI_VFUNC_MUST_NOT_OVERRIDE = 4;
  static const int GI_VFUNC_THROWS = 8;

  final int value;
  const VFuncInfoFlags(this.value);

  static const VFuncInfoFlags mustChainUp = VFuncInfoFlags(GI_VFUNC_MUST_CHAIN_UP);
  static const VFuncInfoFlags mustOverride = VFuncInfoFlags(GI_VFUNC_MUST_OVERRIDE);
  static const VFuncInfoFlags mustNotOverride = VFuncInfoFlags(GI_VFUNC_MUST_NOT_OVERRIDE);
  static const VFuncInfoFlags throws = VFuncInfoFlags(GI_VFUNC_THROWS);

  @override
  bool operator ==(Object other) {
    if (other is VFuncInfoFlags) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'VFuncInfoFlags($value)';

  VFuncInfoFlags operator|(VFuncInfoFlags other) {
    return VFuncInfoFlags(value | other.value);
  }

  bool hasFlag(VFuncInfoFlags flag) {
    return (value & flag.value) != 0;
  }
}

final class FieldInfoFlags {
  static const int GI_FIELD_IS_READABLE = 1;
  static const int GI_FIELD_IS_WRITABLE = 2;

  final int value;

  const FieldInfoFlags(this.value);

  static const FieldInfoFlags readable = FieldInfoFlags(GI_FIELD_IS_READABLE);

  static const FieldInfoFlags writable = FieldInfoFlags(GI_FIELD_IS_WRITABLE);

  @override
  bool operator ==(Object other) {
    if (other is FieldInfoFlags) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'FieldInfoFlags($value)';

  FieldInfoFlags operator|(FieldInfoFlags other) {
    return FieldInfoFlags(value | other.value);
  }

  bool hasFlag(FieldInfoFlags flag) {
    return (value & flag.value) != 0;
  }
}

final class Direction {
  static const int GI_DIRECTION_IN = 0;
  static const int GI_DIRECTION_OUT = 1;
  static const int GI_DIRECTION_INOUT = 2;

  final int value;

  const Direction(this.value);

  static const Direction in_ = Direction(GI_DIRECTION_IN);

  static const Direction out = Direction(GI_DIRECTION_OUT);

  static const Direction inout = Direction(GI_DIRECTION_INOUT);

  @override
  bool operator ==(Object other) {
    if (other is Direction) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Direction($value)';

  Direction operator|(Direction other) {
    return Direction(value | other.value);
  }

  bool hasFlag(Direction flag) {
    return (value & flag.value) != 0;
  }
}

final class ScopeType {
  static const int GI_SCOPE_TYPE_INVALID = 0;
  static const int GI_SCOPE_TYPE_CALL = 1;
  static const int GI_SCOPE_TYPE_ASYNC = 2;
  static const int GI_SCOPE_TYPE_NOTIFIED = 3;
  static const int GI_SCOPE_TYPE_FOREVER = 4;

  final int value;

  const ScopeType(this.value);

  static const ScopeType invalid = ScopeType(GI_SCOPE_TYPE_INVALID);
  static const ScopeType call = ScopeType(GI_SCOPE_TYPE_CALL);
  static const ScopeType async = ScopeType(GI_SCOPE_TYPE_ASYNC);
  static const ScopeType notified = ScopeType(GI_SCOPE_TYPE_NOTIFIED);
  static const ScopeType forever = ScopeType(GI_SCOPE_TYPE_FOREVER);

  @override
  bool operator ==(Object other) {
    if (other is ScopeType) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'ScopeType($value)';
}

final class ArrayType {
  static const int GI_ARRAY_TYPE_C = 0;
  static const int GI_ARRAY_TYPE_ARRAY = 1;
  static const int GI_ARRAY_TYPE_PTR_ARRAY = 2;
  static const int GI_ARRAY_TYPE_BYTE_ARRAY = 3;

  final int value;

  const ArrayType(this.value);

  static const ArrayType c = ArrayType(GI_ARRAY_TYPE_C);

  static const ArrayType array = ArrayType(GI_ARRAY_TYPE_ARRAY);

  static const ArrayType ptrArray = ArrayType(GI_ARRAY_TYPE_PTR_ARRAY);

  static const ArrayType byteArray = ArrayType(GI_ARRAY_TYPE_BYTE_ARRAY);

  @override
  bool operator ==(Object other) {
    if (other is ArrayType) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'ArrayType($value)';
}

final class Transfer {
  final int value;

  const Transfer(this.value);

  static const Transfer nothing = Transfer(0);

  static const Transfer container = Transfer(1);

  static const Transfer everything = Transfer(2);

  @override
  String toString() {
    return 'Transfer(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    if (other is Transfer) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;
}

final class TypeTag {
  static const int GI_TYPE_TAG_VOID = 0;
  static const int GI_TYPE_TAG_BOOLEAN = 1;
  static const int GI_TYPE_TAG_INT8 = 2;
  static const int GI_TYPE_TAG_UINT8 = 3;
  static const int GI_TYPE_TAG_INT16 = 4;
  static const int GI_TYPE_TAG_UINT16 = 5;
  static const int GI_TYPE_TAG_INT32 = 6;
  static const int GI_TYPE_TAG_UINT32 = 7;
  static const int GI_TYPE_TAG_INT64 = 8;
  static const int GI_TYPE_TAG_UINT64 = 9;
  static const int GI_TYPE_TAG_FLOAT = 10;
  static const int GI_TYPE_TAG_DOUBLE = 11;
  static const int GI_TYPE_TAG_GTYPE = 12;
  static const int GI_TYPE_TAG_UTF8 = 13;
  static const int GI_TYPE_TAG_FILENAME = 14;
  static const int GI_TYPE_TAG_ARRAY = 15;
  static const int GI_TYPE_TAG_INTERFACE = 16;
  static const int GI_TYPE_TAG_GLIST = 17;
  static const int GI_TYPE_TAG_GSLIST = 18;
  static const int GI_TYPE_TAG_GHASH = 19;
  static const int GI_TYPE_TAG_ERROR = 20;
  static const int GI_TYPE_TAG_UNICHAR = 21;

  final int value;

  const TypeTag(this.value);

  static const void_ = const TypeTag(GI_TYPE_TAG_VOID);
  static const boolean = const TypeTag(GI_TYPE_TAG_BOOLEAN);
  static const int8 = const TypeTag(GI_TYPE_TAG_INT8);
  static const uint8 = const TypeTag(GI_TYPE_TAG_UINT8);
  static const int16 = const TypeTag(GI_TYPE_TAG_INT16);
  static const uint16 = const TypeTag(GI_TYPE_TAG_UINT16);
  static const int32 = const TypeTag(GI_TYPE_TAG_INT32);
  static const uint32 = const TypeTag(GI_TYPE_TAG_UINT32);
  static const int64 = const TypeTag(GI_TYPE_TAG_INT64);
  static const uint64 = const TypeTag(GI_TYPE_TAG_UINT64);
  static const float = const TypeTag(GI_TYPE_TAG_FLOAT);
  static const double = const TypeTag(GI_TYPE_TAG_DOUBLE);
  static const gtype = const TypeTag(GI_TYPE_TAG_GTYPE);
  static const utf8 = const TypeTag(GI_TYPE_TAG_UTF8);
  static const filename = const TypeTag(GI_TYPE_TAG_FILENAME);
  static const array = const TypeTag(GI_TYPE_TAG_ARRAY);
  static const interface = const TypeTag(GI_TYPE_TAG_INTERFACE);
  static const glist = const TypeTag(GI_TYPE_TAG_GLIST);
  static const gslist = const TypeTag(GI_TYPE_TAG_GSLIST);
  static const ghash = const TypeTag(GI_TYPE_TAG_GHASH);
  static const error = const TypeTag(GI_TYPE_TAG_ERROR);
  static const unichar = const TypeTag(GI_TYPE_TAG_UNICHAR);

  @override
  bool operator ==(other) {
    if (other is TypeTag) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    switch (this) {
      case void_:
        return 'void';
      case boolean:
        return 'bool';
      case int8:
        return 'int8';
      case uint8:
        return 'uint8';
      case int16:
        return 'int16';
      case uint16:
        return 'uint16';
      case int32:
        return 'int32';
      case uint32:
        return 'uint32';
      case int64:
        return 'int64';
      case uint64:
        return 'uint64';
      case float:
        return 'float';
      case double:
        return 'double';
      case gtype:
        return 'gtype';
      case utf8:
        return 'string';
      case filename:
        return 'filename';
      case array:
        return 'array';
      case interface:
        return 'interface';
      case glist:
        return 'glist';
      case gslist:
        return 'gslist';
      case ghash:
        return 'ghash';
      case error:
        return 'error';
      case unichar:
        return 'wchar';
      default:
        return 'unknown($value)';
    }
  }
}
