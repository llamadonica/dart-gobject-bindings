// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
//

#include "array.h"
#include "function.h"
#include "common.h"
#include "object_wrapper.h"
#include "bridge_context.h"
#include "introspection_interface.h"
#include "include/dart_api.h"

//gint gi_count = 0;

static gchar *_gi_base_info_print_name (GIBaseInfo *base_info)
{
  gchar *current_name, *previous_name;
  GIBaseInfo *parent;
  current_name = g_strdup (g_base_info_get_name (base_info));
  parent = g_base_info_get_container (base_info);
  while (parent != NULL) {
    previous_name = current_name;

    current_name = g_strdup_printf ("%s.%s", g_base_info_get_name (parent), 
previous_name);
    parent = g_base_info_get_container (parent);

    g_free (previous_name);
  }
  previous_name = current_name;
  current_name = g_strdup_printf ("%s.%s", g_base_info_get_namespace 
(base_info), previous_name);
  g_free (previous_name);
  return current_name;
}

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
  temp_value = Dart_StringToUTF8 (field_value, &string_raw, &string_raw_length);
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

  if (!Dart_IsString (field_value)) {
    gdart_bridge_context_create_error_handle (self,
        "%s: value was not a String", G_STRFUNC);
    g_set_error (error, GDART_ERROR, 1, "%s: value was not a String", 
G_STRFUNC);
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
  gboolean is_of_type;

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
				  (bool*) &is_of_type);
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
    *result_out = result_base_info;
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
  Dart_Handle dart_object, function_name, field_value, index_storage;

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

static gboolean _gi_callable_info_callable_info_free_closure (gpointer object,
    GdartBridgeContext *self,
    ffi_closure *closure,
    Dart_Handle *dart_error_out,
    GError **error)
{
  g_callable_info_free_closure ( (GICallableInfo *) object, closure);
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
  gboolean raw_result;

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

  temp_value = Dart_BooleanValue (field_value, (bool*) &raw_result);
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

static gboolean _gi_function_info_function_info_prep_invoker (gpointer object,
    GdartBridgeContext *self,
    GIFunctionInvoker *invoker,
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
  return TRUE;
}

static gboolean _null_function_info_prep_invoker (gpointer object,
    GdartBridgeContext *self,
    GIFunctionInvoker *invoker,
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
  return TRUE;
}

static gboolean _null_v_func_info_get_address (gpointer object,
    GdartBridgeContext *self,
    GType type,
    gpointer *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object, self, "get_address", dart_error_out, 
error);
}

static gboolean _gi_object_info_object_info_get_ref_function_pointer (gpointer 
object,
    GdartBridgeContext *self,
    GIObjectInfoRefFunction *result_out,
    Dart_Handle *dart_error,
    GError **error)
{
  *result_out = g_object_info_get_ref_function_pointer (object);
  return TRUE;
}


static gboolean _gi_object_info_object_info_get_unref_function_pointer (gpointer 
object,
    GdartBridgeContext *self,
    GIObjectInfoUnrefFunction *result_out,
    Dart_Handle *dart_error,
    GError **error)
{
  *result_out = g_object_info_get_unref_function_pointer (object);
  return TRUE;
}

static gboolean _null_object_info_get_ref_function_pointer (gpointer object,
    GdartBridgeContext *self,
    GIObjectInfoRefFunction *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object, self, "get_ref_function_pointer", 
dart_error_out, error);
}

