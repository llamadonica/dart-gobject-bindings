// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "include/dart_api.h"
#include "include/dart_native_api.h"

#include "gdart/importer.h"
#include "gdart/common.h"
#include "gdart/bridge_context.h"

Dart_NativeFunction resolve_name(Dart_Handle name,
                                int argc,
                                bool* auto_setup_scope);
typedef struct {
  const char* name;
  Dart_NativeFunction function;
} FunctionLookup;

FunctionLookup function_list[] = {
    {"import_native_file", import_native_file},
    {"gdart_bridge_context_lookup_gtype_from_named_type", gdart_bridge_context_lookup_gtype_from_named_type},
    {"gdart_bridge_context_register_interceptor_type_for_gtype", gdart_bridge_context_register_interceptor_type_for_gtype},
    {"gdart_bridge_context_lookup_object_info", gdart_bridge_context_lookup_object_info},
    {"gdart_bridge_context_object_info_call_static", gdart_bridge_context_object_info_call_static},
    {"gdart_bridge_context_object_call_method", gdart_bridge_context_object_call_method},
    {"gdart_bridge_context_call_static_global", gdart_bridge_context_call_static_global},
    {"gdart_bridge_context_object_get_string_representation", gdart_bridge_context_object_get_string_representation},
    {"gdart_bridge_context_lookup_gtype_for_list", gdart_bridge_context_lookup_gtype_for_list},
    {"gdart_bridge_context_lookup_gtype_for_slist", gdart_bridge_context_lookup_gtype_for_slist},
    {"gdart_bridge_context_object_signal_connect", gdart_bridge_context_object_signal_connect},
    {"gdart_bridge_context_register_copy_func_for_gtype", gdart_bridge_context_register_copy_func_for_gtype},
    {"gdart_bridge_context_register_free_func_for_gtype", gdart_bridge_context_register_free_func_for_gtype},
    {"gdart_bridge_context_lookup_error_quark_from_string", gdart_bridge_context_lookup_error_quark_from_string},
    {"gdart_bridge_context_register_interceptor_type_for_error_quark", gdart_bridge_context_register_interceptor_type_for_error_quark},
    {"gdart_bridge_context_lookup_error_string_from_quark", gdart_bridge_context_lookup_error_string_from_quark},
    {"gdart_bridge_context_object_info_call_method_on_receiver", gdart_bridge_context_object_info_call_method_on_receiver},
    {NULL, NULL}};

DART_EXPORT Dart_Handle gdart_Init(Dart_Handle parent_library) {
  GdartBridgeContext* bridge_context;
  if (Dart_IsError(parent_library)) {
    return parent_library;
  }
  Dart_Handle result_code =
      Dart_SetNativeResolver(parent_library, resolve_name, NULL);
  bridge_context = gdart_bridge_context_new();
  gdart_bridge_context_set_base_library(bridge_context,
					Dart_NewWeakPersistentHandle(parent_library, bridge_context, 0, gdart_bridge_context_finalize_from_dart));
  gdart_bridge_context_set_isolate(bridge_context, Dart_CurrentIsolate());
  if (Dart_IsError(result_code)) {
    return result_code;
  }
  return Dart_Null();
}

Dart_NativeFunction resolve_name(Dart_Handle name,
                                int argc,
                                bool* auto_setup_scope) {
  if (!Dart_IsString(name)) {
    return NULL;
  }
  Dart_NativeFunction result = NULL;
  if (auto_setup_scope == NULL) {
    return NULL;
  }

  Dart_EnterScope();
  const char* cname;
  handle_error(Dart_StringToCString(name, &cname));

  for (int i=0; function_list[i].name != NULL; ++i) {
    if (strcmp(function_list[i].name, cname) == 0) {
      *auto_setup_scope = true;
      result = function_list[i].function;
      break;
    }
  }

  if (result != NULL) {
    Dart_ExitScope();
    return result;
  }

  Dart_ExitScope();
  return result;
}
