#include "array.h"

#define _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE(t, x, y) do {\
  *((t*) *x) = y; \
  *x = (gpointer) (((t*) *x) + 1);\
} while (FALSE)
#define _GDART_FUNCTION_READ_BUFFER_AND_ADVANCE(t, x, y) do {\
  y = *((t*) *x);\
  *x = (gpointer) (((t*) *x) + 1);\
} while (FALSE)
#define _GDART_FUNCTION_READ_BUFFER_AND_ADVANCE_WITH_CAST(t, x, y, s) do {\
  y = (s) *((t*) *x);\
  *x = (gpointer) (((t*) *x) + 1);\
} while (FALSE)

static gboolean _gdart_array_fill_element (GdartBridgeContext *self,
    const gchar *name_prefix,
    Dart_Handle element,
    gpointer arg_type,
    const TypeInfoKlass *arg_type_klass,
    gpointer *buffer,
    Dart_Handle *dart_error_out,
    GError **error);


static gboolean _gdart_array_fill_num_raw_in_buffer (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  gdouble double_result,
  gpointer  *buffer,
  GITypeTag type_tag,
  Dart_Handle *dart_error_out,
  GError **error)
{
  gfloat float_result;

  switch (type_tag) {
  case GI_TYPE_TAG_FLOAT:
    float_result = (gfloat) double_result;
    _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE (gfloat, buffer, float_result);
    break;
  case GI_TYPE_TAG_DOUBLE:
    _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE (gdouble, buffer, double_result);
    break;
  default:
    *dart_error_out = gdart_bridge_context_create_error_handle (
                        self,
                        "%s: expected an number-like type", G_STRFUNC);
    g_set_error (error, GDART_ERROR, 1,
                 "%s: expected an number-like type", G_STRFUNC);
    goto error;
  }
  return TRUE;
error:
  return FALSE;
}

static gboolean _gdart_array_fill_num_in_buffer (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  Dart_Handle element,
  gpointer  *buffer,
  GITypeTag type_tag,
  Dart_Handle *dart_error_out,
  GError **error)
{
  Dart_Handle temp_result;
  gdouble double_result;

  if (Dart_IsInteger (element)) {
    int64_t raw_result;
    temp_result = Dart_IntegerToInt64 (element, &raw_result);
    if (G_UNLIKELY(Dart_IsError (temp_result))) {
      *dart_error_out = temp_result;
      g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
      goto error;
    }
    double_result = (gdouble) raw_result;
  } else { // Double
    temp_result = Dart_DoubleValue (element, &double_result);
    if (G_UNLIKELY(Dart_IsError (temp_result))) {
      *dart_error_out = temp_result;
      g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
      goto error;
    }
  }
  return _gdart_array_fill_num_raw_in_buffer (self,
         name_prefix,
         double_result,
         buffer,
         type_tag,
         dart_error_out,
         error);
error:
  return FALSE;
}

static void _gdart_array_fill_boolean_raw_in_buffer (
  bool result,
  gpointer *buffer)
{
  _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE (gboolean, buffer, result);
}

static gboolean _gdart_array_fill_boolean_in_buffer (
  Dart_Handle element,
  gpointer *buffer,
  Dart_Handle *dart_error_out,
  GError **error)
{
  bool result;
  Dart_Handle temp_result;
  temp_result = Dart_BooleanValue (element, &result);
  if (G_UNLIKELY(Dart_IsError (temp_result))) {
    *dart_error_out = temp_result;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
    goto error;
  }
  _gdart_array_fill_boolean_raw_in_buffer (result,
      buffer);
  return TRUE;
error:
  return FALSE;
}

static gboolean _gdart_array_fill_int_raw_in_buffer (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  int64_t raw_result,
  uint64_t raw_result_64,
  gpointer *buffer,
  GITypeTag type_tag,
  Dart_Handle *dart_error_out,
  GError **error)
{
  switch (type_tag) {
  case GI_TYPE_TAG_INT8:
    if (raw_result > G_MAXINT8 || raw_result < G_MININT8) {
      g_warning ("%s: Integer was out of bounds. Result will be clamped.",
                 name_prefix);
      raw_result = CLAMP (raw_result, G_MININT8, G_MAXINT8);
    }
    _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE (gint8, buffer, (gint8) raw_result);
    break;
  case GI_TYPE_TAG_UINT8:
    if (raw_result > G_MAXUINT8 || raw_result < 0) {
      g_warning ("%s: Integer was out of bounds. Result will be clamped.",
                 name_prefix);
      raw_result = CLAMP (raw_result, 0, G_MAXUINT8);
    }
    _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE (guint8, buffer, (guint8) raw_result);
    break;
  case GI_TYPE_TAG_INT16:
    if (raw_result > G_MAXINT16 || raw_result < G_MININT16) {
      g_warning ("%s: Integer was out of bounds. Result will be clamped.",
                 name_prefix);
      raw_result = CLAMP (raw_result, G_MININT16, G_MAXINT16);
    }
    _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE (gint16, buffer, (gint16) raw_result);
    break;
  case GI_TYPE_TAG_UINT16:
    if (raw_result > G_MAXUINT16 || raw_result < 0) {
      g_warning ("%s: Integer was out of bounds. Result will be clamped.",
                 name_prefix);
      raw_result = CLAMP (raw_result, 0, G_MAXUINT16);
    }
    _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE (guint16, buffer, (guint16) raw_result);
    break;
  case GI_TYPE_TAG_INT32:
    if (raw_result > G_MAXINT32 || raw_result < G_MININT32) {
      g_warning ("%s: Integer was out of bounds. Result will be clamped.",
                 name_prefix);
      raw_result = CLAMP (raw_result, G_MININT32, G_MAXINT32);
    }
    _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE (gint32, buffer, (gint32) raw_result);
    break;
  case GI_TYPE_TAG_UINT32:
    if (raw_result > G_MAXUINT32 || raw_result < 0) {
      g_warning ("%s: Integer was out of bounds. Result will be clamped.",
                 name_prefix);
      raw_result = CLAMP (raw_result, 0, G_MAXUINT32);
    }
    _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE (guint32, buffer, (guint32) raw_result);
    break;
  case GI_TYPE_TAG_INT64:
    _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE (gint64, buffer, raw_result);
    break;
  case GI_TYPE_TAG_UINT64:
    _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE (guint8, buffer, raw_result_64);
    break;
  case GI_TYPE_TAG_GTYPE:
    _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE (GType, buffer, raw_result_64);
    break;
  default:
    *dart_error_out = gdart_bridge_context_create_error_handle (
                        self,
                        "%s: expected an integer-like type", G_STRFUNC);
    g_set_error (error, GDART_ERROR, 1,
                 "%s: expected an integer-like type", G_STRFUNC);
    goto error;
  }
  return TRUE;
error:
  return FALSE;
}

static gboolean _gdart_array_fill_int_in_buffer (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  Dart_Handle element,
  gpointer  *buffer,
  GITypeTag type_tag,
  Dart_Handle *dart_error_out,
  GError **error)
{
  int64_t raw_result;
  uint64_t raw_result_64;
  Dart_Handle temp_result;
  if (type_tag == GI_TYPE_TAG_UINT64 || type_tag == GI_TYPE_TAG_GTYPE) {
    temp_result = Dart_IntegerToUint64 (element, &raw_result_64);
  } else {
    temp_result = Dart_IntegerToInt64 (element, &raw_result);
  }
  if (G_UNLIKELY(Dart_IsError (temp_result))) {
    *dart_error_out = temp_result;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
    goto error;
  }
  if (!_gdart_array_fill_int_raw_in_buffer (self,
      name_prefix,
      raw_result,
      raw_result_64,
      buffer,
      type_tag,
      dart_error_out,
      error)) {
    return FALSE;
  }
  return TRUE;
error:
  return FALSE;
}

