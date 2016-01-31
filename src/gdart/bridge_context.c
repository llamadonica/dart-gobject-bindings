// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

#include <gee.h>

#include "bridge_context.h"
#include "common.h"
#include "marshallers_check.h"
#include "object_wrapper.h"
#include "function.h"
#include "g_property.h"

static void gdart_bridge_context_dispose(GObject *object);
static void gdart_bridge_context_finalize(GObject *object);
static void gdart_bridge_context_constructed(GObject *object);
static void gdart_bridge_context_get_property(GObject *object,
    guint prop_id,
    GValue *value,
    GParamSpec *pspec);
static void gdart_bridge_context_set_property(GObject *object,
    guint prop_id,
    const GValue *value,
    GParamSpec *pspec);
struct _GdartBridgeContext {
  GObject parent;
  Dart_WeakPersistentHandle base_library;
  Dart_Isolate isolate;
  gboolean encapsulation_class_created;
  Dart_PersistentHandle raw_pointer_class;
  gboolean loaded_gdart_internal_error_class;
  Dart_PersistentHandle gdart_internal_error_class;
  gboolean loaded_unknown_object_class;
  Dart_PersistentHandle gdart_unknown_object_class;
  gboolean loaded_object_info_class;
  Dart_PersistentHandle gdart_unknown_error_class;
  gboolean loaded_unknown_error_class;
  Dart_PersistentHandle gdart_object_info_class;
  gboolean loaded_base_object_class;
  Dart_PersistentHandle gdart_base_object_class;
  gboolean loaded_base_enum_class;
  Dart_PersistentHandle gdart_base_enum_class;
  GeeHashMap* dart_classes_by_gtype;
  GeeHashMap* dart_free_funcs_by_gtype;
  GeeHashMap* dart_copy_funcs_by_gtype;
  GeeHashMap* dart_classes_by_gerror_quark;
  GIRepository* gi_repository;
};

struct _GdartBridgeContextClass {
  GObjectClass parent;
};

struct _GdartBridgeContextNamespaceGtype {
  const gchar* namespace;
  gpointer base_info;
  RegisteredTypeInfoKlass base_info_klass;
  GType gtype;
};
typedef struct _GdartBridgeContextNamespaceGtype GdartBridgeContextNamespaceGtype;

struct _GdartBridgeContextNamespaceGquark {
  GQuark quark;
};
typedef struct _GdartBridgeContextNamespaceGquark GdartBridgeContextNamespaceGquark;


static gpointer _g_dart_compat_list_boxed_copy(gpointer _)
{
  g_assert_not_reached();
}
static void _g_dart_compat_list_boxed_free(gpointer _)
{
  g_assert_not_reached();
}

G_GNUC_CONST GType g_dart_compat_list_type (void)
{
  static GType value;
  if (g_once_init_enter (&value)) {
    GType value_init;
    value_init = g_boxed_type_register_static("GDartCompatList",
                 _g_dart_compat_list_boxed_copy,
                 _g_dart_compat_list_boxed_free);
    g_once_init_leave(&value, value_init);
  }
  return value;
}

G_GNUC_CONST GType g_dart_compat_slist_type (void)
{
  static GType value;
  if (g_once_init_enter (&value)) {
    GType value_init;
    value_init = g_boxed_type_register_static("GDartCompatSList",
                 _g_dart_compat_list_boxed_copy,
                 _g_dart_compat_list_boxed_free);
    g_once_init_leave(&value, value_init);
  }
  return value;
}


static gpointer _gdart_bridge_context_namespace_gtype_copy(gpointer boxed)
{
  GdartBridgeContextNamespaceGtype *src, *dest;
  src = (GdartBridgeContextNamespaceGtype*) boxed;
  dest = g_slice_new(GdartBridgeContextNamespaceGtype);
  dest->namespace = src->namespace;
  dest->gtype = src->gtype;
  dest->base_info =src->base_info_klass.copy(src->base_info);
  dest->base_info_klass = src->base_info_klass;
  return (gpointer) dest;
}

static void _gdart_bridge_context_namespace_gtype_free(gpointer boxed)
{
  GdartBridgeContextNamespaceGtype *src;
  src = (GdartBridgeContextNamespaceGtype*) boxed;
  src->base_info_klass.free(src->base_info);

  g_slice_free(GdartBridgeContextNamespaceGtype, boxed);
}

static gpointer _gdart_bridge_context_namespace_gquark_copy(gpointer boxed)
{
  GdartBridgeContextNamespaceGquark *src, *dest;
  src = (GdartBridgeContextNamespaceGquark*) boxed;
  dest = g_slice_new(GdartBridgeContextNamespaceGquark);
  dest->quark = src->quark;
  return (gpointer) dest;
}

static void _gdart_bridge_context_namespace_gquark_free(gpointer boxed)
{
  g_slice_free(GdartBridgeContextNamespaceGquark, boxed);
}


static guint _gdart_bridge_context_namespace_gtype_hash(gconstpointer boxed, void* userdata)
{
  GdartBridgeContext* self;
  const GdartBridgeContextNamespaceGtype *src;
  guint intermediate, base_info_hash;
  Dart_Handle set_on_error;
  GError *error = NULL;
  self = userdata;
  
  src = (const GdartBridgeContextNamespaceGtype *) boxed;
  if (!src->base_info_klass.get_hash_code(src->base_info,
                                          self,
					  &base_info_hash,
					  &set_on_error,
					  &error))
    g_assert_not_reached();
  src = (const GdartBridgeContextNamespaceGtype*) boxed;
  intermediate = g_str_hash((gconstpointer) src->namespace);
  intermediate = intermediate * 63 + base_info_hash;
  return intermediate * 63 + src->gtype;
}

static gboolean _gdart_bridge_context_namespace_gtype_eq(gconstpointer a_boxed, gconstpointer b_boxed, void* userdata)
{
  const GdartBridgeContextNamespaceGtype *a, *b;
  GdartBridgeContext* self;
  Dart_Handle set_on_error;
  GError *error = NULL;
  gboolean result;
  
  self = userdata;
  a = (const GdartBridgeContextNamespaceGtype*) a_boxed;
  b = (const GdartBridgeContextNamespaceGtype*) b_boxed;
  if (!a->base_info_klass.equals(
    a->base_info,
    self,
    b->base_info,
    &b->base_info_klass,
    &result,
    &set_on_error,
    &error))
    g_assert_not_reached();
  return g_str_equal((gconstpointer) a->namespace, (gconstpointer) b->namespace) &&
         result;
}


static guint _gdart_bridge_context_namespace_gquark_hash(gconstpointer boxed, void* userdata)
{
  const GdartBridgeContextNamespaceGquark *src;
  src = (const GdartBridgeContextNamespaceGquark*) boxed;
  return src->quark;
}

static gboolean _gdart_bridge_context_namespace_gquark_eq(gconstpointer a_boxed, gconstpointer b_boxed, void* userdata)
{
  const GdartBridgeContextNamespaceGquark *a, *b;
  a = (const GdartBridgeContextNamespaceGquark*) a_boxed;
  b = (const GdartBridgeContextNamespaceGquark*) b_boxed;
  return a->quark == b->quark;
}

static gpointer _gdart_bridge_context_persistent_handle_copy(gpointer boxed)
{
  Dart_PersistentHandle src, dest;
  src = (Dart_PersistentHandle) boxed;
  Dart_EnterScope();
  dest = Dart_NewPersistentHandle(Dart_HandleFromPersistent(src));
  Dart_ExitScope();
  return (gpointer) dest;
}

static void _gdart_bridge_context_persistent_handle_free(gpointer boxed)
{
  Dart_PersistentHandle src;
  src = (Dart_PersistentHandle) boxed;
  Dart_DeletePersistentHandle(src);
}

static gpointer _gdart_bridge_context_external_func_copy(gpointer boxed)
{
  return boxed;
}

static void _gdart_bridge_context_external_func_free(gpointer boxed)
{
}

static gboolean _gdart_bridge_context_external_func_eq(gconstpointer a_boxed, gconstpointer b_boxed, void* userdata)
{
  return (a_boxed == b_boxed);
}

static gboolean _gdart_bridge_context_persistent_handle_eq(gconstpointer a_boxed, gconstpointer b_boxed, void* userdata)
{
  Dart_PersistentHandle a, b;
  Dart_Handle a_temp, b_temp;
  bool result;
  a = (Dart_PersistentHandle) a_boxed;
  b = (Dart_PersistentHandle) b_boxed;
  Dart_EnterScope();
  a_temp = Dart_HandleFromPersistent(a);
  b_temp = Dart_HandleFromPersistent(b);
  result = Dart_IdentityEquals(a_temp, b_temp);
  Dart_ExitScope();
  return result;
}

static GRWLock isolate_to_bridge_lock;
static GList *all_isolate_to_bridge = NULL;

G_DEFINE_TYPE(GdartBridgeContext, gdart_bridge_context, G_TYPE_OBJECT);

static void gdart_bridge_context_class_init(GdartBridgeContextClass *klass)
{
  GObjectClass *object_class = G_OBJECT_CLASS (klass);

  object_class->dispose = gdart_bridge_context_dispose;
  object_class->finalize = gdart_bridge_context_finalize;

  object_class->constructed = gdart_bridge_context_constructed;
  object_class->get_property = gdart_bridge_context_get_property;
  object_class->set_property = gdart_bridge_context_set_property;
}

static void gdart_bridge_context_init(GdartBridgeContext *self)
{
  self->encapsulation_class_created = FALSE;
  self->loaded_gdart_internal_error_class = FALSE;
  self->loaded_unknown_object_class = FALSE;
  self->loaded_base_object_class = FALSE;
  self->loaded_base_enum_class = FALSE;
  self->dart_classes_by_gtype = gee_hash_map_new(G_TYPE_NONE, _gdart_bridge_context_namespace_gtype_copy,
                                _gdart_bridge_context_namespace_gtype_free, G_TYPE_NONE,
                                _gdart_bridge_context_persistent_handle_copy,
                                _gdart_bridge_context_persistent_handle_free,
                                _gdart_bridge_context_namespace_gtype_hash, self,
                                NULL, _gdart_bridge_context_namespace_gtype_eq, self,
                                NULL, _gdart_bridge_context_persistent_handle_eq, NULL,
                                NULL);
  self->dart_copy_funcs_by_gtype = gee_hash_map_new(G_TYPE_NONE, _gdart_bridge_context_namespace_gtype_copy,
                                   _gdart_bridge_context_namespace_gtype_free, G_TYPE_NONE,
                                   _gdart_bridge_context_external_func_copy,
                                   _gdart_bridge_context_external_func_free,
                                   _gdart_bridge_context_namespace_gtype_hash, self,
                                   NULL, _gdart_bridge_context_namespace_gtype_eq, self,
                                   NULL, _gdart_bridge_context_external_func_eq, NULL,
                                   NULL);
  self->dart_free_funcs_by_gtype = gee_hash_map_new(G_TYPE_NONE, _gdart_bridge_context_namespace_gtype_copy,
                                   _gdart_bridge_context_namespace_gtype_free, G_TYPE_NONE,
                                   _gdart_bridge_context_external_func_copy,
                                   _gdart_bridge_context_external_func_free,
                                   _gdart_bridge_context_namespace_gtype_hash, self,
                                   NULL, _gdart_bridge_context_namespace_gtype_eq, self,
                                   NULL, _gdart_bridge_context_external_func_eq, NULL,
                                   NULL);
  self->dart_classes_by_gerror_quark = gee_hash_map_new(G_TYPE_NONE, _gdart_bridge_context_namespace_gquark_copy,
                                       _gdart_bridge_context_namespace_gquark_free, G_TYPE_NONE,
                                       _gdart_bridge_context_persistent_handle_copy,
                                       _gdart_bridge_context_persistent_handle_free,
                                       _gdart_bridge_context_namespace_gquark_hash, NULL,
                                       NULL, _gdart_bridge_context_namespace_gquark_eq, NULL,
                                       NULL, _gdart_bridge_context_persistent_handle_eq, NULL,
                                       NULL);
  self->gi_repository = g_irepository_get_default();
}

static void gdart_bridge_context_dispose(GObject *object)
{
  GdartBridgeContext* self = GDART_BRIDGE_CONTEXT(object);
  g_object_unref(G_OBJECT(self->dart_classes_by_gtype));
  g_object_unref(G_OBJECT(self->dart_copy_funcs_by_gtype));
  g_object_unref(G_OBJECT(self->dart_free_funcs_by_gtype));
  g_object_unref(G_OBJECT(self->dart_classes_by_gerror_quark));
  G_OBJECT_CLASS(gdart_bridge_context_parent_class)->dispose(object);
}

static void gdart_bridge_context_finalize(GObject *object)
{
  G_OBJECT_CLASS(gdart_bridge_context_parent_class)->finalize(object);

}

static void gdart_bridge_context_constructed(GObject *object)
{
  G_OBJECT_CLASS(gdart_bridge_context_parent_class)->constructed(object);
}

static void gdart_bridge_context_get_property(GObject *object,
    guint prop_id,
    GValue *value,
    GParamSpec *pspec)
{
  switch (prop_id) {
  default:
    G_OBJECT_WARN_INVALID_PROPERTY_ID (object, prop_id, pspec);
    break;
  }
}

GIRepository* gdart_bridge_context_get_gi_repository(GdartBridgeContext* self)
{
  return self->gi_repository;
}

static void gdart_bridge_context_set_property(GObject *object,
    guint prop_id,
    const GValue *value,
    GParamSpec *pspec)
{
  switch (prop_id) {
  default:
    G_OBJECT_WARN_INVALID_PROPERTY_ID (object, prop_id, pspec);
    break;
  }
}

GdartBridgeContext* gdart_bridge_context_new(void)
{
  return (GdartBridgeContext*) g_object_new(TYPE_GDART_BRIDGE_CONTEXT, NULL);
}

void gdart_bridge_context_finalize_from_dart(void* isolate_callback_data,
    Dart_WeakPersistentHandle handle,
    void* peer)
{
  g_object_unref((GObject*) peer);
}

void gdart_bridge_context_set_base_library(GdartBridgeContext* self,
    Dart_WeakPersistentHandle value)
{
  self->base_library = value;
}

void gdart_bridge_context_set_isolate(GdartBridgeContext* self,
                                      Dart_Isolate value)
{
  GList* l;
  g_assert (value != NULL);
  g_rw_lock_writer_lock(&isolate_to_bridge_lock);
  for (l = all_isolate_to_bridge; l != NULL; l = l->next) {
    GdartBridgeContext* data;
    data = (GdartBridgeContext*) l->data;
    if (data->isolate == value) {
      g_assert_not_reached();
    }
  }
  all_isolate_to_bridge = g_list_prepend(all_isolate_to_bridge, self);
  self->isolate = value;
  g_rw_lock_writer_unlock(&isolate_to_bridge_lock);
}

