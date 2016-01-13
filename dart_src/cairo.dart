library cairo.gdart;

import "gdart.dart";


class Context extends GObjectBase {
  Context.fromNative();
}

class Surface extends GObjectBase {
  Surface.fromNative();
}

class Matrix extends GObjectBase {
  Matrix.fromNative();
}

class CairoPattern extends GObjectBase {
  CairoPattern.fromNative();
}

class Region extends GObjectBase {
  Region.fromNative();
}

class Content extends GEnumBase {
  const Content(int value) : super(value);
  static const Content COLOR = const Content(4096);
  static const Content ALPHA = const Content(8192);
  static const Content COLOR_ALPHA = const Content(12288);
  String toString() {
    switch(value) {
      case 4096: return 'Content.COLOR';
      case 8192: return 'Content.ALPHA';
      case 12288: return 'Content.COLOR_ALPHA';
      default: return 'new Content($value)';
    }
  }
}

class FontOptions extends GObjectBase {
  FontOptions.fromNative();
}

class FontType extends GObjectBase {
  FontType.fromNative();
}

class FontFace extends GObjectBase {
  FontFace.fromNative();
}

class ScaledFont extends GObjectBase {
  ScaledFont.fromNative();
}

class Path extends GObjectBase {
  Path.fromNative();
}

class RectangleInt extends GObjectBase {
  RectangleInt.fromNative();
  int get x => getFieldOfObject('x', 0);
  void set x(int value) => setFieldOfObject('x', 0, value);
  int get y => getFieldOfObject('y', 1);
  void set y(int value) => setFieldOfObject('y', 1, value);
  int get width => getFieldOfObject('width', 2);
  void set width(int value) => setFieldOfObject('width', 2, value);
  int get height => getFieldOfObject('height', 3);
  void set height(int value) => setFieldOfObject('height', 3, value);
}

void imageSurfaceCreate() => callStaticGlobal('cairo', 'image_surface_create', []);

bool _initLibraryStarted = false;

void initLibrary() {
  if (_initLibraryStarted) return;
  _initLibraryStarted = true;
  registerInterceptorTypeForNamedType("cairo", "Context",Context);
  registerInterceptorTypeForNamedType("cairo", "Surface",Surface);
  registerInterceptorTypeForNamedType("cairo", "Matrix",Matrix);
  registerInterceptorTypeForNamedType("cairo", "Pattern",CairoPattern);
  registerInterceptorTypeForNamedType("cairo", "Region",Region);
  registerInterceptorTypeForNamedType("cairo", "Content",Content);
  registerInterceptorTypeForNamedType("cairo", "FontOptions",FontOptions);
  registerInterceptorTypeForNamedType("cairo", "FontType",FontType);
  registerInterceptorTypeForNamedType("cairo", "FontFace",FontFace);
  registerInterceptorTypeForNamedType("cairo", "ScaledFont",ScaledFont);
  registerInterceptorTypeForNamedType("cairo", "Path",Path);
  registerInterceptorTypeForNamedType("cairo", "RectangleInt",RectangleInt);
}