gsize gdart_array_get_size_multiplier (
  GdartBridgeContext *self,
  gpointer param_type,
  const TypeInfoKlass *param_type_klass,
  Dart_Handle *dart_error_out,
  GError **error)
{
  GITypeTag type_tag;
  gsize result;

  if (!param_type_klass->get_tag (param_type,
                                  self,
                                  &type_tag,
                                  dart_error_out,
                                  error))
    return 0;
  switch (type_tag) {
  case GI_TYPE_TAG_BOOLEAN:
    return sizeof (gboolean);
  case GI_TYPE_TAG_INT8:
    return sizeof (gint8);
  case GI_TYPE_TAG_UINT8:
    return sizeof (guint8);
  case GI_TYPE_TAG_INT16:
    return sizeof (gint16);
  case GI_TYPE_TAG_UINT16:
    return sizeof (guint16);
  case GI_TYPE_TAG_INT32:
    return sizeof (gint32);
  case GI_TYPE_TAG_UINT32:
    return sizeof (guint32);
  case GI_TYPE_TAG_INT64:
    return sizeof (gint64);
  case GI_TYPE_TAG_UINT64:
    return sizeof (guint64);
  case GI_TYPE_TAG_GTYPE:
    return sizeof (GType);
  case GI_TYPE_TAG_FLOAT:
    return sizeof (gfloat);
  case GI_TYPE_TAG_DOUBLE:
    return sizeof (gdouble);
  case GI_TYPE_TAG_INTERFACE: {
    gpointer base_info;
    const InterfaceInfoKlass *base_info_klass;
    GIInfoType base_info_type;

    if (!param_type_klass->get_interface (param_type,
                                          self,
                                          &base_info,
                                          &base_info_klass,
                                          dart_error_out,
                                          error))
      return 0;

    if (!base_info_klass->get_type (base_info,
                                    self,
                                    &base_info_type,
                                    dart_error_out,
                                    error)) {
      base_info_klass->free (base_info);
      return 0;
    }
    switch (base_info_type) {
    case GI_INFO_TYPE_CALLBACK:
    case GI_INFO_TYPE_STRUCT:
    case GI_INFO_TYPE_BOXED:
    case GI_INFO_TYPE_UNION:
    case GI_INFO_TYPE_OBJECT:
    case GI_INFO_TYPE_INTERFACE:
      base_info_klass->free (base_info);
      return sizeof (gpointer);
    case GI_INFO_TYPE_ENUM:
    case GI_INFO_TYPE_FLAGS: {
      GITypeTag inner_type;
      const EnumInfoKlass *klass;

      klass = base_info_klass->cast_to_enum_info (base_info);

      if (!klass->get_storage_type (base_info,
                                    self,
                                    &inner_type,
                                    dart_error_out,
                                    error)) {
        base_info_klass->free (base_info);
        return 0;
      }
      switch (inner_type) {
      case GI_TYPE_TAG_BOOLEAN:
        result = sizeof (gboolean);
      case GI_TYPE_TAG_INT8:
        result = sizeof (gint8);
      case GI_TYPE_TAG_UINT8:
        result = sizeof (guint8);
      case GI_TYPE_TAG_INT16:
        result = sizeof (gint16);
      case GI_TYPE_TAG_UINT16:
        result = sizeof (guint16);
      case GI_TYPE_TAG_INT32:
        result = sizeof (gint32);
      case GI_TYPE_TAG_UINT32:
        result = sizeof (guint32);
      case GI_TYPE_TAG_INT64:
        result = sizeof (gint64);
      case GI_TYPE_TAG_UINT64:
        result = sizeof (guint64);
      case GI_TYPE_TAG_GTYPE:
        result = sizeof (GType);
      default:
        result = 0;
        *dart_error_out =  gdart_bridge_context_create_error_handle (
                             self,
                             "%s: Couldn't get a size for the specific type.", G_STRFUNC);
        g_set_error (error, GDART_ERROR, 1, "%s: Couldn't get a size for the specific type.", G_STRFUNC);
      }
    }
    default:
      result = 0;
      *dart_error_out =  gdart_bridge_context_create_error_handle (
                           self,
                           "%s: Couldn't get a size for the specific type.", G_STRFUNC);
      g_set_error (error, GDART_ERROR, 1, "%s: Couldn't get a size for the specific type.", G_STRFUNC);
    }
    base_info_klass->free (base_info);
    return result;
  }
  case GI_TYPE_TAG_ARRAY:
  case GI_TYPE_TAG_UTF8:
  case GI_TYPE_TAG_FILENAME:
  case GI_TYPE_TAG_GLIST:
  case GI_TYPE_TAG_GSLIST:
  case GI_TYPE_TAG_GHASH:
  case GI_TYPE_TAG_ERROR:
    return sizeof (gpointer);
  default:
    *dart_error_out =  gdart_bridge_context_create_error_handle (
                         self,
                         "%s: Couldn't get a size for the specific type.", G_STRFUNC);
    g_set_error (error, GDART_ERROR, 1, "%s: Couldn't get a size for the specific type.", G_STRFUNC);
    return 0;
  }
}

gboolean gdart_array_fill_in_parameters (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  Dart_Handle dart_list,
  gpointer param_type,
  const TypeInfoKlass *param_type_klass,
  gint fixed_length,
  gintptr list_length,
  gpointer buffer,
  gpointer *buffer_out,
  Dart_Handle *dart_error_out,
  GError **error)
{
  Dart_Handle element;
  gintptr elem_i = 0;
  GError *inner_error = NULL;

  if (fixed_length != -1 && fixed_length != list_length) {
    *dart_error_out = gdart_bridge_context_create_error_handle (self,
                      "%s: the array did not have a length, a fixed size or a null termination so I can't handle it", G_STRFUNC);
    g_set_error (error, GDART_ERROR, 1,
                 "%s: the array did not have a length, a fixed size or a null termination so I can't handle it", G_STRFUNC);
    goto error;
  }

  for (; elem_i < list_length; elem_i++) {
    element = Dart_ListGetAt (dart_list, elem_i);
    if (G_UNLIKELY(Dart_IsError (element))) {
      *dart_error_out = element;
      g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
      goto error;
    }
    if (!_gdart_array_fill_element (self,
                                    name_prefix,
                                    element,
                                    param_type,
                                    param_type_klass,
                                    &buffer,
                                    dart_error_out,
                                    &inner_error)) {
      g_propagate_error (error, inner_error);
      goto error;
    }
  }
  (*buffer_out) = buffer;
  return TRUE;
error:
  return FALSE;
}

static void _gdart_array_fill_pointer_raw_in_buffer (
  gpointer object,
  gpointer  *buffer)
{
  _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE (gpointer, buffer, object);
}

static gboolean _gdart_array_fill_wrapped_pointer_in_buffer (
  Dart_Handle element,
  const gchar *name_prefix,
  gpointer  *buffer,
  Dart_Handle *dart_error_out,
  GError **error)
{
  Dart_Handle temp_result, inner_container, name_handle;
  RawPointerContainer *raw_pointer;
  GdartBridgeContextWrappedObject *object_info;
  void *object;

  if (Dart_IsNull (element)) {
    _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE (gpointer, buffer, NULL);
    return TRUE;
  }
  name_handle = Dart_NewStringFromCString ("_internal");
  if (G_UNLIKELY(Dart_IsError (name_handle))) {
    *dart_error_out = name_handle;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
    return FALSE;
  }
  inner_container = Dart_GetField (element, name_handle);
  if (G_UNLIKELY(Dart_IsError (inner_container))) {
    *dart_error_out = inner_container;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
    return FALSE;
  }
  temp_result = Dart_GetNativeInstanceField (inner_container, 0, (intptr_t *) &raw_pointer);
  if (G_UNLIKELY(Dart_IsError (temp_result))) {
    *dart_error_out = temp_result;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
    return FALSE;
  }
  object_info = (GdartBridgeContextWrappedObject *) raw_pointer->raw_pointer;
  object = object_info->object;
  _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE (gpointer, buffer, object);
  return TRUE;
}