GdartBridgeContext* gdart_bridge_context_new_from_isolate(Dart_Isolate isolate)
{
  GList* l;
  g_rw_lock_reader_lock(&isolate_to_bridge_lock);
  for (l = all_isolate_to_bridge; l != NULL; l = l->next) {
    GdartBridgeContext* data;
    data = (GdartBridgeContext*) l->data;
    if (data->isolate == isolate) {
      g_rw_lock_reader_unlock(&isolate_to_bridge_lock);
      return data;
    }
  }
  g_assert_not_reached();
  return NULL;
}

static gboolean _gdart_bridge_context_ensure_encapsulation_class_created(GdartBridgeContext* self,
    Dart_Handle* dart_error_out,
    GError** error)
{
  Dart_Handle library, class_name, class;
  g_assert_nonnull(self);
  if (self->encapsulation_class_created) return TRUE;
  class_name = Dart_NewStringFromCString("_RawPtrImpl");
  if (G_UNLIKELY(Dart_IsError(class_name))) {
    *dart_error_out = class_name;
    goto out_error;
  }
  library = Dart_HandleFromWeakPersistent(self->base_library);
  if (G_UNLIKELY(Dart_IsError(library))) {
    *dart_error_out = library;
    goto out_error;
  }
  class = Dart_CreateNativeWrapperClass(library, class_name, 1);
  if (G_UNLIKELY(Dart_IsError(class))) {
    *dart_error_out = class;
    goto out_error;
  }
  self->raw_pointer_class = Dart_NewPersistentHandle(class);
  self->encapsulation_class_created = TRUE;
  return TRUE;
out_error:
  g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
  return FALSE;
}

static gboolean _gdart_bridge_context_ensure_loaded_gdart_internal_error_class(GdartBridgeContext* self,
    Dart_Handle* dart_error_out,
    GError** error)
{
  Dart_Handle library, class_name, class;
  g_assert_nonnull(self);
  if (self->loaded_gdart_internal_error_class) return TRUE;
  class_name = Dart_NewStringFromCString("GDartException");
  if (G_UNLIKELY(Dart_IsError(class_name))) {
    *dart_error_out = class_name;
    goto out_error;
  }
  library = Dart_HandleFromWeakPersistent(self->base_library);
  if (G_UNLIKELY(Dart_IsError(library))) {
    *dart_error_out = library;
    goto out_error;
  }
  class = Dart_GetType(library, class_name, 0, NULL);
  if (G_UNLIKELY(Dart_IsError(class))) {
    *dart_error_out = class;
    goto out_error;
  }
  self->gdart_internal_error_class = Dart_NewPersistentHandle(class);
  self->loaded_gdart_internal_error_class = TRUE;
  return TRUE;
out_error:
  g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
  return FALSE;
}

static gboolean _gdart_bridge_context_ensure_loaded_unknown_object_class(GdartBridgeContext* self,
    Dart_Handle* dart_error_out,
    GError** error)
{
  Dart_Handle library, class_name, class;
  g_assert_nonnull(self);
  if (self->loaded_unknown_object_class) return TRUE;
  class_name = Dart_NewStringFromCString("UnknownObject");
  if (G_UNLIKELY(Dart_IsError(class_name))) {
    *dart_error_out = class_name;
    goto out_error;
  }
  library = Dart_HandleFromWeakPersistent(self->base_library);
  if (G_UNLIKELY(Dart_IsError(library))) {
    *dart_error_out = library;
    goto out_error;
  }
  class = Dart_GetType(library, class_name, 0, NULL);
  if (G_UNLIKELY(Dart_IsError(class))) {
    *dart_error_out = class;
    goto out_error;
  }
  g_assert(Dart_IsType(class));
  self->gdart_unknown_object_class = Dart_NewPersistentHandle(class);
  self->loaded_unknown_object_class = TRUE;
  return TRUE;
out_error:
  g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
  return FALSE;
}


static gboolean _gdart_bridge_context_ensure_loaded_unknown_error_class(GdartBridgeContext* self,
    Dart_Handle* dart_error_out,
    GError** error)
{
  Dart_Handle library, class_name, class;
  g_assert_nonnull(self);
  if (self->loaded_unknown_error_class) return TRUE;
  class_name = Dart_NewStringFromCString("GErrorBase");
  if (G_UNLIKELY(Dart_IsError(class_name))) {
    *dart_error_out = class_name;
    goto out_error;
  }
  library = Dart_HandleFromWeakPersistent(self->base_library);
  if (G_UNLIKELY(Dart_IsError(library))) {
    *dart_error_out = library;
    goto out_error;
  }
  class = Dart_GetType(library, class_name, 0, NULL);
  if (G_UNLIKELY(Dart_IsError(class))) {
    *dart_error_out = class;
    goto out_error;
  }
  g_assert(Dart_IsType(class));
  self->gdart_unknown_error_class = Dart_NewPersistentHandle(class);
  self->loaded_unknown_error_class = TRUE;
  return TRUE;
out_error:
  g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
  return FALSE;
}


static gboolean _gdart_bridge_context_ensure_loaded_base_object_class(GdartBridgeContext* self,
    Dart_Handle* dart_error_out,
    GError** error)
{
  Dart_Handle library, class_name, class;
  g_assert_nonnull(self);
  if (self->loaded_base_object_class) return TRUE;
  class_name = Dart_NewStringFromCString("GObjectBase");
  if (G_UNLIKELY(Dart_IsError(class_name))) {
    *dart_error_out = class_name;
    goto out_error;
  }
  library = Dart_HandleFromWeakPersistent(self->base_library);
  if (G_UNLIKELY(Dart_IsError(library))) {
    *dart_error_out = library;
    goto out_error;
  }
  class = Dart_GetType(library, class_name, 0, NULL);
  if (G_UNLIKELY(Dart_IsError(class))) {
    *dart_error_out = class;
    goto out_error;
  }
  self->gdart_base_object_class = Dart_NewPersistentHandle(class);
  self->loaded_base_object_class = TRUE;
  return TRUE;
out_error:
  g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
  return FALSE;
}


static gboolean _gdart_bridge_context_ensure_loaded_base_enum_class(GdartBridgeContext* self,
    Dart_Handle* dart_error_out,
    GError** error)
{
  Dart_Handle library, class_name, class;
  g_assert_nonnull(self);
  if (self->loaded_base_enum_class) return TRUE;
  class_name = Dart_NewStringFromCString("GEnumBase");
  if (G_UNLIKELY(Dart_IsError(class_name))) {
    *dart_error_out = class_name;
    goto out_error;
  }
  library = Dart_HandleFromWeakPersistent(self->base_library);
  if (G_UNLIKELY(Dart_IsError(library))) {
    *dart_error_out = library;
    goto out_error;
  }
  class = Dart_GetType(library, class_name, 0, NULL);
  if (G_UNLIKELY(Dart_IsError(class))) {
    *dart_error_out = class;
    goto out_error;
  }
  self->gdart_base_enum_class = Dart_NewPersistentHandle(class);
  self->loaded_base_enum_class = TRUE;
  return TRUE;
out_error:
  g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
  return FALSE;
}


Dart_Handle gdart_bridge_context_get_base_object_class(GdartBridgeContext* self,
    Dart_Handle* dart_error_out,
    GError** error)
{
  if (_gdart_bridge_context_ensure_loaded_base_object_class(self, dart_error_out, error)) {
    return Dart_HandleFromPersistent(self->gdart_base_object_class);
  }
  return NULL;
}


Dart_Handle gdart_bridge_context_get_base_enum_class(GdartBridgeContext* self,
    Dart_Handle* dart_error_out,
    GError** error)
{
  if (_gdart_bridge_context_ensure_loaded_base_enum_class(self, dart_error_out, error)) {
    return Dart_HandleFromPersistent(self->gdart_base_enum_class);
  }
  return NULL;
}

static gboolean _gdart_bridge_context_ensure_loaded_object_info_class(GdartBridgeContext* self,
    Dart_Handle* dart_error_out,
    GError** error)
{
  Dart_Handle library, class_name, class;
  g_assert_nonnull(self);
  if (self->loaded_object_info_class) return TRUE;
  class_name = Dart_NewStringFromCString("GIObjectInfo");
  if (G_UNLIKELY(Dart_IsError(class_name))) {
    *dart_error_out = class_name;
    goto out_error;
  }
  library = Dart_HandleFromWeakPersistent(self->base_library);
  if (G_UNLIKELY(Dart_IsError(library))) {
    *dart_error_out = library;
    goto out_error;
  }
  class = Dart_GetType(library, class_name, 0, NULL);
  if (G_UNLIKELY(Dart_IsError(class))) {
    *dart_error_out = class;
    goto out_error;
  }
  self->gdart_object_info_class = Dart_NewPersistentHandle(class);
  self->loaded_object_info_class = TRUE;
  return TRUE;
out_error:
  g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
  return FALSE;
}

Dart_Handle gdart_bridge_context_create_error_handle(
  GdartBridgeContext* self, const gchar* format, ...)
{
  GError* inner_error = NULL;
  va_list arg;
  gchar* error_string;
  Dart_Handle inner_dart_error, error_message, result;

  if(!_gdart_bridge_context_ensure_loaded_gdart_internal_error_class(
        self,
        &inner_dart_error,
        &inner_error)) {
    g_clear_error(&inner_error);
    Dart_PropagateError(inner_dart_error);
  }
  va_start(arg, format);
  error_string = g_strdup_vprintf(format, arg);
  va_end(arg);
  error_message = Dart_NewStringFromUTF8((const uint8_t*) error_string,
                                         strlen(error_string));
  g_free(error_string);
  if (G_UNLIKELY(Dart_IsError(error_message))) {
    Dart_PropagateError(error_message);
  }
  result = Dart_New(Dart_HandleFromPersistent(self->gdart_internal_error_class),
                    Dart_Null(),
                    1,
                    &error_message);

  if (G_UNLIKELY(Dart_IsError(result))) {
    Dart_PropagateError(result);
  }
  return result;
}

static void _gdart_bridge_context_finalize_wrapped_pointer(void* isolate_callback_data,
    Dart_WeakPersistentHandle handle,
    void* peer)
{
  RawPointerContainer* container = (RawPointerContainer*) peer;
  if (container->finalizer != NULL) {
    container->finalizer(container->raw_pointer);
  }
  g_slice_free(RawPointerContainer, container);
}

Dart_Handle gdart_bridge_context_wrap_pointer(GdartBridgeContext* self,
    gpointer raw_pointer,
    RawPointerFinalizer finalizer,
    Dart_Handle* dart_error_out,
    GError** error)
{
  RawPointerContainer* container;
  Dart_Handle class, instance, result;
  g_assert_nonnull(self);
  container = g_slice_new(RawPointerContainer);
  container->raw_pointer = raw_pointer;
  container->finalizer = finalizer;
  if (!_gdart_bridge_context_ensure_encapsulation_class_created(self, dart_error_out, error)) {
    goto rethrow;
  }
  class = Dart_HandleFromPersistent(self->raw_pointer_class);
  if (G_UNLIKELY(Dart_IsError(class))) {
    *dart_error_out = class;
    goto out_error;
  }
  instance = Dart_Allocate(class);
  if (G_UNLIKELY(Dart_IsError(instance))) {
    *dart_error_out = instance;
    goto out_error;
  }
  result = Dart_SetNativeInstanceField(instance, 0, (intptr_t) container);
  if (G_UNLIKELY(Dart_IsError(result))) {
    *dart_error_out = result;
    goto out_error;
  }
  Dart_NewWeakPersistentHandle(result, container, 0, _gdart_bridge_context_finalize_wrapped_pointer);
  return instance;
out_error:
  g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
rethrow:
  g_slice_free(RawPointerContainer, container);
  return NULL;
}

void gdart_bridge_context_lookup_error_quark_from_string(
  Dart_NativeArguments arguments)
{
  Dart_EnterScope();
  GdartBridgeContext* self;
  gintptr argument_count, symbol_name_length;
  Dart_Handle dart_error_out, symbol_name, result, gtype_result;
  gchar *symbol_name_str,
        *symbol_name_str_out;
  GType gtype;
  self = gdart_bridge_context_new_from_isolate(Dart_CurrentIsolate());
  argument_count = Dart_GetNativeArgumentCount(arguments);
  if (argument_count < 1) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 1 argument, an error string representation", G_STRFUNC);
    goto error;
  }
  symbol_name = Dart_GetNativeArgument(arguments, 0);
  if (G_UNLIKELY(Dart_IsError(symbol_name))) {
    dart_error_out = symbol_name;
    goto error_native;
  }
  if (Dart_IsNull(symbol_name)) {
    symbol_name_str_out = NULL;
  } else if (!Dart_IsString(symbol_name)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 1 argument, an error string representation", G_STRFUNC);
    goto error;
  } else {
    result = Dart_StringToUTF8(symbol_name, (uint8_t **) &symbol_name_str, &symbol_name_length);
    if (G_UNLIKELY(Dart_IsError(result))) {
      dart_error_out = result;
      goto error_native;
    }
    symbol_name_str_out = g_newa(gchar, symbol_name_length + 1);
    memmove(symbol_name_str_out, symbol_name_str, symbol_name_length);
    symbol_name_str_out[symbol_name_length] = '\0';
  }
  gtype = g_quark_from_string(symbol_name_str_out);
  gtype_result = Dart_NewIntegerFromUint64((guint64) gtype);
  if (G_UNLIKELY(Dart_IsError(gtype_result))) {
    dart_error_out = gtype_result;
    goto error_native;
  }
  Dart_SetReturnValue(arguments, gtype_result);
  Dart_ExitScope();
  return;
error:
  dart_error_out = Dart_ThrowException(dart_error_out);
error_native:
  Dart_PropagateError(dart_error_out);
}

