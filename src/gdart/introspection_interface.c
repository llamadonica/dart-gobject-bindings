// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
//

#include <dlfcn.h>

#include "array.h"
#include "function.h"
#include "common.h"
#include "object_wrapper.h"
#include "bridge_context.h"
#include "introspection_interface.h"
#include "include/dart_api.h"

//gint gi_count = 0;

typedef struct {
  ffi_closure ffi_closure;
  gint64 nargs;
  gpointer writable_self;
} DartClosureWrapper;

static void _gi_base_info_interface_info_free (gpointer object)
{
  /*
  if (g_base_info_get_type(object) != GI_INFO_TYPE_TYPE) {
    gchar *name = _gi_base_info_print_name(object);
    printf("Freeing %s. Ref count is now %i\n", name, --gi_count);
    g_free(name);
  } else {
    printf("Freeing (some anonymous type). Ref count is now %i\n", --gi_count);
  }
  */
  g_base_info_unref ( (GIBaseInfo *) object);
}

static void _dart_interface_info_free (gpointer object)
{
  Dart_DeletePersistentHandle ( (Dart_PersistentHandle) object);
}

static gboolean _gi_base_info_interface_info_get_name (gpointer object,
    GdartBridgeContext *self,
    gchar **result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  *result_out = g_strdup (g_base_info_get_name ( (GIBaseInfo *) object));
  return TRUE;
}

