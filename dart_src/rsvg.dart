library rsvg.gdart;

import "gdart.dart";

import "cairo.dart" hide initLibrary;
import "cairo.dart" as cairo;
import "glib.dart" hide initLibrary;
import "glib.dart" as glib;
import "gio.dart" hide initLibrary;
import "gio.dart" as gio;
import "gobject.dart" hide initLibrary;
import "gobject.dart" as gobject;
import "gmodule.dart" hide initLibrary;
import "gmodule.dart" as gmodule;
import "gdkpixbuf.dart" hide initLibrary;
import "gdkpixbuf.dart" as gdkpixbuf;

class DimensionData extends GObjectBase {
  DimensionData.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Rsvg', 'DimensionData');

  int get width => getFieldOfObject('width', 0);
  void set width(int value) => setFieldOfObject('width', 0, value);
  int get height => getFieldOfObject('height', 1);
  void set height(int value) => setFieldOfObject('height', 1, value);
  num get em => getFieldOfObject('em', 2);
  void set em(num value) => setFieldOfObject('em', 2, value);
  num get ex => getFieldOfObject('ex', 3);
  void set ex(num value) => setFieldOfObject('ex', 3, value);
}

class ErrorCode extends GEnumBase {
  const ErrorCode(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Rsvg', 'Error');

  static const ErrorCode FAILED = const ErrorCode(0);
  String toString() {
    switch(index) {
      case 0: return 'ErrorCode.FAILED';
      default: return 'new ErrorCode($index)';
    }
  }
  static int quark() => _staticInfo.callStatic('quark', []);
}

class Error extends GErrorBase {
  static final int _quark = lookupErrorQuarkFromString('rsvg-error-quark');
  Error(ErrorCode code, String message)
      : super.fromFields(_quark, code, message);
}

class Handle extends GObjectObject {
  Handle.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Rsvg', 'Handle');

  static const String BASE_URI_PROPERTY = 'base-uri';
  String get desc => _staticInfo.getGPropertyOnReceiver('desc', this);
  static const String DESC_PROPERTY = 'desc';
  num get dpiX => _staticInfo.getGPropertyOnReceiver('dpi-x', this);
  void set dpiX(num value) => _staticInfo.setGPropertyOnReceiver('dpi-x', this, value);
  static const String DPI_X_PROPERTY = 'dpi-x';
  num get dpiY => _staticInfo.getGPropertyOnReceiver('dpi-y', this);
  void set dpiY(num value) => _staticInfo.setGPropertyOnReceiver('dpi-y', this, value);
  static const String DPI_Y_PROPERTY = 'dpi-y';
  num get em => _staticInfo.getGPropertyOnReceiver('em', this);
  static const String EM_PROPERTY = 'em';
  num get ex => _staticInfo.getGPropertyOnReceiver('ex', this);
  static const String EX_PROPERTY = 'ex';
  HandleFlags get flags => _staticInfo.getGPropertyOnReceiver('flags', this);
  void set flags(HandleFlags value) => _staticInfo.setGPropertyOnReceiver('flags', this, value);
  static const String FLAGS_PROPERTY = 'flags';
  int get height => _staticInfo.getGPropertyOnReceiver('height', this);
  static const String HEIGHT_PROPERTY = 'height';
  String get metadata => _staticInfo.getGPropertyOnReceiver('metadata', this);
  static const String METADATA_PROPERTY = 'metadata';
  String get title => _staticInfo.getGPropertyOnReceiver('title', this);
  static const String TITLE_PROPERTY = 'title';
  int get width => _staticInfo.getGPropertyOnReceiver('width', this);
  static const String WIDTH_PROPERTY = 'width';
  factory Handle() => _staticInfo.callStatic('new', []);
  factory Handle.fromData(List<int> data) => _staticInfo.callStatic('new_from_data', [data]);
  factory Handle.fromFile(String fileName) => _staticInfo.callStatic('new_from_file', [fileName]);
  factory Handle.fromGfileSync(File file, HandleFlags flags, Cancellable cancellable) => _staticInfo.callStatic('new_from_gfile_sync', [file, flags, cancellable]);
  factory Handle.fromStreamSync(InputStream inputStream, File baseFile, HandleFlags flags, Cancellable cancellable) => _staticInfo.callStatic('new_from_stream_sync', [inputStream, baseFile, flags, cancellable]);
  factory Handle.withFlags(HandleFlags flags) => _staticInfo.callStatic('new_with_flags', [flags]);
  void close() => _staticInfo.callMethodOnReceiver('close', this, []);
  String get baseUri => _staticInfo.callMethodOnReceiver('get_base_uri', this, []);
  DimensionData get dimensions => _staticInfo.callMethodOnReceiver('get_dimensions', this, []);
  List getDimensionsSub(String id) => _staticInfo.callMethodOnReceiver('get_dimensions_sub', this, [id]);
  Pixbuf get pixbuf => _staticInfo.callMethodOnReceiver('get_pixbuf', this, []);
  Pixbuf getPixbufSub(String id) => _staticInfo.callMethodOnReceiver('get_pixbuf_sub', this, [id]);
  List getPositionSub(String id) => _staticInfo.callMethodOnReceiver('get_position_sub', this, [id]);
  bool hasSub(String id) => _staticInfo.callMethodOnReceiver('has_sub', this, [id]);
  void readStreamSync(InputStream stream, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('read_stream_sync', this, [stream, cancellable]);
  bool renderCairo(Context cr) => _staticInfo.callMethodOnReceiver('render_cairo', this, [cr]);
  bool renderCairoSub(Context cr, String id) => _staticInfo.callMethodOnReceiver('render_cairo_sub', this, [cr, id]);
  void setBaseGfile(File baseFile) => _staticInfo.callMethodOnReceiver('set_base_gfile', this, [baseFile]);
  void set baseUri(String baseUri) => _staticInfo.callMethodOnReceiver('set_base_uri', this, [baseUri]);
  void setDpi(num dpi) => _staticInfo.callMethodOnReceiver('set_dpi', this, [dpi]);
  void setDpiXY(num dpiX, num dpiY) => _staticInfo.callMethodOnReceiver('set_dpi_x_y', this, [dpiX, dpiY]);
  void write(List<int> buf) => _staticInfo.callMethodOnReceiver('write', this, [buf]);
  HandlePrivate get priv => getFieldOfObject('priv', 1);
  List<dynamic /* this will fail */> get AbiPadding => getFieldOfObject('_abi_padding', 2);
}

class HandleFlags extends GEnumBase {
  const HandleFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Rsvg', 'HandleFlags');

