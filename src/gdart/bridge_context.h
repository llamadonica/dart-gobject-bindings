// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
#ifndef __GDART_BRIDGE_CONTEXT_H__
#define __GDART_BRIDGE_CONTEXT_H__

#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <glib-object.h>
#include <girepository.h>
#include "../include/dart_api.h"
#include "../include/dart_native_api.h"

#include "common.h"
#include "object_wrapper.h"

G_BEGIN_DECLS

typedef struct _GdartBridgeContext GdartBridgeContext;
typedef struct _GdartBridgeContextClass GdartBridgeContextClass;
typedef struct _GdartBridgeContextWrappedObjectInfo GdartBridgeContextWrappedObjectInfo;

#define TYPE_GDART_BRIDGE_CONTEXT (gdart_bridge_context_get_type ())
#define GDART_BRIDGE_CONTEXT(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), TYPE_GDART_BRIDGE_CONTEXT, GdartBridgeContext))
#define GDART_BRIDGE_CONTEXT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), TYPE_GDART_BRIDGE_CONTEXT, GdartBridgeContextClass))
#define IS_GDART_BRIDGE_CONTEXT(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), TYPE_GDART_BRIDGE_CONTEXT))
#define IS_GDART_BRIDGE_CONTEXT__CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), TYPE_GDART_BRIDGE_CONTEXT))
#define GDART_BRIDGE_CONTEXT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), TYPE_GDART_BRIDGE_CONTEXT , GdartBridgeContextClass))

#define G_DART_COMPAT_LIST_TYPE (g_dart_compat_list_type())
G_GNUC_CONST GType g_dart_compat_list_type ();
#define G_DART_COMPAT_SLIST_TYPE (g_dart_compat_slist_type())
G_GNUC_CONST GType g_dart_compat_slist_type ();

GType gdart_bridge_context_get_type (void) G_GNUC_CONST;
GdartBridgeContext* gdart_bridge_context_new (void);
void gdart_bridge_context_finalize_from_dart(void* isolate_callback_data,
    Dart_WeakPersistentHandle handle,
    void* peer);
void gdart_bridge_context_set_base_library(GdartBridgeContext* self,
    Dart_WeakPersistentHandle value);
void gdart_bridge_context_set_isolate(GdartBridgeContext* self,
                                      Dart_Isolate value);
Dart_Handle gdart_bridge_context_create_error_handle(
  GdartBridgeContext* self, const gchar* format, ...) __attribute__ ((format (printf, 2, 3)));
Dart_Handle gdart_bridge_context_get_base_object_class(GdartBridgeContext* self,
    Dart_Handle* dart_error_out,
    GError** error);
Dart_Handle gdart_bridge_context_get_base_enum_class(GdartBridgeContext* self,
    Dart_Handle* dart_error_out,
    GError** error);
GIRepository* gdart_bridge_context_get_gi_repository(GdartBridgeContext* self);
Dart_Handle gdart_bridge_context_wrap_internal_pointer(GdartBridgeContext* self,
    Dart_Handle internal_container,
    const gchar* namespace,
    GType type,
    GIBaseInfo *base_info,
    Dart_Handle *dart_error_out,
    GError **error);
Dart_Handle gdart_bridge_context_wrap_class_for_error(
  GdartBridgeContext* self,
  GQuark error_domain,
  gint code,
  const gchar* message,
  Dart_Handle *dart_error_out,
  GError **error);
Dart_Handle gdart_bridge_context_retrieve_wrapping_class(
  GdartBridgeContext* self,
  const gchar* namespace,
  GType type,
  GIBaseInfo *base_info,
  gboolean is_enum,
  Dart_Handle *dart_error_out,
  GError **error);
gpointer gdart_bridge_context_retrieve_copy_func(
  GdartBridgeContext* self,
  const gchar* namespace,
  GIBaseInfo *base_info,
  GType type);
gpointer gdart_bridge_context_retrieve_free_func(
  GdartBridgeContext* self,
  const gchar* namespace,
  GIBaseInfo *base_info,
  GType type);
Dart_Handle gdart_bridge_context_wrap_pointer(GdartBridgeContext* self,
    gpointer raw_pointer,
    RawPointerFinalizer finalizer,
    Dart_Handle* dart_error_out,
    GError** error);
GIRegisteredTypeInfo* gdart_bridge_context_unwrap_object_info(GdartBridgeContext* self,
    Dart_Handle wrapped,
    Dart_Handle *dart_error_out,
    GError **error);
GdartBridgeContextWrappedObject* gdart_bridge_context_unwrap_object(
  GdartBridgeContext* self,
  Dart_Handle wrapped,
  Dart_Handle *dart_error_out,
  GError **error);
GdartBridgeContext* gdart_bridge_context_new_from_isolate(Dart_Isolate isolate);
void gdart_bridge_context_finalize_wrapped_gobject(void* container);
void gdart_bridge_context_finalize_wrapped_struct(void* container);
void gdart_bridge_context_finalize_wrapped_unowned_struct(void* container);
void gdart_bridge_context_finalize_wrapped_boxed(void* container);
void gdart_bridge_context_finalize_wrapped_custom_struct(void* container);

void gdart_bridge_context_register_interceptor_type_for_gtype(Dart_NativeArguments arguments);
void gdart_bridge_context_lookup_gtype_from_named_type(Dart_NativeArguments arguments);
void gdart_bridge_context_lookup_object_info(Dart_NativeArguments arguments);
void gdart_bridge_context_object_info_call_static(Dart_NativeArguments arguments);
void gdart_bridge_context_object_info_call_method_on_receiver(Dart_NativeArguments arguments);
void gdart_bridge_context_object_call_method(Dart_NativeArguments arguments);
void gdart_bridge_context_object_signal_connect(Dart_NativeArguments arguments);
void gdart_bridge_context_object_signal_disconnect(Dart_NativeArguments arguments);
void gdart_bridge_context_register_interceptor_type_for_error_quark(Dart_NativeArguments arguments);
void gdart_bridge_context_call_static_global(Dart_NativeArguments arguments);
void gdart_bridge_context_object_get_string_representation(Dart_NativeArguments arguments);
void gdart_bridge_context_lookup_gtype_for_list(Dart_NativeArguments arguments);
void gdart_bridge_context_lookup_gtype_for_slist(Dart_NativeArguments arguments);
void gdart_bridge_context_register_copy_func_for_gtype(Dart_NativeArguments arguments);
void gdart_bridge_context_register_free_func_for_gtype(Dart_NativeArguments arguments);

void gdart_bridge_context_lookup_error_quark_from_string(Dart_NativeArguments arguments);
void gdart_bridge_context_register_interceptor_type_for_error_quark(Dart_NativeArguments arguments);
void gdart_bridge_context_lookup_error_string_from_quark(Dart_NativeArguments arguments);

void gdart_bridge_context_object_info_set_g_property_on_receiver(
  Dart_NativeArguments arguments);
void gdart_bridge_context_object_info_get_g_property_on_receiver(
  Dart_NativeArguments arguments);

G_END_DECLS

#endif