gboolean gdart_array_zero_element (GdartBridgeContext *self,
                                   const gchar *name_prefix,
                                   gpointer arg_type,
                                   const TypeInfoKlass *arg_type_klass,
                                   gpointer *buffer,
                                   Dart_Handle *dart_error_out,
                                   GError **error)
{
  GITypeTag type_tag;
  if (!arg_type_klass->get_tag (arg_type,
                                self,
                                &type_tag,
                                dart_error_out,
                                error))
    return FALSE;
  switch (type_tag) {
  case GI_TYPE_TAG_BOOLEAN:
    _gdart_array_fill_boolean_raw_in_buffer (
      FALSE,
      buffer);
    return TRUE;
  case GI_TYPE_TAG_INT8:
  case GI_TYPE_TAG_UINT8:
  case GI_TYPE_TAG_INT16:
  case GI_TYPE_TAG_UINT16:
  case GI_TYPE_TAG_INT32:
  case GI_TYPE_TAG_UINT32:
  case GI_TYPE_TAG_INT64:
  case GI_TYPE_TAG_UINT64:
  case GI_TYPE_TAG_GTYPE:
    return _gdart_array_fill_int_raw_in_buffer (self,
           name_prefix,
           0,
           0,
           buffer,
           type_tag,
           dart_error_out,
           error);
  case GI_TYPE_TAG_FLOAT:
  case GI_TYPE_TAG_DOUBLE:
    return _gdart_array_fill_num_raw_in_buffer (self,
           name_prefix,
           0.0,
           buffer,
           type_tag,
           dart_error_out,
           error);
  case GI_TYPE_TAG_UTF8:
  case GI_TYPE_TAG_FILENAME:
  case GI_TYPE_TAG_ARRAY:
  case GI_TYPE_TAG_INTERFACE:
  case GI_TYPE_TAG_GLIST:
  case GI_TYPE_TAG_GSLIST:
  case GI_TYPE_TAG_GHASH:
  case GI_TYPE_TAG_ERROR:
    _gdart_array_fill_pointer_raw_in_buffer (
      NULL,
      buffer);
    return TRUE;
  default:
    *dart_error_out = gdart_bridge_context_create_error_handle (self,
                      "%s: got an unexpected type", G_STRFUNC);
    g_set_error (error, GDART_ERROR, 1,
                 "%s: got an unexpected type", G_STRFUNC);
    return FALSE;
  }
}


static gboolean _gdart_array_fill_flags_in_buffer (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  Dart_Handle element,
  gpointer  *buffer,
  GIEnumInfo *enum_info,
  Dart_Handle *dart_error_out,
  GError **error)
{
  Dart_Handle inner_container, name_handle;
  GITypeTag storage_type;
  storage_type = g_enum_info_get_storage_type (enum_info);
  name_handle = Dart_NewStringFromCString ("value");
  if (G_UNLIKELY(Dart_IsError (name_handle))) {
    *dart_error_out = name_handle;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
    return FALSE;
  }
  inner_container = Dart_GetField (element, name_handle);
  if (G_UNLIKELY(Dart_IsError (inner_container))) {
    *dart_error_out = inner_container;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
    return FALSE;
  }
  return _gdart_array_fill_int_in_buffer (self,
                                          name_prefix,
                                          inner_container,
                                          buffer,
                                          storage_type,
                                          dart_error_out,
                                          error);
}

static gboolean _gdart_array_fill_interface_in_buffer (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  Dart_Handle element,
  gpointer *buffer,
  gpointer arg_type,
  const TypeInfoKlass *arg_type_klass,
  Dart_Handle *dart_error_out,
  GError **error)
{
  gpointer base_info;
  const InterfaceInfoKlass *base_info_klass;
  gboolean result;
  GIInfoType base_info_type;

  if (!arg_type_klass->get_interface (arg_type,
                                      self,
                                      &base_info,
                                      &base_info_klass,
                                      dart_error_out,
                                      error))
    return FALSE;
  if (!base_info_klass->get_type (base_info,
                                  self,
                                  &base_info_type,
                                  dart_error_out,
                                  error)) {
    base_info_klass->free (base_info);
    return FALSE;
  }
  switch (base_info_type) {
  case GI_INFO_TYPE_CALLBACK:
    *dart_error_out = gdart_bridge_context_create_error_handle (self,
                      "%s: can't handle callbacks yet", G_STRFUNC);
    g_set_error (error, GDART_ERROR, 1,
                 "%s: can't handle callbacks yet", G_STRFUNC);
    result = FALSE;
    break;
  case GI_INFO_TYPE_STRUCT:
  case GI_INFO_TYPE_BOXED:
  case GI_INFO_TYPE_UNION:
  case GI_INFO_TYPE_OBJECT:
  case GI_INFO_TYPE_INTERFACE:
    result = _gdart_array_fill_wrapped_pointer_in_buffer (
               element,
               name_prefix,
               buffer,
               dart_error_out,
               error);
    break;

  case GI_INFO_TYPE_ENUM:
  case GI_INFO_TYPE_FLAGS:
    result = _gdart_array_fill_flags_in_buffer (self,
             name_prefix,
             element,
             buffer,
             (GIEnumInfo *) base_info,
             dart_error_out,
             error);
    break;
  default:
    *dart_error_out = gdart_bridge_context_create_error_handle (self,
                      "%s: received an unexpected base info type", G_STRFUNC);
    g_set_error (error, GDART_ERROR, 1,
                 "%s: received an unexpected base info type", G_STRFUNC);
    result = FALSE;
  }
  base_info_klass->free (base_info);
  return result;
}

static gboolean _gdart_array_fill_string_in_buffer (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  Dart_Handle element,
  gpointer  *buffer,
  GITypeTag type_tag,
  Dart_Handle *dart_error_out,
  GError **error)
{
  uint8_t *original_string;
  gchar *resulting_string;
  intptr_t string_length;
  Dart_Handle temp_result;
  gsize bytes_read, bytes_written;
  GError *inner_error = NULL;

  if (Dart_IsNull (element)) {
    _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE (gchar *, buffer, NULL);
    return TRUE;
  }
  temp_result = Dart_StringToUTF8 (element, &original_string, &string_length);
  if (G_UNLIKELY(Dart_IsError (temp_result))) {
    *dart_error_out = temp_result;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
    return FALSE;
  }
  switch (type_tag) {
  case GI_TYPE_TAG_UTF8:
    resulting_string = g_new (gchar, string_length + 1);
    memmove (resulting_string, original_string, string_length);
    resulting_string[string_length] = '\0';
    break;
  case GI_TYPE_TAG_FILENAME:
    resulting_string = g_filename_from_utf8 ( (gchar *) original_string,
                       string_length,
                       &bytes_read,
                       &bytes_written,
                       &inner_error);
    if (resulting_string == NULL) {
      *dart_error_out = gdart_bridge_context_create_error_handle (
                          self,
                          "%s",
                          inner_error->message);
      g_propagate_error (error, inner_error);
      return FALSE;
    }
    break;
  default:
    *dart_error_out = gdart_bridge_context_create_error_handle (
                        self,
                        "%s: expected an string-like type", G_STRFUNC);
    g_set_error (error, GDART_ERROR, 1,
                 "%s: expected an string-like type", G_STRFUNC);
    goto error;
  }
  _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE (gchar *, buffer, resulting_string);
  return TRUE;
error:
  return FALSE;
}


