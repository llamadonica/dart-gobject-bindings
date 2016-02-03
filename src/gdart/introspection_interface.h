// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
#ifndef __INTROSPECTION_INTERFACE_H__
#define __INTROSPECTION_INTERFACE_H__

#include <glib-object.h>
#include <girepository.h>
#include <girffi.h>

#include "../include/dart_api.h"
#include "../include/dart_native_api.h"
#include "bridge_context_forward.h"

typedef struct _InterfaceInfoKlass InterfaceInfoKlass;
typedef struct _CallableInfoKlass CallableInfoKlass;
typedef struct _FunctionInfoKlass FunctionInfoKlass;
typedef struct _VFuncInfoKlass VFuncInfoKlass;
typedef struct _ArgInfoKlass ArgInfoKlass;
typedef struct _TypeInfoKlass TypeInfoKlass;
typedef struct _EnumInfoKlass EnumInfoKlass;
typedef struct _RegisteredTypeInfoKlass RegisteredTypeInfoKlass;
typedef struct _ObjectInfoKlass ObjectInfoKlass;
typedef struct _StructUnionInfoKlass StructUnionInfoKlass;

typedef void (*GIFunctionInvokerDestroyFunc)(
  GIFunctionInvoker* invoker, gpointer user_data);
typedef void (*AddressPeerDestroyFunc)(gpointer peer_data);

struct _InterfaceInfoKlass {
  gpointer (*copy) (gpointer object);
  void (*free) (gpointer object);
  gboolean (*get_name) (gpointer object,
                        GdartBridgeContext *self,
                        gchar **result_out,
                        Dart_Handle *dart_error,
                        GError **error);
  gboolean (*get_type) (gpointer object,
                        GdartBridgeContext *self,
                        GIInfoType *result_out,
                        Dart_Handle *dart_error,
                        GError **error);
  gboolean (*get_namespace) (gpointer object,
                        GdartBridgeContext *self,
                        gchar **result_out,
                        Dart_Handle *dart_error,
                        GError **error);
  const CallableInfoKlass* (*cast_to_callable_info) (gpointer object);
  const EnumInfoKlass* (*cast_to_enum_info) (gpointer object);
  const RegisteredTypeInfoKlass* (*cast_to_registered_type_info) (gpointer object);
  const StructUnionInfoKlass* (*cast_to_struct_union_info) (gpointer object);
};

struct _TypeInfoKlass {
  gpointer (*copy) (gpointer object);
  void (*free) (gpointer object);
  gboolean (*get_name) (gpointer object,
                        GdartBridgeContext *self,
                        gchar **result_out,
                        Dart_Handle *dart_error,
                        GError **error);
  gboolean (*get_type) (gpointer object,
                        GdartBridgeContext *self,
                        GIInfoType *result_out,
                        Dart_Handle *dart_error,
                        GError **error);
  gboolean (*get_namespace) (gpointer object,
                        GdartBridgeContext *self,
                        gchar **result_out,
                        Dart_Handle *dart_error,
                        GError **error);
  gboolean (*get_tag) (gpointer object,
                       GdartBridgeContext *self,
                       GITypeTag *result_out,
                       Dart_Handle *dart_error,
                       GError **error);
  gboolean (*get_interface) (gpointer object,
                             GdartBridgeContext *self,
                             gpointer *result_out,
                             const InterfaceInfoKlass **result_klass_out,
                             Dart_Handle *dart_error,
                             GError **error);
  gboolean (*get_array_length) (gpointer object,
                                GdartBridgeContext *self,
                                gint *result_out,
                                Dart_Handle *dart_error,
                                GError **error);
  gboolean (*is_zero_terminated) (gpointer object,
                                  GdartBridgeContext *self,
                                  gboolean *result_out,
                                  Dart_Handle *dart_error,
                                  GError **error);
  gboolean (*get_array_fixed_size) (gpointer object,
                                    GdartBridgeContext *self,
                                    gboolean *result_out,
                                    Dart_Handle *dart_error,
                                    GError **error);
  gboolean (*get_param_type) (gpointer object,
                              GdartBridgeContext *self,
                              gint index,
                              gpointer *result_out,
                              const TypeInfoKlass **result_klass_out,
                              Dart_Handle *dart_error,
                              GError **error);
};