void gdart_bridge_context_register_interceptor_type_for_error_quark(
  Dart_NativeArguments arguments)
{
  GdartBridgeContext* self;
  Dart_Handle gtype, dart_type, dart_error_out, temp_result;
  guint64 gtype_int;
  gintptr argument_count;
  bool integer_fits;
  GQuark gtype_as_gtype;
  Dart_PersistentHandle dart_persistent_type;
  GdartBridgeContextNamespaceGquark *namespace_context;

  Dart_EnterScope();

  self = gdart_bridge_context_new_from_isolate(Dart_CurrentIsolate());
  argument_count = Dart_GetNativeArgumentCount(arguments);
  if (argument_count < 2) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 2 arguments, a gquark and the type of the container", G_STRFUNC);
    goto error;
  }
  gtype = Dart_GetNativeArgument(arguments, 0);
  if (G_UNLIKELY(Dart_IsError(gtype))) {
    dart_error_out = gtype;
    goto error_native;
  }
  if (!Dart_IsInteger(gtype)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 2 arguments, a gquark and the type of the container", G_STRFUNC);
    goto error;
  }
  temp_result = Dart_IntegerFitsIntoUint64(gtype, &integer_fits);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }
  if (!integer_fits) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: the gquark parameter was not a valid gquark for this system.", G_STRFUNC);
    goto error;
  }
  temp_result = Dart_IntegerToUint64(gtype, &gtype_int);
  if (gtype_int > G_MAXUINT32) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: the gtype parameter was not a valid gquark for this system.", G_STRFUNC);
    goto error;
  }
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }
  if (gtype_int > SIZE_MAX) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: the gtype parameter was not a valid gtype for this system.", G_STRFUNC);
    goto error;
  }
  gtype_as_gtype = (GQuark) gtype_int;

  dart_type = Dart_GetNativeArgument(arguments, 1);
  if (G_UNLIKELY(Dart_IsError(dart_type))) {
    dart_error_out = dart_type;
    goto error_native;
  }
  if (!Dart_IsType(dart_type)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 2 arguments, a gquark and the type of the container", G_STRFUNC);
    goto error;
  }
  namespace_context = g_newa(GdartBridgeContextNamespaceGquark, 1);
  namespace_context->quark = gtype_as_gtype;
  dart_persistent_type = Dart_NewPersistentHandle(dart_type);
  if (gee_abstract_map_has_key(GEE_ABSTRACT_MAP(self->dart_classes_by_gerror_quark),
                               (gconstpointer) namespace_context)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: the specified gtype was already registered", G_STRFUNC);
    goto error;
  }
  gee_abstract_map_set(GEE_ABSTRACT_MAP(self->dart_classes_by_gerror_quark),
                       (gconstpointer) namespace_context,
                       (gconstpointer) dart_persistent_type);
  Dart_DeletePersistentHandle(dart_persistent_type);
  Dart_ExitScope();
  return;
error:
  dart_error_out = Dart_ThrowException(dart_error_out);
error_native:
  Dart_PropagateError(dart_error_out);
}

void gdart_bridge_context_lookup_error_string_from_quark(
  Dart_NativeArguments arguments)
{
  GdartBridgeContext* self;
  Dart_Handle gtype, dart_error_out, temp_result;
  guint64 gtype_int;
  gintptr argument_count;
  bool integer_fits;
  GQuark gtype_as_gtype;
  const char *error_string;
  gint string_length;

  Dart_EnterScope();

  self = gdart_bridge_context_new_from_isolate(Dart_CurrentIsolate());
  argument_count = Dart_GetNativeArgumentCount(arguments);
  if (argument_count < 1) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 1 arguments, a gquark", G_STRFUNC);
    goto error;
  }
  gtype = Dart_GetNativeArgument(arguments, 0);
  if (G_UNLIKELY(Dart_IsError(gtype))) {
    dart_error_out = gtype;
    goto error_native;
  }
  if (!Dart_IsInteger(gtype)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 1 arguments, a gquark", G_STRFUNC);
    goto error;
  }
  temp_result = Dart_IntegerFitsIntoUint64(gtype, &integer_fits);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }
  if (!integer_fits) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: the gquark parameter was not a valid gquark for this system.", G_STRFUNC);
    goto error;
  }
  temp_result = Dart_IntegerToUint64(gtype, &gtype_int);
  if (gtype_int > G_MAXUINT32) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: the gtype parameter was not a valid gquark for this system.", G_STRFUNC);
    goto error;
  }
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }
  gtype_as_gtype = (GQuark) gtype_int;
  error_string = g_quark_to_string(gtype_as_gtype);
  if (error_string == NULL) {
    temp_result = Dart_Null();
  } else {
    string_length = g_utf8_strlen(error_string, -1);
    temp_result = Dart_NewStringFromUTF8((const guint8*) error_string, string_length);
  }
  Dart_SetReturnValue(arguments, temp_result);
  Dart_ExitScope();
  return;
error:
  dart_error_out = Dart_ThrowException(dart_error_out);
error_native:
  Dart_PropagateError(dart_error_out);
}

void gdart_bridge_context_register_interceptor_type_for_gtype(Dart_NativeArguments arguments)
{
  GdartBridgeContext* self;
  Dart_Handle gtype, namespace, dart_type, dart_error_out, temp_result,
              symbol_name;
  guint64 gtype_int;
  gintptr namespace_length, argument_count, symbol_name_length;
  gchar *namespace_str, *namespace_str_out, *error_string, *symbol_name_str,
        *symbol_name_str_out;
  const gchar* namespace_str_const;
  bool integer_fits;
  GType gtype_as_gtype;
  GError* inner_error = NULL;
  GITypelib* typelib;
  Dart_PersistentHandle dart_persistent_type;
  GdartBridgeContextNamespaceGtype *namespace_context;
  GIBaseInfo *base_info;

  Dart_EnterScope();

  self = gdart_bridge_context_new_from_isolate(Dart_CurrentIsolate());
  argument_count = Dart_GetNativeArgumentCount(arguments);
  if (argument_count < 3) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 3 arguments, a gtype, a namespace and the type of the container", G_STRFUNC);
    goto error;
  }
  gtype = Dart_GetNativeArgument(arguments, 0);
  if (G_UNLIKELY(Dart_IsError(gtype))) {
    dart_error_out = gtype;
    goto error_native;
  }
  if (!Dart_IsInteger(gtype)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 3 arguments, a gtype, a namespace and the type of the container", G_STRFUNC);
    goto error;
  }
  temp_result = Dart_IntegerFitsIntoUint64(gtype, &integer_fits);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }
  if (!integer_fits) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: the gtype parameter was not a valid gtype for this system.", G_STRFUNC);
    goto error;
  }
  temp_result = Dart_IntegerToUint64(gtype, &gtype_int);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }
  if (gtype_int > SIZE_MAX) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: the gtype parameter was not a valid gtype for this system.", G_STRFUNC);
    goto error;
  }
  gtype_as_gtype = (GType) gtype_int;
  namespace = Dart_GetNativeArgument(arguments, 1);
  if (G_UNLIKELY(Dart_IsError(namespace))) {
    dart_error_out = namespace;
    goto error_native;
  }
  if (!Dart_IsString(namespace)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 3 arguments, a gtype, a namespace and the type of the container", G_STRFUNC);
    goto error;
  }
  temp_result = Dart_StringToUTF8(namespace, (uint8_t **) &namespace_str, &namespace_length);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }
  namespace_str_out = g_newa(gchar, namespace_length + 1);
  memmove(namespace_str_out, namespace_str, namespace_length);
  namespace_str_out[namespace_length] = '\0';
  typelib = g_irepository_require(self->gi_repository, namespace_str_out, NULL, 0,
                                  &inner_error);
  if (typelib == NULL) {
    g_slice_free1(namespace_length + 1, namespace_str_out);
    error_string = g_strdup_printf("%s: caught an error %s", G_STRFUNC,
                                   inner_error->message);
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s",
                     error_string);
    g_free(error_string);
    g_clear_error(&inner_error);
    goto error;
  }
  namespace_str_const = g_typelib_get_namespace(typelib);

  symbol_name = Dart_GetNativeArgument(arguments, 2);
  if (G_UNLIKELY(Dart_IsError(symbol_name))) {
    dart_error_out = symbol_name;
    goto error_native;
  }
  if (!Dart_IsString(symbol_name)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 2 arguments, a namespace and a symbol name", G_STRFUNC);
    goto error;
  }
  temp_result = Dart_StringToUTF8(symbol_name, (uint8_t **) &symbol_name_str, &symbol_name_length);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }
  symbol_name_str_out = g_newa(gchar, symbol_name_length + 1);
  memmove(symbol_name_str_out, symbol_name_str, symbol_name_length);
  symbol_name_str_out[symbol_name_length] = '\0';

  base_info = g_irepository_find_by_name(self->gi_repository,
                                         namespace_str_out,
                                         symbol_name_str_out);

  dart_type = Dart_GetNativeArgument(arguments, 3);
  if (G_UNLIKELY(Dart_IsError(dart_type))) {
    dart_error_out = dart_type;
    goto error_native;
  }
  if (!Dart_IsType(dart_type)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 3 arguments, a gtype, a namespace and the type of the container", G_STRFUNC);
    goto error;
  }
  namespace_context = g_newa(GdartBridgeContextNamespaceGtype, 1);
  namespace_context->namespace = namespace_str_const;
  namespace_context->gtype = gtype_as_gtype;
  namespace_context->base_info = base_info;
  namespace_context->base_info_klass = gi_registered_type_info_registered_type_info;

  dart_persistent_type = Dart_NewPersistentHandle(dart_type);
  if (gee_abstract_map_has_key(GEE_ABSTRACT_MAP(self->dart_classes_by_gtype),
                               (gconstpointer) namespace_context)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: the specified gtype was already registered", G_STRFUNC);
    goto error;
  }
  gee_abstract_map_set(GEE_ABSTRACT_MAP(self->dart_classes_by_gtype),
                       (gconstpointer) namespace_context,
                       (gconstpointer) dart_persistent_type);
  Dart_DeletePersistentHandle(dart_persistent_type);
  g_base_info_unref(base_info);
  Dart_ExitScope();
  return;
error:
  dart_error_out = Dart_ThrowException(dart_error_out);
error_native:
  Dart_PropagateError(dart_error_out);
}

void gdart_bridge_context_register_copy_func_for_gtype(Dart_NativeArguments arguments)
{
  GdartBridgeContext* self;
  Dart_Handle gtype, namespace, function_name, dart_error_out, temp_result,
              symbol_name;
  guint64 gtype_int;
  gintptr namespace_length, argument_count, function_name_str_length,
          symbol_name_length;
  gchar *namespace_str, *namespace_str_out, *function_name_str,
        *function_name_str_out, *error_string, *symbol_name_str,
        *symbol_name_str_out;
  const gchar* namespace_str_const;
  bool integer_fits;
  GType gtype_as_gtype;
  GError* inner_error = NULL;
  GITypelib* typelib;
  GdartBridgeContextNamespaceGtype *namespace_context;
  gpointer symbol;
  GIBaseInfo *base_info;

  Dart_EnterScope();

  self = gdart_bridge_context_new_from_isolate(Dart_CurrentIsolate());
  argument_count = Dart_GetNativeArgumentCount(arguments);
  if (argument_count < 3) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 3 arguments, a gtype, a namespace and the type of the container", G_STRFUNC);
    goto error;
  }
  gtype = Dart_GetNativeArgument(arguments, 0);
  if (G_UNLIKELY(Dart_IsError(gtype))) {
    dart_error_out = gtype;
    goto error_native;
  }
  if (!Dart_IsInteger(gtype)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 3 arguments, a gtype, a namespace and the type of the container", G_STRFUNC);
    goto error;
  }
  temp_result = Dart_IntegerFitsIntoUint64(gtype, &integer_fits);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }
  if (!integer_fits) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: the gtype parameter was not a valid gtype for this system.", G_STRFUNC);
    goto error;
  }
  temp_result = Dart_IntegerToUint64(gtype, &gtype_int);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }
  if (gtype_int > SIZE_MAX) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: the gtype parameter was not a valid gtype for this system.", G_STRFUNC);
    goto error;
  }
  gtype_as_gtype = (GType) gtype_int;
  namespace = Dart_GetNativeArgument(arguments, 1);
  if (G_UNLIKELY(Dart_IsError(namespace))) {
    dart_error_out = namespace;
    goto error_native;
  }
  if (!Dart_IsString(namespace)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 3 arguments, a gtype, a namespace and the type of the container", G_STRFUNC);
    goto error;
  }
  temp_result = Dart_StringToUTF8(namespace, (uint8_t **) &namespace_str, &namespace_length);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }


  symbol_name = Dart_GetNativeArgument(arguments, 2);
  if (G_UNLIKELY(Dart_IsError(symbol_name))) {
    dart_error_out = symbol_name;
    goto error_native;
  }
  if (!Dart_IsString(symbol_name)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 2 arguments, a namespace and a symbol name", G_STRFUNC);
    goto error;
  }
  temp_result = Dart_StringToUTF8(symbol_name, (uint8_t **) &symbol_name_str, &symbol_name_length);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }
  symbol_name_str_out = g_newa(gchar, symbol_name_length + 1);
  memmove(symbol_name_str_out, symbol_name_str, symbol_name_length);
  symbol_name_str_out[symbol_name_length] = '\0';



  function_name = Dart_GetNativeArgument(arguments, 3);
  if (G_UNLIKELY(Dart_IsError(function_name))) {
    dart_error_out = function_name;
    goto error_native;
  }
  if (!Dart_IsString(function_name)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 3 arguments, a gtype, a namespace and the type of the container", G_STRFUNC);
    goto error;
  }
  temp_result = Dart_StringToUTF8(function_name, (uint8_t **) &function_name_str, &function_name_str_length);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }

  namespace_str_out = g_newa(gchar, namespace_length + 1);
  memmove(namespace_str_out, namespace_str, namespace_length);
  namespace_str_out[namespace_length] = '\0';

  function_name_str_out = g_newa(gchar, function_name_str_length + 1);
  memmove(function_name_str_out, function_name_str, function_name_str_length);
  function_name_str_out[function_name_str_length] = '\0';

  typelib = g_irepository_require(self->gi_repository, namespace_str_out, NULL, 0,
                                  &inner_error);
  if (typelib == NULL) {
    g_slice_free1(namespace_length + 1, namespace_str_out);
    error_string = g_strdup_printf("%s: caught an error %s", G_STRFUNC,
                                   inner_error->message);
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s",
                     error_string);
    g_free(error_string);
    g_clear_error(&inner_error);
    goto error;
  }
  base_info = g_irepository_find_by_name(self->gi_repository,
                                         namespace_str_out,
                                         symbol_name_str_out);

  namespace_str_const = g_typelib_get_namespace(typelib);
  namespace_context = g_newa(GdartBridgeContextNamespaceGtype, 1);
  namespace_context->namespace = namespace_str_const;
  namespace_context->gtype = gtype_as_gtype;
  namespace_context->base_info = base_info;
  namespace_context->base_info_klass = gi_registered_type_info_registered_type_info;

  if (gee_abstract_map_has_key(GEE_ABSTRACT_MAP(self->dart_copy_funcs_by_gtype),
                               (gconstpointer) namespace_context)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: the specified gtype was already registered", G_STRFUNC);
    goto error;
  }
  if (!g_typelib_symbol(typelib, function_name_str_out, &symbol) ||
      symbol == NULL) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: could not find the specied symbol", G_STRFUNC);
    goto error;
  }

  gee_abstract_map_set(GEE_ABSTRACT_MAP(self->dart_copy_funcs_by_gtype),
                       (gconstpointer) namespace_context,
                       (gconstpointer) symbol);
  g_base_info_unref(base_info);
  Dart_ExitScope();

  return;
error:
  dart_error_out = Dart_ThrowException(dart_error_out);
error_native:
  Dart_PropagateError(dart_error_out);
}