static gboolean _null_object_info_get_unref_function_pointer (gpointer object,
    GdartBridgeContext *self,
    GIObjectInfoUnrefFunction *result_out,
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

static gboolean _null_struct_union_info_get_size (gpointer object,
    GdartBridgeContext *self,
    gsize *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  return _null_no_such_method (object, self, "get_size", dart_error_out, error);
}

const RegisteredTypeInfoKlass gi_registered_type_info_registered_type_info = {
  _gi_base_info_interface_info_copy,
  _gi_base_info_interface_info_free,
  _gi_base_info_interface_info_get_name,
  _gi_base_info_interface_info_get_type,
  _gi_base_info_interface_info_get_namespace,
  _gi_registered_type_info_registered_type_info_get_gtype,
  _gi_registered_type_info_registered_type_info_get_hash_code,
  _gi_registered_type_info_registered_type_info_equals,
  _gi_base_info_interface_info_cast_interface_to_object_info
};

const RegisteredTypeInfoKlass gi_base_info_registered_type_info = {
  _gi_base_info_interface_info_copy,
  _gi_base_info_interface_info_free,
  _gi_base_info_interface_info_get_name,
  _gi_base_info_interface_info_get_type,
  _gi_base_info_interface_info_get_namespace,
  _null_registered_type_info_get_gtype,
  _gi_registered_type_info_registered_type_info_get_hash_code,
  _gi_registered_type_info_registered_type_info_equals,
  _gi_base_info_interface_info_cast_interface_to_object_info
};

const RegisteredTypeInfoKlass null_registerd_type_info = {
  _null_interface_info_copy,
  _null_interface_info_free,
  _null_interface_info_get_name,
  _null_interface_info_get_type,
  _null_interface_info_get_namespace,
  _null_registered_type_info_get_gtype,
  _null_registered_type_info_get_hash_code,
  _null_registered_type_info_equals,
  _null_interface_info_cast_interface_to_object_info
};

const ObjectInfoKlass gi_object_info_object_info = {
  _gi_base_info_interface_info_copy,
  _gi_base_info_interface_info_free,
  _gi_base_info_interface_info_get_name,
  _gi_base_info_interface_info_get_type,
  _gi_base_info_interface_info_get_namespace,
  _gi_registered_type_info_registered_type_info_get_gtype,
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
  _null_object_info_get_ref_function_pointer,
  _null_object_info_get_unref_function_pointer
};

const StructUnionInfoKlass gi_union_info_struct_union_info = {
  _gi_base_info_interface_info_copy,
  _gi_base_info_interface_info_free,
  _gi_base_info_interface_info_get_name,
  _gi_base_info_interface_info_get_type,
  _gi_base_info_interface_info_get_namespace,
  _gi_registered_type_info_registered_type_info_get_gtype,
  _gi_union_info_struct_union_info_get_size
};

const StructUnionInfoKlass gi_struct_info_struct_union_info = {
  _gi_base_info_interface_info_copy,
  _gi_base_info_interface_info_free,
  _gi_base_info_interface_info_get_name,
  _gi_base_info_interface_info_get_type,
  _gi_base_info_interface_info_get_namespace,
  _gi_registered_type_info_registered_type_info_get_gtype,
  _gi_struct_info_struct_union_info_get_size
};

const StructUnionInfoKlass gi_registered_type_info_struct_union_info = {
  _gi_base_info_interface_info_copy,
  _gi_base_info_interface_info_free,
  _gi_base_info_interface_info_get_name,
  _gi_base_info_interface_info_get_type,
  _gi_base_info_interface_info_get_namespace,
  _gi_registered_type_info_registered_type_info_get_gtype,
  _null_struct_union_info_get_size
};

const StructUnionInfoKlass gi_base_info_struct_union_info = {
  _gi_base_info_interface_info_copy,
  _gi_base_info_interface_info_free,
  _gi_base_info_interface_info_get_name,
  _gi_base_info_interface_info_get_type,
  _gi_base_info_interface_info_get_namespace,
  _null_registered_type_info_get_gtype,
  _null_struct_union_info_get_size
};

const StructUnionInfoKlass null_struct_union_info = {
  _null_interface_info_copy,
  _null_interface_info_free,
  _null_interface_info_get_name,
  _null_interface_info_get_type,
  _null_interface_info_get_namespace,
  _null_registered_type_info_get_gtype,
  _null_struct_union_info_get_size
};

const EnumInfoKlass gi_enum_info_enum_info = {
  _gi_base_info_interface_info_copy,
  _gi_base_info_interface_info_free,
  _gi_base_info_interface_info_get_name,
  _gi_base_info_interface_info_get_type,
  _gi_base_info_interface_info_get_namespace,
  _gi_registered_type_info_registered_type_info_get_gtype,
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
  _null_enum_info_get_storage_type,
  _null_interface_info_cast_interface_to_registered_info,
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
  _gi_v_func_info_v_func_info_get_address
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
  _null_v_func_info_get_address
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
  _null_v_func_info_get_address
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
  _null_v_func_info_get_address
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
