library gmodule.gdart;

import "gdart.dart";

import "glib.dart" as glib;

class Module extends GObjectBase {
  Module.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GModule', 'Module');

  bool close() => _staticInfo.callMethodOnReceiver('close', this, []);
  void makeResident() => _staticInfo.callMethodOnReceiver('make_resident', this, []);
  String name() => _staticInfo.callMethodOnReceiver('name', this, []);
  List symbol(String symbolName) => _staticInfo.callMethodOnReceiver('symbol', this, [symbolName]);
  static String buildPath(String directory, String moduleName) => _staticInfo.callStatic('build_path', [directory, moduleName]);
  static String error() => _staticInfo.callStatic('error', []);
  static bool supported() => _staticInfo.callStatic('supported', []);
}

typedef String ModuleCheckInit(Module module);
class ModuleFlags extends GEnumBase {
  const ModuleFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GModule', 'ModuleFlags');

  static const ModuleFlags NULL = const ModuleFlags(0);
  static const ModuleFlags LAZY = const ModuleFlags(1);
  bool get lazy => (value & 1) == 1;
  static const ModuleFlags LOCAL = const ModuleFlags(2);
  bool get local => (value & 2) == 2;
  static const ModuleFlags MASK = const ModuleFlags(3);
  bool get mask => (value & 3) == 3;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'ModuleFlags.LAZY';
      case 2: return 'ModuleFlags.LOCAL';
      default: return 'new ModuleFlags($value)';
    }
  }
  String toString() {
    if (value == 0) {
      return 'ModuleFlags.NULL';
    }
    List codes = [];
    for (var i=1; i <= 2; i <<= 1) {
      if (value & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  ModuleFlags operator|(ModuleFlags other) =>
    new ModuleFlags(value | other.value);
  ModuleFlags operator&(ModuleFlags other) =>
    new ModuleFlags(value & other.value);
}

typedef void ModuleUnload(Module module);
String moduleBuildPath(String directory, String moduleName) => callStaticGlobal('GModule', 'module_build_path', [directory, moduleName]);

String moduleError() => callStaticGlobal('GModule', 'module_error', []);

bool moduleSupported() => callStaticGlobal('GModule', 'module_supported', []);

bool _initLibraryStarted = false;

void initLibrary() {
  if (_initLibraryStarted) return;
  _initLibraryStarted = true;
  glib.initLibrary();
  registerInterceptorTypeForNamedType("GModule", "Module",Module);
  registerInterceptorTypeForNamedType("GModule", "ModuleFlags",ModuleFlags);
}
