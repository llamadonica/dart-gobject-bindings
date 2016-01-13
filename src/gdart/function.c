// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
//

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

gsize _gdart_function_get_array_size_multiplier(GITypeInfo *param_type);
gboolean _gdart_function_array_element(GdartBridgeContext *self,
                                       const gchar *name_prefix,
                                       Dart_Handle element,
                                       GITypeInfo *arg_type,
                                       gpointer *buffer,
                                       Dart_Handle *dart_error_out,
                                       GError **error);
gboolean _gdart_function_remove_array_element(GdartBridgeContext *self,
        GITypeInfo *arg_type,
        gpointer *buffer);
static void gdart_callback_closure_notify(gpointer data);
static void _gdart_callback_closure(ffi_cif *cif,
                                    void *result,
                                    void **args,
                                    void *data);
void _gdart_callback_closure_free_trampoline(GdartCallbackTrampoline* trampoline);


struct _GdartCallbackTrampoline {
    Dart_PersistentHandle closure_dart;
    GICallableInfo *signal_info;
    ffi_cif cif;
    ffi_closure *closure;
    gboolean user_data_present;
    gboolean is_one_shot;
    gchar *closure_name;
};

void _gdart_function_argument_fill_boolean_raw_in_buffer(
    bool result,
    gpointer *buffer)
{
    _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE(gboolean, buffer, result);
}

gboolean _gdart_function_argument_fill_boolean_in_buffer(
    Dart_Handle element,
    gpointer *buffer,
    Dart_Handle *dart_error_out,
    GError **error)
{
    bool result;
    Dart_Handle temp_result;
    temp_result = Dart_BooleanValue(element, &result);
    if (Dart_IsError(temp_result)) {
        *dart_error_out = temp_result;
        g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
        goto error;
    }
    _gdart_function_argument_fill_boolean_raw_in_buffer(result,
            buffer);
    return TRUE;
error:
    return FALSE;
}

gboolean _gdart_function_argument_fill_boolean(
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
    temp_result = Dart_BooleanValue(element, &result);
    if (Dart_IsError(temp_result)) {
        *dart_error_out = temp_result;
        g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
        goto error;
    }
    main_argument->v_boolean = (gboolean) result;
    if (ffi_arg_pointers != NULL) {
        g_assert(main_argument == &in_arg_cvalues[*c_arg_pos]);
        ffi_arg_pointers[*c_arg_pos] = main_argument;
        (*c_arg_pos)++;
    }
    return TRUE;
error:
    return FALSE;
}

gboolean _gdart_function_argument_fill_in_boolean(
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
    element = Dart_ListGetAt(dart_args, (*dart_arg_pos)++);
    if (Dart_IsError(element)) {
        *dart_error_out = element;
        g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
        goto error;
    }
    return _gdart_function_argument_fill_boolean(
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


gboolean _gdart_function_argument_fill_int_raw_in_buffer(
    GdartBridgeContext *self,
    const gchar* name_prefix,
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
            g_warning("%s: Integer was out of bounds. Result will be clamped.",
                      name_prefix);
            raw_result = CLAMP(raw_result, G_MININT8, G_MAXINT8);
        }
        _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE(gint8, buffer, (gint8) raw_result);
        break;
    case GI_TYPE_TAG_UINT8:
        if (raw_result > G_MAXUINT8 || raw_result < 0) {
            g_warning("%s: Integer was out of bounds. Result will be clamped.",
                      name_prefix);
            raw_result = CLAMP(raw_result, 0, G_MAXUINT8);
        }
        _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE(guint8, buffer, (guint8) raw_result);
        break;
    case GI_TYPE_TAG_INT16:
        if (raw_result > G_MAXINT16 || raw_result < G_MININT16) {
            g_warning("%s: Integer was out of bounds. Result will be clamped.",
                      name_prefix);
            raw_result = CLAMP(raw_result, G_MININT16, G_MAXINT16);
        }
        _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE(gint16, buffer, (gint16) raw_result);
        break;
    case GI_TYPE_TAG_UINT16:
        if (raw_result > G_MAXUINT16 || raw_result < 0) {
            g_warning("%s: Integer was out of bounds. Result will be clamped.",
                      name_prefix);
            raw_result = CLAMP(raw_result, 0, G_MAXUINT16);
        }
        _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE(guint16, buffer, (guint16) raw_result);
        break;
    case GI_TYPE_TAG_INT32:
        if (raw_result > G_MAXINT32 || raw_result < G_MININT32) {
            g_warning("%s: Integer was out of bounds. Result will be clamped.",
                      name_prefix);
            raw_result = CLAMP(raw_result, G_MININT32, G_MAXINT32);
        }
        _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE(gint32, buffer, (gint32) raw_result);
        break;
    case GI_TYPE_TAG_UINT32:
        if (raw_result > G_MAXUINT32 || raw_result < 0) {
            g_warning("%s: Integer was out of bounds. Result will be clamped.",
                      name_prefix);
            raw_result = CLAMP(raw_result, 0, G_MAXUINT32);
        }
        _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE(guint32, buffer, (guint32) raw_result);
        break;
    case GI_TYPE_TAG_INT64:
        _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE(gint64, buffer, raw_result);
        break;
    case GI_TYPE_TAG_UINT64:
        _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE(guint8, buffer, raw_result_64);
        break;
    case GI_TYPE_TAG_GTYPE:
        _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE(GType, buffer, raw_result_64);
        break;
    default:
        *dart_error_out = gdart_bridge_context_create_error_handle(
                              self,
                              "%s: expected an integer-like type", G_STRFUNC);
        g_set_error(error, GDART_ERROR, 1,
                              "%s: expected an integer-like type", G_STRFUNC);
        goto error;
    }
    return TRUE;
error:
    return FALSE;
}

gboolean _gdart_function_argument_fill_int_raw(
    GdartBridgeContext *self,
    const gchar* name_prefix,
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
            g_warning("%s: Integer was out of bounds. Result will be clamped.",
                      name_prefix);
            raw_result = CLAMP(raw_result, G_MININT8, G_MAXINT8);
        }
        main_argument->v_int8 = (gint8) raw_result;
        break;
    case GI_TYPE_TAG_UINT8:
        if (raw_result > G_MAXUINT8 || raw_result < 0) {
            g_warning("%s: Integer was out of bounds. Result will be clamped.",
                      name_prefix);
            raw_result = CLAMP(raw_result, 0, G_MAXUINT8);
        }
        main_argument->v_uint8 = (guint8) raw_result;
        break;
    case GI_TYPE_TAG_INT16:
        if (raw_result > G_MAXINT16 || raw_result < G_MININT16) {
            g_warning("%s: Integer was out of bounds. Result will be clamped.",
                      name_prefix);
            raw_result = CLAMP(raw_result, G_MININT16, G_MAXINT16);
        }
        main_argument->v_int16 = (gint16) raw_result;
        break;
    case GI_TYPE_TAG_UINT16:
        if (raw_result > G_MAXUINT16 || raw_result < 0) {
            g_warning("%s: Integer was out of bounds. Result will be clamped.",
                      name_prefix);
            raw_result = CLAMP(raw_result, 0, G_MAXUINT16);
        }
        main_argument->v_uint16 = (guint16) raw_result;
        break;
    case GI_TYPE_TAG_INT32:
        if (raw_result > G_MAXINT32 || raw_result < G_MININT32) {
            g_warning("%s: Integer was out of bounds. Result will be clamped.",
                      name_prefix);
            raw_result = CLAMP(raw_result, G_MININT32, G_MAXINT32);
        }
        main_argument->v_int32 = (gint32) raw_result;
        break;
    case GI_TYPE_TAG_UINT32:
        if (raw_result > G_MAXUINT32 || raw_result < 0) {
            g_warning("%s: Integer was out of bounds. Result will be clamped.",
                      name_prefix);
            raw_result = CLAMP(raw_result, 0, G_MAXUINT32);
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
        *dart_error_out = gdart_bridge_context_create_error_handle(
                              self,
                              "%s: expected an integer-like type", G_STRFUNC);
        g_set_error(error, GDART_ERROR, 1,
                              "%s: expected an integer-like type", G_STRFUNC);
        goto error;
    }
    return TRUE;
error:
    return FALSE;
}

