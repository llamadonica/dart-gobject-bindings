// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
//

#include "array.h"
#include "function.h"
#include "common.h"
#include "object_wrapper.h"
#include "bridge_context.h"

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

typedef struct _GdartCallbackTrampoline GdartCallbackTrampoline;

///{{{ Forward definitions

static void gdart_callback_closure_notify (gpointer data);
static void _gdart_callback_closure (ffi_cif *cif,
                                     void *result,
                                     void **args,
                                     void *data);
static void _gdart_callback_closure_free_trampoline (GdartCallbackTrampoline *trampoline);

///}}}

///{{{ Interface-like stuff

///}}}

struct _GdartCallbackTrampoline {
  GdartBridgeContext *self;
  Dart_PersistentHandle closure_dart;
  gpointer signal_info;
  CallableInfoKlass signal_info_klass;
  ffi_cif cif;
  ffi_closure *closure;
  gboolean user_data_present;
  gboolean is_one_shot;
  gchar *closure_name;
};

static gboolean _gdart_function_argument_fill_boolean (
  Dart_Handle element,
  GArgument *main_argument,
  GArgument *in_arg_cvalues,
  gpointer  *ffi_arg_pointers,
  gint *c_arg_pos,
  Dart_Handle *dart_error_out,
  GError **error)
{
  bool result;
  Dart_Handle temp_result;
  temp_result = Dart_BooleanValue (element, &result);
  if (G_UNLIKELY (Dart_IsError (temp_result))) {
    *dart_error_out = temp_result;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
    goto error;
  }
  main_argument->v_boolean = (gboolean) result;
  if (ffi_arg_pointers != NULL) {
    g_assert (main_argument == &in_arg_cvalues[*c_arg_pos]);
    ffi_arg_pointers[*c_arg_pos] = main_argument;
    (*c_arg_pos) ++;
  }
  return TRUE;
error:
  return FALSE;
}

static gboolean _gdart_function_argument_fill_in_boolean (
  Dart_Handle dart_args,
  gint *dart_arg_pos,
  GArgument *main_argument,
  GArgument *in_arg_cvalues,
  gpointer  *ffi_arg_pointers,
  gint *c_arg_pos,
  Dart_Handle *dart_error_out,
  GError **error)
{
  Dart_Handle element;
  element = Dart_ListGetAt (dart_args, (*dart_arg_pos) ++);
  if (G_UNLIKELY (Dart_IsError (element))) {
    *dart_error_out = element;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
    goto error;
  }
  return _gdart_function_argument_fill_boolean (
           element,
           main_argument,
           in_arg_cvalues,
           ffi_arg_pointers,
           c_arg_pos,
           dart_error_out,
           error);
error:
  return FALSE;
}

static gboolean _gdart_function_argument_fill_int_raw (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  int64_t raw_result,
  uint64_t raw_result_64,
  GArgument *main_argument,
  GArgument *in_arg_cvalues,
  gint c_arg_pos,
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
    main_argument->v_int8 = (gint8) raw_result;
    break;
  case GI_TYPE_TAG_UINT8:
    if (raw_result > G_MAXUINT8 || raw_result < 0) {
      g_warning ("%s: Integer was out of bounds. Result will be clamped.",
                 name_prefix);
      raw_result = CLAMP (raw_result, 0, G_MAXUINT8);
    }
    main_argument->v_uint8 = (guint8) raw_result;
    break;
  case GI_TYPE_TAG_INT16:
    if (raw_result > G_MAXINT16 || raw_result < G_MININT16) {
      g_warning ("%s: Integer was out of bounds. Result will be clamped.",
                 name_prefix);
      raw_result = CLAMP (raw_result, G_MININT16, G_MAXINT16);
    }
    main_argument->v_int16 = (gint16) raw_result;
    break;
  case GI_TYPE_TAG_UINT16:
    if (raw_result > G_MAXUINT16 || raw_result < 0) {
      g_warning ("%s: Integer was out of bounds. Result will be clamped.",
                 name_prefix);
      raw_result = CLAMP (raw_result, 0, G_MAXUINT16);
    }
    main_argument->v_uint16 = (guint16) raw_result;
    break;
  case GI_TYPE_TAG_INT32:
    if (raw_result > G_MAXINT32 || raw_result < G_MININT32) {
      g_warning ("%s: Integer was out of bounds. Result will be clamped.",
                 name_prefix);
      raw_result = CLAMP (raw_result, G_MININT32, G_MAXINT32);
    }
    main_argument->v_int32 = (gint32) raw_result;
    break;
  case GI_TYPE_TAG_UINT32:
    if (raw_result > G_MAXUINT32 || raw_result < 0) {
      g_warning ("%s: Integer was out of bounds. Result will be clamped.",
                 name_prefix);
      raw_result = CLAMP (raw_result, 0, G_MAXUINT32);
    }
    main_argument->v_uint32 = (guint32) raw_result;
    break;
  case GI_TYPE_TAG_INT64:
    main_argument->v_int64 = raw_result;
    break;
  case GI_TYPE_TAG_UINT64:
    main_argument->v_uint64 = raw_result_64;
    break;
  case GI_TYPE_TAG_GTYPE:
    main_argument->v_size = raw_result_64;
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

static gboolean _gdart_function_argument_fill_int (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  Dart_Handle element,
  GArgument *main_argument,
  GArgument *in_arg_cvalues,
  gpointer  *ffi_arg_pointers,
  gint *c_arg_pos,
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
  if (G_UNLIKELY (Dart_IsError (temp_result))) {
    *dart_error_out = temp_result;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
    goto error;
  }
  if (!_gdart_function_argument_fill_int_raw (self,
      name_prefix,
      raw_result,
      raw_result_64,
      main_argument,
      in_arg_cvalues,
      *c_arg_pos,
      type_tag,
      dart_error_out,
      error)) {
    return FALSE;
  }
  if (ffi_arg_pointers != NULL) {
    g_assert (main_argument == &in_arg_cvalues[*c_arg_pos]);
    ffi_arg_pointers[*c_arg_pos] = main_argument;
    (*c_arg_pos) ++;
  }
  return TRUE;
error:
  return FALSE;
}

static gboolean _gdart_function_argument_fill_in_int (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  Dart_Handle dart_args,
  gint *dart_arg_pos,
  GArgument *main_argument,
  GArgument *in_arg_cvalues,
  gpointer  *ffi_arg_pointers,
  gint *c_arg_pos,
  GITypeTag type_tag,
  Dart_Handle *dart_error_out,
  GError **error)
{
  Dart_Handle element;
  element = Dart_ListGetAt (dart_args, (*dart_arg_pos) ++);
  if (G_UNLIKELY (Dart_IsError (element))) {
    *dart_error_out = element;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
    goto error;
  }
  return _gdart_function_argument_fill_int (self,
         name_prefix,
         element,
         main_argument,
         in_arg_cvalues,
         ffi_arg_pointers,
         c_arg_pos,
         type_tag,
         dart_error_out,
         error);
error:
  return FALSE;
}

static gboolean _gdart_function_argument_fill_num (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  Dart_Handle element,
  GArgument *main_argument,
  GArgument *in_arg_cvalues,
  gpointer  *ffi_arg_pointers,
  gint *c_arg_pos,
  GITypeTag type_tag,
  Dart_Handle *dart_error_out,
  GError **error)
{
  Dart_Handle temp_result;
  gfloat float_result;
  gdouble double_result;

  if (Dart_IsInteger (element)) {
    int64_t raw_result;
    temp_result = Dart_IntegerToInt64 (element, &raw_result);
    if (G_UNLIKELY (Dart_IsError (temp_result))) {
      *dart_error_out = temp_result;
      g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
      goto error;
    }
    double_result = (gdouble) raw_result;
  } else { // Double
    temp_result = Dart_DoubleValue (element, &double_result);
    if (G_UNLIKELY (Dart_IsError (temp_result))) {
      *dart_error_out = temp_result;
      g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
      goto error;
    }
  }
  switch (type_tag) {
  case GI_TYPE_TAG_FLOAT:
    float_result = (gfloat) double_result;
    main_argument->v_float = float_result;
    break;
  case GI_TYPE_TAG_DOUBLE:
    main_argument->v_double = double_result;
    break;
  default:
    *dart_error_out = gdart_bridge_context_create_error_handle (
                        self,
                        "%s: expected an number-like type", G_STRFUNC);
    g_set_error (error, GDART_ERROR, 1,
                 "%s: expected an number-like type", G_STRFUNC);
    goto error;
  }
  if (ffi_arg_pointers != NULL) {
    g_assert (main_argument == &in_arg_cvalues[*c_arg_pos]);
    ffi_arg_pointers[*c_arg_pos] = main_argument;
    (*c_arg_pos) ++;
  }
  return TRUE;
error:
  return FALSE;
}

static gboolean _gdart_function_argument_fill_in_num (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  Dart_Handle dart_args,
  gint *dart_arg_pos,
  GArgument *main_argument,
  GArgument *in_arg_cvalues,
  gpointer  *ffi_arg_pointers,
  gint *c_arg_pos,
  GITypeTag type_tag,
  Dart_Handle *dart_error_out,
  GError **error)
{
  Dart_Handle element;
  element = Dart_ListGetAt (dart_args, (*dart_arg_pos) ++);
  if (G_UNLIKELY (Dart_IsError (element))) {
    *dart_error_out = element;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
    goto error;
  }
  return _gdart_function_argument_fill_num (self,
         name_prefix,
         element,
         main_argument,
         in_arg_cvalues,
         ffi_arg_pointers,
         c_arg_pos,
         type_tag,
         dart_error_out,
         error);
error:
  return FALSE;
}

static void _gdart_function_argument_unfill_in_string (
  GdartBridgeContext *self,
  GArgument *in_arg_cvalues,
  gint *c_arg_pos)
{
  g_free (in_arg_cvalues[*c_arg_pos].v_string);
  (*c_arg_pos) ++;
}

static gboolean _gdart_function_argument_fill_string (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  Dart_Handle element,
  GArgument *main_argument,
  GArgument *in_arg_cvalues,
  gpointer  *ffi_arg_pointers,
  gint *c_arg_pos,
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
    main_argument->v_pointer = NULL;
    if (ffi_arg_pointers != NULL) {
      g_assert (main_argument == &in_arg_cvalues[*c_arg_pos]);
      ffi_arg_pointers[*c_arg_pos] = main_argument;
      (*c_arg_pos) ++;
    }
    return TRUE;
  }
  temp_result = Dart_StringToUTF8 (element, &original_string, &string_length);
  if (G_UNLIKELY (Dart_IsError (temp_result))) {
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
  main_argument->v_string = resulting_string;
  if (ffi_arg_pointers != NULL) {
    g_assert (main_argument == &in_arg_cvalues[*c_arg_pos]);
    ffi_arg_pointers[*c_arg_pos] = main_argument;
    (*c_arg_pos) ++;
  }
  return TRUE;
error:
  return FALSE;
}

static gboolean _gdart_function_argument_fill_in_string (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  Dart_Handle dart_args,
  gint *dart_arg_pos,
  GArgument *main_argument,
  GArgument *in_arg_cvalues,
  gpointer  *ffi_arg_pointers,
  gint *c_arg_pos,
  GITypeTag type_tag,
  Dart_Handle *dart_error_out,
  GError **error)
{
  Dart_Handle element;
  element = Dart_ListGetAt (dart_args, (*dart_arg_pos) ++);
  if (G_UNLIKELY (Dart_IsError (element))) {
    *dart_error_out = element;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
    goto error;
  }
  return _gdart_function_argument_fill_string (self,
         name_prefix,
         element,
         main_argument,
         in_arg_cvalues,
         ffi_arg_pointers,
         c_arg_pos,
         type_tag,
         dart_error_out,
         error);
error:
  return FALSE;
}

static gboolean _gdart_function_argument_fill_wrapped_pointer (
  GdartBridgeContext *self,
  Dart_Handle element,
  const gchar *name_prefix,
  gboolean is_transfer_full,
  GArgument *main_argument,
  GArgument *in_arg_cvalues,
  gpointer  *ffi_arg_pointers,
  gint *c_arg_pos,
  Dart_Handle *dart_error_out,
  GError **error)
{
  Dart_Handle temp_result, inner_container, name_handle;
  RawPointerContainer *raw_pointer;

  gpointer type_info;
  const RegisteredTypeInfoKlass *type_info_klass;

  GdartBridgeContextWrappedObject *object_info;
  void *object;

  GIInfoType info_type_tag;

  if (Dart_IsNull (element)) {
    main_argument->v_pointer = NULL;
    if (ffi_arg_pointers != NULL) {
      g_assert (main_argument == &in_arg_cvalues[*c_arg_pos]);
      ffi_arg_pointers[*c_arg_pos] = main_argument;
      (*c_arg_pos) ++;
    }
    return TRUE;
  }
  name_handle = Dart_NewStringFromCString ("_internal");
  if (G_UNLIKELY (Dart_IsError (name_handle))) {
    *dart_error_out = name_handle;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
    return FALSE;
  }
  inner_container = Dart_GetField (element, name_handle);
  if (G_UNLIKELY (Dart_IsError (inner_container))) {
    *dart_error_out = inner_container;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
    return FALSE;
  }
  temp_result = Dart_GetNativeInstanceField (inner_container, 0, (intptr_t *) &raw_pointer);
  if (G_UNLIKELY (Dart_IsError (temp_result))) {
    *dart_error_out = temp_result;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
    return FALSE;
  }
  object_info = (GdartBridgeContextWrappedObject *) raw_pointer->raw_pointer;
  object = object_info->object;

  type_info = object_info->object_info;
  type_info_klass = &object_info->object_info_klass;

  if (G_UNLIKELY (!type_info_klass->get_type (type_info,
                  self,
                  &info_type_tag,
                  dart_error_out,
                  error))) {
    return FALSE;
  }

  if (is_transfer_full) {
    switch (info_type_tag) {
    case GI_INFO_TYPE_OBJECT: {
      const ObjectInfoKlass *klass;
      GIObjectInfoRefFunction refer;
      GdartFunctionReference *refer_reference;

      klass = type_info_klass->cast_to_object_info (type_info);
      if (!klass->get_ref_function_pointer (type_info,
                                            self,
                                            &refer,
                                            &refer_reference,
                                            dart_error_out,
                                            error)) {
        return FALSE;
      }
      gdart_function_reference_unref (refer_reference);
      object = refer (object);
      break;
    }
    case GI_INFO_TYPE_BOXED:
      object = g_boxed_copy (object_info->type, object);
      break;
    case GI_INFO_TYPE_STRUCT:
    case GI_INFO_TYPE_UNION: {
      gchar *namespace_;
      gchar *name;
      if (G_UNLIKELY (!type_info_klass->get_name (type_info,
                      self,
                      &name,
                      dart_error_out,
                      error))) {
        return FALSE;
      }
      if (G_UNLIKELY (!type_info_klass->get_namespace (type_info,
                      self,
                      &namespace_,
                      dart_error_out,
                      error))) {
        g_free (name);
        return FALSE;
      }

      g_warning ("%s: The GI type of an object leaving dart was an [owned %s.%s] "
                 "but there's no copy function registered. "
                 "This can be unsafe if the object is used after it has "
                 "been invalidated by external code.",
                 name_prefix,
                 namespace_,
                 name);
      g_free (namespace_);
      g_free (name);
    }
    default:
      break;
    }
  }

  main_argument->v_pointer = object;
  if (ffi_arg_pointers != NULL) {
    g_assert (main_argument == &in_arg_cvalues[*c_arg_pos]);
    ffi_arg_pointers[*c_arg_pos] = main_argument;
    (*c_arg_pos) ++;
  }
  return TRUE;
}

static void _gdart_function_argument_fill_raw_pointer (
  const gchar *name_prefix,
  gpointer object,
  GArgument *main_argument,
  GArgument *in_arg_cvalues,
  gpointer  *ffi_arg_pointers,
  gint *c_arg_pos)
{
  main_argument->v_pointer = object;
  if (ffi_arg_pointers != NULL) {
    g_assert (main_argument == &in_arg_cvalues[*c_arg_pos]);
    ffi_arg_pointers[*c_arg_pos] = main_argument;
    (*c_arg_pos) ++;
  }
}

static gboolean _gdart_function_argument_fill_callback (GdartBridgeContext *self,
    const gchar *name_prefix,
    Dart_Handle element,
    gpointer callback_info,
    const CallableInfoKlass *callback_info_klass,
    gboolean is_method,
    gpointer arg_info,
    const ArgInfoKlass *arg_info_klass,
    GIScopeType scope,
    GdartCallbackTrampoline **trampolines,
    gint trampolines_length,
    GArgument *main_argument,
    GArgument *in_arg_cvalues,
    gpointer *ffi_arg_pointers,
    gint *c_arg_pos,
    Dart_Handle *dart_error_out,
    GError **error)
{
  gboolean is_one_shot;
  gint user_data;

  is_one_shot = scope == GI_SCOPE_TYPE_ASYNC;

  GdartCallbackTrampoline *trampoline;
  trampoline = g_slice_new (GdartCallbackTrampoline);

  if (!arg_info_klass->get_closure (arg_info,
                                    self,
                                    &user_data,
                                    dart_error_out,
                                    error)) {
    g_slice_free (GdartCallbackTrampoline, trampoline);
    return FALSE;
  }
  if (user_data != -1) {
    gint user_data_c_pos = is_method ? user_data + 1 : user_data;
    _gdart_function_argument_fill_raw_pointer (
      name_prefix,
      trampoline,
      &in_arg_cvalues[user_data_c_pos],
      in_arg_cvalues,
      ffi_arg_pointers,
      &user_data_c_pos);
  }
  if (!callback_info_klass->prepare_closure (callback_info,
      self,
      &trampoline->cif,
      _gdart_callback_closure,
      trampoline,
      &trampoline->closure,
      dart_error_out,
      error)) {
    g_slice_free (GdartCallbackTrampoline, trampoline);
    return FALSE;
  }

  trampoline->closure_dart = Dart_NewPersistentHandle (element);
  trampoline->signal_info = callback_info_klass->copy (callback_info);
  if (trampoline->signal_info == NULL) {
    g_slice_free (GdartCallbackTrampoline, trampoline);
    return FALSE;
  }
  trampoline->self = (GdartBridgeContext *) g_object_ref (G_OBJECT (self));
  trampoline->signal_info_klass = *callback_info_klass;
  trampoline->user_data_present = user_data != -1;
  trampoline->is_one_shot = is_one_shot;
  trampoline->closure_name = g_strdup (name_prefix);

  if (scope == GI_SCOPE_TYPE_CALL) {
    gint trampolines_pos = 0;

    if (trampolines_length == 0) {
      *dart_error_out = gdart_bridge_context_create_error_handle (self,
                        "%s: the callback was call allocated, but it wasn"
                        "'t clear when the callback should be deallocated",
                        G_STRFUNC);
      g_set_error (error, GDART_ERROR, 1,
                   "%s: the callback was call allocated, but it wasn"
                   "'t clear when the callback should be deallocated",
                   G_STRFUNC);
      g_slice_free (GdartCallbackTrampoline, trampoline);
      return FALSE;
    }
    for (; trampolines_pos < trampolines_length; trampolines_pos++) {
      if (trampolines[trampolines_pos] == NULL) {
        trampolines[trampolines_pos] = trampoline;
        break;
      }
    }
  } else if (scope == GI_SCOPE_TYPE_ASYNC) {
  } else if (scope == GI_SCOPE_TYPE_NOTIFIED) {
    gint destroy_notify, destroy_notify_c_pos;
    if (!arg_info_klass->get_destroy (arg_info,
                                      self,
                                      &destroy_notify,
                                      dart_error_out,
                                      error)) {
      g_slice_free (GdartCallbackTrampoline, trampoline);
      return FALSE;
    }
    destroy_notify_c_pos = is_method ? destroy_notify + 1 : destroy_notify;
    _gdart_function_argument_fill_raw_pointer (
      name_prefix,
      gdart_callback_closure_notify,
      &in_arg_cvalues[destroy_notify_c_pos],
      in_arg_cvalues,
      ffi_arg_pointers,
      &destroy_notify_c_pos);
  }
  _gdart_function_argument_fill_raw_pointer (
    name_prefix,
    trampoline->closure,
    main_argument,
    in_arg_cvalues,
    ffi_arg_pointers,
    c_arg_pos);
  return TRUE;
}

static gboolean _gdart_function_argument_fill_in_callback (GdartBridgeContext *self,
    const gchar *name_prefix,
    Dart_Handle dart_args,
    gint *dart_arg_pos,
    gboolean is_method,
    gpointer callback_info,
    const CallableInfoKlass *callback_info_klass,
    gpointer arg_info,
    const ArgInfoKlass *arg_info_klass,
    GIScopeType scope,
    GdartCallbackTrampoline **trampolines,
    gint trampolines_length,
    GArgument *main_argument,
    GArgument *in_arg_cvalues,
    gpointer *ffi_arg_pointers,
    gint *c_arg_pos,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle element;
  element = Dart_ListGetAt (dart_args, (*dart_arg_pos) ++);
  if (G_UNLIKELY (Dart_IsError (element))) {
    *dart_error_out = element;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
    goto error;
  }
  return _gdart_function_argument_fill_callback (
           self,
           name_prefix,
           element,
           callback_info,
           callback_info_klass,
           is_method,
           arg_info,
           arg_info_klass,
           scope,
           trampolines,
           trampolines_length,
           main_argument,
           in_arg_cvalues,
           ffi_arg_pointers,
           c_arg_pos,
           dart_error_out,
           error);
error:
  return FALSE;
}

static gboolean _gdart_function_argument_fill_in_wrapped_pointer (GdartBridgeContext *self,
    const gchar *name_prefix,
    Dart_Handle dart_args,
    gint *dart_arg_pos,
    gboolean is_transfer_full,
    GArgument *main_argument,
    GArgument *in_arg_cvalues,
    gpointer *ffi_arg_pointers,
    gint *c_arg_pos,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle element;
  element = Dart_ListGetAt (dart_args, (*dart_arg_pos) ++);
  if (G_UNLIKELY (Dart_IsError (element))) {
    *dart_error_out = element;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
    goto error;
  }
  return _gdart_function_argument_fill_wrapped_pointer (
           self,
           element,
           name_prefix,
           is_transfer_full,
           main_argument,
           in_arg_cvalues,
           ffi_arg_pointers,
           c_arg_pos,
           dart_error_out,
           error);
error:
  return FALSE;

}

static gboolean _gdart_function_argument_fill_flags (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  Dart_Handle element,
  GArgument *main_argument,
  GArgument *in_arg_cvalues,
  gpointer  *ffi_arg_pointers,
  gint *c_arg_pos,
  gpointer enum_info,
  const EnumInfoKlass *enum_info_klass,
  Dart_Handle *dart_error_out,
  GError **error)
{
  Dart_Handle inner_container, name_handle;
  GITypeTag storage_type;

  if (!enum_info_klass->get_storage_type (enum_info, self, &storage_type, dart_error_out, error)) {
    return FALSE;
  }
  name_handle = Dart_NewStringFromCString ("index");
  if (G_UNLIKELY (Dart_IsError (name_handle))) {
    *dart_error_out = name_handle;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
    return FALSE;
  }
  inner_container = Dart_GetField (element, name_handle);
  if (G_UNLIKELY (Dart_IsError (inner_container))) {
    *dart_error_out = inner_container;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
    return FALSE;
  }
  return _gdart_function_argument_fill_int (self,
         name_prefix,
         inner_container,
         main_argument,
         in_arg_cvalues,
         ffi_arg_pointers,
         c_arg_pos,
         storage_type,
         dart_error_out,
         error);
}

static gboolean _gdart_function_argument_fill_in_flags (GdartBridgeContext *self,
    const gchar *name_prefix,
    Dart_Handle dart_args,
    gint *dart_arg_pos,
    GArgument *main_argument,
    GArgument *in_arg_cvalues,
    gpointer *ffi_arg_pointers,
    gint *c_arg_pos,
    gpointer enum_info,
    const EnumInfoKlass *enum_info_klass,
    Dart_Handle *dart_error_out,
    GError **error)
{
  Dart_Handle element;
  element = Dart_ListGetAt (dart_args, (*dart_arg_pos) ++);
  if (G_UNLIKELY (Dart_IsError (element))) {
    *dart_error_out = element;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
    goto error;
  }
  return _gdart_function_argument_fill_flags (self,
         name_prefix,
         element,
         main_argument,
         in_arg_cvalues,
         ffi_arg_pointers,
         c_arg_pos,
         enum_info,
         enum_info_klass,
         dart_error_out,
         error);
error:
  return FALSE;
}
/*
static gboolean _gdart_function_argument_fill_interface(
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
        *dart_error_out = gdart_bridge_context_create_error_handle(self,
                          "%s: can't handle callbacks yet", G_STRFUNC);
        g_set_error(error, GDART_ERROR, 1,
                          "%s: can't handle callbacks yet", G_STRFUNC);
        goto error;
    case GI_INFO_TYPE_STRUCT:
    case GI_INFO_TYPE_BOXED:
    case GI_INFO_TYPE_UNION:
        result = _gdart_function_argument_fill_struct(self,
                 element,
                 (GIRegisteredTypeInfo*) base_info,
                 dart_error_out,
                 error);
        goto out;
    case GI_INFO_TYPE_OBJECT:
        result = _gdart_function_argument_fill_object(self,
                 element,
                 (GIObjectInfo*) base_info,
                 dart_error_out,
                 error);
        goto out;

    case GI_INFO_TYPE_ENUM:
    case GI_INFO_TYPE_FLAGS:
        result = _gdart_function_argument_fill_flags(self,
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
*/

static gboolean _gdart_function_argument_fill_in_interface (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  Dart_Handle dart_args,
  gint *dart_arg_pos,
  gboolean is_method,
  gpointer arg_info,
  const ArgInfoKlass *arg_info_klass,
  gpointer arg_type,
  const TypeInfoKlass *arg_type_klass,
  gboolean is_transfer_full,
  GArgument *main_argument,
  GArgument *in_arg_cvalues,
  gpointer *ffi_arg_pointers,
  GdartCallbackTrampoline **trampolines,
  gint trampolines_length,
  gint *c_arg_pos,
  Dart_Handle *dart_error_out,
  GError **error)
{
  gpointer interface_info;
  const InterfaceInfoKlass *interface_info_klass;

  gboolean result;
  GIScopeType scope;

  GIInfoType info_type;

  if (!arg_type_klass->get_interface (arg_type,
                                      self,
                                      &interface_info,
                                      &interface_info_klass,
                                      dart_error_out,
                                      error)) {
    return FALSE;
  }
  if (!arg_info_klass->get_scope (arg_info,
                                  self,
                                  &scope,
                                  dart_error_out,
                                  error)) {
    interface_info_klass->free (interface_info);
    return FALSE;
  }
  if (G_UNLIKELY (!interface_info_klass->get_type (interface_info,
                  self,
                  &info_type,
                  dart_error_out,
                  error))) {
    interface_info_klass->free (interface_info);
    return FALSE;
  }
  switch (info_type) {
  case GI_INFO_TYPE_CALLBACK: {
    const CallableInfoKlass *klass;
    klass = interface_info_klass->cast_to_callable_info (interface_info);
    result = _gdart_function_argument_fill_in_callback (
               self,
               name_prefix,
               dart_args,
               dart_arg_pos,
               is_method,
               interface_info,
               klass,
               arg_info,
               arg_info_klass,
               scope,
               trampolines,
               trampolines_length,
               main_argument,
               in_arg_cvalues,
               ffi_arg_pointers,
               c_arg_pos,
               dart_error_out,
               error);
    goto out;
  }
  case GI_INFO_TYPE_STRUCT:
  case GI_INFO_TYPE_BOXED:
  case GI_INFO_TYPE_UNION:
  case GI_INFO_TYPE_OBJECT:
  case GI_INFO_TYPE_INTERFACE:
    result = _gdart_function_argument_fill_in_wrapped_pointer (self,
             name_prefix,
             dart_args,
             dart_arg_pos,
             is_transfer_full,
             main_argument,
             in_arg_cvalues,
             ffi_arg_pointers,
             c_arg_pos,
             dart_error_out,
             error);
    goto out;
  case GI_INFO_TYPE_ENUM:
  case GI_INFO_TYPE_FLAGS: {
    const EnumInfoKlass *klass;
    klass = interface_info_klass->cast_to_enum_info (interface_info);
    result = _gdart_function_argument_fill_in_flags (self,
             name_prefix,
             dart_args,
             dart_arg_pos,
             main_argument,
             in_arg_cvalues,
             ffi_arg_pointers,
             c_arg_pos,
             interface_info,
             klass,
             dart_error_out,
             error);
    goto out;
  }
  default:
    *dart_error_out = gdart_bridge_context_create_error_handle (self,
                      "%s: received an unexpected base info type", G_STRFUNC);
    g_set_error (error, GDART_ERROR, 1,
                 "%s: received an unexpected base info type", G_STRFUNC);
    goto error;
  }
out:
  if (!result) { goto error; }
  interface_info_klass->free (interface_info);
  return result;
error:

  interface_info_klass->free (interface_info);
  return FALSE;
}


/*
static gboolean _gdart_function_argument_fill_array(GdartBridgeContext *self,
        Dart_Handle element,
        GITypeInfo *arg_type,
        Dart_Handle *dart_error_out,
        GError **error)
{
    gint fixed_length=0;
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
    return _gdart_function_argument_fill_in_array_parameters(self,
            element,
            arg_type,
            fixed_length,

            dart_error_out,
            error);
error:
    return FALSE;
}
*/

static gsize _gdart_function_get_array_size_multiplier_out (
  GdartBridgeContext *self,
  gpointer param_type,
  const TypeInfoKlass *param_type_klass,
  Dart_Handle *dart_error_out,
  GError **error)
{
  GITypeTag type_tag;
  if (!param_type_klass->get_tag (param_type,
                                  self,
                                  &type_tag,
                                  dart_error_out,
                                  error)) {
    return 0;
  }
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
  case GI_TYPE_TAG_ARRAY:
  case GI_TYPE_TAG_UTF8:
  case GI_TYPE_TAG_FILENAME:
  case GI_TYPE_TAG_GLIST:
  case GI_TYPE_TAG_GSLIST:
  case GI_TYPE_TAG_GHASH:
    return gdart_array_get_size_multiplier (self,
                                            param_type,
                                            param_type_klass,
                                            dart_error_out,
                                            error);
  case GI_TYPE_TAG_INTERFACE: {
    gpointer base_info;
    const InterfaceInfoKlass *base_info_klass;
    GIInfoType base_info_type;

    if (G_UNLIKELY (!param_type_klass->get_interface (param_type,
                    self,
                    &base_info,
                    &base_info_klass,
                    dart_error_out,
                    error))) {
      return 0;
    }
    if (G_UNLIKELY (!base_info_klass->get_type (base_info,
                    self,
                    &base_info_type,
                    dart_error_out,
                    error))) {
      base_info_klass->free (base_info);
      return 0;
    }

    switch (base_info_type) {
    case GI_INFO_TYPE_CALLBACK:
    case GI_INFO_TYPE_BOXED:
    case GI_INFO_TYPE_OBJECT:
    case GI_INFO_TYPE_INTERFACE:
      base_info_klass->free (base_info);
      return sizeof (gpointer);
    case GI_INFO_TYPE_UNION:
    case GI_INFO_TYPE_STRUCT: {
      gsize result;
      const StructUnionInfoKlass *klass;
      klass = base_info_klass->cast_to_struct_union_info (base_info);

      if (!klass->get_size (base_info,
                            self,
                            &result,
                            dart_error_out,
                            error)) {
        base_info_klass->free (base_info);
      }
      base_info_klass->free (base_info);
      return result;
    }
    case GI_INFO_TYPE_ENUM:
    case GI_INFO_TYPE_FLAGS: {
      gsize result;
      result = gdart_array_get_size_multiplier (self,
               param_type,
               param_type_klass,
               dart_error_out,
               error);
      base_info_klass->free (base_info);
      return result;
    }
    default:
      base_info_klass->free (base_info);
      return 0;
    }
  }

  case GI_TYPE_TAG_ERROR:
    return sizeof (gpointer);
  default:
    return 0;
  }
}