void gdart_bridge_context_register_free_func_for_gtype(Dart_NativeArguments arguments)
{
  GdartBridgeContext* self;
  Dart_Handle gtype, namespace, function_name, dart_error_out, temp_result,
              symbol_name;
  guint64 gtype_int;
  gintptr namespace_length, argument_count, function_name_str_length,
          symbol_name_length;
  gchar *namespace_str, *namespace_str_out, *function_name_str,
        *function_name_str_out, *error_string, *symbol_name_str,
        *symbol_name_str_out;
  const gchar* namespace_str_const;
  bool integer_fits;
  GType gtype_as_gtype;
  GError* inner_error = NULL;
  GITypelib* typelib;
  GdartBridgeContextNamespaceGtype *namespace_context;
  gpointer symbol;
  GIBaseInfo* base_info;

  Dart_EnterScope();

  self = gdart_bridge_context_new_from_isolate(Dart_CurrentIsolate());
  argument_count = Dart_GetNativeArgumentCount(arguments);
  if (argument_count < 3) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 3 arguments, a gtype, a namespace and the type of the container", G_STRFUNC);
    goto error;
  }
  gtype = Dart_GetNativeArgument(arguments, 0);
  if (G_UNLIKELY(Dart_IsError(gtype))) {
    dart_error_out = gtype;
    goto error_native;
  }
  if (!Dart_IsInteger(gtype)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 3 arguments, a gtype, a namespace and the type of the container", G_STRFUNC);
    goto error;
  }
  temp_result = Dart_IntegerFitsIntoUint64(gtype, &integer_fits);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }
  if (!integer_fits) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: the gtype parameter was not a valid gtype for this system.", G_STRFUNC);
    goto error;
  }
  temp_result = Dart_IntegerToUint64(gtype, &gtype_int);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }
  if (gtype_int > SIZE_MAX) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: the gtype parameter was not a valid gtype for this system.", G_STRFUNC);
    goto error;
  }
  gtype_as_gtype = (GType) gtype_int;
  namespace = Dart_GetNativeArgument(arguments, 1);
  if (G_UNLIKELY(Dart_IsError(namespace))) {
    dart_error_out = namespace;
    goto error_native;
  }
  if (!Dart_IsString(namespace)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 3 arguments, a gtype, a namespace and the type of the container", G_STRFUNC);
    goto error;
  }
  temp_result = Dart_StringToUTF8(namespace, (uint8_t **) &namespace_str, &namespace_length);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }

  symbol_name = Dart_GetNativeArgument(arguments, 2);
  if (G_UNLIKELY(Dart_IsError(symbol_name))) {
    dart_error_out = symbol_name;
    goto error_native;
  }
  if (!Dart_IsString(symbol_name)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 2 arguments, a namespace and a symbol name", G_STRFUNC);
    goto error;
  }
  temp_result = Dart_StringToUTF8(symbol_name, (uint8_t **) &symbol_name_str, &symbol_name_length);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }
  symbol_name_str_out = g_newa(gchar, symbol_name_length + 1);
  memmove(symbol_name_str_out, symbol_name_str, symbol_name_length);
  symbol_name_str_out[symbol_name_length] = '\0';


  function_name = Dart_GetNativeArgument(arguments, 3);
  if (G_UNLIKELY(Dart_IsError(function_name))) {
    dart_error_out = function_name;
    goto error_native;
  }
  if (!Dart_IsString(function_name)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 3 arguments, a gtype, a namespace and the type of the container", G_STRFUNC);
    goto error;
  }
  temp_result = Dart_StringToUTF8(function_name, (uint8_t **) &function_name_str, &function_name_str_length);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }

  namespace_str_out = g_newa(gchar, namespace_length + 1);
  memmove(namespace_str_out, namespace_str, namespace_length);
  namespace_str_out[namespace_length] = '\0';

  function_name_str_out = g_newa(gchar, function_name_str_length + 1);
  memmove(function_name_str_out, function_name_str, function_name_str_length);
  function_name_str_out[function_name_str_length] = '\0';

  typelib = g_irepository_require(self->gi_repository, namespace_str_out, NULL, 0,
                                  &inner_error);
  base_info = g_irepository_find_by_name(self->gi_repository,
                                         namespace_str_out,
                                         symbol_name_str_out);
  if (typelib == NULL) {
    g_slice_free1(namespace_length + 1, namespace_str_out);
    error_string = g_strdup_printf("%s: caught an error %s", G_STRFUNC,
                                   inner_error->message);
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s",
                     error_string);
    g_free(error_string);
    g_clear_error(&inner_error);
    goto error;
  }

  namespace_str_const = g_typelib_get_namespace(typelib);
  namespace_context = g_newa(GdartBridgeContextNamespaceGtype, 1);
  namespace_context->namespace = namespace_str_const;
  namespace_context->gtype = gtype_as_gtype;
  namespace_context->base_info = base_info;
  namespace_context->base_info_klass = gi_registered_type_info_registered_type_info;

  if (gee_abstract_map_has_key(GEE_ABSTRACT_MAP(self->dart_free_funcs_by_gtype),
                               (gconstpointer) namespace_context)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: the specified gtype was already registered", G_STRFUNC);
    goto error;
  }
  if (!g_typelib_symbol(typelib, function_name_str_out, &symbol) ||
      symbol == NULL) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: could not find the specied symbol", G_STRFUNC);
    goto error;
  }

  gee_abstract_map_set(GEE_ABSTRACT_MAP(self->dart_free_funcs_by_gtype),
                       (gconstpointer) namespace_context,
                       (gconstpointer) symbol);
  g_base_info_unref(base_info);
  Dart_ExitScope();
  return;
error:
  dart_error_out = Dart_ThrowException(dart_error_out);
error_native:
  Dart_PropagateError(dart_error_out);
}

void gdart_bridge_context_lookup_gtype_from_named_type(
  Dart_NativeArguments arguments)
{
  Dart_EnterScope();
  GdartBridgeContext* self;
  gintptr argument_count, namespace_length, symbol_name_length;
  Dart_Handle dart_error_out, namespace, symbol_name, result, gtype_result;
  gchar *namespace_str, *symbol_name_str, *namespace_str_out,
        *symbol_name_str_out, *error_string;
  GIBaseInfo* result_base_info;
  GType gtype;
  GError* inner_error = NULL;
  self = gdart_bridge_context_new_from_isolate(Dart_CurrentIsolate());
  argument_count = Dart_GetNativeArgumentCount(arguments);
  if (argument_count < 2) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 2 arguments, a namespace and a symbol name", G_STRFUNC);
    goto error;
  }
  namespace = Dart_GetNativeArgument(arguments, 0);
  if (G_UNLIKELY(Dart_IsError(namespace))) {
    dart_error_out = namespace;
    goto error_native;
  }
  if (!Dart_IsString(namespace)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 2 arguments, a namespace and a symbol name", G_STRFUNC);
    goto error;
  }
  symbol_name = Dart_GetNativeArgument(arguments, 1);
  if (G_UNLIKELY(Dart_IsError(symbol_name))) {
    dart_error_out = symbol_name;
    goto error_native;
  }
  if (!Dart_IsString(symbol_name)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 2 arguments, a namespace and a symbol name", G_STRFUNC);
    goto error;
  }
  result = Dart_StringToUTF8(namespace, (uint8_t **) &namespace_str, &namespace_length);
  if (G_UNLIKELY(Dart_IsError(result))) {
    dart_error_out = result;
    goto error_native;
  }
  result = Dart_StringToUTF8(symbol_name, (uint8_t **) &symbol_name_str, &symbol_name_length);
  if (G_UNLIKELY(Dart_IsError(result))) {
    dart_error_out = result;
    goto error_native;
  }
  namespace_str_out = g_newa(gchar, namespace_length + 1);
  memmove(namespace_str_out, namespace_str, namespace_length);
  namespace_str_out[namespace_length] = '\0';
  symbol_name_str_out = g_newa(gchar, symbol_name_length + 1);
  memmove(symbol_name_str_out, symbol_name_str, symbol_name_length);
  symbol_name_str_out[symbol_name_length] = '\0';
  if (g_irepository_require(self->gi_repository, namespace_str_out, NULL, 0,
                            &inner_error) == NULL) {
    error_string = g_strdup_printf("%s: caught an error %s", G_STRFUNC,
                                   inner_error->message);
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s",
                     error_string);
    g_free(error_string);
    g_clear_error(&inner_error);
    goto error;
  }
  result_base_info = g_irepository_find_by_name(self->gi_repository, namespace_str_out, symbol_name_str_out);
  if (result_base_info == NULL) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: did not find the specified type", G_STRFUNC);
    goto error;
  }
  if (!GI_IS_REGISTERED_TYPE_INFO(result_base_info)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: found the specified symbol but it wasn't a type", G_STRFUNC);
    g_base_info_unref(result_base_info);
    goto error;
  }
  gtype = g_registered_type_info_get_g_type((GIRegisteredTypeInfo*) result_base_info);
  gtype_result = Dart_NewIntegerFromUint64((guint64) gtype);
  if (G_UNLIKELY(Dart_IsError(gtype_result))) {
    dart_error_out = gtype_result;
    goto error_native;
  }
  Dart_SetReturnValue(arguments, gtype_result);
  Dart_ExitScope();
  return;
error:
  dart_error_out = Dart_ThrowException(dart_error_out);
error_native:
  Dart_PropagateError(dart_error_out);
}


void gdart_bridge_context_lookup_gtype_for_slist(
  Dart_NativeArguments arguments)
{
  Dart_EnterScope();
  Dart_Handle dart_error_out, gtype_result;
  gtype_result = Dart_NewIntegerFromUint64((guint64) G_DART_COMPAT_SLIST_TYPE);
  if (G_UNLIKELY(Dart_IsError(gtype_result))) {
    dart_error_out = gtype_result;
    goto error_native;
  }
  Dart_SetReturnValue(arguments, gtype_result);
  Dart_ExitScope();
  return;
error_native:
  Dart_PropagateError(dart_error_out);
}

void gdart_bridge_context_lookup_gtype_for_list(
  Dart_NativeArguments arguments)
{
  Dart_EnterScope();
  Dart_Handle dart_error_out, gtype_result;
  gtype_result = Dart_NewIntegerFromUint64((guint64) G_DART_COMPAT_LIST_TYPE);
  if (G_UNLIKELY(Dart_IsError(gtype_result))) {
    dart_error_out = gtype_result;
    goto error_native;
  }
  Dart_SetReturnValue(arguments, gtype_result);
  Dart_ExitScope();
  return;
error_native:
  Dart_PropagateError(dart_error_out);
}


void gdart_bridge_context_finalize_wrapped_gobject(void* container)
{
  GdartBridgeContextWrappedObject* wrapper = (GdartBridgeContextWrappedObject*) container;
  GIObjectInfoUnrefFunction unrefer;
  
  unrefer = g_object_info_get_unref_function_pointer(wrapper->object_info);
  wrapper->object_info_klass.cast_to_object_info(wrapper->object_info)
    ->get_unref_function_pointer(wrapper->object_info,
				 NULL,
				 &unrefer,
			         NULL,
				 NULL);
  if (unrefer != NULL) {
    unrefer(wrapper->object);
  } else {
    g_object_unref(wrapper->object);
  }
  wrapper->object_info_klass.free(wrapper->object_info);
  g_slice_free(GdartBridgeContextWrappedObject, wrapper);
}


void gdart_bridge_context_finalize_wrapped_struct(void* container)
{
  GdartBridgeContextWrappedObject* wrapper = (GdartBridgeContextWrappedObject*) container;
  g_free(wrapper->object);
  wrapper->object_info_klass.free(wrapper->object_info);
  g_slice_free(GdartBridgeContextWrappedObject, wrapper);
}

void gdart_bridge_context_finalize_wrapped_unowned_struct(void* container)
{
  GdartBridgeContextWrappedObject* wrapper = (GdartBridgeContextWrappedObject*) container;
  wrapper->object_info_klass.free(wrapper->object_info);
  g_slice_free(GdartBridgeContextWrappedObject, wrapper);
}

void gdart_bridge_context_finalize_wrapped_custom_struct(void* container)
{
  GdartBridgeContextWrappedObject* wrapper = (GdartBridgeContextWrappedObject*) container;
  wrapper->object_info_klass.free(wrapper->object_info);
  if (wrapper->copy_func != NULL && wrapper->free_func != NULL) {
    wrapper->free_func(wrapper->object);
  }
  g_slice_free(GdartBridgeContextWrappedObject, wrapper);
}


void gdart_bridge_context_finalize_wrapped_boxed(void* container)
{
  GdartBridgeContextWrappedObject* wrapper = (GdartBridgeContextWrappedObject*) container;
  g_boxed_free(wrapper->type, wrapper->object);
  wrapper->object_info_klass.free(wrapper->object_info);
  g_slice_free(GdartBridgeContextWrappedObject, wrapper);
}

gpointer gdart_bridge_context_retrieve_free_func(
  GdartBridgeContext* self,
  const gchar* namespace,
  gpointer base_info,
  const RegisteredTypeInfoKlass* base_info_klass,
  GType type)
{
  GdartBridgeContextNamespaceGtype* namespace_context;
  namespace_context = g_newa(GdartBridgeContextNamespaceGtype, 1);
  namespace_context->namespace = namespace;
  namespace_context->gtype = type;
  namespace_context->base_info = base_info;
  namespace_context->base_info_klass = *base_info_klass;
  return gee_abstract_map_get(GEE_ABSTRACT_MAP(self->dart_free_funcs_by_gtype),
                              (gconstpointer) namespace_context);
}

gpointer gdart_bridge_context_retrieve_copy_func(
  GdartBridgeContext* self,
  const gchar* namespace,
  gpointer base_info,
  const RegisteredTypeInfoKlass* base_info_klass,
  GType type)
{
  GdartBridgeContextNamespaceGtype* namespace_context;
  namespace_context = g_newa(GdartBridgeContextNamespaceGtype, 1);
  namespace_context->namespace = namespace;
  namespace_context->gtype = type;
  namespace_context->base_info = base_info;
  namespace_context->base_info_klass = *base_info_klass;
  return gee_abstract_map_get(GEE_ABSTRACT_MAP(self->dart_copy_funcs_by_gtype),
                              (gconstpointer) namespace_context);
}

Dart_Handle gdart_bridge_context_retrieve_wrapping_class(
  GdartBridgeContext* self,
  const gchar* namespace,
  GType type,
  gpointer base_info,
  const RegisteredTypeInfoKlass* base_info_klass,
  gboolean is_enum,
  Dart_Handle *dart_error_out,
  GError **error)
{
  GdartBridgeContextNamespaceGtype* namespace_context;
  Dart_PersistentHandle type_handle;
  Dart_Handle dart_inner_error;
  gpointer type_handle_as_pointer;
  GError *inner_error = NULL;

  namespace_context = g_newa(GdartBridgeContextNamespaceGtype, 1);
  namespace_context->namespace = namespace;
  namespace_context->gtype = type;
  namespace_context->base_info = base_info;
  namespace_context->base_info_klass = *base_info_klass;
  type_handle_as_pointer = gee_abstract_map_get(
                             GEE_ABSTRACT_MAP(self->dart_classes_by_gtype),
                             (gconstpointer) namespace_context);
  if (type_handle_as_pointer == NULL) {
    if (!_gdart_bridge_context_ensure_loaded_unknown_object_class(self, &dart_inner_error, &inner_error)) {
      *dart_error_out = dart_inner_error;
      g_propagate_error(error, inner_error);
      return NULL;
    }

    g_warning("Could not find a dart-registered wrapper for the type: [%s.%s]",
              g_base_info_get_namespace(base_info),
              g_base_info_get_name(base_info));
    if (is_enum) {
      if (!_gdart_bridge_context_ensure_loaded_base_enum_class(self,
          dart_error_out,
          error)) {
        return NULL;
      }
      type_handle = self->gdart_base_enum_class;
    } else {
      if (!_gdart_bridge_context_ensure_loaded_unknown_object_class(self,
          dart_error_out,
          error)) {
        return NULL;
      }
      type_handle = self->gdart_unknown_object_class;
    }
  } else {
    type_handle = (Dart_PersistentHandle) type_handle_as_pointer;
  }
  return Dart_HandleFromPersistent(type_handle);
}