static gboolean _gdart_array_fill_array_in_buffer (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  Dart_Handle element,
  gpointer *buffer,
  gpointer arg_type,
  const TypeInfoKlass *arg_type_klass,
  Dart_Handle *dart_error_out,
  GError **error)
{
  Dart_Handle temp_result;
  intptr_t list_length;
  gintptr allocation_length;
  gpointer param_type;
  const TypeInfoKlass *param_type_klass;
  gpointer inner_pointer;
  gpointer inner_pointer_after;
  gsize size_per_cell;

  if (!Dart_IsList (element) && !Dart_IsNull (element)) {
    *dart_error_out = gdart_bridge_context_create_error_handle (self,
                      "%s: expected string or null", G_STRFUNC);
    g_set_error (error, GDART_ERROR, 1,
                 "%s: expected string or null", G_STRFUNC);
    goto error;
  }
  if (Dart_IsNull (element)) {
    list_length = 0;
  } else {
    temp_result = Dart_ListLength (element, &list_length);
    if (G_UNLIKELY(Dart_IsError (temp_result))) {
      *dart_error_out = temp_result;
      g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
      goto error;
    }
  }
  allocation_length = list_length + 1;
  if (!arg_type_klass->get_param_type (arg_type,
                                       self,
                                       0,
                                       &param_type,
                                       &param_type_klass,
                                       dart_error_out,
                                       error))
    return FALSE;
  size_per_cell = gdart_array_get_size_multiplier (self,
                  param_type,
                  param_type_klass,
                  dart_error_out,
                  error);
  if (size_per_cell == 0) {
    param_type_klass->free (param_type);
    return FALSE;
  }
  inner_pointer = g_slice_alloc (allocation_length * size_per_cell);

  if (!gdart_array_fill_in_parameters (self,
                                       name_prefix,
                                       element,
                                       param_type,
                                       param_type_klass,
                                       -1,
                                       list_length,
                                       inner_pointer,
                                       &inner_pointer_after,
                                       dart_error_out,
                                       error)) {
    return FALSE;
  }
  ( (gpointer *) inner_pointer) [list_length] = NULL;
  _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE (gpointer, buffer, inner_pointer);

error:
  return FALSE;
}


static gboolean _gdart_array_fill_element (GdartBridgeContext *self,
    const gchar *name_prefix,
    Dart_Handle element,
    gpointer arg_type,
    const TypeInfoKlass *arg_type_klass,
    gpointer *buffer,
    Dart_Handle *dart_error_out,
    GError **error)
{
  GITypeTag type_tag;
  type_tag = g_type_info_get_tag (arg_type);
  switch (type_tag) {
  case GI_TYPE_TAG_BOOLEAN:
    return _gdart_array_fill_boolean_in_buffer (
             element,
             buffer,
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
    return _gdart_array_fill_int_in_buffer (self,
                                            name_prefix,
                                            element,
                                            buffer,
                                            type_tag,
                                            dart_error_out,
                                            error);
  case GI_TYPE_TAG_FLOAT:
  case GI_TYPE_TAG_DOUBLE:
    return _gdart_array_fill_num_in_buffer (self,
                                            name_prefix,
                                            element,
                                            buffer,
                                            type_tag,
                                            dart_error_out,
                                            error);
  case GI_TYPE_TAG_UTF8:
  case GI_TYPE_TAG_FILENAME:
    return _gdart_array_fill_string_in_buffer (self,
           name_prefix,
           element,
           buffer,
           type_tag,
           dart_error_out,
           error);
  case GI_TYPE_TAG_ARRAY:
    return _gdart_array_fill_array_in_buffer (self,
           name_prefix,
           element,
           buffer,
           arg_type,
           arg_type_klass,
           dart_error_out,
           error);
  case GI_TYPE_TAG_INTERFACE:
    return _gdart_array_fill_interface_in_buffer (self,
           name_prefix,
           element,
           buffer,
           arg_type,
           arg_type_klass,
           dart_error_out,
           error);
  case GI_TYPE_TAG_GLIST:
  case GI_TYPE_TAG_GSLIST:
  case GI_TYPE_TAG_GHASH:
  case GI_TYPE_TAG_ERROR:
    return _gdart_array_fill_wrapped_pointer_in_buffer (
             element,
             name_prefix,
             buffer,
             dart_error_out,
             error);
  default:
    *dart_error_out = gdart_bridge_context_create_error_handle (self,
                      "%s: got an unexpected type", G_STRFUNC);
    g_set_error (error, GDART_ERROR, 1,
                 "%s: got an unexpected type", G_STRFUNC);
    return FALSE;
  }
}

static gboolean _gdart_array_unfill_array_in_buffer (
  GdartBridgeContext *self,
  gpointer *buffer,
  gpointer arg_type,
  const TypeInfoKlass *arg_type_klass,
  Dart_Handle *dart_error_out,
  GError **error)
{
  gpointer param_type;
  const TypeInfoKlass *param_type_klass;

  gpointer *buffer_loc = *buffer;
  gpointer inner_buffer = *buffer_loc;
  if (!arg_type_klass->get_param_type (arg_type,
                                       self,
                                       0,
                                       &param_type,
                                       &param_type_klass,
                                       dart_error_out,
                                       error))
    return FALSE;

  if (!gdart_array_unfill_in_array_parameters (self,
      param_type,
      param_type_klass,
      -1,
      TRUE,
      inner_buffer,
      dart_error_out,
      error)) {
    param_type_klass->free (param_type);
    return FALSE;
  }
  g_free (inner_buffer);
  param_type_klass->free (param_type);
  buffer_loc++;
  *buffer = buffer_loc;
  return TRUE;
}


static void _gdart_array_unfill_string_in_buffer (
  GdartBridgeContext *self,
  gpointer  *buffer)
{
  gpointer *buffer_temp = (gpointer *) *buffer;
  g_free (*buffer_temp);
  buffer_temp++;
  *buffer = buffer_temp;
}

static gboolean _gdart_array_remove_array_element (GdartBridgeContext *self,
    gpointer arg_type,
    const TypeInfoKlass *arg_type_klass,
    gpointer *buffer,
    Dart_Handle *dart_error_out,
    GError **error)
{
  GITypeTag type_tag;
  if (!arg_type_klass->get_tag (arg_type,
                                self,
                                &type_tag,
                                dart_error_out,
                                error))
    return FALSE;
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
  case GI_TYPE_TAG_INTERFACE:
  case GI_TYPE_TAG_GLIST:
  case GI_TYPE_TAG_GSLIST:
  case GI_TYPE_TAG_GHASH:
  case GI_TYPE_TAG_ERROR:
    return FALSE;
  case GI_TYPE_TAG_UTF8:
  case GI_TYPE_TAG_FILENAME:
    _gdart_array_unfill_string_in_buffer (self,
                                          buffer);
    return TRUE;
  case GI_TYPE_TAG_ARRAY:
    return _gdart_array_unfill_array_in_buffer (self,
           buffer,
           arg_type,
           arg_type_klass,
           dart_error_out,
           error);
  default:
    g_assert_not_reached();
  }
  return TRUE;
}

gboolean gdart_array_unfill_in_array_parameters (
  GdartBridgeContext *self,
  gpointer param_type,
  const TypeInfoKlass *param_type_klass,
  gint length,
  gboolean is_null_terminated,
  gpointer buffer,
  Dart_Handle *dart_error_out,
  GError **error)
{
  gintptr elem_i = 0;
  for (; elem_i < length; elem_i++) {
    if (!_gdart_array_remove_array_element (self,
                                            param_type,
                                            param_type_klass,
                                            &buffer,
                                            dart_error_out,
                                            error)) {
      if (*error != NULL) return FALSE;
      return TRUE;
    }
  }
  return TRUE;
}