struct _ArgInfoKlass {
  gpointer (*copy) (gpointer object);
  void (*free) (gpointer object);
  gboolean (*get_name) (gpointer object,
                        GdartBridgeContext *self,
                        gchar **result_out,
                        Dart_Handle *dart_error_out,
                        GError **error);
  gboolean (*_InterfaceInfoKlass_get_type__occluded__) (gpointer object,
                        GdartBridgeContext *self,
                        GIInfoType *result_out,
                        Dart_Handle *dart_error,
                        GError **error);
  gboolean (*get_namespace) (gpointer object,
                        GdartBridgeContext *self,
                        gchar **result_out,
                        Dart_Handle *dart_error,
                        GError **error);
  gboolean (*get_closure) (gpointer object, GdartBridgeContext *self, gint *result_out, Dart_Handle *dart_error_out, GError **error);
  gboolean (*get_destroy) (gpointer object, GdartBridgeContext *self, gint *result_out, Dart_Handle *dart_error_out, GError **error);
  gboolean (*get_direction) (gpointer object, GdartBridgeContext *self, GIDirection *result_out, Dart_Handle *dart_error_out, GError **error);
  gboolean (*get_scope) (gpointer object, GdartBridgeContext *self, GIScopeType *result_out, Dart_Handle *dart_error_out, GError **error);
  gboolean (*get_type) (gpointer object,
                        GdartBridgeContext *self,
                        gpointer *result_out,
                        const TypeInfoKlass **result_klass_out,
                        Dart_Handle *dart_error_out,
                        GError **error);
  gboolean (*get_ownership_transfer) (gpointer object, GdartBridgeContext *self, GITransfer *result_out, Dart_Handle *dart_error_out, GError **error);
  gboolean (*is_caller_allocates) (gpointer object, GdartBridgeContext *self, gboolean *result_out, Dart_Handle *dart_error_out, GError **error);
};

struct _CallableInfoKlass {
  gpointer (*copy) (gpointer object);
  void (*free) (gpointer object);
  gboolean (*get_name) (gpointer object,
                        GdartBridgeContext *self,
                        gchar **result_out,
                        Dart_Handle *dart_error_out,
                        GError **error);
  gboolean (*get_type) (gpointer object,
                        GdartBridgeContext *self,
                        GIInfoType *result_out,
                        Dart_Handle *dart_error,
                        GError **error);
  gboolean (*get_namespace) (gpointer object,
                        GdartBridgeContext *self,
                        gchar **result_out,
                        Dart_Handle *dart_error,
                        GError **error);
  gboolean (*prepare_closure) (gpointer object,
                               GdartBridgeContext *self,
                               ffi_cif *cif,
                               GIFFIClosureCallback callback,
                               gpointer user_data,
                               ffi_closure **result_out,
                               Dart_Handle *dart_error_out,
                               GError **error);
  gboolean (*free_closure) (gpointer object,
                            GdartBridgeContext *self,
                            ffi_closure *closure,
                            Dart_Handle *dart_error_out,
                            GError **error);
  gboolean (*get_n_args) (gpointer object,
                          GdartBridgeContext *self,
                          gint *result_out,
                          Dart_Handle *dart_error_out,
                          GError **error);
  gboolean (*get_arg) (gpointer object,
                       GdartBridgeContext *self,
                       gint n,
                       gpointer *result_out,
                       const ArgInfoKlass **result_klass_out,
                       Dart_Handle *dart_error_out,
                       GError **error);
  gboolean (*is_method) (gpointer object,
                         GdartBridgeContext *self,
                         gboolean *result_out,
                         Dart_Handle *dart_error_out,
                         GError **error);
  gboolean (*get_caller_owns) (gpointer object,
                               GdartBridgeContext *self,
                               GITransfer *result_out,
                               Dart_Handle *dart_error_out,
                               GError **error);
  gboolean (*can_throw_gerror) (gpointer object,
                                GdartBridgeContext *self,
                                gboolean *result_out,
                                Dart_Handle *dart_error_out,
                                GError **error);
  gboolean (*get_return_type) (gpointer object,
                               GdartBridgeContext *self,
                               gpointer *result_out,
                               const TypeInfoKlass **result_klass_out,
                               Dart_Handle *dart_error_out,
                               GError **error);
  const FunctionInfoKlass* (*cast_to_function_info) (gpointer object);
  const VFuncInfoKlass* (*cast_to_v_func_info) (gpointer object);
};

