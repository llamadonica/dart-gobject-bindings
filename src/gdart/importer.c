// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

#include "importer.h"
#include "bridge_context.h"

void import_native_file(Dart_NativeArguments arguments) {
  Dart_EnterScope();
  g_assert(gdart_bridge_context_new_from_isolate(Dart_CurrentIsolate()) != NULL);
  Dart_Handle result = handle_error(Dart_NewStringFromCString("Hello world!"));
  Dart_SetReturnValue(arguments, result);
  Dart_ExitScope();
}
