// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
#ifndef __ARRAY_H__
#define __ARRAY_H__

#include <glib-object.h>
#include <girepository.h>
#include <girffi.h>

#include "../include/dart_api.h"
#include "../include/dart_native_api.h"
#include "bridge_context.h"

gsize gdart_array_get_size_multiplier(GITypeInfo *param_type);
gboolean gdart_array_fill_in_parameters(
  GdartBridgeContext *self,
  const gchar* name_prefix,
  Dart_Handle dart_list,
  GITypeInfo *param_type,
  gint fixed_length,
  gintptr list_length,
  gpointer buffer,
  gpointer *buffer_out,
  Dart_Handle *dart_error_out,
  GError **error);
gboolean gdart_array_zero_element(GdartBridgeContext *self,
                                  const gchar* name_prefix,
                                  GITypeInfo *arg_type,
                                  gpointer *buffer,
                                  Dart_Handle *dart_error_out,
                                  GError **error);
void gdart_array_unfill_in_array_parameters(
  GdartBridgeContext *self,
  GITypeInfo *param_type,
  gint length,
  gboolean is_null_terminated,
  gpointer buffer);
gboolean gdart_array_load_parameters(
  GdartBridgeContext *self,
  const gchar* name_prefix,
  GITypeInfo *param_type,
  gint length,
  gboolean is_null_terminated,
  gboolean deallocate_members,
  gpointer buffer,
  Dart_Handle *dart_list_out,
  Dart_Handle *dart_error_out,
  GError **error);
#endif
