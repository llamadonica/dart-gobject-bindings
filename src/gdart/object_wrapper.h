// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

#ifndef __GDART_OBJECT_WRAPPER_H__
#define __GDART_OBJECT_WRAPPER_H__

#include "introspection_interface.h"

struct _GdartBridgeContextWrappedObject {
  void* object;
  gpointer object_info;
  RegisteredTypeInfoKlass object_info_klass;
  GType type;
  GBoxedCopyFunc copy_func;
  GBoxedFreeFunc free_func;
  GdartFunctionReference *copy_func_ref;
  GdartFunctionReference *free_func_ref;
};
typedef struct _GdartBridgeContextWrappedObject GdartBridgeContextWrappedObject;

#endif