static gboolean _gdart_array_load_boolean_from_buffer (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  gboolean is_null_terminated,
  gpointer *buffer,
  gboolean *is_end_out,
  Dart_Handle *dart_elem_out, //out
  Dart_Handle *dart_error_out,
  GError **error)   //status
{
  gboolean result;
  _GDART_FUNCTION_READ_BUFFER_AND_ADVANCE (gboolean, buffer, result);
  if (is_null_terminated && result == FALSE) {
    *is_end_out = TRUE;
  } else {
    *is_end_out = FALSE;
    *dart_elem_out = Dart_NewBoolean ( (bool) result);
  }
  return TRUE;
}


static gboolean _gdart_array_load_int_from_buffer (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  gboolean is_null_terminated,
  GITypeTag type_tag,
  gpointer *buffer,
  gboolean *is_end_out,
  Dart_Handle *dart_elem_out, //out
  Dart_Handle *dart_error_out,
  GError **error)   //status
{
  int64_t raw_result;
  uint64_t raw_result_64;
  gboolean result_is_zero;
  switch (type_tag) {
  case GI_TYPE_TAG_INT8:
    _GDART_FUNCTION_READ_BUFFER_AND_ADVANCE_WITH_CAST (gint8, buffer, raw_result, gint64);
    result_is_zero = raw_result == 0;
    break;
  case GI_TYPE_TAG_UINT8:
    _GDART_FUNCTION_READ_BUFFER_AND_ADVANCE_WITH_CAST (guint8, buffer, raw_result, gint64);
    result_is_zero = raw_result == 0;
    break;
  case GI_TYPE_TAG_INT16:
    _GDART_FUNCTION_READ_BUFFER_AND_ADVANCE_WITH_CAST (gint16, buffer, raw_result, gint64);
    result_is_zero = raw_result == 0;
    break;
  case GI_TYPE_TAG_UINT16:
    _GDART_FUNCTION_READ_BUFFER_AND_ADVANCE_WITH_CAST (guint16, buffer, raw_result, gint64);
    result_is_zero = raw_result == 0;
    break;
  case GI_TYPE_TAG_INT32:
    _GDART_FUNCTION_READ_BUFFER_AND_ADVANCE_WITH_CAST (gint32, buffer, raw_result, gint64);
    result_is_zero = raw_result == 0;
    break;
  case GI_TYPE_TAG_UINT32:
    _GDART_FUNCTION_READ_BUFFER_AND_ADVANCE_WITH_CAST (guint32, buffer, raw_result, gint64);
    result_is_zero = raw_result == 0;
    break;
  case GI_TYPE_TAG_INT64:
    _GDART_FUNCTION_READ_BUFFER_AND_ADVANCE (gint64, buffer, raw_result);
    result_is_zero = raw_result == 0;
    break;
  case GI_TYPE_TAG_UINT64:
    _GDART_FUNCTION_READ_BUFFER_AND_ADVANCE (guint8, buffer, raw_result_64);
    result_is_zero = raw_result_64 == 0;
    break;
  case GI_TYPE_TAG_GTYPE:
    _GDART_FUNCTION_READ_BUFFER_AND_ADVANCE_WITH_CAST (GType, buffer, raw_result_64, guint64);
    result_is_zero = raw_result_64 == 0;
    break;
  default:
    *dart_error_out = gdart_bridge_context_create_error_handle (
                        self,
                        "%s: expected an integer-like type", G_STRFUNC);
    g_set_error (error, GDART_ERROR, 1,
                 "%s: expected an integer-like type", G_STRFUNC);
    return FALSE;
  }
  if (is_null_terminated && result_is_zero) {
    *is_end_out = TRUE;
    return TRUE;
  } else {
    *is_end_out = FALSE;
  }

  switch (type_tag) {
  case GI_TYPE_TAG_UINT64:
  case GI_TYPE_TAG_GTYPE:
    *dart_elem_out = Dart_NewIntegerFromUint64 (raw_result_64);
    break;
  default:
    *dart_elem_out = Dart_NewInteger (raw_result);
    break;
  }
  return TRUE;
}

static gboolean _gdart_array_load_num_from_buffer (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  gboolean is_null_terminated,
  GITypeTag type_tag,
  gpointer *buffer,
  gboolean *is_end_out,
  Dart_Handle *dart_elem_out, //out
  Dart_Handle *dart_error_out,
  GError **error)   //status
{
  gdouble raw_result;
  gboolean result_is_zero;
  switch (type_tag) {
  case GI_TYPE_TAG_FLOAT:
    _GDART_FUNCTION_READ_BUFFER_AND_ADVANCE_WITH_CAST (gfloat, buffer, raw_result, gdouble);
    break;
  case GI_TYPE_TAG_DOUBLE:
    _GDART_FUNCTION_READ_BUFFER_AND_ADVANCE (gdouble, buffer, raw_result);
    break;
  default:
    *dart_error_out = gdart_bridge_context_create_error_handle (
                        self,
                        "%s: expected an integer-like type", G_STRFUNC);
    g_set_error (error, GDART_ERROR, 1,
                 "%s: expected an integer-like type", G_STRFUNC);
    return FALSE;
  }
  result_is_zero = raw_result == 0;
  if (is_null_terminated && result_is_zero) {
    *is_end_out = TRUE;
    return TRUE;
  } else {
    *is_end_out = FALSE;
  }

  *dart_elem_out = Dart_NewDouble (raw_result);
  return TRUE;
}


static gboolean _gdart_array_load_string_from_buffer (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  gboolean is_null_terminated,
  GITypeTag type_tag,
  gboolean deallocate_members,
  gpointer *buffer,
  gboolean *is_end_out,
  Dart_Handle *dart_elem_out, //out
  Dart_Handle *dart_error_out,
  GError **error)   //status
{
  gchar *raw_result, *utf8result;
  gsize bytes_read, bytes_written;
  GError *inner_error = NULL;
  gintptr result_length;
  _GDART_FUNCTION_READ_BUFFER_AND_ADVANCE (gchar *, buffer, raw_result);
  if (is_null_terminated && raw_result == NULL) {
    *is_end_out = TRUE;
    return TRUE;
  } else if (raw_result == NULL) {
    *is_end_out = FALSE;
    *dart_elem_out = Dart_Null();
    return TRUE;
  } else {
    *is_end_out = FALSE;
  }
  switch (type_tag) {
  case GI_TYPE_TAG_UTF8:
    utf8result = raw_result;
    break;
  case GI_TYPE_TAG_FILENAME:
    utf8result = g_filename_to_utf8 (raw_result, -1, &bytes_read,
                                     &bytes_written,
                                     &inner_error);
    if (utf8result == NULL) {
      *dart_error_out = gdart_bridge_context_create_error_handle (
                          self,
                          "%s",
                          inner_error->message);
      g_propagate_error (error, inner_error);
      return FALSE;
    }
    if (deallocate_members) {
      g_free (raw_result);
    }
    deallocate_members = TRUE;
  default:
    *dart_error_out = gdart_bridge_context_create_error_handle (
                        self,
                        "%s: expected an integer-like type", G_STRFUNC);
    g_set_error (error, GDART_ERROR, 1,
                 "%s: expected an integer-like type", G_STRFUNC);
    return FALSE;
  }
  result_length = g_utf8_strlen (utf8result, -1);
  *dart_elem_out = Dart_NewStringFromUTF8 ( (guint8 *) utf8result, result_length);
  if (deallocate_members) {
    g_free (utf8result);
  }
  return TRUE;
}


