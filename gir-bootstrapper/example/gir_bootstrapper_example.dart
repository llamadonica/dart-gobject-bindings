import 'package:gir_bootstrapper/gir_bootstrapper.dart';

void main() {
  var repo = Repository.getDefault();
  repo.require('Gtk');
  for (final info in repo.getInfos('Gtk')) {
    print('$info ${info.namespace}.${info.name}');
    if (info is RegisteredTypeInfo) {
      print('  gtype: ${info.gType}');
    }
    for (final attribute in info.attributes) {
      print('  $attribute');
    }

  }
}
