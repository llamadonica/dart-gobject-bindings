// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
#ifndef __FUNCTION_H__
#define __FUNCTION_H__

#include <glib-object.h>
#include <girepository.h>
#include <girffi.h>

#include "../include/dart_api.h"
#include "../include/dart_native_api.h"
#include "bridge_context.h"
#include "introspection_interface.h"


gboolean gdart_function_invoke (GdartBridgeContext *self,
                                const gchar *name_prefix,
                                gpointer function_info,
                                const CallableInfoKlass *function_info_klass,
                                gpointer type_info,
				const RegisteredTypeInfoKlass* type_info_klass,
                                GType type,
                                Dart_Handle dart_receiver,
                                Dart_Handle dart_args,
                                gint *suppressed_args,
                                gint suppressed_args_length,
                                Dart_Handle *result_out,
                                Dart_Handle *dart_error_out,
                                GError **error);
gboolean gdart_signal_connect_data (
  GdartBridgeContext *self,
  const gchar *detailed_signal,
  GObject *object,
  GIObjectInfo *object_info,
  Dart_Handle callback,
  bool is_after,
  Dart_Handle *result_out,
  Dart_Handle *dart_error_out,
  GError **error);

#endif