static gboolean _gdart_function_result_load_int_raw_from_in (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  gpointer function_info,
  const CallableInfoKlass *function_info_klass,
  gint gi_arg_pos,
  GIArgument *in_arg_cvalues,
  gint c_arg_pos,
  gint *result_out,
  Dart_Handle *dart_error_out,
  GError **error)
{
  gpointer arg_info;
  const ArgInfoKlass *arg_info_klass;
  gpointer type_info;
  const TypeInfoKlass *type_info_klass;
  GITypeTag return_tag;
  gint64 result;
  GIArgument *gi_return_value = &in_arg_cvalues[c_arg_pos];

  if (!function_info_klass->get_arg (function_info,
                                     self,
                                     gi_arg_pos,
                                     &arg_info,
                                     &arg_info_klass,
                                     dart_error_out,
                                     error)) {
    return FALSE;
  }
  if (!arg_info_klass->get_type (arg_info,
                                 self,
                                 &type_info,
                                 &type_info_klass,
                                 dart_error_out,
                                 error)) {
    arg_info_klass->free (arg_info);
    return FALSE;
  }
  if (!type_info_klass->get_tag (type_info,
                                 self,
                                 &return_tag,
                                 dart_error_out,
                                 error)) {
    type_info_klass->free (type_info);
    arg_info_klass->free (arg_info);
    return FALSE;
  }
  switch (return_tag) {
  case GI_TYPE_TAG_BOOLEAN:
    result = (gint64) (gi_return_value->v_int);
    break;
  case GI_TYPE_TAG_INT8:
    result = (gint64) (gi_return_value->v_int8);
    break;
  case GI_TYPE_TAG_UINT8:
    result = (gint64) (gi_return_value->v_uint8);
    break;
  case GI_TYPE_TAG_INT16:
    result = (gint64) (gi_return_value->v_int16);
    break;
  case GI_TYPE_TAG_UINT16:
    result = (gint64) (gi_return_value->v_uint16);
    break;
  case GI_TYPE_TAG_INT32:
    result = (gint64) (gi_return_value->v_int32);
    break;
  case GI_TYPE_TAG_UINT32:
    result = (gint64) (gi_return_value->v_uint32);
    break;
  case GI_TYPE_TAG_INT64:
    result = (gint64) (gi_return_value->v_int64);
    break;
  case GI_TYPE_TAG_UINT64:
    result = (gint64) (gi_return_value->v_uint64);
    break;
  default: {
    type_info_klass->free (type_info);
    arg_info_klass->free (arg_info);
    return FALSE;
  }
  }
  type_info_klass->free (type_info);
  arg_info_klass->free (arg_info);
  *result_out = result;
  return TRUE;
}

static gboolean _gdart_function_argument_unfill_in_array (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  gpointer arg_type,
  const TypeInfoKlass *arg_type_klass,
  gpointer function_info,
  const CallableInfoKlass *function_info_klass,
  GArgument *in_arg_cvalues,
  gboolean is_method,
  gint *c_arg_pos,
  Dart_Handle *dart_error_out,
  GError **error)
{
  gint arg_to_suppress, length = 0;
  if (G_UNLIKELY (!arg_type_klass->get_array_length (arg_type,
                  self,
                  &arg_to_suppress,
                  dart_error_out,
                  error))) {
    return FALSE;
  }
  gboolean is_null_terminated;
  gpointer buffer;

  gpointer param_type;
  const TypeInfoKlass *param_type_klass;
  gboolean result;

  if (!arg_type_klass->is_zero_terminated (arg_type,
      self,
      &is_null_terminated,
      dart_error_out,
      error)) {
    return FALSE;
  }
  if (!arg_type_klass->get_array_fixed_size (arg_type,
      self,
      &length,
      dart_error_out,
      error)) {
    return FALSE;
  }
  if (!arg_type_klass->get_param_type (arg_type,
                                       self,
                                       0,
                                       &param_type,
                                       &param_type_klass,
                                       dart_error_out,
                                       error)) {
    return FALSE;
  }
  if (arg_to_suppress != -1) {
    if (!_gdart_function_result_load_int_raw_from_in (
          self,
          name_prefix,
          function_info,
          function_info_klass,
          arg_to_suppress,
          in_arg_cvalues,
          is_method ? arg_to_suppress + 1 : arg_to_suppress,
          &length,
          dart_error_out,
          error)) {
      param_type_klass->free (param_type);
      return FALSE;
    }
  }
  buffer = in_arg_cvalues[*c_arg_pos].v_pointer;
  result = gdart_array_unfill_in_array_parameters (self,
           param_type,
           param_type_klass,
           length,
           is_null_terminated,
           buffer,
           dart_error_out,
           error);
  g_free (buffer);
  return result;
}

static gboolean _gdart_function_argument_fill_in_array (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  Dart_Handle dart_args,
  gint *dart_arg_pos,
  gpointer arg_type,
  const TypeInfoKlass *arg_type_klass,
  gpointer function_info,
  const CallableInfoKlass *function_info_klass,
  gboolean is_method,
  GArgument *main_argument,
  GArgument *in_arg_cvalues,
  gpointer *ffi_arg_pointers,
  gint *c_arg_pos,
  Dart_Handle *dart_error_out,
  GError **error)
{
  Dart_Handle element, temp_result;
  gint arg_to_suppress, fixed_length = 0;
  gboolean is_null_terminated;
  gpointer buffer, buffer_after;
  intptr_t list_length;
  gintptr allocation_length;

  gpointer param_type;
  const TypeInfoKlass *param_type_klass;

  gsize size_per_cell;

  if (!arg_type_klass->get_array_length (arg_type,
                                         self,
                                         &arg_to_suppress,
                                         dart_error_out,
                                         error)) {
    return FALSE;
  }
  if (!arg_type_klass->is_zero_terminated (arg_type,
      self,
      &is_null_terminated,
      dart_error_out,
      error)) {
    return FALSE;
  }
  if (!arg_type_klass->get_array_fixed_size (arg_type,
      self,
      &fixed_length,
      dart_error_out,
      error)) {
    return FALSE;
  }
  if (arg_to_suppress == -1 && fixed_length == -1 && !is_null_terminated) {
    *dart_error_out = gdart_bridge_context_create_error_handle (self,
                      "%s: the array did not have a length, a fixed size or a null termination so I can't handle it", G_STRFUNC);
    g_set_error (error, GDART_ERROR, 1,
                 "%s: the array did not have a length, a fixed size or a null termination so I can't handle it", G_STRFUNC);
    return FALSE;
  }
  element = Dart_ListGetAt (dart_args, (*dart_arg_pos) ++);
  if (G_UNLIKELY (Dart_IsError (element))) {
    *dart_error_out = element;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
    return FALSE;
  }
  if (!Dart_IsList (element) && !Dart_IsNull (element)) {
    *dart_error_out = gdart_bridge_context_create_error_handle (self,
                      "%s: expected string or null", G_STRFUNC);
    g_set_error (error, GDART_ERROR, 1,
                 "%s: expected string or null", G_STRFUNC);
    return FALSE;
  }
  if (Dart_IsNull (element)) {
    list_length = 0;
  } else {
    temp_result = Dart_ListLength (element, &list_length);
    if (G_UNLIKELY (Dart_IsError (temp_result))) {
      *dart_error_out = temp_result;
      g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
      return FALSE;
    }
  }
  allocation_length = list_length;
  if (is_null_terminated) {
    allocation_length++;
  } else if (arg_to_suppress != -1) {
    gpointer arg_info_length;
    const ArgInfoKlass *arg_info_length_klass;

    gpointer arg_type_length;
    const TypeInfoKlass *arg_type_length_klass;

    GITypeTag type_tag_length;
    gint arg_offset = is_method ? 1 : 0;

    if (!function_info_klass->get_arg (function_info,
                                       self,
                                       arg_to_suppress,
                                       &arg_info_length,
                                       &arg_info_length_klass,
                                       dart_error_out,
                                       error)) {
      return FALSE;
    }
    if (!arg_info_length_klass->get_type (arg_info_length,
                                          self,
                                          &arg_type_length,
                                          &arg_type_length_klass,
                                          dart_error_out,
                                          error)) {
      arg_info_length_klass->free (arg_info_length);
      return FALSE;
    }
    if (!arg_type_length_klass->get_tag (arg_type_length,
                                         self,
                                         &type_tag_length,
                                         dart_error_out,
                                         error)) {
      arg_info_length_klass->free (arg_info_length);
      arg_type_length_klass->free (arg_type_length);
      return FALSE;
    }
    arg_info_length_klass->free (arg_info_length);
    arg_type_length_klass->free (arg_type_length);

    if (!_gdart_function_argument_fill_int_raw (self,
        name_prefix,
        list_length,
        list_length,
        &in_arg_cvalues[arg_offset + arg_to_suppress],
        in_arg_cvalues,
        arg_offset + arg_to_suppress,
        type_tag_length,
        dart_error_out,
        error)) {
      return FALSE;
    }
  }
  if (allocation_length == 0) {
    in_arg_cvalues[*c_arg_pos].v_pointer = NULL;
    if (ffi_arg_pointers != NULL) {
      g_assert (main_argument == &in_arg_cvalues[*c_arg_pos]);
      ffi_arg_pointers[*c_arg_pos] = &in_arg_cvalues[*c_arg_pos];
      (*c_arg_pos) ++;
    }
    return TRUE;
  }
  if (!arg_type_klass->get_param_type (arg_type,
                                       self,
                                       0,
                                       &param_type,
                                       &param_type_klass,
                                       dart_error_out,
                                       error)) {
    return FALSE;
  }
  size_per_cell = gdart_array_get_size_multiplier (self,
                  param_type,
                  param_type_klass,
                  dart_error_out,
                  error);
  if (size_per_cell == 0) {
    param_type_klass->free (param_type);
    return FALSE;
  }
  buffer = g_malloc (allocation_length * size_per_cell);

  if (!gdart_array_fill_in_parameters (self,
                                       name_prefix,
                                       element,
                                       param_type,
                                       param_type_klass,
                                       fixed_length,
                                       list_length,
                                       buffer,
                                       &buffer_after,
                                       dart_error_out,
                                       error)) {
    param_type_klass->free (param_type);
    g_free (buffer);
    return FALSE;
  }
  if (is_null_terminated) {
    if (!gdart_array_zero_element (self,
                                   name_prefix,
                                   param_type,
                                   param_type_klass,
                                   &buffer_after,
                                   dart_error_out,
                                   error)) {
      param_type_klass->free (param_type);
      g_free (buffer);
      return FALSE;
    }
  }
  in_arg_cvalues[*c_arg_pos].v_pointer = buffer;
  if (ffi_arg_pointers != NULL) {
    g_assert (main_argument == &in_arg_cvalues[*c_arg_pos]);
    ffi_arg_pointers[*c_arg_pos] = &in_arg_cvalues[*c_arg_pos];
    (*c_arg_pos) ++;
  }
  return TRUE;
}