struct _FunctionInfoKlass {
  gpointer (*copy) (gpointer object);
  void (*free) (gpointer object);
  gboolean (*get_name) (gpointer object,
                        GdartBridgeContext *self,
                        gchar **result_out,
                        Dart_Handle *dart_error_out,
                        GError **error);
  gboolean (*get_type) (gpointer object,
                        GdartBridgeContext *self,
                        GIInfoType *result_out,
                        Dart_Handle *dart_error,
                        GError **error);
  gboolean (*get_namespace) (gpointer object,
                        GdartBridgeContext *self,
                        gchar **result_out,
                        Dart_Handle *dart_error,
                        GError **error);
  gboolean (*prepare_closure) (gpointer object,
                               GdartBridgeContext *self,
                               ffi_cif *cif,
                               GIFFIClosureCallback callback,
                               gpointer user_data,
                               ffi_closure **result_out,
                               Dart_Handle *dart_error_out,
                               GError **error);
  gboolean (*free_closure) (gpointer object,
                            GdartBridgeContext *self,
                            ffi_closure *closure,
                            Dart_Handle *dart_error_out,
                            GError **error);
  gboolean (*get_n_args) (gpointer object,
                          GdartBridgeContext *self,
                          gint *result_out,
                          Dart_Handle *dart_error_out,
                          GError **error);
  gboolean (*get_arg) (gpointer object,
                       GdartBridgeContext *self,
                       gint n,
                       gpointer *result_out,
                       const ArgInfoKlass **result_klass_out,
                       Dart_Handle *dart_error_out,
                       GError **error);
  gboolean (*is_method) (gpointer object,
                         GdartBridgeContext *self,
                         gboolean *result_out,
                         Dart_Handle *dart_error_out,
                         GError **error);
  gboolean (*get_caller_owns) (gpointer object,
                               GdartBridgeContext *self,
                               GITransfer *result_out,
                               Dart_Handle *dart_error_out,
                               GError **error);
  gboolean (*can_throw_gerror) (gpointer object,
                                GdartBridgeContext *self,
                                gboolean *result_out,
                                Dart_Handle *dart_error_out,
                                GError **error);
  gboolean (*get_return_type) (gpointer object,
                               GdartBridgeContext *self,
                               gpointer *result_out,
                               const TypeInfoKlass **result_klass_out,
                               Dart_Handle *dart_error_out,
                               GError **error);
  gboolean (*prep_invoker) (gpointer object,
                            GdartBridgeContext *self,
                            GIFunctionInvoker *invoker,
			    gpointer *user_data_out,
			    GIFunctionInvokerDestroyFunc *invoker_notify_out,
			    Dart_Handle *dart_error_out,
                            GError **error);
};


struct _VFuncInfoKlass {
  gpointer (*copy) (gpointer object);
  void (*free) (gpointer object);
  gboolean (*get_name) (gpointer object,
                        GdartBridgeContext *self,
                        gchar **result_out,
                        Dart_Handle *dart_error_out,
                        GError **error);
  gboolean (*get_type) (gpointer object,
                        GdartBridgeContext *self,
                        GIInfoType *result_out,
                        Dart_Handle *dart_error,
                        GError **error);
  gboolean (*get_namespace) (gpointer object,
                        GdartBridgeContext *self,
                        gchar **result_out,
                        Dart_Handle *dart_error,
                        GError **error);
  gboolean (*prepare_closure) (gpointer object,
                               GdartBridgeContext *self,
                               ffi_cif *cif,
                               GIFFIClosureCallback callback,
                               gpointer user_data,
                               ffi_closure **result_out,
                               Dart_Handle *dart_error_out,
                               GError **error);
  gboolean (*free_closure) (gpointer object,
                            GdartBridgeContext *self,
                            ffi_closure *closure,
                            Dart_Handle *dart_error_out,
                            GError **error);
  gboolean (*get_n_args) (gpointer object,
                          GdartBridgeContext *self,
                          gint *result_out,
                          Dart_Handle *dart_error_out,
                          GError **error);
  gboolean (*get_arg) (gpointer object,
                       GdartBridgeContext *self,
                       gint n,
                       gpointer *result_out,
                       const ArgInfoKlass **result_klass_out,
                       Dart_Handle *dart_error_out,
                       GError **error);
  gboolean (*is_method) (gpointer object,
                         GdartBridgeContext *self,
                         gboolean *result_out,
                         Dart_Handle *dart_error_out,
                         GError **error);
  gboolean (*get_caller_owns) (gpointer object,
                               GdartBridgeContext *self,
                               GITransfer *result_out,
                               Dart_Handle *dart_error_out,
                               GError **error);
  gboolean (*can_throw_gerror) (gpointer object,
                                GdartBridgeContext *self,
                                gboolean *result_out,
                                Dart_Handle *dart_error_out,
                                GError **error);
  gboolean (*get_return_type) (gpointer object,
                               GdartBridgeContext *self,
                               gpointer *result_out,
                               const TypeInfoKlass **result_klass_out,
                               Dart_Handle *dart_error_out,
                               GError **error);
  gboolean (*get_address) (gpointer object,
                           GdartBridgeContext *self,
			   GType type,
                           gpointer *result_out,
			   gpointer *peer_out,
			   AddressPeerDestroyFunc *peer_finalizer_out,
			   Dart_Handle *dart_error_out,
                           GError **error);
  gboolean (*new_invoker_for_address) (gpointer object,
                           GdartBridgeContext *self,
			   gpointer addr,
			   gpointer peer,
			   AddressPeerDestroyFunc peer_finalizer,
			   GIFunctionInvoker *invoker,
			   gpointer *user_data_out,
			   GIFunctionInvokerDestroyFunc *invoker_notify_out,
			   Dart_Handle *dart_error_out,
                           GError **error);
};

