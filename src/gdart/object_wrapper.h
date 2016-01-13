// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
#ifndef __GDART_OBJECT_WRAPPER_H__
#define __GDART_OBJECT_WRAPPER_H__

struct _GdartBridgeContextWrappedObject {
  void* object;
  GIRegisteredTypeInfo* object_info;
  GType type;
  GBoxedCopyFunc copy_func;
  GBoxedFreeFunc free_func;
};
typedef struct _GdartBridgeContextWrappedObject GdartBridgeContextWrappedObject;

#endif
