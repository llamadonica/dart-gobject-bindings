// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
#ifndef __G_PROPERTY_H__
#define __G_PROPERTY_H__

#include <glib-object.h>
#include <girepository.h>
#include <girffi.h>

#include "../include/dart_api.h"
#include "../include/dart_native_api.h"
#include "bridge_context.h"

typedef struct _GdartGPropertyArrayRecord GdartGPropertyArrayRecord;

gboolean gdart_g_property_set_property(GdartBridgeContext *self,
                                       const gchar* name_prefix,
                                       const gchar* property_name,
                                       GIBaseInfo *base_info,
                                       Dart_Handle dart_receiver,
                                       Dart_Handle dart_value,
                                       Dart_Handle *dart_error_out,
                                       GError **error);
gboolean gdart_g_property_get_property(GdartBridgeContext *self,
                                       const gchar* name_prefix,
                                       const gchar* property_name,
                                       GIObjectInfo *type_info,
                                       Dart_Handle dart_receiver,
                                       Dart_Handle *dart_result_out,
                                       Dart_Handle *dart_error_out,
                                       GError **error);
#endif