struct _EnumInfoKlass {
  gpointer (*copy) (gpointer object);
  void (*free) (gpointer object);
  gboolean (*get_name) (gpointer object,
                        GdartBridgeContext *self,
                        gchar **result_out,
                        Dart_Handle *dart_error,
                        GError **error);
  gboolean (*get_type) (gpointer object,
                        GdartBridgeContext *self,
                        GIInfoType *result_out,
                        Dart_Handle *dart_error,
                        GError **error);
  gboolean (*get_namespace) (gpointer object,
                        GdartBridgeContext *self,
                        gchar **result_out,
                        Dart_Handle *dart_error,
                        GError **error);
  gboolean (*get_gtype) (gpointer object,
                        GdartBridgeContext *self,
                        GType *result_out,
                        Dart_Handle *dart_error,
                        GError **error);
  gboolean (*get_storage_type) (gpointer object,
                                GdartBridgeContext *self,
                                GITypeTag *result_out,
                                Dart_Handle *dart_error,
                                GError **error);
  const RegisteredTypeInfoKlass* (*cast_to_registered_type_info) (gpointer object);
};

struct _RegisteredTypeInfoKlass {
  gpointer (*copy) (gpointer object);
  void (*free) (gpointer object);
  gboolean (*get_name) (gpointer object,
                        GdartBridgeContext *self,
                        gchar **result_out,
                        Dart_Handle *dart_error,
                        GError **error);
  gboolean (*get_type) (gpointer object,
                        GdartBridgeContext *self,
                        GIInfoType *result_out,
                        Dart_Handle *dart_error,
                        GError **error);
  gboolean (*get_namespace) (gpointer object,
                        GdartBridgeContext *self,
                        gchar **result_out,
                        Dart_Handle *dart_error,
                        GError **error);
  gboolean (*get_gtype) (gpointer object,
                        GdartBridgeContext *self,
                        GType *result_out,
                        Dart_Handle *dart_error,
                        GError **error);
  gboolean (*get_hash_code) (gpointer object,
                        GdartBridgeContext *self,
                        guint *result_out,
                        Dart_Handle *dart_error,
                        GError **error);
  gboolean (*equals) (gpointer object,
                        GdartBridgeContext *self,
		        gpointer other,
		        const RegisteredTypeInfoKlass* other_klass,
                        gboolean *result_out,
                        Dart_Handle *dart_error,
                        GError **error);
  const ObjectInfoKlass* (*cast_to_object_info) (gpointer object);
};