Dart_Handle gdart_bridge_context_wrap_class_for_error(
  GdartBridgeContext* self,
  GQuark error_domain,
  gint code,
  const gchar* message,
  Dart_Handle *dart_error_out,
  GError **error)
{
  GdartBridgeContextNamespaceGquark* namespace_context;
  Dart_Handle dart_inner_error, name_handle, enum_class, int_handle,
              final_result, constructor_parameters[3], type_handle;
  gpointer type_handle_as_pointer;
  GError *inner_error = NULL;
  GIEnumInfo *enum_info;
  const gchar *error_domain_namespace;
  GType gtype;
  gboolean is_generic;
  gint message_length;


  namespace_context = g_newa(GdartBridgeContextNamespaceGquark, 1);
  namespace_context->quark = error_domain;
  type_handle_as_pointer = gee_abstract_map_get(
                             GEE_ABSTRACT_MAP(self->dart_classes_by_gerror_quark),
                             (gconstpointer) namespace_context);
  if (type_handle_as_pointer == NULL) {
    if (!_gdart_bridge_context_ensure_loaded_unknown_object_class(self, &dart_inner_error, &inner_error)) {
      *dart_error_out = dart_inner_error;
      g_propagate_error(error, inner_error);
      return NULL;
    }
    g_warning("Could not find a dart-registered wrapper for the errordomain: ['%s']",
              g_quark_to_string(error_domain));
    if (!_gdart_bridge_context_ensure_loaded_unknown_error_class(self,
        dart_error_out,
        error)) {
      return NULL;
    }
    type_handle = Dart_HandleFromPersistent(self->gdart_unknown_error_class);
    name_handle = Dart_NewStringFromCString("fromFields");
    constructor_parameters[0] = Dart_NewInteger(error_domain);
    if (G_UNLIKELY(Dart_IsError(constructor_parameters[0]))) {
      *dart_error_out = constructor_parameters[0];
      g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
      return NULL;
    }
    is_generic = TRUE;
  } else {
    type_handle = Dart_HandleFromPersistent((Dart_PersistentHandle) type_handle_as_pointer);
    name_handle = Dart_Null();
    is_generic = FALSE;
  }
  enum_info = g_irepository_find_by_error_domain(self->gi_repository,
              error_domain);
  gtype = g_registered_type_info_get_g_type((GIRegisteredTypeInfo*) enum_info);
  error_domain_namespace = g_base_info_get_namespace((GIBaseInfo*) enum_info);
  enum_class = gdart_bridge_context_retrieve_wrapping_class(
                 self,
                 error_domain_namespace,
                 gtype,
                 enum_info,
		 &gi_registered_type_info_registered_type_info,
                 TRUE,
                 dart_error_out,
                 error);
  g_base_info_unref((GIBaseInfo*) enum_info);
  if (enum_class == NULL) {
    return NULL;
  }
  int_handle = Dart_NewInteger(code);
  if (G_UNLIKELY(Dart_IsError(int_handle))) {
    *dart_error_out = int_handle;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return NULL;
  }
  constructor_parameters[1] = Dart_New(enum_class, Dart_Null(), 1, &int_handle);
  if (G_UNLIKELY(Dart_IsError(constructor_parameters[1]))) {
    *dart_error_out = constructor_parameters[1];
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return NULL;
  }
  message_length = g_utf8_strlen(message, -1);
  constructor_parameters[2] = Dart_NewStringFromUTF8((const guint8*) message, message_length);
  if (G_UNLIKELY(Dart_IsError(constructor_parameters[2]))) {
    *dart_error_out = constructor_parameters[2];
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return NULL;
  }
  if (is_generic) {
    final_result = Dart_New(type_handle, name_handle, 3, constructor_parameters);
  } else {
    final_result = Dart_New(type_handle, name_handle, 2, &constructor_parameters[1]);
  }
  if (G_UNLIKELY(Dart_IsError(final_result))) {
    *dart_error_out = final_result;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return NULL;
  }
  return final_result;
}

Dart_Handle gdart_bridge_context_wrap_internal_pointer(GdartBridgeContext* self,
    Dart_Handle internal_container,
    const gchar* namespace,
    GType type,
    gpointer base_info,
    const RegisteredTypeInfoKlass* base_info_klass,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dart_type, result,
              temp_result, name_handle;

  dart_type = gdart_bridge_context_retrieve_wrapping_class(
                self,
                namespace,
                type,
                base_info,
		base_info_klass,
                FALSE,
                dart_error_out,
                error);
  if (dart_type == NULL) {
    return NULL;
  }
  if (G_UNLIKELY(Dart_IsError(dart_type))) {
    *dart_error_out = dart_type;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return NULL;
  }
  name_handle = Dart_NewStringFromCString("fromNative");
  if (G_UNLIKELY(Dart_IsError(name_handle))) {
    *dart_error_out = name_handle;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return NULL;
  }
  result = Dart_New(dart_type, name_handle, 0, NULL);
  if (G_UNLIKELY(Dart_IsError(result))) {
    *dart_error_out = result;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return NULL;
  }
  name_handle = Dart_NewStringFromCString("_internal");
  if (G_UNLIKELY(Dart_IsError(name_handle))) {
    *dart_error_out = name_handle;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return NULL;
  }
  temp_result = Dart_SetField(result, name_handle, internal_container);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    *dart_error_out = temp_result;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return NULL;
  }
  return result;
}

Dart_Handle _gdart_bridge_context_wrap_object(GdartBridgeContext* self,
    void* object,
    GIObjectInfo* object_info,
    GType type,
    Dart_Handle *dart_error_out,
    GError **error)
{
  GdartBridgeContextNamespaceGtype* namespace_context;
  GdartBridgeContextWrappedObject* wrapped_object;
  Dart_PersistentHandle type_handle;
  Dart_Handle dart_type, result, internal_container, dart_inner_error,
              temp_result, name_handle;
  gpointer type_handle_as_pointer;
  GError *inner_error = NULL;

  namespace_context = g_newa(GdartBridgeContextNamespaceGtype, 1);
  namespace_context->namespace = g_base_info_get_namespace((GIBaseInfo*) object_info);
  namespace_context->gtype = type;
  type_handle_as_pointer = gee_abstract_map_get(
                             GEE_ABSTRACT_MAP(self->dart_classes_by_gtype),
                             (gconstpointer) namespace_context);
  if (type_handle_as_pointer == NULL) {
    if (!_gdart_bridge_context_ensure_loaded_unknown_object_class(self, &dart_inner_error, &inner_error)) {
      *dart_error_out = dart_inner_error;
      g_propagate_error(error, inner_error);
      return NULL;
    }
    type_handle = self->gdart_unknown_object_class;
  } else {
    type_handle = (Dart_PersistentHandle) type_handle_as_pointer;
  }
  name_handle = Dart_NewStringFromCString("fromNative");
  if (G_UNLIKELY(Dart_IsError(name_handle))) {
    *dart_error_out = name_handle;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return NULL;
  }
  dart_type = Dart_HandleFromPersistent(type_handle);
  Dart_DeletePersistentHandle(dart_type);
  if (G_UNLIKELY(Dart_IsError(dart_type))) {
    *dart_error_out = dart_type;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return NULL;
  }
  result = Dart_New(dart_type, name_handle, 0, NULL);
  if (G_UNLIKELY(Dart_IsError(result))) {
    *dart_error_out = result;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return NULL;
  }
  wrapped_object = g_slice_new(GdartBridgeContextWrappedObject);
  wrapped_object->object = object;
  wrapped_object->object_info = (GIObjectInfo*) g_base_info_ref((GIBaseInfo*) object_info);
  wrapped_object->type = type;
  internal_container = gdart_bridge_context_wrap_pointer(self, wrapped_object,
                       gdart_bridge_context_finalize_wrapped_gobject,
                       &dart_inner_error, &inner_error);
  if (internal_container == NULL) {
    *dart_error_out = dart_inner_error;
    g_propagate_error(error, inner_error);
    return NULL;
  }
  name_handle = Dart_NewStringFromCString("_internal");
  if (G_UNLIKELY(Dart_IsError(name_handle))) {
    *dart_error_out = name_handle;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return NULL;
  }
  temp_result = Dart_SetField(result, name_handle, internal_container);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    *dart_error_out = temp_result;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return NULL;
  }
  return result;
}


struct _GdartBridgeContextWrappedObjectInfo {
  GIRegisteredTypeInfo* object_info;
};

static void _gdart_bridge_context_finalize_wrapped_object_info(void* container)
{
  GdartBridgeContextWrappedObjectInfo* wrapper = (GdartBridgeContextWrappedObjectInfo*) container;
  g_base_info_unref((GIBaseInfo*) wrapper->object_info);
  g_slice_free(GdartBridgeContextWrappedObjectInfo, wrapper);
}

Dart_Handle _gdart_bridge_context_wrap_object_info(GdartBridgeContext* self,
    GIRegisteredTypeInfo* object_info,
    Dart_Handle *dart_error_out,
    GError **error)
{
  GdartBridgeContextWrappedObjectInfo* wrapped_object;
  Dart_PersistentHandle type_handle;
  Dart_Handle dart_type, result, internal_container, dart_inner_error,
              temp_result, name_handle;
  GError *inner_error = NULL;

  if (!_gdart_bridge_context_ensure_loaded_object_info_class(self, &dart_inner_error, &inner_error)) {
    *dart_error_out = dart_inner_error;
    g_propagate_error(error, inner_error);
    return NULL;
  }
  type_handle = self->gdart_object_info_class;

  name_handle = Dart_NewStringFromCString("fromNative");
  if (G_UNLIKELY(Dart_IsError(name_handle))) {
    *dart_error_out = name_handle;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return NULL;
  }
  dart_type = Dart_HandleFromPersistent(type_handle);

  if (G_UNLIKELY(Dart_IsError(dart_type))) {
    *dart_error_out = dart_type;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return NULL;
  }
  result = Dart_New(dart_type, name_handle, 0, NULL);
  if (G_UNLIKELY(Dart_IsError(result))) {
    *dart_error_out = result;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return NULL;
  }
  wrapped_object = g_slice_new(GdartBridgeContextWrappedObjectInfo);
  wrapped_object->object_info = (GIRegisteredTypeInfo*) g_base_info_ref((GIBaseInfo*) object_info);
  internal_container = gdart_bridge_context_wrap_pointer(self, wrapped_object,
                       _gdart_bridge_context_finalize_wrapped_object_info,
                       &dart_inner_error, &inner_error);
  if (internal_container == NULL) {
    *dart_error_out = dart_inner_error;
    g_propagate_error(error, inner_error);
    return NULL;
  }
  name_handle = Dart_NewStringFromCString("_internal");
  if (G_UNLIKELY(Dart_IsError(name_handle))) {
    *dart_error_out = name_handle;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return NULL;
  }
  temp_result = Dart_SetField(result, name_handle, internal_container);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    *dart_error_out = temp_result;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return NULL;
  }
  return result;
}

GIRegisteredTypeInfo* gdart_bridge_context_unwrap_object_info(GdartBridgeContext* self,
    Dart_Handle wrapped,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle inner_container,
              temp_result, name_handle;
  RawPointerContainer* raw_pointer;
  GdartBridgeContextWrappedObjectInfo* object_info;

  name_handle = Dart_NewStringFromCString("_internal");
  if (G_UNLIKELY(Dart_IsError(name_handle))) {
    *dart_error_out = name_handle;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return NULL;
  }
  inner_container = Dart_GetField(wrapped, name_handle);
  if (G_UNLIKELY(Dart_IsError(inner_container))) {
    *dart_error_out = inner_container;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return NULL;
  }
  temp_result = Dart_GetNativeInstanceField(inner_container, 0, (intptr_t*) &raw_pointer);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    *dart_error_out = temp_result;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return NULL;
  }
  object_info = (GdartBridgeContextWrappedObjectInfo*) raw_pointer->raw_pointer;
  return object_info->object_info;
}

GdartBridgeContextWrappedObject* gdart_bridge_context_unwrap_object(
  GdartBridgeContext* self,
  Dart_Handle wrapped,
  Dart_Handle *dart_error_out,
  GError **error)
{
  Dart_Handle inner_container,
              temp_result, name_handle;
  RawPointerContainer* raw_pointer;
  GdartBridgeContextWrappedObject* object_info;

  name_handle = Dart_NewStringFromCString("_internal");
  if (G_UNLIKELY(Dart_IsError(name_handle))) {
    *dart_error_out = name_handle;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return NULL;
  }
  inner_container = Dart_GetField(wrapped, name_handle);
  if (G_UNLIKELY(Dart_IsError(inner_container))) {
    *dart_error_out = inner_container;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return NULL;
  }
  temp_result = Dart_GetNativeInstanceField(inner_container, 0, (intptr_t*) &raw_pointer);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    *dart_error_out = temp_result;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return NULL;
  }
  object_info = (GdartBridgeContextWrappedObject*) raw_pointer->raw_pointer;
  return object_info;
}