static gboolean _gdart_array_load_enum_from_buffer (GdartBridgeContext *self,
    const gchar *name_prefix,
    gpointer base_info,
    const EnumInfoKlass *base_info_klass,
    gboolean is_null_terminated,
    gpointer *buffer,
    gboolean *is_end_out,
    Dart_Handle *dart_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  GITypeTag type_tag;
  Dart_Handle value, wrapper, result;
  gboolean is_end_out_inner;
  gchar* namespace_;
  GType gtype;

  if (!base_info_klass->get_storage_type (base_info,
                                          self,
                                          &type_tag,
                                          dart_error_out,
                                          error))
    return FALSE;
  if (!_gdart_array_load_int_from_buffer (self,
                                          name_prefix,
                                          is_null_terminated,
                                          type_tag,
                                          buffer,
                                          &is_end_out_inner,
                                          &value,
                                          dart_error_out,
                                          error)) {
    return FALSE;
  }
  if (is_end_out_inner) {
    *is_end_out = TRUE;
    return TRUE;
  }
  if (G_UNLIKELY(!base_info_klass->get_namespace(base_info,
                                      self,
				      &namespace_,
				      dart_error_out,
				      error)))
    return FALSE;
  if (G_UNLIKELY(!base_info_klass->get_gtype(base_info,
                                  self,
				  &gtype,
				  dart_error_out,
				  error)))
    return FALSE;
  wrapper = gdart_bridge_context_retrieve_wrapping_class (
              self,
              namespace_,
              gtype,
              base_info,
	      base_info_klass->cast_to_registered_type_info(base_info),
              TRUE,
              dart_error_out,
              error);
  g_free(namespace_);
  if (wrapper == NULL) return FALSE;
  result = Dart_New (wrapper, Dart_Null(), 1, &value);
  if (G_UNLIKELY(Dart_IsError (result))) {
    g_warning ("%s: dart threw an error", name_prefix);
    *dart_error_out = result;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
    return FALSE;
  }
  *dart_out = result;
  *is_end_out = FALSE;
  return TRUE;
}

static gboolean _gdart_array_load_wrapped_pointer_with_g_type_from_buffer (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  gboolean is_null_terminated,
  GType gtype,
  gboolean is_boxed_type,
  gpointer registered_type_info, //heap allocate
  const RegisteredTypeInfoKlass *registered_type_info_klass,
  gboolean must_copy,
  gpointer *buffer,
  gboolean *is_end_out,
  Dart_Handle *dart_elem_out,
  Dart_Handle *dart_error_out, //status
  GError **error)
{
  gpointer raw_result;
  GdartBridgeContextWrappedObject *object_wrapper;
  Dart_Handle internal_container, wrapped_object;
  gchar *namespace_;

  _GDART_FUNCTION_READ_BUFFER_AND_ADVANCE (gpointer, buffer, raw_result);

  if (raw_result == NULL && is_null_terminated) {
    *is_end_out = TRUE;
    return TRUE;
  } else if (raw_result == NULL) {
    *dart_elem_out = Dart_Null();
    *is_end_out = FALSE;
    return TRUE;
  }

  object_wrapper = g_slice_new (GdartBridgeContextWrappedObject);

  object_wrapper->type = gtype;
  if (registered_type_info != NULL) {
    object_wrapper->object_info = registered_type_info_klass->copy (registered_type_info);
    object_wrapper->object_info_klass = *registered_type_info_klass;

  } else {
    object_wrapper->object_info = NULL;
    object_wrapper->object_info_klass = null_registered_type_info;
  }
  if (!registered_type_info_klass->get_namespace (registered_type_info,
      self,
      &namespace_,
      dart_error_out,
      error)) {
    g_slice_free(GdartBridgeContextWrappedObject, object_wrapper);
    return FALSE;
  }

  object_wrapper->copy_func = (GBoxedCopyFunc)
                              gdart_bridge_context_retrieve_copy_func (self,
                                  namespace_,
                                  registered_type_info,
                                  registered_type_info_klass,
                                  gtype);

  object_wrapper->free_func = (GBoxedFreeFunc)
                              gdart_bridge_context_retrieve_free_func (self,
                                  namespace_,
                                  registered_type_info,
                                  registered_type_info_klass,
                                  gtype);
  if (must_copy && is_boxed_type) {
    object_wrapper->object = g_boxed_copy (gtype, raw_result);
    internal_container = gdart_bridge_context_wrap_pointer (self,
                         object_wrapper,
                         gdart_bridge_context_finalize_wrapped_boxed,
                         dart_error_out,
                         error);
  } else if (must_copy) {
    if (object_wrapper->copy_func == NULL) {
      gchar *name;
      if (!registered_type_info_klass->get_name (registered_type_info,
          self,
          &name,
          dart_error_out,
          error)) {
        g_slice_free(GdartBridgeContextWrappedObject, object_wrapper);
        g_free(namespace_);
        return FALSE;
      }
      g_warning ("%s: The GI type of an object to be bound was an [unowned %s."
                 "%s] but there's no registered copy function. "
                 "This can be unsafe if the object is used after it has "
                 "been invalidated by external code.",
                 name_prefix,
                 namespace_,
                 name);
      g_free(name);
      object_wrapper->object = raw_result;
      internal_container = gdart_bridge_context_wrap_pointer (self,
                           object_wrapper,
                           gdart_bridge_context_finalize_wrapped_unowned_struct,
                           dart_error_out,
                           error);
    } else {
      object_wrapper->object = object_wrapper->copy_func (raw_result);
      internal_container = gdart_bridge_context_wrap_pointer (self,
                           object_wrapper,
                           gdart_bridge_context_finalize_wrapped_custom_struct,
                           dart_error_out,
                           error);
    }
  } else {
    object_wrapper->object = raw_result;
    if (object_wrapper->copy_func == NULL) {
      internal_container = gdart_bridge_context_wrap_pointer (self,
                           object_wrapper,
                           gdart_bridge_context_finalize_wrapped_struct,
                           dart_error_out,
                           error);
    } else {
      internal_container = gdart_bridge_context_wrap_pointer (self,
                           object_wrapper,
                           gdart_bridge_context_finalize_wrapped_custom_struct,
                           dart_error_out,
                           error);
    }
  }
  if (internal_container == NULL) {
    return FALSE;
  g_free(namespace_);
  }
  wrapped_object = gdart_bridge_context_wrap_internal_pointer (self,
                   internal_container,
                   namespace_,
                   gtype,
                   registered_type_info,
                   registered_type_info_klass,
                   dart_error_out,
                   error);
  g_free(namespace_);
  if (wrapped_object == NULL) {
    return FALSE;
  }
  *dart_elem_out = wrapped_object;
  *is_end_out = FALSE;
  return TRUE;
}