struct _ObjectInfoKlass {
  gpointer (*copy) (gpointer object);
  void (*free) (gpointer object);
  gboolean (*get_name) (gpointer object,
                        GdartBridgeContext *self,
                        gchar **result_out,
                        Dart_Handle *dart_error,
                        GError **error);
  gboolean (*get_type) (gpointer object,
                        GdartBridgeContext *self,
                        GIInfoType *result_out,
                        Dart_Handle *dart_error,
                        GError **error);
  gboolean (*get_namespace) (gpointer object,
                        GdartBridgeContext *self,
                        gchar **result_out,
                        Dart_Handle *dart_error,
                        GError **error);
  gboolean (*get_gtype) (gpointer object,
                        GdartBridgeContext *self,
                        GType *result_out,
                        Dart_Handle *dart_error,
                        GError **error);
  gboolean (*get_ref_function_pointer) (gpointer object,
                        GdartBridgeContext *self,
                        GIObjectInfoRefFunction *result_out,
                        GdartFunctionReference **result_out_reference,
                        Dart_Handle *dart_error,
                        GError **error);
  gboolean (*get_unref_function_pointer) (gpointer object,
                        GdartBridgeContext *self,
                        GIObjectInfoUnrefFunction *result_out,
                        GdartFunctionReference **result_out_reference,
                        Dart_Handle *dart_error,
                        GError **error);
                      
};

struct _StructUnionInfoKlass {
  gpointer (*copy) (gpointer object);
  void (*free) (gpointer object);
  gboolean (*get_name) (gpointer object,
                        GdartBridgeContext *self,
                        gchar **result_out,
                        Dart_Handle *dart_error,
                        GError **error);
  gboolean (*get_type) (gpointer object,
                        GdartBridgeContext *self,
                        GIInfoType *result_out,
                        Dart_Handle *dart_error,
                        GError **error);
  gboolean (*get_namespace) (gpointer object,
                        GdartBridgeContext *self,
                        gchar **result_out,
                        Dart_Handle *dart_error,
                        GError **error);
  gboolean (*get_gtype) (gpointer object,
                        GdartBridgeContext *self,
                        GType *result_out,
                        Dart_Handle *dart_error,
                        GError **error);
  gboolean (*get_size) (gpointer object,
                        GdartBridgeContext *self,
                        gsize *result_out,
                        Dart_Handle *dart_error,
                        GError **error);
};

const InterfaceInfoKlass gi_base_info_interface_info;
const InterfaceInfoKlass null_interface_info;
const InterfaceInfoKlass dart_interface_info;

const CallableInfoKlass gi_callable_info_callable_info;
const CallableInfoKlass gi_base_info_callable_info;
const CallableInfoKlass null_callable_info;
const CallableInfoKlass dart_callable_info;

const EnumInfoKlass gi_enum_info_enum_info;
const EnumInfoKlass gi_base_info_enum_info;
const EnumInfoKlass null_enum_info;
const EnumInfoKlass dart_enum_info;

const TypeInfoKlass gi_type_info_type_info;
const TypeInfoKlass null_type_info;
const TypeInfoKlass dart_type_info;

const ArgInfoKlass gi_arg_info_arg_info;
const ArgInfoKlass null_arg_info;
const ArgInfoKlass dart_arg_info;

const RegisteredTypeInfoKlass gi_registered_type_info_registered_type_info;
const RegisteredTypeInfoKlass gi_base_info_registered_type_info;
const RegisteredTypeInfoKlass null_registered_type_info;
const RegisteredTypeInfoKlass dart_registered_type_info;

const FunctionInfoKlass gi_function_info_function_info;
const FunctionInfoKlass gi_callable_info_function_info;
const FunctionInfoKlass gi_base_info_function_info;
const FunctionInfoKlass null_function_info;
const FunctionInfoKlass dart_function_info;

const VFuncInfoKlass gi_v_func_info_v_func_info;
const VFuncInfoKlass gi_callable_info_v_func_info;
const VFuncInfoKlass gi_base_info_v_func_info;
const VFuncInfoKlass null_v_func_info;
const VFuncInfoKlass dart_v_func_info;

const ObjectInfoKlass gi_object_info_object_info;
const ObjectInfoKlass gi_registered_type_info_object_info;
const ObjectInfoKlass gi_base_info_object_info;
const ObjectInfoKlass null_object_info;
const ObjectInfoKlass dart_object_info;

const StructUnionInfoKlass gi_union_info_struct_union_info;
const StructUnionInfoKlass gi_struct_info_struct_union_info;
const StructUnionInfoKlass gi_registered_type_info_struct_union_info;
const StructUnionInfoKlass gi_base_info_struct_union_info;
const StructUnionInfoKlass null_struct_union_info;
const StructUnionInfoKlass dart_struct_union_info;

#endif