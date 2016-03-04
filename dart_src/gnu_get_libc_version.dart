// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library gjs_integration.gnu_get_libc_version;

import 'dart:async';
import 'dart:math';

import 'gdart.dart' as gdart;
import 'introspection_compat_classes.dart';
import 'girepository.dart' as girepository;

main() {
  var x = new FunctionInfo(
      TypeInfo.string,
      "gnu_get_libc_version",
      [],
      new FunctionSymbol("/lib/libc.so.6", "gnu_get_libc_version"),
      callerOwns: girepository.Transfer.NOTHING);
  var result = x.call([]);
  print(result);
}