static gboolean _dart_interface_info_get_name (
  gpointer object,
  GdartBridgeContext *self,
  gchar **result_out,
  Dart_Handle *dart_error_out,
  GError **error)
{
  Dart_Handle dart_object, field_name, field_value, temp_value;
  gchar *string_raw, *string_trimmed;
  gintptr string_raw_length;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_name = Dart_NewStringFromCString ("name");
  if (Dart_IsError (field_name)) {
    *dart_error_out = field_name;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_value = Dart_GetField (dart_object, field_name);
  if (Dart_IsError (field_value)) {
    *dart_error_out = field_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  if (!Dart_IsString (field_value)) {
    gdart_bridge_context_create_error_handle (self,
        "%s: value was not a String", G_STRFUNC);
    g_set_error (error, GDART_ERROR, 1, "%s: value was not a String", 
G_STRFUNC);
  }
  temp_value = Dart_StringToUTF8 (field_value, (guint8**) &string_raw, 
				  &string_raw_length);
  if (Dart_IsError (temp_value)) {
    *dart_error_out = temp_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  string_trimmed = g_malloc (string_raw_length + 1);
  memmove (string_trimmed, string_raw, string_raw_length);
  string_trimmed[string_raw_length] = '\0';
  *result_out = string_trimmed;
  return TRUE;
}

static gpointer _gi_base_info_interface_info_copy (gpointer object)
{
  /*
  gchar *name = _gi_base_info_print_name(object);
  printf("Copying %s. Ref count is now %i\n", name, ++gi_count);
  g_free(name);
  */
  return (gpointer) g_base_info_ref ( (GIBaseInfo *) object);
}

static gpointer _dart_interface_info_copy (gpointer object)
{
  /*
  gchar *name = _gi_base_info_print_name(object);
  printf("Copying %s. Ref count is now %i\n", name, ++gi_count);
  g_free(name);
  */
  return Dart_NewPersistentHandle (Dart_HandleFromPersistent ( 
(Dart_PersistentHandle) object));
}

static gboolean _gi_base_info_interface_info_get_type (gpointer object,
    GdartBridgeContext *self,
    GIInfoType *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  *result_out = g_base_info_get_type ( (GIBaseInfo *) object);
  return TRUE;
}


static gboolean _dart_interface_info_get_type (gpointer object,
    GdartBridgeContext *self,
    GIInfoType *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dart_object, field_name, field_value, index_symbol, index_value, 
temp_value;
  gint64 raw_result;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_name = Dart_NewStringFromCString ("type");
  if (Dart_IsError (field_name)) {
    *dart_error_out = field_name;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_value = Dart_GetField (dart_object, field_name);
  if (Dart_IsError (field_value)) {
    *dart_error_out = field_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  index_symbol = Dart_NewStringFromCString ("index");
  if (Dart_IsError (index_symbol)) {
    *dart_error_out = index_symbol;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  index_value = Dart_GetField (field_value, index_symbol);
  if (Dart_IsError (index_value)) {
    *dart_error_out = index_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  temp_value = Dart_IntegerToInt64 (index_value, &raw_result);
  if (Dart_IsError (temp_value)) {
    *dart_error_out = temp_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  *result_out = raw_result;
  return TRUE;
}

const CallableInfoKlass 
*_gi_base_info_interface_info_cast_interface_to_callable_info (gpointer object)
{
  GIInfoType type;

  type = g_base_info_get_type ( (GIBaseInfo *) object);
  switch (type) {
  case GI_INFO_TYPE_CALLBACK:
  case GI_INFO_TYPE_FUNCTION:
  case GI_INFO_TYPE_VFUNC:
  case GI_INFO_TYPE_SIGNAL:
    return &gi_callable_info_callable_info;
  default:
    return &gi_base_info_callable_info;
  }
}

const CallableInfoKlass *_dart_interface_info_cast_interface_to_callable_info 
(gpointer object)
{
  return &dart_callable_info;
}

const EnumInfoKlass *_gi_base_info_interface_info_cast_interface_to_enum_info 
(gpointer object)
{
  GIInfoType type;

  type = g_base_info_get_type ( (GIBaseInfo *) object);
  switch (type) {
  case GI_INFO_TYPE_ENUM:
  case GI_INFO_TYPE_FLAGS:
    return &gi_enum_info_enum_info;
  default:
    return &gi_base_info_enum_info;
  }
}

const EnumInfoKlass *_dart_interface_info_cast_interface_to_enum_info (gpointer 
object)
{
  return &dart_enum_info;
}

const RegisteredTypeInfoKlass 
*_gi_base_info_interface_info_cast_interface_to_registered_type_info (gpointer 
object)
{
  GIInfoType type;

  type = g_base_info_get_type ( (GIBaseInfo *) object);
  switch (type) {
  case GI_INFO_TYPE_ENUM:
  case GI_INFO_TYPE_FLAGS:
  case GI_INFO_TYPE_INTERFACE:
  case GI_INFO_TYPE_OBJECT:
  case GI_INFO_TYPE_STRUCT:
  case GI_INFO_TYPE_UNION:
    return &gi_registered_type_info_registered_type_info;
  default:
    return &gi_base_info_registered_type_info;
  }
}

const RegisteredTypeInfoKlass 
*_dart_interface_info_cast_interface_to_registered_type_info (gpointer 
object)
{
  return &dart_registered_type_info;
}

static const FunctionInfoKlass *
_gi_base_info_interface_info_cast_interface_to_function_info (gpointer object)
{
  GIInfoType type;

  type = g_base_info_get_type ( (GIBaseInfo *) object);
  switch (type) {
  case GI_INFO_TYPE_FUNCTION:
    return &gi_function_info_function_info;
  case GI_INFO_TYPE_VFUNC:
  case GI_INFO_TYPE_SIGNAL:
  case GI_INFO_TYPE_CALLBACK:
    return &gi_callable_info_function_info;
  default:
    return &gi_base_info_function_info;
  }
  return NULL;
}

static const FunctionInfoKlass 
*_dart_interface_info_cast_interface_to_function_info (gpointer object)
{
  return &dart_function_info;
}


static const VFuncInfoKlass *
_gi_base_info_interface_info_cast_interface_to_v_func_info (gpointer object)
{
  GIInfoType type;

  type = g_base_info_get_type ( (GIBaseInfo *) object);
  switch (type) {
  case GI_INFO_TYPE_VFUNC:
    return &gi_v_func_info_v_func_info;
  case GI_INFO_TYPE_SIGNAL:
  case GI_INFO_TYPE_CALLBACK:
  case GI_INFO_TYPE_FUNCTION:
    return &gi_callable_info_v_func_info;
  default:
    return &gi_base_info_v_func_info;
  }
  return NULL;
}

static const VFuncInfoKlass *
_dart_interface_info_cast_interface_to_v_func_info (gpointer object)
{
  return &dart_v_func_info;
}

static const ObjectInfoKlass *
_gi_base_info_interface_info_cast_interface_to_object_info (gpointer object)
{
  GIInfoType type;

  type = g_base_info_get_type ( (GIBaseInfo *) object);
  switch (type) {
  case GI_INFO_TYPE_OBJECT:
    return &gi_object_info_object_info;
  case GI_INFO_TYPE_ENUM:
  case GI_INFO_TYPE_FLAGS:
  case GI_INFO_TYPE_INTERFACE:
  case GI_INFO_TYPE_STRUCT:
  case GI_INFO_TYPE_UNION:
    return &gi_registered_type_info_object_info;
  default:
    return &gi_base_info_object_info;
  }
}

static const ObjectInfoKlass *
_dart_interface_info_cast_interface_to_object_info (gpointer object)
{
  return &dart_object_info;
}

static const StructUnionInfoKlass *
_gi_base_info_interface_info_cast_interface_to_struct_union_info (gpointer 
object)
{
  GIInfoType type;

  type = g_base_info_get_type ( (GIBaseInfo *) object);
  switch (type) {
  case GI_INFO_TYPE_ENUM:
  case GI_INFO_TYPE_FLAGS:
  case GI_INFO_TYPE_INTERFACE:
  case GI_INFO_TYPE_OBJECT:
    return &gi_registered_type_info_struct_union_info;
  case GI_INFO_TYPE_STRUCT:
    return &gi_struct_info_struct_union_info;
  case GI_INFO_TYPE_UNION:
    return &gi_union_info_struct_union_info;
  default:
    return &gi_base_info_struct_union_info;
  }
  return NULL;
}

static const StructUnionInfoKlass *
_dart_interface_info_cast_interface_to_struct_union_info (gpointer object)
{
  return &dart_struct_union_info;
}

static gboolean _gi_base_info_interface_info_get_namespace (gpointer object,
    GdartBridgeContext *self,
    gchar **result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  *result_out = g_strdup (g_base_info_get_namespace ( (GIBaseInfo *) object));
  return TRUE;
}


static gboolean _dart_interface_info_get_namespace (
  gpointer object,
  GdartBridgeContext *self,
  gchar **result_out,
  Dart_Handle *dart_error_out,
  GError **error)
{
  Dart_Handle dart_object, field_name, field_value, temp_value;
  gchar *string_raw, *string_trimmed;
  gintptr string_raw_length;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_name = Dart_NewStringFromCString ("namespace");
  if (Dart_IsError (field_name)) {
    *dart_error_out = field_name;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_value = Dart_GetField (dart_object, field_name);
  if (Dart_IsError (field_value)) {
    *dart_error_out = field_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  if (!Dart_IsString (field_value)) {
    gdart_bridge_context_create_error_handle (self,
        "%s: value was not a String", G_STRFUNC);
    g_set_error (error, GDART_ERROR, 1, "%s: value was not a String", 
G_STRFUNC);
  }
  temp_value = Dart_StringToUTF8 (field_value, (guint8 **) &string_raw, 
&string_raw_length);
  if (Dart_IsError (temp_value)) {
    *dart_error_out = temp_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  string_trimmed = g_malloc (string_raw_length + 1);
  memmove (string_trimmed, string_raw, string_raw_length);
  string_trimmed[string_raw_length] = '\0';
  *result_out = string_trimmed;
  return TRUE;
}

static gboolean _null_no_such_method (gpointer object,
                                      GdartBridgeContext *self,
                                      const gchar *method_name,
                                      Dart_Handle *dart_error_out,
                                      GError **error)
{
  *dart_error_out = gdart_bridge_context_create_error_handle (
                      self,
                      "%s: no such method: %s", G_STRFUNC, method_name);
  g_set_error (error, GDART_ERROR, 1,
               "%s: no such method: %s", G_STRFUNC, method_name);
  return FALSE;
}

static void _null_interface_info_free (gpointer object)
{
}

static gpointer _null_interface_info_copy (gpointer object)
{
  return NULL;
}

static gboolean _null_interface_info_get_name (gpointer object,
    GdartBridgeContext *self,
    gchar **result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object, self, "get_name", dart_error_out, error);
}


static gboolean _null_interface_info_get_namespace (gpointer object,
    GdartBridgeContext *self,
    gchar **result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object, self, "get_namespace", dart_error_out, 
error);
}

static gboolean _null_interface_info_get_type (gpointer object,
    GdartBridgeContext *self,
    GIInfoType *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object, self, "get_name", dart_error_out, error);
}

const CallableInfoKlass *_null_interface_info_cast_interface_to_callable_info 
(gpointer object)
{
  return &null_callable_info;
}

const EnumInfoKlass *_null_interface_info_cast_interface_to_enum_info (gpointer 
object)
{
  return &null_enum_info;
}

const RegisteredTypeInfoKlass 
*_null_interface_info_cast_interface_to_registered_info (gpointer object)
{
  return &null_registered_type_info;
}


const StructUnionInfoKlass 
*_null_interface_info_cast_interface_to_struct_union_info (gpointer object)
{
  return &null_struct_union_info;
}


const FunctionInfoKlass *_null_interface_info_cast_interface_to_function_info 
(gpointer object)
{
  return &null_function_info;
}


const VFuncInfoKlass *_null_interface_info_cast_interface_to_v_func_info 
(gpointer object)
{
  return &null_v_func_info;
}


const ObjectInfoKlass *_null_interface_info_cast_interface_to_object_info 
(gpointer object)
{
  return &null_object_info;
}

static gboolean _gi_type_info_type_get_tag (gpointer object,
    GdartBridgeContext *self,
    GITypeTag *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  *result_out = g_type_info_get_tag ( (GITypeInfo *) object);
  return TRUE;
}

static gboolean _dart_type_get_tag (gpointer object,
                                    GdartBridgeContext *self,
                                    GITypeTag *result_out,
                                    Dart_Handle *dart_error_out,
                                    GError **error)
{
  Dart_Handle dart_object, field_name, field_value, index_symbol, index_value, 
temp_value;
  gint64 raw_result;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_name = Dart_NewStringFromCString ("tag");
  if (Dart_IsError (field_name)) {
    *dart_error_out = field_name;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_value = Dart_GetField (dart_object, field_name);
  if (Dart_IsError (field_value)) {
    *dart_error_out = field_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  index_symbol = Dart_NewStringFromCString ("index");
  if (Dart_IsError (index_symbol)) {
    *dart_error_out = index_symbol;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  index_value = Dart_GetField (field_value, index_symbol);
  if (Dart_IsError (index_value)) {
    *dart_error_out = index_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  temp_value = Dart_IntegerToInt64 (index_value, &raw_result);
  if (Dart_IsError (temp_value)) {
    *dart_error_out = temp_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  *result_out = raw_result;
  return TRUE;
}

static gboolean _gi_type_info_type_get_interface (gpointer object,
    GdartBridgeContext *self,
    gpointer *result_out,
    const InterfaceInfoKlass **result_klass_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  *result_out = g_type_info_get_interface ( (GITypeInfo *) object);
  /*
  gchar *name = _gi_base_info_print_name(*result_out);
  printf("Got %s from get interface. Ref count is now %i\n", name, ++gi_count);
  g_free(name);
  */
  if (*result_out == NULL) {
  } else {
    *result_klass_out = &gi_base_info_interface_info;
  }
  return TRUE;
}

static gboolean _dart_type_get_interface (gpointer object,
    GdartBridgeContext *self,
    gpointer *result_out,
    const InterfaceInfoKlass **result_klass_out,
    Dart_Handle *dart_error_out,
    GError **error)
{

  Dart_Handle dart_object, field_name, field_value, expected_type, temp_value;
  bool is_of_type;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  field_name = Dart_NewStringFromCString ("interface");
  if (Dart_IsError (field_name)) {
    *dart_error_out = field_name;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  field_value = Dart_GetField (dart_object, field_name);
  if (Dart_IsError (field_value)) {
    *dart_error_out = field_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  expected_type = gdart_bridge_context_get_object_info_class (self);
  if (Dart_IsError (expected_type)) {
    *dart_error_out = expected_type;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  temp_value = Dart_ObjectIsType (field_value, 
				  expected_type, 
				  &is_of_type);
  if (Dart_IsError (temp_value)) {
    *dart_error_out = temp_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  if (is_of_type) {
    GIRegisteredTypeInfo *result_base_info;

    result_base_info = gdart_bridge_context_unwrap_object_info (self,
                       field_value,
                       dart_error_out,
                       error);
    if (result_base_info == NULL) { return FALSE; }
    *result_out = g_base_info_ref(result_base_info);
    *result_klass_out = &gi_base_info_interface_info;
    return TRUE;
  }
  *result_out = Dart_NewPersistentHandle (field_value);
  *result_klass_out = &dart_interface_info;
  return TRUE;
}

static gboolean _gi_type_info_type_get_array_length (gpointer object,
    GdartBridgeContext *self,
    gint *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  *result_out = g_type_info_get_array_length ( (GITypeInfo *) object);
  return TRUE;
}

static gboolean _dart_type_get_array_length (gpointer object,
    GdartBridgeContext *self,
    gint *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dart_object, field_name, field_value, temp_value;
  gint64 raw_result;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_name = Dart_NewStringFromCString ("arrayLength");
  if (Dart_IsError (field_name)) {
    *dart_error_out = field_name;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_value = Dart_GetField (dart_object, field_name);
  if (Dart_IsError (field_value)) {
    *dart_error_out = field_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  temp_value = Dart_IntegerToInt64 (field_value, &raw_result);
  if (Dart_IsError (temp_value)) {
    *dart_error_out = temp_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  *result_out = raw_result;
  return TRUE;
}

static gboolean _gi_type_info_type_is_zero_terminated (gpointer object,
    GdartBridgeContext *self,
    gboolean *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  *result_out = g_type_info_is_zero_terminated ( (GITypeInfo *) object);
  return TRUE;
}

static gboolean _dart_type_is_zero_terminated (gpointer object,
    GdartBridgeContext *self,
    gboolean *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dart_object, field_name, field_value, temp_value;
  gboolean raw_result;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_name = Dart_NewStringFromCString ("isZeroTerminated");
  if (Dart_IsError (field_name)) {
    *dart_error_out = field_name;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_value = Dart_GetField (dart_object, field_name);
  if (Dart_IsError (field_value)) {
    *dart_error_out = field_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  temp_value = Dart_BooleanValue (field_value, (bool*) &raw_result);
  if (Dart_IsError (temp_value)) {
    *dart_error_out = temp_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  *result_out = raw_result;
  return TRUE;
}

static gboolean _gi_type_info_type_get_array_fixed_size (gpointer object,
    GdartBridgeContext *self,
    gint *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  *result_out = g_type_info_get_array_fixed_size ( (GITypeInfo *) object);
  return TRUE;
}

static gboolean _dart_type_get_array_fixed_size (gpointer object,
    GdartBridgeContext *self,
    gint *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dart_object, field_name, field_value, temp_value;
  gint64 raw_result;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_name = Dart_NewStringFromCString ("arrayFixedSize");
  if (Dart_IsError (field_name)) {
    *dart_error_out = field_name;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_value = Dart_GetField (dart_object, field_name);
  if (Dart_IsError (field_value)) {
    *dart_error_out = field_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  temp_value = Dart_IntegerToInt64 (field_value, &raw_result);
  if (Dart_IsError (temp_value)) {
    *dart_error_out = temp_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  *result_out = raw_result;
  return TRUE;
}

static gboolean _gi_type_info_type_get_param_type (gpointer object,
    GdartBridgeContext *self,
    gint index,
    gpointer *result_out,
    const TypeInfoKlass **result_klass_out,
    Dart_Handle *dart_error,
    GError **error)
{
  *result_out = g_type_info_get_param_type ( (GITypeInfo *) object,
                index);
  /*
  printf("Got (anonymous type) from get param type. Ref count is now %i\n", 
++gi_count);
  */
  if (*result_out == NULL) {
  } else {
    *result_klass_out = &gi_type_info_type_info;
  }
  return TRUE;
}

static gboolean _dart_type_get_param_type (gpointer object,
    GdartBridgeContext *self,
    gint index,
    gpointer *result_out,
    const TypeInfoKlass **result_klass_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dart_object, function_name, field_value, index_storage;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  function_name = Dart_NewStringFromCString ("getParamType");
  if (Dart_IsError (function_name)) {
    *dart_error_out = function_name;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  index_storage = Dart_NewInteger (index);
  if (Dart_IsError (index_storage)) {
    *dart_error_out = index_storage;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  field_value = Dart_Invoke (dart_object, function_name, 1, &index_storage);
  if (Dart_IsError (field_value)) {
    *dart_error_out = field_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  *result_out = Dart_NewPersistentHandle (field_value);
  *result_klass_out = &dart_type_info;
  return TRUE;
}


static gboolean _null_type_get_tag (gpointer object,
                                    GdartBridgeContext *self,
                                    GITypeTag *result_out,
                                    Dart_Handle *dart_error_out,
                                    GError **error)
{
  return _null_no_such_method (object, self, "get_tag", dart_error_out, error);
}

static gboolean _null_type_get_interface (gpointer object,
    GdartBridgeContext *self,
    gpointer *result_out,
    const InterfaceInfoKlass **result_klass_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object,
                               self,
                               "get_interface",
                               dart_error_out,
                               error);
}

static gboolean _null_type_get_array_length (gpointer object,
    GdartBridgeContext *self,
    gint *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object,
                               self,
                               "get_array_length",
                               dart_error_out,
                               error);
}

static gboolean _null_type_is_zero_terminated (gpointer object,
    GdartBridgeContext *self,
    gboolean *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object,
                               self,
                               "is_zero_terminated",
                               dart_error_out,
                               error);
}


static gboolean _null_type_get_array_fixed_size (gpointer object,
    GdartBridgeContext *self,
    gint *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object,
                               self,
                               "get_array_fixed_size",
                               dart_error_out,
                               error);
}

static gboolean _null_type_get_param_type (gpointer object,
    GdartBridgeContext *self,
    gint index,
    gpointer *result_out,
    const TypeInfoKlass **result_klass_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object,
                               self,
                               "get_param_type",
                               dart_error_out,
                               error);
}


static gboolean _gi_arg_info_arg_info_get_closure (gpointer object,
    GdartBridgeContext *self,
    gint *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  *result_out = g_arg_info_get_closure ( (GIArgInfo *) object);
  return TRUE;
}

static gboolean _dart_arg_info_get_closure (gpointer object,
    GdartBridgeContext *self,
    gint *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dart_object, field_name, field_value, temp_value;
  gint64 raw_result;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_name = Dart_NewStringFromCString ("closure");
  if (Dart_IsError (field_name)) {
    *dart_error_out = field_name;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_value = Dart_GetField (dart_object, field_name);
  if (Dart_IsError (field_value)) {
    *dart_error_out = field_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  temp_value = Dart_IntegerToInt64 (field_value, &raw_result);
  if (Dart_IsError (temp_value)) {
    *dart_error_out = temp_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  *result_out = raw_result;
  return TRUE;
}

static gboolean _gi_arg_info_arg_info_get_destroy (gpointer object,
    GdartBridgeContext *self,
    gint *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  *result_out = g_arg_info_get_destroy ( (GIArgInfo *) object);
  return TRUE;
}


static gboolean _dart_arg_info_get_destroy (gpointer object,
    GdartBridgeContext *self,
    gint *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dart_object, field_name, field_value, temp_value;
  gint64 raw_result;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_name = Dart_NewStringFromCString ("destroy");
  if (Dart_IsError (field_name)) {
    *dart_error_out = field_name;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_value = Dart_GetField (dart_object, field_name);
  if (Dart_IsError (field_value)) {
    *dart_error_out = field_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  temp_value = Dart_IntegerToInt64 (field_value, &raw_result);
  if (Dart_IsError (temp_value)) {
    *dart_error_out = temp_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  *result_out = raw_result;
  return TRUE;
}

static gboolean _gi_arg_info_arg_info_get_direction (gpointer object,
    GdartBridgeContext *self,
    GIDirection *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  *result_out = g_arg_info_get_direction ( (GIArgInfo *) object);
  return TRUE;
}

static gboolean _dart_arg_info_get_direction (gpointer object,
    GdartBridgeContext *self,
    GIDirection *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dart_object, field_name, field_value, index_symbol, index_value,
              temp_value;
  gint64 raw_result;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_name = Dart_NewStringFromCString ("direction");
  if (Dart_IsError (field_name)) {
    *dart_error_out = field_name;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_value = Dart_GetField (dart_object, field_name);
  if (Dart_IsError (field_value)) {
    *dart_error_out = field_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  index_symbol = Dart_NewStringFromCString ("index");
  if (Dart_IsError (index_symbol)) {
    *dart_error_out = index_symbol;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  index_value = Dart_GetField (field_value, index_symbol);
  if (Dart_IsError (index_value)) {
    *dart_error_out = index_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  temp_value = Dart_IntegerToInt64 (index_value, &raw_result);
  if (Dart_IsError (temp_value)) {
    *dart_error_out = temp_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  *result_out = raw_result;
  return TRUE;
}

static gboolean _gi_arg_info_arg_info_get_scope (gpointer object,
    GdartBridgeContext *self,
    GIScopeType *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  *result_out = g_arg_info_get_scope ( (GIArgInfo *) object);
  return TRUE;
}

static gboolean _dart_arg_info_get_scope (gpointer object,
    GdartBridgeContext *self,
    GIScopeType *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dart_object, field_name, field_value, index_symbol, index_value,
              temp_value;
  gint64 raw_result;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_name = Dart_NewStringFromCString ("scope");
  if (Dart_IsError (field_name)) {
    *dart_error_out = field_name;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_value = Dart_GetField (dart_object, field_name);
  if (Dart_IsError (field_value)) {
    *dart_error_out = field_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  index_symbol = Dart_NewStringFromCString ("index");
  if (Dart_IsError (index_symbol)) {
    *dart_error_out = index_symbol;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  index_value = Dart_GetField (field_value, index_symbol);
  if (Dart_IsError (index_value)) {
    *dart_error_out = index_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  temp_value = Dart_IntegerToInt64 (index_value, &raw_result);
  if (Dart_IsError (temp_value)) {
    *dart_error_out = temp_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  *result_out = raw_result;
  return TRUE;
}

static gboolean _gi_arg_info_arg_info_get_type (gpointer object,
    GdartBridgeContext *self,
    gpointer *result_out,
    const TypeInfoKlass **result_klass_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  *result_out = (gpointer) g_arg_info_get_type ( (GIArgInfo *) object);
  *result_klass_out = &gi_type_info_type_info;
  return TRUE;
}

static gboolean _dart_arg_info_get_type (gpointer object,
    GdartBridgeContext *self,
    gpointer *result_out,
    const TypeInfoKlass **result_klass_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dart_object, function_name, field_value;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  function_name = Dart_NewStringFromCString ("argType");
  if (Dart_IsError (function_name)) {
    *dart_error_out = function_name;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  field_value = Dart_GetField (dart_object, function_name);
  if (Dart_IsError (field_value)) {
    *dart_error_out = field_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  *result_out = Dart_NewPersistentHandle (field_value);
  *result_klass_out = &dart_type_info;
  return TRUE;
}

static gboolean _null_arg_info_get_closure (gpointer object,
    GdartBridgeContext *self,
    gint *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object,
                               self,
                               "get_closure",
                               dart_error_out,
                               error);
}

static gboolean _null_arg_info_get_destroy (gpointer object,
    GdartBridgeContext *self,
    gint *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object,
                               self,
                               "get_destroy",
                               dart_error_out,
                               error);
}


static gboolean _null_arg_info_get_direction (gpointer object,
    GdartBridgeContext *self,
    GIDirection *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object,
                               self,
                               "get_direction",
                               dart_error_out,
                               error);
}


static gboolean _null_arg_info_get_ownership_transfer (gpointer object,
    GdartBridgeContext *self,
    GITransfer *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object,
                               self,
                               "get_ownership_transfer",
                               dart_error_out,
                               error);
}


static gboolean _null_arg_info_get_scope (gpointer object,
    GdartBridgeContext *self,
    GIScopeType *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object,
                               self,
                               "get_scope",
                               dart_error_out,
                               error);
}

static gboolean _null_arg_info_get_type (gpointer object,
    GdartBridgeContext *self,
    gpointer *result_out,
    const TypeInfoKlass **result_klass_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object,
                               self,
                               "get_type",
                               dart_error_out,
                               error);
}

static gboolean _gi_arg_info_arg_info_get_ownership_transfer (gpointer object,
    GdartBridgeContext *self,
    GITransfer *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  *result_out = g_arg_info_get_ownership_transfer ( (GIArgInfo *) object);
  return TRUE;
}

static gboolean _dart_arg_info_get_ownership_transfer (gpointer object,
    GdartBridgeContext *self,
    GITransfer *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dart_object, field_name, field_value, index_symbol, index_value,
              temp_value;
  gint64 raw_result;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_name = Dart_NewStringFromCString ("ownershipTransfer");
  if (Dart_IsError (field_name)) {
    *dart_error_out = field_name;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_value = Dart_GetField (dart_object, field_name);
  if (Dart_IsError (field_value)) {
    *dart_error_out = field_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  index_symbol = Dart_NewStringFromCString ("index");
  if (Dart_IsError (index_symbol)) {
    *dart_error_out = index_symbol;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  index_value = Dart_GetField (field_value, index_symbol);
  if (Dart_IsError (index_value)) {
    *dart_error_out = index_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  temp_value = Dart_IntegerToInt64 (index_value, &raw_result);
  if (Dart_IsError (temp_value)) {
    *dart_error_out = temp_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  *result_out = raw_result;
  return TRUE;
}

static gboolean _gi_arg_info_arg_info_is_caller_allocates (gpointer object,
    GdartBridgeContext *self,
    gboolean *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  *result_out = g_arg_info_is_caller_allocates ( (GIArgInfo *) object);
  return TRUE;
}

static gboolean _null_arg_info_is_caller_allocates (gpointer object,
    GdartBridgeContext *self,
    gboolean *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object,
                               self,
                               "is_caller_allocates",
                               dart_error_out,
                               error);
}

static gboolean _dart_arg_info_is_caller_allocates (gpointer object,
    GdartBridgeContext *self,
    gboolean *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dart_object, field_name, field_value, temp_value;
  gboolean raw_result;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_name = Dart_NewStringFromCString ("isCallerAllocates");
  if (Dart_IsError (field_name)) {
    *dart_error_out = field_name;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_value = Dart_GetField (dart_object, field_name);
  if (Dart_IsError (field_value)) {
    *dart_error_out = field_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  temp_value = Dart_BooleanValue (field_value, (bool*) &raw_result);
  if (Dart_IsError (temp_value)) {
    *dart_error_out = temp_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  *result_out = raw_result;
  return TRUE;
}

static gboolean _gi_callable_info_callable_info_prepare_closure (gpointer 
object,
    GdartBridgeContext *self,
    ffi_cif *cif,
    GIFFIClosureCallback callback,
    gpointer user_data,
    ffi_closure **result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  *result_out = g_callable_info_prepare_closure ( (GICallableInfo *) object,
                cif,
                callback,
                user_data);
  return TRUE;
}

static void _dart_callable_info_prepare_closure_fill_type(
  ffi_type** atypes,
  gintptr i,
  gint64 index)
{
  
    switch (index) {
      case 0: //void_;
        atypes[i] = &ffi_type_void;
	break;
      case 1: //uint8;
        atypes[i] = &ffi_type_uint8;
	break;
      case 2: //sint8;
        atypes[i] = &ffi_type_sint8;
	break;
      case 3: //uint16
        atypes[i] = &ffi_type_uint16;
	break;
      case 4: //sint16
        atypes[i] = &ffi_type_sint16;
	break;
      case 5: //uint32
        atypes[i] = &ffi_type_uint32;
	break;
      case 6: //sint32
        atypes[i] = &ffi_type_sint32;
	break;
      case 7: //uint64
        atypes[i] = &ffi_type_uint64;
	break;
      case 8: //sint64
        atypes[i] = &ffi_type_sint64;
	break;
      case 9: //float
        atypes[i] = &ffi_type_float;
	break;
      case 10: //double
        atypes[i] = &ffi_type_double;
	break;
      case 11: //longdouble
        atypes[i] = &ffi_type_longdouble;
	break;
      case 12: //pointer
        atypes[i] = &ffi_type_pointer;
	break;
      case 13: //uchar
        atypes[i] = &ffi_type_uchar;
	break;
      case 14: //schar
        atypes[i] = &ffi_type_schar;
	break;
      case 15: //ushort
        atypes[i] = &ffi_type_ushort;
	break;
      case 16: //sshort
        atypes[i] = &ffi_type_sshort;
	break;
      case 17: //uint
        atypes[i] = &ffi_type_uint;
	break;
      case 18: //sint
        atypes[i] = &ffi_type_sint;
	break;
      case 19: //ulong
        atypes[i] = &ffi_type_ulong;
	break;
      case 20: //slong
        atypes[i] = &ffi_type_slong;
	break;
    }
}

static ffi_type** _dart_callable_info_prepare_closure_get_arg_types(
  Dart_Handle ffi_arg_value,
  gintptr list_length,
  Dart_Handle *dart_error_out,
  GError **error
)
{
  ffi_type** atypes;
  gintptr i = 0;
  Dart_Handle index_symbol;
  
  index_symbol = Dart_NewStringFromCString("index");
  if (Dart_IsError (index_symbol)) {
    *dart_error_out = index_symbol;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return NULL;
  }
  atypes = g_slice_alloc(sizeof(ffi_type*)*list_length);
  for (;i < list_length; i++) {
    Dart_Handle list_entry, index_value, temp_result;
    gint64 index;
    
    list_entry = Dart_ListGetAt(ffi_arg_value, i);
    if (Dart_IsError (list_entry)) {
      g_slice_free1(list_length*sizeof(ffi_type*), atypes);
      *dart_error_out = list_entry;
      g_set_error (error, GDART_ERROR, 1, "Error from Dart");
      return NULL;
    }
    index_value = Dart_GetField(list_entry, index_symbol);
    if (Dart_IsError (index_value)) {
      g_slice_free1(list_length*sizeof(ffi_type*), atypes);
      *dart_error_out = index_value;
      g_set_error (error, GDART_ERROR, 1, "Error from Dart");
      return NULL;
      return FALSE;
    }
    temp_result = Dart_IntegerToInt64(index_value, &index);
    if (Dart_IsError (temp_result)) {
      g_slice_free1(list_length*sizeof(ffi_type*), atypes);
      *dart_error_out = temp_result;
      g_set_error (error, GDART_ERROR, 1, "Error from Dart");
      return NULL;
      return FALSE;
    }
    _dart_callable_info_prepare_closure_fill_type(atypes, i, index);
  }
  return atypes;
}

static gboolean _dart_callable_info_prepare_closure (gpointer 
object,
    GdartBridgeContext *self,
    ffi_cif *cif,
    GIFFIClosureCallback callback,
    gpointer user_data,
    ffi_closure **result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dart_object, ffi_arguments_symbol, ffi_arg_value, temp_value, 
              ffi_return_type_symbol, ffi_return_type_value, 
	      index_symbol, index_value;
  gintptr list_length;
  gint64 ffi_return_type_index;
  gpointer exec_ptr;
  ffi_type** atypes;
  ffi_type* rtype;
  ffi_status status;
  DartClosureWrapper *closure;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  ffi_arguments_symbol = Dart_NewStringFromCString ("ffiArgumentTypes");
  if (Dart_IsError (ffi_arguments_symbol)) {
    *dart_error_out = ffi_arguments_symbol;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  ffi_arg_value = Dart_GetField (dart_object, ffi_arguments_symbol);
  if (Dart_IsError (ffi_arg_value)) {
    *dart_error_out = ffi_arg_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  if (!Dart_IsList (ffi_arg_value)) {
    *dart_error_out = gdart_bridge_context_create_error_handle (
                        self,
                        "%s: The arguments value was not a list.",
                        G_STRFUNC
                      );
    g_set_error (error, GDART_ERROR, 1,
                 "%s: The arguments value was not a list.",
                 G_STRFUNC);
    return FALSE;
  }
  temp_value = Dart_ListLength(ffi_arg_value, &list_length);
  if (Dart_IsError (temp_value)) {
    *dart_error_out = temp_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  index_symbol = Dart_NewStringFromCString("index");
  if (Dart_IsError (index_symbol)) {
    *dart_error_out = index_symbol;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  if (list_length > 0) {
    atypes = _dart_callable_info_prepare_closure_get_arg_types(
      ffi_arg_value,
      list_length,
      dart_error_out,
      error
    );
    if (atypes == NULL) {
      return FALSE;
    }
  } else {
    atypes = NULL;
  }
  ffi_return_type_symbol = Dart_NewStringFromCString ("ffiReturnType");
  if (Dart_IsError (ffi_return_type_symbol)) {
    g_slice_free1(list_length*sizeof(ffi_type*), atypes);
    *dart_error_out = ffi_return_type_symbol;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  ffi_return_type_value = Dart_GetField (dart_object, ffi_return_type_symbol);
  if (Dart_IsError (ffi_return_type_value)) {
    g_slice_free1(list_length*sizeof(ffi_type*), atypes);
    *dart_error_out = ffi_return_type_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  index_value = Dart_GetField(ffi_return_type_value, index_symbol);
  if (Dart_IsError (index_value)) {
    g_slice_free1(list_length*sizeof(ffi_type*), atypes);
    *dart_error_out = index_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  temp_value = Dart_IntegerToInt64(index_value, &ffi_return_type_index);
  if (Dart_IsError (temp_value)) {
    g_slice_free1(list_length*sizeof(ffi_type*), atypes);
    *dart_error_out = temp_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  _dart_callable_info_prepare_closure_fill_type(&rtype, 
						0, 
						ffi_return_type_index);
  closure = ffi_closure_alloc(sizeof (DartClosureWrapper), &exec_ptr);
  closure->nargs = list_length;
  if (!closure) {
    g_slice_free1(list_length*sizeof(ffi_type*), atypes);
    g_warning("Could not allocate closure");
    *dart_error_out = gdart_bridge_context_create_error_handle (
                        self,
                        "%s: Could not allocate a closure.",
                        G_STRFUNC
                      );
    g_set_error (error, GDART_ERROR, 1,
                 "%s: Could not allocate a closure.",
                 G_STRFUNC);
    return FALSE;
  }
  closure->writable_self = closure;
    
  status = ffi_prep_cif(cif, FFI_DEFAULT_ABI, list_length, rtype, atypes);
  if (status != FFI_OK) {
    g_slice_free1(list_length*sizeof(ffi_type*), atypes);
    g_warning("ffi_prep_cif failed: %d\n", status);
    ffi_closure_free(closure);
    *dart_error_out = gdart_bridge_context_create_error_handle (
                        self,
                        "%s: ffi_prep_cif failed: %d.",
                        G_STRFUNC,
			status
                      );
    g_set_error (error, GDART_ERROR, 1,
                 "%s: ffi_prep_cif failed: %d.",
                 G_STRFUNC,
		 status
		);
    return FALSE;
  }
  status = ffi_prep_closure_loc(&closure->ffi_closure, 
                                cif,
				callback,
				user_data,
				exec_ptr);
  if (status != FFI_OK) {
    g_slice_free1(list_length*sizeof(ffi_type*), atypes);
    g_warning("ffi_prep_closure_loc failed: %d\n", status);
    ffi_closure_free(closure);
    *dart_error_out = gdart_bridge_context_create_error_handle (
                        self,
                        "%s: ffi_prep_closure_loc failed: %d.",
                        G_STRFUNC,
			status
                      );
    g_set_error (error, GDART_ERROR, 1,
                 "%s: ffi_prep_closure_loc failed: %d.",
                 G_STRFUNC,
		 status
		);
    return FALSE;
  }
  *result_out = exec_ptr;
  return TRUE;
}

static gboolean _gi_callable_info_callable_info_free_closure (gpointer object,
    GdartBridgeContext *self,
    ffi_closure *closure,
    Dart_Handle *dart_error_out,
    GError **error)
{
  g_callable_info_free_closure ( (GICallableInfo *) object, closure);
  return TRUE;
}

static gboolean _dart_callable_info_free_closure (gpointer object,
    GdartBridgeContext *self,
    ffi_closure *closure,
    Dart_Handle *dart_error_out,
    GError **error)
{
  DartClosureWrapper *wrapper = (DartClosureWrapper*) closure;
  
  g_slice_free1(wrapper->nargs*sizeof(ffi_type*), 
                wrapper->ffi_closure.cif->arg_types);
  ffi_closure_free(wrapper->writable_self);
  return TRUE;
}

static gboolean _gi_callable_info_callable_info_get_n_args (gpointer object,
    GdartBridgeContext *self,
    gint *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  *result_out = g_callable_info_get_n_args ( (GICallableInfo *) object);
  return TRUE;
}

static gboolean _dart_callable_info_get_n_args (gpointer object,
    GdartBridgeContext *self,
    gint *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dart_object, function_name, field_value, temp_value;
  gintptr list_length;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  function_name = Dart_NewStringFromCString ("args");
  if (Dart_IsError (function_name)) {
    *dart_error_out = function_name;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  field_value = Dart_GetField (dart_object, function_name);
  if (Dart_IsError (field_value)) {
    *dart_error_out = field_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  if (!Dart_IsList (field_value)) {
    *dart_error_out = gdart_bridge_context_create_error_handle (
                        self,
                        "%s: The arguments value was not a list.",
                        G_STRFUNC
                      );
    g_set_error (error, GDART_ERROR, 1,
                 "%s: The arguments value was not a list.",
                 G_STRFUNC);
    return FALSE;
  }
  temp_value = Dart_ListLength(field_value, &list_length);
  if (Dart_IsError (temp_value)) {
    *dart_error_out = temp_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  *result_out = list_length;
  return TRUE;
}

static gboolean _gi_callable_info_callable_info_get_arg (gpointer object,
    GdartBridgeContext *self,
    gint n,
    gpointer *result_out,
    const ArgInfoKlass **result_klass_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  *result_out = (gpointer) g_callable_info_get_arg ( (GICallableInfo *) object, 
n);
  /*
  gchar *name = _gi_base_info_print_name(*result_out);
  printf("Got %s from get arg. Ref count is now %i\n", name, ++gi_count);
  g_free(name);
  */
  *result_klass_out = &gi_arg_info_arg_info;
  return TRUE;
}

static gboolean _dart_callable_info_get_arg (gpointer object,
    GdartBridgeContext *self,
    gint n,
    gpointer *result_out,
    const ArgInfoKlass **result_klass_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dart_object, function_name, field_value, index_storage,
              final_dart_result;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  function_name = Dart_NewStringFromCString ("args");
  if (Dart_IsError (function_name)) {
    *dart_error_out = function_name;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  index_storage = Dart_NewInteger (n);
  if (Dart_IsError (index_storage)) {
    *dart_error_out = index_storage;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  field_value = Dart_GetField (dart_object, function_name);
  if (Dart_IsError (field_value)) {
    *dart_error_out = field_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  if (!Dart_IsList (field_value)) {
    *dart_error_out = gdart_bridge_context_create_error_handle (
                        self,
                        "%s: The arguments value was not a list.",
                        G_STRFUNC
                      );
    g_set_error (error, GDART_ERROR, 1,
                 "%s: The arguments value was not a list.",
                 G_STRFUNC);
    return FALSE;
  }
  final_dart_result = Dart_ListGetAt(field_value, n);
  *result_out = Dart_NewPersistentHandle(final_dart_result);
  *result_klass_out = &dart_arg_info;
  return TRUE;
}

static gboolean _gi_callable_info_callable_info_is_method (gpointer object,
    GdartBridgeContext *self,
    gboolean *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  *result_out = g_callable_info_is_method ( (GICallableInfo *) object);
  return TRUE;
}

static gboolean _dart_callable_info_is_method (gpointer object,
    GdartBridgeContext *self,
    gboolean *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dart_object, field_name, field_value, temp_value;
  bool raw_result;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_name = Dart_NewStringFromCString ("isMethod");
  if (Dart_IsError (field_name)) {
    *dart_error_out = field_name;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_value = Dart_GetField (dart_object, field_name);
  if (Dart_IsError (field_value)) {
    *dart_error_out = field_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  temp_value = Dart_BooleanValue (field_value, &raw_result);
  if (Dart_IsError (temp_value)) {
    *dart_error_out = temp_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  *result_out = raw_result;
  return TRUE;
}

static gboolean _gi_callable_info_callable_info_get_caller_owns (gpointer 
object,
    GdartBridgeContext *self,
    GITransfer *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  *result_out = g_callable_info_get_caller_owns ( (GICallableInfo *) object);
  return TRUE;
}

static gboolean _dart_callable_info_get_caller_owns (
    gpointer object,
    GdartBridgeContext *self,
    GITransfer *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dart_object, field_name, field_value, index_symbol, index_value,
              temp_value;
  gint64 raw_result;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_name = Dart_NewStringFromCString ("callerOwns");
  if (Dart_IsError (field_name)) {
    *dart_error_out = field_name;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_value = Dart_GetField (dart_object, field_name);
  if (Dart_IsError (field_value)) {
    *dart_error_out = field_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  index_symbol = Dart_NewStringFromCString ("index");
  if (Dart_IsError (index_symbol)) {
    *dart_error_out = index_symbol;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  index_value = Dart_GetField (field_value, index_symbol);
  if (Dart_IsError (index_value)) {
    *dart_error_out = index_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  temp_value = Dart_IntegerToInt64 (index_value, &raw_result);
  if (Dart_IsError (temp_value)) {
    *dart_error_out = temp_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  *result_out = raw_result;
  return TRUE;
}

static gboolean _gi_callable_info_callable_info_can_throw_gerror (gpointer 
object,
    GdartBridgeContext *self,
    gboolean *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  *result_out = g_callable_info_can_throw_gerror ( (GICallableInfo *) object);
  return TRUE;
}

static gboolean _dart_callable_info_can_throw_gerror (
    gpointer object,
    GdartBridgeContext *self,
    gboolean *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dart_object, field_name, field_value, temp_value;
  bool raw_result;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_name = Dart_NewStringFromCString ("canThrowError");
  if (Dart_IsError (field_name)) {
    *dart_error_out = field_name;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_value = Dart_GetField (dart_object, field_name);
  if (Dart_IsError (field_value)) {
    *dart_error_out = field_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  temp_value = Dart_BooleanValue (field_value, &raw_result);
  if (Dart_IsError (temp_value)) {
    *dart_error_out = temp_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  *result_out = raw_result;
  return TRUE;
}

static gboolean _gi_callable_info_callable_info_get_return_type (gpointer 
object,
    GdartBridgeContext *self,
    gpointer *result_out,
    const TypeInfoKlass **result_klass_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  *result_out = g_callable_info_get_return_type ( (GICallableInfo *) object);
  //gchar *name = _gi_base_info_print_name(*result_out);
  //printf("Got (anonymous type) from get return type. Ref count is now %i\n", 
  //g_free(name);
  *result_klass_out = &gi_type_info_type_info;
  return TRUE;
}

static gboolean _dart_callable_info_get_return_type (
    gpointer object,
    GdartBridgeContext *self,
    gpointer *result_out,
    const TypeInfoKlass **result_klass_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dart_object, function_name, field_value;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  function_name = Dart_NewStringFromCString ("returnType");
  if (Dart_IsError (function_name)) {
    *dart_error_out = function_name;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  field_value = Dart_GetField (dart_object, function_name);
  if (Dart_IsError (field_value)) {
    *dart_error_out = field_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  *result_out = Dart_NewPersistentHandle (field_value);
  *result_klass_out = &dart_type_info;
  return TRUE;
}

static gboolean _null_callable_info_prepare_closure (gpointer object,
    GdartBridgeContext *self,
    ffi_cif *cif,
    GIFFIClosureCallback callback,
    gpointer user_data,
    ffi_closure **result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object, self, "prepare_closure", dart_error_out, 
error);
}

static gboolean _null_callable_info_free_closure (gpointer object,
    GdartBridgeContext *self,
    ffi_closure *closure,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object, self, "free_closure", dart_error_out, 
error);
}

static gboolean _null_callable_info_get_n_args (gpointer object,
    GdartBridgeContext *self,
    gint *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object, self, "get_n_args", dart_error_out, 
error);
}

static gboolean _null_callable_info_get_arg (gpointer object,
    GdartBridgeContext *self,
    gint n,
    gpointer *result_out,
    const ArgInfoKlass **result_klass_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object, self, "get_arg", dart_error_out, error);
}

static gboolean _null_callable_info_is_method (gpointer object,
    GdartBridgeContext *self,
    gboolean *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object, self, "is_method", dart_error_out, 
error);
}

static gboolean _null_callable_info_get_caller_owns (gpointer object,
    GdartBridgeContext *self,
    GITransfer *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object, self, "get_caller_owns", dart_error_out, 
error);
}

static gboolean _null_callable_info_can_throw_gerror (gpointer object,
    GdartBridgeContext *self,
    gboolean *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object, self, "can_throw_gerror", dart_error_out, 
error);
}

static gboolean _null_callable_info_get_return_type (gpointer object,
    GdartBridgeContext *self,
    gpointer *result_out,
    const TypeInfoKlass **result_klass_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object, self, "get_return_type", dart_error_out, 
error);
}

static gboolean _gi_enum_info_enum_info_get_storage_type (gpointer object,
    GdartBridgeContext *self,
    GITypeTag *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  *result_out = g_enum_info_get_storage_type ( (GIEnumInfo *) object);
  return TRUE;
}

static gboolean _dart_enum_info_get_storage_type (
    gpointer object,
    GdartBridgeContext *self,
    GITypeTag *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dart_object, field_name, field_value, index_symbol, index_value,
              temp_value;
  gint64 raw_result;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_name = Dart_NewStringFromCString ("storageType");
  if (Dart_IsError (field_name)) {
    *dart_error_out = field_name;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_value = Dart_GetField (dart_object, field_name);
  if (Dart_IsError (field_value)) {
    *dart_error_out = field_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  index_symbol = Dart_NewStringFromCString ("index");
  if (Dart_IsError (index_symbol)) {
    *dart_error_out = index_symbol;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  index_value = Dart_GetField (field_value, index_symbol);
  if (Dart_IsError (index_value)) {
    *dart_error_out = index_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  temp_value = Dart_IntegerToInt64 (index_value, &raw_result);
  if (Dart_IsError (temp_value)) {
    *dart_error_out = temp_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  *result_out = raw_result;
  return TRUE;
}


static gboolean _null_enum_info_get_storage_type (gpointer object,
    GdartBridgeContext *self,
    GITypeTag *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object, self, "get_return_type", dart_error_out, 
error);
}

static gboolean _gi_registered_type_info_registered_type_info_get_gtype 
(gpointer object,
    GdartBridgeContext *self,
    GType *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  *result_out = g_registered_type_info_get_g_type ( (GIRegisteredTypeInfo *) 
object);
  return TRUE;
}

static gboolean _dart_registered_type_info_get_gtype 
(gpointer object,
    GdartBridgeContext *self,
    GType *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dart_object, field_name, field_value, temp_value;
  gint64 raw_result;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_name = Dart_NewStringFromCString ("gtype");
  if (Dart_IsError (field_name)) {
    *dart_error_out = field_name;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_value = Dart_GetField (dart_object, field_name);
  if (Dart_IsError (field_value)) {
    *dart_error_out = field_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  temp_value = Dart_IntegerToInt64 (field_value, &raw_result);
  if (Dart_IsError (temp_value)) {
    *dart_error_out = temp_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  *result_out = raw_result;
  return TRUE;
}

static gboolean _gi_registered_type_info_registered_type_info_retrieve_wrapping_class(gpointer object,
				       GdartBridgeContext* self,
				       const gchar* namespace_,
				       Dart_Handle* result_out,
				       Dart_Handle* dart_error,
				       GError **error)
{
  Dart_Handle result;
  GIInfoType info_type;
  
  info_type = g_base_info_get_type((GIBaseInfo*) object);
  result = gdart_bridge_context_retrieve_wrapping_class(
    self,
    namespace_,
    g_registered_type_info_get_g_type((GIRegisteredTypeInfo*) object),
    object,
    &gi_registered_type_info_registered_type_info,
    (info_type == GI_INFO_TYPE_FLAGS || info_type == GI_INFO_TYPE_ENUM),
    dart_error,
    error
  );
  if (result == NULL) return FALSE;
  *result_out = result;
  return TRUE;
}

static gboolean _dart_registered_type_info_retrieve_wrapping_class(gpointer object,
				       GdartBridgeContext* self,
				       const gchar* namespace_,
				       Dart_Handle* result_out,
				       Dart_Handle* dart_error,
				       GError **error)
{
  Dart_Handle dart_object, dart_type_symbol, dart_type_value;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  dart_type_symbol = Dart_NewStringFromCString("dartType");
  if (Dart_IsError (dart_type_symbol)) {
    *dart_error = dart_type_symbol;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  dart_type_value = Dart_GetField(dart_object, dart_type_symbol);
  if (Dart_IsError (dart_type_value)) {
    *dart_error = dart_type_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  *result_out = dart_type_value;
  return TRUE;
}

static gboolean _null_registered_type_info_retrieve_wrapping_class (gpointer object,
    GdartBridgeContext *self,
    const gchar* namespace_,
    Dart_Handle* result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object, self, "retrieve_wrapping_class", dart_error_out, 
error);
}

static gboolean _gi_registered_type_info_registered_type_info_get_hash_code 
(gpointer object,
    GdartBridgeContext *self,
    guint *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  guint current_result = 0;
  guint current_iteration = 0;
  GIBaseInfo *current_base_info;
  current_base_info = g_base_info_ref (object);

  while (current_base_info != NULL) {
    GIBaseInfo *previous_base_info;
    guint inner_hash = g_str_hash (g_base_info_get_name (current_base_info));
    current_result = 63 * current_result + inner_hash;
    current_iteration++;

    previous_base_info = current_base_info;
    current_base_info = g_base_info_get_container (current_base_info);
    g_base_info_unref (previous_base_info);
  }
  current_result = 63 * current_result + g_str_hash (g_base_info_get_namespace 
(object));
  current_result = 63 * current_result + current_iteration;
  *result_out = current_result;
  return TRUE;
}

static gboolean _dart_registered_type_info_get_hash_code 
(gpointer object,
    GdartBridgeContext *self,
    guint *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dart_object, field_name, field_value, temp_value;
  gint64 raw_result;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_name = Dart_NewStringFromCString ("hashCode");
  if (Dart_IsError (field_name)) {
    *dart_error_out = field_name;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_value = Dart_GetField (dart_object, field_name);
  if (Dart_IsError (field_value)) {
    *dart_error_out = field_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  temp_value = Dart_IntegerToInt64 (field_value, &raw_result);
  if (Dart_IsError (temp_value)) {
    *dart_error_out = temp_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  *result_out = raw_result;
  return TRUE;
}


static gboolean _gi_registered_type_info_registered_type_info_equals (gpointer 
object,
    GdartBridgeContext *self,
    gpointer other,
    const RegisteredTypeInfoKlass *other_klass,
    gboolean *result_out,
    Dart_Handle *dart_error_out,
    GError **error);

static gboolean _gi_registered_type_info_registered_type_info_equals (gpointer 
object,
    GdartBridgeContext *self,
    gpointer other,
    const RegisteredTypeInfoKlass *other_klass,
    gboolean *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  if (other_klass->equals != 
_gi_registered_type_info_registered_type_info_equals) {
    *result_out = FALSE;
    return TRUE;
  }
  *result_out = g_base_info_equal (object, other);
  return TRUE;
}

static gboolean _dart_registered_type_info_equals (gpointer 
object,
    GdartBridgeContext *self,
    gpointer other,
    const RegisteredTypeInfoKlass *other_klass,
    gboolean *result_out,
    Dart_Handle *dart_error_out,
    GError **error);

static gboolean _dart_registered_type_info_equals (
    gpointer object,
    GdartBridgeContext *self,
    gpointer other,
    const RegisteredTypeInfoKlass *other_klass,
    gboolean *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dart_object, dart_other_object, temp_result;
  gboolean raw_result;
  
  if (other_klass->equals != _dart_registered_type_info_equals) {
    *result_out = FALSE;
    return TRUE;
  }

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  dart_other_object = Dart_HandleFromPersistent ( 
      (Dart_PersistentHandle) other);
  if (Dart_IsError (dart_other_object)) {
    *dart_error_out = dart_other_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  temp_result = Dart_ObjectEquals(dart_object, 
				  dart_other_object, 
				  (bool*) &raw_result);
  if (Dart_IsError (temp_result)) {
    *dart_error_out = temp_result;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  *result_out = raw_result;
  return TRUE;
}

static gboolean _null_registered_type_info_get_gtype (gpointer object,
    GdartBridgeContext *self,
    GType *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object, self, "get_g_type", dart_error_out, 
error);
}

static gboolean _null_registered_type_info_get_hash_code (gpointer object,
    GdartBridgeContext *self,
    guint *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object, self, "get_hash_code", dart_error_out, 
error);
}

static gboolean _null_registered_type_info_equals (gpointer object,
    GdartBridgeContext *self,
    gpointer other,
    const RegisteredTypeInfoKlass *other_klass,
    gboolean *result_out,
    Dart_Handle *dart_error_out,
    GError **error);

static gboolean _null_registered_type_info_equals (gpointer object,
    GdartBridgeContext *self,
    gpointer other,
    const RegisteredTypeInfoKlass *other_klass,
    gboolean *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  if (other_klass->equals != _null_registered_type_info_equals) {
    *result_out = FALSE;
    return TRUE;
  }
  *result_out = TRUE;
  return TRUE;
}

static void _gi_function_info_function_invoker_destroy(
    GIFunctionInvoker *invoker,
    gpointer user_data)
{
  g_function_invoker_destroy(invoker);
}

static gboolean _gi_function_info_function_info_prep_invoker (gpointer object,
    GdartBridgeContext *self,
    GIFunctionInvoker *invoker,
    gpointer *user_data_out,
    GIFunctionInvokerDestroyFunc *invoker_notify_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  GError *inner_error = NULL;

  g_function_info_prep_invoker (object, invoker, &inner_error);
  if (inner_error != NULL) {
    *dart_error_out = gdart_bridge_context_create_error_handle (
                        self,
                        "%s",
                        inner_error->message);
    g_propagate_error (error, inner_error);
    return FALSE;
  }
  *user_data_out = NULL;
  *invoker_notify_out = &_gi_function_info_function_invoker_destroy;
  return TRUE;
}

typedef struct {
  gpointer peer;
  AddressPeerDestroyFunc peer_finalizer;
  gintptr arg_count;
} DartFunctionInvokerPeer;

static void _dart_function_info_notify_invoker(
    GIFunctionInvoker *invoker,
    gpointer user_data)
{
  DartFunctionInvokerPeer *peer = user_data;
  
  if (peer->peer_finalizer != NULL) 
    peer->peer_finalizer(peer->peer);
  g_slice_free1(peer->arg_count*sizeof(ffi_type*), invoker->cif.arg_types);
  g_slice_free(DartFunctionInvokerPeer, peer);
}

static gboolean _dart_v_func_info_new_invoker_for_address (
  gpointer object,
  GdartBridgeContext *self,
  gpointer addr,
  gpointer peer,
  AddressPeerDestroyFunc peer_finalizer,
  GIFunctionInvoker *invoker,
  gpointer *user_data_out,
  GIFunctionInvokerDestroyFunc *invoker_notify_out,
  Dart_Handle *dart_error_out,
  GError **error);

static void _dart_function_info_prep_invoker_dl_close (gpointer object)
{
  dlclose(object);
}

static gboolean _dart_get_function_from_function_entity (
    GdartBridgeContext *self,
    Dart_Handle function_value,
    gpointer *dl_handle_out,
    gpointer *dl_sym_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dl_filename_symbol, dl_sym_symbol, dl_filename_value, dl_sym_value,
              temp_value;
  gchar *dl_filename_untrimmed, *dl_sym_untrimmed, *dl_filename_trimmed,
        *dl_sym_trimmed;
  gintptr dl_filename_length, dl_sym_length;
  gpointer dl_handle, dl_sym;
  
  if (Dart_IsNull(function_value)) {
    *dl_handle_out = NULL;
    *dl_sym_out = NULL;
    return TRUE;
  }
  
  dl_filename_symbol = Dart_NewStringFromCString("dlFilename");
  if (Dart_IsError (dl_filename_symbol)) {
    *dart_error_out = dl_filename_symbol;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  dl_sym_symbol = Dart_NewStringFromCString("dlSym");
  if (Dart_IsError (dl_sym_symbol)) {
    *dart_error_out = dl_sym_symbol;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  dl_filename_value = Dart_GetField(function_value, dl_filename_symbol);
  if (Dart_IsError (dl_filename_value)) {
    *dart_error_out = dl_filename_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  dl_sym_value = Dart_GetField(function_value, dl_sym_symbol);
  if (Dart_IsError (dl_sym_value)) {
    *dart_error_out = dl_sym_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  temp_value = Dart_StringToUTF8(dl_filename_value, 
                                 (guint8**) &dl_filename_untrimmed,
				 &dl_filename_length);
  if (Dart_IsError (temp_value)) {
    *dart_error_out = temp_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  temp_value = Dart_StringToUTF8(dl_sym_value, 
                                 (guint8**) &dl_sym_untrimmed,
				 &dl_sym_length);
  if (Dart_IsError (temp_value)) {
    *dart_error_out = temp_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  dl_filename_trimmed = g_newa(gchar, dl_filename_length + 1);
  dl_sym_trimmed = g_newa(gchar, dl_sym_length + 1);
  memmove(dl_sym_trimmed, dl_sym_untrimmed, dl_sym_length);
  dl_sym_trimmed[dl_sym_length] = '\0';
  memmove(dl_filename_trimmed, dl_filename_untrimmed, dl_filename_length);
  dl_filename_trimmed[dl_filename_length] = '\0';
  
  dlerror();
  dl_handle = dlopen(dl_filename_trimmed, RTLD_LOCAL | RTLD_NOW);
  if (dl_handle == NULL) {
    gchar* error_string;
    
    error_string = dlerror();
    *dart_error_out = gdart_bridge_context_create_error_handle(
      self,
      "%s: error from dlopen: %s.",
      G_STRFUNC,
      error_string
    );
    g_set_error(error, GDART_ERROR, 1,
      "%s: error from dlopen: %s.",
      G_STRFUNC,
      error_string
    );
    return FALSE;
  }
  
  dl_sym = dlsym(dl_handle, dl_sym_trimmed);
  if (dl_sym == NULL) {
    gchar* error_string;
    
    error_string = dlerror();
    if (error_string != NULL) {
      dlclose(dl_handle);
      *dart_error_out = gdart_bridge_context_create_error_handle(
	self,
	"%s: error from dlopen: %s.",
	G_STRFUNC,
	error_string
      );
      g_set_error(error, GDART_ERROR, 1,
		  "%s: error from dlsym: %s.",
		  G_STRFUNC,
		  error_string
      );
      return FALSE;
    }
  }
  *dl_handle_out = dl_handle;
  *dl_sym_out = dl_sym;
  return TRUE;
}

static gboolean _dart_function_info_prep_invoker (gpointer object,
    GdartBridgeContext *self,
    GIFunctionInvoker *invoker,
    gpointer *user_data_out,
    GIFunctionInvokerDestroyFunc *invoker_notify_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dart_object, 
              function_symbol, function_value;
  gpointer dl_handle, dl_sym;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  function_symbol = Dart_NewStringFromCString ("function");
  if (Dart_IsError (function_symbol)) {
    *dart_error_out = function_symbol;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  function_value = Dart_GetField(dart_object, function_symbol);
  if (Dart_IsError (function_value)) {
    *dart_error_out = function_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  if (!_dart_get_function_from_function_entity(
      self,
      function_value,
      &dl_handle,
      &dl_sym,
      dart_error_out,
      error))
    return FALSE;
  if (!_dart_v_func_info_new_invoker_for_address (
      object,
      self,
      dl_sym,
      dl_handle,
      _dart_function_info_prep_invoker_dl_close,
      invoker,
      user_data_out,
      invoker_notify_out,
      dart_error_out,
      error)) {
    dlclose(dl_handle);
    return FALSE;
  }
  return TRUE;
}

static gboolean _dart_v_func_info_new_invoker_for_address (
  gpointer object,
  GdartBridgeContext *self,
  gpointer addr,
  gpointer peer,
  AddressPeerDestroyFunc peer_finalizer,
  GIFunctionInvoker *invoker,
  gpointer *user_data_out,
  GIFunctionInvokerDestroyFunc *invoker_notify_out,
  Dart_Handle *dart_error_out,
  GError **error)
{
  Dart_Handle dart_object, ffi_arguments_symbol, ffi_arg_value, temp_value,
              index_symbol, ffi_return_type_symbol, ffi_return_type_value,
	      index_value;
  gintptr list_length;
  gint64 ffi_return_type_index;
  ffi_type **atypes, *rtype;
  ffi_status status;
  DartFunctionInvokerPeer *peer_out;
  
  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  ffi_arguments_symbol = Dart_NewStringFromCString ("ffiArgumentTypes");
  if (Dart_IsError (ffi_arguments_symbol)) {
    *dart_error_out = ffi_arguments_symbol;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  
  ffi_arg_value = Dart_GetField (dart_object, ffi_arguments_symbol);
  if (Dart_IsError (ffi_arg_value)) {
    *dart_error_out = ffi_arg_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  if (!Dart_IsList (ffi_arg_value)) {
    *dart_error_out = gdart_bridge_context_create_error_handle (
                        self,
                        "%s: The arguments value was not a list.",
                        G_STRFUNC
                      );
    g_set_error (error, GDART_ERROR, 1,
                 "%s: The arguments value was not a list.",
                 G_STRFUNC);
    return FALSE;
  }
  temp_value = Dart_ListLength(ffi_arg_value, &list_length);
  if (Dart_IsError (temp_value)) {
    *dart_error_out = temp_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  index_symbol = Dart_NewStringFromCString("index");
  if (Dart_IsError (index_symbol)) {
    *dart_error_out = index_symbol;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  if (list_length > 0) {
    atypes = _dart_callable_info_prepare_closure_get_arg_types(
      ffi_arg_value,
      list_length,
      dart_error_out,
      error
    );
    if (atypes == NULL) {
      return FALSE;
    }
  } else {
    atypes = NULL;
  }
  ffi_return_type_symbol = Dart_NewStringFromCString ("ffiReturnType");
  if (Dart_IsError (ffi_return_type_symbol)) {
    g_slice_free1(list_length*sizeof(ffi_type*), atypes);
    *dart_error_out = ffi_return_type_symbol;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  ffi_return_type_value = Dart_GetField (dart_object, ffi_return_type_symbol);
  if (Dart_IsError (ffi_return_type_value)) {
    g_slice_free1(list_length*sizeof(ffi_type*), atypes);
    *dart_error_out = ffi_return_type_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  index_value = Dart_GetField(ffi_return_type_value, index_symbol);
  if (Dart_IsError (index_value)) {
    g_slice_free1(list_length*sizeof(ffi_type*), atypes);
    *dart_error_out = index_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  temp_value = Dart_IntegerToInt64(index_value, &ffi_return_type_index);
  if (Dart_IsError (temp_value)) {
    g_slice_free1(list_length*sizeof(ffi_type*), atypes);
    *dart_error_out = temp_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  _dart_callable_info_prepare_closure_fill_type(&rtype, 
						0, 
						ffi_return_type_index);
  invoker->native_address = addr;
  status = ffi_prep_cif(&(invoker->cif), 
			FFI_DEFAULT_ABI, 
			list_length,
	                rtype, 
			atypes);
  if (status != FFI_OK) {
    g_slice_free1(list_length*sizeof(ffi_type*), atypes);
    g_warning("ffi_prep_cif failed: %d\n", status);
    *dart_error_out = gdart_bridge_context_create_error_handle (
                        self,
                        "%s: ffi_prep_cif failed: %d.",
                        G_STRFUNC,
			status
                      );
    g_set_error (error, GDART_ERROR, 1,
                 "%s: ffi_prep_cif failed: %d.",
                 G_STRFUNC,
		 status
		);
    return FALSE;
  }
  peer_out = g_slice_new(DartFunctionInvokerPeer);
  peer_out->peer = peer;
  peer_out->peer_finalizer = peer_finalizer;
  peer_out->arg_count = list_length;
  *user_data_out = peer_out;
  *invoker_notify_out = &_dart_function_info_notify_invoker;
  return TRUE;
}

static gboolean _null_function_info_prep_invoker (gpointer object,
    GdartBridgeContext *self,
    GIFunctionInvoker *invoker,
    gpointer *user_data_out,
    GIFunctionInvokerDestroyFunc *invoker_notify_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object, self, "prep_invoker", dart_error_out, 
error);
}

static gboolean _gi_v_func_info_v_func_info_get_address (gpointer object,
    GdartBridgeContext *self,
    GType type,
    gpointer *result_out,
    gpointer *peer_out,
    AddressPeerDestroyFunc *peer_finalizer_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  GError *inner_error = NULL;

  *result_out = g_vfunc_info_get_address (object, type, &inner_error);
  if (inner_error != NULL) {
    *dart_error_out = gdart_bridge_context_create_error_handle (
                        self,
                        "%s",
                        inner_error->message);
    g_propagate_error (error, inner_error);
    return FALSE;
  }
  *peer_out = NULL;
  *peer_finalizer_out = NULL;
  return TRUE;
}

typedef struct {
  gpointer peer;
  AddressPeerDestroyFunc peer_finalizer;
} GIVFuncInfoFunctionInvokerPeer;

static void _gi_v_func_info_v_func_info_finalize_function_invoker_peer (
  GIFunctionInvoker *invoker,
  gpointer peer)
{
  GIVFuncInfoFunctionInvokerPeer* self = peer;
  if (self->peer_finalizer != NULL) {
    self->peer_finalizer(self->peer);
  }
  g_slice_free(GIVFuncInfoFunctionInvokerPeer, self);
  g_function_invoker_destroy(invoker);
}

gboolean _gi_v_func_info_v_func_info_new_invoker_for_address (
  gpointer object,
  GdartBridgeContext *self,
  gpointer addr,
  gpointer peer,
  AddressPeerDestroyFunc peer_finalizer,
  GIFunctionInvoker *invoker,
  gpointer *user_data_out,
  GIFunctionInvokerDestroyFunc *invoker_notify_out,
  Dart_Handle *dart_error_out,
  GError **error)
{
  GError *inner_error = NULL;
  GIVFuncInfoFunctionInvokerPeer *outer_peer;
  
  if (!g_function_invoker_new_for_address (addr,
					   (GICallableInfo*) object,
					   invoker ,
					   &inner_error)) {
    *user_data_out = NULL;
    *dart_error_out = gdart_bridge_context_create_error_handle (
      self,
      "%s",
      inner_error->message);
    g_propagate_error (error, inner_error);
    return FALSE;
  }
  outer_peer = g_slice_new(GIVFuncInfoFunctionInvokerPeer);
  outer_peer->peer = peer;
  outer_peer->peer_finalizer = peer_finalizer;
  
  *user_data_out = outer_peer;
  *invoker_notify_out = 
      _gi_v_func_info_v_func_info_finalize_function_invoker_peer;
  return TRUE;
}

static gboolean _null_v_func_info_get_address (gpointer object,
    GdartBridgeContext *self,
    GType type,
    gpointer *result_out,
    gpointer *peer_out,
    AddressPeerDestroyFunc *peer_finalizer_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object, self, "get_address", dart_error_out, 
error);
}

static gboolean _dart_v_func_info_get_address (gpointer object,
    GdartBridgeContext *self,
    GType type,
    gpointer *result_out,
    gpointer *peer_out,
    AddressPeerDestroyFunc *peer_finalizer_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dart_object, temp_value, 
              get_function_symbol, function_value, dl_filename_symbol, 
	      dl_filename_value, dl_sym_symbol, dl_sym_value, gtype_value;
  gchar *dl_filename_untrimmed, *dl_sym_untrimmed, *dl_filename_trimmed,
        *dl_sym_trimmed;
  gintptr dl_filename_length, dl_sym_length;
  gpointer dl_handle;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  get_function_symbol = Dart_NewStringFromCString ("getFunction");
  if (Dart_IsError (get_function_symbol)) {
    *dart_error_out = get_function_symbol;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  gtype_value = Dart_NewIntegerFromUint64(type);
  if (Dart_IsError (gtype_value)) {
    *dart_error_out = gtype_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  function_value = Dart_Invoke(dart_object, get_function_symbol, 1, &gtype_value);
  if (Dart_IsError (function_value)) {
    *dart_error_out = function_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  dl_filename_symbol = Dart_NewStringFromCString("dlFilename");
  if (Dart_IsError (dl_filename_symbol)) {
    *dart_error_out = dl_filename_symbol;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  dl_sym_symbol = Dart_NewStringFromCString("dlSym");
  if (Dart_IsError (dl_sym_symbol)) {
    *dart_error_out = dl_sym_symbol;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  dl_filename_value = Dart_GetField(function_value, dl_filename_symbol);
  if (Dart_IsError (dl_filename_value)) {
    *dart_error_out = dl_filename_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  dl_sym_value = Dart_GetField(function_value, dl_sym_symbol);
  if (Dart_IsError (dl_sym_value)) {
    *dart_error_out = dl_sym_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  temp_value = Dart_StringToUTF8(dl_filename_value, 
                                 (guint8**) &dl_filename_untrimmed,
				 &dl_filename_length);
  if (Dart_IsError (temp_value)) {
    *dart_error_out = temp_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  temp_value = Dart_StringToUTF8(dl_sym_value, 
                                 (guint8**) &dl_sym_untrimmed,
				 &dl_sym_length);
  if (Dart_IsError (temp_value)) {
    *dart_error_out = temp_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  dl_filename_trimmed = g_newa(gchar, dl_filename_length + 1);
  dl_sym_trimmed = g_newa(gchar, dl_sym_length + 1);
  memmove(dl_sym_trimmed, dl_sym_untrimmed, dl_sym_length);
  dl_sym_trimmed[dl_sym_length] = '\0';
  memmove(dl_filename_trimmed, dl_filename_untrimmed, dl_filename_length);
  dl_filename_trimmed[dl_filename_length] = '\0';
  
  dlerror();
  dl_handle = dlopen(dl_filename_trimmed, RTLD_LOCAL);
  if (dl_handle == NULL) {
    gchar* error_string;
    
    error_string = dlerror();
    *dart_error_out = gdart_bridge_context_create_error_handle(
      self,
      "%s: error from dlopen: %s.",
      G_STRFUNC,
      error_string
    );
    g_set_error(error, GDART_ERROR, 1,
      "%s: error from dlopen: %s.",
      G_STRFUNC,
      error_string
    );
    return FALSE;
  }
  
  gpointer dl_sym = dlsym(dl_handle, dl_sym_trimmed);
  if (dl_sym == NULL) {
    gchar* error_string;
    
    error_string = dlerror();
    if (error_string != NULL) {
      *dart_error_out = gdart_bridge_context_create_error_handle(
	self,
	"%s: error from dlopen: %s.",
	G_STRFUNC,
	error_string
      );
      g_set_error(error, GDART_ERROR, 1,
		  "%s: error from dlsym: %s.",
		  G_STRFUNC,
		  error_string
      );
      return FALSE;
    }
  }

  *result_out = dl_sym;
  *peer_out = dl_handle;
  *peer_finalizer_out = _dart_function_info_prep_invoker_dl_close;
  return TRUE;
}

gboolean _null_v_func_info_new_invoker_for_address (
  gpointer object,
  GdartBridgeContext *self,
  gpointer addr,
  gpointer peer,
  AddressPeerDestroyFunc peer_finalizer,
  GIFunctionInvoker *invoker,
  gpointer *user_data_out,
  GIFunctionInvokerDestroyFunc *invoker_notify_out,
  Dart_Handle *dart_error_out,
  GError **error)
{
  return _null_no_such_method (object, self, "new_invoker_for_address", 
dart_error_out, error);
}

static gboolean _gi_object_info_object_info_get_ref_function_pointer (gpointer 
object,
    GdartBridgeContext *self,
    GIObjectInfoRefFunction *result_out,
    GdartFunctionReference **result_out_reference,
    Dart_Handle *dart_error,
    GError **error)
{
  GdartFunctionReference *reference_out;
  gpointer addr;
  
  *result_out = addr = g_object_info_get_ref_function_pointer (object);
  reference_out = g_slice_new(GdartFunctionReference);
  reference_out->dl_handle = NULL;
  reference_out->function_pointer = addr;
  g_atomic_int_set(&reference_out->ref_count, 1);
  *result_out_reference = reference_out;
  return TRUE;
}

static gboolean _dart_object_info_get_ref_function_pointer (gpointer 
object,
    GdartBridgeContext *self,
    GIObjectInfoRefFunction *result_out,
    GdartFunctionReference **result_out_reference,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dart_object, function_symbol, function_value;
  gpointer dl_handle, dl_sym;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  function_symbol = Dart_NewStringFromCString ("refFunction");
  if (Dart_IsError (function_symbol)) {
    *dart_error_out = function_symbol;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  function_value = Dart_GetField(dart_object, function_symbol);
  if (Dart_IsError (function_value)) {
    *dart_error_out = function_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  if (_dart_get_function_from_function_entity(
      self,
      function_value,
      &dl_handle,
      &dl_sym,
      dart_error_out,
      error))
    return FALSE;
  *result_out = dl_sym;
  GdartFunctionReference *reference_out = g_slice_new(GdartFunctionReference);
  reference_out->dl_handle = NULL;
  reference_out->function_pointer = dl_sym;
  g_atomic_int_set(&reference_out->ref_count, 1);
  *result_out_reference = reference_out;
  
  return TRUE;
}

static gboolean _gi_object_info_object_info_get_unref_function_pointer (gpointer 
object,
    GdartBridgeContext *self,
    GIObjectInfoUnrefFunction *result_out,
    GdartFunctionReference **result_out_reference,
    Dart_Handle *dart_error,
    GError **error)
{
  GdartFunctionReference *reference_out;
  gpointer addr;
  
  *result_out = addr = g_object_info_get_unref_function_pointer (object);
  reference_out = g_slice_new(GdartFunctionReference);
  reference_out->dl_handle = NULL;
  reference_out->function_pointer = addr;
  *result_out_reference = reference_out;
  return TRUE;
}

static gboolean _dart_object_info_get_unref_function_pointer (gpointer 
object,
    GdartBridgeContext *self,
    GIObjectInfoUnrefFunction *result_out,
    GdartFunctionReference **result_out_reference,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dart_object, function_symbol, function_value;
  gpointer dl_handle, dl_sym;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  function_symbol = Dart_NewStringFromCString ("unrefFunction");
  if (Dart_IsError (function_symbol)) {
    *dart_error_out = function_symbol;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  function_value = Dart_GetField(dart_object, function_symbol);
  if (Dart_IsError (function_value)) {
    *dart_error_out = function_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  if (_dart_get_function_from_function_entity(
      self,
      function_value,
      &dl_handle,
      &dl_sym,
      dart_error_out,
      error))
    return FALSE;
  *result_out = dl_sym;
  GdartFunctionReference *reference_out = g_slice_new(GdartFunctionReference);
  reference_out->dl_handle = NULL;
  reference_out->function_pointer = dl_sym;
  g_atomic_int_set(&reference_out->ref_count, 1);
  *result_out_reference = reference_out;
  
  return TRUE;
}

static gboolean _null_object_info_get_ref_function_pointer (gpointer object,
    GdartBridgeContext *self,
    GIObjectInfoRefFunction *result_out,
    GdartFunctionReference **result_out_reference,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object, self, "get_ref_function_pointer", 
dart_error_out, error);
}

static gboolean _null_object_info_get_unref_function_pointer (gpointer object,
    GdartBridgeContext *self,
    GIObjectInfoUnrefFunction *result_out,
    GdartFunctionReference **result_out_reference,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object, self, "get_unref_function_pointer", 
dart_error_out, error);
}

static gboolean _gi_struct_info_struct_union_info_get_size (gpointer object,
    GdartBridgeContext *self,
    gsize *result_out,
    Dart_Handle *dart_error,
    GError **error)
{
  *result_out = g_struct_info_get_size (object);
  return TRUE;
}

static gboolean _gi_union_info_struct_union_info_get_size (gpointer object,
    GdartBridgeContext *self,
    gsize *result_out,
    Dart_Handle *dart_error,
    GError **error)
{
  *result_out = g_union_info_get_size (object);
  return TRUE;
}

static gboolean _dart_struct_union_info_get_size (gpointer object,
    GdartBridgeContext *self,
    gsize *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dart_object, field_name, field_value, temp_value;
  gint64 raw_result;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_name = Dart_NewStringFromCString ("size");
  if (Dart_IsError (field_name)) {
    *dart_error_out = field_name;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_value = Dart_GetField (dart_object, field_name);
  if (Dart_IsError (field_value)) {
    *dart_error_out = field_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  temp_value = Dart_IntegerToInt64 (field_value, &raw_result);
  if (Dart_IsError (temp_value)) {
    *dart_error_out = temp_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  *result_out = raw_result;
  return TRUE;
}

static gboolean _null_struct_union_info_get_size (gpointer object,
    GdartBridgeContext *self,
    gsize *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object, self, "get_size", dart_error_out, error);
}

static gboolean _gi_struct_info_struct_union_info_get_n_fields (gpointer object,
    GdartBridgeContext *self,
    gint *result_out,
    Dart_Handle *dart_error,
    GError **error)
{
  *result_out = g_struct_info_get_n_fields (object);
  return TRUE;
}

static gboolean _gi_union_info_struct_union_info_get_n_fields (gpointer object,
    GdartBridgeContext *self,
    gint *result_out,
    Dart_Handle *dart_error,
    GError **error)
{
  *result_out = g_union_info_get_n_fields (object);
  return TRUE;
}

static gboolean _dart_struct_union_info_get_n_fields (gpointer object,
    GdartBridgeContext *self,
    gint *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dart_object, field_name, field_value, temp_value;
  gintptr raw_result;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_name = Dart_NewStringFromCString ("fields");
  if (Dart_IsError (field_name)) {
    *dart_error_out = field_name;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_value = Dart_GetField (dart_object, field_name);
  if (Dart_IsError (field_value)) {
    *dart_error_out = field_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  temp_value = Dart_ListLength(field_value, &raw_result);
  if (Dart_IsError (temp_value)) {
    *dart_error_out = temp_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  *result_out = raw_result;
  return TRUE;
}

static gboolean _null_struct_union_info_get_n_fields (gpointer object,
    GdartBridgeContext *self,
    gint *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object, self, "get_n_fields", dart_error_out, error);
}

static gboolean _gi_struct_info_struct_union_info_get_field (gpointer object,
    GdartBridgeContext *self,
    gint n,
    gpointer *result_out,
    const FieldInfoKlass **result_klass_out,
    Dart_Handle *dart_error,
    GError **error)
{
  *result_out = g_struct_info_get_field (object, n);
  *result_klass_out = &gi_field_info_field_info;
  return TRUE;
}

static gboolean _gi_union_info_struct_union_info_get_field (gpointer object,
    GdartBridgeContext *self,
    gint n,
    gpointer *result_out,
    const FieldInfoKlass **result_klass_out,
    Dart_Handle *dart_error,
    GError **error)
{
  *result_out = g_union_info_get_field (object, n);
  *result_klass_out = &gi_field_info_field_info;
  return TRUE;
}

static gboolean _dart_struct_union_info_get_field (gpointer object,
    GdartBridgeContext *self,
    gint n,
    gpointer *result_out,
    const FieldInfoKlass **result_klass_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dart_object, field_name, field_value, temp_value;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_name = Dart_NewStringFromCString ("fields");
  if (Dart_IsError (field_name)) {
    *dart_error_out = field_name;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_value = Dart_GetField (dart_object, field_name);
  if (Dart_IsError (field_value)) {
    *dart_error_out = field_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  temp_value = Dart_ListGetAt(field_value, n);
  if (Dart_IsError (temp_value)) {
    *dart_error_out = temp_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  *result_out = Dart_NewPersistentHandle(temp_value);
  *result_klass_out = &dart_field_info;
  return TRUE;
}

static gboolean _null_struct_union_info_get_field (gpointer object,
    GdartBridgeContext *self,
    gint n,
    gpointer *result_out,
    const FieldInfoKlass **result_klass_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object, self, "get_field", dart_error_out, error);
}

static gboolean _gi_struct_union_info_struct_union_info_retrieve_copy_function(
  gpointer object,
  GdartBridgeContext *self,
  GdartFunctionReference **result_out,
  Dart_Handle *dart_error_out,
  GError **error)
{
  GIRegisteredTypeInfo* registered_type_info = object;
  GdartFunctionReference *function_reference;
  
  function_reference = gdart_bridge_context_retrieve_copy_func (self,
                                    g_base_info_get_namespace((GIBaseInfo*) registered_type_info),
                                    registered_type_info,
                                    &gi_registered_type_info_registered_type_info,
                                    g_registered_type_info_get_g_type(registered_type_info));
  *result_out = function_reference;
  return TRUE;
}

static gboolean _null_struct_union_info_retrieve_copy_function(
  gpointer object,
  GdartBridgeContext *self,
  GdartFunctionReference **result_out,
  Dart_Handle *dart_error_out,
  GError **error)
{
  return _null_no_such_method (object, self, "retrieve_copy_function", dart_error_out, error);
}

static gboolean _dart_struct_union_info_retrieve_copy_function(
  gpointer object,
  GdartBridgeContext *self,
  GdartFunctionReference **result_out,
  Dart_Handle *dart_error_out,
  GError **error)
{
  Dart_Handle dart_object, function_symbol, function_value;
  gpointer dl_handle, dl_sym;
  GdartFunctionReference *reference_out;
  
  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  function_symbol = Dart_NewStringFromCString ("copyFunction");
  if (Dart_IsError (function_symbol)) {
    *dart_error_out = function_symbol;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  function_value = Dart_GetField(dart_object, function_symbol);
  if (Dart_IsError (function_value)) {
    *dart_error_out = function_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  if (!_dart_get_function_from_function_entity(
      self,
      function_value,
      &dl_handle,
      &dl_sym,
      dart_error_out,
      error))
    return FALSE;
  if (dl_sym == NULL && dl_handle == NULL) {
    reference_out = NULL;
  } else {
    reference_out = g_slice_new(GdartFunctionReference);
    reference_out->dl_handle = NULL;
    reference_out->function_pointer = dl_sym;
    g_atomic_int_set(&reference_out->ref_count, 1);
  }
  *result_out = reference_out;
  return TRUE;
}

static gboolean _gi_struct_union_info_struct_union_info_retrieve_free_function(
  gpointer object,
  GdartBridgeContext *self,
  GdartFunctionReference **result_out,
  Dart_Handle *dart_error_out,
  GError **error)
{
  GIRegisteredTypeInfo* registered_type_info = object;
  GdartFunctionReference *function_reference;
  
  function_reference = gdart_bridge_context_retrieve_free_func (self,
                                    g_base_info_get_namespace((GIBaseInfo*) registered_type_info),
                                    registered_type_info,
                                    &gi_registered_type_info_registered_type_info,
                                    g_registered_type_info_get_g_type(registered_type_info));
  *result_out = function_reference;
  return TRUE;
}

static gboolean _null_struct_union_info_retrieve_free_function(
  gpointer object,
  GdartBridgeContext *self,
  GdartFunctionReference **result_out,
  Dart_Handle *dart_error_out,
  GError **error)
{
  return _null_no_such_method (object, self, "retrieve_free_function", dart_error_out, error);
}

static gboolean _dart_struct_union_info_retrieve_free_function(
  gpointer object,
  GdartBridgeContext *self,
  GdartFunctionReference **result_out,
  Dart_Handle *dart_error_out,
  GError **error)
{
  Dart_Handle dart_object, function_symbol, function_value;
  gpointer dl_handle, dl_sym;
  GdartFunctionReference *reference_out;
  
  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  function_symbol = Dart_NewStringFromCString ("freeFunction");
  if (Dart_IsError (function_symbol)) {
    *dart_error_out = function_symbol;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  function_value = Dart_GetField(dart_object, function_symbol);
  if (Dart_IsError (function_value)) {
    *dart_error_out = function_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  if (!_dart_get_function_from_function_entity(
      self,
      function_value,
      &dl_handle,
      &dl_sym,
      dart_error_out,
      error))
    return FALSE;
  if (dl_handle == NULL && dl_sym == NULL) {
    reference_out = NULL;
  } else {
    reference_out = g_slice_new(GdartFunctionReference);
    reference_out->dl_handle = NULL;
    reference_out->function_pointer = dl_sym;
    g_atomic_int_set(&reference_out->ref_count, 1);
  }
  *result_out = reference_out;
  return TRUE;
}

static gboolean _gi_field_info_field_info_get_size (gpointer object,
    GdartBridgeContext *self,
    gint *result_out,
    Dart_Handle *dart_error,
    GError **error)
{
  *result_out = g_field_info_get_size (object);
  return TRUE;
}

static gboolean _dart_field_info_get_size (gpointer object,
    GdartBridgeContext *self,
    gint *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dart_object, field_name, field_value, temp_value;
  gint64 raw_result;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_name = Dart_NewStringFromCString ("size");
  if (Dart_IsError (field_name)) {
    *dart_error_out = field_name;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_value = Dart_GetField (dart_object, field_name);
  if (Dart_IsError (field_value)) {
    *dart_error_out = field_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  temp_value = Dart_IntegerToInt64 (field_value, &raw_result);
  if (Dart_IsError (temp_value)) {
    *dart_error_out = temp_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  *result_out = raw_result;
  return TRUE;
}

static gboolean _gi_field_info_field_info_get_offset (gpointer object,
    GdartBridgeContext *self,
    gint *result_out,
    Dart_Handle *dart_error,
    GError **error)
{
  *result_out = g_field_info_get_offset (object);
  return TRUE;
}

static gboolean _dart_field_info_get_offset (gpointer object,
    GdartBridgeContext *self,
    gint *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dart_object, field_name, field_value, temp_value;
  gint64 raw_result;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_name = Dart_NewStringFromCString ("offset");
  if (Dart_IsError (field_name)) {
    *dart_error_out = field_name;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  field_value = Dart_GetField (dart_object, field_name);
  if (Dart_IsError (field_value)) {
    *dart_error_out = field_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  temp_value = Dart_IntegerToInt64 (field_value, &raw_result);
  if (Dart_IsError (temp_value)) {
    *dart_error_out = temp_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  } 
  *result_out = raw_result;
  return TRUE;
}

static gboolean _gi_field_info_field_info_get_type (gpointer 
object,
    GdartBridgeContext *self,
    gpointer *result_out,
    const TypeInfoKlass **result_klass_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  *result_out = g_field_info_get_type ( (GIFieldInfo *) object);
  //gchar *name = _gi_base_info_print_name(*result_out);
  //printf("Got (anonymous type) from get return type. Ref count is now %i\n", 
  //g_free(name);
  *result_klass_out = &gi_type_info_type_info;
  return TRUE;
}

static gboolean _dart_field_info_get_type (
    gpointer object,
    GdartBridgeContext *self,
    gpointer *result_out,
    const TypeInfoKlass **result_klass_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle dart_object, function_name, field_value;

  dart_object = Dart_HandleFromPersistent ( (Dart_PersistentHandle) object);
  if (Dart_IsError (dart_object)) {
    *dart_error_out = dart_object;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }

  function_name = Dart_NewStringFromCString ("fieldType");
  if (Dart_IsError (function_name)) {
    *dart_error_out = function_name;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  field_value = Dart_GetField (dart_object, function_name);
  if (Dart_IsError (field_value)) {
    *dart_error_out = field_value;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart");
    return FALSE;
  }
  *result_out = Dart_NewPersistentHandle (field_value);
  *result_klass_out = &dart_type_info;
  return TRUE;
}

const RegisteredTypeInfoKlass gi_registered_type_info_registered_type_info = {
  _gi_base_info_interface_info_copy,
  _gi_base_info_interface_info_free,
  _gi_base_info_interface_info_get_name,
  _gi_base_info_interface_info_get_type,
  _gi_base_info_interface_info_get_namespace,
  _gi_registered_type_info_registered_type_info_get_gtype,
  _gi_registered_type_info_registered_type_info_retrieve_wrapping_class,
  _gi_registered_type_info_registered_type_info_get_hash_code,
  _gi_registered_type_info_registered_type_info_equals,
  _gi_base_info_interface_info_cast_interface_to_object_info,
  _gi_base_info_interface_info_cast_interface_to_struct_union_info
};

const RegisteredTypeInfoKlass gi_base_info_registered_type_info = {
  _gi_base_info_interface_info_copy,
  _gi_base_info_interface_info_free,
  _gi_base_info_interface_info_get_name,
  _gi_base_info_interface_info_get_type,
  _gi_base_info_interface_info_get_namespace,
  _null_registered_type_info_get_gtype,
  _null_registered_type_info_retrieve_wrapping_class,
  _gi_registered_type_info_registered_type_info_get_hash_code,
  _gi_registered_type_info_registered_type_info_equals,
  _gi_base_info_interface_info_cast_interface_to_object_info,
  _gi_base_info_interface_info_cast_interface_to_struct_union_info
};

const RegisteredTypeInfoKlass null_registered_type_info = {
  _null_interface_info_copy,
  _null_interface_info_free,
  _null_interface_info_get_name,
  _null_interface_info_get_type,
  _null_interface_info_get_namespace,
  _null_registered_type_info_get_gtype,
  _null_registered_type_info_retrieve_wrapping_class,
  _null_registered_type_info_get_hash_code,
  _null_registered_type_info_equals,
  _null_interface_info_cast_interface_to_object_info,
  _null_interface_info_cast_interface_to_struct_union_info
};

const RegisteredTypeInfoKlass dart_registered_type_info = {
  _dart_interface_info_copy,
  _dart_interface_info_free,
  _dart_interface_info_get_name,
  _dart_interface_info_get_type,
  _dart_interface_info_get_namespace,
  _dart_registered_type_info_get_gtype,
  _dart_registered_type_info_retrieve_wrapping_class,
  _dart_registered_type_info_get_hash_code,
  _dart_registered_type_info_equals,
  _dart_interface_info_cast_interface_to_object_info,
  _dart_interface_info_cast_interface_to_struct_union_info
};

const ObjectInfoKlass gi_object_info_object_info = {
  _gi_base_info_interface_info_copy,
  _gi_base_info_interface_info_free,
  _gi_base_info_interface_info_get_name,
  _gi_base_info_interface_info_get_type,
  _gi_base_info_interface_info_get_namespace,
  _gi_registered_type_info_registered_type_info_get_gtype,
  _gi_registered_type_info_registered_type_info_retrieve_wrapping_class,
  _gi_object_info_object_info_get_ref_function_pointer,
  _gi_object_info_object_info_get_unref_function_pointer
};

const ObjectInfoKlass gi_registered_type_info_object_info = {
  _gi_base_info_interface_info_copy,
  _gi_base_info_interface_info_free,
  _gi_base_info_interface_info_get_name,
  _gi_base_info_interface_info_get_type,
  _gi_base_info_interface_info_get_namespace,
  _gi_registered_type_info_registered_type_info_get_gtype,
  _gi_registered_type_info_registered_type_info_retrieve_wrapping_class,
  _null_object_info_get_ref_function_pointer,
  _null_object_info_get_unref_function_pointer
};

const ObjectInfoKlass gi_base_info_object_info = {
  _gi_base_info_interface_info_copy,
  _gi_base_info_interface_info_free,
  _gi_base_info_interface_info_get_name,
  _gi_base_info_interface_info_get_type,
  _gi_base_info_interface_info_get_namespace,
  _null_registered_type_info_get_gtype,
  _null_registered_type_info_retrieve_wrapping_class,
  _null_object_info_get_ref_function_pointer,
  _null_object_info_get_unref_function_pointer
};

const ObjectInfoKlass null_object_info = {
  _null_interface_info_copy,
  _null_interface_info_free,
  _null_interface_info_get_name,
  _null_interface_info_get_type,
  _null_interface_info_get_namespace,
  _null_registered_type_info_get_gtype,
  _null_registered_type_info_retrieve_wrapping_class,
  _null_object_info_get_ref_function_pointer,
  _null_object_info_get_unref_function_pointer
};

const ObjectInfoKlass dart_object_info = {
  _dart_interface_info_copy,
  _dart_interface_info_free,
  _dart_interface_info_get_name,
  _dart_interface_info_get_type,
  _dart_interface_info_get_namespace,
  _dart_registered_type_info_get_gtype,
  _dart_registered_type_info_retrieve_wrapping_class,
  _dart_object_info_get_ref_function_pointer,
  _dart_object_info_get_unref_function_pointer
};

const StructUnionInfoKlass gi_union_info_struct_union_info = {
  _gi_base_info_interface_info_copy,
  _gi_base_info_interface_info_free,
  _gi_base_info_interface_info_get_name,
  _gi_base_info_interface_info_get_type,
  _gi_base_info_interface_info_get_namespace,
  _gi_registered_type_info_registered_type_info_get_gtype,
  _gi_registered_type_info_registered_type_info_retrieve_wrapping_class,
  _gi_struct_union_info_struct_union_info_retrieve_copy_function,
  _gi_struct_union_info_struct_union_info_retrieve_free_function,
  _gi_union_info_struct_union_info_get_size,
  _gi_union_info_struct_union_info_get_n_fields,
  _gi_union_info_struct_union_info_get_field
};

const StructUnionInfoKlass gi_struct_info_struct_union_info = {
  _gi_base_info_interface_info_copy,
  _gi_base_info_interface_info_free,
  _gi_base_info_interface_info_get_name,
  _gi_base_info_interface_info_get_type,
  _gi_base_info_interface_info_get_namespace,
  _gi_registered_type_info_registered_type_info_get_gtype,
  _gi_registered_type_info_registered_type_info_retrieve_wrapping_class,
  _gi_struct_union_info_struct_union_info_retrieve_copy_function,
  _gi_struct_union_info_struct_union_info_retrieve_free_function,
  _gi_struct_info_struct_union_info_get_size,
  _gi_struct_info_struct_union_info_get_n_fields,
  _gi_struct_info_struct_union_info_get_field
};

const StructUnionInfoKlass gi_registered_type_info_struct_union_info = {
  _gi_base_info_interface_info_copy,
  _gi_base_info_interface_info_free,
  _gi_base_info_interface_info_get_name,
  _gi_base_info_interface_info_get_type,
  _gi_base_info_interface_info_get_namespace,
  _gi_registered_type_info_registered_type_info_get_gtype,
  _gi_registered_type_info_registered_type_info_retrieve_wrapping_class,
  _null_struct_union_info_retrieve_copy_function,
  _null_struct_union_info_retrieve_free_function,
  _null_struct_union_info_get_size,
  _null_struct_union_info_get_n_fields,
  _null_struct_union_info_get_field
};

const StructUnionInfoKlass gi_base_info_struct_union_info = {
  _gi_base_info_interface_info_copy,
  _gi_base_info_interface_info_free,
  _gi_base_info_interface_info_get_name,
  _gi_base_info_interface_info_get_type,
  _gi_base_info_interface_info_get_namespace,
  _null_registered_type_info_get_gtype,
  _null_registered_type_info_retrieve_wrapping_class,
  _null_struct_union_info_retrieve_copy_function,
  _null_struct_union_info_retrieve_free_function,
  _null_struct_union_info_get_size,
  _null_struct_union_info_get_n_fields,
  _null_struct_union_info_get_field
};

const StructUnionInfoKlass null_struct_union_info = {
  _null_interface_info_copy,
  _null_interface_info_free,
  _null_interface_info_get_name,
  _null_interface_info_get_type,
  _null_interface_info_get_namespace,
  _null_registered_type_info_get_gtype,
  _null_registered_type_info_retrieve_wrapping_class,
  _null_struct_union_info_retrieve_copy_function,
  _null_struct_union_info_retrieve_free_function,
  _null_struct_union_info_get_size,
  _null_struct_union_info_get_n_fields,
  _null_struct_union_info_get_field
};

const StructUnionInfoKlass dart_struct_union_info = {
  _dart_interface_info_copy,
  _dart_interface_info_free,
  _dart_interface_info_get_name,
  _dart_interface_info_get_type,
  _dart_interface_info_get_namespace,
  _dart_registered_type_info_get_gtype,
  _dart_registered_type_info_retrieve_wrapping_class,
  _dart_struct_union_info_retrieve_copy_function,
  _dart_struct_union_info_retrieve_free_function,
  _dart_struct_union_info_get_size,
  _dart_struct_union_info_get_n_fields,
  _dart_struct_union_info_get_field
};

const EnumInfoKlass gi_enum_info_enum_info = {
  _gi_base_info_interface_info_copy,
  _gi_base_info_interface_info_free,
  _gi_base_info_interface_info_get_name,
  _gi_base_info_interface_info_get_type,
  _gi_base_info_interface_info_get_namespace,
  _gi_registered_type_info_registered_type_info_get_gtype,
  _gi_registered_type_info_registered_type_info_retrieve_wrapping_class,
  _gi_enum_info_enum_info_get_storage_type,
  _gi_base_info_interface_info_cast_interface_to_registered_type_info
};

const EnumInfoKlass gi_base_info_enum_info = {
  _gi_base_info_interface_info_copy,
  _gi_base_info_interface_info_free,
  _gi_base_info_interface_info_get_name,
  _gi_base_info_interface_info_get_type,
  _gi_base_info_interface_info_get_namespace,
  _null_registered_type_info_get_gtype,
  _null_registered_type_info_retrieve_wrapping_class,
  _null_enum_info_get_storage_type,
  _gi_base_info_interface_info_cast_interface_to_registered_type_info
};

const EnumInfoKlass null_enum_info = {
  _null_interface_info_copy,
  _null_interface_info_free,
  _null_interface_info_get_name,
  _null_interface_info_get_type,
  _null_interface_info_get_namespace,
  _null_registered_type_info_get_gtype,
  _null_registered_type_info_retrieve_wrapping_class,
  _null_enum_info_get_storage_type,
  _null_interface_info_cast_interface_to_registered_info,
};

const EnumInfoKlass dart_enum_info = {
  _dart_interface_info_copy,
  _dart_interface_info_free,
  _dart_interface_info_get_name,
  _dart_interface_info_get_type,
  _dart_interface_info_get_namespace,
  _dart_registered_type_info_get_gtype,
  _dart_registered_type_info_retrieve_wrapping_class,
  _dart_enum_info_get_storage_type,
  _dart_interface_info_cast_interface_to_registered_type_info
};

const CallableInfoKlass gi_callable_info_callable_info = {
  _gi_base_info_interface_info_copy,
  _gi_base_info_interface_info_free,
  _gi_base_info_interface_info_get_name,
  _gi_base_info_interface_info_get_type,
  _gi_base_info_interface_info_get_namespace,
  _gi_callable_info_callable_info_prepare_closure,
  _gi_callable_info_callable_info_free_closure,
  _gi_callable_info_callable_info_get_n_args,
  _gi_callable_info_callable_info_get_arg,
  _gi_callable_info_callable_info_is_method,
  _gi_callable_info_callable_info_get_caller_owns,
  _gi_callable_info_callable_info_can_throw_gerror,
  _gi_callable_info_callable_info_get_return_type,
  _gi_base_info_interface_info_cast_interface_to_function_info,
  _gi_base_info_interface_info_cast_interface_to_v_func_info
};

const CallableInfoKlass gi_base_info_callable_info = {
  _gi_base_info_interface_info_copy,
  _gi_base_info_interface_info_free,
  _gi_base_info_interface_info_get_name,
  _gi_base_info_interface_info_get_type,
  _gi_base_info_interface_info_get_namespace,
  _null_callable_info_prepare_closure,
  _null_callable_info_free_closure,
  _null_callable_info_get_n_args,
  _null_callable_info_get_arg,
  _null_callable_info_is_method,
  _null_callable_info_get_caller_owns,
  _null_callable_info_can_throw_gerror,
  _null_callable_info_get_return_type,
  _gi_base_info_interface_info_cast_interface_to_function_info,
  _gi_base_info_interface_info_cast_interface_to_v_func_info
};

const CallableInfoKlass null_callable_info = {
  _null_interface_info_copy,
  _null_interface_info_free,
  _null_interface_info_get_name,
  _null_interface_info_get_type,
  _null_interface_info_get_namespace,
  _null_callable_info_prepare_closure,
  _null_callable_info_free_closure,
  _null_callable_info_get_n_args,
  _null_callable_info_get_arg,
  _null_callable_info_is_method,
  _null_callable_info_get_caller_owns,
  _null_callable_info_can_throw_gerror,
  _null_callable_info_get_return_type,
  _null_interface_info_cast_interface_to_function_info,
  _null_interface_info_cast_interface_to_v_func_info
};

const CallableInfoKlass dart_callable_info = {
  _dart_interface_info_copy,
  _dart_interface_info_free,
  _dart_interface_info_get_name,
  _dart_interface_info_get_type,
  _dart_interface_info_get_namespace,
  _dart_callable_info_prepare_closure,
  _dart_callable_info_free_closure,
  _dart_callable_info_get_n_args,
  _dart_callable_info_get_arg,
  _dart_callable_info_is_method,
  _dart_callable_info_get_caller_owns,
  _dart_callable_info_can_throw_gerror,
  _dart_callable_info_get_return_type,
  _dart_interface_info_cast_interface_to_function_info,
  _dart_interface_info_cast_interface_to_v_func_info
};

const FunctionInfoKlass gi_function_info_function_info = {
  _gi_base_info_interface_info_copy,
  _gi_base_info_interface_info_free,
  _gi_base_info_interface_info_get_name,
  _gi_base_info_interface_info_get_type,
  _gi_base_info_interface_info_get_namespace,
  _gi_callable_info_callable_info_prepare_closure,
  _gi_callable_info_callable_info_free_closure,
  _gi_callable_info_callable_info_get_n_args,
  _gi_callable_info_callable_info_get_arg,
  _gi_callable_info_callable_info_is_method,
  _gi_callable_info_callable_info_get_caller_owns,
  _gi_callable_info_callable_info_can_throw_gerror,
  _gi_callable_info_callable_info_get_return_type,
  _gi_function_info_function_info_prep_invoker
};

const FunctionInfoKlass gi_callable_info_function_info = {
  _gi_base_info_interface_info_copy,
  _gi_base_info_interface_info_free,
  _gi_base_info_interface_info_get_name,
  _gi_base_info_interface_info_get_type,
  _gi_base_info_interface_info_get_namespace,
  _gi_callable_info_callable_info_prepare_closure,
  _gi_callable_info_callable_info_free_closure,
  _gi_callable_info_callable_info_get_n_args,
  _gi_callable_info_callable_info_get_arg,
  _gi_callable_info_callable_info_is_method,
  _gi_callable_info_callable_info_get_caller_owns,
  _gi_callable_info_callable_info_can_throw_gerror,
  _gi_callable_info_callable_info_get_return_type,
  _null_function_info_prep_invoker
};

const FunctionInfoKlass gi_base_info_function_info = {
  _gi_base_info_interface_info_copy,
  _gi_base_info_interface_info_free,
  _gi_base_info_interface_info_get_name,
  _gi_base_info_interface_info_get_type,
  _gi_base_info_interface_info_get_namespace,
  _null_callable_info_prepare_closure,
  _null_callable_info_free_closure,
  _null_callable_info_get_n_args,
  _null_callable_info_get_arg,
  _null_callable_info_is_method,
  _null_callable_info_get_caller_owns,
  _null_callable_info_can_throw_gerror,
  _null_callable_info_get_return_type,
  _null_function_info_prep_invoker
};

const FunctionInfoKlass null_function_info = {
  _null_interface_info_copy,
  _null_interface_info_free,
  _null_interface_info_get_name,
  _null_interface_info_get_type,
  _null_interface_info_get_namespace,
  _null_callable_info_prepare_closure,
  _null_callable_info_free_closure,
  _null_callable_info_get_n_args,
  _null_callable_info_get_arg,
  _null_callable_info_is_method,
  _null_callable_info_get_caller_owns,
  _null_callable_info_can_throw_gerror,
  _null_callable_info_get_return_type,
  _null_function_info_prep_invoker
};

const FunctionInfoKlass dart_function_info = {
  _dart_interface_info_copy,
  _dart_interface_info_free,
  _dart_interface_info_get_name,
  _dart_interface_info_get_type,
  _dart_interface_info_get_namespace,
  _dart_callable_info_prepare_closure,
  _dart_callable_info_free_closure,
  _dart_callable_info_get_n_args,
  _dart_callable_info_get_arg,
  _dart_callable_info_is_method,
  _dart_callable_info_get_caller_owns,
  _dart_callable_info_can_throw_gerror,
  _dart_callable_info_get_return_type,
  _dart_function_info_prep_invoker
};

const VFuncInfoKlass gi_v_func_info_v_func_info = {
  _gi_base_info_interface_info_copy,
  _gi_base_info_interface_info_free,
  _gi_base_info_interface_info_get_name,
  _gi_base_info_interface_info_get_type,
  _gi_base_info_interface_info_get_namespace,
  _gi_callable_info_callable_info_prepare_closure,
  _gi_callable_info_callable_info_free_closure,
  _gi_callable_info_callable_info_get_n_args,
  _gi_callable_info_callable_info_get_arg,
  _gi_callable_info_callable_info_is_method,
  _gi_callable_info_callable_info_get_caller_owns,
  _gi_callable_info_callable_info_can_throw_gerror,
  _gi_callable_info_callable_info_get_return_type,
  _gi_v_func_info_v_func_info_get_address,
  _gi_v_func_info_v_func_info_new_invoker_for_address
};

const VFuncInfoKlass dart_v_func_info = {
  _dart_interface_info_copy,
  _dart_interface_info_free,
  _dart_interface_info_get_name,
  _dart_interface_info_get_type,
  _dart_interface_info_get_namespace,
  _dart_callable_info_prepare_closure,
  _dart_callable_info_free_closure,
  _dart_callable_info_get_n_args,
  _dart_callable_info_get_arg,
  _dart_callable_info_is_method,
  _dart_callable_info_get_caller_owns,
  _dart_callable_info_can_throw_gerror,
  _dart_callable_info_get_return_type,
  _dart_v_func_info_get_address,
  _dart_v_func_info_new_invoker_for_address
};

const VFuncInfoKlass gi_callable_info_v_func_info = {
  _gi_base_info_interface_info_copy,
  _gi_base_info_interface_info_free,
  _gi_base_info_interface_info_get_name,
  _gi_base_info_interface_info_get_type,
  _gi_base_info_interface_info_get_namespace,
  _gi_callable_info_callable_info_prepare_closure,
  _gi_callable_info_callable_info_free_closure,
  _gi_callable_info_callable_info_get_n_args,
  _gi_callable_info_callable_info_get_arg,
  _gi_callable_info_callable_info_is_method,
  _gi_callable_info_callable_info_get_caller_owns,
  _gi_callable_info_callable_info_can_throw_gerror,
  _gi_callable_info_callable_info_get_return_type,
  _null_v_func_info_get_address,
  _null_v_func_info_new_invoker_for_address
};

const VFuncInfoKlass gi_base_info_v_func_info = {
  _gi_base_info_interface_info_copy,
  _gi_base_info_interface_info_free,
  _gi_base_info_interface_info_get_name,
  _gi_base_info_interface_info_get_type,
  _gi_base_info_interface_info_get_namespace,
  _null_callable_info_prepare_closure,
  _null_callable_info_free_closure,
  _null_callable_info_get_n_args,
  _null_callable_info_get_arg,
  _null_callable_info_is_method,
  _null_callable_info_get_caller_owns,
  _null_callable_info_can_throw_gerror,
  _null_callable_info_get_return_type,
  _null_v_func_info_get_address,
  _null_v_func_info_new_invoker_for_address
};

const VFuncInfoKlass null_v_func_info = {
  _null_interface_info_copy,
  _null_interface_info_free,
  _null_interface_info_get_name,
  _null_interface_info_get_type,
  _null_interface_info_get_namespace,
  _null_callable_info_prepare_closure,
  _null_callable_info_free_closure,
  _null_callable_info_get_n_args,
  _null_callable_info_get_arg,
  _null_callable_info_is_method,
  _null_callable_info_get_caller_owns,
  _null_callable_info_can_throw_gerror,
  _null_callable_info_get_return_type,
  _null_v_func_info_get_address,
  _null_v_func_info_new_invoker_for_address
};

const InterfaceInfoKlass gi_base_info_interface_info = {
  _gi_base_info_interface_info_copy,
  _gi_base_info_interface_info_free,
  _gi_base_info_interface_info_get_name,
  _gi_base_info_interface_info_get_type,
  _gi_base_info_interface_info_get_namespace,
  _gi_base_info_interface_info_cast_interface_to_callable_info,
  _gi_base_info_interface_info_cast_interface_to_enum_info,
  _gi_base_info_interface_info_cast_interface_to_registered_type_info,
  _gi_base_info_interface_info_cast_interface_to_struct_union_info
};

const InterfaceInfoKlass null_interface_info = {
  _null_interface_info_copy,
  _null_interface_info_free,
  _null_interface_info_get_name,
  _null_interface_info_get_type,
  _null_interface_info_get_namespace,
  _null_interface_info_cast_interface_to_callable_info,
  _null_interface_info_cast_interface_to_enum_info,
  _null_interface_info_cast_interface_to_registered_info,
  _null_interface_info_cast_interface_to_struct_union_info
};

const InterfaceInfoKlass dart_interface_info = {
  _dart_interface_info_copy,
  _dart_interface_info_free,
  _dart_interface_info_get_name,
  _dart_interface_info_get_type,
  _dart_interface_info_get_namespace,
  _dart_interface_info_cast_interface_to_callable_info,
  _dart_interface_info_cast_interface_to_enum_info,
  _dart_interface_info_cast_interface_to_registered_type_info,
  _dart_interface_info_cast_interface_to_struct_union_info
};


const TypeInfoKlass gi_type_info_type_info = {
  _gi_base_info_interface_info_copy,
  _gi_base_info_interface_info_free,
  _gi_base_info_interface_info_get_name,
  _gi_base_info_interface_info_get_type,
  _gi_base_info_interface_info_get_namespace,
  _gi_type_info_type_get_tag,
  _gi_type_info_type_get_interface,
  _gi_type_info_type_get_array_length,
  _gi_type_info_type_is_zero_terminated,
  _gi_type_info_type_get_array_fixed_size,
  _gi_type_info_type_get_param_type
};

const TypeInfoKlass null_type_info = {
  _null_interface_info_copy,
  _null_interface_info_free,
  _null_interface_info_get_name,
  _null_interface_info_get_type,
  _null_interface_info_get_namespace,
  _null_type_get_tag,
  _null_type_get_interface,
  _null_type_get_array_length,
  _null_type_is_zero_terminated,
  _null_type_get_array_fixed_size,
  _null_type_get_param_type
};

const TypeInfoKlass dart_type_info = {
  _dart_interface_info_copy,
  _dart_interface_info_free,
  _dart_interface_info_get_name,
  _dart_interface_info_get_type,
  _dart_interface_info_get_namespace,
  _dart_type_get_tag,
  _dart_type_get_interface,
  _dart_type_get_array_length,
  _dart_type_is_zero_terminated,
  _dart_type_get_array_fixed_size,
  _dart_type_get_param_type
};

const ArgInfoKlass gi_arg_info_arg_info = {
  _gi_base_info_interface_info_copy,
  _gi_base_info_interface_info_free,
  _gi_base_info_interface_info_get_name,
  _gi_base_info_interface_info_get_type,
  _gi_base_info_interface_info_get_namespace,
  _gi_arg_info_arg_info_get_closure,
  _gi_arg_info_arg_info_get_destroy,
  _gi_arg_info_arg_info_get_direction,
  _gi_arg_info_arg_info_get_scope,
  _gi_arg_info_arg_info_get_type,
  _gi_arg_info_arg_info_get_ownership_transfer,
  _gi_arg_info_arg_info_is_caller_allocates
};

const ArgInfoKlass dart_arg_info = {
  _dart_interface_info_copy,
  _dart_interface_info_free,
  _dart_interface_info_get_name,
  _dart_interface_info_get_type,
  _dart_interface_info_get_namespace,
  _dart_arg_info_get_closure,
  _dart_arg_info_get_destroy,
  _dart_arg_info_get_direction,
  _dart_arg_info_get_scope,
  _dart_arg_info_get_type,
  _dart_arg_info_get_ownership_transfer,
  _dart_arg_info_is_caller_allocates
};

const ArgInfoKlass null_arg_info = {
  _null_interface_info_copy,
  _null_interface_info_free,
  _null_interface_info_get_name,
  _null_interface_info_get_type,
  _null_interface_info_get_namespace,
  _null_arg_info_get_closure,
  _null_arg_info_get_destroy,
  _null_arg_info_get_direction,
  _null_arg_info_get_scope,
  _null_arg_info_get_type,
  _null_arg_info_get_ownership_transfer,
  _null_arg_info_is_caller_allocates
};

const FieldInfoKlass gi_field_info_field_info = {
  _gi_base_info_interface_info_copy,
  _gi_base_info_interface_info_free,
  _gi_base_info_interface_info_get_name,
  _gi_base_info_interface_info_get_type,
  _gi_base_info_interface_info_get_namespace,
  _gi_field_info_field_info_get_offset,
  _gi_field_info_field_info_get_size,
  _gi_field_info_field_info_get_type,
};

const FieldInfoKlass dart_field_info = {
  _dart_interface_info_copy,
  _dart_interface_info_free,
  _dart_interface_info_get_name,
  _dart_interface_info_get_type,
  _dart_interface_info_get_namespace,
  _dart_field_info_get_offset,
  _dart_field_info_get_size,
  _dart_field_info_get_type,
};