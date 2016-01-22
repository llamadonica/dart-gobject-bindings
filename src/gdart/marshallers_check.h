// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
#ifndef __MARSHALLERS_CHECK_H__
#define __MARSHALLERS_CHECK_H__

#include <glib-object.h>
#include <girepository.h>

#include "../include/dart_api.h"
#include "../include/dart_native_api.h"
#include "bridge_context.h"

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
    GError **error);

gboolean gdart_marshaller_check_arguments(GdartBridgeContext *self,
    GIFunctionInfo *function,
    Dart_Handle dart_args,
    gint garg_length,
    gintptr dart_args_length,
    gint** suppressed_args_out,
    gint* suppress_args_length_out,
    Dart_Handle *dart_error_out,
    GError **error);

#endif
