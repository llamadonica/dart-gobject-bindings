// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
//

#include "g_property.h"

#include "array.h"
#include "common.h"
#include "object_wrapper.h"
#include "bridge_context.h"

struct _GdartGPropertyArrayRecord {
  gint array_length;
  gpointer array_buffer;
};

gboolean _gdart_g_property_fill_boolean(
  GdartBridgeContext *self,
  const gchar* name_prefix,
  Dart_Handle dart_value,
  GValue *value,
  Dart_Handle *dart_error_out,
  GError **error)
{
  bool result;
  Dart_Handle temp_result;
  temp_result = Dart_BooleanValue(dart_value, &result);
  if (Dart_IsError(temp_result)) {
    *dart_error_out = temp_result;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return FALSE;
  }
  g_value_init(value, G_TYPE_BOOLEAN);
  g_value_set_boolean(value, result);
  return TRUE;
}

gboolean _gdart_g_property_fill_int_raw(
  GdartBridgeContext *self,
  const gchar* name_prefix,
  gint64 raw_result,
  guint64 uraw_value,
  GValue *value,
  GITypeTag type_tag,
  Dart_Handle *dart_error_out,
  GError **error)
{
  switch (type_tag) {
  case GI_TYPE_TAG_INT8:
    if (raw_result > G_MAXINT8 || raw_result < G_MININT8) {
      g_warning("%s: Integer was out of bounds. Result will be clamped.",
                name_prefix);
      raw_result = CLAMP(raw_result, G_MININT8, G_MAXINT8);
    }
    g_value_init(value, G_TYPE_CHAR);
    g_value_set_schar(value, raw_result);
    break;
  case GI_TYPE_TAG_UINT8:
    if (raw_result > G_MAXUINT8 || raw_result < 0) {
      g_warning("%s: Integer was out of bounds. Result will be clamped.",
                name_prefix);
      raw_result = CLAMP(raw_result, 0, G_MAXUINT8);
    }
    g_value_init(value, G_TYPE_UCHAR);
    g_value_set_uchar(value, raw_result);
    break;
  case GI_TYPE_TAG_INT16:
    if (raw_result > G_MAXINT16 || raw_result < G_MININT16) {
      g_warning("%s: Integer was out of bounds. Result will be clamped.",
                name_prefix);
      raw_result = CLAMP(raw_result, G_MININT16, G_MAXINT16);
    }
    g_value_init(value, G_TYPE_INT);
    g_value_set_int(value, raw_result);
    break;
  case GI_TYPE_TAG_UINT16:
    if (raw_result > G_MAXUINT16 || raw_result < 0) {
      g_warning("%s: Integer was out of bounds. Result will be clamped.",
                name_prefix);
      raw_result = CLAMP(raw_result, 0, G_MAXUINT16);
    }
    g_value_init(value, G_TYPE_UINT);
    g_value_set_uint(value, raw_result);
    break;
  case GI_TYPE_TAG_INT32:
    if (raw_result > G_MAXINT32 || raw_result < G_MININT32) {
      g_warning("%s: Integer was out of bounds. Result will be clamped.",
                name_prefix);
      raw_result = CLAMP(raw_result, G_MININT32, G_MAXINT32);
    }
    g_value_init(value, G_TYPE_INT);
    g_value_set_int(value, raw_result);
    break;
  case GI_TYPE_TAG_UINT32:
    if (raw_result > G_MAXUINT32 || raw_result < 0) {
      g_warning("%s: Integer was out of bounds. Result will be clamped.",
                name_prefix);
      raw_result = CLAMP(raw_result, 0, G_MAXUINT32);
    }
    g_value_init(value, G_TYPE_UINT);
    g_value_set_uint(value, raw_result);
    break;
  case GI_TYPE_TAG_INT64:
    g_value_init(value, G_TYPE_INT64);
    g_value_set_int64(value, raw_result);
    break;
  case GI_TYPE_TAG_UINT64:
    g_value_init(value, G_TYPE_UINT64);
    g_value_set_uint64(value, uraw_value);
    break;
  case GI_TYPE_TAG_GTYPE:
    g_value_init(value, G_TYPE_GTYPE);
    g_value_set_gtype(value, uraw_value);
    break;
  default:
    *dart_error_out = gdart_bridge_context_create_error_handle(
                        self,
                        "%s: expected an integer-like type", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: expected an integer-like type", G_STRFUNC);
  }
  return TRUE;
}

gboolean _gdart_g_property_fill_int(
  GdartBridgeContext *self,
  const gchar* name_prefix,
  Dart_Handle dart_value,
  GValue *value,
  GITypeTag type_tag,
  Dart_Handle *dart_error_out,
  GError **error)
{
  int64_t raw_result;
  uint64_t raw_result_64;
  Dart_Handle temp_result;
  if (type_tag == GI_TYPE_TAG_UINT64 || type_tag == GI_TYPE_TAG_GTYPE) {
    temp_result = Dart_IntegerToUint64(dart_value, &raw_result_64);
  } else {
    temp_result = Dart_IntegerToInt64(dart_value, &raw_result);
  }
  if (Dart_IsError(temp_result)) {
    *dart_error_out = temp_result;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return FALSE;
  }
  return _gdart_g_property_fill_int_raw(self,
                                        name_prefix,
                                        raw_result,
                                        raw_result_64,
                                        value,
                                        type_tag,
                                        dart_error_out,
                                        error);
}

gboolean _gdart_g_property_fill_num(
  GdartBridgeContext *self,
  const gchar* name_prefix,
  Dart_Handle dart_value,
  GValue *value,
  GITypeTag type_tag,
  Dart_Handle *dart_error_out,
  GError **error)
{
  gdouble result_out;
  Dart_Handle temp_result;

  temp_result = Dart_DoubleValue(dart_value, &result_out);
  if (Dart_IsError(temp_result)) {
    *dart_error_out = temp_result;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return FALSE;
  }
  switch (type_tag) {
  case GI_TYPE_TAG_DOUBLE:
    g_value_init(value, G_TYPE_DOUBLE);
    g_value_set_double(value, result_out);
    break;
  case GI_TYPE_TAG_FLOAT:
    g_value_init(value, G_TYPE_FLOAT);
    g_value_set_float(value, result_out);
    break;
  default:
    *dart_error_out = gdart_bridge_context_create_error_handle(
                        self,
                        "%s: expected an integer-like type", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: expected an integer-like type", G_STRFUNC);
    return FALSE;
  }
  return TRUE;
}

gboolean _gdart_g_property_fill_string(
  GdartBridgeContext *self,
  const gchar* name_prefix,
  Dart_Handle dart_value,
  GValue *value,
  GITypeTag type_tag,
  Dart_Handle *dart_error_out,
  GError **error)
{
  gchar *result_untrimmed, *result_trimmed;
  gintptr result_length;
  Dart_Handle temp_result;

  if (Dart_IsNull(dart_value)) {
    result_trimmed = NULL;
    goto handle_null;
  }
  temp_result = Dart_StringToUTF8(dart_value,
                                  (guint8**) &result_untrimmed,
                                  &result_length);
  if (Dart_IsError(temp_result)) {
    *dart_error_out = temp_result;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return FALSE;
  }
  result_trimmed = g_newa(gchar, result_length + 1);
  memmove(result_trimmed, result_untrimmed, result_length);
  result_trimmed[result_length] = '\0';

  switch (type_tag) {
  case GI_TYPE_TAG_FILENAME: {
    gchar* filename_string, *error_string;
    gsize bytes_read, bytes_written;
    GError* inner_error = NULL;

    filename_string = g_filename_from_utf8(result_trimmed,
                                           -1,
                                           &bytes_read,
                                           &bytes_written,
                                           &inner_error);
    if (inner_error != NULL) {
      error_string = g_strdup_printf("%s: caught an error %s", G_STRFUNC,
                                     inner_error->message);
      *dart_error_out = gdart_bridge_context_create_error_handle(self,
                        "%s",
                        error_string);
      g_propagate_error(error, inner_error);
      return FALSE;
    }
    g_value_init(value, G_TYPE_STRING);
    g_value_set_string(value, filename_string);
    g_free(filename_string);
    break;
  }
handle_null:
  case GI_TYPE_TAG_UTF8:
    g_value_init(value, G_TYPE_STRING);
    g_value_set_string(value, result_trimmed);
    break;
  default:
    *dart_error_out = gdart_bridge_context_create_error_handle(
                        self,
                        "%s: expected an string-like type", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: expected an integer-like type", G_STRFUNC);
    return FALSE;
  }
  return TRUE;
}

gboolean _gdart_g_property_fill_wrapped_pointer(
  GdartBridgeContext *self,
  const gchar* name_prefix,
  const gchar* property_name,
  Dart_Handle dart_value,
  GValue *value,
  GObject *object,
  Dart_Handle *dart_error_out,
  GError **error)
{
  GObjectClass* klass;
  GParamSpec* param_spec;
  GdartBridgeContextWrappedObject* wrapped_object;


  klass = G_OBJECT_CLASS(object);
  param_spec = g_object_class_find_property(klass, property_name);
  g_value_init(value, G_PARAM_SPEC_VALUE_TYPE(param_spec));
  if (Dart_IsNull(dart_value)) {
    g_value_set_boxed(value, NULL);
    return TRUE;
  }
  wrapped_object = gdart_bridge_context_unwrap_object(self,
                   dart_value,
                   dart_error_out,
                   error);
  if (wrapped_object == NULL) return FALSE;
  g_value_set_boxed(value, wrapped_object->object);
  return TRUE;
}

gboolean _gdart_g_property_fill_enum(
  GdartBridgeContext *self,
  const gchar* name_prefix,
  const gchar* property_name,
  Dart_Handle dart_value,
  GValue *value,
  GObject *object,
  GIEnumInfo *enum_info,
  Dart_Handle *dart_error_out,
  GError **error)
{
  GObjectClass* klass;
  GParamSpec* param_spec;
  Dart_Handle inner_container, name_handle, temp_result;
  GITypeTag storage_type;
  gint64 raw_result;
  guint64 uraw_result;

  klass = G_OBJECT_CLASS(object);
  param_spec = g_object_class_find_property(klass, property_name);
  g_value_init(value, G_PARAM_SPEC_VALUE_TYPE(param_spec));


  storage_type = g_enum_info_get_storage_type(enum_info);
  name_handle = Dart_NewStringFromCString("value");
  if (Dart_IsError(name_handle)) {
    *dart_error_out = name_handle;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return FALSE;
  }
  inner_container = Dart_GetField(dart_value, name_handle);
  if (Dart_IsError(inner_container)) {
    *dart_error_out = inner_container;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return FALSE;
  }
  if (storage_type == GI_TYPE_TAG_UINT64 || storage_type == GI_TYPE_TAG_GTYPE) {
    temp_result = Dart_IntegerToUint64(dart_value, &uraw_result);
  } else {
    temp_result = Dart_IntegerToInt64(dart_value, &raw_result);
  }
  if (Dart_IsError(temp_result)) {
    *dart_error_out = temp_result;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return FALSE;
  }
  if (g_type_is_a(G_PARAM_SPEC_VALUE_TYPE(param_spec), G_TYPE_FLAGS)) {
    if (storage_type == GI_TYPE_TAG_UINT64 ||
        storage_type == GI_TYPE_TAG_GTYPE) {
      g_value_set_flags(value, uraw_result);
      return TRUE;
    }
    g_value_set_flags(value, raw_result);
    return TRUE;
  }
  if (storage_type == GI_TYPE_TAG_UINT64 ||
      storage_type == GI_TYPE_TAG_GTYPE) {
    g_value_set_enum(value, uraw_result);
    return TRUE;
  }
  g_value_set_enum(value, raw_result);
  return TRUE;
}

gboolean _gdart_g_property_unfill_array(
  GdartBridgeContext *self,
  GITypeInfo *arg_type,
  gpointer user_data,
  Dart_Handle *dart_error_out,
  GError **error)
{
  gboolean is_null_terminated;
  is_null_terminated = g_type_info_is_zero_terminated(arg_type);
  gpointer buffer;
  GITypeInfo *param_type;
  GdartGPropertyArrayRecord *array_record;
  gint length = 0;

  array_record = (GdartGPropertyArrayRecord*) user_data;
  if (array_record == NULL) {
    return TRUE;
  }
  is_null_terminated = g_type_info_is_zero_terminated(arg_type);
  param_type = g_type_info_get_param_type(arg_type, 0);

  length = g_type_info_get_array_fixed_size(arg_type);
  if (length == -1) {
    length = array_record->array_length;
  }
  buffer = array_record->array_buffer;
  gdart_array_unfill_in_array_parameters(self,
                                         param_type,
                                         length,
                                         is_null_terminated,
                                         buffer);
  g_free(buffer);
  return TRUE;
}

gboolean _gdart_g_property_fill_array(
  GdartBridgeContext *self,
  const gchar* name_prefix,
  const gchar* property_name,
  Dart_Handle dart_value,
  GValue *value,
  GObject *object,
  GITypeInfo *arg_type,
  gpointer *user_data_out,
  Dart_Handle *dart_error_out,
  GError **error)
{
  Dart_Handle temp_result;
  gint fixed_length = 0;
  gboolean is_null_terminated;
  is_null_terminated = g_type_info_is_zero_terminated(arg_type);
  gpointer buffer, buffer_after;
  intptr_t list_length;
  gintptr allocation_length;
  GITypeInfo *param_type;
  GObjectClass *klass;
  GParamSpec *param_spec;
  GdartGPropertyArrayRecord *array_record;

  klass = G_OBJECT_CLASS(object);
  param_spec = g_object_class_find_property(klass, property_name);
  fixed_length = g_type_info_get_array_fixed_size(arg_type);
  if (fixed_length == -1 && !is_null_terminated) {
    *dart_error_out = gdart_bridge_context_create_error_handle(self,
                      "%s: the array did not have a length, a fixed size or a null termination so I can't handle it", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: the array did not have a length, a fixed size or a null termination so I can't handle it", G_STRFUNC);
    goto error;
  }
  if (!Dart_IsList(dart_value) && !Dart_IsNull(dart_value)) {
    *dart_error_out = gdart_bridge_context_create_error_handle(self,
                      "%s: expected string or null", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: expected string or null", G_STRFUNC);
    goto error;
  }
  if (Dart_IsNull(dart_value)) {
    list_length = 0;
  } else {
    temp_result = Dart_ListLength(dart_value, &list_length);
    if (Dart_IsError(temp_result)) {
      *dart_error_out = temp_result;
      g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
      goto error;
    }
  }
  allocation_length = list_length;
  if (is_null_terminated) {
    allocation_length++;
  }
  g_value_init(value, G_PARAM_SPEC_VALUE_TYPE(param_spec));
  if (allocation_length == 0) {
    g_value_set_boxed(value, NULL);
    return TRUE;
  }
  param_type = g_type_info_get_param_type(arg_type, 0);
  buffer = g_malloc(allocation_length * gdart_array_get_size_multiplier(param_type));

  if (!gdart_array_fill_in_parameters(self,
                                      name_prefix,
                                      dart_value,
                                      param_type,
                                      fixed_length,
                                      list_length,
                                      buffer,
                                      &buffer_after,
                                      dart_error_out,
                                      error)) {
    g_base_info_unref((GIBaseInfo*) param_type);
    g_free(buffer);
    return FALSE;
  }
  if (is_null_terminated) {
    if (!gdart_array_zero_element(self,
                                  name_prefix,
                                  param_type,
                                  &buffer_after,
                                  dart_error_out,
                                  error)) {
      g_base_info_unref((GIBaseInfo*) param_type);
      g_free(buffer);
      return FALSE;
    }
  }
  array_record = g_slice_new(GdartGPropertyArrayRecord);
  array_record->array_buffer = buffer;
  array_record->array_length = allocation_length * gdart_array_get_size_multiplier(param_type);
  *user_data_out = array_record;
  g_value_set_boxed(value, buffer);
  return TRUE;
error:
  return FALSE;
}

gboolean _gdart_g_property_fill_object(
  GdartBridgeContext *self,
  const gchar* name_prefix,
  Dart_Handle dart_value,
  GValue *value,
  Dart_Handle *dart_error_out,
  GError **error)
{
  GdartBridgeContextWrappedObject* wrapped_object;
  GObject* object;

  if (Dart_IsNull(dart_value)) {
    object = NULL;
    g_value_init(value, G_TYPE_OBJECT);
    g_value_set_object(value, object);
  } else {
    wrapped_object = gdart_bridge_context_unwrap_object(self,
                     dart_value,
                     dart_error_out,
                     error);
    if (wrapped_object == NULL) return FALSE;
    object = (GObject*) wrapped_object->object;
    g_value_init(value, G_OBJECT_TYPE(object));
    g_value_set_object(value, object);
  }
  return TRUE;
}

gboolean _gdart_g_property_fill_interface(
  GdartBridgeContext *self,
  const gchar* name_prefix,
  const gchar* property_name,
  Dart_Handle dart_value,
  GValue *value,
  GObject *object,
  GIPropertyInfo *property_info,
  GITypeInfo *arg_type,
  Dart_Handle *dart_error_out,
  GError **error)
{
  GIBaseInfo *registered_type_info;
  gboolean result;

  registered_type_info = g_type_info_get_interface(arg_type);
  switch (g_base_info_get_type(registered_type_info)) {
  case GI_INFO_TYPE_CALLBACK:
    result = FALSE;
    *dart_error_out = gdart_bridge_context_create_error_handle(self,
                      "%s: GObject property functions can't handle callbacks.", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: received an unexpected base info type", G_STRFUNC);
    break;
  case GI_INFO_TYPE_OBJECT:
  case GI_INFO_TYPE_INTERFACE:
    result = _gdart_g_property_fill_object(self,
                                           name_prefix,
                                           dart_value,
                                           value,
                                           dart_error_out,
                                           error);
    break;
  case GI_INFO_TYPE_STRUCT:
  case GI_INFO_TYPE_BOXED:
  case GI_INFO_TYPE_UNION:
    result = _gdart_g_property_fill_wrapped_pointer(self,
             name_prefix,
             property_name,
             dart_value,
             value,
             object,
             dart_error_out,
             error);
    break;
  case GI_INFO_TYPE_ENUM:
  case GI_INFO_TYPE_FLAGS:
    result = _gdart_g_property_fill_enum(self,
                                         name_prefix,
                                         property_name,
                                         dart_value,
                                         value,
                                         object,
                                         registered_type_info,
                                         dart_error_out,
                                         error);
    break;
  default:
    *dart_error_out = gdart_bridge_context_create_error_handle(self,
                      "%s: received an unexpected base info type", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: received an unexpected base info type", G_STRFUNC);
    result = FALSE;
  }
  g_base_info_unref(registered_type_info);
  return result;
}


gboolean _gdart_g_property_unfill_value(
  GdartBridgeContext *self,
  GIPropertyInfo *arg_info,
  gpointer user_data,
  Dart_Handle *dart_error_out,
  GError **error)
{
  GITypeInfo *arg_type;
  GITypeTag type_tag;
  gboolean result;

  arg_type = g_property_info_get_type(arg_info);
  type_tag = g_type_info_get_tag(arg_type);
  switch (type_tag) {
  case GI_TYPE_TAG_BOOLEAN:
  case GI_TYPE_TAG_INT8:
  case GI_TYPE_TAG_UINT8:
  case GI_TYPE_TAG_INT16:
  case GI_TYPE_TAG_UINT16:
  case GI_TYPE_TAG_INT32:
  case GI_TYPE_TAG_UINT32:
  case GI_TYPE_TAG_INT64:
  case GI_TYPE_TAG_UINT64:
  case GI_TYPE_TAG_GTYPE:
  case GI_TYPE_TAG_FLOAT:
  case GI_TYPE_TAG_DOUBLE:
  case GI_TYPE_TAG_UTF8:
  case GI_TYPE_TAG_FILENAME:
  case GI_TYPE_TAG_INTERFACE:
  case GI_TYPE_TAG_GLIST:
  case GI_TYPE_TAG_GSLIST:
  case GI_TYPE_TAG_GHASH:
  case GI_TYPE_TAG_ERROR:
    result = TRUE;
    break;
  case GI_TYPE_TAG_ARRAY:
    result = _gdart_g_property_unfill_array(self,
                                            arg_type,
                                            user_data,
                                            dart_error_out,
                                            error);
    break;
  default:
    *dart_error_out = gdart_bridge_context_create_error_handle(self,
                      "%s: got an unexpected type", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: got an unexpected type", G_STRFUNC);
    result = FALSE;
  }
  g_base_info_unref(arg_type);
  return result;
}

gboolean _gdart_g_property_fill_value(
  GdartBridgeContext *self,
  const gchar* property_name,
  const gchar* name_prefix,
  GObject *object,
  Dart_Handle dart_value,
  GIPropertyInfo *arg_info,
  GValue *value,
  gpointer *user_data_out,
  Dart_Handle *dart_error_out,
  GError **error)
{
  GITypeInfo *arg_type;
  GITypeTag type_tag;
  gboolean result;

  arg_type = g_property_info_get_type(arg_info);
  type_tag = g_type_info_get_tag(arg_type);
  switch (type_tag) {
  case GI_TYPE_TAG_BOOLEAN:
    result = _gdart_g_property_fill_boolean(self,
                                            name_prefix,
                                            dart_value,
                                            value,
                                            dart_error_out,
                                            error);
    break;
  case GI_TYPE_TAG_INT8:
  case GI_TYPE_TAG_UINT8:
  case GI_TYPE_TAG_INT16:
  case GI_TYPE_TAG_UINT16:
  case GI_TYPE_TAG_INT32:
  case GI_TYPE_TAG_UINT32:
  case GI_TYPE_TAG_INT64:
  case GI_TYPE_TAG_UINT64:
  case GI_TYPE_TAG_GTYPE:
    result = _gdart_g_property_fill_int(self,
                                        name_prefix,
                                        dart_value,
                                        value,
                                        type_tag,
                                        dart_error_out,
                                        error);
    break;
  case GI_TYPE_TAG_FLOAT:
  case GI_TYPE_TAG_DOUBLE:
    result =  _gdart_g_property_fill_num(self,
                                         name_prefix,
                                         dart_value,
                                         value,
                                         type_tag,
                                         dart_error_out,
                                         error);
    break;
  case GI_TYPE_TAG_UTF8:
  case GI_TYPE_TAG_FILENAME:
    result = _gdart_g_property_fill_string(self,
                                           name_prefix,
                                           dart_value,
                                           value,
                                           type_tag,
                                           dart_error_out,
                                           error);
    break;
  case GI_TYPE_TAG_ARRAY:
    result = _gdart_g_property_fill_array(self,
                                          name_prefix,
                                          property_name,
                                          dart_value,
                                          value,
                                          object,
                                          arg_type,
                                          user_data_out,
                                          dart_error_out,
                                          error);
    break;

  case GI_TYPE_TAG_INTERFACE:
    result = _gdart_g_property_fill_interface(self,
             name_prefix,
             property_name,
             dart_value,
             value,
             object,
             arg_info,
             arg_type,
             dart_error_out,
             error);
    break;
  case GI_TYPE_TAG_GLIST:
  case GI_TYPE_TAG_GSLIST:
  case GI_TYPE_TAG_GHASH:
  case GI_TYPE_TAG_ERROR:
    //TODO: Handle GErrors better.
    result = _gdart_g_property_fill_wrapped_pointer(self,
             name_prefix,
             property_name,
             dart_value,
             value,
             object,
             dart_error_out,
             error);
    break;
  default:
    *dart_error_out = gdart_bridge_context_create_error_handle(self,
                      "%s: got an unexpected type", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: got an unexpected type", G_STRFUNC);
    result = FALSE;
  }
  g_base_info_unref(arg_type);
  return result;
}

gboolean gdart_g_property_set_property(GdartBridgeContext *self,
                                       const gchar* name_prefix,
                                       const gchar* property_name,
                                       GIBaseInfo *base_info,
                                       Dart_Handle dart_receiver,
                                       Dart_Handle dart_value,
                                       Dart_Handle *dart_error_out,
                                       GError **error)
{
  GObject* object;
  Dart_Handle name_handle, inner_container, temp_result;
  RawPointerContainer *raw_pointer;
  GdartBridgeContextWrappedObject* object_info;
  GValue value = G_VALUE_INIT;
  GIInfoType base_info_type;
  GIPropertyInfo *property_info = NULL;
  gboolean result;
  gpointer user_data = NULL;

  base_info_type = g_base_info_get_type(base_info);
  if (base_info_type == GI_INFO_TYPE_OBJECT) {
    int i = 0, q_of_properties;

    q_of_properties = g_object_info_get_n_properties((GIObjectInfo*) base_info);
    for (; i < q_of_properties; i++) {
      GIPropertyInfo *test_property_info;

      test_property_info = g_object_info_get_property((GIObjectInfo*) base_info, i);
      if (g_str_equal(g_base_info_get_name((GIBaseInfo*) test_property_info),
                      property_name)) {
        property_info = test_property_info;
        break;
      }
      g_base_info_unref((GIBaseInfo*) test_property_info);
    }
  } else if (base_info_type == GI_INFO_TYPE_INTERFACE) {
    int i = 0, q_of_properties;

    q_of_properties = g_interface_info_get_n_properties((GIInterfaceInfo*) base_info);
    for (; i < q_of_properties; i++) {
      GIPropertyInfo *test_property_info;

      test_property_info = g_interface_info_get_property((GIInterfaceInfo*) base_info, i);
      if (g_str_equal(g_base_info_get_name((GIBaseInfo*) test_property_info),
                      property_name)) {
        property_info = test_property_info;
        break;
      }
      g_base_info_unref((GIBaseInfo*) test_property_info);
    }
  } else {
    *dart_error_out = gdart_bridge_context_create_error_handle(self,
                      "%s: expected a GIObjectInfo or a GIInterfaceInfo",
                      G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return FALSE;
  }
  if (property_info == NULL) {
    *dart_error_out = gdart_bridge_context_create_error_handle(self,
                      "%s: Could not find the specified property",
                      G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return FALSE;
  }

  if (Dart_IsNull(dart_receiver)) {
    object = NULL;
  } else {
    name_handle = Dart_NewStringFromCString("_internal");
    if (Dart_IsError(name_handle)) {
      *dart_error_out = name_handle;
      g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
      return FALSE;
    }
    inner_container = Dart_GetField(dart_receiver, name_handle);
    if (Dart_IsError(inner_container)) {
      *dart_error_out = inner_container;
      g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
      return FALSE;
    }
    temp_result = Dart_GetNativeInstanceField(inner_container, 0, (intptr_t*) &raw_pointer);
    if (Dart_IsError(temp_result)) {
      *dart_error_out = temp_result;
      g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
      return FALSE;
    }
    object_info = (GdartBridgeContextWrappedObject*) raw_pointer->raw_pointer;
    object = object_info->object;
  }
  result = _gdart_g_property_fill_value(self,
                                        property_name,
                                        name_prefix,
                                        object,
                                        dart_value,
                                        property_info,
                                        &value,
                                        &user_data,
                                        dart_error_out,
                                        error);
  if (result) {
    g_object_set_property(object, property_name, &value);
  }
  _gdart_g_property_unfill_value(self,
                                 property_info,
                                 user_data,
                                 dart_error_out,
                                 error);
  g_base_info_unref((GIBaseInfo*) property_info);
  return result;
}


Dart_Handle _gdart_g_property_take_boolean(
  GdartBridgeContext *self,
  const gchar* name_prefix,
  const GValue *value,
  Dart_Handle *dart_error_out,
  GError **error)
{
  return Dart_NewBoolean(g_value_get_boolean(value));
}

Dart_Handle _gdart_g_property_take_int(
  GdartBridgeContext *self,
  const gchar* name_prefix,
  const GValue *value,
  GITypeTag type_tag,
  Dart_Handle *dart_error_out,
  GError **error)
{
  gint64 result;
  guint64 uresult;
  switch (type_tag) {
  case GI_TYPE_TAG_INT8:
    result = g_value_get_schar(value);
    break;
  case GI_TYPE_TAG_UINT8:
    result = g_value_get_uchar(value);
    break;
  case GI_TYPE_TAG_INT16:
    result = g_value_get_int(value);
    break;
  case GI_TYPE_TAG_UINT16:
    result = g_value_get_uint(value);
    break;
  case GI_TYPE_TAG_INT32:
    result = g_value_get_int(value);
    break;
  case GI_TYPE_TAG_UINT32:
    result = g_value_get_uint(value);
    break;
  case GI_TYPE_TAG_INT64:
    result = g_value_get_int64(value);
    break;
  case GI_TYPE_TAG_UINT64:
    uresult = g_value_get_uint64(value);
    break;
  case GI_TYPE_TAG_GTYPE:
    uresult = g_value_get_gtype(value);
    break;
  default:
    *dart_error_out = gdart_bridge_context_create_error_handle(
                        self,
                        "%s: expected an integer-like type", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: expected an integer-like type", G_STRFUNC);
    return NULL;
  }
  if (type_tag == GI_TYPE_TAG_GTYPE || type_tag == GI_TYPE_TAG_UINT64) {
    return Dart_NewIntegerFromUint64(uresult);
  }
  return Dart_NewInteger(result);
}

Dart_Handle _gdart_g_property_take_num(
  GdartBridgeContext *self,
  const gchar* name_prefix,
  const GValue *value,
  GITypeTag type_tag,
  Dart_Handle *dart_error_out,
  GError **error)
{
  gdouble result;
  switch (type_tag) {
  case GI_TYPE_TAG_FLOAT:
    result = g_value_get_float(value);
    break;
  case GI_TYPE_TAG_DOUBLE:
    result = g_value_get_double(value);
    break;
  default:
    *dart_error_out = gdart_bridge_context_create_error_handle(
                        self,
                        "%s: expected a num-like type", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: expected a num-like type", G_STRFUNC);
    return NULL;
  }
  return Dart_NewDouble(result);
}

Dart_Handle _gdart_g_property_take_string(
  GdartBridgeContext *self,
  const gchar* name_prefix,
  const GValue *value,
  GITypeTag type_tag,
  Dart_Handle *dart_error_out,
  GError **error)
{
  Dart_Handle dart_result;
  const gchar* result_const;
  gchar* result;
  gintptr result_length;
  gsize bytes_read, bytes_written;
  GError* inner_error = NULL;

  result_const = g_value_get_string(value);

  switch (type_tag) {
  case GI_TYPE_TAG_FILENAME:
    result = g_filename_to_utf8(result_const,
                                -1,
                                &bytes_read,
                                &bytes_written,
                                &inner_error);
    if (inner_error != NULL) {
      gchar* error_string;
      error_string = g_strdup_printf("%s: caught an error %s", G_STRFUNC,
                                     inner_error->message);
      *dart_error_out = gdart_bridge_context_create_error_handle(self,
                        "%s",
                        error_string);
      g_propagate_error(error, inner_error);
      dart_result = NULL;
      g_free(error_string);
    } else {
      result_length = g_utf8_strlen(result_const, -1);
      dart_result = Dart_NewStringFromUTF8((guchar*) result_const, result_length);
      g_free(result);
    }
    break;
  case GI_TYPE_TAG_UTF8:
    result_length = g_utf8_strlen(result_const, -1);
    dart_result = Dart_NewStringFromUTF8((guchar*) result_const, result_length);
    break;
  default:
    *dart_error_out = gdart_bridge_context_create_error_handle(
                        self,
                        "%s: expected a string-like type", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: expected a string-like type", G_STRFUNC);
    return NULL;
  }
  return dart_result;
}

Dart_Handle _gdart_g_property_take_array(
  GdartBridgeContext *self,
  const gchar* name_prefix,
  const GValue *value,
  GITypeInfo *type_info,
  Dart_Handle *dart_error_out,
  GError **error)
{
  gpointer result;

  result = g_value_get_boxed(value);

  gboolean is_null_terminated = FALSE;
  gint64 length;
  gint length_parameter;
  GITypeInfo *param_type;
  Dart_Handle dart_result;

  length_parameter = g_type_info_get_array_length(type_info);

  if (g_type_info_is_zero_terminated(type_info)) {
    length = -1;
    is_null_terminated = TRUE;
  } else {
    length = g_type_info_get_array_fixed_size(type_info);
    if (length == -1) {
      return NULL;
    }
  }
  param_type = g_type_info_get_param_type(type_info, 0);
  if (!gdart_array_load_parameters(self,
                                   name_prefix,
                                   param_type,
                                   length,
                                   is_null_terminated,
                                   FALSE,
                                   result,
                                   &dart_result,
                                   dart_error_out,
                                   error)) {
    dart_result = NULL;
  }
  g_base_info_unref((GIBaseInfo*) param_type);
  return dart_result;
}

Dart_Handle _gdart_g_property_take_wrapped_pointer(
  GdartBridgeContext* self,
  const gchar* name_prefix,
  GIRegisteredTypeInfo *registered_type_info,
  const GValue *value,
  GIInfoType info_type,
  Dart_Handle *dart_error_out,
  GError **error)
{
  const gchar* namespace;
  GType gtype;
  gpointer raw_result;
  GdartBridgeContextWrappedObject* object_wrapper;
  Dart_Handle internal_container;
  GIRegisteredTypeInfo *type_info = NULL;

  raw_result = g_value_get_boxed(value);
  if (raw_result == NULL) {
    return Dart_Null();
  }

  object_wrapper = g_slice_new(GdartBridgeContextWrappedObject);
  gtype = g_registered_type_info_get_g_type(registered_type_info);

  if ((info_type == GI_INFO_TYPE_OBJECT && g_type_is_a(gtype, G_TYPE_OBJECT))
      || info_type == GI_INFO_TYPE_INTERFACE) {
    GObject* object = (GObject*) raw_result;

    gtype = G_OBJECT_TYPE(object);
    type_info = (GIRegisteredTypeInfo*) g_irepository_find_by_gtype(
                  gdart_bridge_context_get_gi_repository(self),
                  gtype);
  }

  object_wrapper->type = gtype;
  if (type_info == NULL) {
    object_wrapper->object_info = g_base_info_ref((GIBaseInfo*) registered_type_info);
  } else {
    object_wrapper->object_info = type_info;
    registered_type_info = type_info;
  }

  switch (info_type) {
  case GI_INFO_TYPE_UNION:
  case GI_INFO_TYPE_STRUCT:
    object_wrapper->copy_func = (GBoxedCopyFunc)
                                gdart_bridge_context_retrieve_copy_func(self,
                                    g_base_info_get_namespace((GIBaseInfo*) registered_type_info),
                                    (GIBaseInfo*) registered_type_info,
                                    gtype);
    object_wrapper->free_func = (GBoxedFreeFunc)
                                gdart_bridge_context_retrieve_free_func(self,
                                    g_base_info_get_namespace((GIBaseInfo*) object_wrapper->object_info),
                                    (GIBaseInfo*) registered_type_info,
                                    gtype);
    if (object_wrapper->copy_func == NULL) {
      g_warning("%s: The GI type of an object to be bound was an [unowned %s."
                "%s] but there's no registered copy function. "
                "This can be unsafe if the object is used after it has "
                "been invalidated by external code.",
                name_prefix,
                g_base_info_get_namespace(registered_type_info),
                g_base_info_get_name(registered_type_info));
      object_wrapper->object = raw_result;
      internal_container = gdart_bridge_context_wrap_pointer(self,
                           object_wrapper,
                           gdart_bridge_context_finalize_wrapped_unowned_struct,
                           dart_error_out,
                           error);
    } else {
      object_wrapper->object = object_wrapper->copy_func(raw_result);
      internal_container = gdart_bridge_context_wrap_pointer(self,
                           object_wrapper,
                           gdart_bridge_context_finalize_wrapped_custom_struct,
                           dart_error_out,
                           error);
    }
    break;
  case GI_INFO_TYPE_BOXED:
    raw_result = g_boxed_copy(gtype, raw_result);
    object_wrapper->object = raw_result;
    internal_container = gdart_bridge_context_wrap_pointer(self,
                         object_wrapper,
                         gdart_bridge_context_finalize_wrapped_boxed,
                         dart_error_out,
                         error);
    break;
  case GI_INFO_TYPE_OBJECT:
  case GI_INFO_TYPE_INTERFACE: {
    GIObjectInfoRefFunction refer;
    refer = g_object_info_get_ref_function_pointer((GIObjectInfo*) object_wrapper->object_info);
    if (refer != NULL) {
      raw_result = refer(raw_result);
    } else {
      raw_result = g_object_ref(raw_result);
    }
  }
  object_wrapper->object = raw_result;
  internal_container = gdart_bridge_context_wrap_pointer(self,
                       object_wrapper,
                       gdart_bridge_context_finalize_wrapped_gobject,
                       dart_error_out,
                       error);
  break;
  default:
    g_assert_not_reached();
  }
  if (internal_container == NULL) {
    return NULL;
  }
  namespace = g_base_info_get_namespace((GIBaseInfo*) registered_type_info);
  return gdart_bridge_context_wrap_internal_pointer(self,
         internal_container,
         namespace,
         gtype,
         (GIBaseInfo*) registered_type_info,
         dart_error_out,
         error);
}

Dart_Handle _gdart_g_property_take_enum(
  GdartBridgeContext *self,
  const gchar* name_prefix,
  const GValue *value,
  GIEnumInfo* base_info,
  Dart_Handle *dart_error_out,
  GError **error)
{

  GITypeTag type_tag;
  Dart_Handle dart_value, wrapper, result;

  type_tag = g_enum_info_get_storage_type(base_info);
  dart_value = _gdart_g_property_take_int(self,
				  name_prefix,
				  value,
				  type_tag,
				  dart_error_out,
                                  error);
  if (dart_value == NULL) {
    return NULL;
  }
  wrapper = gdart_bridge_context_retrieve_wrapping_class(
              self,
              g_base_info_get_namespace((GIBaseInfo*) base_info),
              g_registered_type_info_get_g_type((GIRegisteredTypeInfo*) base_info),
              base_info,
              TRUE,
              dart_error_out,
              error);
  if (wrapper == NULL) return NULL;
  result = Dart_New(wrapper, Dart_Null(), 1, &dart_value);
  if (Dart_IsError(result)) {
    g_warning("%s: dart threw an error", name_prefix);
    *dart_error_out = result;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return NULL;
  }
  return result;
}

Dart_Handle _gdart_g_property_take_interface(
  GdartBridgeContext *self,
  const gchar* name_prefix,
  const GValue *value,
  GITypeInfo *type_info,
  Dart_Handle *dart_error_out,
  GError **error)
{
  GIBaseInfo* base_info;
  GIInfoType info_type;
  Dart_Handle result;

  base_info = g_type_info_get_interface(type_info); //heap allocated
  info_type = g_base_info_get_type(base_info);
  switch (info_type) {
  case GI_INFO_TYPE_CALLBACK:
    //TODO: handle callbacks.
    *dart_error_out = gdart_bridge_context_create_error_handle(self,
                      "%s: can't handle callbacks yet", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: can't handle callbacks yet", G_STRFUNC);
    result = NULL;
    break;
  case GI_INFO_TYPE_STRUCT:
  case GI_INFO_TYPE_BOXED:
  case GI_INFO_TYPE_UNION:
  case GI_INFO_TYPE_INTERFACE:
  case GI_INFO_TYPE_OBJECT:
    result = _gdart_g_property_take_wrapped_pointer(self,
             name_prefix,
             (GIRegisteredTypeInfo *) base_info,
             value,
             info_type,
             dart_error_out,
             error);
    break;
  case GI_INFO_TYPE_ENUM:
  case GI_INFO_TYPE_FLAGS:
    result = _gdart_g_property_take_enum(self,
                                         name_prefix,
                                         value,
                                         (GIEnumInfo *) base_info,
                                         dart_error_out,
                                         error);
    break;
  default:
    *dart_error_out = gdart_bridge_context_create_error_handle(self,
                      "%s: received an unexpected base info type", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: received an unexpected base info type", G_STRFUNC);
    result = NULL;
    break;
  }
  g_base_info_unref(base_info);
  return result;
}



Dart_Handle _gdart_g_property_take_value(
  GdartBridgeContext *self,
  const gchar* name_prefix,
  GIPropertyInfo *arg_info,
  const GValue *value,
  Dart_Handle *dart_error_out,
  GError **error)
{
  GITypeInfo *arg_type;
  GITypeTag type_tag;
  Dart_Handle result;
  GIRegisteredTypeInfo *type_info = NULL;
  GError *inner_error = NULL;

  arg_type = g_property_info_get_type(arg_info);
  type_tag = g_type_info_get_tag(arg_type);
  switch (type_tag) {
  case GI_TYPE_TAG_BOOLEAN:
    result = _gdart_g_property_take_boolean(self,
                                            name_prefix,
                                            value,
                                            dart_error_out,
                                            error);
    break;
  case GI_TYPE_TAG_INT8:
  case GI_TYPE_TAG_UINT8:
  case GI_TYPE_TAG_INT16:
  case GI_TYPE_TAG_UINT16:
  case GI_TYPE_TAG_INT32:
  case GI_TYPE_TAG_UINT32:
  case GI_TYPE_TAG_INT64:
  case GI_TYPE_TAG_UINT64:
  case GI_TYPE_TAG_GTYPE:
    result = _gdart_g_property_take_int(self,
                                        name_prefix,
                                        value,
                                        type_tag,
                                        dart_error_out,
                                        error);
    break;
  case GI_TYPE_TAG_FLOAT:
  case GI_TYPE_TAG_DOUBLE:
    result =  _gdart_g_property_take_num(self,
                                         name_prefix,
                                         value,
                                         type_tag,
                                         dart_error_out,
                                         error);
    break;
  case GI_TYPE_TAG_UTF8:
  case GI_TYPE_TAG_FILENAME:
    result = _gdart_g_property_take_string(self,
                                           name_prefix,
                                           value,
                                           type_tag,
                                           dart_error_out,
                                           error);
    break;
  case GI_TYPE_TAG_ARRAY:
    result = _gdart_g_property_take_array(self,
                                          name_prefix,
                                          value,
                                          arg_type,
                                          dart_error_out,
                                          error);
    break;
  case GI_TYPE_TAG_INTERFACE:
    result = _gdart_g_property_take_interface(self,
                                              name_prefix,
					      value,
					      arg_info,
					      dart_error_out,
					      error);
    break;
  case GI_TYPE_TAG_GLIST:
    if (type_info == NULL && inner_error == NULL) {
      g_irepository_require(gdart_bridge_context_get_gi_repository(self),
			    "GLib",
			    NULL,
			    0,
			    &inner_error);
      if (inner_error == NULL) {
        type_info = g_irepository_find_by_name(gdart_bridge_context_get_gi_repository(self),
	  				     "GLib",
					     "List");
      }
    }
  case GI_TYPE_TAG_GSLIST:
    if (type_info == NULL && inner_error == NULL) {
      g_irepository_require(gdart_bridge_context_get_gi_repository(self),
			    "GLib",
			    NULL,
			    0,
			    &inner_error);
      if (inner_error == NULL) {
        type_info = g_irepository_find_by_name(gdart_bridge_context_get_gi_repository(self),
	  				     "GLib",
					     "SList");
      }
    }
  case GI_TYPE_TAG_GHASH:
    if (type_info == NULL && inner_error == NULL) {
      g_irepository_require(gdart_bridge_context_get_gi_repository(self),
			    "GLib",
			    NULL,
			    0,
			    &inner_error);
      if (inner_error == NULL) {
        type_info = g_irepository_find_by_name(gdart_bridge_context_get_gi_repository(self),
	  				     "GLib",
					     "HashTable");
      }
    }
  case GI_TYPE_TAG_ERROR:
    if (type_info == NULL && inner_error == NULL) {
      g_irepository_require(gdart_bridge_context_get_gi_repository(self),
			    "GLib",
			    NULL,
			    0,
			    &inner_error);
      if (inner_error == NULL) {
        type_info = g_irepository_find_by_name(gdart_bridge_context_get_gi_repository(self),
	  				     "GLib",
					     "List");
      }
    }
    if (inner_error != NULL) {
      gchar* error_string;

      error_string = g_strdup_printf("%s: caught an error %s", G_STRFUNC,
                                     inner_error->message);
      *dart_error_out = gdart_bridge_context_create_error_handle(self,
                        "%s",
                        error_string);
      g_propagate_error(error, inner_error);
      result = NULL;
    } else if (type_info == NULL) {
      *dart_error_out = gdart_bridge_context_create_error_handle(self,
                      "%s: couldn't find a critical type", G_STRFUNC);
      g_set_error(error, GDART_ERROR, 1,
                "%s: couldn't find a critical type", G_STRFUNC);
      result = NULL;
    } else {
      result = _gdart_g_property_take_wrapped_pointer(self,
	  					    name_prefix,
						    type_info,
						    value,
						    g_base_info_get_type(type_info),
						    dart_error_out,
						    error);
    }
    break;
  default:
    *dart_error_out = gdart_bridge_context_create_error_handle(self,
                      "%s: got an unexpected type", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: got an unexpected type", G_STRFUNC);
    result = NULL;
  }
  g_base_info_unref(arg_type);
  return result;
}

gboolean gdart_g_property_get_property(GdartBridgeContext * self,
                                       const gchar * name_prefix,
                                       const gchar * property_name,
                                       GIObjectInfo * base_info,
                                       Dart_Handle dart_receiver,
                                       Dart_Handle * dart_result_out,
                                       Dart_Handle * dart_error_out,
                                       GError **error)
{
  GObject* object;
  GObjectClass* klass;
  GParamSpec* param_spec;
  GdartBridgeContextWrappedObject* wrapped_object;
  Dart_Handle name_handle, inner_container, temp_result;
  RawPointerContainer* raw_pointer;
  GValue value = G_VALUE_INIT;
  GIPropertyInfo* property_info = NULL;
  GIInfoType base_info_type;
  gboolean result = TRUE;

  if (Dart_IsNull(dart_receiver)) {
    object = NULL;
  } else {
    name_handle = Dart_NewStringFromCString("_internal");
    if (Dart_IsError(name_handle)) {
      *dart_error_out = name_handle;
      g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
      return FALSE;
    }
    inner_container = Dart_GetField(dart_receiver, name_handle);
    if (Dart_IsError(inner_container)) {
      *dart_error_out = inner_container;
      g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
      return FALSE;
    }
    temp_result = Dart_GetNativeInstanceField(inner_container, 0, (intptr_t*) &raw_pointer);
    if (Dart_IsError(temp_result)) {
      *dart_error_out = temp_result;
      g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
      return FALSE;
    }
    wrapped_object = (GdartBridgeContextWrappedObject*) raw_pointer->raw_pointer;
    object = wrapped_object->object;
  }
  klass = G_OBJECT_CLASS(object);
  param_spec = g_object_class_find_property(klass, property_name);
  g_value_init(&value, G_PARAM_SPEC_VALUE_TYPE(param_spec));
  g_object_get_property(object, property_name, &value);
  base_info_type = g_base_info_get_type(base_info);
  if (base_info_type == GI_INFO_TYPE_OBJECT) {
    int i = 0, q_of_properties;

    q_of_properties = g_object_info_get_n_properties((GIObjectInfo*) base_info);
    for (; i < q_of_properties; i++) {
      GIPropertyInfo *test_property_info;

      test_property_info = g_object_info_get_property((GIObjectInfo*) base_info, i);
      if (g_str_equal(g_base_info_get_name((GIBaseInfo*) test_property_info),
                      property_name)) {
        property_info = test_property_info;
        break;
      }
      g_base_info_unref((GIBaseInfo*) test_property_info);
    }
  } else if (base_info_type == GI_INFO_TYPE_INTERFACE) {
    int i = 0, q_of_properties;

    q_of_properties = g_interface_info_get_n_properties((GIInterfaceInfo*) base_info);
    for (; i < q_of_properties; i++) {
      GIPropertyInfo *test_property_info;

      test_property_info = g_interface_info_get_property((GIInterfaceInfo*) base_info, i);
      if (g_str_equal(g_base_info_get_name((GIBaseInfo*) test_property_info),
                      property_name)) {
        property_info = test_property_info;
        break;
      }
      g_base_info_unref((GIBaseInfo*) test_property_info);
    }
  } else {
    *dart_error_out = gdart_bridge_context_create_error_handle(self,
                      "%s: expected a GIObjectInfo or a GIInterfaceInfo",
                      G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    result = FALSE;
  }
  if (result && property_info == NULL) {
    *dart_error_out = gdart_bridge_context_create_error_handle(self,
                      "%s: Could not find the specified property",
                      G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    result = FALSE;
  }
  if (result) {
    Dart_Handle dart_result;
    dart_result = _gdart_g_property_take_value(self,
					       name_prefix,
                                               property_info,
					       &value,
					       dart_error_out,
					       error);
    if (dart_result == NULL) result = FALSE;
    *dart_result_out = dart_result;
  }
  g_base_info_unref(property_info);
  g_value_unset(&value);
  return result;
}