  static const HandleFlags FLAGS_NONE = const HandleFlags(0);
  bool get flagsNone => (index & 0) == 0;
  static const HandleFlags FLAG_UNLIMITED = const HandleFlags(1);
  bool get flagUnlimited => (index & 1) == 1;
  static const HandleFlags FLAG_KEEP_IMAGE_DATA = const HandleFlags(2);
  bool get flagKeepImageData => (index & 2) == 2;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'HandleFlags.FLAG_UNLIMITED';
      case 2: return 'HandleFlags.FLAG_KEEP_IMAGE_DATA';
      default: return 'new HandleFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'HandleFlags.FLAGS_NONE';
    }
    List codes = [];
    for (var i=1; i <= 2; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  HandleFlags operator|(HandleFlags other) =>
    new HandleFlags(index | other.index);
  HandleFlags operator&(HandleFlags other) =>
    new HandleFlags(index & other.index);
}

class HandlePrivate extends GObjectBase {
  HandlePrivate.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Rsvg', 'HandlePrivate');

}

class PositionData extends GObjectBase {
  PositionData.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Rsvg', 'PositionData');

  int get x => getFieldOfObject('x', 0);
  void set x(int value) => setFieldOfObject('x', 0, value);
  int get y => getFieldOfObject('y', 1);
  void set y(int value) => setFieldOfObject('y', 1, value);
}

void cleanup() => callStaticGlobal('Rsvg', 'cleanup', []);

int errorQuark() => callStaticGlobal('Rsvg', 'error_quark', []);

void setDefaultDpi(num dpi) => callStaticGlobal('Rsvg', 'set_default_dpi', [dpi]);

void setDefaultDpiXY(num dpiX, num dpiY) => callStaticGlobal('Rsvg', 'set_default_dpi_x_y', [dpiX, dpiY]);

bool _initLibraryStarted = false;

void initLibrary() {
  if (_initLibraryStarted) return;
  _initLibraryStarted = true;
  cairo.initLibrary();
  gio.initLibrary();
  gdkpixbuf.initLibrary();
  gobject.initLibrary();
  glib.initLibrary();
  registerInterceptorTypeForNamedType("Rsvg", "DimensionData",DimensionData);
  registerInterceptorTypeForNamedType("Rsvg", "Error",ErrorCode);
  registerInterceptorTypeForNamedType("Rsvg", "Handle",Handle);
  registerInterceptorTypeForNamedType("Rsvg", "HandleFlags",HandleFlags);
  registerInterceptorTypeForNamedType("Rsvg", "HandlePrivate",HandlePrivate);
  registerInterceptorTypeForNamedType("Rsvg", "PositionData",PositionData);
  registerInterceptorTypeForErrorDomain("rsvg-error-quark", Error);
}
