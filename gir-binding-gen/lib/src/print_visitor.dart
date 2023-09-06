import 'dart:io';

import './visitor.dart';

class PrintVisitor extends BaseVisitor<void> {
  int _indent = 0;

  @override
  void visitBaseInfo(BaseInfoVisitable info) {
    stdout.write('${'  ' * _indent}${info.shortTypeName} ${info.name}');
    if (info.children.isNotEmpty) {
      stdout.write(':');
    }
    stdout.writeln();
    _indent++;
    info.visitChildren(this);
    _indent--;
  }

  @override
  void visitBaseInfoAttribute(BaseInfoAttributeVisitable attribute) {
    stdout.write('${'  ' * _indent}${attribute.shortTypeName} ${attribute.name}=${attribute.value}');
    if (attribute.children.isNotEmpty) {
      stdout.write(':');
    }
    stdout.writeln();
    _indent++;
    attribute.visitChildren(this);
    _indent--;
  }

  @override
  void visitNamespaceInfo(NamespaceEntity info) {
    stdout.write('${'  ' * _indent}${info.shortTypeName} ${info.name}');
    if (info.children.isNotEmpty) {
      stdout.write(':');
    }
    stdout.writeln();
    _indent++;
    info.visitChildren(this);
    _indent--;
  }

  @override
  void visitNamespacesInfo(NamespacesEntity info) {
    print('${'  ' * _indent}${info.shortTypeName}:');
    _indent++;
    info.visitChildren(this);
    _indent--;
  }

  @override
  void visitParameterizedType(ParameterizedType parameterizedType) {
    stdout.write('${'  ' * _indent}${parameterizedType.shortTypeName}');
    if (parameterizedType.children.isNotEmpty) {
      stdout.write(':');
    }
    stdout.writeln();
    _indent++;
    parameterizedType.visitChildren(this);
    _indent--;
  }

  @override
  void visitTypeInfo(TypeInfoVisitable info) {
    stdout.write('${'  ' * _indent}${info.shortTypeName} ${info.name}');
    if (info.children.isNotEmpty) {
      stdout.write(':');
    }
    stdout.writeln();
    _indent++;
    info.visitChildren(this);
    _indent--;
  }

  @override
  void visitConstantValue(ConstantValueVisitable info) {
    stdout.write('${'  ' * _indent}${info.shortTypeName} ${info.renderValue()}');
    if (info.children.isNotEmpty) {
      stdout.write(':');
    }
    stdout.writeln();
    _indent++;
    info.visitChildren(this);
    _indent--;
  }

  @override
  void visitUnknownConstantValue(UnknownConstantValueVisitable info) {
    stdout.write('${'  ' * _indent}${info.shortTypeName}');
    if (info.children.isNotEmpty) {
      stdout.write(':');
    }
    stdout.writeln();
    _indent++;
    info.visitChildren(this);
    _indent--;
  }
}