static gboolean _gdart_array_load_wrapped_pointer_from_buffer (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  gboolean is_null_terminated,
  gpointer registered_type_info, //heap allocated
  const RegisteredTypeInfoKlass *registered_type_info_klass,
  GIInfoType info_type,
  gboolean must_copy,
  gpointer *buffer,
  gboolean *is_end_out,
  Dart_Handle *dart_elem_out,
  Dart_Handle *dart_error_out, //status
  GError **error)
{
  GType gtype;
  gpointer raw_result;
  GdartBridgeContextWrappedObject *object_wrapper;
  Dart_Handle internal_container, wrapped_object;
  GIRegisteredTypeInfo *type_info = NULL;
  _GDART_FUNCTION_READ_BUFFER_AND_ADVANCE (gpointer, buffer, raw_result);

  if (raw_result == NULL && is_null_terminated) {
    *is_end_out = TRUE;
    return TRUE;
  } else if (raw_result == NULL) {
    *dart_elem_out = Dart_Null();
    *is_end_out = FALSE;
    return TRUE;
  }

  object_wrapper = g_slice_new (GdartBridgeContextWrappedObject);
  if (!registered_type_info_klass->get_gtype (registered_type_info,
      self,
      &gtype,
      dart_error_out,
      error))
    return FALSE;

  if ( (info_type == GI_INFO_TYPE_OBJECT && g_type_is_a (gtype, G_TYPE_OBJECT))
       || (info_type == GI_INFO_TYPE_INTERFACE)) {
    GObject *object = (GObject *) raw_result;

    gtype = G_OBJECT_TYPE (object);
    type_info = (GIRegisteredTypeInfo *) g_irepository_find_by_gtype (
                  gdart_bridge_context_get_gi_repository (self),
                  gtype);
  }

  object_wrapper->type = gtype;
  if (type_info == NULL) {
    object_wrapper->object_info = registered_type_info_klass->copy (registered_type_info);
    object_wrapper->object_info_klass = *registered_type_info_klass;
  } else {
    object_wrapper->object_info = registered_type_info = type_info;
    object_wrapper->object_info_klass = gi_registered_type_info_registered_type_info;
    registered_type_info_klass = &gi_registered_type_info_registered_type_info;
  }
  gchar *namespace_;
  if (!registered_type_info_klass->get_namespace (registered_type_info,
        self,
        &namespace_,
        dart_error_out,
        error)) {
      registered_type_info_klass->free (object_wrapper->object_info);
      return FALSE;
  }

  switch (info_type) {
  case GI_INFO_TYPE_UNION:
  case GI_INFO_TYPE_STRUCT: {
    object_wrapper->copy_func = (GBoxedCopyFunc)
                                gdart_bridge_context_retrieve_copy_func (self,
                                    namespace_,
                                    registered_type_info,
                                    registered_type_info_klass,
                                    gtype);

    object_wrapper->free_func = (GBoxedFreeFunc)
                                gdart_bridge_context_retrieve_free_func (self,
                                    namespace_,
                                    registered_type_info,
                                    registered_type_info_klass,
                                    gtype);
    if (must_copy) {
      if (object_wrapper->copy_func == NULL) {
        gchar *name;
        if (!registered_type_info_klass->get_name (registered_type_info,
            self,
            &name,
            dart_error_out,
            error)) {
	  g_free(namespace_);
          registered_type_info_klass->free (object_wrapper->object_info);
          return FALSE;
        }

        g_warning ("%s: The GI type of an object to be bound was an [unowned %s."
                   "%s] but there's no registered copy function. "
                   "This can be unsafe if the object is used after it has "
                   "been invalidated by external code.",
                   name_prefix,
                   namespace_,
                   name);
        object_wrapper->object = raw_result;
        internal_container = gdart_bridge_context_wrap_pointer (self,
                             object_wrapper,
                             gdart_bridge_context_finalize_wrapped_unowned_struct,
                             dart_error_out,
                             error);
	g_free(name);
      } else {
        object_wrapper->object = object_wrapper->copy_func (raw_result);
        internal_container = gdart_bridge_context_wrap_pointer (self,
                             object_wrapper,
                             gdart_bridge_context_finalize_wrapped_custom_struct,
                             dart_error_out,
                             error);
      }
    } else {
      object_wrapper->object = raw_result;
      if (object_wrapper->copy_func == NULL) {
        internal_container = gdart_bridge_context_wrap_pointer (self,
                             object_wrapper,
                             gdart_bridge_context_finalize_wrapped_struct,
                             dart_error_out,
                             error);
      } else {
        internal_container = gdart_bridge_context_wrap_pointer (self,
                             object_wrapper,
                             gdart_bridge_context_finalize_wrapped_custom_struct,
                             dart_error_out,
                             error);
      }
    }
  }
  break;
  case GI_INFO_TYPE_BOXED:
    if (must_copy) {
      raw_result = g_boxed_copy (gtype, raw_result);
    }
    object_wrapper->object = raw_result;
    internal_container = gdart_bridge_context_wrap_pointer (self,
                         object_wrapper,
                         gdart_bridge_context_finalize_wrapped_boxed,
                         dart_error_out,
                         error);
    break;
  case GI_INFO_TYPE_INTERFACE:
  case GI_INFO_TYPE_OBJECT:
    if (must_copy) {
      GIObjectInfoRefFunction refer;
      if (G_UNLIKELY(!registered_type_info_klass->cast_to_object_info(registered_type_info)->get_ref_function_pointer(registered_type_info,
	                                                                                                   self,
													   &refer,
													   dart_error_out,
													   error))) {
        registered_type_info_klass->free (object_wrapper->object_info);
        return FALSE;
      }
      if (refer != NULL) {
        raw_result = refer (raw_result);
      } else {
        raw_result = g_object_ref_sink (raw_result);
        //if this is the main result, assume we are given a floating reference.
      }
    }
    object_wrapper->object = raw_result;
    internal_container = gdart_bridge_context_wrap_pointer (self,
                         object_wrapper,
                         gdart_bridge_context_finalize_wrapped_gobject,
                         dart_error_out,
                         error);
    break;
  default:
    g_assert_not_reached();
  }
  if (internal_container == NULL) {
    return FALSE;
  }
  wrapped_object = gdart_bridge_context_wrap_internal_pointer (self,
                   internal_container,
                   namespace_,
                   gtype,
                   registered_type_info,
		   registered_type_info_klass,
                   dart_error_out,
                   error);
  g_free(namespace_);
  if (wrapped_object == NULL) {
    return FALSE;
  }
  *dart_elem_out = wrapped_object;
  *is_end_out = FALSE;
  return TRUE;
}


static gboolean _gdart_function_result_load_interface_from_buffer (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  gboolean is_null_terminated,
  gpointer type_info,
  const TypeInfoKlass *type_info_klass,
  gboolean must_copy,
  gpointer *buffer,
  gboolean *is_end_out,
  Dart_Handle *dart_elem_out,
  Dart_Handle *dart_error_out, //status
  GError **error)
{
  gpointer base_info;
  const InterfaceInfoKlass *base_info_klass;

  GIInfoType info_type;
  gboolean result;

  if (!type_info_klass->get_interface (type_info,
                                       self,
                                       &base_info,
                                       &base_info_klass,
                                       dart_error_out,
                                       error))
    return FALSE;
  if (!base_info_klass->get_type (base_info,
                                  self,
                                  &info_type,
                                  dart_error_out,
                                  error)) {
    base_info_klass->free (base_info);
    return FALSE;
  }
  switch (info_type) {
  case GI_INFO_TYPE_CALLBACK:
    *dart_error_out = gdart_bridge_context_create_error_handle (self,
                      "%s: can't handle callbacks yet", G_STRFUNC);
    g_set_error (error, GDART_ERROR, 1,
                 "%s: can't handle callbacks yet", G_STRFUNC);
    base_info_klass->free (base_info);
    return FALSE;
  case GI_INFO_TYPE_STRUCT:
  case GI_INFO_TYPE_BOXED:
  case GI_INFO_TYPE_UNION:
  case GI_INFO_TYPE_OBJECT: {
    result = _gdart_array_load_wrapped_pointer_from_buffer (self,
             name_prefix,
             is_null_terminated,
             base_info,
             base_info_klass->cast_to_registered_type_info(base_info),
             info_type,
             must_copy,
             buffer,
             is_end_out,
             dart_elem_out,
             dart_error_out,
             error);
    base_info_klass->free (base_info);
    return result;
    case GI_INFO_TYPE_ENUM:
    case GI_INFO_TYPE_FLAGS: {
      const EnumInfoKlass *klass;
      klass = base_info_klass->cast_to_enum_info (base_info);
      result = _gdart_array_load_enum_from_buffer (self,
               name_prefix,
               base_info,
               klass,
               is_null_terminated,
               buffer,
               is_end_out,
               dart_elem_out,
               dart_error_out,
               error);
      base_info_klass->free (base_info);
      return result;
    }
    case GI_INFO_TYPE_INTERFACE:
      *dart_error_out = gdart_bridge_context_create_error_handle (self,
                        "%s: can't handle interfaces yet", G_STRFUNC);
      g_set_error (error, GDART_ERROR, 1,
                   "%s: can't handle interfaces yet", G_STRFUNC);
      g_base_info_unref (base_info);
      return FALSE;
    default:
      *dart_error_out = gdart_bridge_context_create_error_handle (self,
                        "%s: received an unexpected base info type", G_STRFUNC);
      g_set_error (error, GDART_ERROR, 1,
                   "%s: received an unexpected base info type", G_STRFUNC);
      g_base_info_unref (base_info);
      return FALSE;
    }
  }
}