void gdart_bridge_context_lookup_object_info(
  Dart_NativeArguments arguments)
{
  Dart_EnterScope();
  GdartBridgeContext* self;
  gintptr argument_count, namespace_length, symbol_name_length;
  Dart_Handle dart_error_out, namespace, symbol_name, result, wrapped_result;
  gchar *namespace_str, *symbol_name_str, *namespace_str_out,
        *symbol_name_str_out, *error_string;
  GIBaseInfo* result_base_info;
  GError* inner_error = NULL;
  self = gdart_bridge_context_new_from_isolate(Dart_CurrentIsolate());
  argument_count = Dart_GetNativeArgumentCount(arguments);
  if (argument_count < 2) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 2 arguments, a namespace and a symbol name", G_STRFUNC);
    goto error;
  }
  namespace = Dart_GetNativeArgument(arguments, 0);
  if (G_UNLIKELY(Dart_IsError(namespace))) {
    dart_error_out = namespace;
    goto error_native;
  }
  if (!Dart_IsString(namespace)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 2 arguments, a namespace and a symbol name", G_STRFUNC);
    goto error;
  }
  symbol_name = Dart_GetNativeArgument(arguments, 1);
  if (G_UNLIKELY(Dart_IsError(symbol_name))) {
    dart_error_out = symbol_name;
    goto error_native;
  }
  if (!Dart_IsString(symbol_name)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 2 arguments, a namespace and a symbol name", G_STRFUNC);
    goto error;
  }
  result = Dart_StringToUTF8(namespace, (uint8_t **) &namespace_str, &namespace_length);
  if (G_UNLIKELY(Dart_IsError(result))) {
    dart_error_out = result;
    goto error_native;
  }
  result = Dart_StringToUTF8(symbol_name, (uint8_t **) &symbol_name_str, &symbol_name_length);
  if (G_UNLIKELY(Dart_IsError(result))) {
    dart_error_out = result;
    goto error_native;
  }
  namespace_str_out = g_newa(gchar, namespace_length + 1);
  memmove(namespace_str_out, namespace_str, namespace_length);
  namespace_str_out[namespace_length] = '\0';
  symbol_name_str_out = g_newa(gchar, symbol_name_length + 1);
  memmove(symbol_name_str_out, symbol_name_str, symbol_name_length);
  symbol_name_str_out[symbol_name_length] = '\0';
  if (g_irepository_require(self->gi_repository, namespace_str_out, NULL, 0,
                            &inner_error) == NULL) {
    error_string = g_strdup_printf("%s: caught an error %s", G_STRFUNC,
                                   inner_error->message);
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s",
                     error_string);
    g_free(error_string);
    g_clear_error(&inner_error);
    goto error;
  }
  result_base_info = g_irepository_find_by_name(self->gi_repository, namespace_str_out, symbol_name_str_out);
  if (result_base_info == NULL) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: did not find an object info", G_STRFUNC);
    goto error;
  }
  if (!GI_IS_OBJECT_INFO(result_base_info) &&
      !GI_IS_STRUCT_INFO(result_base_info) &&
      !GI_IS_UNION_INFO(result_base_info)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: found a type but it wasn't a Object, Struct or Union", G_STRFUNC);
    g_base_info_unref(result_base_info);
    goto error;
  }
  wrapped_result = _gdart_bridge_context_wrap_object_info(self,
                   (GIRegisteredTypeInfo*) result_base_info,
                   &result,
                   &inner_error);
  if (wrapped_result == NULL) {
    dart_error_out = result;
    goto error;
  }
  g_base_info_unref(result_base_info);
  Dart_SetReturnValue(arguments, wrapped_result);
  Dart_ExitScope();
  return;
error:
  dart_error_out = Dart_ThrowException(dart_error_out);
error_native:
  Dart_PropagateError(dart_error_out);
}


static gboolean _gdart_bridge_context_invoke_static(GdartBridgeContext *self,
    const gchar *function_name,
    GIFunctionInfo *function,
    Dart_Handle dart_args,
    Dart_Handle *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  gint garg_i = 0, garg_length, garg_in_count = 0, garg_out_count = 0;
  gintptr dart_args_length;
  GIDirection arg_direction;
  Dart_Handle temp_result;
  gint *suppressed_args, suppressed_args_length;
  garg_length = g_callable_info_get_n_args((GICallableInfo*) function);

  for (; garg_i < garg_length; garg_i++) {
    GIArgInfo type_info;
    g_callable_info_load_arg((GICallableInfo*) function, garg_i, &type_info);
    arg_direction = g_arg_info_get_direction(&type_info);
    if (arg_direction == GI_DIRECTION_IN ||
        arg_direction == GI_DIRECTION_INOUT) {
      garg_in_count++;
    }
    if (arg_direction == GI_DIRECTION_OUT ||
        arg_direction == GI_DIRECTION_INOUT) {
      garg_out_count++;
    }
  }
  temp_result = Dart_ListLength(dart_args, &dart_args_length);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    *dart_error_out = temp_result;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return FALSE;
  }

  if (!gdart_marshaller_check_arguments(self, function, dart_args,
                                        garg_length, dart_args_length, &suppressed_args,
                                        &suppressed_args_length, dart_error_out, error)) {
    return FALSE;
  }
  if (!gdart_function_invoke(self,
                             function_name,
                             function,
                             &gi_callable_info_callable_info,
                             NULL,
			     &null_registered_type_info,
                             0,
                             NULL,
                             dart_args,
                             suppressed_args,
                             suppressed_args_length,
                             result_out,
                             dart_error_out,
                             error)) {
    return FALSE;
  }
  return TRUE;
}


static gboolean _gdart_bridge_context_invoke_method(GdartBridgeContext *self,
    const gchar* method_name,
    GIFunctionInfo *function,
    Dart_Handle dart_receiver,
    GIRegisteredTypeInfo *registered_type_info,
    GType gtype,
    Dart_Handle dart_args,
    Dart_Handle *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  gint garg_i = 0, garg_length, garg_in_count = 0, garg_out_count = 0;
  gintptr dart_args_length;
  GIDirection arg_direction;
  Dart_Handle temp_result;
  gint *suppressed_args, suppressed_args_length;
  garg_length = g_callable_info_get_n_args((GICallableInfo*) function);

  for (; garg_i < garg_length; garg_i++) {
    GIArgInfo type_info;
    g_callable_info_load_arg((GICallableInfo*) function, garg_i, &type_info);
    arg_direction = g_arg_info_get_direction(&type_info);
    if (arg_direction == GI_DIRECTION_IN ||
        arg_direction == GI_DIRECTION_INOUT) {
      garg_in_count++;
    }
    if (arg_direction == GI_DIRECTION_OUT ||
        arg_direction == GI_DIRECTION_INOUT) {
      garg_out_count++;
    }
  }
  temp_result = Dart_ListLength(dart_args, &dart_args_length);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    *dart_error_out = temp_result;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return FALSE;
  }

  if (!gdart_marshaller_check_arguments(self, function, dart_args,
                                        garg_length, dart_args_length, &suppressed_args,
                                        &suppressed_args_length, dart_error_out, error)) {
    return FALSE;
  }
  if (!gdart_function_invoke(self,
                             method_name,
                             function,
                             &gi_callable_info_callable_info,
                             registered_type_info,
			     &gi_registered_type_info_registered_type_info,
                             gtype,
                             dart_receiver,
                             dart_args,
                             suppressed_args,
                             suppressed_args_length,
                             result_out,
                             dart_error_out,
                             error)) {
    return FALSE;
  }
  return TRUE;
}

Dart_Handle gdart_bridge_context_get_object_info_class(GdartBridgeContext *self)
{
  return Dart_HandleFromPersistent(self->gdart_object_info_class);
}

void gdart_bridge_context_object_info_call_static(
  Dart_NativeArguments arguments)
{
  Dart_EnterScope();
  GdartBridgeContext* self;
  gintptr argument_count, symbol_name_length;
  Dart_Handle dart_error_out, receiver, expected_type, symbol_name, temp_result,
              dart_inner_error, args_list, final_result;
  gchar *symbol_name_str,
        *symbol_name_str_out,
        *error_prefix;
  bool is_of_type;
  GIRegisteredTypeInfo* result_base_info;
  GIFunctionInfo* function_info;
  GError* inner_error = NULL;
  GIFunctionInfoFlags function_flags;

  self = gdart_bridge_context_new_from_isolate(Dart_CurrentIsolate());
  argument_count = Dart_GetNativeArgumentCount(arguments);
  if (argument_count < 3) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 3 arguments, the receiver, the method name, and a list of arguments", G_STRFUNC);
    goto error;
  }
  receiver = Dart_GetNativeArgument(arguments, 0);
  if (G_UNLIKELY(Dart_IsError(receiver))) {
    dart_error_out = receiver;
    goto error_native;
  }
  if (!_gdart_bridge_context_ensure_loaded_object_info_class(self, &dart_inner_error, &inner_error)) {
    dart_error_out = dart_inner_error;
    g_clear_error(&inner_error);
    goto error;
  }
  expected_type = gdart_bridge_context_get_object_info_class(self);
  if (G_UNLIKELY(Dart_IsError(expected_type))) {
    dart_error_out = expected_type;
    goto error_native;
  }
  temp_result = Dart_ObjectIsType(receiver, expected_type, &is_of_type);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }
  symbol_name = Dart_GetNativeArgument(arguments, 1);
  if (G_UNLIKELY(Dart_IsError(symbol_name))) {
    dart_error_out = symbol_name;
    goto error_native;
  }
  if (!Dart_IsString(symbol_name)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 3 arguments, the receiver, the method name, and a list of arguments", G_STRFUNC);
    goto error;
  }
  temp_result = Dart_StringToUTF8(symbol_name, (uint8_t **) &symbol_name_str, &symbol_name_length);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }
  symbol_name_str_out = g_newa(gchar, symbol_name_length + 1);
  memmove(symbol_name_str_out, symbol_name_str, symbol_name_length);
  symbol_name_str_out[symbol_name_length] = '\0';

  result_base_info = gdart_bridge_context_unwrap_object_info(self, receiver, &dart_inner_error, &inner_error);
  if (result_base_info == NULL) {
    dart_error_out = dart_inner_error;
    goto error_native;
  }
  switch (g_base_info_get_type(result_base_info)) {
  case GI_INFO_TYPE_OBJECT:
    function_info = g_object_info_find_method((GIObjectInfo*) result_base_info,
                    symbol_name_str_out);
    break;
  case GI_INFO_TYPE_STRUCT:
    function_info = g_struct_info_find_method((GIStructInfo*) result_base_info,
                    symbol_name_str_out);
    break;
  case GI_INFO_TYPE_UNION:
    function_info = g_union_info_find_method((GIUnionInfo *) result_base_info,
                    symbol_name_str_out);
    break;
  default:
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: was called on an unexpected type", G_STRFUNC);
    goto error;
  }
  if (function_info == NULL) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: did not find an function info with the specified name", G_STRFUNC);
    goto error;
  }
  function_flags = g_function_info_get_flags(function_info);
  if (function_flags & GI_FUNCTION_IS_METHOD) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: found a method and not a static function", G_STRFUNC);
    goto error;
  }
  args_list = Dart_GetNativeArgument(arguments, 2);
  if (G_UNLIKELY(Dart_IsError(args_list))) {
    g_base_info_unref((GIBaseInfo*) function_info);
    dart_error_out = args_list;
    goto error_native;
  }
  if (!Dart_IsList(args_list)) {
    g_base_info_unref((GIBaseInfo*) function_info);
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: the arguments argument was not a list", G_STRFUNC);
    goto error;
  }
  error_prefix = g_strdup_printf("%s.%s.%s",
                                 g_base_info_get_namespace(result_base_info),
                                 g_base_info_get_name(result_base_info),
                                 symbol_name_str_out);
  if (!_gdart_bridge_context_invoke_static(self,
      error_prefix,
      function_info,
      args_list,
      &final_result,
      &dart_inner_error,
      &inner_error)) {
    g_free(error_prefix);
    g_base_info_unref((GIBaseInfo*) function_info);
    g_clear_error(&inner_error);
    dart_error_out = dart_inner_error;
    goto error;
  }
  g_free(error_prefix);

  g_base_info_unref((GIBaseInfo*) function_info);
  Dart_SetReturnValue(arguments, final_result);
  Dart_ExitScope();
  return;
error:
  dart_error_out = Dart_ThrowException(dart_error_out);
error_native:
  Dart_PropagateError(dart_error_out);
}

void gdart_bridge_context_object_info_call_method_on_receiver(
  Dart_NativeArguments arguments)
{
  Dart_EnterScope();
  GdartBridgeContext* self;
  gintptr argument_count, symbol_name_length;
  Dart_Handle dart_error_out, receiver, expected_type, symbol_name, temp_result,
              dart_inner_error, args_list, final_result, this_argument;
  gchar *symbol_name_str,
        *symbol_name_str_out,
        *error_prefix;
  bool is_of_type;
  GIRegisteredTypeInfo* result_base_info;
  GIFunctionInfo* function_info;
  GError* inner_error = NULL;
  GIFunctionInfoFlags function_flags;

  self = gdart_bridge_context_new_from_isolate(Dart_CurrentIsolate());
  argument_count = Dart_GetNativeArgumentCount(arguments);
  if (argument_count < 4) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 4 arguments, the original receiver, the method name, the target receiver, and a list of arguments", G_STRFUNC);
    goto error;
  }
  receiver = Dart_GetNativeArgument(arguments, 0);
  if (G_UNLIKELY(Dart_IsError(receiver))) {
    dart_error_out = receiver;
    goto error_native;
  }
  if (!_gdart_bridge_context_ensure_loaded_object_info_class(self, &dart_inner_error, &inner_error)) {
    dart_error_out = dart_inner_error;
    g_clear_error(&inner_error);
    goto error;
  }
  expected_type = gdart_bridge_context_get_object_info_class(self);
  if (G_UNLIKELY(Dart_IsError(expected_type))) {
    dart_error_out = expected_type;
    goto error_native;
  }
  temp_result = Dart_ObjectIsType(receiver, expected_type, &is_of_type);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }
  symbol_name = Dart_GetNativeArgument(arguments, 1);
  if (G_UNLIKELY(Dart_IsError(symbol_name))) {
    dart_error_out = symbol_name;
    goto error_native;
  }
  if (!Dart_IsString(symbol_name)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 3 arguments, the receiver, the method name, and a list of arguments", G_STRFUNC);
    goto error;
  }
  temp_result = Dart_StringToUTF8(symbol_name, (uint8_t **) &symbol_name_str, &symbol_name_length);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }
  symbol_name_str_out = g_newa(gchar, symbol_name_length + 1);
  memmove(symbol_name_str_out, symbol_name_str, symbol_name_length);
  symbol_name_str_out[symbol_name_length] = '\0';


  this_argument = Dart_GetNativeArgument(arguments, 2);
  if (G_UNLIKELY(Dart_IsError(this_argument))) {
    dart_error_out = this_argument;
    goto error_native;
  }

  result_base_info = gdart_bridge_context_unwrap_object_info(self, receiver, &dart_inner_error, &inner_error);
  if (result_base_info == NULL) {
    dart_error_out = dart_inner_error;
    goto error_native;
  }
  switch (g_base_info_get_type(result_base_info)) {
  case GI_INFO_TYPE_OBJECT:
    function_info = g_object_info_find_method((GIObjectInfo*) result_base_info,
                    symbol_name_str_out);
    break;
  case GI_INFO_TYPE_STRUCT:
    function_info = g_struct_info_find_method((GIStructInfo*) result_base_info,
                    symbol_name_str_out);
    break;
  case GI_INFO_TYPE_UNION:
    function_info = g_union_info_find_method((GIUnionInfo *) result_base_info,
                    symbol_name_str_out);
    break;
  case GI_INFO_TYPE_INTERFACE:
    function_info = g_interface_info_find_method((GIInterfaceInfo*) result_base_info,
                    symbol_name_str_out);
    break;
  default:
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: was called on an unexpected type", G_STRFUNC);
    goto error;
  }
  if (function_info == NULL) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: did not find an function info with the specified name", G_STRFUNC);
    goto error;
  }
  function_flags = g_function_info_get_flags(function_info);
  if (!(function_flags & GI_FUNCTION_IS_METHOD)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: found a static function and not a method", G_STRFUNC);
    goto error;
  }
  args_list = Dart_GetNativeArgument(arguments, 3);
  if (G_UNLIKELY(Dart_IsError(args_list))) {
    g_base_info_unref((GIBaseInfo*) function_info);
    dart_error_out = args_list;
    goto error_native;
  }
  if (!Dart_IsList(args_list)) {
    g_base_info_unref((GIBaseInfo*) function_info);
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: the arguments argument was not a list", G_STRFUNC);
    goto error;
  }
  error_prefix = g_strdup_printf("%s.%s.%s",
                                 g_base_info_get_namespace(result_base_info),
                                 g_base_info_get_name(result_base_info),
                                 symbol_name_str_out);
  if (!_gdart_bridge_context_invoke_method(self,
      error_prefix,
      function_info,
      this_argument,
      (GIRegisteredTypeInfo*) result_base_info,
      g_registered_type_info_get_g_type((GIRegisteredTypeInfo*) result_base_info),
      args_list,
      &final_result,
      &dart_inner_error,
      &inner_error)) {

    g_base_info_unref((GIBaseInfo*) function_info);
    g_clear_error(&inner_error);
    g_free(error_prefix);
    dart_error_out = dart_inner_error;
    goto error;
  }
  g_free(error_prefix);
  g_base_info_unref((GIBaseInfo*) function_info);
  Dart_SetReturnValue(arguments, final_result);
  Dart_ExitScope();
  return;
