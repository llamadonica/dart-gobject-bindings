// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
#ifndef __GDART_COMMON_H__
#define __GDART_COMMON_H__
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <glib-object.h>
#include "../include/dart_api.h"
#include "../include/dart_native_api.h"

#define GDART_ERROR gdart_error_quark()

typedef void (*RawPointerFinalizer)(gpointer raw_pointer);

struct _RawPointerContainer {
  gpointer raw_pointer;
  RawPointerFinalizer finalizer;
};
typedef struct _RawPointerContainer RawPointerContainer;

GQuark gdart_error_quark(void);

Dart_Handle handle_error(Dart_Handle handle);
#endif
