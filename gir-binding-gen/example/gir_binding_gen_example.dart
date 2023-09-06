import 'package:gir_binding_gen/gir_binding_gen.dart';
import 'package:gir_binding_gen/src/print_visitor.dart';
import 'package:gir_binding_gen/src/visitor.dart';
import 'package:gir_bootstrapper/gir_bootstrapper.dart';

void main() {
  var repo = Repository.getDefault();
  repo.require('Gtk');
  final namespaces = NamespacesEntity(repo, repo.getLoadedNamespaces());
  final printVisitor = PrintVisitor();
  namespaces.visitChildren(printVisitor);
}
