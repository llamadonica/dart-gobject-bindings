library xlib.gdart;

import "gdart.dart";


class Display extends GObjectBase {
  Display.fromNative();
}

class Screen extends GObjectBase {
  Screen.fromNative();
}

class Visual extends GObjectBase {
  Visual.fromNative();
}

class XEvent extends GObjectBase {
  XEvent.fromNative();
}

class XConfigureEvent extends GObjectBase {
  XConfigureEvent.fromNative();
}

class XImage extends GObjectBase {
  XImage.fromNative();
}

class XFontStruct extends GObjectBase {
  XFontStruct.fromNative();
}

class XTrapezoid extends GObjectBase {
  XTrapezoid.fromNative();
}

class XVisualInfo extends GObjectBase {
  XVisualInfo.fromNative();
}

class XWindowAttributes extends GObjectBase {
  XWindowAttributes.fromNative();
}

void openDisplay() => callStaticGlobal('xlib', 'open_display', []);

bool _initLibraryStarted = false;

void initLibrary() {
  if (_initLibraryStarted) return;
  _initLibraryStarted = true;
  registerInterceptorTypeForNamedType("xlib", "Display",Display);
  registerInterceptorTypeForNamedType("xlib", "Screen",Screen);
  registerInterceptorTypeForNamedType("xlib", "Visual",Visual);
  registerInterceptorTypeForNamedType("xlib", "XEvent",XEvent);
  registerInterceptorTypeForNamedType("xlib", "XConfigureEvent",XConfigureEvent);
  registerInterceptorTypeForNamedType("xlib", "XImage",XImage);
  registerInterceptorTypeForNamedType("xlib", "XFontStruct",XFontStruct);
  registerInterceptorTypeForNamedType("xlib", "XTrapezoid",XTrapezoid);
  registerInterceptorTypeForNamedType("xlib", "XVisualInfo",XVisualInfo);
  registerInterceptorTypeForNamedType("xlib", "XWindowAttributes",XWindowAttributes);
}
