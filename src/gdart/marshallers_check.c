// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
//

#include "marshallers_check.h"
#include "common.h"
#include "object_wrapper.h"

gboolean _gdart_marshaller_check_array_element(GdartBridgeContext *self,
    Dart_Handle element,
    GITypeInfo *arg_type,
    Dart_Handle *dart_error_out,
    GError **error);

gboolean _gdart_marshaller_check_argument_boolean(GdartBridgeContext *self,
    Dart_Handle element,
    GITypeInfo *arg_type,
    Dart_Handle *dart_error_out,
    GError **error)
{
  if (!Dart_IsBoolean(element)) {
    *dart_error_out = gdart_bridge_context_create_error_handle(self,
                      "%s: expected boolean", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: expected boolean", G_STRFUNC);
    goto error;
  }
  return TRUE;
error:
  return FALSE;
}

gboolean _gdart_marshaller_check_argument_in_boolean(GdartBridgeContext *self,
    Dart_Handle dart_args,
    gint *dartarg_i,
    GITypeInfo *arg_type,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle element;
  element = Dart_ListGetAt(dart_args, (*dartarg_i)++);
  if (Dart_IsError(element)) {
    *dart_error_out = element;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    goto error;
  }
  return _gdart_marshaller_check_argument_boolean(self,
         element,
         arg_type,
         dart_error_out,
         error);
error:
  return FALSE;
}

gboolean _gdart_marshaller_check_argument_int(GdartBridgeContext *self,
    Dart_Handle element,
    GITypeInfo *arg_type,
    Dart_Handle *dart_error_out,
    GError **error)
{
  if (!Dart_IsInteger(element)) {
    *dart_error_out = gdart_bridge_context_create_error_handle(self,
                      "%s: expected integer", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: expected integer", G_STRFUNC);
    goto error;
  }
  return TRUE;
error:
  return FALSE;
}

gboolean _gdart_marshaller_check_argument_in_int(GdartBridgeContext *self,
    Dart_Handle dart_args,
    gint *dartarg_i,
    GITypeInfo *arg_type,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle element;
  element = Dart_ListGetAt(dart_args, (*dartarg_i)++);
  if (Dart_IsError(element)) {
    *dart_error_out = element;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    goto error;
  }
  return _gdart_marshaller_check_argument_int(self,
         element,
         arg_type,
         dart_error_out,
         error);
error:
  return FALSE;
}

gboolean _gdart_marshaller_check_argument_num(GdartBridgeContext *self,
    Dart_Handle element,
    GITypeInfo *arg_type,
    Dart_Handle *dart_error_out,
    GError **error)
{
  if (!Dart_IsInteger(element) && !Dart_IsDouble(element)) {
    *dart_error_out = gdart_bridge_context_create_error_handle(self,
                      "%s: expected double or integer", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: expected double or integer", G_STRFUNC);
    goto error;
  }
  return TRUE;
error:
  return FALSE;
}

gboolean _gdart_marshaller_check_argument_in_num(GdartBridgeContext *self,
    Dart_Handle dart_args,
    gint *dartarg_i,
    GITypeInfo *arg_type,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle element;
  element = Dart_ListGetAt(dart_args, (*dartarg_i)++);
  if (Dart_IsError(element)) {
    *dart_error_out = element;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    goto error;
  }
  return _gdart_marshaller_check_argument_num(self,
         element,
         arg_type,
         dart_error_out,
         error);
error:
  return FALSE;
}

gboolean _gdart_marshaller_check_argument_string(GdartBridgeContext *self,
    Dart_Handle element,
    GITypeInfo *arg_type,
    Dart_Handle *dart_error_out,
    GError **error)
{
  if (!Dart_IsString(element) && !Dart_IsNull(element)) {
    *dart_error_out = gdart_bridge_context_create_error_handle(self,
                      "%s: expected string or null", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: expected string or null", G_STRFUNC);
    goto error;
  }
  return TRUE;
error:
  return FALSE;
}

gboolean _gdart_marshaller_check_argument_in_string(GdartBridgeContext *self,
    Dart_Handle dart_args,
    gint *dartarg_i,
    GITypeInfo *arg_type,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle element;
  element = Dart_ListGetAt(dart_args, (*dartarg_i)++);
  if (Dart_IsError(element)) {
    *dart_error_out = element;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    goto error;
  }
  return _gdart_marshaller_check_argument_string(self,
         element,
         arg_type,
         dart_error_out,
         error);
error:
  return FALSE;
}

gboolean _gdart_marshaller_check_argument_struct_from_gtype(
  GdartBridgeContext *self,
  Dart_Handle element,
  GType type,
  Dart_Handle *dart_error_out,
  GError **error)
{
  Dart_Handle base_object_class, temp_result, inner_container, name_handle;
  bool is_proper_type;
  RawPointerContainer* raw_pointer;
  GdartBridgeContextWrappedObject* object_info;
  base_object_class = gdart_bridge_context_get_base_object_class(self, dart_error_out, error);
  if (base_object_class == NULL) {
    return false;
  }
  if (Dart_IsNull(element)) {
    return TRUE;
  }
  temp_result = Dart_ObjectIsType(element, base_object_class, &is_proper_type);
  if (Dart_IsError(temp_result)) {
    *dart_error_out = temp_result;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    goto error;
  }
  if (!is_proper_type) {
    *dart_error_out = gdart_bridge_context_create_error_handle(self,
                      "%s: received an unexpected base info type", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: received an unexpected base info type", G_STRFUNC);
    goto error;
  }
  name_handle = Dart_NewStringFromCString("_internal");
  if (Dart_IsError(name_handle)) {
    *dart_error_out = name_handle;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return FALSE;
  }
  inner_container = Dart_GetField(element, name_handle);
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
  if (object_info->type != type) {
    *dart_error_out = gdart_bridge_context_create_error_handle(self,
                      "%s: got an argument of the wrong type. This might be due to a problem in the GIR file", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: got an argument of the wrong type. This might be due to a problem in the GIR file", G_STRFUNC);
    goto error;
  }
  return TRUE;
error:
  return FALSE;
}

gboolean _gdart_marshaller_check_argument_callback(
  GdartBridgeContext *self,
  Dart_Handle element,
  GIRegisteredTypeInfo* type,
  Dart_Handle *dart_error_out,
  GError **error)
{
  if (Dart_IsClosure(element) || Dart_IsFunction(element)) {
    return TRUE;
  }
  *dart_error_out = gdart_bridge_context_create_error_handle(self,
                    "%s: expected a callback", G_STRFUNC);
  g_set_error(error, GDART_ERROR, 1,
              "%s: expected a callback", G_STRFUNC);
  return FALSE;
}

gboolean _gdart_marshaller_check_argument_struct(
  GdartBridgeContext *self,
  Dart_Handle element,
  GIRegisteredTypeInfo* type,
  Dart_Handle *dart_error_out,
  GError **error)
{
  return _gdart_marshaller_check_argument_struct_from_gtype(self,
         element,
         g_registered_type_info_get_g_type(type),
         dart_error_out,
         error);
}


gboolean _gdart_marshaller_check_argument_in_callback(
  GdartBridgeContext *self,
  Dart_Handle dart_args,
  gint *dartarg_i,
  GIRegisteredTypeInfo* type,
  Dart_Handle *dart_error_out,
  GError **error)
{
  Dart_Handle element;
  element = Dart_ListGetAt(dart_args, (*dartarg_i)++);
  if (Dart_IsError(element)) {
    *dart_error_out = element;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    goto error;
  }
  return _gdart_marshaller_check_argument_callback(self,
         element,
         type,
         dart_error_out,
         error);
error:
  return FALSE;
}

gboolean _gdart_marshaller_check_argument_in_struct(
  GdartBridgeContext *self,
  Dart_Handle dart_args,
  gint *dartarg_i,
  GIRegisteredTypeInfo* type,
  Dart_Handle *dart_error_out,
  GError **error)
{
  Dart_Handle element;
  element = Dart_ListGetAt(dart_args, (*dartarg_i)++);
  if (Dart_IsError(element)) {
    *dart_error_out = element;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    goto error;
  }
  return _gdart_marshaller_check_argument_struct(self,
         element,
         type,
         dart_error_out,
         error);
error:
  return FALSE;
}

gboolean _gdart_marshaller_check_argument_in_struct_from_gtype(
  GdartBridgeContext *self,
  Dart_Handle dart_args,
  gint *dartarg_i,
  GType type,
  Dart_Handle *dart_error_out,
  GError **error)
{
  Dart_Handle element;
  element = Dart_ListGetAt(dart_args, (*dartarg_i)++);
  if (Dart_IsError(element)) {
    *dart_error_out = element;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    goto error;
  }
  return _gdart_marshaller_check_argument_struct_from_gtype(self,
         element,
         type,
         dart_error_out,
         error);
error:
  return FALSE;
}

gboolean _gdart_marshaller_check_argument_object(
  GdartBridgeContext *self,
  Dart_Handle element,
  GIRegisteredTypeInfo* type,
  Dart_Handle *dart_error_out,
  GError **error)
{
  Dart_Handle base_object_class, temp_result, inner_container, name_handle;
  bool is_proper_type;
  RawPointerContainer* raw_pointer;
  GdartBridgeContextWrappedObject* object_info;
  GObject* object;
  base_object_class = gdart_bridge_context_get_base_object_class(self, dart_error_out, error);
  if (base_object_class == NULL) {
    return false;
  }
  if (Dart_IsNull(element)) {
    return TRUE;
  }
  temp_result = Dart_ObjectIsType(element, base_object_class, &is_proper_type);
  if (Dart_IsError(temp_result)) {
    *dart_error_out = temp_result;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    goto error;
  }
  if (!is_proper_type) {
    *dart_error_out = gdart_bridge_context_create_error_handle(self,
                      "%s: received an unexpected base info type", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: received an unexpected base info type", G_STRFUNC);
    goto error;
  }
  name_handle = Dart_NewStringFromCString("_internal");
  if (Dart_IsError(name_handle)) {
    *dart_error_out = name_handle;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return FALSE;
  }
  inner_container = Dart_GetField(element, name_handle);
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
  if (g_base_info_get_type(object_info->object_info) != GI_INFO_TYPE_OBJECT) {
    *dart_error_out = gdart_bridge_context_create_error_handle(self,
                      "%s: expected an object but got a struct", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: expected an object but got a struct", G_STRFUNC);
    goto error;
  }
  object = (GObject*) object_info->object;
  if (!g_type_is_a(G_OBJECT_TYPE(object), g_registered_type_info_get_g_type(type))) {
    *dart_error_out = gdart_bridge_context_create_error_handle(self,
                      "%s: expected an object of one type but got another", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: expected an object of one type but got another", G_STRFUNC);
    goto error;
  }
  return TRUE;
error:
  return FALSE;
}

gboolean _gdart_marshaller_check_argument_in_object(
  GdartBridgeContext *self,
  Dart_Handle dart_args,
  gint *dartarg_i,
  GIObjectInfo* type,
  Dart_Handle *dart_error_out,
  GError **error)
{
  Dart_Handle element;
  element = Dart_ListGetAt(dart_args, (*dartarg_i)++);
  if (Dart_IsError(element)) {
    *dart_error_out = element;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    goto error;
  }
  return _gdart_marshaller_check_argument_object(self,
         element,
         type,
         dart_error_out,
         error);
error:
  return FALSE;

}


gboolean _gdart_marshaller_check_argument_flags(
  GdartBridgeContext *self,
  Dart_Handle element,
  GIRegisteredTypeInfo* type,
  Dart_Handle *dart_error_out,
  GError **error)
{
  Dart_Handle base_object_class, temp_result, inner_container, name_handle;
  bool is_proper_type;
  int64_t raw_result;
  base_object_class = gdart_bridge_context_get_base_enum_class(self, dart_error_out, error);
  if (base_object_class == NULL) {
    return false;
  }
  temp_result = Dart_ObjectIsType(element, base_object_class, &is_proper_type);
  if (Dart_IsError(temp_result)) {
    *dart_error_out = temp_result;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    goto error;
  }
  if (!is_proper_type) {
    *dart_error_out = gdart_bridge_context_create_error_handle(self,
                      "%s: received an unexpected base info type", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: received an unexpected base info type", G_STRFUNC);
    goto error;
  }
  name_handle = Dart_NewStringFromCString("value");
  if (Dart_IsError(name_handle)) {
    *dart_error_out = name_handle;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return FALSE;
  }
  inner_container = Dart_GetField(element, name_handle);
  if (Dart_IsError(inner_container)) {
    *dart_error_out = inner_container;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return FALSE;
  }
  temp_result = Dart_IntegerToInt64(inner_container, &raw_result);
  if (Dart_IsError(temp_result)) {
    *dart_error_out = temp_result;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    return FALSE;
  }
  return TRUE;
error:
  return FALSE;
}

gboolean _gdart_marshaller_check_argument_in_flags(GdartBridgeContext *self,
    Dart_Handle dart_args,
    gint *dartarg_i,
    GIEnumInfo* type,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle element;
  element = Dart_ListGetAt(dart_args, (*dartarg_i)++);
  if (Dart_IsError(element)) {
    *dart_error_out = element;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    goto error;
  }
  return _gdart_marshaller_check_argument_flags(self,
         element,
         type,
         dart_error_out,
         error);
error:
  return FALSE;
}

gboolean _gdart_marshaller_check_argument_interface(
  GdartBridgeContext *self,
  Dart_Handle element,
  GITypeInfo *arg_type,
  Dart_Handle *dart_error_out,
  GError **error)
{
  GIBaseInfo* base_info;
  gboolean result;
  base_info = g_type_info_get_interface(arg_type);
  switch (g_base_info_get_type(base_info)) {
  case GI_INFO_TYPE_CALLBACK:
    result = _gdart_marshaller_check_argument_callback(self,
             element,
             (GICallbackInfo*) base_info,
             dart_error_out,
             error);
    goto out;
  case GI_INFO_TYPE_STRUCT:
  case GI_INFO_TYPE_BOXED:
  case GI_INFO_TYPE_UNION:
    result = _gdart_marshaller_check_argument_struct(self,
             element,
             (GIRegisteredTypeInfo*) base_info,
             dart_error_out,
             error);
    goto out;
  case GI_INFO_TYPE_OBJECT:
    result = _gdart_marshaller_check_argument_object(self,
             element,
             (GIObjectInfo*) base_info,
             dart_error_out,
             error);
    goto out;

  case GI_INFO_TYPE_ENUM:
  case GI_INFO_TYPE_FLAGS:
    result = _gdart_marshaller_check_argument_flags(self,
             element,
             (GIEnumInfo*) base_info,
             dart_error_out,
             error);
    goto out;
  case GI_INFO_TYPE_INTERFACE:
  default:
    *dart_error_out = gdart_bridge_context_create_error_handle(self,
                      "%s: received an unexpected base info type", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: received an unexpected base info type", G_STRFUNC);
    goto error;
  }
out:
  g_base_info_unref(base_info);
  return result;
error:
  g_base_info_unref(base_info);
  return FALSE;
}

gboolean _gdart_marshaller_check_argument_in_interface(
  GdartBridgeContext *self,
  Dart_Handle dart_args,
  gint *dartarg_i,
  GITypeInfo *arg_type,
  gint* suppressed_args,
  gint suppressed_args_length,
  gint garg_i,
  Dart_Handle *dart_error_out,
  GError **error)
{
  GIBaseInfo* base_info;
  gboolean result;
  base_info = g_type_info_get_interface(arg_type);
  switch (g_base_info_get_type(base_info)) {
  case GI_INFO_TYPE_CALLBACK:
    result = _gdart_marshaller_check_argument_in_callback(self,
             dart_args,
             dartarg_i,
             (GICallbackInfo*) base_info,
             dart_error_out,
             error);
    goto out;
  case GI_INFO_TYPE_STRUCT:
  case GI_INFO_TYPE_BOXED:
  case GI_INFO_TYPE_UNION:
    result = _gdart_marshaller_check_argument_in_struct(self,
             dart_args,
             dartarg_i,
             (GIRegisteredTypeInfo*) base_info,
             dart_error_out,
             error);
    goto out;
  case GI_INFO_TYPE_INTERFACE:
  case GI_INFO_TYPE_OBJECT:
    result = _gdart_marshaller_check_argument_in_object(self,
             dart_args,
             dartarg_i,
             (GIObjectInfo*) base_info,
             dart_error_out,
             error);
    goto out;
  case GI_INFO_TYPE_ENUM:
  case GI_INFO_TYPE_FLAGS:
    result = _gdart_marshaller_check_argument_in_flags(self,
             dart_args,
             dartarg_i,
             (GIEnumInfo*) base_info,
             dart_error_out,
             error);
    goto out;
  default:
    *dart_error_out = gdart_bridge_context_create_error_handle(self,
                      "%s: received an unexpected base info type", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: received an unexpected base info type", G_STRFUNC);
    goto error;
  }
out:
  g_base_info_unref(base_info);
  return result;
error:
  g_base_info_unref(base_info);
  return FALSE;
}

gboolean _gdart_marshaller_check_argument_in_array_parameters(
  GdartBridgeContext *self,
  Dart_Handle dart_list,
  GITypeInfo *arg_type,
  gint fixed_length,
  Dart_Handle *dart_error_out,
  GError **error)
{
  Dart_Handle temp_result, element;
  gintptr list_length, elem_i = 0;
  GITypeInfo *param_type;
  GError* inner_error = NULL;

  param_type = g_type_info_get_param_type(arg_type, 0);

  temp_result = Dart_ListLength(dart_list, &list_length);
  if (Dart_IsError(temp_result)) {
    *dart_error_out = temp_result;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    goto error;
  }
  if (fixed_length != -1 && fixed_length != list_length) {
    *dart_error_out = gdart_bridge_context_create_error_handle(self,
                      "%s: the array did not have a length, a fixed size or a null termination so I can't handle it", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: the array did not have a length, a fixed size or a null termination so I can't handle it", G_STRFUNC);
    goto error;
  }

  for (; elem_i < list_length; elem_i++) {
    element = Dart_ListGetAt(dart_list, elem_i);
    if (Dart_IsError(element)) {
      *dart_error_out = element;
      g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
      goto error;
    }
    if (!_gdart_marshaller_check_array_element(self, element, param_type,
        dart_error_out, &inner_error)) {
      g_propagate_error(error, inner_error);
      goto error;
    }
  }
  g_base_info_unref((GIBaseInfo*) param_type);
  return TRUE;
error:
  g_base_info_unref((GIBaseInfo*) param_type);
  return FALSE;
}

gboolean _gdart_marshaller_check_argument_array(GdartBridgeContext *self,
    Dart_Handle element,
    GITypeInfo *arg_type,
    Dart_Handle *dart_error_out,
    GError **error)
{
  gint fixed_length = 0;
  fixed_length = g_type_info_get_array_fixed_size(arg_type);
  if (fixed_length == -1 && !g_type_info_is_zero_terminated(arg_type)) {
    *dart_error_out = gdart_bridge_context_create_error_handle(self,
                      "%s: the array did not have a fixed size or a null termination so I can't handle it", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: the array did not have a fixed size or a null termination so I can't handle it", G_STRFUNC);
    goto error;
  }
  if (!Dart_IsList(element) && !Dart_IsNull(element)) {
    *dart_error_out = gdart_bridge_context_create_error_handle(self,
                      "%s: expected string or null", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: expected string or null", G_STRFUNC);
    goto error;
  }
  if (Dart_IsNull(element) && fixed_length == -1) return TRUE;
  return _gdart_marshaller_check_argument_in_array_parameters(self,
         element,
         arg_type,
         fixed_length,
         dart_error_out,
         error);
error:
  return FALSE;
}


gboolean _gdart_marshaller_check_argument_in_array(GdartBridgeContext *self,
    Dart_Handle dart_args,
    gint *dartarg_i,
    GITypeInfo *arg_type,
    gint garg_i,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle element;
  gint arg_to_suppress, fixed_length = 0;
  arg_to_suppress = g_type_info_get_array_length(arg_type);
  fixed_length = g_type_info_get_array_fixed_size(arg_type);
  if (arg_to_suppress == -1 && fixed_length == -1 &&
      !g_type_info_is_zero_terminated(arg_type)) {
    *dart_error_out = gdart_bridge_context_create_error_handle(self,
                      "%s: the array did not have a length, a fixed size or a null termination so I can't handle it", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: the array did not have a length, a fixed size or a null termination so I can't handle it", G_STRFUNC);
    goto error;
  }

  element = Dart_ListGetAt(dart_args, (*dartarg_i)++);
  if (Dart_IsError(element)) {
    *dart_error_out = element;
    g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
    goto error;
  }
  if (!Dart_IsList(element) && !Dart_IsNull(element)) {
    *dart_error_out = gdart_bridge_context_create_error_handle(self,
                      "%s: expected string or null", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: expected string or null", G_STRFUNC);
    goto error;
  }
  if (Dart_IsNull(element) && fixed_length == -1) return TRUE;
  return _gdart_marshaller_check_argument_in_array_parameters(self,
         element,
         arg_type,
         fixed_length,
         dart_error_out,
         error);
error:
  return FALSE;
}

gboolean _gdart_marshaller_check_array_element(GdartBridgeContext *self,
    Dart_Handle element,
    GITypeInfo *arg_type,
    Dart_Handle *dart_error_out,
    GError **error)
{

  switch (g_type_info_get_tag(arg_type)) {
  case GI_TYPE_TAG_BOOLEAN:
    return _gdart_marshaller_check_argument_boolean(self,
           element,
           arg_type,
           dart_error_out,
           error);
  case GI_TYPE_TAG_INT8:
  case GI_TYPE_TAG_UINT8:
  case GI_TYPE_TAG_INT16:
  case GI_TYPE_TAG_UINT16:
  case GI_TYPE_TAG_INT32:
  case GI_TYPE_TAG_UINT32:
  case GI_TYPE_TAG_INT64:
  case GI_TYPE_TAG_UINT64:
  case GI_TYPE_TAG_GTYPE:
    return _gdart_marshaller_check_argument_int(self,
           element,
           arg_type,
           dart_error_out,
           error);
  case GI_TYPE_TAG_FLOAT:
  case GI_TYPE_TAG_DOUBLE:
    return _gdart_marshaller_check_argument_num(self,
           element,
           arg_type,
           dart_error_out,
           error);
  case GI_TYPE_TAG_UTF8:
  case GI_TYPE_TAG_FILENAME:
    return _gdart_marshaller_check_argument_string(self,
           element,
           arg_type,
           dart_error_out,
           error);
  case GI_TYPE_TAG_ARRAY:
    return _gdart_marshaller_check_argument_array(self,
           element,
           arg_type,
           dart_error_out,
           error);
  case GI_TYPE_TAG_INTERFACE:
    return _gdart_marshaller_check_argument_interface(self,
           element,
           arg_type,
           dart_error_out,
           error);
  case GI_TYPE_TAG_GLIST:
  case GI_TYPE_TAG_GSLIST:
    return _gdart_marshaller_check_argument_struct_from_gtype(self,
           element,
           4,
           dart_error_out,
           error);
  case GI_TYPE_TAG_GHASH:
    return _gdart_marshaller_check_argument_struct_from_gtype(self,
           element,
           G_TYPE_HASH_TABLE,
           dart_error_out,
           error);
  case GI_TYPE_TAG_ERROR:
    return _gdart_marshaller_check_argument_struct_from_gtype(self,
           element,
           G_TYPE_ERROR,
           dart_error_out,
           error);

  default:
    *dart_error_out = gdart_bridge_context_create_error_handle(self,
                      "%s: got an unexpected type", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: got an unexpected type", G_STRFUNC);
    return FALSE;
  }
}

void gdart_marshaller_preload_suppressed_args(GdartBridgeContext *self,
    GIFunctionInfo *function,
    gint garg_length,
    gint* suppressed_args,
    gint suppressed_args_length)
{
  gint garg_i = 0;
  GIArgInfo arg_info;
  GITypeInfo type_info;

  for (garg_i = 0; garg_i < garg_length; garg_i++) {
    g_callable_info_load_arg((GICallableInfo*) function, garg_i, &arg_info);
    if (g_arg_info_get_direction(&arg_info) == GI_DIRECTION_IN ||
        g_arg_info_get_direction(&arg_info) == GI_DIRECTION_INOUT) {
      g_arg_info_load_type(&arg_info, &type_info);
      switch (g_type_info_get_tag(&type_info)) {
      case GI_TYPE_TAG_ARRAY: {
        gint arg_to_suppress, arg_i = 0;
        arg_to_suppress = g_type_info_get_array_length(&type_info);
        if (arg_to_suppress != -1) {
          for (; arg_i < suppressed_args_length; arg_i++) {
            if (suppressed_args[arg_i] == -1) {
              suppressed_args[arg_i] = arg_to_suppress;
              break;
            }
          }
        }
        break;
      }
      case GI_TYPE_TAG_INTERFACE: {
        GIBaseInfo *interface_info;

        interface_info = g_type_info_get_interface(&type_info);
        switch (g_base_info_get_type(interface_info )) {
        case GI_INFO_TYPE_CALLBACK: {
          gint arg_to_suppress, arg_i = 0;
          arg_to_suppress = g_arg_info_get_closure(&arg_info);
          if (arg_to_suppress != -1) {
            for (; arg_i < suppressed_args_length; arg_i++) {
              if (suppressed_args[arg_i] == -1) {
                suppressed_args[arg_i] = arg_to_suppress;
                break;
              }
            }
          }
          arg_to_suppress = g_arg_info_get_destroy(&arg_info);
          if (arg_to_suppress != -1) {
            for (; arg_i < suppressed_args_length; arg_i++) {
              if (suppressed_args[arg_i] == -1) {
                suppressed_args[arg_i] = arg_to_suppress;
                break;
              }
            }
          }
          break;
        }
        default:
          break;
        }
      }
      default:
        break;
      }
    }
  }
}

gboolean gdart_marshaller_check_argument_in(GdartBridgeContext *self,
    GIFunctionInfo *function,
    Dart_Handle dart_args,
    gint garg_i,
    gint *dartarg_i,
    GITypeInfo *arg_type,
    gint* suppressed_args,
    gint suppressed_args_length,
    gintptr dart_args_length,
    Dart_Handle *dart_error_out,
    GError **error)
{
  gint arg_i = 0;
  for (; arg_i < suppressed_args_length; arg_i++) {
    if (suppressed_args[arg_i] == garg_i) return TRUE;
    if (suppressed_args[arg_i] == -1) break;
  }
  if ((*dartarg_i) >= dart_args_length) {
    *dart_error_out = gdart_bridge_context_create_error_handle(self,
                      "%s: did not get enough arguments from dart", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: did not get enough arguments from dart", G_STRFUNC);
    return FALSE;
  }
  switch (g_type_info_get_tag(arg_type)) {
  case GI_TYPE_TAG_BOOLEAN:
    return _gdart_marshaller_check_argument_in_boolean(self,
           dart_args,
           dartarg_i,
           arg_type,
           dart_error_out,
           error);
  case GI_TYPE_TAG_INT8:
  case GI_TYPE_TAG_UINT8:
  case GI_TYPE_TAG_INT16:
  case GI_TYPE_TAG_UINT16:
  case GI_TYPE_TAG_INT32:
  case GI_TYPE_TAG_UINT32:
  case GI_TYPE_TAG_INT64:
  case GI_TYPE_TAG_UINT64:
  case GI_TYPE_TAG_GTYPE:
    return _gdart_marshaller_check_argument_in_int(self,
           dart_args,
           dartarg_i,
           arg_type,
           dart_error_out,
           error);
  case GI_TYPE_TAG_FLOAT:
  case GI_TYPE_TAG_DOUBLE:
    return _gdart_marshaller_check_argument_in_num(self,
           dart_args,
           dartarg_i,
           arg_type,
           dart_error_out,
           error);
  case GI_TYPE_TAG_UTF8:
  case GI_TYPE_TAG_FILENAME:
    return _gdart_marshaller_check_argument_in_string(self,
           dart_args,
           dartarg_i,
           arg_type,
           dart_error_out,
           error);
  case GI_TYPE_TAG_ARRAY:
    return _gdart_marshaller_check_argument_in_array(self,
           dart_args,
           dartarg_i,
           arg_type,
           garg_i,
           dart_error_out,
           error);
  case GI_TYPE_TAG_INTERFACE:
    return _gdart_marshaller_check_argument_in_interface(self,
           dart_args,
           dartarg_i,
           arg_type,
           suppressed_args,
           suppressed_args_length,
           garg_i,
           dart_error_out,
           error);
  case GI_TYPE_TAG_GLIST:
    return _gdart_marshaller_check_argument_in_struct_from_gtype(self,
           dart_args,
           dartarg_i,
           G_DART_COMPAT_LIST_TYPE,
           dart_error_out,
           error);
  case GI_TYPE_TAG_GSLIST:
    return _gdart_marshaller_check_argument_in_struct_from_gtype(self,
           dart_args,
           dartarg_i,
           G_DART_COMPAT_SLIST_TYPE,
           dart_error_out,
           error);
  case GI_TYPE_TAG_GHASH:
    return _gdart_marshaller_check_argument_in_struct_from_gtype(self,
           dart_args,
           dartarg_i,
           G_TYPE_HASH_TABLE,
           dart_error_out,
           error);
  case GI_TYPE_TAG_ERROR:
    return _gdart_marshaller_check_argument_in_struct_from_gtype(self,
           dart_args,
           dartarg_i,
           G_TYPE_ERROR,
           dart_error_out,
           error);

  default:
    *dart_error_out = gdart_bridge_context_create_error_handle(self,
                      "%s: got an unexpected type", G_STRFUNC);
    g_set_error(error, GDART_ERROR, 1,
                "%s: got an unexpected type", G_STRFUNC);
    return FALSE;
  }
}

gboolean gdart_marshaller_check_arguments(GdartBridgeContext *self,
    GIFunctionInfo *function,
    Dart_Handle dart_args,
    gint garg_length,
    gintptr dart_args_length,
    gint** suppressed_args_out,
    gint* suppress_args_length_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  gint garg_i = 0, dartarg_i = 0;
  GError* inner_error = NULL;
  gint* suppressed_args;
  suppressed_args = g_slice_alloc(sizeof(gint) * garg_length);
  for (; garg_i < garg_length; garg_i ++) {
    suppressed_args[garg_i] = -1;
  }
  gdart_marshaller_preload_suppressed_args(self, function, garg_length, suppressed_args, garg_length);

  for (garg_i = 0; garg_i < garg_length; garg_i++) {
    GIArgInfo type_info;
    GITypeInfo arg_type;
    g_callable_info_load_arg((GICallableInfo*) function, garg_i, &type_info);
    if (g_arg_info_get_direction(&type_info) == GI_DIRECTION_IN ||
        g_arg_info_get_direction(&type_info) == GI_DIRECTION_INOUT) {
      g_arg_info_load_type(&type_info, &arg_type);
      if (!gdart_marshaller_check_argument_in(self,
                                              function,
                                              dart_args,
                                              garg_i,
                                              &dartarg_i,
                                              &arg_type,
                                              suppressed_args,
                                              garg_length,
                                              dart_args_length,
                                              dart_error_out,
                                              &inner_error)) {
        g_propagate_error(error, inner_error);
        goto error;
      }
    }
  }
  *suppress_args_length_out = garg_length;
  *suppressed_args_out = suppressed_args;
  return TRUE;
error:
  return FALSE;
}