gboolean _gdart_function_argument_fill_int_in_buffer(
    GdartBridgeContext *self,
    const gchar* name_prefix,
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
        temp_result = Dart_IntegerToUint64(element, &raw_result_64);
    } else {
        temp_result = Dart_IntegerToInt64(element, &raw_result);
    }
    if (Dart_IsError(temp_result)) {
        *dart_error_out = temp_result;
        g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
        goto error;
    }
    if (!_gdart_function_argument_fill_int_raw_in_buffer(self,
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

gboolean _gdart_function_argument_fill_int(
    GdartBridgeContext *self,
    const gchar* name_prefix,
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
        temp_result = Dart_IntegerToUint64(element, &raw_result_64);
    } else {
        temp_result = Dart_IntegerToInt64(element, &raw_result);
    }
    if (Dart_IsError(temp_result)) {
        *dart_error_out = temp_result;
        g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
        goto error;
    }
    if (!_gdart_function_argument_fill_int_raw(self,
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
        g_assert(main_argument == &in_arg_cvalues[*c_arg_pos]);
        ffi_arg_pointers[*c_arg_pos] = main_argument;
        (*c_arg_pos)++;
    }
    return TRUE;
error:
    return FALSE;
}

gboolean _gdart_function_argument_fill_in_int(
    GdartBridgeContext *self,
    const gchar* name_prefix,
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
    element = Dart_ListGetAt(dart_args, (*dart_arg_pos)++);
    if (Dart_IsError(element)) {
        *dart_error_out = element;
        g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
        goto error;
    }
    return _gdart_function_argument_fill_int(self,
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

gboolean _gdart_function_argument_fill_num_raw_in_buffer(
    GdartBridgeContext *self,
    const gchar* name_prefix,
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
        _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE(gfloat, buffer, float_result);
        break;
    case GI_TYPE_TAG_DOUBLE:
        _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE(gdouble, buffer, double_result);
        break;
    default:
        *dart_error_out = gdart_bridge_context_create_error_handle(
                              self,
                              "%s: expected an number-like type", G_STRFUNC);
        g_set_error(error, GDART_ERROR, 1,
                              "%s: expected an number-like type", G_STRFUNC);
        goto error;
    }
    return TRUE;
error:
    return FALSE;
}

gboolean _gdart_function_argument_fill_num_in_buffer(
    GdartBridgeContext *self,
    const gchar* name_prefix,
    Dart_Handle element,
    gpointer  *buffer,
    GITypeTag type_tag,
    Dart_Handle *dart_error_out,
    GError **error)
{
    Dart_Handle temp_result;
    gdouble double_result;

    if (Dart_IsInteger(element)) {
        int64_t raw_result;
        temp_result = Dart_IntegerToInt64(element, &raw_result);
        if (Dart_IsError(temp_result)) {
            *dart_error_out = temp_result;
            g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
            goto error;
        }
        double_result = (gdouble) raw_result;
    } else { // Double
        temp_result = Dart_DoubleValue(element, &double_result);
        if (Dart_IsError(temp_result)) {
            *dart_error_out = temp_result;
            g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
            goto error;
        }
    }
    return _gdart_function_argument_fill_num_raw_in_buffer(self,
            name_prefix,
            double_result,
            buffer,
            type_tag,
            dart_error_out,
            error);
error:
    return FALSE;
}

gboolean _gdart_function_argument_fill_num(
    GdartBridgeContext *self,
    const gchar* name_prefix,
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

    if (Dart_IsInteger(element)) {
        int64_t raw_result;
        temp_result = Dart_IntegerToInt64(element, &raw_result);
        if (Dart_IsError(temp_result)) {
            *dart_error_out = temp_result;
            g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
            goto error;
        }
        double_result = (gdouble) raw_result;
    } else { // Double
        temp_result = Dart_DoubleValue(element, &double_result);
        if (Dart_IsError(temp_result)) {
            *dart_error_out = temp_result;
            g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
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
        *dart_error_out = gdart_bridge_context_create_error_handle(
                              self,
                              "%s: expected an number-like type", G_STRFUNC);
        g_set_error(error, GDART_ERROR, 1,
                              "%s: expected an number-like type", G_STRFUNC);
        goto error;
    }
    if (ffi_arg_pointers != NULL) {
        g_assert(main_argument == &in_arg_cvalues[*c_arg_pos]);
        ffi_arg_pointers[*c_arg_pos] = main_argument;
        (*c_arg_pos)++;
    }
    return TRUE;
error:
    return FALSE;
}

gboolean _gdart_function_argument_fill_in_num(
    GdartBridgeContext *self,
    const gchar* name_prefix,
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
    element = Dart_ListGetAt(dart_args, (*dart_arg_pos)++);
    if (Dart_IsError(element)) {
        *dart_error_out = element;
        g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
        goto error;
    }
    return _gdart_function_argument_fill_num(self,
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

void _gdart_function_argument_fill_pointer_raw_in_buffer(
    gpointer object,
    gpointer  *buffer)
{
    _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE(gpointer, buffer, object);
}

void _gdart_function_argument_unfill_string_in_buffer(
    GdartBridgeContext *self,
    gpointer  *buffer)
{
    gpointer* buffer_temp = (gpointer*) *buffer;
    g_free(*buffer_temp);
    buffer_temp++;
    *buffer = buffer_temp;
}

gboolean _gdart_function_argument_fill_string_in_buffer(
    GdartBridgeContext *self,
    const gchar* name_prefix,
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

    if (Dart_IsNull(element)) {
        _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE(gchar*, buffer, NULL);
        return TRUE;
    }
    temp_result = Dart_StringToUTF8(element, &original_string, &string_length);
    if (Dart_IsError(temp_result)) {
        *dart_error_out = temp_result;
        g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
        return FALSE;
    }
    switch (type_tag) {
    case GI_TYPE_TAG_UTF8:
        resulting_string = g_new(gchar, string_length + 1);
        memmove(resulting_string, original_string, string_length);
        resulting_string[string_length] = '\0';
        break;
    case GI_TYPE_TAG_FILENAME:
        resulting_string = g_filename_from_utf8((gchar*) original_string,
                                                string_length,
                                                &bytes_read,
                                                &bytes_written,
                                                &inner_error);
        if (resulting_string == NULL) {
            *dart_error_out = gdart_bridge_context_create_error_handle(
                                  self,
                                  "%s",
                                  inner_error->message);
            g_propagate_error(error, inner_error);
            return FALSE;
        }
        break;
    default:
        *dart_error_out = gdart_bridge_context_create_error_handle(
                              self,
                              "%s: expected an string-like type", G_STRFUNC);
        g_set_error(error, GDART_ERROR, 1,
                              "%s: expected an string-like type", G_STRFUNC);
        goto error;
    }
    _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE(gchar*, buffer, resulting_string);
    return TRUE;
error:
    return FALSE;
}


void _gdart_function_argument_unfill_in_string(
    GdartBridgeContext *self,
    GArgument *in_arg_cvalues,
    gint *c_arg_pos)
{
    g_free(in_arg_cvalues[*c_arg_pos].v_string);
    (*c_arg_pos)++;

}

gboolean _gdart_function_argument_fill_string(
    GdartBridgeContext *self,
    const gchar* name_prefix,
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

    if (Dart_IsNull(element)) {
        main_argument->v_pointer = NULL;
        if (ffi_arg_pointers != NULL) {
            g_assert(main_argument == &in_arg_cvalues[*c_arg_pos]);
            ffi_arg_pointers[*c_arg_pos] = main_argument;
            (*c_arg_pos)++;
        }
        return TRUE;
    }
    temp_result = Dart_StringToUTF8(element, &original_string, &string_length);
    if (Dart_IsError(temp_result)) {
        *dart_error_out = temp_result;
        g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
        return FALSE;
    }
    switch (type_tag) {
    case GI_TYPE_TAG_UTF8:
        resulting_string = g_new(gchar, string_length + 1);
        memmove(resulting_string, original_string, string_length);
        resulting_string[string_length] = '\0';
        break;
    case GI_TYPE_TAG_FILENAME:
        resulting_string = g_filename_from_utf8((gchar*) original_string,
                                                string_length,
                                                &bytes_read,
                                                &bytes_written,
                                                &inner_error);
        if (resulting_string == NULL) {
            *dart_error_out = gdart_bridge_context_create_error_handle(
                                  self,
                                  "%s",
                                  inner_error->message);
            g_propagate_error(error, inner_error);
            return FALSE;
        }
        break;
    default:
        *dart_error_out = gdart_bridge_context_create_error_handle(
                              self,
                              "%s: expected an string-like type", G_STRFUNC);
        g_set_error(error, GDART_ERROR, 1,
                              "%s: expected an string-like type", G_STRFUNC);
        goto error;
    }
    main_argument->v_string = resulting_string;
    if (ffi_arg_pointers != NULL) {
        g_assert(main_argument == &in_arg_cvalues[*c_arg_pos]);
        ffi_arg_pointers[*c_arg_pos] = main_argument;
        (*c_arg_pos)++;
    }
    return TRUE;
error:
    return FALSE;
}

gboolean _gdart_function_argument_fill_in_string(
    GdartBridgeContext *self,
    const gchar* name_prefix,
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
    element = Dart_ListGetAt(dart_args, (*dart_arg_pos)++);
    if (Dart_IsError(element)) {
        *dart_error_out = element;
        g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
        goto error;
    }
    return _gdart_function_argument_fill_string(self,
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

gboolean _gdart_function_argument_fill_wrapped_pointer_in_buffer(
    Dart_Handle element,
    const gchar* name_prefix,
    gpointer  *buffer,
    Dart_Handle *dart_error_out,
    GError **error)
{
    Dart_Handle temp_result, inner_container, name_handle;
    RawPointerContainer *raw_pointer;
    GdartBridgeContextWrappedObject *object_info;
    void *object;

    if (Dart_IsNull(element)) {
        _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE(gpointer, buffer, NULL);
        return TRUE;
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
    object = object_info->object;
    _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE(gpointer, buffer, object);
    return TRUE;
}

gboolean _gdart_function_argument_fill_wrapped_pointer(
    Dart_Handle element,
    const gchar* name_prefix,
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
    GIRegisteredTypeInfo* type_info;
    GdartBridgeContextWrappedObject *object_info;
    void *object;

    if (Dart_IsNull(element)) {
        main_argument->v_pointer = NULL;
        if (ffi_arg_pointers != NULL) {
            g_assert(main_argument == &in_arg_cvalues[*c_arg_pos]);
            ffi_arg_pointers[*c_arg_pos] = main_argument;
            (*c_arg_pos)++;
        }
        return TRUE;
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
    object = object_info->object;
    type_info = object_info->object_info;
    if (is_transfer_full) {
        switch(g_base_info_get_type((GIBaseInfo*) type_info)) {
        case GI_INFO_TYPE_OBJECT: {
            GIObjectInfoRefFunction refer =
                g_object_info_get_ref_function_pointer((GIObjectInfo*) type_info);
            object = refer(object);
            break;
        }
        case GI_INFO_TYPE_BOXED:
            object = g_boxed_copy(object_info->type, object);
            break;
        case GI_INFO_TYPE_STRUCT:
        case GI_INFO_TYPE_UNION:
            g_warning("%s: The GI type of an object leaving dart was an [owned %s.%s] "
                      "but there's no copy function registered. "
                      "This can be unsafe if the object is used after it has "
                      "been invalidated by external code.",
                      name_prefix,
                      g_base_info_get_namespace(type_info),
                      g_base_info_get_name(type_info));
        default:
            break;
        }
    }

    main_argument->v_pointer = object;
    if (ffi_arg_pointers != NULL) {
        g_assert(main_argument == &in_arg_cvalues[*c_arg_pos]);
        ffi_arg_pointers[*c_arg_pos] = main_argument;
        (*c_arg_pos)++;
    }
    return TRUE;
}


void _gdart_function_argument_fill_raw_pointer(
    const gchar* name_prefix,
    gpointer object,
    GArgument *main_argument,
    GArgument *in_arg_cvalues,
    gpointer  *ffi_arg_pointers,
    gint *c_arg_pos)
{
    main_argument->v_pointer = object;
    if (ffi_arg_pointers != NULL) {
        g_assert(main_argument == &in_arg_cvalues[*c_arg_pos]);
        ffi_arg_pointers[*c_arg_pos] = main_argument;
        (*c_arg_pos)++;
    }
}


gboolean _gdart_function_argument_fill_callback(GdartBridgeContext *self,
        const gchar *name_prefix,
        Dart_Handle element,
        GICallbackInfo *callback_info,
        gboolean is_method,
        GIArgInfo *arg_info,
        GIScopeType scope,
        GdartCallbackTrampoline **trampolines,
        gint trampolines_length,
        GArgument *main_argument,
        GArgument *in_arg_cvalues,
        gpointer *ffi_arg_pointers,
        gint *c_arg_pos,
        Dart_Handle *dart_error_out,
        GError **error) {
	gboolean is_one_shot;
	gint user_data;

	is_one_shot = scope == GI_SCOPE_TYPE_ASYNC;


	GdartCallbackTrampoline* trampoline;
	trampoline = g_slice_new(GdartCallbackTrampoline);

    user_data = g_arg_info_get_closure(arg_info);
    if (user_data != -1) {
		gint user_data_c_pos = is_method ? user_data + 1 : user_data;
		_gdart_function_argument_fill_raw_pointer(
		    name_prefix,
		    trampoline,
		    &in_arg_cvalues[user_data_c_pos],
		    in_arg_cvalues,
		    ffi_arg_pointers,
		    &user_data_c_pos);
	}
    trampoline->closure = g_callable_info_prepare_closure(callback_info,
                          &trampoline->cif,
                          _gdart_callback_closure,
                          trampoline);
    trampoline->closure_dart = Dart_NewPersistentHandle(element);
    trampoline->signal_info = g_base_info_ref((GIBaseInfo*) callback_info);
    trampoline->user_data_present = user_data != -1;
    trampoline->is_one_shot = is_one_shot;
    trampoline->closure_name = g_strdup(name_prefix);

    if (scope == GI_SCOPE_TYPE_CALL) {
		gint trampolines_pos = 0;

		if (trampolines_length == 0) {
            *dart_error_out = gdart_bridge_context_create_error_handle(self,
                              "%s: the callback was call allocated, but it wasn"
                              "'t clear when the callback should be deallocated",
                              G_STRFUNC);
            g_set_error(error, GDART_ERROR, 1,
                              "%s: the callback was call allocated, but it wasn"
                              "'t clear when the callback should be deallocated",
                              G_STRFUNC);
            g_slice_free(GdartCallbackTrampoline, trampoline);
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

		destroy_notify = g_arg_info_get_destroy(arg_info);
		destroy_notify_c_pos = is_method ? destroy_notify + 1 : destroy_notify;
		_gdart_function_argument_fill_raw_pointer(
		    name_prefix,
		    gdart_callback_closure_notify,
		    &in_arg_cvalues[destroy_notify_c_pos],
		    in_arg_cvalues,
		    ffi_arg_pointers,
		    &destroy_notify_c_pos);
	}
	_gdart_function_argument_fill_raw_pointer(
	    name_prefix,
	    trampoline->closure ,
		main_argument,
		in_arg_cvalues,
		ffi_arg_pointers,
		c_arg_pos);
	return TRUE;
}

gboolean _gdart_function_argument_fill_in_callback(GdartBridgeContext *self,
        const gchar* name_prefix,
        Dart_Handle dart_args,
        gint *dart_arg_pos,
        gboolean is_method,
        GICallbackInfo* callback_info,
        GIArgInfo *arg_info,
        GIScopeType scope,
        GdartCallbackTrampoline** trampolines,
        gint trampolines_length,
        GArgument *main_argument,
        GArgument *in_arg_cvalues,
        gpointer *ffi_arg_pointers,
        gint *c_arg_pos,
        Dart_Handle *dart_error_out,
        GError **error)
{
    Dart_Handle element;
    element = Dart_ListGetAt(dart_args, (*dart_arg_pos)++);
    if (Dart_IsError(element)) {
        *dart_error_out = element;
        g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
        goto error;
    }
    return _gdart_function_argument_fill_callback(
               self,
               name_prefix,
               element,
               callback_info,
               is_method,
               arg_info,
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

gboolean _gdart_function_argument_fill_in_wrapped_pointer(GdartBridgeContext *self,
        const gchar* name_prefix,
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
    element = Dart_ListGetAt(dart_args, (*dart_arg_pos)++);
    if (Dart_IsError(element)) {
        *dart_error_out = element;
        g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
        goto error;
    }
    return _gdart_function_argument_fill_wrapped_pointer(
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

gboolean _gdart_function_argument_fill_flags_in_buffer(
    GdartBridgeContext *self,
    const gchar* name_prefix,
    Dart_Handle element,
    gpointer  *buffer,
    GIEnumInfo* enum_info,
    Dart_Handle *dart_error_out,
    GError **error)
{
    Dart_Handle inner_container, name_handle;
    GITypeTag storage_type;
    storage_type = g_enum_info_get_storage_type(enum_info);
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
    return _gdart_function_argument_fill_int_in_buffer(self,
            name_prefix,
            inner_container,
            buffer,
            storage_type,
            dart_error_out,
            error);
}

gboolean _gdart_function_argument_fill_flags(
    GdartBridgeContext *self,
    const gchar* name_prefix,
    Dart_Handle element,
    GArgument *main_argument,
    GArgument *in_arg_cvalues,
    gpointer  *ffi_arg_pointers,
    gint *c_arg_pos,
    GIEnumInfo* enum_info,
    Dart_Handle *dart_error_out,
    GError **error)
{
    Dart_Handle inner_container, name_handle;
    GITypeTag storage_type;

    storage_type = g_enum_info_get_storage_type(enum_info);
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
    return _gdart_function_argument_fill_int(self,
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

gboolean _gdart_function_argument_fill_in_flags(GdartBridgeContext *self,
        const gchar* name_prefix,
        Dart_Handle dart_args,
        gint *dart_arg_pos,
        GArgument *main_argument,
        GArgument *in_arg_cvalues,
        gpointer *ffi_arg_pointers,
        gint *c_arg_pos,
        GIEnumInfo* enum_info,
        Dart_Handle *dart_error_out,
        GError **error)
{
    Dart_Handle element;
    element = Dart_ListGetAt(dart_args, (*dart_arg_pos)++);
    if (Dart_IsError(element)) {
        *dart_error_out = element;
        g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
        goto error;
    }
    return _gdart_function_argument_fill_flags(self,
            name_prefix,
            element,
            main_argument,
            in_arg_cvalues,
            ffi_arg_pointers,
            c_arg_pos,
            enum_info,
            dart_error_out,
            error);
error:
    return FALSE;
}
/*
gboolean _gdart_function_argument_fill_interface(
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

gboolean _gdart_function_argument_fill_interface_in_buffer(
    GdartBridgeContext *self,
    const gchar* name_prefix,
    Dart_Handle element,
    gpointer* buffer,
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
    case GI_INFO_TYPE_OBJECT:
    case GI_INFO_TYPE_INTERFACE:
        result = _gdart_function_argument_fill_wrapped_pointer_in_buffer(
                     element,
                     name_prefix,
                     buffer,
                     dart_error_out,
                     error);
        goto out;

    case GI_INFO_TYPE_ENUM:
    case GI_INFO_TYPE_FLAGS:
        result = _gdart_function_argument_fill_flags_in_buffer(self,
                 name_prefix,
                 element,
                 buffer,
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

gboolean _gdart_function_argument_fill_in_interface(
    GdartBridgeContext *self,
    const gchar* name_prefix,
    Dart_Handle dart_args,
    gint *dart_arg_pos,
    gboolean is_method,
    GIArgInfo *arg_info,
    GITypeInfo *arg_type,
    gboolean is_transfer_full,
    GArgument *main_argument,
    GArgument* in_arg_cvalues,
    gpointer* ffi_arg_pointers,
    GdartCallbackTrampoline** trampolines,
    gint trampolines_length,
    gint* c_arg_pos,
    Dart_Handle *dart_error_out,
    GError **error)
{
    GIBaseInfo* base_info;
    gboolean result;
    base_info = g_type_info_get_interface(arg_type);
    switch (g_base_info_get_type(base_info)) {
    case GI_INFO_TYPE_CALLBACK:
        result = _gdart_function_argument_fill_in_callback(
                 self,
                 name_prefix,
                 dart_args,
                 dart_arg_pos,
                 is_method,
                 (GICallbackInfo*) base_info,
                 arg_info,
                 g_arg_info_get_scope(arg_info),
                 trampolines,
                 trampolines_length,
                 main_argument,
                 in_arg_cvalues,
                 ffi_arg_pointers,
                 c_arg_pos,
                 dart_error_out,
                 error);
        goto out;
    case GI_INFO_TYPE_STRUCT:
    case GI_INFO_TYPE_BOXED:
    case GI_INFO_TYPE_UNION:
    case GI_INFO_TYPE_OBJECT:
    case GI_INFO_TYPE_INTERFACE:
        result = _gdart_function_argument_fill_in_wrapped_pointer(self,
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
    case GI_INFO_TYPE_FLAGS:
        result = _gdart_function_argument_fill_in_flags(self,
                 name_prefix,
                 dart_args,
                 dart_arg_pos,
                 main_argument,
                 in_arg_cvalues,
                 ffi_arg_pointers,
                 c_arg_pos,
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

gboolean _gdart_function_argument_fill_in_array_parameters(
    GdartBridgeContext *self,
    const gchar* name_prefix,
    Dart_Handle dart_list,
    GITypeInfo *param_type,
    gint fixed_length,
    gintptr list_length,
    gpointer buffer,
    gpointer *buffer_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
    Dart_Handle element;
    gintptr elem_i = 0;
    GError* inner_error = NULL;

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
        if (!_gdart_function_array_element(self,
                                           name_prefix,
                                           element,
                                           param_type,
                                           &buffer,
                                           dart_error_out,
                                           &inner_error)) {
            g_propagate_error(error, inner_error);
            goto error;
        }
    }
    (*buffer_out) = buffer;
    return TRUE;
error:
    return FALSE;
}

/*
gboolean _gdart_function_argument_fill_array(GdartBridgeContext *self,
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

gsize _gdart_function_get_array_size_multiplier_out(GITypeInfo *param_type)
{
    switch (g_type_info_get_tag(param_type)) {
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
        return _gdart_function_get_array_size_multiplier(param_type);
    case GI_TYPE_TAG_INTERFACE: {
        GIBaseInfo* base_info;
        base_info = g_type_info_get_interface(param_type);
        switch (g_base_info_get_type(base_info)) {
        case GI_INFO_TYPE_CALLBACK:
        case GI_INFO_TYPE_BOXED:
        case GI_INFO_TYPE_OBJECT:
        case GI_INFO_TYPE_INTERFACE:
            g_base_info_unref(base_info);
            return sizeof(gpointer);
        case GI_INFO_TYPE_STRUCT: {
            gsize result;
            result = g_struct_info_get_size((GIStructInfo*) base_info);
            g_base_info_unref(base_info);
            return result;
        }
        case GI_INFO_TYPE_UNION: {
            gsize result;
            result = g_union_info_get_size((GIUnionInfo*) base_info);
            g_base_info_unref(base_info);
            return result;
        }
        case GI_INFO_TYPE_ENUM:
        case GI_INFO_TYPE_FLAGS: {
            gsize result;
            result = _gdart_function_get_array_size_multiplier(param_type);
            g_base_info_unref(base_info);
            return result;
        }
        default:
            g_base_info_unref(base_info);
            return 0;
        }
    }

    case GI_TYPE_TAG_ERROR:
        return sizeof(gpointer);
    default:
        return 0;
    }
}

gsize _gdart_function_get_array_size_multiplier(GITypeInfo *param_type)
{
    switch (g_type_info_get_tag(param_type)) {
    case GI_TYPE_TAG_BOOLEAN:
        return sizeof(gboolean);
    case GI_TYPE_TAG_INT8:
        return sizeof(gint8);
    case GI_TYPE_TAG_UINT8:
        return sizeof(guint8);
    case GI_TYPE_TAG_INT16:
        return sizeof(gint16);
    case GI_TYPE_TAG_UINT16:
        return sizeof(guint16);
    case GI_TYPE_TAG_INT32:
        return sizeof(gint32);
    case GI_TYPE_TAG_UINT32:
        return sizeof(guint32);
    case GI_TYPE_TAG_INT64:
        return sizeof(gint64);
    case GI_TYPE_TAG_UINT64:
        return sizeof(guint64);
    case GI_TYPE_TAG_GTYPE:
        return sizeof(GType);
    case GI_TYPE_TAG_FLOAT:
        return sizeof(gfloat);
    case GI_TYPE_TAG_DOUBLE:
        return sizeof(gdouble);
    case GI_TYPE_TAG_INTERFACE: {
        GIBaseInfo* base_info;
        base_info = g_type_info_get_interface(param_type);
        switch (g_base_info_get_type(base_info)) {
        case GI_INFO_TYPE_CALLBACK:
        case GI_INFO_TYPE_STRUCT:
        case GI_INFO_TYPE_BOXED:
        case GI_INFO_TYPE_UNION:
        case GI_INFO_TYPE_OBJECT:
        case GI_INFO_TYPE_INTERFACE:
            g_base_info_unref(base_info);
            return sizeof(gpointer);

        case GI_INFO_TYPE_ENUM:
        case GI_INFO_TYPE_FLAGS: {
            switch (g_enum_info_get_storage_type((GIEnumInfo*) base_info)) {
            case GI_TYPE_TAG_BOOLEAN:
                g_base_info_unref(base_info);
                return sizeof(gboolean);
            case GI_TYPE_TAG_INT8:
                g_base_info_unref(base_info);
                return sizeof(gint8);
            case GI_TYPE_TAG_UINT8:
                g_base_info_unref(base_info);
                return sizeof(guint8);
            case GI_TYPE_TAG_INT16:
                g_base_info_unref(base_info);
                return sizeof(gint16);
            case GI_TYPE_TAG_UINT16:
                g_base_info_unref(base_info);
                return sizeof(guint16);
            case GI_TYPE_TAG_INT32:
                g_base_info_unref(base_info);
                return sizeof(gint32);
            case GI_TYPE_TAG_UINT32:
                g_base_info_unref(base_info);
                return sizeof(guint32);
            case GI_TYPE_TAG_INT64:
                g_base_info_unref(base_info);
                return sizeof(gint64);
            case GI_TYPE_TAG_UINT64:
                g_base_info_unref(base_info);
                return sizeof(guint64);
            case GI_TYPE_TAG_GTYPE:
                g_base_info_unref(base_info);
                return sizeof(GType);
            default:
                g_base_info_unref(base_info);
                return 0;
            }
        }
        default:
            g_base_info_unref(base_info);
            return 0;
        }
    }
    case GI_TYPE_TAG_ARRAY:
    case GI_TYPE_TAG_UTF8:
    case GI_TYPE_TAG_FILENAME:
    case GI_TYPE_TAG_GLIST:
    case GI_TYPE_TAG_GSLIST:
    case GI_TYPE_TAG_GHASH:
    case GI_TYPE_TAG_ERROR:
        return sizeof(gpointer);
    default:
        return 0;
    }
}


void _gdart_function_argument_unfill_in_array_parameters(
    GdartBridgeContext *self,
    GITypeInfo *param_type,
    gint length,
    gboolean is_null_terminated,
    gpointer buffer)
{
    gintptr elem_i = 0;
    for (; elem_i < length; elem_i++) {
        if (!_gdart_function_remove_array_element(self,
                param_type,
                &buffer)) {
            return;
        }
    }
}

void _gdart_function_argument_unfill_array_in_buffer(
    GdartBridgeContext *self,
    gpointer* buffer,
    GITypeInfo* arg_type)
{
    GITypeInfo *param_type;
    gpointer *buffer_loc = *buffer;
    gpointer inner_buffer = *buffer_loc;
    param_type = g_type_info_get_param_type(arg_type, 0);
    _gdart_function_argument_unfill_in_array_parameters(self,
            param_type,
            -1,
            TRUE,
            inner_buffer);
    g_free(inner_buffer);
    buffer_loc++;
    *buffer = buffer_loc;
}


gboolean _gdart_function_argument_fill_array_in_buffer(
    GdartBridgeContext *self,
    const gchar* name_prefix,
    Dart_Handle element,
    gpointer* buffer,
    GITypeInfo* arg_type,
    Dart_Handle *dart_error_out,
    GError **error)
{
    Dart_Handle temp_result;
    intptr_t list_length;
    gintptr allocation_length;
    GITypeInfo *param_type;
    gpointer inner_pointer;
    gpointer inner_pointer_after;
    if (!Dart_IsList(element) && !Dart_IsNull(element)) {
        *dart_error_out = gdart_bridge_context_create_error_handle(self,
                          "%s: expected string or null", G_STRFUNC);
        g_set_error(error, GDART_ERROR, 1,
                          "%s: expected string or null", G_STRFUNC);
        goto error;
    }
    if (Dart_IsNull(element)) {
        list_length = 0;
    } else {
        temp_result = Dart_ListLength(element, &list_length);
        if (Dart_IsError(temp_result)) {
            *dart_error_out = temp_result;
            g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
            goto error;
        }
    }
    allocation_length = list_length + 1;
    param_type = g_type_info_get_param_type(arg_type, 0);
    inner_pointer = g_slice_alloc(allocation_length*_gdart_function_get_array_size_multiplier(param_type));

    if (!_gdart_function_argument_fill_in_array_parameters(self,
            name_prefix,
            element,
            param_type,
            -1,
            list_length,
            inner_pointer,
            &inner_pointer_after,
            dart_error_out,
            error)) {
        return FALSE;
    }
    ((gpointer*) inner_pointer)[list_length] = NULL;
    _GDART_FUNCTION_FILL_BUFFER_AND_ADVANCE(gpointer, buffer, inner_pointer);

error:
    return FALSE;
}

gboolean _gdart_function_zero_array_element(GdartBridgeContext *self,
        const gchar* name_prefix,
        GITypeInfo *arg_type,
        gpointer *buffer,
        Dart_Handle *dart_error_out,
        GError **error)
{
    GITypeTag type_tag;
    type_tag = g_type_info_get_tag(arg_type);
    switch (type_tag) {
    case GI_TYPE_TAG_BOOLEAN:
        _gdart_function_argument_fill_boolean_raw_in_buffer(
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
        return _gdart_function_argument_fill_int_raw_in_buffer(self,
                name_prefix,
                0,
                0,
                buffer,
                type_tag,
                dart_error_out,
                error);
    case GI_TYPE_TAG_FLOAT:
    case GI_TYPE_TAG_DOUBLE:
        return _gdart_function_argument_fill_num_raw_in_buffer(self,
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
        _gdart_function_argument_fill_pointer_raw_in_buffer(
            NULL,
            buffer);
        return TRUE;
    default:
        *dart_error_out = gdart_bridge_context_create_error_handle(self,
                          "%s: got an unexpected type", G_STRFUNC);
        g_set_error(error, GDART_ERROR, 1,
                          "%s: got an unexpected type", G_STRFUNC);
        return FALSE;
    }
}

gint _gdart_function_result_load_int_raw_from_in(
    GdartBridgeContext *self,
    const gchar* name_prefix,
    GICallableInfo *function_info,
    gint gi_arg_pos,
    GIArgument *in_arg_cvalues,
    gint c_arg_pos)
{
    GIArgInfo arg_info;
    GITypeInfo type_info;
    GITypeTag return_tag;
    gint64 result;
    GIArgument *gi_return_value = &in_arg_cvalues[c_arg_pos];
    g_callable_info_load_arg(function_info, gi_arg_pos, &arg_info);
    g_arg_info_load_type(&arg_info, &type_info);
    return_tag = g_type_info_get_tag(&type_info);
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
    default:
        goto error;
    }
    return result;
error:
    return -1;
}

void _gdart_function_argument_unfill_in_array(
    GdartBridgeContext *self,
    const gchar* name_prefix,
    GITypeInfo *arg_type,
    GICallableInfo *function_info,
    GArgument* in_arg_cvalues,
    gboolean is_method,
    gint* c_arg_pos)
{
    gint arg_to_suppress, length=0;
    arg_to_suppress = g_type_info_get_array_length(arg_type);
    gboolean is_null_terminated;
    gpointer buffer;

    is_null_terminated = g_type_info_is_zero_terminated(arg_type);
    GITypeInfo *param_type;
    param_type = g_type_info_get_param_type(arg_type, 0);

    length = g_type_info_get_array_fixed_size(arg_type);
    if (arg_to_suppress != -1) {
        length = _gdart_function_result_load_int_raw_from_in(
                     self,
                     name_prefix,
                     function_info,
                     arg_to_suppress,
                     in_arg_cvalues,
                     is_method ? arg_to_suppress + 1 : arg_to_suppress);
    }
    buffer = in_arg_cvalues[*c_arg_pos].v_pointer;
    _gdart_function_argument_unfill_in_array_parameters(self,
            param_type,
            length,
            is_null_terminated,
            buffer);
    g_free(buffer);
}

gboolean _gdart_function_argument_fill_in_array(
    GdartBridgeContext *self,
    const gchar* name_prefix,
    Dart_Handle dart_args,
    gint *dart_arg_pos,
    GITypeInfo *arg_type,
    GICallableInfo *function_info,
    gboolean is_method,
    GArgument *main_argument,
    GArgument* in_arg_cvalues,
    gpointer* ffi_arg_pointers,
    gint* c_arg_pos,
    Dart_Handle *dart_error_out,
    GError **error)
{
    Dart_Handle element, temp_result;
    gint arg_to_suppress, fixed_length=0;
    arg_to_suppress = g_type_info_get_array_length(arg_type);
    gboolean is_null_terminated;
    is_null_terminated = g_type_info_is_zero_terminated(arg_type);
    gpointer buffer, buffer_after;
    intptr_t list_length;
    gintptr allocation_length;
    GITypeInfo *param_type;

    fixed_length = g_type_info_get_array_fixed_size(arg_type);
    if (arg_to_suppress == -1 && fixed_length == -1 && !is_null_terminated) {
        *dart_error_out = gdart_bridge_context_create_error_handle(self,
                          "%s: the array did not have a length, a fixed size or a null termination so I can't handle it", G_STRFUNC);
        g_set_error(error, GDART_ERROR, 1,
                          "%s: the array did not have a length, a fixed size or a null termination so I can't handle it", G_STRFUNC);
        goto error;
    }
    element = Dart_ListGetAt(dart_args, (*dart_arg_pos)++);
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
    if (Dart_IsNull(element)) {
        list_length = 0;
    } else {
        temp_result = Dart_ListLength(element, &list_length);
        if (Dart_IsError(temp_result)) {
            *dart_error_out = temp_result;
            g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
            goto error;
        }
    }
    allocation_length = list_length;
    if (is_null_terminated) {
        allocation_length++;
    } else if (arg_to_suppress != -1) {
        GIArgInfo arg_info_length;
        GITypeInfo arg_type_length;
        GITypeTag type_tag_length;
        gint arg_offset = is_method ? 1 : 0;
        g_callable_info_load_arg(function_info, arg_to_suppress, &arg_info_length);
        g_arg_info_load_type(&arg_info_length, &arg_type_length);
        type_tag_length = g_type_info_get_tag(&arg_type_length);
        if (!_gdart_function_argument_fill_int_raw(self,
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
            g_assert(main_argument == &in_arg_cvalues[*c_arg_pos]);
            ffi_arg_pointers[*c_arg_pos] = &in_arg_cvalues[*c_arg_pos];
            (*c_arg_pos)++;
        }
        return TRUE;
    }
    param_type = g_type_info_get_param_type(arg_type, 0);
    buffer = g_malloc(allocation_length*_gdart_function_get_array_size_multiplier(param_type));

    if (!_gdart_function_argument_fill_in_array_parameters(self,
            name_prefix,
            element,
            param_type,
            fixed_length,
            list_length,
            buffer,
            &buffer_after,
            dart_error_out,
            error)) {
        g_base_info_unref((GIBaseInfo*) param_type);
        g_slice_free1(allocation_length*_gdart_function_get_array_size_multiplier(param_type),
                      buffer);
        return FALSE;
    }
    if (is_null_terminated) {
        if (!_gdart_function_zero_array_element(self,
                                                name_prefix,
                                                param_type,
                                                &buffer_after,
                                                dart_error_out,
                                                error)) {
            g_base_info_unref((GIBaseInfo*) param_type);
            g_slice_free1(allocation_length*_gdart_function_get_array_size_multiplier(param_type),
                          buffer);
            return FALSE;
        }
    }
    in_arg_cvalues[*c_arg_pos].v_pointer = buffer;
    if (ffi_arg_pointers != NULL) {
        g_assert(main_argument == &in_arg_cvalues[*c_arg_pos]);
        ffi_arg_pointers[*c_arg_pos] = &in_arg_cvalues[*c_arg_pos];
        (*c_arg_pos)++;
    }
    return TRUE;
error:
    return FALSE;
}

gboolean _gdart_function_remove_array_element(GdartBridgeContext *self,
        GITypeInfo *arg_type,
        gpointer *buffer)
{
    GITypeTag type_tag;
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
    case GI_TYPE_TAG_INTERFACE:
    case GI_TYPE_TAG_GLIST:
    case GI_TYPE_TAG_GSLIST:
    case GI_TYPE_TAG_GHASH:
    case GI_TYPE_TAG_ERROR:
        return FALSE;
    case GI_TYPE_TAG_UTF8:
    case GI_TYPE_TAG_FILENAME:
        _gdart_function_argument_unfill_string_in_buffer(self,
                buffer);
        return TRUE;
    case GI_TYPE_TAG_ARRAY:
        _gdart_function_argument_unfill_array_in_buffer(self,
                buffer,
                arg_type);
        return TRUE;
    default:
        g_assert_not_reached();
    }
    return TRUE;
}

gboolean _gdart_function_array_element(GdartBridgeContext *self,
                                       const gchar* name_prefix,
                                       Dart_Handle element,
                                       GITypeInfo *arg_type,
                                       gpointer *buffer,
                                       Dart_Handle *dart_error_out,
                                       GError **error)
{
    GITypeTag type_tag;
    type_tag = g_type_info_get_tag(arg_type);
    switch (type_tag) {
    case GI_TYPE_TAG_BOOLEAN:
        return _gdart_function_argument_fill_boolean_in_buffer(
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
        return _gdart_function_argument_fill_int_in_buffer(self,
                name_prefix,
                element,
                buffer,
                type_tag,
                dart_error_out,
                error);
    case GI_TYPE_TAG_FLOAT:
    case GI_TYPE_TAG_DOUBLE:
        return _gdart_function_argument_fill_num_in_buffer(self,
                name_prefix,
                element,
                buffer,
                type_tag,
                dart_error_out,
                error);
    case GI_TYPE_TAG_UTF8:
    case GI_TYPE_TAG_FILENAME:
        return _gdart_function_argument_fill_string_in_buffer(self,
                name_prefix,
                element,
                buffer,
                type_tag,
                dart_error_out,
                error);
    case GI_TYPE_TAG_ARRAY:
        return _gdart_function_argument_fill_array_in_buffer(self,
                name_prefix,
                element,
                buffer,
                arg_type,
                dart_error_out,
                error);
    case GI_TYPE_TAG_INTERFACE:
        return _gdart_function_argument_fill_interface_in_buffer(self,
                name_prefix,
                element,
                buffer,
                arg_type,
                dart_error_out,
                error);
    case GI_TYPE_TAG_GLIST:
    case GI_TYPE_TAG_GSLIST:
    case GI_TYPE_TAG_GHASH:
    case GI_TYPE_TAG_ERROR:
        return _gdart_function_argument_fill_wrapped_pointer_in_buffer(
                   element,
                   name_prefix,
                   buffer,
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

gboolean gdart_function_prep_invoke(GdartBridgeContext *self,
                                    const gchar* name_prefix,
                                    GICallableInfo *function_info,
                                    GType type,
                                    GIFunctionInvoker *invoker,
                                    Dart_Handle *dart_error_out,
                                    GError **error)
{
    GIInfoType info_type;
    GError *inner_error = NULL;
    gpointer addr;
    info_type = g_base_info_get_type((GIBaseInfo*) function_info);
    if (info_type == GI_INFO_TYPE_FUNCTION) {
        if (!g_function_info_prep_invoker((GIFunctionInfo*) function_info,
                                          invoker,
                                          &inner_error)) {
            *dart_error_out = gdart_bridge_context_create_error_handle(
                                  self,
                                  "%s",
                                  inner_error->message);
            g_propagate_error(error, inner_error);
            return FALSE;
        }
    } else if (info_type == GI_INFO_TYPE_VFUNC) {
        addr = g_vfunc_info_get_address((GIVFuncInfo*) function_info,
                                        type,
                                        &inner_error);
        if (inner_error != NULL) {
            if (inner_error->code != G_INVOKE_ERROR_SYMBOL_NOT_FOUND) {
                *dart_error_out = gdart_bridge_context_create_error_handle(
                                      self,
                                      "%s",
                                      inner_error->message);
                g_propagate_error(error, inner_error);
                return FALSE;
            }
            g_clear_error(&inner_error);
            return FALSE;
        }
        if (!g_function_invoker_new_for_address(addr,
                                                function_info,
                                                invoker,
                                                &inner_error)) {
            *dart_error_out = gdart_bridge_context_create_error_handle(
                                  self,
                                  "%s",
                                  inner_error->message);
            g_propagate_error(error, inner_error);
            return FALSE;
        }
    }
    return TRUE;
}

gboolean _gdart_function_invoke_fill_receiver(GdartBridgeContext *self,
        const gchar* name_prefix,
        Dart_Handle dart_receiver,
        GArgument *main_argument,
        GArgument *in_arg_cvalues,
        gpointer  *ffi_arg_pointers,
        Dart_Handle *dart_error_out,
        GError **error)
{
    gint c_arg_pos = 0, dart_arg_pos = 0;
    Dart_Handle dart_args, temp_result;
    dart_args = Dart_NewList(1);
    if (Dart_IsError(dart_args)) {
        *dart_error_out = dart_args;
        g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
        return FALSE;
    }
    temp_result = Dart_ListSetAt(dart_args, 0, dart_receiver);
    if (Dart_IsError(temp_result)) {
        *dart_error_out = temp_result;
        g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
        return FALSE;
    }
    return _gdart_function_argument_fill_in_wrapped_pointer(self,
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

gboolean _gdart_function_fill_argument_out(
    GdartBridgeContext *self,
    const gchar* name_prefix,
    gboolean is_caller_allocates,
    gint *c_arg_pos,
    gint gi_arg_pos,
    GITypeInfo *arg_type,
    GArgument *in_arg_cvalues,
    GArgument *out_arg_cvalues,
    gpointer  *ffi_arg_pointers,
    Dart_Handle *dart_error_out,
    GError **error)
{
    GITypeTag return_tag;
    GIArgument* gi_return_value;

    if (is_caller_allocates) {
        gsize size_of_slot;
        gpointer slot;
        size_of_slot = _gdart_function_get_array_size_multiplier_out(arg_type);
        slot = g_slice_alloc0(size_of_slot);
        in_arg_cvalues[*c_arg_pos].v_pointer = slot;
        if (ffi_arg_pointers != NULL) {
            ffi_arg_pointers[*c_arg_pos] = &in_arg_cvalues[*c_arg_pos];
            (*c_arg_pos)++;
        }
        return TRUE;
    }
    gi_return_value = &out_arg_cvalues[*c_arg_pos];
    return_tag = g_type_info_get_tag(arg_type);
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
    (*c_arg_pos)++;
    return TRUE;
}


gboolean _gdart_function_fill_argument_inout(
    GdartBridgeContext *self,
    const gchar* name_prefix,
    Dart_Handle dart_args,
    GICallableInfo *function_info,
    gboolean is_transfer_full,
    gboolean is_method,
    gint *c_arg_pos,
    gint *dart_arg_pos,
    gint gi_arg_pos,
    GIArgInfo* arg_info,
    GITypeInfo *arg_type,
    gint* suppressed_args,
    gint suppressed_args_length,
    GArgument *in_arg_cvalues,
    GArgument *out_arg_cvalues,
    GArgument *inout_original_arg_cvalues,
    gpointer  *ffi_arg_pointers,
    GdartCallbackTrampoline** trampolines,
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
        if (suppressed_args[arg_i] == -1) break;
    }
    type_tag = g_type_info_get_tag(arg_type);
    switch (type_tag) {
    case GI_TYPE_TAG_BOOLEAN:
        result = _gdart_function_argument_fill_in_boolean(
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
        result =  _gdart_function_argument_fill_in_int(self,
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
        result =  _gdart_function_argument_fill_in_num(self,
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
        result =  _gdart_function_argument_fill_in_string(self,
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
        result =  _gdart_function_argument_fill_in_array(self,
                  name_prefix,
                  dart_args,
                  dart_arg_pos,
                  arg_type,
                  function_info,
                  is_method,
                  &out_arg_cvalues[*c_arg_pos],
                  out_arg_cvalues,
                  NULL,
                  c_arg_pos,
                  dart_error_out,
                  error);
        break;
    case GI_TYPE_TAG_INTERFACE:
        result =  _gdart_function_argument_fill_in_interface(self,
                  name_prefix,
                  dart_args,
                  dart_arg_pos,
                  is_method,
                  arg_info,
                  arg_type,
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
        result = _gdart_function_argument_fill_in_wrapped_pointer(self,
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
        *dart_error_out = gdart_bridge_context_create_error_handle(self,
                          "%s: got an unexpected type", G_STRFUNC);
        g_set_error(error, GDART_ERROR, 1,
                          "%s: got an unexpected type", G_STRFUNC);
        return FALSE;
    }
    if (!result) return FALSE;
out:
    inout_original_arg_cvalues[*c_arg_pos] = out_arg_cvalues[*c_arg_pos];
    in_arg_cvalues[*c_arg_pos].v_pointer = &out_arg_cvalues[*c_arg_pos];
    ffi_arg_pointers[*c_arg_pos] = &in_arg_cvalues[*c_arg_pos];
    (*c_arg_pos)++;
    return TRUE;
}

gboolean _gdart_function_fill_argument_in(
    GdartBridgeContext *self,
    const gchar* name_prefix,
    Dart_Handle dart_args,
    GICallableInfo *function_info,
    gboolean is_transfer_full,
    gboolean is_method,
    gint *c_arg_pos,
    gint *dart_arg_pos,
    gint gi_arg_pos,
    GIArgInfo *arg_info,
    GITypeInfo *arg_type,
    gint* suppressed_args,
    gint suppressed_args_length,
    GArgument *main_argument,
    GArgument *in_arg_cvalues,
    gpointer  *ffi_arg_pointers,
    GdartCallbackTrampoline** trampolines,
    gint trampolines_length,
    Dart_Handle *dart_error_out,
    GError **error)
{
    gint arg_i = 0;
    GITypeTag type_tag;
    for (; arg_i < suppressed_args_length; arg_i++) {
        if (suppressed_args[arg_i] == -1) break;
        if (suppressed_args[arg_i] == gi_arg_pos) {
            g_assert(main_argument == &in_arg_cvalues[*c_arg_pos]);
            ffi_arg_pointers[*c_arg_pos] = main_argument;
            (*c_arg_pos)++;
            return TRUE;
        }
    }
    type_tag = g_type_info_get_tag(arg_type);
    switch (type_tag) {
    case GI_TYPE_TAG_BOOLEAN:
        return _gdart_function_argument_fill_in_boolean(
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
        return _gdart_function_argument_fill_in_int(self,
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
        return _gdart_function_argument_fill_in_num(self,
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
        return _gdart_function_argument_fill_in_string(self,
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
        return _gdart_function_argument_fill_in_array(self,
                name_prefix,
                dart_args,
                dart_arg_pos,
                arg_type,
                function_info,
                is_method,
                main_argument,
                in_arg_cvalues,
                ffi_arg_pointers,
                c_arg_pos,
                dart_error_out,
                error);
    case GI_TYPE_TAG_INTERFACE:
        return _gdart_function_argument_fill_in_interface(self,
                name_prefix,
                dart_args,
                dart_arg_pos,
                is_method,
                arg_info,
                arg_type,
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
        return _gdart_function_argument_fill_in_wrapped_pointer(self,
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
        *dart_error_out = gdart_bridge_context_create_error_handle(self,
                          "%s: got an unexpected type", G_STRFUNC);
        g_set_error(error, GDART_ERROR, 1,
                          "%s: got an unexpected type", G_STRFUNC);
        return FALSE;
    }
}

void _gdart_function_unfill_argument_in(
    GdartBridgeContext *self,
    const gchar *name_prefix,
    gboolean is_method,
    GICallableInfo *function_info,
    gint *c_arg_pos,
    gint gi_arg_pos,
    GITypeInfo *arg_type,
    gint* suppressed_args,
    gint suppressed_args_length,
    GArgument *in_arg_cvalues,
    GdartCallbackTrampoline** trampolines)
{
    gint arg_i = 0;
    GITypeTag type_tag;
    for (; arg_i < suppressed_args_length; arg_i++) {
        if (suppressed_args[arg_i] == gi_arg_pos) {
            (*c_arg_pos)++;
            return;
        }
        if (suppressed_args[arg_i] == -1) break;
    }
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
    case GI_TYPE_TAG_INTERFACE:
    case GI_TYPE_TAG_GLIST:
    case GI_TYPE_TAG_GSLIST:
    case GI_TYPE_TAG_GHASH:
    case GI_TYPE_TAG_ERROR:
        //No need to do anything for these types. Interfaces may need to be
        //revisited for functions.
        (*c_arg_pos)++;
        break;
    case GI_TYPE_TAG_UTF8:
    case GI_TYPE_TAG_FILENAME:
        _gdart_function_argument_unfill_in_string(self,
                in_arg_cvalues,
                c_arg_pos);
        break;
    case GI_TYPE_TAG_ARRAY:
        _gdart_function_argument_unfill_in_array(self,
                name_prefix,
                arg_type,
                function_info,
                in_arg_cvalues,
                is_method,
                c_arg_pos);
        break;
    default:
        g_assert_not_reached();
    }
}

gboolean _gdart_function_invoke_fill_arguments(GdartBridgeContext *self,
        const gchar* name_prefix,
        GICallableInfo *function_info,
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
        GdartCallbackTrampoline** trampolines,
        gint c_argc,
        gint gi_argc,
        gint* suppressed_args,
        gint suppressed_args_length,
        Dart_Handle *dart_error_out,
        GError **error)
{
    gint c_arg_pos = 0, gi_arg_pos = 0, dart_arg_pos = 0;

    if (is_method) {
        gchar* arg_name;
        arg_name = g_strdup_printf("%s.this",
                                   name_prefix);
        if (!_gdart_function_invoke_fill_receiver(self,
                arg_name,
                dart_receiver,
                &in_arg_cvalues[c_arg_pos],
                in_arg_cvalues,
                ffi_arg_pointers,
                dart_error_out,
                error)) {
            g_free(arg_name);
            return FALSE;
        }
        g_free(arg_name);
        c_arg_pos++;
    }

    for (gi_arg_pos = 0; gi_arg_pos < gi_argc; gi_arg_pos++) {
        GIDirection direction;
        GIArgInfo arg_info;
        gchar* arg_name;

        g_callable_info_load_arg(function_info, gi_arg_pos, &arg_info);
        arg_name = g_strdup_printf("%s.%s",
                                   name_prefix,
                                   g_base_info_get_name((GIBaseInfo*) &arg_info));
        direction = g_arg_info_get_direction(&arg_info);
        switch (direction) {
        case GI_DIRECTION_IN: {
            GITypeInfo arg_type;
            g_arg_info_load_type(&arg_info, &arg_type);
            if (!_gdart_function_fill_argument_in(self,
                                                  arg_name,
                                                  dart_args,
                                                  function_info,
                                                  g_arg_info_get_ownership_transfer(&arg_info) != GI_TRANSFER_NOTHING,
                                                  is_method,
                                                  &c_arg_pos,
                                                  &dart_arg_pos,
                                                  gi_arg_pos,
                                                  &arg_info,
                                                  &arg_type,
                                                  suppressed_args,
                                                  gi_argc,
                                                  &in_arg_cvalues[c_arg_pos],
                                                  in_arg_cvalues,
                                                  ffi_arg_pointers,
                                                  trampolines,
                                                  c_argc,
                                                  dart_error_out,
                                                  error)) {
                g_free(arg_name);
                return FALSE;
            }
            break;
        }
        case GI_DIRECTION_OUT: {
            gboolean is_caller_allocates;
            is_caller_allocates = g_arg_info_is_caller_allocates(&arg_info);

            GITypeInfo arg_type;
            g_arg_info_load_type(&arg_info, &arg_type);
            if (!_gdart_function_fill_argument_out(self,
                                                   arg_name,
                                                   is_caller_allocates,
                                                   &c_arg_pos,
                                                   gi_arg_pos,
                                                   &arg_type,
                                                   in_arg_cvalues,
                                                   out_arg_cvalues,
                                                   ffi_arg_pointers,
                                                   dart_error_out,
                                                   error)) {
                g_free(arg_name);
                return FALSE;
            }
            break;
        }
        case GI_DIRECTION_INOUT: {
            GITypeInfo arg_type;
            g_arg_info_load_type(&arg_info, &arg_type);
            if (!_gdart_function_fill_argument_inout(self,
                    arg_name,
                    dart_args,
                    function_info,
                    g_arg_info_get_ownership_transfer(&arg_info) != GI_TRANSFER_NOTHING,
                    is_method,
                    &c_arg_pos,
                    &dart_arg_pos,
                    gi_arg_pos,
                    &arg_info,
                    &arg_type,
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
                g_free(arg_name);
                return FALSE;
            }
            break;
        }
        g_free(arg_name);
        }

    }
    if (can_throw_gerror) {
		out_arg_cvalues[c_arg_pos].v_pointer = NULL;
        in_arg_cvalues[c_arg_pos].v_pointer = &out_arg_cvalues[c_arg_pos].v_pointer;
        ffi_arg_pointers[c_arg_pos] = &in_arg_cvalues[c_arg_pos];
        c_arg_pos++;
    }
    if (c_arg_pos != c_argc) {
        *dart_error_out = gdart_bridge_context_create_error_handle(self,
                          "%s: didn't fill all the arguments. What's up?", G_STRFUNC);
        g_set_error(error, GDART_ERROR, 1,
                          "%s: didn't fill all the arguments. What's up?", G_STRFUNC);
        return FALSE;
    }
    return TRUE;
}


gboolean _gdart_function_invoke_unfill_arguments(GdartBridgeContext *self,
        const gchar *name_prefix,
        GICallableInfo *function_info,
        gboolean is_method,
        gboolean can_throw_gerror,
        gboolean was_uncaught_error, //if TRUE clear all out parameters.
        //if FALSE, then dart has captured all the
        //arguments, so no need to clear memory.
        GArgument *in_arg_cvalues,
        GArgument *out_arg_cvalues,
        GArgument *inout_original_arg_cvalues,
        GdartCallbackTrampoline** trampolines,
        gint c_argc,
        gint gi_argc,
        gint* suppressed_args,
        gint suppressed_args_length)
{
    gint c_arg_pos = 0, gi_arg_pos = 0;

    if (is_method) {
        c_arg_pos++;
    }

    for (gi_arg_pos = 0; gi_arg_pos < gi_argc; gi_arg_pos++) {
        GIDirection direction;
        GIArgInfo arg_info;
        g_callable_info_load_arg(function_info, gi_arg_pos, &arg_info);
        direction = g_arg_info_get_direction(&arg_info);
        switch (direction) {
        case GI_DIRECTION_IN: {
            GITypeInfo arg_type;
            gchar *arg_name;

            g_arg_info_load_type(&arg_info, &arg_type);
            arg_name = g_strdup_printf("%s.%s",
                                       name_prefix,
                                       g_base_info_get_name((GIBaseInfo*) &arg_info));
            if (g_arg_info_get_ownership_transfer(&arg_info) == GI_TRANSFER_NOTHING) {
                // We only have to deallocate arguments if they aren't
                // transfered.
                _gdart_function_unfill_argument_in(self,
                                                   arg_name,
                                                   is_method,
                                                   function_info,
                                                   &c_arg_pos,
                                                   gi_arg_pos,
                                                   &arg_type,
                                                   suppressed_args,
                                                   gi_argc,
                                                   in_arg_cvalues,
                                                   trampolines);
            }
            break;
            g_free(arg_name);
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
    }
    if (can_throw_gerror) {
        gpointer slot;
        // slot = g_slice_alloc0(sizeof(gpointer));
        c_arg_pos++;
    }
    return TRUE;
}


void _gdart_prep_results(GdartBridgeContext *self,
                         const gchar* name_prefix,
                         GICallableInfo *function,
                         GITypeInfo* return_type,
                         gint* suppressed_args,
                         gint suppressed_args_length,
                         gint* out_argc_out,
                         gint garg_length,
                         gboolean can_throw_gerror)
{
    gint garg_i = 0;
    gint out_argc = 0;

    GITypeTag return_tag;
    return_tag = g_type_info_get_tag(return_type);
    if (return_tag == GI_TYPE_TAG_BOOLEAN && can_throw_gerror) {
        ;
    } else if (return_tag != GI_TYPE_TAG_VOID) {
        out_argc++;
    }

    for (garg_i = 0; garg_i < garg_length; garg_i++) {
        GIArgInfo arg_info;
        GITypeInfo type_info;
        g_callable_info_load_arg((GICallableInfo*) function, garg_i, &arg_info);
        if (g_arg_info_get_direction(&arg_info) == GI_DIRECTION_OUT) {
            out_argc++;
            g_arg_info_load_type(&arg_info, &type_info);
            switch (g_type_info_get_tag(&type_info)) {
            case GI_TYPE_TAG_ARRAY: {
                gint arg_to_suppress, arg_i = 0;
                arg_to_suppress = g_type_info_get_array_length(&type_info);
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
        } else if (g_arg_info_get_direction(&arg_info) == GI_DIRECTION_INOUT) {
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
    }
    (*out_argc_out) = out_argc;
}

gboolean _gdart_function_result_load_boolean_from_buffer(
    GdartBridgeContext *self,
    const gchar* name_prefix,
    gboolean is_null_terminated,
    gpointer *buffer,
    gboolean *is_end_out,
    Dart_Handle* dart_elem_out, //out
    Dart_Handle* dart_error_out,
    GError **error) //status
{
    gboolean result;
    _GDART_FUNCTION_READ_BUFFER_AND_ADVANCE(gboolean, buffer, result);
    if (is_null_terminated && result == FALSE) {
        *is_end_out = TRUE;
    } else {
        *is_end_out = FALSE;
        *dart_elem_out = Dart_NewBoolean((bool) result);
    }
    return TRUE;
}


void _gdart_function_result_load_boolean(
    GdartBridgeContext *self,
    const gchar* error_prefix,
    GIArgument *gi_return_value,
    gint* out_arg_pos_out, //in-out
    Dart_Handle* dart_out) //status
{
    gint out_arg_pos = (*out_arg_pos_out);
    gboolean result = gi_return_value->v_boolean;
    dart_out[out_arg_pos++] = Dart_NewBoolean((bool) result);
    *out_arg_pos_out = out_arg_pos;
}


gboolean _gdart_function_result_load_int_from_buffer(
    GdartBridgeContext *self,
    const gchar* name_prefix,
    gboolean is_null_terminated,
    GITypeTag type_tag,
    gpointer *buffer,
    gboolean *is_end_out,
    Dart_Handle* dart_elem_out, //out
    Dart_Handle* dart_error_out,
    GError **error) //status
{
    int64_t raw_result;
    uint64_t raw_result_64;
    gboolean result_is_zero;
    switch (type_tag) {
    case GI_TYPE_TAG_INT8:
        _GDART_FUNCTION_READ_BUFFER_AND_ADVANCE_WITH_CAST(gint8, buffer, raw_result, gint64);
        result_is_zero = raw_result == 0;
        break;
    case GI_TYPE_TAG_UINT8:
        _GDART_FUNCTION_READ_BUFFER_AND_ADVANCE_WITH_CAST(guint8, buffer, raw_result, gint64);
        result_is_zero = raw_result == 0;
        break;
    case GI_TYPE_TAG_INT16:
        _GDART_FUNCTION_READ_BUFFER_AND_ADVANCE_WITH_CAST(gint16, buffer, raw_result, gint64);
        result_is_zero = raw_result == 0;
        break;
    case GI_TYPE_TAG_UINT16:
        _GDART_FUNCTION_READ_BUFFER_AND_ADVANCE_WITH_CAST(guint16, buffer, raw_result, gint64);
        result_is_zero = raw_result == 0;
        break;
    case GI_TYPE_TAG_INT32:
        _GDART_FUNCTION_READ_BUFFER_AND_ADVANCE_WITH_CAST(gint32, buffer, raw_result, gint64);
        result_is_zero = raw_result == 0;
        break;
    case GI_TYPE_TAG_UINT32:
        _GDART_FUNCTION_READ_BUFFER_AND_ADVANCE_WITH_CAST(guint32, buffer, raw_result, gint64);
        result_is_zero = raw_result == 0;
        break;
    case GI_TYPE_TAG_INT64:
        _GDART_FUNCTION_READ_BUFFER_AND_ADVANCE(gint64, buffer, raw_result);
        result_is_zero = raw_result == 0;
        break;
    case GI_TYPE_TAG_UINT64:
        _GDART_FUNCTION_READ_BUFFER_AND_ADVANCE(guint8, buffer, raw_result_64);
        result_is_zero = raw_result_64 == 0;
        break;
    case GI_TYPE_TAG_GTYPE:
        _GDART_FUNCTION_READ_BUFFER_AND_ADVANCE_WITH_CAST(GType, buffer, raw_result_64, guint64);
        result_is_zero = raw_result_64 == 0;
        break;
    default:
        *dart_error_out = gdart_bridge_context_create_error_handle(
                              self,
                              "%s: expected an integer-like type", G_STRFUNC);
        g_set_error(error, GDART_ERROR, 1,
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
        *dart_elem_out = Dart_NewIntegerFromUint64(raw_result_64);
        break;
    default:
        *dart_elem_out = Dart_NewInteger(raw_result);
        break;
    }
    return TRUE;
}

gboolean _gdart_function_result_load_int(
    GdartBridgeContext *self,
    const gchar* name_prefix,
    GIArgument *gi_return_value,
    GITypeTag type_tag,
    gint* out_arg_pos_out, //in-out
    Dart_Handle* dart_out,
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
        *dart_error_out = gdart_bridge_context_create_error_handle(
                              self,
                              "%s: expected an integer-like type", G_STRFUNC);
        g_set_error(error, GDART_ERROR, 1,
                              "%s: expected an integer-like type", G_STRFUNC);
        goto error;
    }
    switch (type_tag) {
    case GI_TYPE_TAG_GTYPE:
    case GI_TYPE_TAG_UINT64:
        dart_out[out_arg_pos++] = Dart_NewIntegerFromUint64(result_unsigned);
        break;
    default:
        dart_out[out_arg_pos++] = Dart_NewInteger(result);
        break;
    }
    *out_arg_pos_out = out_arg_pos;
    return TRUE;
error:
    return FALSE;
}


gint _gdart_function_result_load_int_raw(
    GdartBridgeContext *self,
    const gchar* name_prefix,
    GICallableInfo *function_info,
    gint gi_arg_pos,
    GIArgument *in_arg_cvalues,
    gint c_arg_pos,
    Dart_Handle *dart_error_out, //status
    GError **error)
{
    GIArgInfo arg_info;
    GITypeInfo type_info;
    GITypeTag return_tag;
    gint64 result;
    GIArgument *gi_return_value = &in_arg_cvalues[c_arg_pos];
    g_callable_info_load_arg(function_info, gi_arg_pos, &arg_info);
    g_arg_info_load_type(&arg_info, &type_info);
    return_tag = g_type_info_get_tag(&type_info);
    switch (return_tag) {
    case GI_TYPE_TAG_BOOLEAN:
        result = (gint64) *((gint*) gi_return_value->v_pointer);
        break;
    case GI_TYPE_TAG_INT8:
        result = (gint64) *((gint8*) gi_return_value->v_pointer);
        break;
    case GI_TYPE_TAG_UINT8:
        result = (gint64) *((guint8*) gi_return_value->v_pointer);
        break;
    case GI_TYPE_TAG_INT16:
        result = (gint64) *((gint16*) gi_return_value->v_pointer);
        break;
    case GI_TYPE_TAG_UINT16:
        result = (gint64) *((guint16*) gi_return_value->v_pointer);
        break;
    case GI_TYPE_TAG_INT32:
        result = (gint64) *((gint32*) gi_return_value->v_pointer);
        break;
    case GI_TYPE_TAG_UINT32:
        result = (gint64) *((guint32*) gi_return_value->v_pointer);
        break;
    case GI_TYPE_TAG_INT64:
        result = (gint64) *((gint64*) gi_return_value->v_pointer);
        break;
    case GI_TYPE_TAG_UINT64:
        result = (gint64) *((guint64*) gi_return_value->v_pointer);
        break;
    default:
        *dart_error_out = gdart_bridge_context_create_error_handle(
                              self,
                              "%s: expected an integer-like type", G_STRFUNC);
        g_set_error(error, GDART_ERROR, 1,
                              "%s: expected an integer-like type", G_STRFUNC);
        goto error;
    }
    return result;
error:
    return -1;
}

gboolean _gdart_function_result_load_num_from_buffer(
    GdartBridgeContext *self,
    const gchar* name_prefix,
    gboolean is_null_terminated,
    GITypeTag type_tag,
    gpointer *buffer,
    gboolean *is_end_out,
    Dart_Handle* dart_elem_out, //out
    Dart_Handle* dart_error_out,
    GError **error) //status
{
    gdouble raw_result;
    gboolean result_is_zero;
    switch (type_tag) {
    case GI_TYPE_TAG_FLOAT:
        _GDART_FUNCTION_READ_BUFFER_AND_ADVANCE_WITH_CAST(gfloat, buffer, raw_result, gdouble);
        break;
    case GI_TYPE_TAG_DOUBLE:
        _GDART_FUNCTION_READ_BUFFER_AND_ADVANCE(gdouble, buffer, raw_result);
        break;
    default:
        *dart_error_out = gdart_bridge_context_create_error_handle(
                              self,
                              "%s: expected an integer-like type", G_STRFUNC);
        g_set_error(error, GDART_ERROR, 1,
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

    *dart_elem_out = Dart_NewDouble(raw_result);
    return TRUE;
}

gboolean _gdart_function_result_load_num(
    GdartBridgeContext *self,
    const gchar* name_prefix,
    GIArgument *gi_return_value,
    GITypeTag type_tag,
    gint* out_arg_pos_out, //in-out
    Dart_Handle* dart_out,
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
        *dart_error_out = gdart_bridge_context_create_error_handle(
                              self,
                              "%s: expected an integer-like type", G_STRFUNC);
        g_set_error(error, GDART_ERROR, 1,
                              "%s: expected an integer-like type", G_STRFUNC);
        goto error;
    }
    dart_out[out_arg_pos++] = Dart_NewDouble(result);
    *out_arg_pos_out = out_arg_pos;
    return TRUE;
error:
    return FALSE;
}

gboolean _gdart_function_result_load_string_from_buffer(
    GdartBridgeContext *self,
    const gchar* name_prefix,
    gboolean is_null_terminated,
    GITypeTag type_tag,
    gboolean deallocate_members,
    gpointer *buffer,
    gboolean *is_end_out,
    Dart_Handle* dart_elem_out, //out
    Dart_Handle* dart_error_out,
    GError **error) //status
{
    gchar *raw_result, *utf8result;
    gsize bytes_read, bytes_written;
    GError* inner_error = NULL;
    gintptr result_length;
    _GDART_FUNCTION_READ_BUFFER_AND_ADVANCE(gchar*, buffer, raw_result);
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
        utf8result = g_filename_to_utf8(raw_result, -1, &bytes_read,
                                        &bytes_written,
                                        &inner_error);
        if (utf8result == NULL) {
            *dart_error_out = gdart_bridge_context_create_error_handle(
                                  self,
                                  "%s",
                                  inner_error->message);
            g_propagate_error(error, inner_error);
            return FALSE;
        }
        if (deallocate_members) {
            g_free(raw_result);
        }
        deallocate_members = TRUE;
    default:
        *dart_error_out = gdart_bridge_context_create_error_handle(
                              self,
                              "%s: expected an integer-like type", G_STRFUNC);
        g_set_error(error, GDART_ERROR, 1,
                              "%s: expected an integer-like type", G_STRFUNC);
        return FALSE;
    }
    result_length = g_utf8_strlen(utf8result, -1);
    *dart_elem_out = Dart_NewStringFromUTF8((guint8*) utf8result, result_length);
    if (deallocate_members) {
        g_free(utf8result);
    }
    return TRUE;
}

gboolean _gdart_function_result_load_string(
    GdartBridgeContext *self,
    const gchar* name_prefix,
    GIArgument *gi_return_value,
    GITransfer transfer,
    GITypeTag type_tag,
    gint* out_arg_pos_out, //in-out
    Dart_Handle* dart_out,
    Dart_Handle *dart_error_out, //status
    GError **error)
{
    gint out_arg_pos = (*out_arg_pos_out);
    gchar *result, *result_filename;
    gboolean deallocate = FALSE;
    gsize bytes_read, bytes_written;
    GError* inner_error = NULL;
    gintptr codepoints;
    if (transfer == GI_TRANSFER_EVERYTHING) {
        deallocate = TRUE;
    }
    switch (type_tag) {
    case GI_TYPE_TAG_UTF8:
        result = (gchar*) gi_return_value->v_string;
        if (result == NULL) goto null_out;
        break;
    case GI_TYPE_TAG_FILENAME:
        result_filename = (gchar*) gi_return_value->v_string;
        if (result_filename == NULL) goto null_out;
        result = g_filename_to_utf8(result_filename,
                                    -1,
                                    &bytes_read,
                                    &bytes_written,
                                    &inner_error);
        if (result == NULL) {
            *dart_error_out = gdart_bridge_context_create_error_handle(
                                  self,
                                  "%s",
                                  inner_error->message);
            g_propagate_error(error, inner_error);
            return FALSE;
        }
        if (deallocate) {
            g_free(result_filename);
        }
        deallocate = TRUE;
        break;
    default:
        *dart_error_out = gdart_bridge_context_create_error_handle(
                              self,
                              "%s: expected an integer-like type", G_STRFUNC);
        g_set_error(error, GDART_ERROR, 1,
                              "%s: expected an integer-like type", G_STRFUNC);
        goto error;
    }
    codepoints = (gintptr) g_utf8_strlen(result, -1);
    dart_out[out_arg_pos++] = Dart_NewStringFromUTF8((guint8*) result, codepoints);
    if (deallocate) {
        g_free(result);
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


gboolean _gdart_function_result_load_enum_from_buffer(GdartBridgeContext *self,
        const gchar* name_prefix,
        GIEnumInfo *base_info,
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

    type_tag = g_enum_info_get_storage_type(base_info);
    if (!_gdart_function_result_load_int_from_buffer(self,
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
    wrapper = gdart_bridge_context_retrieve_wrapping_class(
                  self,
                  g_base_info_get_namespace((GIBaseInfo*) base_info),
                  g_registered_type_info_get_g_type((GIRegisteredTypeInfo*) base_info),
                  base_info,
                  TRUE,
                  dart_error_out,
                  error);
    if (wrapper == NULL) return FALSE;
    result = Dart_New(wrapper, Dart_Null(), 1, &value);
    if (Dart_IsError(result)) {
		g_warning("%s: dart threw an error", name_prefix);
        *dart_error_out = result;
        g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
        return FALSE;
    }
    *dart_out = result;
    *is_end_out = FALSE;
    return TRUE;
}


gboolean _gdart_function_result_load_wrapped_pointer_from_buffer(
    GdartBridgeContext *self,
    const gchar* name_prefix,
    gboolean is_null_terminated,
    GIRegisteredTypeInfo* registered_type_info, //heap allocated
    GIInfoType info_type,
    gboolean must_copy,
    gpointer *buffer,
    gboolean *is_end_out,
    Dart_Handle *dart_elem_out,
    Dart_Handle *dart_error_out, //status
    GError **error)
{
    const gchar* namespace;
    GType gtype;
    gpointer raw_result;
    GdartBridgeContextWrappedObject* object_wrapper;
    Dart_Handle internal_container, wrapped_object;
    GIRegisteredTypeInfo *type_info = NULL;
    _GDART_FUNCTION_READ_BUFFER_AND_ADVANCE(gpointer, buffer, raw_result);

    if (raw_result == NULL && is_null_terminated) {
        *is_end_out = TRUE;
        return TRUE;
    } else if (raw_result == NULL) {
        *dart_elem_out = Dart_Null();
        *is_end_out = FALSE;
        return TRUE;
    }

    object_wrapper = g_slice_new(GdartBridgeContextWrappedObject);
    gtype = g_registered_type_info_get_g_type(registered_type_info);

    if ((info_type == GI_INFO_TYPE_OBJECT && g_type_is_a(gtype, G_TYPE_OBJECT))
        || (info_type == GI_INFO_TYPE_INTERFACE)) {
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
                                                g_base_info_get_namespace((GIBaseInfo*) registered_type_info),
                                                (GIBaseInfo*) registered_type_info,
                                                gtype);
        if (must_copy) {
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
        } else {
            object_wrapper->object = raw_result;
			if (object_wrapper->copy_func == NULL) {
                internal_container = gdart_bridge_context_wrap_pointer(self,
                                     object_wrapper,
                                     gdart_bridge_context_finalize_wrapped_struct,
                                     dart_error_out,
                                     error);
            } else {
                internal_container = gdart_bridge_context_wrap_pointer(self,
                                     object_wrapper,
                                     gdart_bridge_context_finalize_wrapped_custom_struct,
                                     dart_error_out,
                                     error);
			}
        }
        break;
    case GI_INFO_TYPE_BOXED:
        if (must_copy) {
            raw_result = g_boxed_copy(gtype, raw_result);
        }
        object_wrapper->object = raw_result;
        internal_container = gdart_bridge_context_wrap_pointer(self,
                             object_wrapper,
                             gdart_bridge_context_finalize_wrapped_boxed,
                             dart_error_out,
                             error);
        break;
    case GI_INFO_TYPE_INTERFACE:
    case GI_INFO_TYPE_OBJECT:
        if (must_copy) {
            GIObjectInfoRefFunction refer;
            refer = g_object_info_get_ref_function_pointer((GIObjectInfo*) object_wrapper->object_info);
            if (refer != NULL) {
                raw_result = refer(raw_result);
            } else {
                raw_result = g_object_ref_sink(raw_result);
                //if this is the main result, assume we are given a floating reference.
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
        return FALSE;
    }
    namespace = g_base_info_get_namespace((GIBaseInfo*) registered_type_info);
    wrapped_object = gdart_bridge_context_wrap_internal_pointer(self,
                     internal_container,
                     namespace,
                     gtype,
                     (GIBaseInfo*) registered_type_info,
                     dart_error_out,
                     error);
    if (wrapped_object == NULL) {
        return FALSE;
    }
    *dart_elem_out = wrapped_object;
    *is_end_out = FALSE;
    return TRUE;
}

gboolean _gdart_function_result_load_interface_from_buffer(
    GdartBridgeContext *self,
    const gchar* name_prefix,
    gboolean is_null_terminated,
    GITypeInfo *type_info,
    gboolean must_copy,
    gpointer *buffer,
    gboolean *is_end_out,
    Dart_Handle *dart_elem_out,
    Dart_Handle *dart_error_out, //status
    GError **error)
{
    GIBaseInfo* base_info;
    GIInfoType info_type;
    gboolean result;

    base_info = g_type_info_get_interface(type_info); //heap allocated
    info_type = g_base_info_get_type(base_info);
    switch (info_type) {
    case GI_INFO_TYPE_CALLBACK:
        *dart_error_out = gdart_bridge_context_create_error_handle(self,
                          "%s: can't handle callbacks yet", G_STRFUNC);
        g_set_error(error, GDART_ERROR, 1,
                          "%s: can't handle callbacks yet", G_STRFUNC);
        g_base_info_unref(base_info);
        return FALSE;
    case GI_INFO_TYPE_STRUCT:
    case GI_INFO_TYPE_BOXED:
    case GI_INFO_TYPE_UNION:
    case GI_INFO_TYPE_OBJECT: {
        result = _gdart_function_result_load_wrapped_pointer_from_buffer(self,
                 name_prefix,
                 is_null_terminated,
                 (GIRegisteredTypeInfo*) base_info,
                 info_type,
                 must_copy,
                 buffer,
                 is_end_out,
                 dart_elem_out,
                 dart_error_out,
                 error);
        g_base_info_unref(base_info);
        return result;
        case GI_INFO_TYPE_ENUM:
        case GI_INFO_TYPE_FLAGS:
            result = _gdart_function_result_load_enum_from_buffer(self,
                     name_prefix,
                     (GIEnumInfo *) base_info,
                     is_null_terminated,
                     buffer,
                     is_end_out,
                     dart_elem_out,
                     dart_error_out,
                     error);
            g_base_info_unref(base_info);
            return result;
        case GI_INFO_TYPE_INTERFACE:
            *dart_error_out = gdart_bridge_context_create_error_handle(self,
                              "%s: can't handle interfaces yet", G_STRFUNC);
            g_set_error(error, GDART_ERROR, 1,
                              "%s: can't handle interfaces yet", G_STRFUNC);
            g_base_info_unref(base_info);
            return FALSE;
        default:
            *dart_error_out = gdart_bridge_context_create_error_handle(self,
                              "%s: received an unexpected base info type", G_STRFUNC);
            g_set_error(error, GDART_ERROR, 1,
                              "%s: received an unexpected base info type", G_STRFUNC);
            g_base_info_unref(base_info);
            return FALSE;
        }
    }
}


gboolean _gdart_function_result_load_wrapped_pointer_with_g_type_from_buffer(
    GdartBridgeContext *self,
    const gchar* name_prefix,
    gboolean is_null_terminated,
    GType gtype,
    gboolean is_boxed_type,
    GIRegisteredTypeInfo* registered_type_info, //heap allocated
    gboolean must_copy,
    gpointer *buffer,
    gboolean *is_end_out,
    Dart_Handle *dart_elem_out,
    Dart_Handle *dart_error_out, //status
    GError **error)
{
    const gchar* namespace;
    gpointer raw_result;
    GdartBridgeContextWrappedObject* object_wrapper;
    Dart_Handle internal_container, wrapped_object;
    _GDART_FUNCTION_READ_BUFFER_AND_ADVANCE(gpointer, buffer, raw_result);

    if (raw_result == NULL && is_null_terminated) {
        *is_end_out = TRUE;
        return TRUE;
    } else if (raw_result == NULL) {
        *dart_elem_out = Dart_Null();
        *is_end_out = FALSE;
        return TRUE;
    }

    object_wrapper = g_slice_new(GdartBridgeContextWrappedObject);

    object_wrapper->type = gtype;
    if (registered_type_info != NULL) {
        object_wrapper->object_info = g_base_info_ref((GIBaseInfo*) registered_type_info);
    } else {
        object_wrapper->object_info = NULL;
    }
    object_wrapper->copy_func = (GBoxedCopyFunc)
                                gdart_bridge_context_retrieve_copy_func(self,
                                                g_base_info_get_namespace((GIBaseInfo*) registered_type_info),
                                                (GIBaseInfo*) registered_type_info,
                                                gtype);

    object_wrapper->free_func = (GBoxedFreeFunc)
                                gdart_bridge_context_retrieve_free_func(self,
                                                g_base_info_get_namespace((GIBaseInfo*) registered_type_info),
                                                (GIBaseInfo*) registered_type_info,
                                                gtype);

    if (must_copy && is_boxed_type) {
        object_wrapper->object = g_boxed_copy(gtype, raw_result);
        internal_container = gdart_bridge_context_wrap_pointer(self,
                             object_wrapper,
                             gdart_bridge_context_finalize_wrapped_boxed,
                             dart_error_out,
                             error);
    } else if (must_copy) {
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
    } else {
        object_wrapper->object = raw_result;
        if (object_wrapper->copy_func == NULL) {
            internal_container = gdart_bridge_context_wrap_pointer(self,
                                 object_wrapper,
                                 gdart_bridge_context_finalize_wrapped_struct,
                                 dart_error_out,
                                 error);
        } else {
            internal_container = gdart_bridge_context_wrap_pointer(self,
                                 object_wrapper,
                                 gdart_bridge_context_finalize_wrapped_custom_struct,
                                 dart_error_out,
                                 error);
        }
    }
    if (internal_container == NULL) {
        return FALSE;
    }
    namespace = g_base_info_get_namespace((GIBaseInfo*) registered_type_info);
    wrapped_object = gdart_bridge_context_wrap_internal_pointer(self,
                     internal_container,
                     namespace,
                     gtype,
                     (GIBaseInfo*) registered_type_info,
                     dart_error_out,
                     error);
    if (wrapped_object == NULL) {
        return FALSE;
    }
    *dart_elem_out = wrapped_object;
    *is_end_out = FALSE;
    return TRUE;
}



gboolean _gdart_function_load_array_element(
    GdartBridgeContext *self,
    const gchar* name_prefix,
    GITypeInfo *param_type,
    gboolean is_null_terminated,
    gboolean deallocate_members,
    gpointer *buffer,
    gboolean *is_end,
    Dart_Handle *dart_elem_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
    GITypeTag type_tag;
    type_tag = g_type_info_get_tag(param_type);
    switch (type_tag) {
    case GI_TYPE_TAG_BOOLEAN:
        return _gdart_function_result_load_boolean_from_buffer(self,
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
        return _gdart_function_result_load_int_from_buffer(self,
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
        return _gdart_function_result_load_num_from_buffer(self,
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
        return _gdart_function_result_load_string_from_buffer(self,
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
        return _gdart_function_result_load_interface_from_buffer(self,
                name_prefix,
                is_null_terminated,
                param_type,
                !deallocate_members,
                buffer,
                is_end,
                dart_elem_out,
                dart_error_out,
                error);
    case GI_TYPE_TAG_GLIST:
        return _gdart_function_result_load_wrapped_pointer_with_g_type_from_buffer(
                   self,
                   name_prefix,
                   is_null_terminated,
                   G_DART_COMPAT_LIST_TYPE,
                   FALSE,
                   NULL,
                   !deallocate_members,
                   buffer,
                   is_end,
                   dart_elem_out,
                   dart_error_out,
                   error);

    case GI_TYPE_TAG_GSLIST:
        return _gdart_function_result_load_wrapped_pointer_with_g_type_from_buffer(
                   self,
                   name_prefix,
                   is_null_terminated,
                   G_DART_COMPAT_SLIST_TYPE,
                   FALSE,
                   NULL,
                   !deallocate_members,
                   buffer,
                   is_end,
                   dart_elem_out,
                   dart_error_out,
                   error);
    case GI_TYPE_TAG_GHASH: {
        GIRegisteredTypeInfo* type_info;
        gboolean result;

        type_info = (GIRegisteredTypeInfo*) g_irepository_find_by_gtype(
                        gdart_bridge_context_get_gi_repository(self),
                        G_TYPE_HASH_TABLE); //heap allocated
        result = _gdart_function_result_load_wrapped_pointer_with_g_type_from_buffer(
                     self,
                     name_prefix,
                     is_null_terminated,
                     G_TYPE_HASH_TABLE,
                     TRUE,
                     type_info,
                     !deallocate_members,
                     buffer,
                     is_end,
                     dart_elem_out,
                     dart_error_out,
                     error);
        g_base_info_unref((GIBaseInfo*) type_info);
        return result;
    }
    case GI_TYPE_TAG_ERROR: {
        GIRegisteredTypeInfo* type_info;
        gboolean result;

        type_info = (GIRegisteredTypeInfo*) g_irepository_find_by_gtype(
                        gdart_bridge_context_get_gi_repository(self),
                        G_TYPE_ERROR); //heap allocated
        result = _gdart_function_result_load_wrapped_pointer_with_g_type_from_buffer(
                     self,
                     name_prefix,
                     is_null_terminated,
                     G_TYPE_ERROR,
                     TRUE,
                     type_info,
                     !deallocate_members,
                     buffer,
                     is_end,
                     dart_elem_out,
                     dart_error_out,
                     error);
        g_base_info_unref((GIBaseInfo*) type_info);
        return result;
    }
    default:
        *dart_error_out = gdart_bridge_context_create_error_handle(self,
                          "%s: got an unexpected type", G_STRFUNC);
        g_set_error(error, GDART_ERROR, 1,
                          "%s: got an unexpected type", G_STRFUNC);
        return FALSE;
    }
}

gboolean _gdart_function_load_array_parameters(
    GdartBridgeContext *self,
    const gchar* name_prefix,
    GITypeInfo *param_type,
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
    Dart_Handle* list_elements;
    Dart_Handle dart_list;
    initial_length = is_null_terminated ? 32 : length;

    list_elements = g_new(Dart_Handle, initial_length);

    for (; is_null_terminated || elem_i < length; elem_i++) {
        Dart_Handle* dart_elem_out;
        gboolean is_at_end;
        if (elem_i >= initial_length) {
            initial_length *= 2;
            list_elements = g_renew(Dart_Handle, list_elements, initial_length);
        }
        dart_elem_out = &list_elements[elem_i];
        if (!_gdart_function_load_array_element(self,
                                                name_prefix,
                                                param_type,
                                                is_null_terminated,
                                                deallocate_members,
                                                &buffer,
                                                &is_at_end,
                                                dart_elem_out,
                                                dart_error_out,
                                                error)) {
            g_free(list_elements);
            return FALSE;
        }
        if (is_at_end) break;
    }
    dart_list = Dart_NewList(elem_i);
    for (elem_i--; elem_i >= 0; elem_i--) {
        Dart_ListSetAt(dart_list, elem_i, list_elements[elem_i]);
    }
    g_free(list_elements);
    *dart_list_out = dart_list;
    return TRUE;
}

gboolean _gdart_function_result_load_array(
    GdartBridgeContext *self,
    const gchar* name_prefix,
    GICallableInfo* function_info,
    gboolean is_method,
    GIArgument *gi_return_value,
    GIArgument *in_arg_cvalues,
    GITypeInfo *type_info,
    GITransfer transfer,
    gint* out_arg_pos_out, //in-out
    Dart_Handle *dart_out,
    Dart_Handle *dart_error_out, //status
    GError **error)
{
    gint out_arg_pos = (*out_arg_pos_out);

    gpointer result;
    gboolean deallocate = FALSE, deallocate_members = FALSE,
             is_null_terminated = FALSE;
    gint64 length;
    gint length_parameter;
    GITypeInfo *param_type;
    Dart_Handle dart_list;

    if (transfer == GI_TRANSFER_EVERYTHING) {
        deallocate = TRUE;
        deallocate_members = TRUE;
    } else if (transfer == GI_TRANSFER_CONTAINER) {
        deallocate = TRUE;
    }

    result = gi_return_value->v_pointer;
    length_parameter = g_type_info_get_array_length(type_info);

    if (length_parameter != -1) {
        gint length_parameter_c;
        if (is_method) {
            length_parameter_c = length_parameter + 1;
        } else {
            length_parameter_c = length_parameter;
        }
        length = _gdart_function_result_load_int_raw(self,
                 name_prefix,
                 function_info,
                 length_parameter,
                 in_arg_cvalues,
                 length_parameter_c,
                 dart_error_out,
                 error);
        if (length == -1) {
            return FALSE;
        }
    } else if (g_type_info_is_zero_terminated(type_info)) {
        length = -1;
        is_null_terminated = TRUE;
    } else {
        length = g_type_info_get_array_fixed_size(type_info);
        if (length == -1) {
            return FALSE;
        }
    }
    param_type = g_type_info_get_param_type(type_info, 0);
    if (!_gdart_function_load_array_parameters(self,
            name_prefix,
            param_type,
            length,
            is_null_terminated,
            deallocate_members,
            result,
            &dart_list,
            dart_error_out,
            error)) {
        g_base_info_unref((GIBaseInfo*) param_type);
        return FALSE;
    }
    dart_out[out_arg_pos++] = dart_list;
    g_base_info_unref((GIBaseInfo*) param_type);
    if (deallocate) {
        g_free(result);
    }
    *out_arg_pos_out = out_arg_pos;
    return TRUE;
}

gboolean _gdart_function_result_load_wrapped_pointer(
    GdartBridgeContext *self,
    const gchar* name_prefix,
    GICallableInfo* function_info,
    gboolean is_method,
    gboolean must_copy,
    gboolean is_user_allocated,
    gboolean is_main,
    GIArgument *gi_return_value,
    GIArgument *gi_return_value_user_allocated,
    GIArgument *in_arg_cvalues,
    GIRegisteredTypeInfo *registered_type_info, //heap allocated
    GIInfoType info_type,
    gint* out_arg_pos_out, //in-out
    Dart_Handle *dart_out,
    Dart_Handle *dart_error_out, //status
    GError **error)
{
    gint out_arg_pos = (*out_arg_pos_out);
    const gchar* namespace;
    GType gtype;
    gpointer raw_result;
    GdartBridgeContextWrappedObject* object_wrapper;
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
        if (must_copy) {
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
        } else {
            object_wrapper->object = raw_result;
			if (object_wrapper->copy_func == NULL) {
                internal_container = gdart_bridge_context_wrap_pointer(self,
                                     object_wrapper,
                                     gdart_bridge_context_finalize_wrapped_struct,
                                     dart_error_out,
                                     error);
            } else {
                internal_container = gdart_bridge_context_wrap_pointer(self,
                                     object_wrapper,
                                     gdart_bridge_context_finalize_wrapped_custom_struct,
                                     dart_error_out,
                                     error);
			}
        }
        break;
    case GI_INFO_TYPE_BOXED:
        if (must_copy) {
            raw_result = g_boxed_copy(gtype, raw_result);
        }
        object_wrapper->object = raw_result;
        internal_container = gdart_bridge_context_wrap_pointer(self,
                             object_wrapper,
                             gdart_bridge_context_finalize_wrapped_boxed,
                             dart_error_out,
                             error);
        break;
    case GI_INFO_TYPE_OBJECT:
    case GI_INFO_TYPE_INTERFACE:
        if (must_copy && !is_main) {
            GIObjectInfoRefFunction refer;
            refer = g_object_info_get_ref_function_pointer((GIObjectInfo*) object_wrapper->object_info);
            if (refer != NULL) {
                raw_result = refer(raw_result);
            } else {
                raw_result = g_object_ref(raw_result);
            }
        } else if (must_copy) {
            GIObjectInfoRefFunction refer;
            refer = g_object_info_get_ref_function_pointer((GIObjectInfo*) object_wrapper->object_info);
            if (refer != NULL) {
                raw_result = refer(raw_result);
            } else {
                raw_result = g_object_ref_sink(raw_result);
                //if this is the main result, assume we are given a floating reference.
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
        return FALSE;
    }
    namespace = g_base_info_get_namespace((GIBaseInfo*) registered_type_info);
    wrapped_object = gdart_bridge_context_wrap_internal_pointer(self,
                     internal_container,
                     namespace,
                     gtype,
                     (GIBaseInfo*) registered_type_info,
                     dart_error_out,
                     error);
    if (wrapped_object == NULL) {
        return FALSE;
    }
    dart_out[out_arg_pos++] = wrapped_object;
    *out_arg_pos_out = out_arg_pos;
    return TRUE;
}


gboolean _gdart_function_result_load_wrapped_pointer_with_g_error(
    GdartBridgeContext *self,
    const gchar* name_prefix,
    gboolean must_copy,
    GIArgument *gi_return_value,
    gint* out_arg_pos_out, //in-out
    Dart_Handle *dart_out,
    Dart_Handle *dart_error_out, //status
    GError **error) {
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
    error_to_throw = (GError*) raw_result;
    result = gdart_bridge_context_wrap_class_for_error(self,
                                                       error_to_throw->domain,
                                                       error_to_throw->code,
                                                       error_to_throw->message,
                                                       dart_error_out,
                                                       error);
    if (!must_copy) {
		g_error_free(error_to_throw);
	}
	if (result == NULL) return FALSE;

    dart_out[out_arg_pos++] = result;
    *out_arg_pos_out = out_arg_pos;
    return TRUE;
}

gboolean _gdart_function_result_load_wrapped_pointer_with_g_type(
    GdartBridgeContext *self,
    const gchar* name_prefix,
    gboolean must_copy,
    GIArgument *gi_return_value,
    GType gtype,
    gboolean is_boxed_type,
    GIRegisteredTypeInfo *registered_type_info, // or NULL for a List or SList, heap allocted
    gint* out_arg_pos_out, //in-out
    Dart_Handle *dart_out,
    Dart_Handle *dart_error_out, //status
    GError **error)
{
    gint out_arg_pos = (*out_arg_pos_out);
    const gchar* namespace;
    gpointer raw_result;
    GdartBridgeContextWrappedObject* object_wrapper;
    Dart_Handle internal_container, wrapped_object;
    if (gtype == G_TYPE_ERROR) {
		return _gdart_function_result_load_wrapped_pointer_with_g_error(
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

    object_wrapper = g_slice_new(GdartBridgeContextWrappedObject);
    if (registered_type_info != NULL) {
        object_wrapper->object_info = g_base_info_ref((GIBaseInfo*) registered_type_info);
    } else {
        object_wrapper->object_info = NULL;
    }


    object_wrapper->copy_func = (GBoxedCopyFunc)
                                gdart_bridge_context_retrieve_copy_func(self,
                                            g_base_info_get_namespace((GIBaseInfo*) object_wrapper->object_info),
                                            (GIBaseInfo*) registered_type_info,
                                            gtype);
    object_wrapper->free_func = (GBoxedFreeFunc)
                                gdart_bridge_context_retrieve_free_func(self,
                                            g_base_info_get_namespace((GIBaseInfo*) registered_type_info),
                                            (GIBaseInfo*) registered_type_info,
                                            gtype);
    if (must_copy && is_boxed_type) {
        object_wrapper->object = g_boxed_copy(gtype, raw_result);
        internal_container = gdart_bridge_context_wrap_pointer(self,
                             object_wrapper,
                             gdart_bridge_context_finalize_wrapped_boxed,
                             dart_error_out,
                             error);
    } else if (must_copy) {
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
    } else {
        object_wrapper->object = raw_result;
        if (object_wrapper->copy_func == NULL) {
            internal_container = gdart_bridge_context_wrap_pointer(self,
                                 object_wrapper,
                                 gdart_bridge_context_finalize_wrapped_struct,
                                 dart_error_out,
                                 error);
        } else {
            internal_container = gdart_bridge_context_wrap_pointer(self,
                                 object_wrapper,
                                 gdart_bridge_context_finalize_wrapped_custom_struct,
                                 dart_error_out,
                                 error);
        }
    }
    if (internal_container == NULL) {
        return FALSE;
    }
    if (registered_type_info != NULL) {
        namespace = g_base_info_get_namespace((GIBaseInfo*) registered_type_info);
    } else {
        namespace = "Base";
    }
    wrapped_object = gdart_bridge_context_wrap_internal_pointer(self,
                     internal_container,
                     namespace,
                     gtype,
                     (GIBaseInfo*) registered_type_info,
                     dart_error_out,
                     error);
    if (wrapped_object == NULL) {
        return FALSE;
    }
    dart_out[out_arg_pos++] = wrapped_object;
    *out_arg_pos_out = out_arg_pos;
    return TRUE;
}


gboolean _gdart_function_result_load_enum(GdartBridgeContext *self,
        const gchar* name_prefix,
        GIArgument *gi_return_value,
        GIEnumInfo *base_info,
        gint* out_arg_pos_out,
        Dart_Handle *dart_out,
        Dart_Handle *dart_error_out,
        GError **error)
{
    GITypeTag type_tag;
    Dart_Handle value, wrapper, result;
    gint index = 0, out_arg_pos;

    out_arg_pos = *out_arg_pos_out;

    type_tag = g_enum_info_get_storage_type(base_info);
    if (!_gdart_function_result_load_int(self, name_prefix, gi_return_value, type_tag,
                                         &index, &value, dart_error_out,
                                         error)) {
        return FALSE;
    }
    wrapper = gdart_bridge_context_retrieve_wrapping_class(
                  self,
                  g_base_info_get_namespace((GIBaseInfo*) base_info),
                  g_registered_type_info_get_g_type((GIRegisteredTypeInfo*) base_info),
                  base_info,
                  TRUE,
                  dart_error_out,
                  error);
    if (wrapper == NULL) return FALSE;
    result = Dart_New(wrapper, Dart_Null(), 1, &value);
    if (Dart_IsError(result)) {
		g_warning("%s: dart threw an error", name_prefix);
        *dart_error_out = result;
        g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
        return FALSE;
    }
    dart_out[out_arg_pos++] = result;
    *out_arg_pos_out = out_arg_pos;
    return TRUE;
}


gboolean _gdart_function_result_load_interface(
    GdartBridgeContext *self,
    const gchar* name_prefix,
    GICallableInfo* function_info,
    gboolean is_method,
    gboolean is_user_allocated,
    gboolean is_main,
    GIArgument *gi_return_value,
    GIArgument *gi_return_value_user_allocated,
    GIArgument *in_arg_cvalues,
    GITypeInfo *type_info,
    GITransfer transfer,
    gint* out_arg_pos_out, //in-out
    Dart_Handle *dart_out,
    Dart_Handle *dart_error_out, //status
    GError **error)
{
    GIBaseInfo* base_info;
    gboolean make_copy = TRUE, result;
    GIInfoType info_type;

    base_info = g_type_info_get_interface(type_info); //heap allocated
    if (transfer == GI_TRANSFER_EVERYTHING || transfer == GI_TRANSFER_CONTAINER) {
        make_copy = FALSE;
    }
    info_type = g_base_info_get_type(base_info);
    switch (info_type) {
    case GI_INFO_TYPE_CALLBACK:
        //TODO: handle callbacks.
        *dart_error_out = gdart_bridge_context_create_error_handle(self,
                          "%s: can't handle callbacks yet", G_STRFUNC);
        g_set_error(error, GDART_ERROR, 1,
                          "%s: can't handle callbacks yet", G_STRFUNC);
        g_base_info_unref(base_info);
        return FALSE;
    case GI_INFO_TYPE_STRUCT:
    case GI_INFO_TYPE_BOXED:
    case GI_INFO_TYPE_UNION:
    case GI_INFO_TYPE_INTERFACE:
    case GI_INFO_TYPE_OBJECT: {
        result = _gdart_function_result_load_wrapped_pointer(self,
                 name_prefix,
                 function_info,
                 is_method,
                 make_copy,
                 is_user_allocated,
                 is_main,
                 gi_return_value,
                 gi_return_value_user_allocated,
                 in_arg_cvalues,
                 (GIRegisteredTypeInfo *) base_info,
                 info_type,
                 out_arg_pos_out,
                 dart_out,
                 dart_error_out,
                 error);
        g_base_info_unref(base_info);
        return result;
        case GI_INFO_TYPE_ENUM:
        case GI_INFO_TYPE_FLAGS:
            result = _gdart_function_result_load_enum(self,
                     name_prefix,
                     gi_return_value,
                     (GIEnumInfo *) base_info,
                     out_arg_pos_out,
                     dart_out,
                     dart_error_out,
                     error);
            g_base_info_unref(base_info);
            return result;
        default:
            *dart_error_out = gdart_bridge_context_create_error_handle(self,
                              "%s: received an unexpected base info type", G_STRFUNC);
            g_set_error(error, GDART_ERROR, 1,
                              "%s: received an unexpected base info type", G_STRFUNC);
            return FALSE;
        }
    }
}


gboolean _gdart_function_result_load_return(
    GdartBridgeContext *self,
    const gchar* name_prefix,
    GICallableInfo *function_info,
    GIArgInfo* arg_info, // or NULL if examining the main argument
    gboolean is_method,
    gboolean can_throw_gerror,
    gboolean is_main_return,
    GArgument *in_arg_cvalues,
    GArgument *out_arg_cvalues,
    GArgument *inout_original_arg_cvalues,
    GIFFIReturnValue *gi_return_value,
    GIFFIReturnValue *gi_return_value_user_allocated,
    GITypeInfo* return_type,
    gint* out_arg_pos_out, //in-out
    Dart_Handle* dart_out, //out caller-allocates
    gint out_argc,
    Dart_Handle *dart_error_out, //status
    GError **error) //status
{
    GITypeTag return_tag;
    GITransfer transfer;
    gboolean is_user_allocated = FALSE;
    return_tag = g_type_info_get_tag(return_type);
    if (arg_info == NULL) {
        transfer = g_callable_info_get_caller_owns(function_info);
    } else {
        transfer = g_arg_info_get_ownership_transfer(arg_info);
        is_user_allocated = g_arg_info_is_caller_allocates(arg_info);
    }
    switch (return_tag) {
    case GI_TYPE_TAG_VOID:
        return TRUE; //no change;
    case GI_TYPE_TAG_BOOLEAN:
        if (can_throw_gerror)
            return TRUE;
        _gdart_function_result_load_boolean(self,
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
        return _gdart_function_result_load_int(self,
                                               name_prefix,
                                               gi_return_value,
                                               return_tag,
                                               out_arg_pos_out,
                                               dart_out,
                                               dart_error_out,
                                               error);
    case GI_TYPE_TAG_FLOAT:
    case GI_TYPE_TAG_DOUBLE:
        return _gdart_function_result_load_num(self,
                                               name_prefix,
                                               gi_return_value,
                                               return_tag,
                                               out_arg_pos_out,
                                               dart_out,
                                               dart_error_out,
                                               error);
    case GI_TYPE_TAG_UTF8:
    case GI_TYPE_TAG_FILENAME:
        return _gdart_function_result_load_string(self,
                name_prefix,
                gi_return_value,
                transfer,
                return_tag,
                out_arg_pos_out,
                dart_out,
                dart_error_out,
                error);
    case GI_TYPE_TAG_ARRAY:
        return _gdart_function_result_load_array(self,
                name_prefix,
                function_info,
                is_method,
                gi_return_value,
                in_arg_cvalues,
                return_type,
                transfer,
                out_arg_pos_out,
                dart_out,
                dart_error_out,
                error);
    case GI_TYPE_TAG_INTERFACE:
        return _gdart_function_result_load_interface(self,
                name_prefix,
                function_info,
                is_method,
                is_user_allocated,
                (arg_info != NULL),
                gi_return_value,
                gi_return_value_user_allocated,
                in_arg_cvalues,
                return_type,
                transfer,
                out_arg_pos_out,
                dart_out,
                dart_error_out,
                error);
    case GI_TYPE_TAG_GLIST:
        //I'm sure there's some kind of problem here. Transfering GLists is
        //bound to create issues.
        return _gdart_function_result_load_wrapped_pointer_with_g_type(
                   self,
                   name_prefix,
                   (transfer == GI_TRANSFER_NOTHING),
                   gi_return_value,
                   G_DART_COMPAT_LIST_TYPE,
                   FALSE,
                   NULL,
                   out_arg_pos_out,
                   dart_out,
                   dart_error_out,
                   error);
    case GI_TYPE_TAG_GSLIST:
        //I'm sure there's some kind of problem here. Transfering GLists is
        //bound to create issues.
        return _gdart_function_result_load_wrapped_pointer_with_g_type(
                   self,
                   name_prefix,
                   (transfer == GI_TRANSFER_NOTHING),
                   gi_return_value,
                   G_DART_COMPAT_SLIST_TYPE,
                   FALSE,
                   NULL,
                   out_arg_pos_out,
                   dart_out,
                   dart_error_out,
                   error);
    case GI_TYPE_TAG_GHASH: {
        GIRegisteredTypeInfo* type_info;
        gboolean result;

        type_info = (GIRegisteredTypeInfo*) g_irepository_find_by_gtype(
                        gdart_bridge_context_get_gi_repository(self),
                        G_TYPE_HASH_TABLE); //heap allocated
        result = _gdart_function_result_load_wrapped_pointer_with_g_type(
                     self,
                     name_prefix,
                     (transfer == GI_TRANSFER_NOTHING),
                     gi_return_value,
                     G_TYPE_HASH_TABLE,
                     TRUE,
                     type_info,
                     out_arg_pos_out,
                     dart_out,
                     dart_error_out,
                     error);
        g_base_info_unref(type_info);
        return result;
    }
    case GI_TYPE_TAG_ERROR: {
        //TODO: Handle GErrors better.
        GIRegisteredTypeInfo* type_info;
        gboolean result;

        type_info = (GIRegisteredTypeInfo*) g_irepository_find_by_gtype(
                        gdart_bridge_context_get_gi_repository(self),
                        G_TYPE_ERROR); //heap allocated
        result = _gdart_function_result_load_wrapped_pointer_with_g_type(
                     self,
                     name_prefix,
                     (transfer == GI_TRANSFER_NOTHING),
                     gi_return_value,
                     G_TYPE_ERROR,
                     TRUE,
                     type_info,
                     out_arg_pos_out,
                     dart_out,
                     dart_error_out,
                     error);
        g_base_info_unref(type_info);
        return result;
    }
    default:
        *dart_error_out = gdart_bridge_context_create_error_handle(self,
                          "%s: got an unexpected type", G_STRFUNC);
        g_set_error(error, GDART_ERROR, 1,
                          "%s: got an unexpected type", G_STRFUNC);
        return FALSE;
    }
}

gboolean _gdart_function_invoke_load_return_arguments(
    GdartBridgeContext *self,
    const gchar* name_prefix,
    GICallableInfo *function_info,
    gboolean is_method,
    gboolean can_throw_gerror,
    gint c_argc,
    gint gi_argc,
    gint* suppressed_args,
    gint suppressed_args_length,
    GArgument *in_arg_cvalues,
    GArgument *out_arg_cvalues,
    GArgument *inout_original_arg_cvalues,
    GIFFIReturnValue *gi_return_value,
    GITypeInfo* return_type,
    Dart_Handle *dart_out,
    gint out_argc,
    Dart_Handle *dart_error_out,
    GError **error)
{
    gint out_arg_pos = 0, gi_arg_pos = 0;
    GITypeInfo type_info;
    gchar* return_identifier;

    g_callable_info_load_return_type(function_info, &type_info);
    Dart_Handle *outputs = g_newa(Dart_Handle, out_argc);
    return_identifier = g_strdup_printf("%s[return]", name_prefix);

    if (!_gdart_function_result_load_return(self,
                                            return_identifier,
                                            function_info,
                                            NULL,
                                            is_method,
                                            can_throw_gerror,
                                            TRUE,
                                            in_arg_cvalues,
                                            out_arg_cvalues,
                                            inout_original_arg_cvalues,
                                            gi_return_value,
                                            NULL,
                                            &type_info,
                                            &out_arg_pos,
                                            outputs,
                                            out_argc,
                                            dart_error_out,
                                            error)) {
        return FALSE;
    }
    for (; gi_arg_pos < gi_argc; gi_arg_pos++) {
        gint c_arg_pos, arg_i = 0;
        GIArgInfo arg_info;
        GIDirection direction;
        gchar* arg_identifier;

        g_callable_info_load_arg(function_info, gi_arg_pos, &arg_info);
        direction = g_arg_info_get_direction(&arg_info);
        if (direction == GI_DIRECTION_IN) {
            continue;
        }
        for (; arg_i < suppressed_args_length; arg_i++) {
            if (suppressed_args[arg_i] == gi_arg_pos) {
                goto out;
            }
            if (suppressed_args[arg_i] == -1) break;
        }
        c_arg_pos = is_method ? gi_arg_pos + 1 : gi_arg_pos;
        g_arg_info_load_type(&arg_info, &type_info);
        arg_identifier = g_strdup_printf("%s.%s",
                                         name_prefix,
                                         g_base_info_get_name((GIBaseInfo*) &arg_info));
        if (!_gdart_function_result_load_return(self,
                                                arg_identifier,
                                                function_info,
                                                &arg_info,
                                                is_method,
                                                can_throw_gerror,
                                                FALSE,
                                                in_arg_cvalues,
                                                out_arg_cvalues,
                                                inout_original_arg_cvalues,
                                                &out_arg_cvalues[c_arg_pos],
                                                &in_arg_cvalues[c_arg_pos],
                                                &type_info,
                                                &out_arg_pos,
                                                outputs,
                                                out_argc,
                                                dart_error_out,
                                                error)) {
            g_free(arg_identifier);
            return FALSE;
        }
        g_free(arg_identifier);
out:
        continue;
    }
    if (can_throw_gerror) {
        //TODO: Handle GErrors better.
        GIRegisteredTypeInfo* type_info;
        gboolean result;
        gint position = 0;
        Dart_Handle result_dart;
        gchar* error_identifier;

        error_identifier = g_strdup_printf("%s.error", name_prefix);

        type_info = (GIRegisteredTypeInfo*) g_irepository_find_by_gtype(
                        gdart_bridge_context_get_gi_repository(self),
                        G_TYPE_ERROR); //heap allocated
        if (out_arg_cvalues[is_method ? gi_argc + 1 : gi_argc].v_pointer == NULL) {
            g_free(error_identifier);
            g_base_info_unref((GIBaseInfo*) type_info);
            goto success_out;
		}
        result = _gdart_function_result_load_wrapped_pointer_with_g_type(
                     self,
                     error_identifier,
                     FALSE,
                     &out_arg_cvalues[is_method ? gi_argc + 1 : gi_argc],
                     G_TYPE_ERROR,
                     TRUE,
                     type_info,
                     &position,
                     &result_dart,
                     dart_error_out,
                     error);
        g_free(error_identifier);
        g_base_info_unref((GIBaseInfo*) type_info);
        if (!result) return FALSE;
        if (!Dart_IsNull(result_dart)) {
            GError *inner_error = NULL;
            *dart_error_out = result_dart;
            inner_error  = (GError *) out_arg_cvalues[is_method ? gi_argc + 1 : gi_argc].v_pointer;
            g_propagate_error(error, inner_error);
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
        result = Dart_NewList(out_argc);
        for (out_arg_pos = 0; out_arg_pos < out_argc; out_arg_pos++) {
            Dart_ListSetAt(result, out_arg_pos, outputs[out_arg_pos]);
        }
        *dart_out = result;
    }
    return TRUE;
}

gboolean gdart_function_invoke(GdartBridgeContext *self,
                               const gchar* name_prefix,
                               GICallableInfo *function_info,
                               GIRegisteredTypeInfo *type_info,
                               GType type,
                               Dart_Handle dart_receiver,
                               Dart_Handle dart_args,
                               gint* suppressed_args,
                               gint suppressed_args_length,
                               Dart_Handle *result_out,
                               Dart_Handle *dart_error_out,
                               GError **error)
{
    GIFunctionInvoker invoker;
    GArgument *in_arg_cvalues, *out_arg_cvalues, *inout_original_arg_cvalues;
    gpointer *ffi_arg_pointers;
    GIFFIReturnValue gi_return_value;
    GdartCallbackTrampoline **trampolines;
    gpointer return_value_p;
    gint c_argc, gi_argc, out_argc, c_arg_pos=0;
    gboolean is_method, can_throw_gerror;
    GITypeInfo return_type;
    GITypeTag return_tag;

    if (!gdart_function_prep_invoke(self,
                                    name_prefix,
                                    function_info,
                                    type,
                                    &invoker,
                                    dart_error_out,
                                    error)) {
        return FALSE;
    }

    is_method = g_callable_info_is_method(function_info);
    can_throw_gerror = g_callable_info_can_throw_gerror(function_info);
    c_argc = invoker.cif.nargs;
    gi_argc = g_callable_info_get_n_args(function_info);

    in_arg_cvalues = g_newa(GArgument, c_argc);
    out_arg_cvalues = g_newa(GArgument, c_argc);
    inout_original_arg_cvalues = g_newa(GArgument, c_argc);
    ffi_arg_pointers = g_newa(gpointer, c_argc);
    trampolines = g_newa(GdartCallbackTrampoline *, c_argc);
    for (; c_arg_pos < c_argc; c_arg_pos++)
        trampolines[c_arg_pos] = NULL;

    if (!_gdart_function_invoke_fill_arguments(self,
            name_prefix,
            function_info,
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
        return FALSE;
    }
    g_callable_info_load_return_type(function_info, &return_type);
    return_tag = g_type_info_get_tag(&return_type);

    if (return_tag == GI_TYPE_TAG_FLOAT)
        return_value_p = &gi_return_value.v_float;
    else if (return_tag == GI_TYPE_TAG_DOUBLE)
        return_value_p = &gi_return_value.v_double;
    else if (return_tag == GI_TYPE_TAG_INT64 || return_tag == GI_TYPE_TAG_UINT64)
        return_value_p = &gi_return_value.v_uint64;
    else
        return_value_p = &gi_return_value.v_long;

    ffi_call(&invoker.cif,
             FFI_FN(invoker.native_address),
             return_value_p,
             ffi_arg_pointers);
    _gdart_prep_results(self,
                        name_prefix,
                        function_info,
                        &return_type,
                        suppressed_args,
                        suppressed_args_length,
                        &out_argc,
                        gi_argc,
                        can_throw_gerror);

    gboolean result;
    result = _gdart_function_invoke_load_return_arguments(self,
             name_prefix,
             function_info,
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
             &return_type,
             result_out,
             out_argc,
             dart_error_out,
             error);
    _gdart_function_invoke_unfill_arguments(self,
                                            name_prefix,
                                            function_info,
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
                                            suppressed_args_length);
    for (c_arg_pos = 0; c_arg_pos < c_argc; c_arg_pos++) {
        if (trampolines[c_arg_pos] == NULL) {
			break;
		}
		_gdart_callback_closure_free_trampoline(trampolines[c_arg_pos]);
	}

    return result;
}

void _gdart_callback_copyback_out_argument(
    GITypeInfo* type_info,
    GIArgument* in_arg_cvalues,
    GIArgument* out_arg_cvalues,
    gint c_arg_pos)
{
    switch(g_type_info_get_tag(type_info)) {
    case GI_TYPE_TAG_BOOLEAN:
        *((gboolean *) in_arg_cvalues[c_arg_pos].v_pointer) = out_arg_cvalues[c_arg_pos].v_boolean;
        break;
    case GI_TYPE_TAG_INT8:
    case GI_TYPE_TAG_UINT8:
        *((guint8 *) in_arg_cvalues[c_arg_pos].v_pointer) = out_arg_cvalues[c_arg_pos].v_uint8;
        break;
    case GI_TYPE_TAG_INT16:
    case GI_TYPE_TAG_UINT16:
        *((guint16 *) in_arg_cvalues[c_arg_pos].v_pointer) = out_arg_cvalues[c_arg_pos].v_uint16;
        break;
    case GI_TYPE_TAG_INT32:
    case GI_TYPE_TAG_UINT32:
        *((guint32 *) in_arg_cvalues[c_arg_pos].v_pointer) = out_arg_cvalues[c_arg_pos].v_uint32;
        break;
    case GI_TYPE_TAG_INT64:
    case GI_TYPE_TAG_UINT64:
    case GI_TYPE_TAG_GTYPE:
        *((guint64 *) in_arg_cvalues[c_arg_pos].v_pointer) = out_arg_cvalues[c_arg_pos].v_uint64;
        break;
    case GI_TYPE_TAG_FLOAT:
        *((gfloat *) in_arg_cvalues[c_arg_pos].v_pointer) = out_arg_cvalues[c_arg_pos].v_float;
        break;
    case GI_TYPE_TAG_DOUBLE:
        *((gdouble *) in_arg_cvalues[c_arg_pos].v_pointer) = out_arg_cvalues[c_arg_pos].v_double;
        break;
    case GI_TYPE_TAG_ARRAY:
    case GI_TYPE_TAG_UTF8:
    case GI_TYPE_TAG_FILENAME:
    case GI_TYPE_TAG_GLIST:
    case GI_TYPE_TAG_GSLIST:
    case GI_TYPE_TAG_GHASH:
    case GI_TYPE_TAG_ERROR:
        *((gpointer *) in_arg_cvalues[c_arg_pos].v_pointer) = out_arg_cvalues[c_arg_pos].v_pointer;
        break;
    case GI_TYPE_TAG_INTERFACE: {
        GIBaseInfo* base_info;
        base_info = g_type_info_get_interface(type_info);
        switch (g_base_info_get_type(base_info)) {
        case GI_INFO_TYPE_CALLBACK:
        case GI_INFO_TYPE_BOXED:
        case GI_INFO_TYPE_OBJECT:
        case GI_INFO_TYPE_INTERFACE:
        case GI_INFO_TYPE_STRUCT:
        case GI_INFO_TYPE_UNION:
            *((gpointer *) in_arg_cvalues[c_arg_pos].v_pointer) = out_arg_cvalues[c_arg_pos].v_pointer;
            break;
        case GI_INFO_TYPE_ENUM:
        case GI_INFO_TYPE_FLAGS: {
            switch (g_enum_info_get_storage_type((GIEnumInfo*) base_info)) {
            case GI_TYPE_TAG_BOOLEAN:
                *((gboolean *) in_arg_cvalues[c_arg_pos].v_pointer) = out_arg_cvalues[c_arg_pos].v_boolean;
                break;
            case GI_TYPE_TAG_INT8:
            case GI_TYPE_TAG_UINT8:
                *((guint8 *) in_arg_cvalues[c_arg_pos].v_pointer) = out_arg_cvalues[c_arg_pos].v_uint8;
                break;
            case GI_TYPE_TAG_INT16:
            case GI_TYPE_TAG_UINT16:
                *((guint16 *) in_arg_cvalues[c_arg_pos].v_pointer) = out_arg_cvalues[c_arg_pos].v_uint16;
                break;
            case GI_TYPE_TAG_INT32:
            case GI_TYPE_TAG_UINT32:
                *((guint32 *) in_arg_cvalues[c_arg_pos].v_pointer) = out_arg_cvalues[c_arg_pos].v_uint32;
                break;
            case GI_TYPE_TAG_INT64:
            case GI_TYPE_TAG_UINT64:
            case GI_TYPE_TAG_GTYPE:
                *((guint64 *) in_arg_cvalues[c_arg_pos].v_pointer) = out_arg_cvalues[c_arg_pos].v_uint64;
                break;
            default:
                break;
            }
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
}

void _gdart_callback_copy_ref_argument(
    GITypeInfo* type_info,
    GIArgument* in_arg_cvalues,
    GIArgument* inout_original_arg_cvalues,
    gint c_arg_pos)
{
    switch(g_type_info_get_tag(type_info)) {
    case GI_TYPE_TAG_BOOLEAN:
        inout_original_arg_cvalues[c_arg_pos].v_boolean = *((gboolean*) in_arg_cvalues[c_arg_pos].v_pointer);
        break;
    case GI_TYPE_TAG_INT8:
    case GI_TYPE_TAG_UINT8:
        inout_original_arg_cvalues[c_arg_pos].v_uint8 = *((guint8*) in_arg_cvalues[c_arg_pos].v_pointer);
        break;
    case GI_TYPE_TAG_INT16:
    case GI_TYPE_TAG_UINT16:
        inout_original_arg_cvalues[c_arg_pos].v_uint16 = *((guint16*) in_arg_cvalues[c_arg_pos].v_pointer);
        break;
    case GI_TYPE_TAG_INT32:
    case GI_TYPE_TAG_UINT32:
        inout_original_arg_cvalues[c_arg_pos].v_uint32 = *((guint32*) in_arg_cvalues[c_arg_pos].v_pointer);
        break;
    case GI_TYPE_TAG_INT64:
    case GI_TYPE_TAG_UINT64:
    case GI_TYPE_TAG_GTYPE:
        inout_original_arg_cvalues[c_arg_pos].v_uint64 = *((guint64*) in_arg_cvalues[c_arg_pos].v_pointer);
        break;
    case GI_TYPE_TAG_FLOAT:
        inout_original_arg_cvalues[c_arg_pos].v_float = *((gfloat*) in_arg_cvalues[c_arg_pos].v_pointer);
        break;
    case GI_TYPE_TAG_DOUBLE:
        inout_original_arg_cvalues[c_arg_pos].v_double = *((gdouble*) in_arg_cvalues[c_arg_pos].v_pointer);
        break;
    case GI_TYPE_TAG_ARRAY:
    case GI_TYPE_TAG_UTF8:
    case GI_TYPE_TAG_FILENAME:
    case GI_TYPE_TAG_GLIST:
    case GI_TYPE_TAG_GSLIST:
    case GI_TYPE_TAG_GHASH:
    case GI_TYPE_TAG_ERROR:
        inout_original_arg_cvalues[c_arg_pos].v_pointer = *((gpointer*) in_arg_cvalues[c_arg_pos].v_pointer);
        break;
    case GI_TYPE_TAG_INTERFACE: {
        GIBaseInfo* base_info;
        base_info = g_type_info_get_interface(type_info);
        switch (g_base_info_get_type(base_info)) {
        case GI_INFO_TYPE_CALLBACK:
        case GI_INFO_TYPE_BOXED:
        case GI_INFO_TYPE_OBJECT:
        case GI_INFO_TYPE_INTERFACE:
        case GI_INFO_TYPE_STRUCT:
        case GI_INFO_TYPE_UNION:
            inout_original_arg_cvalues[c_arg_pos].v_pointer = *((gpointer*) in_arg_cvalues[c_arg_pos].v_pointer);
            break;
        case GI_INFO_TYPE_ENUM:
        case GI_INFO_TYPE_FLAGS: {
            switch (g_enum_info_get_storage_type((GIEnumInfo*) base_info)) {
            case GI_TYPE_TAG_BOOLEAN:
                inout_original_arg_cvalues[c_arg_pos].v_boolean = *((gboolean*) in_arg_cvalues[c_arg_pos].v_pointer);
                break;
            case GI_TYPE_TAG_INT8:
            case GI_TYPE_TAG_UINT8:
                inout_original_arg_cvalues[c_arg_pos].v_uint8 = *((guint8*) in_arg_cvalues[c_arg_pos].v_pointer);
                break;
            case GI_TYPE_TAG_INT16:
            case GI_TYPE_TAG_UINT16:
                inout_original_arg_cvalues[c_arg_pos].v_uint16 = *((guint16*) in_arg_cvalues[c_arg_pos].v_pointer);
                break;
            case GI_TYPE_TAG_INT32:
            case GI_TYPE_TAG_UINT32:
                inout_original_arg_cvalues[c_arg_pos].v_uint32 = *((guint32*) in_arg_cvalues[c_arg_pos].v_pointer);
                break;
            case GI_TYPE_TAG_INT64:
            case GI_TYPE_TAG_UINT64:
            case GI_TYPE_TAG_GTYPE:
                inout_original_arg_cvalues[c_arg_pos].v_uint64 = *((guint64*) in_arg_cvalues[c_arg_pos].v_pointer);
                break;
            default:
                break;
            }
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
}


void _gdart_callback_prep_arguments_for_callback(
    void **args,
    GICallableInfo* callable_info,
    GIArgument* in_arg_cvalues,
    GIArgument* inout_original_arg_cvalues,
    gint c_argc,
    gint gi_argc,
    gboolean is_method,
    gboolean has_user_data,
    gboolean can_throw_gerror,
    gint *suppressed_args,
    gint suppressed_args_length,
    gint *dart_argc_out)
{
    gint gi_arg_pos = 0, c_arg_pos = 0, dart_argc=0;

    if (is_method) {
        GIArgument* this_argument = (GIArgument*) args[c_arg_pos];
        in_arg_cvalues[c_arg_pos] = *this_argument;
        c_arg_pos++;
    }
    for (; gi_arg_pos < gi_argc; gi_arg_pos++) {
        GIArgInfo arg_info;
        GITypeInfo type_info;
        GIDirection direction;

        GIArgument* this_argument = (GIArgument*) args[c_arg_pos];
        in_arg_cvalues[c_arg_pos] = *this_argument;
        if (has_user_data && gi_arg_pos == (gi_argc - 1)) {
			c_arg_pos++;
			continue;
		}

        g_callable_info_load_arg(callable_info, gi_arg_pos, &arg_info);
        g_arg_info_load_type(&arg_info, &type_info);
        direction = g_arg_info_get_direction(&arg_info);
        if (direction == GI_DIRECTION_IN || direction == GI_DIRECTION_INOUT) {
            dart_argc++;
            switch (g_type_info_get_tag(&type_info)) {
            case GI_TYPE_TAG_ARRAY: {
                gint arg_to_suppress, arg_i = 0;
                arg_to_suppress = g_type_info_get_array_length(&type_info);
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
        GIArgument* this_argument = (GIArgument*) args[c_arg_pos];
        in_arg_cvalues[c_arg_pos] = *this_argument;
        c_arg_pos++;
    }
    (*dart_argc_out) = dart_argc;
}

void _gdart_callback_load_arguments_for_callback(
    GdartBridgeContext* self,
    const gchar* name_prefix,
    GICallableInfo* callable_info,
    GIArgument* in_arg_cvalues,
    GIArgument* inout_original_arg_cvalues,
    gint c_argc,
    gint gi_argc,
    gboolean is_method,
    gboolean can_throw_gerror,
    gboolean user_data_present,
    gint *suppressed_args,
    gint suppressed_args_length,
    gint dart_argc,
    Dart_Handle* dart_arguments)
{
    gint gi_arg_pos = 0, c_arg_pos = 0, dart_arg_pos=0;
    Dart_Handle set_on_error = NULL;
    GError *error = NULL;

    if (is_method) {
        c_arg_pos++;
    }
    for (; gi_arg_pos < gi_argc; gi_arg_pos++) {
        gint arg_i = 0;
        GIArgInfo arg_info;
        GITypeInfo type_info;
        GIDirection direction;
        gchar* arg_name;

        g_callable_info_load_arg(callable_info, gi_arg_pos, &arg_info);
        arg_name = g_strdup_printf("%s.%s",
                                   name_prefix,
                                   g_base_info_get_name((GIBaseInfo*) &arg_info));
        g_arg_info_load_type(&arg_info, &type_info);
        direction = g_arg_info_get_direction(&arg_info);
        if (direction == GI_DIRECTION_INOUT) {
            _gdart_callback_copy_ref_argument(&type_info,
                                              in_arg_cvalues,
                                              inout_original_arg_cvalues,
                                              c_arg_pos);
        }
        for (; arg_i < suppressed_args_length; arg_i++) {
            if (suppressed_args[arg_i] == gi_arg_pos) {
                goto out;
            }
            if (suppressed_args[arg_i] == -1) break;
        }
        switch (direction) {
        case GI_DIRECTION_IN:
            if (!_gdart_function_result_load_return(self,
                                               arg_name,
                                               callable_info,
                                               &arg_info,
                                               is_method,
                                               can_throw_gerror,
                                               FALSE,
                                               in_arg_cvalues,
                                               NULL,
                                               NULL,
                                               &in_arg_cvalues[c_arg_pos],
                                               NULL,
                                               &type_info,
                                               &dart_arg_pos,
                                               dart_arguments,
                                               dart_argc,
                                               &set_on_error,
                                               &error)) {
				goto error_out;
			}
            break;
        case GI_DIRECTION_INOUT:
            if (!_gdart_function_result_load_return(self,
                                               arg_name,
                                               callable_info,
                                               &arg_info,
                                               is_method,
                                               can_throw_gerror,
                                               FALSE,
                                               inout_original_arg_cvalues,
                                               NULL,
                                               NULL,
                                               &inout_original_arg_cvalues[c_arg_pos],
                                               NULL,
                                               &type_info,
                                               &dart_arg_pos,
                                               dart_arguments,
                                               dart_argc,
                                               &set_on_error,
                                               &error)) {
				goto error_out;
			}
            break;
        default:
            break;
        }
out:
        g_free(arg_name);
        c_arg_pos++;
    }
    if (user_data_present) {
        c_arg_pos++;
    }
    return;
error_out: {
        g_critical("Dart threw a fatal error from within a callback in a "
                   "place where it can't be ignored: %s",
                   error->message);
        g_assert_not_reached();
    }
}


void _gdart_function_invoke_fill_callback_returns(
    GdartBridgeContext *self,
    const gchar* name_prefix,
    GICallableInfo *function_info,
    Dart_Handle dart_args,
    gboolean is_method,
    gboolean can_throw_gerror,
    GArgument *main_out_argument,
    GArgument *in_arg_cvalues,
    GArgument *out_arg_cvalues,
    gint c_argc,
    gint gi_argc,
    gint* suppressed_args,
    gint suppressed_args_length)
{
    gint c_arg_pos = 0, gi_arg_pos = 0, dart_arg_pos = 0, c_arg_pos0=0;
    GITypeInfo return_type_info;
    GITypeTag type_tag;
    Dart_Handle set_on_error = NULL;
    GError *error = NULL;

    g_callable_info_load_return_type(function_info, &return_type_info);
    if (is_method) {
        c_arg_pos++;
    }

    type_tag = g_type_info_get_tag(&return_type_info);
    if (type_tag != GI_TYPE_TAG_VOID && (!can_throw_gerror || type_tag != GI_TYPE_TAG_BOOLEAN)) {
        gchar *return_name;
        return_name = g_strdup_printf("%s[return]", name_prefix);
        if (!_gdart_function_fill_argument_in(self,
                                              return_name,
                                              dart_args,
                                              function_info,
                                              g_callable_info_get_caller_owns(function_info) != GI_TRANSFER_NOTHING,
                                              is_method,
                                              &c_arg_pos0,
                                              &dart_arg_pos,
                                              -1,
                                              NULL,
                                              &return_type_info,
                                              suppressed_args,
                                              gi_argc,
                                              main_out_argument,
                                              out_arg_cvalues,
                                              NULL,
                                              NULL,
                                              0,
                                              &set_on_error,
                                              &error)) {
            g_free(return_name);
            goto error_out;
        }
        g_free(return_name);
    } else if (can_throw_gerror && type_tag == GI_TYPE_TAG_BOOLEAN) {
        main_out_argument->v_boolean = TRUE;
    }

    for (gi_arg_pos = 0; gi_arg_pos < gi_argc; gi_arg_pos++) {
        GIDirection direction;
        GIArgInfo arg_info;
        gchar* arg_name;

        g_callable_info_load_arg(function_info, gi_arg_pos, &arg_info);
        arg_name = g_strdup_printf("%s.%s",
                                   name_prefix,
                                   g_base_info_get_name((GIBaseInfo*) &arg_info));
        direction = g_arg_info_get_direction(&arg_info);
        switch (direction) {
        case GI_DIRECTION_IN:
            c_arg_pos++;
            break;
        case GI_DIRECTION_INOUT:
        case GI_DIRECTION_OUT: {
            gint c_arg_pos_previous;
            GITypeInfo arg_type;

            c_arg_pos_previous = c_arg_pos;
            if (in_arg_cvalues[c_arg_pos].v_pointer == NULL) {
                c_arg_pos++;
                break;
            }
            g_arg_info_load_type(&arg_info, &arg_type);
            switch (g_type_info_get_tag(&arg_type)) {
            case GI_TYPE_TAG_UTF8:
            case GI_TYPE_TAG_FILENAME:
            case GI_TYPE_TAG_ARRAY: {
                if (g_arg_info_get_ownership_transfer(&arg_info) == GI_TRANSFER_NOTHING) {
                    g_warning("%s: The type of transfer for an out argument was "
                              "`transfer none`, but Dart uses native types for "
                              "arguments of this type.",
                              arg_name);
                    g_free(arg_name);
                    g_assert_not_reached();
                }
            }
            default:
                break;
            }
            if (!_gdart_function_fill_argument_in(self,
                                                  arg_name,
                                                  dart_args,
                                                  function_info,
                                                  g_arg_info_get_ownership_transfer(&arg_info) != GI_TRANSFER_NOTHING,
                                                  is_method,
                                                  &c_arg_pos,
                                                  &dart_arg_pos,
                                                  gi_arg_pos,
                                                  &arg_info,
                                                  &arg_type,
                                                  suppressed_args,
                                                  gi_argc,
                                                  &out_arg_cvalues[c_arg_pos],
                                                  out_arg_cvalues,
                                                  NULL,
                                                  NULL,
                                                  0,
                                                  &set_on_error,
                                                  &error)) {
                g_free(arg_name);
                goto error_out;
            }
            _gdart_callback_copyback_out_argument(&arg_type,
                                                  in_arg_cvalues,
                                                  out_arg_cvalues,
                                                  c_arg_pos_previous);
            break;
        }
        default:
            g_free(arg_name);
            g_assert_not_reached();
        }
        g_free(arg_name);
    }
    if (can_throw_gerror) {
        c_arg_pos++;
    }
    if (c_arg_pos != c_argc) {
        g_assert_not_reached();
    }
    return;
error_out: {
        g_critical("Dart threw a fatal error from within a callback in a "
                   "place where it can't be ignored: %s",
                   error->message);
        g_assert_not_reached();
    }
}

void set_return_ffi_arg_from_giargument (GITypeInfo  *ret_type,
        void        *result,
        GIArgument  *return_value)
{
    switch (g_type_info_get_tag(ret_type)) {
    case GI_TYPE_TAG_INT8:
        *(ffi_sarg *) result = return_value->v_int8;
        break;
    case GI_TYPE_TAG_UINT8:
        *(ffi_arg *) result = return_value->v_uint8;
        break;
    case GI_TYPE_TAG_INT16:
        *(ffi_sarg *) result = return_value->v_int16;
        break;
    case GI_TYPE_TAG_UINT16:
        *(ffi_arg *) result = return_value->v_uint16;
        break;
    case GI_TYPE_TAG_INT32:
        *(ffi_sarg *) result = return_value->v_int32;
        break;
    case GI_TYPE_TAG_UINT32:
    case GI_TYPE_TAG_BOOLEAN:
    case GI_TYPE_TAG_UNICHAR:
        *(ffi_arg *) result = return_value->v_uint32;

        break;
    case GI_TYPE_TAG_INT64:
        *(ffi_sarg *) result = return_value->v_int64;
        break;
    case GI_TYPE_TAG_UINT64:
        *(ffi_arg *) result = return_value->v_uint64;
        break;
    case GI_TYPE_TAG_INTERFACE: {
        GIBaseInfo* interface_info;
        GIInfoType interface_type;

        interface_info = g_type_info_get_interface(ret_type);
        interface_type = g_base_info_get_type(interface_info);

        switch (interface_type) {
        case GI_INFO_TYPE_ENUM:
        case GI_INFO_TYPE_FLAGS:
            *(ffi_sarg *) result = return_value->v_long;
            break;
        default:
            *(ffi_arg *) result = (ffi_arg) return_value->v_pointer;
            break;
        }

        g_base_info_unref(interface_info);
    }
    default:
        *(ffi_arg *) result = (ffi_arg) return_value->v_uint64;
        break;
    }
}

void _gdart_callback_closure_free_trampoline(GdartCallbackTrampoline* trampoline)
{
    g_callable_info_free_closure(trampoline->signal_info, trampoline->closure);
    Dart_DeletePersistentHandle(trampoline->closure_dart);
    g_free(trampoline->closure_name);
    g_slice_free(GdartCallbackTrampoline, trampoline);
}

static void _gdart_callback_closure(ffi_cif *cif,
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
    GITypeInfo return_type_info;
    gint* suppressed_args;
    gboolean is_method, can_throw_gerror;
    GdartBridgeContext* self;
    gchar *closure_name;

    trampoline = (GdartCallbackTrampoline*) data;
    c_argc = trampoline->cif.nargs;
    closure_name = g_strdup_printf("(closure invoked from %s)", trampoline->closure_name);
    gi_argc = g_callable_info_get_n_args(trampoline->signal_info);
    is_method = g_callable_info_is_method(trampoline->signal_info);
    can_throw_gerror = g_callable_info_can_throw_gerror(trampoline->signal_info);
    g_callable_info_load_return_type(trampoline->signal_info, &return_type_info);
    suppressed_args_length = gi_argc;
    in_arg_cvalues = g_newa(GIArgument, c_argc);
    inout_original_arg_cvalues = g_newa(GIArgument, c_argc);
    out_arg_cvalues = g_newa(GIArgument, c_argc);
    suppressed_args = g_newa(gint, suppressed_args_length);
    for (; c_arg_pos < suppressed_args_length; c_arg_pos++) {
        suppressed_args[c_arg_pos] = -1;
    }
    self = gdart_bridge_context_new_from_isolate(Dart_CurrentIsolate());
    _gdart_callback_prep_arguments_for_callback(args,
            trampoline->signal_info,
            in_arg_cvalues,
            inout_original_arg_cvalues,
            c_argc,
            gi_argc,
            is_method,
            trampoline->user_data_present,
            can_throw_gerror,
            suppressed_args,
            suppressed_args_length,
            &dart_argc);
    if (trampoline->user_data_present) {
        //dart_argc--;
    }
    dart_arguments = g_newa(Dart_Handle, dart_argc);
    _gdart_callback_load_arguments_for_callback(self,
            closure_name,
            trampoline->signal_info,
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
            dart_arguments);
    Dart_EnterScope();
    closure = Dart_HandleFromPersistent(trampoline->closure_dart);
    dart_result = Dart_InvokeClosure(closure, dart_argc, dart_arguments);
    if (Dart_IsError(dart_result)) {
        //TODO: Handle GErrors when callbacks can throw them.
        Dart_Handle stacktrace, dart_stacktrace_string, temp_result;
        gchar *output_string, *output_string_copy;
        gintptr output_string_length;

        stacktrace = Dart_ErrorGetStacktrace(dart_result);
        if (Dart_IsError(stacktrace)) {
            dart_stacktrace_string = result;
        } else {
            dart_stacktrace_string = Dart_ToString(stacktrace);
        }
        if (Dart_IsError(dart_stacktrace_string)) {
            temp_result = dart_stacktrace_string;
        } else {
            temp_result = Dart_StringToUTF8(dart_stacktrace_string,
                                            (guint8**) &output_string,
                                            &output_string_length);
        }
        if (Dart_IsError(temp_result)) {
            output_string_length = 0;
            output_string_copy = g_newa(gchar, 1);
            output_string_copy[0] = '\0';
        } else {
            output_string_copy = g_newa(gchar, output_string_length + 1);
            memmove(output_string_copy, output_string, output_string_length);
            output_string_copy[output_string_length] = '\0';
        }
        g_critical("%s: Dart threw a fatal error from within a callback:\n%s\n%s",
                   closure_name,
                   Dart_GetError(dart_result),
                   output_string_copy);
        g_assert_not_reached();
    }
    _gdart_prep_results(self,
                        closure_name,
                        trampoline->signal_info,
                        &return_type_info,
                        suppressed_args,
                        suppressed_args_length,
                        &dart_out_argc,
                        gi_argc,
                        can_throw_gerror);
    if (dart_out_argc == 1) {
        Dart_Handle result_element, temp_result;
        result_element = dart_result;
        dart_result = Dart_NewList(1);
        temp_result = Dart_ListSetAt(dart_result, 0, result_element);
        if (Dart_IsError(temp_result)) {
            Dart_Handle stacktrace, dart_stacktrace_string, temp_result;
            gchar *output_string, *output_string_copy;
            gintptr output_string_length;

            stacktrace = Dart_ErrorGetStacktrace(dart_result);
            if (Dart_IsError(stacktrace)) {
                dart_stacktrace_string = result;
            } else {
                dart_stacktrace_string = Dart_ToString(stacktrace);
            }
            if (Dart_IsError(dart_stacktrace_string)) {
                temp_result = dart_stacktrace_string;
            } else {
                temp_result = Dart_StringToUTF8(dart_stacktrace_string,
                                                (guint8**) &output_string,
                                                &output_string_length);
            }
            if (Dart_IsError(temp_result)) {
                output_string_length = 0;
                output_string_copy = g_newa(gchar, 1);
                output_string_copy[0] = '\0';
            } else {
                output_string_copy = g_newa(gchar, output_string_length + 1);
                memmove(output_string_copy, output_string, output_string_length);
                output_string_copy[output_string_length] = '\0';
            }
            g_critical("%s: Dart threw an error from within a callback:\n%s\n%s",
                       closure_name,
                       Dart_GetError(dart_result),
                       output_string_copy);
        }
    } else if (dart_out_argc == 0) {
        dart_result = Dart_NewList(0);
    }
    _gdart_function_invoke_fill_callback_returns(self,
            closure_name,
            trampoline->signal_info,
            dart_result,
            is_method,
            can_throw_gerror,
            &main_return,
            in_arg_cvalues,
            out_arg_cvalues,
            c_argc,
            gi_argc,
            suppressed_args,
            suppressed_args_length);
    if (trampoline->is_one_shot) {
        _gdart_callback_closure_free_trampoline(trampoline);
    }
    Dart_ExitScope();
    set_return_ffi_arg_from_giargument(&return_type_info, result, &main_return);
    g_free(closure_name);
}

void gdart_callback_closure_notify(gpointer data)
{
    _gdart_callback_closure_free_trampoline((GdartCallbackTrampoline*) data);
}

void gdart_callback_closure_free(gpointer data, GClosure *closure)
{
    _gdart_callback_closure_free_trampoline((GdartCallbackTrampoline*) data);
}

gboolean gdart_signal_connect_data(
    GdartBridgeContext *self,
    const gchar* detailed_signal,
    GObject* object,
    GIObjectInfo* object_info, //heap allocated
    Dart_Handle callback,
    bool is_after,
    Dart_Handle *result_out,
    Dart_Handle *dart_error_out,
    GError **error)
{
    GdartCallbackTrampoline* trampoline;
    gchar** substrings;
    GICallableInfo* signal_info;
    guint64 result;
    Dart_Handle result_dart;

    substrings = g_strsplit(detailed_signal, "::", -1);
    {
        GIObjectInfo *current_object_info, *previous_object_info;
        current_object_info = g_base_info_ref((GIBaseInfo*) object_info);
        while (current_object_info != NULL) {
            signal_info = g_object_info_find_signal(current_object_info, substrings[0]);
            if (signal_info != NULL) break;
            previous_object_info = current_object_info;
            current_object_info = g_object_info_get_parent(current_object_info);
            g_base_info_unref((GIBaseInfo*) previous_object_info);
        }
        if (current_object_info != NULL) g_base_info_unref((GIBaseInfo*) current_object_info);
    }
    g_strfreev(substrings);
    if (signal_info == NULL) {
        *dart_error_out = gdart_bridge_context_create_error_handle(self,
                          "%s: could not find the specified signal", G_STRFUNC);
        g_set_error(error, GDART_ERROR, 1,
                          "%s: could not find the specified signal", G_STRFUNC);
        return FALSE;
    }
    trampoline = g_slice_new(GdartCallbackTrampoline);
    trampoline->closure = g_callable_info_prepare_closure(signal_info,
                          &trampoline->cif,
                          _gdart_callback_closure,
                          trampoline);
    trampoline->closure_dart = Dart_NewPersistentHandle(callback);
    trampoline->signal_info = signal_info;
    trampoline->user_data_present = FALSE;
    trampoline->is_one_shot = FALSE;
    trampoline->closure_name = g_strdup_printf("GLib.GObject.signals['%s']",
                               detailed_signal);
    result = g_signal_connect_data(object,
                                   detailed_signal,
                                   G_CALLBACK(trampoline->closure),
                                   trampoline,
                                   gdart_callback_closure_free,
                                   is_after ? G_CONNECT_AFTER : 0);
    result_dart = Dart_NewIntegerFromUint64(result);
    if (Dart_IsError(result_dart)) {
		g_warning("%s: Dart threw an error.", trampoline->closure_name);
        *dart_error_out = result_dart;
        g_set_error(error, GDART_ERROR, 1, "Error from Dart operation.");
        return FALSE;
    }
    *result_out = result_dart;
    return TRUE;
}