gboolean gdart_function_prep_invoke (GdartBridgeContext *self,
                                     const gchar *name_prefix,
                                     gpointer function_info,
                                     const CallableInfoKlass *function_info_klass,
                                     GType type,
                                     GIFunctionInvoker *invoker,
                                     gpointer *user_data_out,
                                     GIFunctionInvokerDestroyFunc
                                     *invoker_destroy_func,
                                     Dart_Handle *dart_error_out,
                                     GError **error)
{
  GIInfoType info_type;
  gpointer addr;

  if (G_UNLIKELY (!function_info_klass->get_type (function_info,
                  self,
                  &info_type,
                  dart_error_out,
                  error))) {
    return FALSE;
  }
  if (info_type == GI_INFO_TYPE_FUNCTION) {
    const FunctionInfoKlass *klass;
    klass = function_info_klass->cast_to_function_info (function_info);
    if (!klass->prep_invoker (function_info,
                              self,
                              invoker,
                              user_data_out,
                              invoker_destroy_func,
                              dart_error_out,
                              error)) {
      return FALSE;
    }
  } else if (info_type == GI_INFO_TYPE_VFUNC) {
    const VFuncInfoKlass *klass;
    gpointer address_peer;
    AddressPeerDestroyFunc address_peer_notify;

    klass = function_info_klass->cast_to_v_func_info (function_info);
    if (!klass->get_address (function_info,
                             self,
                             type,
                             &addr,
                             &address_peer,
                             &address_peer_notify,
                             dart_error_out,
                             error)) {
      *user_data_out = NULL;
      return FALSE;
    }
    if (!klass->new_invoker_for_address (function_info,
                                         self,
                                         addr,
                                         address_peer,
                                         address_peer_notify,
                                         invoker,
                                         user_data_out,
                                         invoker_destroy_func,
                                         dart_error_out,
                                         error)) {
      if (address_peer_notify != NULL) {
        address_peer_notify (address_peer);
      }
      return FALSE;
    }
  }
  return TRUE;
}

static gboolean _gdart_function_invoke_fill_receiver (GdartBridgeContext *self,
    const gchar *name_prefix,
    Dart_Handle dart_receiver,
    GArgument *main_argument,
    GArgument *in_arg_cvalues,
    gpointer  *ffi_arg_pointers,
    Dart_Handle *dart_error_out,
    GError **error)
{
  gint c_arg_pos = 0, dart_arg_pos = 0;
  Dart_Handle dart_args, temp_result;
  dart_args = Dart_NewList (1);
  if (G_UNLIKELY (Dart_IsError (dart_args))) {
    *dart_error_out = dart_args;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
    return FALSE;
  }
  temp_result = Dart_ListSetAt (dart_args, 0, dart_receiver);
  if (G_UNLIKELY (Dart_IsError (temp_result))) {
    *dart_error_out = temp_result;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
    return FALSE;
  }
  return _gdart_function_argument_fill_in_wrapped_pointer (self,
         name_prefix,
         dart_args,
         &dart_arg_pos,
         FALSE, //receiver is never transfered
         main_argument,
         in_arg_cvalues,
         ffi_arg_pointers,
         &c_arg_pos,
         dart_error_out,
         error);
}

static gboolean _gdart_function_fill_argument_out (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  gboolean is_caller_allocates,
  gint *c_arg_pos,
  gint gi_arg_pos,
  gpointer arg_type,
  const TypeInfoKlass *arg_type_klass,
  GArgument *in_arg_cvalues,
  GArgument *out_arg_cvalues,
  gpointer  *ffi_arg_pointers,
  Dart_Handle *dart_error_out,
  GError **error)
{
  GITypeTag return_tag;
  GIArgument *gi_return_value;

  if (is_caller_allocates) {
    gsize size_of_slot;
    gpointer slot;
    size_of_slot = _gdart_function_get_array_size_multiplier_out (self,
                   arg_type,
                   arg_type_klass,
                   dart_error_out,
                   error);
    if (size_of_slot == 0) { return FALSE; }
    slot = g_slice_alloc0 (size_of_slot);
    in_arg_cvalues[*c_arg_pos].v_pointer = slot;
    if (ffi_arg_pointers != NULL) {
      ffi_arg_pointers[*c_arg_pos] = &in_arg_cvalues[*c_arg_pos];
      (*c_arg_pos) ++;
    }
    return TRUE;
  }
  gi_return_value = &out_arg_cvalues[*c_arg_pos];
  if (G_UNLIKELY (!arg_type_klass->get_tag (arg_type,
                  self,
                  &return_tag,
                  dart_error_out,
                  error))) {
    return FALSE;
  }
  if (return_tag == GI_TYPE_TAG_FLOAT) {
    in_arg_cvalues[*c_arg_pos].v_pointer = &gi_return_value->v_float;
    gi_return_value->v_float = 0.0;
  } else if (return_tag == GI_TYPE_TAG_DOUBLE) {
    in_arg_cvalues[*c_arg_pos].v_pointer = &gi_return_value->v_double;
    gi_return_value->v_double = 0.0;
  } else if (return_tag == GI_TYPE_TAG_INT64 || return_tag == GI_TYPE_TAG_UINT64) {
    in_arg_cvalues[*c_arg_pos].v_pointer = &gi_return_value->v_uint64;
    gi_return_value->v_uint64 = 0;
  } else {
    in_arg_cvalues[*c_arg_pos].v_pointer = &gi_return_value->v_long;
    gi_return_value->v_uint64 = 0;
  }
  ffi_arg_pointers[*c_arg_pos] = &in_arg_cvalues[*c_arg_pos];
  (*c_arg_pos) ++;
  return TRUE;
}


