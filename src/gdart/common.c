// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

#include "common.h"

GQuark gdart_error_quark(void) {

  return g_quark_from_static_string ("gdart-error-quark");
}

Dart_Handle handle_error(Dart_Handle handle) {
  if (Dart_IsError(handle)) {
    Dart_PropagateError(handle);
  }
  return handle;
}