error:
  dart_error_out = Dart_ThrowException(dart_error_out);
error_native:
  Dart_PropagateError(dart_error_out);
}

void gdart_bridge_context_object_info_get_g_property_on_receiver(
  Dart_NativeArguments arguments)
{
  Dart_EnterScope();
  GdartBridgeContext* self;
  gintptr argument_count, symbol_name_length;
  Dart_Handle dart_error_out, receiver, expected_type, symbol_name, temp_result,
              dart_inner_error, final_result, this_argument;
  gchar *symbol_name_str,
        *symbol_name_str_out,
        *error_prefix;
  bool is_of_type;
  GIRegisteredTypeInfo* result_base_info;
  GError* inner_error = NULL;

  self = gdart_bridge_context_new_from_isolate(Dart_CurrentIsolate());
  argument_count = Dart_GetNativeArgumentCount(arguments);
  if (argument_count < 3) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 3 arguments, the original receiver, the property name, the target receiver", G_STRFUNC);
    goto error;
  }
  receiver = Dart_GetNativeArgument(arguments, 0);
  if (G_UNLIKELY(Dart_IsError(receiver))) {
    dart_error_out = receiver;
    goto error_native;
  }
  if (!_gdart_bridge_context_ensure_loaded_object_info_class(self, &dart_inner_error, &inner_error)) {
    dart_error_out = dart_inner_error;
    g_clear_error(&inner_error);
    goto error;
  }
  expected_type = gdart_bridge_context_get_object_info_class(self);
  if (G_UNLIKELY(Dart_IsError(expected_type))) {
    dart_error_out = expected_type;
    goto error_native;
  }
  temp_result = Dart_ObjectIsType(receiver, expected_type, &is_of_type);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }
  symbol_name = Dart_GetNativeArgument(arguments, 1);
  if (G_UNLIKELY(Dart_IsError(symbol_name))) {
    dart_error_out = symbol_name;
    goto error_native;
  }
  if (!Dart_IsString(symbol_name)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 3 arguments, the original receiver, the property name, the target receiver", G_STRFUNC);
    goto error;
  }
  temp_result = Dart_StringToUTF8(symbol_name, (uint8_t **) &symbol_name_str, &symbol_name_length);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }
  symbol_name_str_out = g_newa(gchar, symbol_name_length + 1);
  memmove(symbol_name_str_out, symbol_name_str, symbol_name_length);
  symbol_name_str_out[symbol_name_length] = '\0';


  this_argument = Dart_GetNativeArgument(arguments, 2);
  if (G_UNLIKELY(Dart_IsError(this_argument))) {
    dart_error_out = this_argument;
    goto error_native;
  }

  result_base_info = gdart_bridge_context_unwrap_object_info(self, receiver, &dart_inner_error, &inner_error);
  if (result_base_info == NULL) {
    dart_error_out = dart_inner_error;
    goto error_native;
  }
  switch (g_base_info_get_type(result_base_info)) {
  case GI_INFO_TYPE_OBJECT:
    break;
  default:
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: was called on an unexpected type", G_STRFUNC);
    goto error;
  }
  error_prefix = g_strdup_printf("%s.%s.%s",
                                 g_base_info_get_namespace(result_base_info),
                                 g_base_info_get_name(result_base_info),
                                 symbol_name_str_out);
  if (!gdart_g_property_get_property(self,
      error_prefix,
      symbol_name_str_out,
      (GIObjectInfo*) result_base_info,
      this_argument,
      &final_result,
      &dart_inner_error,
      &inner_error)) {

    g_clear_error(&inner_error);
    g_free(error_prefix);
    dart_error_out = dart_inner_error;
    goto error;
  }
  g_free(error_prefix);
  Dart_SetReturnValue(arguments, final_result);
  Dart_ExitScope();
  return;
error:
  dart_error_out = Dart_ThrowException(dart_error_out);
error_native:
  Dart_PropagateError(dart_error_out);
}

void gdart_bridge_context_object_info_set_g_property_on_receiver(
  Dart_NativeArguments arguments)
{
  Dart_EnterScope();
  GdartBridgeContext* self;
  gintptr argument_count, symbol_name_length;
  Dart_Handle dart_error_out, receiver, expected_type, symbol_name, temp_result,
              dart_inner_error, value_argument, this_argument;
  gchar *symbol_name_str,
        *symbol_name_str_out,
        *error_prefix;
  bool is_of_type;
  GIRegisteredTypeInfo* result_base_info;
  GError* inner_error = NULL;

  self = gdart_bridge_context_new_from_isolate(Dart_CurrentIsolate());
  argument_count = Dart_GetNativeArgumentCount(arguments);
  if (argument_count < 4) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 4 arguments, the original receiver, the property name, the target receiver, and the new property value", G_STRFUNC);
    goto error;
  }
  receiver = Dart_GetNativeArgument(arguments, 0);
  if (G_UNLIKELY(Dart_IsError(receiver))) {
    dart_error_out = receiver;
    goto error_native;
  }
  if (!_gdart_bridge_context_ensure_loaded_object_info_class(self, &dart_inner_error, &inner_error)) {
    dart_error_out = dart_inner_error;
    g_clear_error(&inner_error);
    goto error;
  }
  expected_type = gdart_bridge_context_get_object_info_class(self);
  if (G_UNLIKELY(Dart_IsError(expected_type))) {
    dart_error_out = expected_type;
    goto error_native;
  }
  temp_result = Dart_ObjectIsType(receiver, expected_type, &is_of_type);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }
  symbol_name = Dart_GetNativeArgument(arguments, 1);
  if (G_UNLIKELY(Dart_IsError(symbol_name))) {
    dart_error_out = symbol_name;
    goto error_native;
  }
  if (!Dart_IsString(symbol_name)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 3 arguments, the original receiver, the property name, the target receiver, and the new property value", G_STRFUNC);
    goto error;
  }
  temp_result = Dart_StringToUTF8(symbol_name, (uint8_t **) &symbol_name_str, &symbol_name_length);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }
  symbol_name_str_out = g_newa(gchar, symbol_name_length + 1);
  memmove(symbol_name_str_out, symbol_name_str, symbol_name_length);
  symbol_name_str_out[symbol_name_length] = '\0';


  this_argument = Dart_GetNativeArgument(arguments, 2);
  if (G_UNLIKELY(Dart_IsError(this_argument))) {
    dart_error_out = this_argument;
    goto error_native;
  }

  result_base_info = gdart_bridge_context_unwrap_object_info(self, receiver, &dart_inner_error, &inner_error);
  if (result_base_info == NULL) {
    dart_error_out = dart_inner_error;
    goto error_native;
  }
  switch (g_base_info_get_type(result_base_info)) {
  case GI_INFO_TYPE_OBJECT:
    break;
  default:
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: was called on an unexpected type", G_STRFUNC);
    goto error;
  }
  error_prefix = g_strdup_printf("%s.%s.%s",
                                 g_base_info_get_namespace(result_base_info),
                                 g_base_info_get_name(result_base_info),
                                 symbol_name_str_out);

  value_argument = Dart_GetNativeArgument(arguments, 3);
  if (G_UNLIKELY(Dart_IsError(value_argument))) {
    dart_error_out = value_argument;
    goto error_native;
  }
  if (!gdart_g_property_set_property(self,
      error_prefix,
      symbol_name_str_out,
      (GIObjectInfo*) result_base_info,
      this_argument,
      value_argument,
      &dart_inner_error,
      &inner_error)) {

    g_clear_error(&inner_error);
    g_free(error_prefix);
    dart_error_out = dart_inner_error;
    goto error;
  }
  g_free(error_prefix);
  Dart_ExitScope();
  return;
error:
  dart_error_out = Dart_ThrowException(dart_error_out);
error_native:
  Dart_PropagateError(dart_error_out);
}

void gdart_bridge_context_object_call_method(
  Dart_NativeArguments arguments)
{
  Dart_EnterScope();
  GdartBridgeContext* self;
  gintptr argument_count, symbol_name_length;
  Dart_Handle dart_error_out, receiver, expected_type, symbol_name, temp_result,
              dart_inner_error, args_list, final_result;
  gchar *symbol_name_str,
        *symbol_name_str_out,
        *error_handling_name,
        *class_name;
  bool is_of_type;
  GdartBridgeContextWrappedObject* result_object;
  GIRegisteredTypeInfo* result_base_info;
  GType gtype;
  GIFunctionInfo* function_info;
  GError* inner_error = NULL;
  GIFunctionInfoFlags function_flags;

  self = gdart_bridge_context_new_from_isolate(Dart_CurrentIsolate());
  argument_count = Dart_GetNativeArgumentCount(arguments);
  if (argument_count < 3) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 3 arguments, the receiver, the method name, and a list of arguments", G_STRFUNC);
    goto error;
  }
  receiver = Dart_GetNativeArgument(arguments, 0);
  if (G_UNLIKELY(Dart_IsError(receiver))) {
    dart_error_out = receiver;
    goto error_native;
  }
  if (!_gdart_bridge_context_ensure_loaded_base_object_class(self, &dart_inner_error, &inner_error)) {
    dart_error_out = dart_inner_error;
    g_clear_error(&inner_error);
    goto error;
  }
  expected_type = Dart_HandleFromPersistent(self->gdart_base_object_class);
  if (G_UNLIKELY(Dart_IsError(expected_type))) {
    dart_error_out = expected_type;
    goto error_native;
  }
  temp_result = Dart_ObjectIsType(receiver, expected_type, &is_of_type);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }
  symbol_name = Dart_GetNativeArgument(arguments, 1);
  if (G_UNLIKELY(Dart_IsError(symbol_name))) {
    dart_error_out = symbol_name;
    goto error_native;
  }
  if (!Dart_IsString(symbol_name)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 3 arguments, the receiver, the method name, and a list of arguments", G_STRFUNC);
    goto error;
  }
  temp_result = Dart_StringToUTF8(symbol_name, (uint8_t **) &symbol_name_str, &symbol_name_length);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }
  symbol_name_str_out = g_newa(gchar, symbol_name_length + 1);
  memmove(symbol_name_str_out, symbol_name_str, symbol_name_length);
  symbol_name_str_out[symbol_name_length] = '\0';

  result_object = gdart_bridge_context_unwrap_object(self, receiver, &dart_inner_error, &inner_error);
  if (result_object == NULL) {
    dart_error_out = dart_inner_error;
    goto error_native;
  }
  result_base_info = result_object->object_info;
  gtype = result_object->type;
  switch (g_base_info_get_type((GIBaseInfo*) result_base_info)) {
  case GI_INFO_TYPE_OBJECT: {
    GIObjectInfo *current_object_info, *previous_object_info,
                 *implementor;
    current_object_info = (GIObjectInfo*) g_base_info_ref(result_base_info);
    while (current_object_info != NULL) {
      function_info = g_object_info_find_method_using_interfaces(
                        current_object_info,
                        symbol_name_str_out,
                        &implementor);
      if (function_info != NULL) break;
      previous_object_info = current_object_info;
      current_object_info = g_object_info_get_parent(previous_object_info);
      g_base_info_unref((GIBaseInfo*) previous_object_info);
    }
    if (current_object_info != NULL) {
      g_base_info_unref((GIBaseInfo*) current_object_info);
      class_name = g_strdup_printf("%s.%s",
                                   g_base_info_get_namespace((GIBaseInfo*) current_object_info),
                                   g_base_info_get_name((GIBaseInfo*) current_object_info));
    } else {
      class_name = g_strdup_printf("[unknown ancestor of %s.%s with method %s]",
                                   g_base_info_get_namespace(result_base_info),
                                   g_base_info_get_name(result_base_info),
                                   symbol_name_str_out);
    }
    break;
  }
  case GI_INFO_TYPE_BOXED:
  case GI_INFO_TYPE_STRUCT:
    function_info = g_struct_info_find_method(
                      (GIStructInfo*) result_base_info,
                      symbol_name_str_out);
    class_name = g_strdup_printf("%s.%s",
                                 g_base_info_get_namespace(result_base_info),
                                 g_base_info_get_name(result_base_info));
    break;
  case GI_INFO_TYPE_UNION:
    function_info = g_union_info_find_method(
                      (GIUnionInfo*) result_base_info,
                      symbol_name_str_out);
    class_name = g_strdup_printf("%s.%s",
                                 g_base_info_get_namespace(result_base_info),
                                 g_base_info_get_name(result_base_info));
    break;
  default:
    function_info = NULL;
    class_name = g_strdup_printf("%s.%s",
                                 g_base_info_get_namespace(result_base_info),
                                 g_base_info_get_name(result_base_info));
  }
  if (function_info == NULL) {
    error_handling_name = g_strdup_printf("%s.???", class_name);
    g_free(class_name);
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: did not find an function info with the specified name", G_STRFUNC);
    g_free(error_handling_name);
    goto error;
  } else {
    error_handling_name = g_strdup_printf("%s.%s",
                                          class_name,
                                          g_base_info_get_name((GIBaseInfo*) function_info));
    g_free(class_name);
  }
  function_flags = g_function_info_get_flags(function_info);
  if (!(function_flags & GI_FUNCTION_IS_METHOD)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: found a static function and not a method", G_STRFUNC);
    g_free(error_handling_name);
    goto error;
  }
  args_list = Dart_GetNativeArgument(arguments, 2);
  if (G_UNLIKELY(Dart_IsError(args_list))) {
    g_base_info_unref((GIBaseInfo*) function_info);
    dart_error_out = args_list;
    g_free(error_handling_name);
    goto error_native;
  }
  if (!Dart_IsList(args_list)) {
    g_base_info_unref((GIBaseInfo*) function_info);
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: the arguments argument was not a list", G_STRFUNC);
    g_free(error_handling_name);
    goto error;
  }
  if (!_gdart_bridge_context_invoke_method(self,
      error_handling_name,
      function_info,
      receiver,
      (GIRegisteredTypeInfo*) result_base_info,
      gtype,
      args_list,
      &final_result,
      &dart_inner_error,
      &inner_error)) {

    g_base_info_unref((GIBaseInfo*) function_info);
    g_clear_error(&inner_error);
    dart_error_out = dart_inner_error;
    goto error;
  }

  g_base_info_unref((GIBaseInfo*) function_info);
  Dart_SetReturnValue(arguments, final_result);
  Dart_ExitScope();
  return;