static gboolean _gdart_array_load_element (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  gpointer param_type,
  const TypeInfoKlass *param_type_klass,
  gboolean is_null_terminated,
  gboolean deallocate_members,
  gpointer *buffer,
  gboolean *is_end,
  Dart_Handle *dart_elem_out,
  Dart_Handle *dart_error_out,
  GError **error)
{
  GITypeTag type_tag;
  if (!param_type_klass->get_tag (param_type,
                                  self,
                                  &type_tag,
                                  dart_error_out,
                                  error))
    return FALSE;
  switch (type_tag) {
  case GI_TYPE_TAG_BOOLEAN:
    return _gdart_array_load_boolean_from_buffer (self,
           name_prefix,
           is_null_terminated,
           buffer,
           is_end,
           dart_elem_out,
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
    return _gdart_array_load_int_from_buffer (self,
           name_prefix,
           is_null_terminated,
           type_tag,
           buffer,
           is_end,
           dart_elem_out,
           dart_error_out,
           error);
  case GI_TYPE_TAG_FLOAT:
  case GI_TYPE_TAG_DOUBLE:
    return _gdart_array_load_num_from_buffer (self,
           name_prefix,
           is_null_terminated,
           type_tag,
           buffer,
           is_end,
           dart_elem_out,
           dart_error_out,
           error);
  case GI_TYPE_TAG_UTF8:
  case GI_TYPE_TAG_FILENAME:
    return _gdart_array_load_string_from_buffer (self,
           name_prefix,
           is_null_terminated,
           type_tag,
           deallocate_members,
           buffer,
           is_end,
           dart_elem_out,
           dart_error_out,
           error);
    /*  case GI_TYPE_TAG_ARRAY:
            return _gdart_function_argument_load_array_from_buffer(self,
                    is_null_terminated,
                    type_tag,
                    deallocate_members,
                    buffer,
                    is_end,
                    dart_elem_out,
                    dart_error_out,
                    error);
    */
  case GI_TYPE_TAG_INTERFACE:
    return _gdart_function_result_load_interface_from_buffer (self,
           name_prefix,
           is_null_terminated,
           param_type,
           param_type_klass,
           !deallocate_members,
           buffer,
           is_end,
           dart_elem_out,
           dart_error_out,
           error);
  case GI_TYPE_TAG_GLIST:
    return _gdart_array_load_wrapped_pointer_with_g_type_from_buffer (
             self,
             name_prefix,
             is_null_terminated,
             G_DART_COMPAT_LIST_TYPE,
             FALSE,
             NULL,
             &null_registered_type_info,
             !deallocate_members,
             buffer,
             is_end,
             dart_elem_out,
             dart_error_out,
             error);

  case GI_TYPE_TAG_GSLIST:
    return _gdart_array_load_wrapped_pointer_with_g_type_from_buffer (
             self,
             name_prefix,
             is_null_terminated,
             G_DART_COMPAT_SLIST_TYPE,
             FALSE,
             NULL,
             &null_registered_type_info,
             !deallocate_members,
             buffer,
             is_end,
             dart_elem_out,
             dart_error_out,
             error);
  case GI_TYPE_TAG_GHASH: {
    GIRegisteredTypeInfo *type_info;
    gboolean result;

    type_info = (GIRegisteredTypeInfo *) g_irepository_find_by_gtype (
                  gdart_bridge_context_get_gi_repository (self),
                  G_TYPE_HASH_TABLE); //heap allocated
    result = _gdart_array_load_wrapped_pointer_with_g_type_from_buffer (
               self,
               name_prefix,
               is_null_terminated,
               G_TYPE_HASH_TABLE,
               TRUE,
               type_info,
               &gi_registered_type_info_registered_type_info,
               !deallocate_members,
               buffer,
               is_end,
               dart_elem_out,
               dart_error_out,
               error);
    g_base_info_unref ( (GIBaseInfo *) type_info);
    return result;
  }
  case GI_TYPE_TAG_ERROR: {
    GIRegisteredTypeInfo *type_info;
    gboolean result;

    type_info = (GIRegisteredTypeInfo *) g_irepository_find_by_gtype (
                  gdart_bridge_context_get_gi_repository (self),
                  G_TYPE_ERROR); //heap allocated
    result = _gdart_array_load_wrapped_pointer_with_g_type_from_buffer (
               self,
               name_prefix,
               is_null_terminated,
               G_TYPE_ERROR,
               TRUE,
               type_info,
               &gi_registered_type_info_registered_type_info,
               !deallocate_members,
               buffer,
               is_end,
               dart_elem_out,
               dart_error_out,
               error);
    g_base_info_unref ( (GIBaseInfo *) type_info);
    return result;
  }
  default:
    *dart_error_out = gdart_bridge_context_create_error_handle (self,
                      "%s: got an unexpected type", G_STRFUNC);
    g_set_error (error, GDART_ERROR, 1,
                 "%s: got an unexpected type", G_STRFUNC);
    return FALSE;
  }
}


gboolean gdart_array_load_parameters (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  gpointer param_type,
  const TypeInfoKlass *param_type_klass,
  gint length,
  gboolean is_null_terminated,
  gboolean deallocate_members,
  gpointer buffer,
  Dart_Handle *dart_list_out,
  Dart_Handle *dart_error_out,
  GError **error)
{
  gintptr elem_i = 0;
  gint initial_length;
  Dart_Handle *list_elements;
  Dart_Handle dart_list;
  initial_length = is_null_terminated ? 32 : length;

  list_elements = g_new (Dart_Handle, initial_length);

  for (; is_null_terminated || elem_i < length; elem_i++) {
    Dart_Handle *dart_elem_out;
    gboolean is_at_end;
    if (elem_i >= initial_length) {
      initial_length *= 2;
      list_elements = g_renew (Dart_Handle, list_elements, initial_length);
    }
    dart_elem_out = &list_elements[elem_i];
    if (!_gdart_array_load_element (self,
                                    name_prefix,
                                    param_type,
                                    param_type_klass,
                                    is_null_terminated,
                                    deallocate_members,
                                    &buffer,
                                    &is_at_end,
                                    dart_elem_out,
                                    dart_error_out,
                                    error)) {
      g_free (list_elements);
      return FALSE;
    }
    if (is_at_end) break;
  }
  dart_list = Dart_NewList (elem_i);
  for (elem_i--; elem_i >= 0; elem_i--) {
    Dart_ListSetAt (dart_list, elem_i, list_elements[elem_i]);
  }
  g_free (list_elements);
  *dart_list_out = dart_list;
  return TRUE;
}