static gboolean _gdart_function_fill_argument_inout (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  Dart_Handle dart_args,
  gpointer function_info,
  const CallableInfoKlass *function_info_klass,
  gboolean is_transfer_full,
  gboolean is_method,
  gint *c_arg_pos,
  gint *dart_arg_pos,
  gint gi_arg_pos,
  gpointer arg_info,
  const ArgInfoKlass *arg_info_klass,
  gpointer arg_type,
  const TypeInfoKlass *arg_type_klass,
  gint *suppressed_args,
  gint suppressed_args_length,
  GArgument *in_arg_cvalues,
  GArgument *out_arg_cvalues,
  GArgument *inout_original_arg_cvalues,
  gpointer  *ffi_arg_pointers,
  GdartCallbackTrampoline **trampolines,
  gint trampolines_length,
  Dart_Handle *dart_error_out,
  GError **error)
{
  gint arg_i = 0;
  GITypeTag type_tag;
  gboolean result;
  for (; arg_i < suppressed_args_length; arg_i++) {
    if (suppressed_args[arg_i] == gi_arg_pos) {
      goto out;
    }
    if (suppressed_args[arg_i] == -1) { break; }
  }
  if (!arg_type_klass->get_tag (arg_type,
                                self,
                                &type_tag,
                                dart_error_out,
                                error)) {
    return FALSE;
  }
  switch (type_tag) {
  case GI_TYPE_TAG_BOOLEAN:
    result = _gdart_function_argument_fill_in_boolean (
               dart_args,
               dart_arg_pos,
               &out_arg_cvalues[*c_arg_pos],
               out_arg_cvalues,
               NULL,
               c_arg_pos,
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
    result =  _gdart_function_argument_fill_in_int (self,
              name_prefix,
              dart_args,
              dart_arg_pos,
              &out_arg_cvalues[*c_arg_pos],
              out_arg_cvalues,
              NULL,
              c_arg_pos,
              type_tag,
              dart_error_out,
              error);
    break;
  case GI_TYPE_TAG_FLOAT:
  case GI_TYPE_TAG_DOUBLE:
    result =  _gdart_function_argument_fill_in_num (self,
              name_prefix,
              dart_args,
              dart_arg_pos,
              &out_arg_cvalues[*c_arg_pos],
              out_arg_cvalues,
              NULL,
              c_arg_pos,
              type_tag,
              dart_error_out,
              error);
    break;
  case GI_TYPE_TAG_UTF8:
  case GI_TYPE_TAG_FILENAME:
    result =  _gdart_function_argument_fill_in_string (self,
              name_prefix,
              dart_args,
              dart_arg_pos,
              &out_arg_cvalues[*c_arg_pos],
              out_arg_cvalues,
              NULL,
              c_arg_pos,
              type_tag,
              dart_error_out,
              error);
    break;
  case GI_TYPE_TAG_ARRAY:
    result =  _gdart_function_argument_fill_in_array (self,
              name_prefix,
              dart_args,
              dart_arg_pos,
              arg_type,
              arg_type_klass,
              function_info,
              function_info_klass,
              is_method,
              &out_arg_cvalues[*c_arg_pos],
              out_arg_cvalues,
              NULL,
              c_arg_pos,
              dart_error_out,
              error);
    break;
  case GI_TYPE_TAG_INTERFACE:
    result =  _gdart_function_argument_fill_in_interface (self,
              name_prefix,
              dart_args,
              dart_arg_pos,
              is_method,
              arg_info,
              arg_info_klass,
              arg_type,
              arg_type_klass,
              is_transfer_full,
              &out_arg_cvalues[*c_arg_pos],
              out_arg_cvalues,
              NULL,
              trampolines,
              trampolines_length,
              c_arg_pos,
              dart_error_out,
              error);
    break;
  case GI_TYPE_TAG_GLIST:
  case GI_TYPE_TAG_GSLIST:
  case GI_TYPE_TAG_GHASH:
  case GI_TYPE_TAG_ERROR:
    result = _gdart_function_argument_fill_in_wrapped_pointer (self,
             name_prefix,
             dart_args,
             dart_arg_pos,
             is_transfer_full,
             &out_arg_cvalues[*c_arg_pos],
             out_arg_cvalues,
             NULL,
             c_arg_pos,
             dart_error_out,
             error);
    break;
  default:
    *dart_error_out = gdart_bridge_context_create_error_handle (self,
                      "%s: got an unexpected type", G_STRFUNC);
    g_set_error (error, GDART_ERROR, 1,
                 "%s: got an unexpected type", G_STRFUNC);
    return FALSE;
  }
  if (!result) { return FALSE; }
out:
  inout_original_arg_cvalues[*c_arg_pos] = out_arg_cvalues[*c_arg_pos];
  in_arg_cvalues[*c_arg_pos].v_pointer = &out_arg_cvalues[*c_arg_pos];
  ffi_arg_pointers[*c_arg_pos] = &in_arg_cvalues[*c_arg_pos];
  (*c_arg_pos) ++;
  return TRUE;
}

static gboolean _gdart_function_fill_argument_in (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  Dart_Handle dart_args,
  gpointer function_info,
  const CallableInfoKlass *function_info_klass,
  gboolean is_transfer_full,
  gboolean is_method,
  gint *c_arg_pos,
  gint *dart_arg_pos,
  gint gi_arg_pos,
  gpointer arg_info,
  const ArgInfoKlass *arg_info_klass,
  gpointer arg_type,
  const TypeInfoKlass *arg_type_klass,
  gint *suppressed_args,
  gint suppressed_args_length,
  GArgument *main_argument,
  GArgument *in_arg_cvalues,
  gpointer  *ffi_arg_pointers,
  GdartCallbackTrampoline **trampolines,
  gint trampolines_length,
  Dart_Handle *dart_error_out,
  GError **error)
{
  gint arg_i = 0;
  GITypeTag type_tag;
  for (; arg_i < suppressed_args_length; arg_i++) {
    if (suppressed_args[arg_i] == -1) { break; }
    if (suppressed_args[arg_i] == gi_arg_pos) {
      g_assert (main_argument == &in_arg_cvalues[*c_arg_pos]);
      ffi_arg_pointers[*c_arg_pos] = main_argument;
      (*c_arg_pos) ++;
      return TRUE;
    }
  }
  if (!arg_type_klass->get_tag (arg_type,
                                self,
                                &type_tag,
                                dart_error_out,
                                error)) {
    return FALSE;
  }
  switch (type_tag) {
  case GI_TYPE_TAG_BOOLEAN:
    return _gdart_function_argument_fill_in_boolean (
             dart_args,
             dart_arg_pos,
             main_argument,
             in_arg_cvalues,
             ffi_arg_pointers,
             c_arg_pos,
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
    return _gdart_function_argument_fill_in_int (self,
           name_prefix,
           dart_args,
           dart_arg_pos,
           main_argument,
           in_arg_cvalues,
           ffi_arg_pointers,
           c_arg_pos,
           type_tag,
           dart_error_out,
           error);
  case GI_TYPE_TAG_FLOAT:
  case GI_TYPE_TAG_DOUBLE:
    return _gdart_function_argument_fill_in_num (self,
           name_prefix,
           dart_args,
           dart_arg_pos,
           main_argument,
           in_arg_cvalues,
           ffi_arg_pointers,
           c_arg_pos,
           type_tag,
           dart_error_out,
           error);
  case GI_TYPE_TAG_UTF8:
  case GI_TYPE_TAG_FILENAME:
    return _gdart_function_argument_fill_in_string (self,
           name_prefix,
           dart_args,
           dart_arg_pos,
           main_argument,
           in_arg_cvalues,
           ffi_arg_pointers,
           c_arg_pos,
           type_tag,
           dart_error_out,
           error);
  case GI_TYPE_TAG_ARRAY:
    return _gdart_function_argument_fill_in_array (self,
           name_prefix,
           dart_args,
           dart_arg_pos,
           arg_type,
           arg_type_klass,
           function_info,
           function_info_klass,
           is_method,
           main_argument,
           in_arg_cvalues,
           ffi_arg_pointers,
           c_arg_pos,
           dart_error_out,
           error);
  case GI_TYPE_TAG_INTERFACE:
    return _gdart_function_argument_fill_in_interface (self,
           name_prefix,
           dart_args,
           dart_arg_pos,
           is_method,
           arg_info,
           arg_info_klass,
           arg_type,
           arg_type_klass,
           is_transfer_full,
           main_argument,
           in_arg_cvalues,
           ffi_arg_pointers,
           trampolines,
           trampolines_length,
           c_arg_pos,
           dart_error_out,
           error);
  case GI_TYPE_TAG_GLIST:
  case GI_TYPE_TAG_GSLIST:
  case GI_TYPE_TAG_GHASH:
  case GI_TYPE_TAG_ERROR:
    //TODO: Handle GErrors better.
    return _gdart_function_argument_fill_in_wrapped_pointer (self,
           name_prefix,
           dart_args,
           dart_arg_pos,
           is_transfer_full,
           main_argument,
           in_arg_cvalues,
           ffi_arg_pointers,
           c_arg_pos,
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

static gboolean _gdart_function_unfill_argument_in (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  gboolean is_method,
  gpointer function_info,
  const CallableInfoKlass *function_info_klass,
  gint *c_arg_pos,
  gint gi_arg_pos,
  gpointer arg_type,
  const TypeInfoKlass *arg_type_klass,
  gint *suppressed_args,
  gint suppressed_args_length,
  GArgument *in_arg_cvalues,
  GdartCallbackTrampoline **trampolines,
  Dart_Handle *dart_error_out,
  GError **error)
{
  gint arg_i = 0;
  GITypeTag type_tag;
  for (; arg_i < suppressed_args_length; arg_i++) {
    if (suppressed_args[arg_i] == gi_arg_pos) {
      (*c_arg_pos) ++;
      return TRUE;
    }
    if (suppressed_args[arg_i] == -1) { break; }
  }
  if (!arg_type_klass->get_tag (arg_type,
                                self,
                                &type_tag,
                                dart_error_out,
                                error)) {
    return FALSE;
  }
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
    //No need to do anything for these types. Interfaces may need to be
    //revisited for functions.
    (*c_arg_pos) ++;
    break;
  case GI_TYPE_TAG_UTF8:
  case GI_TYPE_TAG_FILENAME:
    _gdart_function_argument_unfill_in_string (self,
        in_arg_cvalues,
        c_arg_pos);
    break;
  case GI_TYPE_TAG_ARRAY:
    if (!_gdart_function_argument_unfill_in_array (self,
        name_prefix,
        arg_type,
        arg_type_klass,
        function_info,
        function_info_klass,
        in_arg_cvalues,
        is_method,
        c_arg_pos,
        dart_error_out,
        error)) {
      return FALSE;
    }
    break;
  default:
    g_assert_not_reached();
  }
  return TRUE;
}

static gboolean _gdart_function_invoke_fill_arguments (GdartBridgeContext *self,
    const gchar *name_prefix,
    gpointer function_info,
    const CallableInfoKlass *function_info_klass,
    GIRegisteredTypeInfo *base_info, //or NULL if there is no receiver
    GType type, //or 0 if there is no receiver
    Dart_Handle dart_receiver,
    Dart_Handle dart_args,
    gboolean is_method,
    gboolean can_throw_gerror,
    GArgument *in_arg_cvalues,
    GArgument *out_arg_cvalues,
    GArgument *inout_original_arg_cvalues,
    gpointer  *ffi_arg_pointers,
    GdartCallbackTrampoline **trampolines,
    gint c_argc,
    gint gi_argc,
    gint *suppressed_args,
    gint suppressed_args_length,
    Dart_Handle *dart_error_out,
    GError **error)
{
  gint c_arg_pos = 0, gi_arg_pos = 0, dart_arg_pos = 0;

  if (is_method) {
    gchar *arg_name;
    arg_name = g_strdup_printf ("%s.this",
                                name_prefix);
    if (!_gdart_function_invoke_fill_receiver (self,
        arg_name,
        dart_receiver,
        &in_arg_cvalues[c_arg_pos],
        in_arg_cvalues,
        ffi_arg_pointers,
        dart_error_out,
        error)) {
      g_free (arg_name);
      return FALSE;
    }
    g_free (arg_name);
    c_arg_pos++;
  }

  for (gi_arg_pos = 0; gi_arg_pos < gi_argc; gi_arg_pos++) {
    GIDirection direction;
    gpointer arg_info;
    const ArgInfoKlass *arg_info_klass;
    gchar *arg_name, *arg_name_const;

    if (!function_info_klass->get_arg (function_info,
                                       self,
                                       gi_arg_pos,
                                       &arg_info,
                                       &arg_info_klass,
                                       dart_error_out,
                                       error)) {
      return FALSE;
    }
    if (!arg_info_klass->get_name (arg_info,
                                   self,
                                   &arg_name_const,
                                   dart_error_out,
                                   error)) {
      arg_info_klass->free (arg_info);
      return FALSE;
    }
    arg_name = g_strdup_printf ("%s.%s",
                                name_prefix,
                                arg_name_const);
    g_free (arg_name_const);
    if (!arg_info_klass->get_direction (arg_info,
                                        self,
                                        &direction,
                                        dart_error_out,
                                        error)) {
      g_free (arg_name);
      arg_info_klass->free (arg_info);
      return FALSE;
    }
    switch (direction) {
    case GI_DIRECTION_IN: {
      gpointer arg_type;
      const TypeInfoKlass *arg_type_klass;
      GITransfer transfer;

      if (!arg_info_klass->get_type (arg_info,
                                     self,
                                     &arg_type,
                                     &arg_type_klass,
                                     dart_error_out,
                                     error)) {
        g_free (arg_name);
        arg_info_klass->free (arg_info);
        return FALSE;
      }
      if (!arg_info_klass->get_ownership_transfer (arg_info,
          self,
          &transfer,
          dart_error_out,
          error)) {
        g_free (arg_name);
        arg_info_klass->free (arg_info);
        arg_type_klass->free (arg_type);
        return FALSE;
      }
      if (!_gdart_function_fill_argument_in (self,
                                             arg_name,
                                             dart_args,
                                             function_info,
                                             function_info_klass,
                                             transfer != GI_TRANSFER_NOTHING,
                                             is_method,
                                             &c_arg_pos,
                                             &dart_arg_pos,
                                             gi_arg_pos,
                                             arg_info,
                                             arg_info_klass,
                                             arg_type,
                                             arg_type_klass,
                                             suppressed_args,
                                             gi_argc,
                                             &in_arg_cvalues[c_arg_pos],
                                             in_arg_cvalues,
                                             ffi_arg_pointers,
                                             trampolines,
                                             c_argc,
                                             dart_error_out,
                                             error)) {
        g_free (arg_name);
        arg_info_klass->free (arg_info);
        arg_type_klass->free (arg_type);
        return FALSE;
      }
      arg_type_klass->free (arg_type);
      break;
    }
    case GI_DIRECTION_OUT: {
      gboolean is_caller_allocates;
      //TODO: Move this to the interface
      if (G_UNLIKELY (!arg_info_klass->is_caller_allocates (arg_info,
                      self,
                      &is_caller_allocates,
                      dart_error_out,
                      error))) {
        g_free (arg_name);
        arg_info_klass->free (arg_info);
        return FALSE;
      }
      gpointer arg_type;
      const TypeInfoKlass *arg_type_klass;

      if (!arg_info_klass->get_type (arg_info,
                                     self,
                                     &arg_type,
                                     &arg_type_klass,
                                     dart_error_out,
                                     error)) {
        g_free (arg_name);
        arg_info_klass->free (arg_info);
        return FALSE;
      }
      if (!_gdart_function_fill_argument_out (self,
                                              arg_name,
                                              is_caller_allocates,
                                              &c_arg_pos,
                                              gi_arg_pos,
                                              arg_type,
                                              arg_type_klass,
                                              in_arg_cvalues,
                                              out_arg_cvalues,
                                              ffi_arg_pointers,
                                              dart_error_out,
                                              error)) {
        g_free (arg_name);
        arg_info_klass->free (arg_info);
        arg_type_klass->free (arg_type);
        return FALSE;
      }
      arg_type_klass->free (arg_type);
      break;
    }
    case GI_DIRECTION_INOUT: {
      gpointer arg_type;
      const TypeInfoKlass *arg_type_klass;
      GITransfer transfer;

      if (!arg_info_klass->get_ownership_transfer (arg_info,
          self,
          &transfer,
          dart_error_out,
          error)) {
        g_free (arg_name);
        arg_info_klass->free (arg_info);
        return FALSE;
      }

      if (!arg_info_klass->get_type (arg_info,
                                     self,
                                     &arg_type,
                                     &arg_type_klass,
                                     dart_error_out,
                                     error)) {
        g_free (arg_name);
        arg_info_klass->free (arg_info);
        return FALSE;
      }
      if (!_gdart_function_fill_argument_inout (self,
          arg_name,
          dart_args,
          function_info,
          function_info_klass,
          transfer != GI_TRANSFER_NOTHING,
          is_method,
          &c_arg_pos,
          &dart_arg_pos,
          gi_arg_pos,
          arg_info,
          arg_info_klass,
          arg_type,
          arg_type_klass,
          suppressed_args,
          gi_argc,
          in_arg_cvalues,
          out_arg_cvalues,
          inout_original_arg_cvalues,
          ffi_arg_pointers,
          trampolines,
          c_argc,
          dart_error_out,
          error)) {
        g_free (arg_name);
        arg_info_klass->free (arg_info);
        arg_type_klass->free (arg_type);
        return FALSE;
      }
      arg_type_klass->free (arg_type);
      break;
    }
    }
    g_free (arg_name);
    arg_info_klass->free (arg_info);
  }
  if (can_throw_gerror) {
    out_arg_cvalues[c_arg_pos].v_pointer = NULL;
    in_arg_cvalues[c_arg_pos].v_pointer = &out_arg_cvalues[c_arg_pos].v_pointer;
    ffi_arg_pointers[c_arg_pos] = &in_arg_cvalues[c_arg_pos];
    c_arg_pos++;
  }
  if (c_arg_pos != c_argc) {
    *dart_error_out = gdart_bridge_context_create_error_handle (self,
                      "%s: didn't fill all the arguments. What's up?", G_STRFUNC);
    g_set_error (error, GDART_ERROR, 1,
                 "%s: didn't fill all the arguments. What's up?", G_STRFUNC);
    return FALSE;
  }
  return TRUE;
}


static gboolean _gdart_function_invoke_unfill_arguments (GdartBridgeContext *self,
    const gchar *name_prefix,
    gpointer function_info,
    const CallableInfoKlass *function_info_klass,
    gboolean is_method,
    gboolean can_throw_gerror,
    gboolean was_uncaught_error, //if TRUE clear all out parameters.
    //if FALSE, then dart has captured all the
    //arguments, so no need to clear memory.
    GArgument *in_arg_cvalues,
    GArgument *out_arg_cvalues,
    GArgument *inout_original_arg_cvalues,
    GdartCallbackTrampoline **trampolines,
    gint c_argc,
    gint gi_argc,
    gint *suppressed_args,
    gint suppressed_args_length,
    Dart_Handle *dart_error_out,
    GError **error)
{
  gint c_arg_pos = 0, gi_arg_pos = 0;

  if (is_method) {
    c_arg_pos++;
  }

  for (gi_arg_pos = 0; gi_arg_pos < gi_argc; gi_arg_pos++) {
    GIDirection direction;
    gpointer arg_info;
    const ArgInfoKlass *arg_info_klass;

    if (!function_info_klass->get_arg (function_info,
                                       self,
                                       gi_arg_pos,
                                       &arg_info,
                                       &arg_info_klass,
                                       dart_error_out,
                                       error)) {
      return FALSE;
    }
    if (!arg_info_klass->get_direction (arg_info,
                                        self,
                                        &direction,
                                        dart_error_out,
                                        error)) {
      arg_info_klass->free (arg_info);
      return FALSE;
    }
    switch (direction) {
    case GI_DIRECTION_IN: {
      gpointer arg_type;
      const TypeInfoKlass *arg_type_klass;
      GITransfer transfer;

      gchar *arg_name, *arg_name_inner;

      if (!arg_info_klass->get_type (arg_info,
                                     self,
                                     &arg_type,
                                     &arg_type_klass,
                                     dart_error_out,
                                     error)) {
        arg_info_klass->free (arg_info);
        return FALSE;
      }

      if (!arg_info_klass->get_name (arg_info,
                                     self,
                                     &arg_name_inner,
                                     dart_error_out,
                                     error)) {
        arg_info_klass->free (arg_info);
        arg_type_klass->free (arg_type);
        return FALSE;
      }

      arg_name = g_strdup_printf ("%s.%s",
                                  name_prefix,
                                  arg_name_inner);
      g_free (arg_name_inner);
      if (!arg_info_klass->get_ownership_transfer (arg_info,
          self,
          &transfer,
          dart_error_out,
          error)) {
        arg_info_klass->free (arg_info);
        arg_type_klass->free (arg_type);
        g_free (arg_name);
        return FALSE;
      }
      if (transfer == GI_TRANSFER_NOTHING) {
        // We only have to deallocate arguments if they aren't
        // transfered.
        if (!_gdart_function_unfill_argument_in (self,
            arg_name,
            is_method,
            function_info,
            function_info_klass,
            &c_arg_pos,
            gi_arg_pos,
            arg_type,
            arg_type_klass,
            suppressed_args,
            gi_argc,
            in_arg_cvalues,
            trampolines,
            dart_error_out,
            error)) {
          arg_info_klass->free (arg_info);
          arg_type_klass->free (arg_type);
          g_free (arg_name);
          return FALSE;
        }
      }
      g_free (arg_name);
      arg_type_klass->free (arg_type);
      break;
    }
    case GI_DIRECTION_OUT: {
      /*
        if (!was_uncaught_error) {
            break;
        }
          gboolean is_caller_allocates;
          is_caller_allocates = g_arg_info_is_caller_allocates(&arg_info);

          GITypeInfo arg_type;
          g_arg_info_load_type(&arg_info, &arg_type);
          _gdart_function_unfill_argument_out(self,
                                                 is_caller_allocates,
                                                 &c_arg_pos,
                                                 gi_arg_pos,
                                                 &arg_type,
                                                 out_arg_cvalues);
          break;
          */
    }
    case GI_DIRECTION_INOUT: {
      /*
      GITypeInfo arg_type;
      g_arg_info_load_type(&arg_info, &arg_type);
      _gdart_function_unfill_argument_inout(self,
              function_info,
              &c_arg_pos,
              gi_arg_pos,
              &arg_type,
              suppressed_args,
              gi_argc,
              out_arg_cvalues,
              inout_original_arg_cvalues,
              trampolines) ;
      break;
      */
      c_arg_pos++;
      //TODO: Figure out what to do if anything
    }
    }
    arg_info_klass->free (arg_info);
  }
  if (can_throw_gerror) {
    gpointer slot;
    // slot = g_slice_alloc0(sizeof(gpointer));
    c_arg_pos++;
  }
  return TRUE;
}


static gboolean _gdart_prep_results (GdartBridgeContext *self,
                                     const gchar *name_prefix,
                                     gpointer function,
                                     const CallableInfoKlass *function_klass,
                                     gpointer return_type,
                                     const TypeInfoKlass *return_type_klass,
                                     gint *suppressed_args,
                                     gint suppressed_args_length,
                                     gint *out_argc_out,
                                     gint garg_length,
                                     gboolean can_throw_gerror,
                                     Dart_Handle *dart_error_out,
                                     GError **error)
{
  gint garg_i = 0;
  gint out_argc = 0;

  GITypeTag return_tag;
  if (G_UNLIKELY (!return_type_klass->get_tag (return_type,
                  self,
                  &return_tag,
                  dart_error_out,
                  error))) {
    return FALSE;
  }
  if (return_tag == GI_TYPE_TAG_BOOLEAN && can_throw_gerror) {
    ;
  } else if (return_tag != GI_TYPE_TAG_VOID) {
    out_argc++;
  }

  for (garg_i = 0; garg_i < garg_length; garg_i++) {
    gpointer arg_info;
    const ArgInfoKlass *arg_info_klass;

    gpointer type_info;
    const TypeInfoKlass *type_info_klass;

    GIDirection direction;

    if (G_UNLIKELY (!function_klass->get_arg (function,
                    self,
                    garg_i,
                    &arg_info,
                    &arg_info_klass,
                    dart_error_out,
                    error))) {
      return FALSE;
    }
    if (G_UNLIKELY (!arg_info_klass->get_direction (arg_info,
                    self,
                    &direction,
                    dart_error_out,
                    error))) {
      arg_info_klass->free (arg_info);
      return FALSE;
    }

    if (direction == GI_DIRECTION_OUT) {
      GITypeTag type_tag;

      out_argc++;
      if (G_UNLIKELY (!arg_info_klass->get_type (arg_info,
                      self,
                      &type_info,
                      &type_info_klass,
                      dart_error_out,
                      error))) {
        arg_info_klass->free (arg_info);
        return FALSE;
      }
      if (G_UNLIKELY (!type_info_klass->get_tag (type_info,
                      self,
                      &type_tag,
                      dart_error_out,
                      error))) {
        type_info_klass->free (type_info);
        arg_info_klass->free (arg_info);
        return FALSE;
      }
      switch (type_tag) {
      case GI_TYPE_TAG_ARRAY: {
        gint arg_to_suppress, arg_i = 0;
        if (G_UNLIKELY (!type_info_klass->get_array_length (type_info,
                        self,
                        &arg_to_suppress,
                        dart_error_out,
                        error))) {
          type_info_klass->free (type_info);
          arg_info_klass->free (arg_info);
          return FALSE;
        }
        if (arg_to_suppress != -1) {
          for (; arg_i < suppressed_args_length; arg_i++) {
            if (suppressed_args[arg_i] == -1) {
              out_argc--;
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
      type_info_klass->free (type_info);
    } else if (direction == GI_DIRECTION_INOUT) {
      gint arg_i = 0;
      for (; arg_i < suppressed_args_length; arg_i++) {
        if (suppressed_args[arg_i] == garg_i) {
          out_argc--;
        } else if (suppressed_args[arg_i] == -1) {
          break;
        }
      }
      out_argc++;
    }
    arg_info_klass->free (arg_info);
  }
  (*out_argc_out) = out_argc;
  return TRUE;
}


static void _gdart_function_result_load_boolean (
  GdartBridgeContext *self,
  const gchar *error_prefix,
  GIArgument *gi_return_value,
  gint *out_arg_pos_out, //in-out
  Dart_Handle *dart_out)   //status
{
  gint out_arg_pos = (*out_arg_pos_out);
  gboolean result = gi_return_value->v_boolean;
  dart_out[out_arg_pos++] = Dart_NewBoolean ( (bool) result);
  *out_arg_pos_out = out_arg_pos;
}



static gboolean _gdart_function_result_load_int (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  GIArgument *gi_return_value,
  GITypeTag type_tag,
  gint *out_arg_pos_out, //in-out
  Dart_Handle *dart_out,
  Dart_Handle *dart_error_out, //status
  GError **error)
{
  gint out_arg_pos = (*out_arg_pos_out);
  gint64 result;
  guint64 result_unsigned;
  switch (type_tag) {
  case GI_TYPE_TAG_INT8:
    result = (gint64) gi_return_value->v_int8;
    break;
  case GI_TYPE_TAG_UINT8:
    result = (gint64) gi_return_value->v_uint8;
    break;
  case GI_TYPE_TAG_INT16:
    result = (gint64) gi_return_value->v_int16;
    break;
  case GI_TYPE_TAG_UINT16:
    result = (gint64) gi_return_value->v_uint16;
    break;
  case GI_TYPE_TAG_INT32:
    result = (gint64) gi_return_value->v_int32;
    break;
  case GI_TYPE_TAG_UINT32:
    result = (gint64) gi_return_value->v_uint32;
    break;
  case GI_TYPE_TAG_INT64:
    result = (gint64) gi_return_value->v_int64;
    break;
  case GI_TYPE_TAG_UINT64:
    result_unsigned = (guint64) gi_return_value->v_uint64;
    break;
  case GI_TYPE_TAG_GTYPE:
    result_unsigned = (guint64) gi_return_value->v_size;
    break;
  default:
    *dart_error_out = gdart_bridge_context_create_error_handle (
                        self,
                        "%s: expected an integer-like type", G_STRFUNC);
    g_set_error (error, GDART_ERROR, 1,
                 "%s: expected an integer-like type", G_STRFUNC);
    goto error;
  }
  switch (type_tag) {
  case GI_TYPE_TAG_GTYPE:
  case GI_TYPE_TAG_UINT64:
    dart_out[out_arg_pos++] = Dart_NewIntegerFromUint64 (result_unsigned);
    break;
  default:
    dart_out[out_arg_pos++] = Dart_NewInteger (result);
    break;
  }
  *out_arg_pos_out = out_arg_pos;
  return TRUE;
error:
  return FALSE;
}


static gint _gdart_function_result_load_int_raw (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  gpointer function_info,
  const CallableInfoKlass *function_info_klass,
  gint gi_arg_pos,
  GIArgument *in_arg_cvalues,
  gint c_arg_pos,
  Dart_Handle *dart_error_out, //status
  GError **error)
{
  gpointer arg_info;
  const ArgInfoKlass *arg_info_klass;

  gpointer type_info;
  const TypeInfoKlass *type_info_klass;

  GITypeTag return_tag;
  GIArgument *gi_return_value = &in_arg_cvalues[c_arg_pos];
  gint64 result;

  if (G_UNLIKELY (!function_info_klass->get_arg (function_info,
                  self,
                  gi_arg_pos,
                  &arg_info,
                  &arg_info_klass,
                  dart_error_out,
                  error))) {
    return -1;
  }
  if (G_UNLIKELY (!arg_info_klass->get_type (arg_info,
                  self,
                  &type_info,
                  &type_info_klass,
                  dart_error_out,
                  error))) {
    arg_info_klass->free (arg_info);
    return -1;
  }
  arg_info_klass->free (arg_info);
  if (G_UNLIKELY (!type_info_klass->get_tag (type_info,
                  self,
                  &return_tag,
                  dart_error_out,
                  error))) {
    type_info_klass->free (type_info);
    return -1;
  }
  type_info_klass->free (type_info);
  switch (return_tag) {
  case GI_TYPE_TAG_BOOLEAN:
    result = (gint64) * ( (gint *) gi_return_value->v_pointer);
    break;
  case GI_TYPE_TAG_INT8:
    result = (gint64) * ( (gint8 *) gi_return_value->v_pointer);
    break;
  case GI_TYPE_TAG_UINT8:
    result = (gint64) * ( (guint8 *) gi_return_value->v_pointer);
    break;
  case GI_TYPE_TAG_INT16:
    result = (gint64) * ( (gint16 *) gi_return_value->v_pointer);
    break;
  case GI_TYPE_TAG_UINT16:
    result = (gint64) * ( (guint16 *) gi_return_value->v_pointer);
    break;
  case GI_TYPE_TAG_INT32:
    result = (gint64) * ( (gint32 *) gi_return_value->v_pointer);
    break;
  case GI_TYPE_TAG_UINT32:
    result = (gint64) * ( (guint32 *) gi_return_value->v_pointer);
    break;
  case GI_TYPE_TAG_INT64:
    result = (gint64) * ( (gint64 *) gi_return_value->v_pointer);
    break;
  case GI_TYPE_TAG_UINT64:
    result = (gint64) * ( (guint64 *) gi_return_value->v_pointer);
    break;
  default:
    *dart_error_out = gdart_bridge_context_create_error_handle (
                        self,
                        "%s: expected an integer-like type", G_STRFUNC);
    g_set_error (error, GDART_ERROR, 1,
                 "%s: expected an integer-like type", G_STRFUNC);
    result = -1;
  }
  return result;
}

static gboolean _gdart_function_result_load_num (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  GIArgument *gi_return_value,
  GITypeTag type_tag,
  gint *out_arg_pos_out, //in-out
  Dart_Handle *dart_out,
  Dart_Handle *dart_error_out, //status
  GError **error)
{
  gint out_arg_pos = (*out_arg_pos_out);
  gdouble result;
  switch (type_tag) {
  case GI_TYPE_TAG_FLOAT:
    result = (gdouble) gi_return_value->v_float;
    break;
  case GI_TYPE_TAG_DOUBLE:
    result = gi_return_value->v_double;
    break;
  default:
    *dart_error_out = gdart_bridge_context_create_error_handle (
                        self,
                        "%s: expected an integer-like type", G_STRFUNC);
    g_set_error (error, GDART_ERROR, 1,
                 "%s: expected an integer-like type", G_STRFUNC);
    goto error;
  }
  dart_out[out_arg_pos++] = Dart_NewDouble (result);
  *out_arg_pos_out = out_arg_pos;
  return TRUE;
error:
  return FALSE;
}


static gboolean _gdart_function_result_load_string (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  GIArgument *gi_return_value,
  GITransfer transfer,
  GITypeTag type_tag,
  gint *out_arg_pos_out, //in-out
  Dart_Handle *dart_out,
  Dart_Handle *dart_error_out, //status
  GError **error)
{
  gint out_arg_pos = (*out_arg_pos_out);
  gchar *result, *result_filename;
  gboolean deallocate = FALSE;
  gsize bytes_read, bytes_written;
  GError *inner_error = NULL;
  gintptr codepoints;
  if (transfer == GI_TRANSFER_EVERYTHING) {
    deallocate = TRUE;
  }
  switch (type_tag) {
  case GI_TYPE_TAG_UTF8:
    result = (gchar *) gi_return_value->v_string;
    if (result == NULL) { goto null_out; }
    break;
  case GI_TYPE_TAG_FILENAME:
    result_filename = (gchar *) gi_return_value->v_string;
    if (result_filename == NULL) { goto null_out; }
    result = g_filename_to_utf8 (result_filename,
                                 -1,
                                 &bytes_read,
                                 &bytes_written,
                                 &inner_error);
    if (result == NULL) {
      *dart_error_out = gdart_bridge_context_create_error_handle (
                          self,
                          "%s",
                          inner_error->message);
      g_propagate_error (error, inner_error);
      return FALSE;
    }
    if (deallocate) {
      g_free (result_filename);
    }
    deallocate = TRUE;
    break;
  default:
    *dart_error_out = gdart_bridge_context_create_error_handle (
                        self,
                        "%s: expected an integer-like type", G_STRFUNC);
    g_set_error (error, GDART_ERROR, 1,
                 "%s: expected an integer-like type", G_STRFUNC);
    goto error;
  }
  codepoints = (gintptr) g_utf8_strlen (result, -1);
  dart_out[out_arg_pos++] = Dart_NewStringFromUTF8 ( (guint8 *) result, codepoints);
  if (deallocate) {
    g_free (result);
  }
  *out_arg_pos_out = out_arg_pos;
  return TRUE;
null_out:
  dart_out[out_arg_pos++] = Dart_Null();
  *out_arg_pos_out = out_arg_pos;
  return TRUE;
error:
  return FALSE;
}




static gboolean _gdart_function_result_load_array (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  gpointer function_info,
  const CallableInfoKlass *function_info_klass,
  gboolean is_method,
  GIArgument *gi_return_value,
  GIArgument *in_arg_cvalues,
  gpointer type_info,
  const TypeInfoKlass *type_info_klass,
  GITransfer transfer,
  gint *out_arg_pos_out, //in-out
  Dart_Handle *dart_out,
  Dart_Handle *dart_error_out, //status
  GError **error)
{
  gint out_arg_pos = (*out_arg_pos_out);

  gpointer result;
  gboolean deallocate = FALSE, deallocate_members = FALSE,
           is_null_terminated;
  gint length;
  gint length_parameter;

  gpointer param_type;
  const TypeInfoKlass *param_type_klass;

  Dart_Handle dart_list;

  if (transfer == GI_TRANSFER_EVERYTHING) {
    deallocate = TRUE;
    deallocate_members = TRUE;
  } else if (transfer == GI_TRANSFER_CONTAINER) {
    deallocate = TRUE;
  }

  result = gi_return_value->v_pointer;
  if (G_UNLIKELY (!type_info_klass->get_array_length (type_info,
                  self,
                  &length_parameter,
                  dart_error_out,
                  error))) {
    return FALSE;
  }

  if (G_UNLIKELY (!type_info_klass->is_zero_terminated (type_info,
                  self,
                  &is_null_terminated,
                  dart_error_out,
                  error))) {
    return FALSE;
  }

  if (length_parameter != -1) {
    gint length_parameter_c;
    if (is_method) {
      length_parameter_c = length_parameter + 1;
    } else {
      length_parameter_c = length_parameter;
    }
    length = _gdart_function_result_load_int_raw (self,
             name_prefix,
             function_info,
             function_info_klass,
             length_parameter,
             in_arg_cvalues,
             length_parameter_c,
             dart_error_out,
             error);
    if (length == -1) {
      return FALSE;
    }
  } else if (is_null_terminated) {
    length = -1;
  } else {
    if (G_UNLIKELY (!type_info_klass->get_array_fixed_size (type_info,
                    self,
                    &length,
                    dart_error_out,
                    error))) {
      return FALSE;
    }
    if (length == -1) {
      return FALSE;
    }
  }
  if (G_UNLIKELY (!type_info_klass->get_param_type (type_info,
                  self,
                  0,
                  &param_type,
                  &param_type_klass,
                  dart_error_out,
                  error))) {
    return FALSE;
  }
  if (!gdart_array_load_parameters (self,
                                    name_prefix,
                                    param_type,
                                    param_type_klass,
                                    length,
                                    is_null_terminated,
                                    deallocate_members,
                                    result,
                                    &dart_list,
                                    dart_error_out,
                                    error)) {
    param_type_klass->free (param_type);
    return FALSE;
  }
  dart_out[out_arg_pos++] = dart_list;
  param_type_klass->free (param_type);
  if (deallocate) {
    g_free (result);
  }
  *out_arg_pos_out = out_arg_pos;
  return TRUE;
}

static gboolean _gdart_function_result_load_wrapped_pointer (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  GICallableInfo *function_info,
  gboolean is_method,
  gboolean must_copy,
  gboolean is_user_allocated,
  gboolean is_main,
  GIArgument *gi_return_value,
  GIArgument *gi_return_value_user_allocated,
  GIArgument *in_arg_cvalues,
  gpointer registered_type_info, //heap allocated
  const RegisteredTypeInfoKlass *registered_type_info_klass,
  GIInfoType info_type,
  gint *out_arg_pos_out, //in-out
  Dart_Handle *dart_out,
  Dart_Handle *dart_error_out, //status
  GError **error)
{
  gint out_arg_pos = (*out_arg_pos_out);
  gchar *namespace_;
  GType gtype;
  gpointer raw_result;
  GdartBridgeContextWrappedObject *object_wrapper;
  Dart_Handle internal_container, wrapped_object;
  GIRegisteredTypeInfo *type_info = NULL;

  if (is_user_allocated) {
    raw_result = gi_return_value_user_allocated->v_pointer;
    must_copy = FALSE;
  } else {
    raw_result = gi_return_value->v_pointer;
  }
  if (raw_result == NULL) {
    dart_out[out_arg_pos++] = Dart_Null();
    *out_arg_pos_out = out_arg_pos;
    return TRUE;
  }

  object_wrapper = g_slice_new (GdartBridgeContextWrappedObject);
  object_wrapper->copy_func_ref = NULL;
  object_wrapper->free_func_ref = NULL;
  if (G_UNLIKELY (!registered_type_info_klass->get_gtype (registered_type_info,
                  self,
                  &gtype,
                  dart_error_out,
                  error))) {
    return FALSE;
  }
  if ( (info_type == GI_INFO_TYPE_OBJECT && g_type_is_a (gtype, G_TYPE_OBJECT))
       || info_type == GI_INFO_TYPE_INTERFACE) {
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
    //printf("Brought in a foreign registered type. Ref count is now %i\n", ++gi_count);
    object_wrapper->object_info = type_info;
    object_wrapper->object_info_klass = gi_registered_type_info_registered_type_info;
    //registered_type_info_klass->free(registered_type_info);
    registered_type_info = type_info;
    registered_type_info_klass = &gi_registered_type_info_registered_type_info;
  }
  if (G_UNLIKELY (!registered_type_info_klass->get_namespace (registered_type_info,
                  self,
                  &namespace_,
                  dart_error_out,
                  error))) {
    return FALSE;
  }
  switch (info_type) {
  case GI_INFO_TYPE_UNION:
  case GI_INFO_TYPE_STRUCT: {
    gchar *name;
    const StructUnionInfoKlass *klass;

    klass = registered_type_info_klass->cast_to_struct_union_info (registered_type_info);
    if (G_UNLIKELY (!registered_type_info_klass->get_name (registered_type_info,
                    self,
                    &name,
                    dart_error_out,
                    error))) {
      g_free (namespace_);
      return FALSE;
    }
    if (G_UNLIKELY (!klass->retrieve_copy_function (registered_type_info,
                    self,
                    &object_wrapper->copy_func_ref,
                    dart_error_out,
                    error))) {
      g_free (namespace_);
      return FALSE;
    }
    if (G_UNLIKELY (!klass->retrieve_free_function (registered_type_info,
                    self,
                    &object_wrapper->free_func_ref,
                    dart_error_out,
                    error))) {
      gdart_function_reference_unref (object_wrapper->copy_func_ref);
      g_free (namespace_);
      return FALSE;
    }

    if (object_wrapper->copy_func_ref != NULL) {
      object_wrapper->copy_func = object_wrapper->copy_func_ref->function_pointer;
    } else {
      object_wrapper->copy_func = NULL;
    }
    if (object_wrapper->free_func_ref != NULL) {
      object_wrapper->free_func = object_wrapper->free_func_ref->function_pointer;
    } else {
      object_wrapper->free_func = NULL;
    }
    if (must_copy) {
      if (object_wrapper->copy_func == NULL) {
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
    g_free (name);
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
  case GI_INFO_TYPE_OBJECT:
  case GI_INFO_TYPE_INTERFACE:
    if (must_copy && !is_main) {
      GIObjectInfoRefFunction refer;
      GdartFunctionReference *refer_reference;

      if (!registered_type_info_klass->
          cast_to_object_info (registered_type_info)->
          get_ref_function_pointer (registered_type_info,
                                    self,
                                    &refer,
                                    &refer_reference,
                                    dart_error_out,
                                    error)) {
        g_free (namespace_);
        return FALSE;
      }
      if (refer != NULL) {
        raw_result = refer (raw_result);
      } else {
        raw_result = g_object_ref (raw_result);
      }
      gdart_function_reference_unref (refer_reference);
    } else if (must_copy) {
      GIObjectInfoRefFunction refer;
      GdartFunctionReference *refer_reference;

      if (!registered_type_info_klass->
          cast_to_object_info (registered_type_info)->
          get_ref_function_pointer (registered_type_info,
                                    self,
                                    &refer,
                                    &refer_reference,
                                    dart_error_out,
                                    error)) {
        g_free (namespace_);
        return FALSE;
      }
      if (refer != NULL) {
        raw_result = refer (raw_result);
      } else {
        raw_result = g_object_ref_sink (raw_result);
        //if this is the main result, assume we are given a floating reference.
      }
      gdart_function_reference_unref (refer_reference);
    }
    object_wrapper->object = raw_result;
    internal_container = gdart_bridge_context_wrap_pointer (self,
                         object_wrapper,
                         gdart_bridge_context_finalize_wrapped_gobject,
                         dart_error_out,
                         error);
    break;
  default:
    g_free (namespace_);
    g_assert_not_reached();
  }
  if (internal_container == NULL) {
    g_free (namespace_);
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
  g_free (namespace_);
  if (wrapped_object == NULL) {
    return FALSE;
  }
  dart_out[out_arg_pos++] = wrapped_object;
  *out_arg_pos_out = out_arg_pos;
  return TRUE;
}


static gboolean _gdart_function_result_load_wrapped_pointer_with_g_error (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  gboolean must_copy,
  GIArgument *gi_return_value,
  gint *out_arg_pos_out, //in-out
  Dart_Handle *dart_out,
  Dart_Handle *dart_error_out, //status
  GError **error)
{
  gpointer raw_result;
  GError *error_to_throw;
  Dart_Handle result;
  gint out_arg_pos = (*out_arg_pos_out);

  raw_result = gi_return_value->v_pointer;
  if (raw_result == NULL) {
    dart_out[out_arg_pos++] = Dart_Null();
    *out_arg_pos_out = out_arg_pos;
    return TRUE;
  }
  error_to_throw = (GError *) raw_result;
  result = gdart_bridge_context_wrap_class_for_error (self,
           error_to_throw->domain,
           error_to_throw->code,
           error_to_throw->message,
           dart_error_out,
           error);
  if (!must_copy) {
    g_error_free (error_to_throw);
  }
  if (result == NULL) { return FALSE; }

  dart_out[out_arg_pos++] = result;
  *out_arg_pos_out = out_arg_pos;
  return TRUE;
}

static gboolean _gdart_function_result_load_wrapped_pointer_with_g_type (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  gboolean must_copy,
  GIArgument *gi_return_value,
  GType gtype,
  gboolean is_boxed_type,
  gpointer registered_type_info, // or NULL for a List or SList, heap allocted
  const RegisteredTypeInfoKlass *registered_type_info_klass,
  gint *out_arg_pos_out, //in-out
  Dart_Handle *dart_out,
  Dart_Handle *dart_error_out, //status
  GError **error)
{
  gint out_arg_pos = (*out_arg_pos_out);
  gchar *namespace_;
  gpointer raw_result;
  GdartBridgeContextWrappedObject *object_wrapper;
  Dart_Handle internal_container, wrapped_object;
  if (gtype == G_TYPE_ERROR) {
    return _gdart_function_result_load_wrapped_pointer_with_g_error (
             self,
             name_prefix,
             must_copy,
             gi_return_value,
             out_arg_pos_out,
             dart_out,
             dart_error_out,
             error);
  }

  raw_result = gi_return_value->v_pointer;
  if (raw_result == NULL) {
    dart_out[out_arg_pos++] = Dart_Null();
    *out_arg_pos_out = out_arg_pos;
    return TRUE;
  }

  object_wrapper = g_slice_new (GdartBridgeContextWrappedObject);
  object_wrapper->copy_func_ref = NULL;
  object_wrapper->free_func_ref = NULL;
  if (registered_type_info != NULL) {
    object_wrapper->object_info = registered_type_info_klass->copy (registered_type_info);
    object_wrapper->object_info_klass = *registered_type_info_klass;
  } else {
    object_wrapper->object_info = NULL;
    object_wrapper->object_info_klass = null_registered_type_info;
  }
  if (registered_type_info != NULL) {
    if (G_UNLIKELY (!registered_type_info_klass->get_namespace (registered_type_info,
                    self,
                    &namespace_,
                    dart_error_out,
                    error))) {
      return FALSE;
    }
  } else {
    namespace_ = g_strdup ("Base");
  }
  const StructUnionInfoKlass *klass;

  klass = registered_type_info_klass->cast_to_struct_union_info (registered_type_info);
  if (G_UNLIKELY (!klass->retrieve_copy_function (registered_type_info,
                  self,
                  &object_wrapper->copy_func_ref,
                  dart_error_out,
                  error))) {
    g_free (namespace_);
    return FALSE;
  }
  if (G_UNLIKELY (!klass->retrieve_free_function (registered_type_info,
                  self,
                  &object_wrapper->free_func_ref,
                  dart_error_out,
                  error))) {
    gdart_function_reference_unref (object_wrapper->copy_func_ref);
    g_free (namespace_);
    return FALSE;
  }
  if (object_wrapper->copy_func_ref != NULL) {
    object_wrapper->copy_func = object_wrapper->copy_func_ref->function_pointer;
  } else {
    object_wrapper->copy_func = NULL;
  }
  if (object_wrapper->free_func_ref != NULL) {
    object_wrapper->free_func = object_wrapper->free_func_ref->function_pointer;
  } else {
    object_wrapper->free_func = NULL;
  }
  if (must_copy && is_boxed_type) {
    object_wrapper->object = g_boxed_copy (gtype, raw_result);
    internal_container = gdart_bridge_context_wrap_pointer (self,
                         object_wrapper,
                         gdart_bridge_context_finalize_wrapped_boxed,
                         dart_error_out,
                         error);
  } else if (must_copy) {
    gchar *name;
    if (G_UNLIKELY (!registered_type_info_klass->get_name (registered_type_info,
                    self,
                    &name,
                    dart_error_out,
                    error))) {
      g_free (namespace_);
      return FALSE;
    }
    if (object_wrapper->copy_func == NULL) {
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
    } else {
      object_wrapper->object = object_wrapper->copy_func (raw_result);
      internal_container = gdart_bridge_context_wrap_pointer (self,
                           object_wrapper,
                           gdart_bridge_context_finalize_wrapped_custom_struct,
                           dart_error_out,
                           error);
    }
    g_free (name);
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
    g_free (namespace_);
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
  g_free (namespace_);
  if (wrapped_object == NULL) {
    return FALSE;
  }
  dart_out[out_arg_pos++] = wrapped_object;
  *out_arg_pos_out = out_arg_pos;
  return TRUE;
}


static gboolean _gdart_function_result_load_enum (GdartBridgeContext *self,
    const gchar *name_prefix,
    GIArgument *gi_return_value,
    gpointer base_info,
    const EnumInfoKlass *base_info_klass,
    gint *out_arg_pos_out,
    Dart_Handle *dart_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
  gchar *namespace_;
  GITypeTag type_tag;
  Dart_Handle value, wrapper, result;
  gint index = 0, out_arg_pos;
  GType gtype;

  out_arg_pos = *out_arg_pos_out;
  if (G_UNLIKELY (!base_info_klass->get_storage_type (base_info,
                  self,
                  &type_tag,
                  dart_error_out,
                  error))) {
    return FALSE;
  }
  if (!_gdart_function_result_load_int (self, name_prefix, gi_return_value, type_tag,
                                        &index, &value, dart_error_out,
                                        error)) {
    return FALSE;
  }
  if (G_UNLIKELY (!base_info_klass->get_namespace (base_info,
                  self,
                  &namespace_,
                  dart_error_out,
                  error))) {
    return FALSE;
  }
  if (G_UNLIKELY (!base_info_klass->get_gtype (base_info,
                  self,
                  &gtype,
                  dart_error_out,
                  error))) {
    g_free (namespace_);
    return FALSE;
  }
  if (G_UNLIKELY (!base_info_klass->retrieve_wrapping_class (
                    base_info,
                    self,
                    namespace_,
                    &wrapper,
                    dart_error_out,
                    error))) {
    g_free (namespace_);
    return FALSE;
  }
  g_free (namespace_);
  if (wrapper == NULL) {
    return FALSE;
  }
  result = Dart_New (wrapper, Dart_Null(), 1, &value);
  if (G_UNLIKELY (Dart_IsError (result))) {
    g_warning ("%s: dart threw an error", name_prefix);
    *dart_error_out = result;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
    return FALSE;
  }
  dart_out[out_arg_pos++] = result;
  *out_arg_pos_out = out_arg_pos;
  return TRUE;
}


static gboolean _gdart_function_result_load_interface (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  gpointer function_info,
  const CallableInfoKlass *function_info_klass,
  gboolean is_method,
  gboolean is_user_allocated,
  gboolean is_main,
  GIArgument *gi_return_value,
  GIArgument *gi_return_value_user_allocated,
  GIArgument *in_arg_cvalues,
  gpointer type_info,
  const TypeInfoKlass *type_info_klass,
  GITransfer transfer,
  gint *out_arg_pos_out, //in-out
  Dart_Handle *dart_out,
  Dart_Handle *dart_error_out, //status
  GError **error)
{
  gpointer base_info;
  const InterfaceInfoKlass *base_info_klass;

  gboolean make_copy = TRUE, result;
  GIInfoType info_type;

  if (G_UNLIKELY (!type_info_klass->get_interface (type_info,
                  self,
                  &base_info,
                  &base_info_klass,
                  dart_error_out,
                  error))) {
    return FALSE;
  }
  if (transfer == GI_TRANSFER_EVERYTHING || transfer == GI_TRANSFER_CONTAINER) {
    make_copy = FALSE;
  }
  if (G_UNLIKELY (!base_info_klass->get_type (base_info,
                  self,
                  &info_type,
                  dart_error_out,
                  error))) {
    base_info_klass->free (base_info);
    return FALSE;
  }
  switch (info_type) {
  case GI_INFO_TYPE_CALLBACK:
    //TODO: handle callbacks.
    *dart_error_out = gdart_bridge_context_create_error_handle (self,
                      "%s: can't handle callbacks yet", G_STRFUNC);
    g_set_error (error, GDART_ERROR, 1,
                 "%s: can't handle callbacks yet", G_STRFUNC);
    base_info_klass->free (base_info);
    return FALSE;
  case GI_INFO_TYPE_STRUCT:
  case GI_INFO_TYPE_BOXED:
  case GI_INFO_TYPE_UNION:
  case GI_INFO_TYPE_INTERFACE:
  case GI_INFO_TYPE_OBJECT: {
    const RegisteredTypeInfoKlass *klass;
    klass = base_info_klass->cast_to_registered_type_info (base_info);

    result = _gdart_function_result_load_wrapped_pointer (self,
             name_prefix,
             function_info,
             is_method,
             make_copy,
             is_user_allocated,
             is_main,
             gi_return_value,
             gi_return_value_user_allocated,
             in_arg_cvalues,
             base_info,
             klass,
             info_type,
             out_arg_pos_out,
             dart_out,
             dart_error_out,
             error);
    base_info_klass->free (base_info);
    return result;
    case GI_INFO_TYPE_ENUM:
    case GI_INFO_TYPE_FLAGS: {
      const EnumInfoKlass *klass;

      klass = base_info_klass->cast_to_enum_info (base_info);
      result = _gdart_function_result_load_enum (self,
               name_prefix,
               gi_return_value,
               base_info,
               klass,
               out_arg_pos_out,
               dart_out,
               dart_error_out,
               error);
      base_info_klass->free (base_info);
      return result;
    }
    default:
      *dart_error_out = gdart_bridge_context_create_error_handle (self,
                        "%s: received an unexpected base info type", G_STRFUNC);
      g_set_error (error, GDART_ERROR, 1,
                   "%s: received an unexpected base info type", G_STRFUNC);
      return FALSE;
    }
  }
}


static gboolean _gdart_function_result_load_return (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  gpointer function_info,
  const CallableInfoKlass *function_info_klass,
  gpointer arg_info, // or NULL if examining the main argument
  const ArgInfoKlass *arg_info_klass,
  gboolean is_method,
  gboolean can_throw_gerror,
  gboolean is_main_return,
  GArgument *in_arg_cvalues,
  GArgument *out_arg_cvalues,
  GArgument *inout_original_arg_cvalues,
  GIFFIReturnValue *gi_return_value,
  GIFFIReturnValue *gi_return_value_user_allocated,
  gpointer return_type,
  const TypeInfoKlass *return_type_klass,
  gint *out_arg_pos_out, //in-out
  Dart_Handle *dart_out, //out caller-allocates
  gint out_argc,
  Dart_Handle *dart_error_out, //status
  GError **error)   //status
{
  GITypeTag return_tag;
  GITransfer transfer;
  gboolean is_user_allocated = FALSE;
  if (G_UNLIKELY (!return_type_klass->get_tag (return_type,
                  self,
                  &return_tag,
                  dart_error_out,
                  error))) {
    return FALSE;
  }
  if (arg_info == NULL) {
    if (G_UNLIKELY (!function_info_klass->get_caller_owns (function_info,
                    self,
                    &transfer,
                    dart_error_out,
                    error))) {
      return FALSE;
    }
  } else {
    if (G_UNLIKELY (!arg_info_klass->get_ownership_transfer (arg_info,
                    self,
                    &transfer,
                    dart_error_out,
                    error))) {
      return FALSE;
    }
    if (G_UNLIKELY (!arg_info_klass->is_caller_allocates (arg_info,
                    self,
                    &is_user_allocated,
                    dart_error_out,
                    error))) {
      return FALSE;
    }
  }
  switch (return_tag) {
  case GI_TYPE_TAG_VOID:
    return TRUE; //no change;
  case GI_TYPE_TAG_BOOLEAN:
    if (can_throw_gerror) {
      return TRUE;
    }
    _gdart_function_result_load_boolean (self,
                                         name_prefix,
                                         gi_return_value,
                                         out_arg_pos_out,
                                         dart_out);
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
    return _gdart_function_result_load_int (self,
                                            name_prefix,
                                            gi_return_value,
                                            return_tag,
                                            out_arg_pos_out,
                                            dart_out,
                                            dart_error_out,
                                            error);
  case GI_TYPE_TAG_FLOAT:
  case GI_TYPE_TAG_DOUBLE:
    return _gdart_function_result_load_num (self,
                                            name_prefix,
                                            gi_return_value,
                                            return_tag,
                                            out_arg_pos_out,
                                            dart_out,
                                            dart_error_out,
                                            error);
  case GI_TYPE_TAG_UTF8:
  case GI_TYPE_TAG_FILENAME:
    return _gdart_function_result_load_string (self,
           name_prefix,
           gi_return_value,
           transfer,
           return_tag,
           out_arg_pos_out,
           dart_out,
           dart_error_out,
           error);
  case GI_TYPE_TAG_ARRAY:
    return _gdart_function_result_load_array (self,
           name_prefix,
           function_info,
           function_info_klass,
           is_method,
           gi_return_value,
           in_arg_cvalues,
           return_type,
           return_type_klass,
           transfer,
           out_arg_pos_out,
           dart_out,
           dart_error_out,
           error);
  case GI_TYPE_TAG_INTERFACE:
    return _gdart_function_result_load_interface (self,
           name_prefix,
           function_info,
           function_info_klass,
           is_method,
           is_user_allocated,
           (arg_info != NULL),
           gi_return_value,
           gi_return_value_user_allocated,
           in_arg_cvalues,
           return_type,
           return_type_klass,
           transfer,
           out_arg_pos_out,
           dart_out,
           dart_error_out,
           error);
  case GI_TYPE_TAG_GLIST:
    //I'm sure there's some kind of problem here. Transfering GLists is
    //bound to create issues.
    return _gdart_function_result_load_wrapped_pointer_with_g_type (
             self,
             name_prefix,
             (transfer == GI_TRANSFER_NOTHING),
             gi_return_value,
             G_DART_COMPAT_LIST_TYPE,
             FALSE,
             NULL,
             &null_registered_type_info,
             out_arg_pos_out,
             dart_out,
             dart_error_out,
             error);
  case GI_TYPE_TAG_GSLIST:
    //I'm sure there's some kind of problem here. Transfering GLists is
    //bound to create issues.
    return _gdart_function_result_load_wrapped_pointer_with_g_type (
             self,
             name_prefix,
             (transfer == GI_TRANSFER_NOTHING),
             gi_return_value,
             G_DART_COMPAT_SLIST_TYPE,
             FALSE,
             NULL,
             &null_registered_type_info,
             out_arg_pos_out,
             dart_out,
             dart_error_out,
             error);
  case GI_TYPE_TAG_GHASH: {
    GIRegisteredTypeInfo *type_info;
    gboolean result;

    type_info = (GIRegisteredTypeInfo *) g_irepository_find_by_gtype (
                  gdart_bridge_context_get_gi_repository (self),
                  G_TYPE_HASH_TABLE); //heap allocated
    //printf("Brought in a foreign registered type. Ref count is now %i\n", ++gi_count);
    result = _gdart_function_result_load_wrapped_pointer_with_g_type (
               self,
               name_prefix,
               (transfer == GI_TRANSFER_NOTHING),
               gi_return_value,
               G_TYPE_HASH_TABLE,
               TRUE,
               type_info,
               &gi_registered_type_info_registered_type_info,
               out_arg_pos_out,
               dart_out,
               dart_error_out,
               error);
    g_base_info_unref (type_info);
    return result;
  }
  case GI_TYPE_TAG_ERROR: {
    //TODO: Handle GErrors better.
    GIRegisteredTypeInfo *type_info;
    gboolean result;

    type_info = (GIRegisteredTypeInfo *) g_irepository_find_by_gtype (
                  gdart_bridge_context_get_gi_repository (self),
                  G_TYPE_ERROR); //heap allocated
    //printf("Brought in a foreign registered type. Ref count is now %i\n", ++gi_count);
    result = _gdart_function_result_load_wrapped_pointer_with_g_type (
               self,
               name_prefix,
               (transfer == GI_TRANSFER_NOTHING),
               gi_return_value,
               G_TYPE_ERROR,
               TRUE,
               type_info,
               &gi_registered_type_info_registered_type_info,
               out_arg_pos_out,
               dart_out,
               dart_error_out,
               error);
    g_base_info_unref (type_info);
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

static gboolean _gdart_function_invoke_load_return_arguments (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  gpointer function_info,
  const CallableInfoKlass *function_info_klass,
  gboolean is_method,
  gboolean can_throw_gerror,
  gint c_argc,
  gint gi_argc,
  gint *suppressed_args,
  gint suppressed_args_length,
  GArgument *in_arg_cvalues,
  GArgument *out_arg_cvalues,
  GArgument *inout_original_arg_cvalues,
  GIFFIReturnValue *gi_return_value,
  gpointer return_type,
  const TypeInfoKlass *return_type_klass,
  Dart_Handle *dart_out,
  gint out_argc,
  Dart_Handle *dart_error_out,
  GError **error)
{
  gint out_arg_pos = 0, gi_arg_pos = 0;
  gchar *return_identifier;
  Dart_Handle *outputs = g_newa (Dart_Handle, out_argc);
  return_identifier = g_strdup_printf ("%s[return]", name_prefix);

  if (!_gdart_function_result_load_return (self,
      return_identifier,
      function_info,
      function_info_klass,
      NULL,
      &null_arg_info,
      is_method,
      can_throw_gerror,
      TRUE,
      in_arg_cvalues,
      out_arg_cvalues,
      inout_original_arg_cvalues,
      gi_return_value,
      NULL,
      return_type,
      return_type_klass,
      &out_arg_pos,
      outputs,
      out_argc,
      dart_error_out,
      error)) {
    return FALSE;
  }
  for (; gi_arg_pos < gi_argc; gi_arg_pos++) {
    gint c_arg_pos, arg_i = 0;
    gpointer type_info;
    const TypeInfoKlass *type_info_klass;
    gpointer arg_info;
    const ArgInfoKlass *arg_info_klass;
    GIDirection direction;
    gchar *arg_identifier;
    gchar *arg_identifier_short;

    if (G_UNLIKELY (!function_info_klass->get_arg (function_info,
                    self,
                    gi_arg_pos,
                    &arg_info,
                    &arg_info_klass,
                    dart_error_out,
                    error))) {
      return FALSE;
    }
    if (G_UNLIKELY (!arg_info_klass->get_direction (arg_info,
                    self,
                    &direction,
                    dart_error_out,
                    error))) {
      arg_info_klass->free (arg_info);
      return FALSE;
    }
    if (direction == GI_DIRECTION_IN) {
      arg_info_klass->free (arg_info);
      continue;
    }
    for (; arg_i < suppressed_args_length; arg_i++) {
      if (suppressed_args[arg_i] == gi_arg_pos) {
        goto out;
      }
      if (suppressed_args[arg_i] == -1) { break; }
    }
    c_arg_pos = is_method ? gi_arg_pos + 1 : gi_arg_pos;
    if (G_UNLIKELY (!arg_info_klass->get_name (arg_info,
                    self,
                    &arg_identifier_short,
                    dart_error_out,
                    error))) {
      arg_info_klass->free (arg_info);
      return FALSE;
    }
    if (G_UNLIKELY (!arg_info_klass->get_type (arg_info,
                    self,
                    &type_info,
                    &type_info_klass,
                    dart_error_out,
                    error))) {
      g_free (arg_identifier_short);
      arg_info_klass->free (arg_info);
      return FALSE;
    }

    arg_identifier = g_strdup_printf ("%s.%s",
                                      name_prefix,
                                      arg_identifier_short);
    g_free (arg_identifier_short);
    if (!_gdart_function_result_load_return (self,
        arg_identifier,
        function_info,
        function_info_klass,
        arg_info,
        arg_info_klass,
        is_method,
        can_throw_gerror,
        FALSE,
        in_arg_cvalues,
        out_arg_cvalues,
        inout_original_arg_cvalues,
        &out_arg_cvalues[c_arg_pos],
        &in_arg_cvalues[c_arg_pos],
        type_info,
        type_info_klass,
        &out_arg_pos,
        outputs,
        out_argc,
        dart_error_out,
        error)) {
      type_info_klass->free (type_info);
      arg_info_klass->free (arg_info);
      g_free (arg_identifier);
      return FALSE;
    }
    g_free (arg_identifier);
    type_info_klass->free (type_info);
  out:
    arg_info_klass->free (arg_info);
    continue;
  }
  if (can_throw_gerror) {
    //TODO: Handle GErrors better.
    GIRegisteredTypeInfo *type_info;
    gboolean result;
    gint position = 0;
    Dart_Handle result_dart;
    gchar *error_identifier;

    error_identifier = g_strdup_printf ("%s.error", name_prefix);

    type_info = (GIRegisteredTypeInfo *) g_irepository_find_by_gtype (
                  gdart_bridge_context_get_gi_repository (self),
                  G_TYPE_ERROR); //heap allocated
    //printf("Brought in a foreign registered type. Ref count is now %i\n", ++gi_count);
    if (out_arg_cvalues[is_method ? gi_argc + 1 : gi_argc].v_pointer == NULL) {
      g_free (error_identifier);
      g_base_info_unref ( (GIBaseInfo *) type_info);
      goto success_out;
    }
    result = _gdart_function_result_load_wrapped_pointer_with_g_type (
               self,
               error_identifier,
               FALSE,
               &out_arg_cvalues[is_method ? gi_argc + 1 : gi_argc],
               G_TYPE_ERROR,
               TRUE,
               type_info,
               &gi_registered_type_info_registered_type_info,
               &position,
               &result_dart,
               dart_error_out,
               error);
    g_free (error_identifier);
    g_base_info_unref ( (GIBaseInfo *) type_info);
    if (!result) { return FALSE; }
    if (!Dart_IsNull (result_dart)) {
      GError *inner_error = NULL;
      *dart_error_out = result_dart;
      inner_error  = (GError *) out_arg_cvalues[is_method ? gi_argc + 1 : gi_argc].v_pointer;
      g_propagate_error (error, inner_error);
      return FALSE;
    }
  }
success_out:
  if (out_argc == 0) {
    *dart_out = Dart_Null();
  } else if (out_argc == 1) {
    *dart_out = outputs[0];
  } else {
    Dart_Handle result;
    gint out_arg_pos;
    result = Dart_NewList (out_argc);
    for (out_arg_pos = 0; out_arg_pos < out_argc; out_arg_pos++) {
      Dart_ListSetAt (result, out_arg_pos, outputs[out_arg_pos]);
    }
    *dart_out = result;
  }
  return TRUE;
}

gboolean gdart_function_invoke (GdartBridgeContext *self,
                                const gchar *name_prefix,
                                gpointer function_info,
                                const CallableInfoKlass *function_info_klass,
                                gpointer type_info,
                                const RegisteredTypeInfoKlass *type_info_klass,
                                GType type,
                                Dart_Handle dart_receiver,
                                Dart_Handle dart_args,
                                gint *suppressed_args,
                                gint suppressed_args_length,
                                Dart_Handle *result_out,
                                Dart_Handle *dart_error_out,
                                GError **error)
{
  GIFunctionInvoker invoker;
  GArgument *in_arg_cvalues, *out_arg_cvalues, *inout_original_arg_cvalues;
  gpointer *ffi_arg_pointers, prep_invoke_user_data;
  GIFFIReturnValue gi_return_value;
  GdartCallbackTrampoline **trampolines;
  gpointer return_value_p;
  gint c_argc, gi_argc, out_argc, c_arg_pos = 0;
  gboolean is_method, can_throw_gerror;
  gpointer return_type;
  const TypeInfoKlass *return_type_klass;
  GITypeTag return_tag;
  GIFunctionInvokerDestroyFunc invoker_destroy_func;

  if (!gdart_function_prep_invoke (self,
                                   name_prefix,
                                   function_info,
                                   function_info_klass,
                                   type,
                                   &invoker,
                                   &prep_invoke_user_data,
                                   &invoker_destroy_func,
                                   dart_error_out,
                                   error)) {
    return FALSE;
  }

  if (G_UNLIKELY (!function_info_klass->is_method (function_info,
                  self,
                  &is_method,
                  dart_error_out,
                  error))) {
    invoker_destroy_func (&invoker, prep_invoke_user_data);
    return FALSE;
  }

  if (G_UNLIKELY (!function_info_klass->can_throw_gerror (function_info,
                  self,
                  &can_throw_gerror,
                  dart_error_out,
                  error))) {
    invoker_destroy_func (&invoker, prep_invoke_user_data);
    return FALSE;
  }
  c_argc = invoker.cif.nargs;
  if (G_UNLIKELY (!function_info_klass->get_n_args (function_info,
                  self,
                  &gi_argc,
                  dart_error_out,
                  error))) {
    invoker_destroy_func (&invoker, prep_invoke_user_data);
    return FALSE;
  }

  in_arg_cvalues = g_newa (GArgument, c_argc);
  out_arg_cvalues = g_newa (GArgument, c_argc);
  inout_original_arg_cvalues = g_newa (GArgument, c_argc);
  ffi_arg_pointers = g_newa (gpointer, c_argc);
  trampolines = g_newa (GdartCallbackTrampoline *, c_argc);
  for (; c_arg_pos < c_argc; c_arg_pos++) {
    trampolines[c_arg_pos] = NULL;
  }

  if (!_gdart_function_invoke_fill_arguments (self,
      name_prefix,
      function_info,
      function_info_klass,
      type_info,
      type,
      dart_receiver,
      dart_args,
      is_method,
      can_throw_gerror,
      in_arg_cvalues,
      out_arg_cvalues,
      inout_original_arg_cvalues,
      ffi_arg_pointers,
      trampolines,
      c_argc,
      gi_argc,
      suppressed_args,
      suppressed_args_length,
      dart_error_out,
      error)) {
    invoker_destroy_func (&invoker, prep_invoke_user_data);
    return FALSE;
  }
  if (G_UNLIKELY (!function_info_klass->get_return_type (function_info,
                  self,
                  &return_type,
                  &return_type_klass,
                  dart_error_out,
                  error))) {
    invoker_destroy_func (&invoker, prep_invoke_user_data);
    return FALSE;
  }
  if (G_UNLIKELY (!return_type_klass->get_tag (return_type,
                  self,
                  &return_tag,
                  dart_error_out,
                  error))) {
    invoker_destroy_func (&invoker, prep_invoke_user_data);
    return_type_klass->free (return_type);
    return FALSE;
  }

  if (return_tag == GI_TYPE_TAG_FLOAT) {
    return_value_p = &gi_return_value.v_float;
  } else if (return_tag == GI_TYPE_TAG_DOUBLE) {
    return_value_p = &gi_return_value.v_double;
  } else if (return_tag == GI_TYPE_TAG_INT64 || return_tag == GI_TYPE_TAG_UINT64) {
    return_value_p = &gi_return_value.v_uint64;
  } else {
    return_value_p = &gi_return_value.v_long;
  }

  ffi_call (&invoker.cif,
            FFI_FN (invoker.native_address),
            return_value_p,
            ffi_arg_pointers);
  invoker_destroy_func (&invoker, prep_invoke_user_data);
  if (!_gdart_prep_results (self,
                            name_prefix,
                            function_info,
                            function_info_klass,
                            return_type,
                            return_type_klass,
                            suppressed_args,
                            suppressed_args_length,
                            &out_argc,
                            gi_argc,
                            can_throw_gerror,
                            dart_error_out,
                            error)) {
    return_type_klass->free (return_type);
    return FALSE;
  }

  gboolean result;
  result = _gdart_function_invoke_load_return_arguments (self,
           name_prefix,
           function_info,
           function_info_klass,
           is_method,
           can_throw_gerror,
           c_argc,
           gi_argc,
           suppressed_args,
           suppressed_args_length,
           in_arg_cvalues,
           out_arg_cvalues,
           inout_original_arg_cvalues,
           &gi_return_value,
           return_type,
           return_type_klass,
           result_out,
           out_argc,
           dart_error_out,
           error);
  return_type_klass->free (return_type);
  if (!_gdart_function_invoke_unfill_arguments (self,
      name_prefix,
      function_info,
      function_info_klass,
      is_method,
      can_throw_gerror,
      FALSE,
      in_arg_cvalues,
      out_arg_cvalues,
      inout_original_arg_cvalues,
      trampolines,
      c_argc,
      gi_argc,
      suppressed_args,
      suppressed_args_length,
      dart_error_out,
      error)) {
    result = FALSE;
  }
  for (c_arg_pos = 0; c_arg_pos < c_argc; c_arg_pos++) {
    if (trampolines[c_arg_pos] == NULL) {
      break;
    }
    _gdart_callback_closure_free_trampoline (trampolines[c_arg_pos]);
  }

  return result;
}

static gboolean _gdart_callback_copyback_out_argument (
  GdartBridgeContext *self,
  gpointer type_info,
  const TypeInfoKlass *type_info_klass,
  GIArgument *in_arg_cvalues,
  GIArgument *out_arg_cvalues,
  gint c_arg_pos,
  Dart_Handle *dart_error_out,
  GError **error)
{
  GITypeTag type_tag;
  if (!type_info_klass->get_tag (type_info,
                                 self,
                                 &type_tag,
                                 dart_error_out,
                                 error)) {
    return FALSE;
  }
  switch (type_tag) {
  case GI_TYPE_TAG_BOOLEAN:
    * ( (gboolean *) in_arg_cvalues[c_arg_pos].v_pointer) = out_arg_cvalues[c_arg_pos].v_boolean;
    break;
  case GI_TYPE_TAG_INT8:
  case GI_TYPE_TAG_UINT8:
    * ( (guint8 *) in_arg_cvalues[c_arg_pos].v_pointer) = out_arg_cvalues[c_arg_pos].v_uint8;
    break;
  case GI_TYPE_TAG_INT16:
  case GI_TYPE_TAG_UINT16:
    * ( (guint16 *) in_arg_cvalues[c_arg_pos].v_pointer) = out_arg_cvalues[c_arg_pos].v_uint16;
    break;
  case GI_TYPE_TAG_INT32:
  case GI_TYPE_TAG_UINT32:
    * ( (guint32 *) in_arg_cvalues[c_arg_pos].v_pointer) = out_arg_cvalues[c_arg_pos].v_uint32;
    break;
  case GI_TYPE_TAG_INT64:
  case GI_TYPE_TAG_UINT64:
  case GI_TYPE_TAG_GTYPE:
    * ( (guint64 *) in_arg_cvalues[c_arg_pos].v_pointer) = out_arg_cvalues[c_arg_pos].v_uint64;
    break;
  case GI_TYPE_TAG_FLOAT:
    * ( (gfloat *) in_arg_cvalues[c_arg_pos].v_pointer) = out_arg_cvalues[c_arg_pos].v_float;
    break;
  case GI_TYPE_TAG_DOUBLE:
    * ( (gdouble *) in_arg_cvalues[c_arg_pos].v_pointer) = out_arg_cvalues[c_arg_pos].v_double;
    break;
  case GI_TYPE_TAG_ARRAY:
  case GI_TYPE_TAG_UTF8:
  case GI_TYPE_TAG_FILENAME:
  case GI_TYPE_TAG_GLIST:
  case GI_TYPE_TAG_GSLIST:
  case GI_TYPE_TAG_GHASH:
  case GI_TYPE_TAG_ERROR:
    * ( (gpointer *) in_arg_cvalues[c_arg_pos].v_pointer) = out_arg_cvalues[c_arg_pos].v_pointer;
    break;
  case GI_TYPE_TAG_INTERFACE: {
    gpointer base_info;
    const InterfaceInfoKlass *base_info_klass;
    GIInfoType base_info_type;

    if (G_UNLIKELY (!type_info_klass->get_interface (type_info,
                    self,
                    &base_info,
                    &base_info_klass,
                    dart_error_out,
                    error))) {
      return FALSE;
    }
    if (G_UNLIKELY (!base_info_klass->get_type (base_info,
                    self,
                    &base_info_type,
                    dart_error_out,
                    error))) {
      base_info_klass->free (base_info);
      return FALSE;
    }
    switch (base_info_type) {
    case GI_INFO_TYPE_CALLBACK:
    case GI_INFO_TYPE_BOXED:
    case GI_INFO_TYPE_OBJECT:
    case GI_INFO_TYPE_INTERFACE:
    case GI_INFO_TYPE_STRUCT:
    case GI_INFO_TYPE_UNION:
      * ( (gpointer *) in_arg_cvalues[c_arg_pos].v_pointer) = out_arg_cvalues[c_arg_pos].v_pointer;
      break;
    case GI_INFO_TYPE_ENUM:
    case GI_INFO_TYPE_FLAGS: {
      const EnumInfoKlass *klass;
      GITypeTag storage_type;

      klass = base_info_klass->cast_to_enum_info (base_info);
      if (!klass->get_storage_type (base_info,
                                    self,
                                    &storage_type,
                                    dart_error_out,
                                    error)) {
        base_info_klass->free (base_info);
        return FALSE;
      }
      switch (storage_type) {
      case GI_TYPE_TAG_BOOLEAN:
        * ( (gboolean *) in_arg_cvalues[c_arg_pos].v_pointer) = out_arg_cvalues[c_arg_pos].v_boolean;
        break;
      case GI_TYPE_TAG_INT8:
      case GI_TYPE_TAG_UINT8:
        * ( (guint8 *) in_arg_cvalues[c_arg_pos].v_pointer) = out_arg_cvalues[c_arg_pos].v_uint8;
        break;
      case GI_TYPE_TAG_INT16:
      case GI_TYPE_TAG_UINT16:
        * ( (guint16 *) in_arg_cvalues[c_arg_pos].v_pointer) = out_arg_cvalues[c_arg_pos].v_uint16;
        break;
      case GI_TYPE_TAG_INT32:
      case GI_TYPE_TAG_UINT32:
        * ( (guint32 *) in_arg_cvalues[c_arg_pos].v_pointer) = out_arg_cvalues[c_arg_pos].v_uint32;
        break;
      case GI_TYPE_TAG_INT64:
      case GI_TYPE_TAG_UINT64:
      case GI_TYPE_TAG_GTYPE:
        * ( (guint64 *) in_arg_cvalues[c_arg_pos].v_pointer) = out_arg_cvalues[c_arg_pos].v_uint64;
        break;
      default:
        break;
      }
      base_info_klass->free (base_info);
    }
    break;
    default:
      break;
    }
  }
  break;
  default:
    break;
  }
  return TRUE;
}

static gboolean _gdart_callback_copy_ref_argument (
  GdartBridgeContext *self,
  gpointer type_info,
  const TypeInfoKlass *type_info_klass,
  GIArgument *in_arg_cvalues,
  GIArgument *inout_original_arg_cvalues,
  gint c_arg_pos,
  Dart_Handle *dart_error_out,
  GError **error)
{
  GITypeTag type_tag;
  if (G_UNLIKELY (!type_info_klass->get_tag (type_info,
                  self,
                  &type_tag,
                  dart_error_out,
                  error))) {
    return FALSE;
  }
  switch (type_tag) {
  case GI_TYPE_TAG_BOOLEAN:
    inout_original_arg_cvalues[c_arg_pos].v_boolean = * ( (gboolean *) in_arg_cvalues[c_arg_pos].v_pointer);
    break;
  case GI_TYPE_TAG_INT8:
  case GI_TYPE_TAG_UINT8:
    inout_original_arg_cvalues[c_arg_pos].v_uint8 = * ( (guint8 *) in_arg_cvalues[c_arg_pos].v_pointer);
    break;
  case GI_TYPE_TAG_INT16:
  case GI_TYPE_TAG_UINT16:
    inout_original_arg_cvalues[c_arg_pos].v_uint16 = * ( (guint16 *) in_arg_cvalues[c_arg_pos].v_pointer);
    break;
  case GI_TYPE_TAG_INT32:
  case GI_TYPE_TAG_UINT32:
    inout_original_arg_cvalues[c_arg_pos].v_uint32 = * ( (guint32 *) in_arg_cvalues[c_arg_pos].v_pointer);
    break;
  case GI_TYPE_TAG_INT64:
  case GI_TYPE_TAG_UINT64:
  case GI_TYPE_TAG_GTYPE:
    inout_original_arg_cvalues[c_arg_pos].v_uint64 = * ( (guint64 *) in_arg_cvalues[c_arg_pos].v_pointer);
    break;
  case GI_TYPE_TAG_FLOAT:
    inout_original_arg_cvalues[c_arg_pos].v_float = * ( (gfloat *) in_arg_cvalues[c_arg_pos].v_pointer);
    break;
  case GI_TYPE_TAG_DOUBLE:
    inout_original_arg_cvalues[c_arg_pos].v_double = * ( (gdouble *) in_arg_cvalues[c_arg_pos].v_pointer);
    break;
  case GI_TYPE_TAG_ARRAY:
  case GI_TYPE_TAG_UTF8:
  case GI_TYPE_TAG_FILENAME:
  case GI_TYPE_TAG_GLIST:
  case GI_TYPE_TAG_GSLIST:
  case GI_TYPE_TAG_GHASH:
  case GI_TYPE_TAG_ERROR:
    inout_original_arg_cvalues[c_arg_pos].v_pointer = * ( (gpointer *) in_arg_cvalues[c_arg_pos].v_pointer);
    break;
  case GI_TYPE_TAG_INTERFACE: {
    gpointer base_info;
    const InterfaceInfoKlass *base_info_klass;
    GIInfoType base_info_type;

    if (G_UNLIKELY (!type_info_klass->get_interface (type_info,
                    self,
                    &base_info,
                    &base_info_klass,
                    dart_error_out,
                    error))) {
      return FALSE;
    }
    if (G_UNLIKELY (!base_info_klass->get_type (base_info,
                    self,
                    &base_info_type,
                    dart_error_out,
                    error))) {
      base_info_klass->free (base_info);
      return FALSE;
    }
    switch (base_info_type) {
    case GI_INFO_TYPE_CALLBACK:
    case GI_INFO_TYPE_BOXED:
    case GI_INFO_TYPE_OBJECT:
    case GI_INFO_TYPE_INTERFACE:
    case GI_INFO_TYPE_STRUCT:
    case GI_INFO_TYPE_UNION:
      inout_original_arg_cvalues[c_arg_pos].v_pointer = * ( (gpointer *) in_arg_cvalues[c_arg_pos].v_pointer);
      break;
    case GI_INFO_TYPE_ENUM:
    case GI_INFO_TYPE_FLAGS: {
      GITypeTag storage_type;
      if (G_UNLIKELY (!base_info_klass->cast_to_enum_info (base_info)->get_storage_type (base_info,
                      self,
                      &storage_type,
                      dart_error_out,
                      error))) {
        base_info_klass->free (base_info);
        return FALSE;
      }

      switch (storage_type) {
      case GI_TYPE_TAG_BOOLEAN:
        inout_original_arg_cvalues[c_arg_pos].v_boolean = * ( (gboolean *) in_arg_cvalues[c_arg_pos].v_pointer);
        break;
      case GI_TYPE_TAG_INT8:
      case GI_TYPE_TAG_UINT8:
        inout_original_arg_cvalues[c_arg_pos].v_uint8 = * ( (guint8 *) in_arg_cvalues[c_arg_pos].v_pointer);
        break;
      case GI_TYPE_TAG_INT16:
      case GI_TYPE_TAG_UINT16:
        inout_original_arg_cvalues[c_arg_pos].v_uint16 = * ( (guint16 *) in_arg_cvalues[c_arg_pos].v_pointer);
        break;
      case GI_TYPE_TAG_INT32:
      case GI_TYPE_TAG_UINT32:
        inout_original_arg_cvalues[c_arg_pos].v_uint32 = * ( (guint32 *) in_arg_cvalues[c_arg_pos].v_pointer);
        break;
      case GI_TYPE_TAG_INT64:
      case GI_TYPE_TAG_UINT64:
      case GI_TYPE_TAG_GTYPE:
        inout_original_arg_cvalues[c_arg_pos].v_uint64 = * ( (guint64 *) in_arg_cvalues[c_arg_pos].v_pointer);
        break;
      default:
        break;
      }
    }
    break;
    default:
      break;
    }
    base_info_klass->free (base_info);
  }
  break;
  default:
    break;
  }
  return TRUE;
}


static gboolean _gdart_callback_prep_arguments_for_callback (
  GdartBridgeContext *self,
  void **args,
  gpointer callable_info,
  const CallableInfoKlass *callable_info_klass,
  GIArgument *in_arg_cvalues,
  GIArgument *inout_original_arg_cvalues,
  gint c_argc,
  gint gi_argc,
  gboolean is_method,
  gboolean has_user_data,
  gboolean can_throw_gerror,
  gint *suppressed_args,
  gint suppressed_args_length,
  gint *dart_argc_out,
  Dart_Handle *dart_error_out,
  GError **error)
{
  gint gi_arg_pos = 0, c_arg_pos = 0, dart_argc = 0;

  if (is_method) {
    GIArgument *this_argument = (GIArgument *) args[c_arg_pos];
    in_arg_cvalues[c_arg_pos] = *this_argument;
    c_arg_pos++;
  }
  for (; gi_arg_pos < gi_argc; gi_arg_pos++) {
    gpointer arg_info;
    const ArgInfoKlass *arg_info_klass;

    gpointer type_info;
    const TypeInfoKlass *type_info_klass;

    GIDirection direction;

    GIArgument *this_argument = (GIArgument *) args[c_arg_pos];
    in_arg_cvalues[c_arg_pos] = *this_argument;
    if (has_user_data && gi_arg_pos == (gi_argc - 1)) {
      c_arg_pos++;
      continue;
    }
    if (!callable_info_klass->get_arg (callable_info,
                                       self,
                                       gi_arg_pos,
                                       &arg_info,
                                       &arg_info_klass,
                                       dart_error_out,
                                       error)) {
      return FALSE;
    }
    if (!arg_info_klass->get_direction (arg_info,
                                        self,
                                        &direction,
                                        dart_error_out,
                                        error)) {
      arg_info_klass->free (arg_info);
      return FALSE;
    }
    if (!arg_info_klass->get_type (arg_info,
                                   self,
                                   &type_info,
                                   &type_info_klass,
                                   dart_error_out,
                                   error)) {
      arg_info_klass->free (arg_info);
      return FALSE;
    }
    arg_info_klass->free (arg_info);

    if (direction == GI_DIRECTION_IN || direction == GI_DIRECTION_INOUT) {
      GITypeTag type_tag;

      dart_argc++;
      if (!type_info_klass->get_tag (type_info,
                                     self,
                                     &type_tag,
                                     dart_error_out,
                                     error)) {
        type_info_klass->free (type_info);
        return FALSE;
      }
      switch (type_tag) {
      case GI_TYPE_TAG_ARRAY: {
        gint arg_to_suppress, arg_i = 0;

        if (!type_info_klass->get_array_length (type_info,
                                                self,
                                                &arg_to_suppress,
                                                dart_error_out,
                                                error)) {
          type_info_klass->free (type_info);
          return FALSE;
        }
        if (arg_to_suppress != -1) {
          for (; arg_i < suppressed_args_length; arg_i++) {
            if (suppressed_args[arg_i] == -1) {
              dart_argc--;
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
    c_arg_pos++;
  }
  if (can_throw_gerror) {
    GIArgument *this_argument = (GIArgument *) args[c_arg_pos];
    in_arg_cvalues[c_arg_pos] = *this_argument;
    c_arg_pos++;
  }
  (*dart_argc_out) = dart_argc;
  return TRUE;
}

static gboolean _gdart_callback_load_arguments_for_callback (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  gpointer callable_info,
  const CallableInfoKlass *callable_info_klass,
  GIArgument *in_arg_cvalues,
  GIArgument *inout_original_arg_cvalues,
  gint c_argc,
  gint gi_argc,
  gboolean is_method,
  gboolean can_throw_gerror,
  gboolean user_data_present,
  gint *suppressed_args,
  gint suppressed_args_length,
  gint dart_argc,
  Dart_Handle *dart_arguments,
  Dart_Handle *dart_error_out,
  GError **error)
{
  gint gi_arg_pos = 0, c_arg_pos = 0, dart_arg_pos = 0;

  if (is_method) {
    c_arg_pos++;
  }
  for (; gi_arg_pos < gi_argc; gi_arg_pos++) {
    gint arg_i = 0;

    gpointer arg_info;
    const ArgInfoKlass *arg_info_klass;

    gpointer type_info;
    const TypeInfoKlass *type_info_klass;

    GIDirection direction;
    gchar *arg_name;
    gchar *arg_name_short;

    if (G_UNLIKELY (!callable_info_klass->get_arg (callable_info,
                    self,
                    gi_arg_pos,
                    &arg_info,
                    &arg_info_klass,
                    dart_error_out,
                    error))) {
      return FALSE;
    }
    if (G_UNLIKELY (!arg_info_klass->get_name (arg_info,
                    self,
                    &arg_name_short,
                    dart_error_out,
                    error))) {
      arg_info_klass->free (arg_info);
      return FALSE;
    }
    if (G_UNLIKELY (!arg_info_klass->get_direction (arg_info,
                    self,
                    &direction,
                    dart_error_out,
                    error))) {
      g_free (arg_name_short);
      arg_info_klass->free (arg_info);
      return FALSE;
    }


    arg_name = g_strdup_printf ("%s.%s",
                                name_prefix,
                                arg_name_short);
    g_free (arg_name_short);
    if (G_UNLIKELY (!arg_info_klass->get_type (arg_info,
                    self,
                    &type_info,
                    &type_info_klass,
                    dart_error_out,
                    error))) {
      g_free (arg_name);
      arg_info_klass->free (arg_info);
      return FALSE;
    }
    if (direction == GI_DIRECTION_INOUT) {
      if (!_gdart_callback_copy_ref_argument (self,
                                              type_info,
                                              type_info_klass,
                                              in_arg_cvalues,
                                              inout_original_arg_cvalues,
                                              c_arg_pos,
                                              dart_error_out,
                                              error)) {
        g_free (arg_name);
        arg_info_klass->free (arg_info);
        type_info_klass->free (type_info);
        return FALSE;
      }
    }
    for (; arg_i < suppressed_args_length; arg_i++) {
      if (suppressed_args[arg_i] == gi_arg_pos) {
        g_free (arg_name);
        arg_info_klass->free (arg_info);
        type_info_klass->free (type_info);
        return TRUE;
      }
      if (suppressed_args[arg_i] == -1) { break; }
    }
    switch (direction) {
    case GI_DIRECTION_IN:
      if (!_gdart_function_result_load_return (self,
          arg_name,
          callable_info,
          callable_info_klass,
          arg_info,
          arg_info_klass,
          is_method,
          can_throw_gerror,
          FALSE,
          in_arg_cvalues,
          NULL,
          NULL,
          &in_arg_cvalues[c_arg_pos],
          NULL,
          type_info,
          type_info_klass,
          &dart_arg_pos,
          dart_arguments,
          dart_argc,
          dart_error_out,
          error)) {
        g_free (arg_name);
        arg_info_klass->free (arg_info);
        type_info_klass->free (type_info);
        return FALSE;
      }
      break;
    case GI_DIRECTION_INOUT:
      if (!_gdart_function_result_load_return (self,
          arg_name,
          callable_info,
          callable_info_klass,
          arg_info,
          arg_info_klass,
          is_method,
          can_throw_gerror,
          FALSE,
          inout_original_arg_cvalues,
          NULL,
          NULL,
          &inout_original_arg_cvalues[c_arg_pos],
          NULL,
          type_info,
          type_info_klass,
          &dart_arg_pos,
          dart_arguments,
          dart_argc,
          dart_error_out,
          error)) {
        arg_info_klass->free (arg_info);
        type_info_klass->free (type_info);
        g_free (arg_name);
        return FALSE;
      }
      break;
    default:
      break;
    }
    arg_info_klass->free (arg_info);
    type_info_klass->free (type_info);
    g_free (arg_name);
    c_arg_pos++;
  }
  if (user_data_present) {
    c_arg_pos++;
  }
  return TRUE;
}


static gboolean _gdart_function_invoke_fill_callback_returns (
  GdartBridgeContext *self,
  const gchar *name_prefix,
  gpointer function_info,
  const CallableInfoKlass *function_info_klass,
  Dart_Handle dart_args,
  gboolean is_method,
  gboolean can_throw_gerror,
  GArgument *main_out_argument,
  GArgument *in_arg_cvalues,
  GArgument *out_arg_cvalues,
  gint c_argc,
  gint gi_argc,
  gint *suppressed_args,
  gint suppressed_args_length,
  Dart_Handle *dart_error_out,
  GError **error)
{
  gint c_arg_pos = 0, gi_arg_pos = 0, dart_arg_pos = 0, c_arg_pos0 = 0;

  gpointer return_type_info;
  const TypeInfoKlass *return_type_info_klass;

  GITypeTag type_tag;

  if (!function_info_klass->get_return_type (function_info,
      self,
      &return_type_info,
      &return_type_info_klass,
      dart_error_out,
      error)) {
    goto error_out;
  }
  if (is_method) {
    c_arg_pos++;
  }

  if (!return_type_info_klass->get_tag (return_type_info,
                                        self,
                                        &type_tag,
                                        dart_error_out,
                                        error)) {
    return_type_info_klass->free (return_type_info);
    goto error_out;
  }
  if (type_tag != GI_TYPE_TAG_VOID && (!can_throw_gerror || type_tag != GI_TYPE_TAG_BOOLEAN)) {
    gchar *return_name;
    GITransfer caller_owns;


    return_name = g_strdup_printf ("%s[return]", name_prefix);
    if (G_UNLIKELY (!function_info_klass->get_caller_owns (function_info,
                    self,
                    &caller_owns,
                    dart_error_out,
                    error))) {
      return_type_info_klass->free (return_type_info);
      g_free (return_name);
      goto error_out;
    }
    if (!_gdart_function_fill_argument_in (self,
                                           return_name,
                                           dart_args,
                                           function_info,
                                           function_info_klass,
                                           caller_owns != GI_TRANSFER_NOTHING,
                                           is_method,
                                           &c_arg_pos0,
                                           &dart_arg_pos,
                                           -1,
                                           NULL,
                                           &null_arg_info,
                                           return_type_info,
                                           return_type_info_klass,
                                           suppressed_args,
                                           gi_argc,
                                           main_out_argument,
                                           out_arg_cvalues,
                                           NULL,
                                           NULL,
                                           0,
                                           dart_error_out,
                                           error)) {
      return_type_info_klass->free (return_type_info);
      g_free (return_name);
      goto error_out;
    }
    return_type_info_klass->free (return_type_info);
    g_free (return_name);
  } else if (can_throw_gerror && type_tag == GI_TYPE_TAG_BOOLEAN) {
    main_out_argument->v_boolean = TRUE;
  }

  for (gi_arg_pos = 0; gi_arg_pos < gi_argc; gi_arg_pos++) {
    GIDirection direction;

    gpointer arg_info;
    const ArgInfoKlass *arg_info_klass;

    gchar *arg_name;
    gchar *arg_name_only;

    if (!function_info_klass->get_arg (function_info,
                                       self,
                                       gi_arg_pos,
                                       &arg_info,
                                       &arg_info_klass,
                                       dart_error_out,
                                       error)) {
      goto error_out;
    }
    if (!arg_info_klass->get_name (arg_info,
                                   self,
                                   &arg_name_only,
                                   dart_error_out,
                                   error)) {
      arg_info_klass->free (arg_info);
      goto error_out;
    }
    if (!arg_info_klass->get_direction (arg_info,
                                        self,
                                        &direction,
                                        dart_error_out,
                                        error)) {
      g_free (arg_name_only);
      arg_info_klass->free (arg_info);
      goto error_out;
    }

    arg_name = g_strdup_printf ("%s.%s",
                                name_prefix,
                                arg_name_only);
    g_free (arg_name_only);
    switch (direction) {
    case GI_DIRECTION_IN:
      c_arg_pos++;
      break;
    case GI_DIRECTION_INOUT:
    case GI_DIRECTION_OUT: {
      gint c_arg_pos_previous;

      gpointer arg_type;
      const TypeInfoKlass *arg_type_klass;
      GITypeTag type_tag;
      GITransfer transfer;

      c_arg_pos_previous = c_arg_pos;
      if (in_arg_cvalues[c_arg_pos].v_pointer == NULL) {
        c_arg_pos++;
        break;
      }
      if (!arg_info_klass->get_type (arg_info,
                                     self,
                                     &arg_type,
                                     &arg_type_klass,
                                     dart_error_out,
                                     error)) {
        g_free (arg_name);
        arg_info_klass->free (arg_info);
        goto error_out;
      }
      if (!arg_type_klass->get_tag (arg_type,
                                    self,
                                    &type_tag,
                                    dart_error_out,
                                    error)) {
        g_free (arg_name);
        arg_info_klass->free (arg_info);
        arg_type_klass->free (arg_type);
        goto error_out;
      }
      if (G_UNLIKELY (!arg_info_klass->get_ownership_transfer (arg_info,
                      self,
                      &transfer,
                      dart_error_out,
                      error))) {
        g_free (arg_name);
        arg_info_klass->free (arg_info);
        arg_type_klass->free (arg_type);
        goto error_out;
      }

      switch (type_tag) {
      case GI_TYPE_TAG_UTF8:
      case GI_TYPE_TAG_FILENAME:
      case GI_TYPE_TAG_ARRAY: {
        if (transfer == GI_TRANSFER_NOTHING) {
          g_warning ("%s: The type of transfer for an out argument was "
                     "`transfer none`, but Dart uses native types for "
                     "arguments of this type.",
                     arg_name);
          g_free (arg_name);
          arg_info_klass->free (arg_info);
          arg_type_klass->free (arg_type);
          goto error_out;
        }
      }
      default:
        break;
      }
      if (!_gdart_function_fill_argument_in (self,
                                             arg_name,
                                             dart_args,
                                             function_info,
                                             function_info_klass,
                                             transfer != GI_TRANSFER_NOTHING,
                                             is_method,
                                             &c_arg_pos,
                                             &dart_arg_pos,
                                             gi_arg_pos,
                                             arg_info,
                                             arg_info_klass,
                                             arg_type,
                                             arg_type_klass,
                                             suppressed_args,
                                             gi_argc,
                                             &out_arg_cvalues[c_arg_pos],
                                             out_arg_cvalues,
                                             NULL,
                                             NULL,
                                             0,
                                             dart_error_out,
                                             error)) {
        g_free (arg_name);
        arg_info_klass->free (arg_info);
        arg_type_klass->free (arg_type);
        goto error_out;
      }
      if (!_gdart_callback_copyback_out_argument (self,
          arg_type,
          arg_type_klass,
          in_arg_cvalues,
          out_arg_cvalues,
          c_arg_pos_previous,
          dart_error_out,
          error))  {
        g_free (arg_name);
        arg_info_klass->free (arg_info);
        arg_type_klass->free (arg_type);
        goto error_out;
      }
      arg_type_klass->free (arg_type);

      break;
    }
    arg_info_klass->free (arg_info);
    default:
      g_free (arg_name);
      g_assert_not_reached();
    }
    g_free (arg_name);
  }
  if (can_throw_gerror) {
    c_arg_pos++;
  }

  if (c_arg_pos != c_argc) {
    g_assert_not_reached();
  }
  return TRUE;
error_out: {
    return FALSE;
  }
}

static gboolean set_return_ffi_arg_from_giargument (
  GdartBridgeContext *self,
  gpointer    ret_type,
  const TypeInfoKlass *ret_type_klass,
  void        *result,
  GIArgument  *return_value,
  Dart_Handle *dart_error_out,
  GError **error)
{
  GITypeTag type_tag;
  if (G_UNLIKELY (!ret_type_klass->get_tag (ret_type,
                  self,
                  &type_tag,
                  dart_error_out,
                  error))) {
    return FALSE;
  }
  switch (type_tag) {
  case GI_TYPE_TAG_INT8:
    * (ffi_sarg *) result = return_value->v_int8;
    break;
  case GI_TYPE_TAG_UINT8:
    * (ffi_arg *) result = return_value->v_uint8;
    break;
  case GI_TYPE_TAG_INT16:
    * (ffi_sarg *) result = return_value->v_int16;
    break;
  case GI_TYPE_TAG_UINT16:
    * (ffi_arg *) result = return_value->v_uint16;
    break;
  case GI_TYPE_TAG_INT32:
    * (ffi_sarg *) result = return_value->v_int32;
    break;
  case GI_TYPE_TAG_UINT32:
  case GI_TYPE_TAG_BOOLEAN:
  case GI_TYPE_TAG_UNICHAR:
    * (ffi_arg *) result = return_value->v_uint32;

    break;
  case GI_TYPE_TAG_INT64:
    * (ffi_sarg *) result = return_value->v_int64;
    break;
  case GI_TYPE_TAG_UINT64:
    * (ffi_arg *) result = return_value->v_uint64;
    break;
  case GI_TYPE_TAG_INTERFACE: {
    gpointer interface_info;
    const InterfaceInfoKlass *interface_info_klass;

    GIInfoType interface_type;

    if (G_UNLIKELY (!ret_type_klass->get_interface (ret_type,
                    self,
                    &interface_info,
                    &interface_info_klass,
                    dart_error_out,
                    error))) {
      return FALSE;
    }
    if (G_UNLIKELY (!interface_info_klass->get_type (interface_info,
                    self,
                    &interface_type,
                    dart_error_out,
                    error))) {
      interface_info_klass->free (interface_info);
      return FALSE;
    }
    switch (interface_type) {
    case GI_INFO_TYPE_ENUM:
    case GI_INFO_TYPE_FLAGS:
      * (ffi_sarg *) result = return_value->v_long;
      break;
    default:
      * (ffi_arg *) result = (ffi_arg) return_value->v_pointer;
      break;
    }

    interface_info_klass->free (interface_info);
  }
  default:
    * (ffi_arg *) result = (ffi_arg) return_value->v_uint64;
    break;
  }
  return TRUE;
}

static void _gdart_callback_closure_free_trampoline (GdartCallbackTrampoline *trampoline)
{
  Dart_Handle dart_error;
  GError *inner_error = NULL;

  if (!trampoline->signal_info_klass.free_closure (trampoline->signal_info,
      trampoline->self,
      trampoline->closure,
      &dart_error,
      &inner_error)) {
    g_assert_not_reached();
  }
  trampoline->signal_info_klass.free (trampoline->signal_info);
  Dart_DeletePersistentHandle (trampoline->closure_dart);
  g_object_unref (G_OBJECT (trampoline->self));
  g_free (trampoline->closure_name);
  g_slice_free (GdartCallbackTrampoline, trampoline);
}

static void _gdart_callback_closure (ffi_cif *cif,
                                     void *result,
                                     void **args,
                                     void *data)
{
  GdartCallbackTrampoline *trampoline;
  Dart_Handle closure, *dart_arguments, dart_result;
  gint c_argc, gi_argc, suppressed_args_length, dart_argc, dart_out_argc,
       c_arg_pos = 0;
  GIArgument *in_arg_cvalues, *inout_original_arg_cvalues, *out_arg_cvalues,
             main_return;

  gpointer return_type_info;
  const TypeInfoKlass *return_type_info_klass;

  gint *suppressed_args;
  gboolean is_method, can_throw_gerror;
  GdartBridgeContext *self;
  gchar *closure_name;

  Dart_Handle set_on_error = NULL;
  GError *error = NULL;

  trampoline = (GdartCallbackTrampoline *) data;
  c_argc = trampoline->cif.nargs;
  closure_name = g_strdup_printf ("(closure invoked from %s)", trampoline->closure_name);
  self = gdart_bridge_context_new_from_isolate (Dart_CurrentIsolate());

  if (!trampoline->signal_info_klass.get_n_args (trampoline->signal_info,
      self,
      &gi_argc,
      &set_on_error,
      &error)) {
    g_free (closure_name);
    goto error_out;
  }
  if (!trampoline->signal_info_klass.is_method (trampoline->signal_info,
      self,
      &is_method,
      &set_on_error,
      &error)) {
    g_free (closure_name);
    goto error_out;
  }
  if (!trampoline->signal_info_klass.can_throw_gerror (trampoline->signal_info,
      self,
      &can_throw_gerror,
      &set_on_error,
      &error)) {
    g_free (closure_name);
    goto error_out;
  }

  if (!trampoline->signal_info_klass.get_return_type (trampoline->signal_info,
      self,
      &return_type_info,
      &return_type_info_klass,
      &set_on_error,
      &error)) {
    g_free (closure_name);
    goto error_out;
  }
  suppressed_args_length = gi_argc;
  in_arg_cvalues = g_newa (GIArgument, c_argc);
  inout_original_arg_cvalues = g_newa (GIArgument, c_argc);
  out_arg_cvalues = g_newa (GIArgument, c_argc);
  suppressed_args = g_newa (gint, suppressed_args_length);
  for (; c_arg_pos < suppressed_args_length; c_arg_pos++) {
    suppressed_args[c_arg_pos] = -1;
  }
  if (!_gdart_callback_prep_arguments_for_callback (
        self,
        args,
        trampoline->signal_info,
        &trampoline->signal_info_klass,
        in_arg_cvalues,
        inout_original_arg_cvalues,
        c_argc,
        gi_argc,
        is_method,
        trampoline->user_data_present,
        can_throw_gerror,
        suppressed_args,
        suppressed_args_length,
        &dart_argc,
        &set_on_error,
        &error))  {
    g_free (closure_name);
    return_type_info_klass->free (return_type_info);
    goto error_out;
  }
  if (trampoline->user_data_present) {
    //dart_argc--;
  }
  dart_arguments = g_newa (Dart_Handle, dart_argc);
  if (!_gdart_callback_load_arguments_for_callback (self,
      closure_name,
      trampoline->signal_info,
      &trampoline->signal_info_klass,
      in_arg_cvalues,
      inout_original_arg_cvalues,
      c_argc,
      gi_argc,
      is_method,
      can_throw_gerror,
      trampoline->user_data_present,
      suppressed_args,
      suppressed_args_length,
      dart_argc,
      dart_arguments,
      &set_on_error,
      &error)) {
    g_free (closure_name);
    return_type_info_klass->free (return_type_info);
    goto error_out;
  }
  Dart_EnterScope();
  closure = Dart_HandleFromPersistent (trampoline->closure_dart);
  dart_result = Dart_InvokeClosure (closure, dart_argc, dart_arguments);
  if (G_UNLIKELY (Dart_IsError (dart_result))) {
    //TODO: Handle GErrors when callbacks can throw them.
    Dart_Handle stacktrace, dart_stacktrace_string, temp_result;
    gchar *output_string, *output_string_copy;
    gintptr output_string_length;

    stacktrace = Dart_ErrorGetStacktrace (dart_result);
    if (G_UNLIKELY (Dart_IsError (stacktrace))) {
      dart_stacktrace_string = result;
    } else {
      dart_stacktrace_string = Dart_ToString (stacktrace);
    }
    if (G_UNLIKELY (Dart_IsError (dart_stacktrace_string))) {
      temp_result = dart_stacktrace_string;
    } else {
      temp_result = Dart_StringToUTF8 (dart_stacktrace_string,
                                       (guint8 **) &output_string,
                                       &output_string_length);
    }
    if (G_UNLIKELY (Dart_IsError (temp_result))) {
      output_string_length = 0;
      output_string_copy = g_newa (gchar, 1);
      output_string_copy[0] = '\0';
    } else {
      output_string_copy = g_newa (gchar, output_string_length + 1);
      memmove (output_string_copy, output_string, output_string_length);
      output_string_copy[output_string_length] = '\0';
    }
    g_critical ("%s: Dart threw a fatal error from within a callback:\n%s\n%s",
                closure_name,
                Dart_GetError (dart_result),
                output_string_copy);
    g_assert_not_reached();
  }
  if (!_gdart_prep_results (self,
                            closure_name,
                            trampoline->signal_info,
                            &trampoline->signal_info_klass,
                            return_type_info,
                            return_type_info_klass,
                            suppressed_args,
                            suppressed_args_length,
                            &dart_out_argc,
                            gi_argc,
                            can_throw_gerror,
                            &set_on_error,
                            &error)) {
    g_free (closure_name);
    return_type_info_klass->free (return_type_info);
    goto error_out;
  }
  if (dart_out_argc == 1) {
    Dart_Handle result_element, temp_result;
    result_element = dart_result;
    dart_result = Dart_NewList (1);
    temp_result = Dart_ListSetAt (dart_result, 0, result_element);
    if (G_UNLIKELY (Dart_IsError (temp_result))) {
      Dart_Handle stacktrace, dart_stacktrace_string, temp_result;
      gchar *output_string, *output_string_copy;
      gintptr output_string_length;

      stacktrace = Dart_ErrorGetStacktrace (dart_result);
      if (G_UNLIKELY (Dart_IsError (stacktrace))) {
        dart_stacktrace_string = result;
      } else {
        dart_stacktrace_string = Dart_ToString (stacktrace);
      }
      if (G_UNLIKELY (Dart_IsError (dart_stacktrace_string))) {
        temp_result = dart_stacktrace_string;
      } else {
        temp_result = Dart_StringToUTF8 (dart_stacktrace_string,
                                         (guint8 **) &output_string,
                                         &output_string_length);
      }
      if (G_UNLIKELY (Dart_IsError (temp_result))) {
        output_string_length = 0;
        output_string_copy = g_newa (gchar, 1);
        output_string_copy[0] = '\0';
      } else {
        output_string_copy = g_newa (gchar, output_string_length + 1);
        memmove (output_string_copy, output_string, output_string_length);
        output_string_copy[output_string_length] = '\0';
      }
      g_critical ("%s: Dart threw an error from within a callback:\n%s\n%s",
                  closure_name,
                  Dart_GetError (dart_result),
                  output_string_copy);
    }
  } else if (dart_out_argc == 0) {
    dart_result = Dart_NewList (0);
  }
  if (!_gdart_function_invoke_fill_callback_returns (self,
      closure_name,
      trampoline->signal_info,
      &trampoline->signal_info_klass,
      dart_result,
      is_method,
      can_throw_gerror,
      &main_return,
      in_arg_cvalues,
      out_arg_cvalues,
      c_argc,
      gi_argc,
      suppressed_args,
      suppressed_args_length,
      &set_on_error,
      &error)) {
    g_free (closure_name);
    return_type_info_klass->free (return_type_info);
    goto error_out;
  }
  if (trampoline->is_one_shot) {
    _gdart_callback_closure_free_trampoline (trampoline);
  }
  Dart_ExitScope();
  if (!set_return_ffi_arg_from_giargument (self,
      return_type_info,
      return_type_info_klass,
      result,
      &main_return,
      &set_on_error,
      &error)) {
    g_free (closure_name);
    return_type_info_klass->free (return_type_info);
    goto error_out;
  }
  return_type_info_klass->free (return_type_info);
  g_free (closure_name);
  return;
error_out: {
    g_critical ("Dart threw a fatal error from within a callback in a "
                "place where it can't be ignored: %s",
                error->message);
    g_assert_not_reached();
  }
}

void gdart_callback_closure_notify (gpointer data)
{
  _gdart_callback_closure_free_trampoline ( (GdartCallbackTrampoline *) data);
}

void gdart_callback_closure_free (gpointer data, GClosure *closure)
{
  _gdart_callback_closure_free_trampoline ( (GdartCallbackTrampoline *) data);
}

GISignalInfo *_g_object_info_find_signal (GIObjectInfo *info,
    const gchar  *name)
{
  gint n_signals;
  gint i;

  n_signals = g_object_info_get_n_signals (info);
  for (i = 0; i < n_signals; i++) {
    GISignalInfo *siginfo = g_object_info_get_signal (info, i);

    if (g_strcmp0 (g_base_info_get_name (siginfo), name) != 0) {
      g_base_info_unref ( (GIBaseInfo *) siginfo);
      continue;
    }

    return siginfo;
  }
  return NULL;
}

gboolean gdart_signal_connect_data (
  GdartBridgeContext *self,
  const gchar *detailed_signal,
  GObject *object,
  GIObjectInfo *object_info, //heap allocated
  Dart_Handle callback,
  bool is_after,
  Dart_Handle *result_out,
  Dart_Handle *dart_error_out,
  GError **error)
{
  GdartCallbackTrampoline *trampoline;
  gchar **substrings;
  GICallableInfo *signal_info;
  guint64 result;
  Dart_Handle result_dart;

  substrings = g_strsplit (detailed_signal, "::", -1);
  {
    GIObjectInfo *current_object_info, *previous_object_info;
    //TODO: Switch to interface
    current_object_info = g_base_info_ref ( (GIBaseInfo *) object_info);
    while (current_object_info != NULL) {
      //TODO: Switch to interface
      /* printf("Searching for signal %s in %s.%s\n",
         detailed_signal,
         g_base_info_get_namespace((GIBaseInfo *) current_object_info),
         g_base_info_get_name((GIBaseInfo *) current_object_info));
      */
      signal_info = _g_object_info_find_signal (current_object_info, substrings[0]);
      if (signal_info != NULL) { break; }
      previous_object_info = current_object_info;
      current_object_info = g_object_info_get_parent (current_object_info);
      g_base_info_unref ( (GIBaseInfo *) previous_object_info);
    }
    if (current_object_info != NULL) { g_base_info_unref ( (GIBaseInfo *) current_object_info); }
  }
  g_strfreev (substrings);
  if (signal_info == NULL) {
    *dart_error_out = gdart_bridge_context_create_error_handle (self,
                      "%s: could not find the specified signal", G_STRFUNC);
    g_set_error (error, GDART_ERROR, 1,
                 "%s: could not find the specified signal", G_STRFUNC);
    return FALSE;
  }
  trampoline = g_slice_new (GdartCallbackTrampoline);
  //TODO: Switch to interface
  trampoline->closure = g_callable_info_prepare_closure (signal_info,
                        &trampoline->cif,
                        _gdart_callback_closure,
                        trampoline);
  trampoline->closure_dart = Dart_NewPersistentHandle (callback);
  trampoline->signal_info = signal_info;
  trampoline->signal_info_klass = gi_callable_info_callable_info;
  trampoline->self = (GdartBridgeContext *) g_object_ref (G_OBJECT (self));
  trampoline->user_data_present = FALSE;
  trampoline->is_one_shot = FALSE;
  trampoline->closure_name = g_strdup_printf ("GLib.GObject.signals['%s']",
                             detailed_signal);
  result = g_signal_connect_data (object,
                                  detailed_signal,
                                  G_CALLBACK (trampoline->closure),
                                  trampoline,
                                  gdart_callback_closure_free,
                                  is_after ? G_CONNECT_AFTER : 0);
  result_dart = Dart_NewIntegerFromUint64 (result);
  if (G_UNLIKELY (Dart_IsError (result_dart))) {
    g_warning ("%s: Dart threw an error.", trampoline->closure_name);
    *dart_error_out = result_dart;
    g_set_error (error, GDART_ERROR, 1, "Error from Dart operation.");
    return FALSE;
  }
  *result_out = result_dart;
  return TRUE;
}