error:
  dart_error_out = Dart_ThrowException(dart_error_out);
error_native:
  Dart_PropagateError(dart_error_out);
}

void gdart_bridge_context_object_signal_connect(
  Dart_NativeArguments arguments)
{
  Dart_EnterScope();
  GdartBridgeContext* self;
  gintptr argument_count, symbol_name_length;
  Dart_Handle dart_error_out, receiver, expected_type, symbol_name, temp_result,
              dart_inner_error, callback, final_result, after;
  gchar *symbol_name_str,
        *symbol_name_str_out;
  bool is_of_type, after_bool;
  GdartBridgeContextWrappedObject* result_object;
  GIRegisteredTypeInfo* result_base_info;
  GError* inner_error = NULL;

  self = gdart_bridge_context_new_from_isolate(Dart_CurrentIsolate());
  argument_count = Dart_GetNativeArgumentCount(arguments);
  if (argument_count < 4) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 3 arguments, the receiver, the method name, and a list of arguments", G_STRFUNC);
    goto error;
  }
  receiver = Dart_GetNativeArgument(arguments, 0);
  if (G_UNLIKELY(Dart_IsError(receiver))) {
    dart_error_out = receiver;
    goto error_native;
  }
  if (!_gdart_bridge_context_ensure_loaded_base_object_class(self, &dart_inner_error, &inner_error)) {
    dart_error_out = dart_inner_error;
    g_clear_error(&inner_error);
    goto error;
  }
  expected_type = Dart_HandleFromPersistent(self->gdart_base_object_class);
  if (G_UNLIKELY(Dart_IsError(expected_type))) {
    dart_error_out = expected_type;
    goto error_native;
  }
  temp_result = Dart_ObjectIsType(receiver, expected_type, &is_of_type);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }
  symbol_name = Dart_GetNativeArgument(arguments, 1);
  if (G_UNLIKELY(Dart_IsError(symbol_name))) {
    dart_error_out = symbol_name;
    goto error_native;
  }
  if (!Dart_IsString(symbol_name)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 3 arguments, the receiver, the method name, and a list of arguments", G_STRFUNC);
    goto error;
  }
  temp_result = Dart_StringToUTF8(symbol_name, (uint8_t **) &symbol_name_str, &symbol_name_length);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }
  symbol_name_str_out = g_newa(gchar, symbol_name_length + 1);
  memmove(symbol_name_str_out, symbol_name_str, symbol_name_length);
  symbol_name_str_out[symbol_name_length] = '\0';

  result_object = gdart_bridge_context_unwrap_object(self, receiver, &dart_inner_error, &inner_error);
  if (result_object == NULL) {
    dart_error_out = dart_inner_error;
    goto error_native;
  }
  result_base_info = result_object->object_info;
  if (g_base_info_get_type((GIBaseInfo*) result_base_info) != GI_INFO_TYPE_OBJECT) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: did not find an function info with the specified name", G_STRFUNC);
    goto error;
  }
  callback = Dart_GetNativeArgument(arguments, 2);
  if (G_UNLIKELY(Dart_IsError(callback))) {
    dart_error_out = callback;
    goto error_native;
  }
  if (!Dart_IsClosure(callback) && !Dart_IsFunction(callback)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: the arguments argument was not a list", G_STRFUNC);
    goto error;
  }
  after = Dart_GetNativeArgument(arguments, 3);
  if (G_UNLIKELY(Dart_IsError(after))) {
    dart_error_out = after;
    goto error_native;
  }
  temp_result = Dart_BooleanValue(after, &after_bool);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }

  if (!gdart_signal_connect_data(self,
                                 symbol_name_str_out,
                                 (GObject*) result_object->object,
                                 result_base_info,
                                 callback,
                                 after_bool,
                                 &final_result,
                                 &dart_inner_error,
                                 &inner_error)) {
    g_clear_error(&inner_error);
    dart_error_out = dart_inner_error;
    goto error;
  }

  Dart_SetReturnValue(arguments, final_result);
  Dart_ExitScope();
  return;
error:
  dart_error_out = Dart_ThrowException(dart_error_out);
error_native:
  Dart_PropagateError(dart_error_out);
}

void gdart_bridge_context_object_signal_disconnect(
  Dart_NativeArguments arguments)
{
  Dart_EnterScope();
  GdartBridgeContext* self;
  gintptr argument_count;
  Dart_Handle dart_error_out, receiver, expected_type, connection_id, temp_result,
              dart_inner_error;
  gint64 connection_id_int;
  bool is_of_type;
  GdartBridgeContextWrappedObject* result_object;
  GError* inner_error = NULL;

  self = gdart_bridge_context_new_from_isolate(Dart_CurrentIsolate());
  argument_count = Dart_GetNativeArgumentCount(arguments);
  if (argument_count < 2) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 2 arguments, the receiver, and a connection_id", G_STRFUNC);
    goto error;
  }
  receiver = Dart_GetNativeArgument(arguments, 0);
  if (G_UNLIKELY(Dart_IsError(receiver))) {
    dart_error_out = receiver;
    goto error_native;
  }
  if (!_gdart_bridge_context_ensure_loaded_base_object_class(self, &dart_inner_error, &inner_error)) {
    dart_error_out = dart_inner_error;
    g_clear_error(&inner_error);
    goto error;
  }
  expected_type = Dart_HandleFromPersistent(self->gdart_base_object_class);
  if (G_UNLIKELY(Dart_IsError(expected_type))) {
    dart_error_out = expected_type;
    goto error_native;
  }
  temp_result = Dart_ObjectIsType(receiver, expected_type, &is_of_type);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }
  connection_id = Dart_GetNativeArgument(arguments, 1);
  if (G_UNLIKELY(Dart_IsError(connection_id))) {
    dart_error_out = connection_id;
    goto error_native;
  }
  if (!Dart_IsInteger(connection_id)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 2 arguments, the receiver, and a connection_id", G_STRFUNC);
    goto error;
  }
  temp_result = Dart_IntegerToInt64(connection_id, &connection_id_int);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }
  result_object = gdart_bridge_context_unwrap_object(self, receiver, &dart_inner_error, &inner_error);
  if (result_object == NULL) {
    dart_error_out = dart_inner_error;
    goto error_native;
  }
  g_signal_handler_disconnect(result_object->object, connection_id_int);
  Dart_ExitScope();
  return;
error:
  dart_error_out = Dart_ThrowException(dart_error_out);
error_native:
  Dart_PropagateError(dart_error_out);
}

void gdart_bridge_context_object_get_string_representation(
  Dart_NativeArguments arguments)
{
  Dart_EnterScope();
  GdartBridgeContext* self;
  gintptr argument_count, result_str_length;
  Dart_Handle dart_error_out, receiver, expected_type, temp_result,
              dart_inner_error, final_result;
  gchar *result_str;
  bool is_of_type;
  GdartBridgeContextWrappedObject* result_object;
  GError* inner_error = NULL;

  self = gdart_bridge_context_new_from_isolate(Dart_CurrentIsolate());
  argument_count = Dart_GetNativeArgumentCount(arguments);
  if (argument_count < 1) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 3 arguments, the receiver, the method name, and a list of arguments", G_STRFUNC);
    goto error;
  }
  receiver = Dart_GetNativeArgument(arguments, 0);
  if (G_UNLIKELY(Dart_IsError(receiver))) {
    dart_error_out = receiver;
    goto error_native;
  }
  if (!_gdart_bridge_context_ensure_loaded_object_info_class(self, &dart_inner_error, &inner_error)) {
    dart_error_out = dart_inner_error;
    g_clear_error(&inner_error);
    goto error;
  }
  expected_type = gdart_bridge_context_get_object_info_class(self);
  if (G_UNLIKELY(Dart_IsError(expected_type))) {
    dart_error_out = expected_type;
    goto error_native;
  }
  temp_result = Dart_ObjectIsType(receiver, expected_type, &is_of_type);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }
  result_object = gdart_bridge_context_unwrap_object(self, receiver, &dart_inner_error, &inner_error);
  if (result_object == NULL) {
    dart_error_out = dart_inner_error;
    goto error_native;
  }
  if (result_object->object_info != NULL) {
    result_str = g_strdup_printf("%s.%s %p",
                                 g_base_info_get_namespace((GIBaseInfo*) result_object->object_info),
                                 g_base_info_get_name((GIBaseInfo*) result_object->object_info),
                                 result_object->object);
  } else if (result_object->type == G_DART_COMPAT_LIST_TYPE) {
    result_str = g_strdup_printf("Base.List %p",
                                 result_object->object);
  } else if (result_object->type == G_DART_COMPAT_SLIST_TYPE) {
    result_str = g_strdup_printf("Base.SList %p",
                                 result_object->object);
  } else {
    result_str = g_strdup_printf("?.? %p",
                                 result_object->object);
  }
  result_str_length = g_utf8_strlen(result_str, -1);
  final_result = Dart_NewStringFromUTF8((uint8_t*) result_str, result_str_length);
  g_free(result_str);
  Dart_SetReturnValue(arguments, final_result);
  Dart_ExitScope();
  return;
error:
  dart_error_out = Dart_ThrowException(dart_error_out);
error_native:
  Dart_PropagateError(dart_error_out);
}

void gdart_bridge_context_call_static_global(
  Dart_NativeArguments arguments)
{
  Dart_EnterScope();
  GdartBridgeContext* self;
  gintptr argument_count, symbol_name_length, namespace_length;
  Dart_Handle dart_error_out, namespace, symbol_name, temp_result,
              dart_inner_error, args_list, final_result;
  gchar *symbol_name_str,
        *symbol_name_str_out,
        *namespace_str,
        *namespace_str_out,
        *error_string,
        *error_prefix;
  GIBaseInfo* function_info;
  GError* inner_error = NULL;
  GIFunctionInfoFlags function_flags;

  self = gdart_bridge_context_new_from_isolate(Dart_CurrentIsolate());
  argument_count = Dart_GetNativeArgumentCount(arguments);
  if (argument_count < 3) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 3 arguments, the namespace, the method name, and a list of arguments", G_STRFUNC);
    goto error;
  }
  namespace = Dart_GetNativeArgument(arguments, 0);
  if (G_UNLIKELY(Dart_IsError(namespace))) {
    dart_error_out = namespace;
    goto error_native;
  }
  if (!Dart_IsString(namespace)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 3 arguments, the receiver, the method name, and a list of arguments", G_STRFUNC);
    goto error;
  }
  temp_result = Dart_StringToUTF8(namespace, (uint8_t **) &namespace_str, &namespace_length);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }
  symbol_name = Dart_GetNativeArgument(arguments, 1);
  if (G_UNLIKELY(Dart_IsError(symbol_name))) {
    dart_error_out = symbol_name;
    goto error_native;
  }
  if (!Dart_IsString(symbol_name)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: takes 3 arguments, the receiver, the method name, and a list of arguments", G_STRFUNC);
    goto error;
  }
  temp_result = Dart_StringToUTF8(symbol_name, (uint8_t **) &symbol_name_str, &symbol_name_length);
  if (G_UNLIKELY(Dart_IsError(temp_result))) {
    dart_error_out = temp_result;
    goto error_native;
  }
  symbol_name_str_out = g_newa(gchar, symbol_name_length + 1);
  memmove(symbol_name_str_out, symbol_name_str, symbol_name_length);
  symbol_name_str_out[symbol_name_length] = '\0';
  namespace_str_out = g_newa(gchar, namespace_length + 1);
  memmove(namespace_str_out, namespace_str, namespace_length);
  namespace_str_out[namespace_length] = '\0';
  error_prefix = g_strdup_printf("%s.%s", namespace_str_out, symbol_name_str_out);

  if (g_irepository_require(self->gi_repository, namespace_str_out, NULL, 0,
                            &inner_error) == NULL) {
    error_string = g_strdup_printf("%s: caught an error %s", G_STRFUNC,
                                   inner_error->message);
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s",
                     error_string);
    g_free(error_string);
    g_free(error_prefix);
    g_clear_error(&inner_error);
    goto error;
  }

  function_info = g_irepository_find_by_name(self->gi_repository, namespace_str_out, symbol_name_str_out);
  if (function_info == NULL) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: did not find a function with the specified name", G_STRFUNC);
    g_free(error_prefix);
    goto error;
  }
  if (!GI_IS_FUNCTION_INFO(function_info)) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: found a symbol with the specified name, but it is not a function", G_STRFUNC);
    g_base_info_unref(function_info);
    g_free(error_prefix);
    goto error;
  }
  function_flags = g_function_info_get_flags((GIFunctionInfo*) function_info);
  if (function_flags & GI_FUNCTION_IS_METHOD) {
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: found a method and not a static function", G_STRFUNC);
    g_base_info_unref(function_info);
    g_free(error_prefix);
    goto error;
  }
  args_list = Dart_GetNativeArgument(arguments, 2);
  if (G_UNLIKELY(Dart_IsError(args_list))) {
    g_base_info_unref(function_info);
    g_free(error_prefix);
    dart_error_out = args_list;
    goto error_native;
  }
  if (!Dart_IsList(args_list)) {
    g_base_info_unref(function_info);
    g_free(error_prefix);
    dart_error_out = gdart_bridge_context_create_error_handle(self,
                     "%s: the arguments argument was not a list", G_STRFUNC);
    goto error;
  }
  if (!_gdart_bridge_context_invoke_static(self,
      error_prefix,
      (GIFunctionInfo*) function_info,
      args_list,
      &final_result,
      &dart_inner_error,
      &inner_error)) {

    g_base_info_unref(function_info);
    g_clear_error(&inner_error);
    dart_error_out = dart_inner_error;
    g_free(error_prefix);
    goto error;
  }

  g_base_info_unref(function_info);
  g_free(error_prefix);
  Dart_SetReturnValue(arguments, final_result);
  Dart_ExitScope();
  return;
error:
  dart_error_out = Dart_ThrowException(dart_error_out);
error_native:
  Dart_PropagateError(dart_error_out);
}

/*
void gdart_bridge_context_register_interceptor_type_for_named_type(Dart_NativeArguments arguments);
*/
