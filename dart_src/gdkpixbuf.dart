library gdkpixbuf.gdart;

import "gdart.dart";

import "dart:async";

import "glib.dart" hide initLibrary;
import "gio.dart" hide initLibrary;
import "gio.dart" as gio;
import "gobject.dart" hide initLibrary;
import "gmodule.dart" as gmodule;

class Colorspace extends GEnumBase {
  const Colorspace(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GdkPixbuf', 'Colorspace');

  static const Colorspace RGB = const Colorspace(0);
  String toString() {
    switch(value) {
      case 0: return 'Colorspace.RGB';
      default: return 'new Colorspace($value)';
    }
  }
}

class InterpType extends GEnumBase {
  const InterpType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GdkPixbuf', 'InterpType');

  static const InterpType NEAREST = const InterpType(0);
  static const InterpType TILES = const InterpType(1);
  static const InterpType BILINEAR = const InterpType(2);
  static const InterpType HYPER = const InterpType(3);
  String toString() {
    switch(value) {
      case 0: return 'InterpType.NEAREST';
      case 1: return 'InterpType.TILES';
      case 2: return 'InterpType.BILINEAR';
      case 3: return 'InterpType.HYPER';
      default: return 'new InterpType($value)';
    }
  }
}

class Pixbuf extends GObjectObject with Icon, LoadableIcon {
  Pixbuf.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GdkPixbuf', 'Pixbuf');

  void set bitsPerSample(int value) => setGProperty('bits-per-sample', value);
  static const String BITS_PER_SAMPLE_PROPERTY = 'bits-per-sample';
  void set colorspace(Colorspace value) => setGProperty('colorspace', value);
  static const String COLORSPACE_PROPERTY = 'colorspace';
  void set hasAlpha(bool value) => setGProperty('has-alpha', value);
  static const String HAS_ALPHA_PROPERTY = 'has-alpha';
  void set height(int value) => setGProperty('height', value);
  static const String HEIGHT_PROPERTY = 'height';
  void set nChannels(int value) => setGProperty('n-channels', value);
  static const String N_CHANNELS_PROPERTY = 'n-channels';
  Bytes get pixelBytes => getGProperty('pixel-bytes');
  void set pixelBytes(Bytes value) => setGProperty('pixel-bytes', value);
  static const String PIXEL_BYTES_PROPERTY = 'pixel-bytes';
  void set pixels(dynamic value /* this will fail */) => setGProperty('pixels', value);
  static const String PIXELS_PROPERTY = 'pixels';
  void set rowstride(int value) => setGProperty('rowstride', value);
  static const String ROWSTRIDE_PROPERTY = 'rowstride';
  void set width(int value) => setGProperty('width', value);
  static const String WIDTH_PROPERTY = 'width';
  factory Pixbuf(Colorspace colorspace, bool hasAlpha, int bitsPerSample, int width, int height) => _staticInfo.callStatic('new', [colorspace, hasAlpha, bitsPerSample, width, height]);
  factory Pixbuf.fromBytes(Bytes data, Colorspace colorspace, bool hasAlpha, int bitsPerSample, int width, int height, int rowstride) => _staticInfo.callStatic('new_from_bytes', [data, colorspace, hasAlpha, bitsPerSample, width, height, rowstride]);
  factory Pixbuf.fromData(List<int> data, Colorspace colorspace, bool hasAlpha, int bitsPerSample, int width, int height, int rowstride, PixbufDestroyNotify destroyFn) => _staticInfo.callStatic('new_from_data', [data, colorspace, hasAlpha, bitsPerSample, width, height, rowstride, destroyFn]);
  factory Pixbuf.fromFile(String filename) => _staticInfo.callStatic('new_from_file', [filename]);
  factory Pixbuf.fromFileAtScale(String filename, int width, int height, bool preserveAspectRatio) => _staticInfo.callStatic('new_from_file_at_scale', [filename, width, height, preserveAspectRatio]);
  factory Pixbuf.fromFileAtSize(String filename, int width, int height) => _staticInfo.callStatic('new_from_file_at_size', [filename, width, height]);
  factory Pixbuf.fromInline(List<int> data, bool copyPixels) => _staticInfo.callStatic('new_from_inline', [data, copyPixels]);
  factory Pixbuf.fromResource(String resourcePath) => _staticInfo.callStatic('new_from_resource', [resourcePath]);
  factory Pixbuf.fromResourceAtScale(String resourcePath, int width, int height, bool preserveAspectRatio) => _staticInfo.callStatic('new_from_resource_at_scale', [resourcePath, width, height, preserveAspectRatio]);
  factory Pixbuf.fromStream(InputStream stream, Cancellable cancellable) => _staticInfo.callStatic('new_from_stream', [stream, cancellable]);
  factory Pixbuf.fromStreamAtScale(InputStream stream, int width, int height, bool preserveAspectRatio, Cancellable cancellable) => _staticInfo.callStatic('new_from_stream_at_scale', [stream, width, height, preserveAspectRatio, cancellable]);
  factory Pixbuf.fromStreamFinish(AsyncResult asyncResult) => _staticInfo.callStatic('new_from_stream_finish', [asyncResult]);
  factory Pixbuf.fromXpmData(List<String> data) => _staticInfo.callStatic('new_from_xpm_data', [data]);
  static Pixbuf fromPixdata(Pixdata pixdata, bool copyPixels) => _staticInfo.callStatic('from_pixdata', [pixdata, copyPixels]);
  static List getFileInfo(String filename) => _staticInfo.callStatic('get_file_info', [filename]);
  static void getFileInfoAsync(String filename, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callStatic('get_file_info_async', [filename, cancellable, callback]);
  static List getFileInfoFinish(AsyncResult asyncResult) => _staticInfo.callStatic('get_file_info_finish', [asyncResult]);
  static SList /* this will fail */ getFormats() => _staticInfo.callStatic('get_formats', []);
  static void newFromStreamAsync(InputStream stream, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callStatic('new_from_stream_async', [stream, cancellable, callback]);
  static void newFromStreamAtScaleAsync(InputStream stream, int width, int height, bool preserveAspectRatio, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callStatic('new_from_stream_at_scale_async', [stream, width, height, preserveAspectRatio, cancellable, callback]);
  static void saveToStreamFinish(AsyncResult asyncResult) => _staticInfo.callStatic('save_to_stream_finish', [asyncResult]);
  Pixbuf addAlpha(bool substituteColor, int r, int g, int b) => _staticInfo.callMethodOnReceiver('add_alpha', this, [substituteColor, r, g, b]);
  Pixbuf applyEmbeddedOrientation() => _staticInfo.callMethodOnReceiver('apply_embedded_orientation', this, []);
  void composite(Pixbuf dest, int destX, int destY, int destWidth, int destHeight, num offsetX, num offsetY, num scaleX, num scaleY, InterpType interpType, int overallAlpha) => _staticInfo.callMethodOnReceiver('composite', this, [dest, destX, destY, destWidth, destHeight, offsetX, offsetY, scaleX, scaleY, interpType, overallAlpha]);
  void compositeColor(Pixbuf dest, int destX, int destY, int destWidth, int destHeight, num offsetX, num offsetY, num scaleX, num scaleY, InterpType interpType, int overallAlpha, int checkX, int checkY, int checkSize, int color1, int color2) => _staticInfo.callMethodOnReceiver('composite_color', this, [dest, destX, destY, destWidth, destHeight, offsetX, offsetY, scaleX, scaleY, interpType, overallAlpha, checkX, checkY, checkSize, color1, color2]);
  Pixbuf compositeColorSimple(int destWidth, int destHeight, InterpType interpType, int overallAlpha, int checkSize, int color1, int color2) => _staticInfo.callMethodOnReceiver('composite_color_simple', this, [destWidth, destHeight, interpType, overallAlpha, checkSize, color1, color2]);
  Pixbuf copy() => _staticInfo.callMethodOnReceiver('copy', this, []);
  void copyArea(int srcX, int srcY, int width, int height, Pixbuf destPixbuf, int destX, int destY) => _staticInfo.callMethodOnReceiver('copy_area', this, [srcX, srcY, width, height, destPixbuf, destX, destY]);
  void fill(int pixel) => _staticInfo.callMethodOnReceiver('fill', this, [pixel]);
  Pixbuf flip(bool horizontal) => _staticInfo.callMethodOnReceiver('flip', this, [horizontal]);
  int get bitsPerSample_ => _staticInfo.callMethodOnReceiver('get_bits_per_sample', this, []);
  int get byteLength => _staticInfo.callMethodOnReceiver('get_byte_length', this, []);
  Colorspace get colorspace_ => _staticInfo.callMethodOnReceiver('get_colorspace', this, []);
  bool get hasAlpha_ => _staticInfo.callMethodOnReceiver('get_has_alpha', this, []);
  int get height_ => _staticInfo.callMethodOnReceiver('get_height', this, []);
  int get nChannels_ => _staticInfo.callMethodOnReceiver('get_n_channels', this, []);
  String getOption(String key) => _staticInfo.callMethodOnReceiver('get_option', this, [key]);
  HashTable get options => _staticInfo.callMethodOnReceiver('get_options', this, []);
  List getPixels() => _staticInfo.callMethodOnReceiver('get_pixels', this, []);
  int get rowstride_ => _staticInfo.callMethodOnReceiver('get_rowstride', this, []);
  int get width_ => _staticInfo.callMethodOnReceiver('get_width', this, []);
  Pixbuf newSubpixbuf(int srcX, int srcY, int width, int height) => _staticInfo.callMethodOnReceiver('new_subpixbuf', this, [srcX, srcY, width, height]);
  Bytes readPixelBytes() => _staticInfo.callMethodOnReceiver('read_pixel_bytes', this, []);
  int readPixels() => _staticInfo.callMethodOnReceiver('read_pixels', this, []);
  Pixbuf rotateSimple(PixbufRotation angle) => _staticInfo.callMethodOnReceiver('rotate_simple', this, [angle]);
  void saturateAndPixelate(Pixbuf dest, num saturation, bool pixelate) => _staticInfo.callMethodOnReceiver('saturate_and_pixelate', this, [dest, saturation, pixelate]);
  List saveToBufferv(String type, List<String> optionKeys, List<String> optionValues) => _staticInfo.callMethodOnReceiver('save_to_bufferv', this, [type, optionKeys, optionValues]);
  void saveToCallbackv(PixbufSaveFunc saveFunc, String type, List<String> optionKeys, List<String> optionValues) => _staticInfo.callMethodOnReceiver('save_to_callbackv', this, [saveFunc, type, optionKeys, optionValues]);
  void savev(String filename, String type, List<String> optionKeys, List<String> optionValues) => _staticInfo.callMethodOnReceiver('savev', this, [filename, type, optionKeys, optionValues]);
  void scale(Pixbuf dest, int destX, int destY, int destWidth, int destHeight, num offsetX, num offsetY, num scaleX, num scaleY, InterpType interpType) => _staticInfo.callMethodOnReceiver('scale', this, [dest, destX, destY, destWidth, destHeight, offsetX, offsetY, scaleX, scaleY, interpType]);
  Pixbuf scaleSimple(int destWidth, int destHeight, InterpType interpType) => _staticInfo.callMethodOnReceiver('scale_simple', this, [destWidth, destHeight, interpType]);
}

class PixbufAlphaMode extends GEnumBase {
  const PixbufAlphaMode(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GdkPixbuf', 'PixbufAlphaMode');

  static const PixbufAlphaMode BILEVEL = const PixbufAlphaMode(0);
  static const PixbufAlphaMode FULL = const PixbufAlphaMode(1);
  String toString() {
    switch(value) {
      case 0: return 'PixbufAlphaMode.BILEVEL';
      case 1: return 'PixbufAlphaMode.FULL';
      default: return 'new PixbufAlphaMode($value)';
    }
  }
}

class PixbufAnimation extends GObjectObject {
  PixbufAnimation.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GdkPixbuf', 'PixbufAnimation');

  factory PixbufAnimation.fromFile(String filename) => _staticInfo.callStatic('new_from_file', [filename]);
  factory PixbufAnimation.fromResource(String resourcePath) => _staticInfo.callStatic('new_from_resource', [resourcePath]);
  factory PixbufAnimation.fromStream(InputStream stream, Cancellable cancellable) => _staticInfo.callStatic('new_from_stream', [stream, cancellable]);
  factory PixbufAnimation.fromStreamFinish(AsyncResult asyncResult) => _staticInfo.callStatic('new_from_stream_finish', [asyncResult]);
  static void newFromStreamAsync(InputStream stream, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callStatic('new_from_stream_async', [stream, cancellable, callback]);
  int get height => _staticInfo.callMethodOnReceiver('get_height', this, []);
  PixbufAnimationIter getIter(TimeVal startTime) => _staticInfo.callMethodOnReceiver('get_iter', this, [startTime]);
  Pixbuf get staticImage => _staticInfo.callMethodOnReceiver('get_static_image', this, []);
  int get width => _staticInfo.callMethodOnReceiver('get_width', this, []);
  bool isStaticImage() => _staticInfo.callMethodOnReceiver('is_static_image', this, []);
}

class PixbufAnimationIter extends GObjectObject {
  PixbufAnimationIter.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GdkPixbuf', 'PixbufAnimationIter');

  bool advance(TimeVal currentTime) => _staticInfo.callMethodOnReceiver('advance', this, [currentTime]);
  int get delayTime => _staticInfo.callMethodOnReceiver('get_delay_time', this, []);
  Pixbuf get pixbuf => _staticInfo.callMethodOnReceiver('get_pixbuf', this, []);
  bool onCurrentlyLoadingFrame() => _staticInfo.callMethodOnReceiver('on_currently_loading_frame', this, []);
}

typedef void PixbufDestroyNotify(List<int> pixels);
class PixbufErrorCode extends GEnumBase {
  const PixbufErrorCode(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GdkPixbuf', 'PixbufError');

  static const PixbufErrorCode CORRUPT_IMAGE = const PixbufErrorCode(0);
  static const PixbufErrorCode INSUFFICIENT_MEMORY = const PixbufErrorCode(1);
  static const PixbufErrorCode BAD_OPTION = const PixbufErrorCode(2);
  static const PixbufErrorCode UNKNOWN_TYPE = const PixbufErrorCode(3);
  static const PixbufErrorCode UNSUPPORTED_OPERATION = const PixbufErrorCode(4);
  static const PixbufErrorCode FAILED = const PixbufErrorCode(5);
  String toString() {
    switch(value) {
      case 0: return 'PixbufErrorCode.CORRUPT_IMAGE';
      case 1: return 'PixbufErrorCode.INSUFFICIENT_MEMORY';
      case 2: return 'PixbufErrorCode.BAD_OPTION';
      case 3: return 'PixbufErrorCode.UNKNOWN_TYPE';
      case 4: return 'PixbufErrorCode.UNSUPPORTED_OPERATION';
      case 5: return 'PixbufErrorCode.FAILED';
      default: return 'new PixbufErrorCode($value)';
    }
  }
  static int quark() => _staticInfo.callStatic('quark', []);
}

class PixbufError extends GErrorBase {
  static final int _quark = lookupErrorQuarkFromString('gdk-pixbuf-error-quark');
  PixbufError(PixbufErrorCode code, String message)
      : super.fromFields(_quark, code, message);
}

class PixbufFormat extends GObjectBase {
  PixbufFormat.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GdkPixbuf', 'PixbufFormat');

  PixbufFormat copy() => _staticInfo.callMethodOnReceiver('copy', this, []);
  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
  String get description => _staticInfo.callMethodOnReceiver('get_description', this, []);
  List<String> get extensions => _staticInfo.callMethodOnReceiver('get_extensions', this, []);
  String get license => _staticInfo.callMethodOnReceiver('get_license', this, []);
  List<String> get mimeTypes => _staticInfo.callMethodOnReceiver('get_mime_types', this, []);
  String get name => _staticInfo.callMethodOnReceiver('get_name', this, []);
  bool isDisabled() => _staticInfo.callMethodOnReceiver('is_disabled', this, []);
  bool isScalable() => _staticInfo.callMethodOnReceiver('is_scalable', this, []);
  bool isWritable() => _staticInfo.callMethodOnReceiver('is_writable', this, []);
  void setDisabled(bool disabled) => _staticInfo.callMethodOnReceiver('set_disabled', this, [disabled]);
}

class PixbufLoader extends GObjectObject {
  PixbufLoader.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GdkPixbuf', 'PixbufLoader');

  factory PixbufLoader() => _staticInfo.callStatic('new', []);
  factory PixbufLoader.withMimeType(String mimeType) => _staticInfo.callStatic('new_with_mime_type', [mimeType]);
  factory PixbufLoader.withType(String imageType) => _staticInfo.callStatic('new_with_type', [imageType]);
  void close() => _staticInfo.callMethodOnReceiver('close', this, []);
  PixbufAnimation get animation => _staticInfo.callMethodOnReceiver('get_animation', this, []);
  PixbufFormat get format => _staticInfo.callMethodOnReceiver('get_format', this, []);
  Pixbuf get pixbuf => _staticInfo.callMethodOnReceiver('get_pixbuf', this, []);
  void setSize(int width, int height) => _staticInfo.callMethodOnReceiver('set_size', this, [width, height]);
  void write(List<int> buf) => _staticInfo.callMethodOnReceiver('write', this, [buf]);
  void writeBytes(Bytes buffer) => _staticInfo.callMethodOnReceiver('write_bytes', this, [buffer]);
  int _connectToAreaPrepared(bool after, void func()) => signalConnect('area-prepared', func, after);
  Stream get onAreaPrepared {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToAreaPrepared(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterAreaPrepared {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToAreaPrepared(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToAreaUpdated(bool after, void func(int x, int y, int width, int height)) => signalConnect('area-updated', func, after);
  Stream<PixbufLoaderAreaUpdatedEvent> get onAreaUpdated {
    int signalId;
    StreamController<PixbufLoaderAreaUpdatedEvent> controller;
    controller = new StreamController<PixbufLoaderAreaUpdatedEvent>(
      onListen: () {
          signalId = _connectToAreaUpdated(false, (int x, int y, int width, int height) {
              var result = new PixbufLoaderAreaUpdatedEvent(x, y, width, height);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<PixbufLoaderAreaUpdatedEvent> get afterAreaUpdated {
    int signalId;
    StreamController<PixbufLoaderAreaUpdatedEvent> controller;
    controller = new StreamController<PixbufLoaderAreaUpdatedEvent>(
      onListen: () {
          signalId = _connectToAreaUpdated(true, (int x, int y, int width, int height) {
              var result = new PixbufLoaderAreaUpdatedEvent(x, y, width, height);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToClosed(bool after, void func()) => signalConnect('closed', func, after);
  Stream get onClosed {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToClosed(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterClosed {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToClosed(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToSizePrepared(bool after, void func(int width, int height)) => signalConnect('size-prepared', func, after);
  Stream<PixbufLoaderSizePreparedEvent> get onSizePrepared {
    int signalId;
    StreamController<PixbufLoaderSizePreparedEvent> controller;
    controller = new StreamController<PixbufLoaderSizePreparedEvent>(
      onListen: () {
          signalId = _connectToSizePrepared(false, (int width, int height) {
              var result = new PixbufLoaderSizePreparedEvent(width, height);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<PixbufLoaderSizePreparedEvent> get afterSizePrepared {
    int signalId;
    StreamController<PixbufLoaderSizePreparedEvent> controller;
    controller = new StreamController<PixbufLoaderSizePreparedEvent>(
      onListen: () {
          signalId = _connectToSizePrepared(true, (int width, int height) {
              var result = new PixbufLoaderSizePreparedEvent(width, height);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
}

class PixbufLoaderAreaUpdatedEvent {
  final int x;
  final int y;
  final int width;
  final int height;

  PixbufLoaderAreaUpdatedEvent(this.x, this.y, this.width, this.height);
}

class PixbufLoaderSizePreparedEvent {
  final int width;
  final int height;

  PixbufLoaderSizePreparedEvent(this.width, this.height);
}

class PixbufRotation extends GEnumBase {
  const PixbufRotation(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GdkPixbuf', 'PixbufRotation');

  static const PixbufRotation NONE = const PixbufRotation(0);
  static const PixbufRotation COUNTERCLOCKWISE = const PixbufRotation(90);
  static const PixbufRotation UPSIDEDOWN = const PixbufRotation(180);
  static const PixbufRotation CLOCKWISE = const PixbufRotation(270);
  String toString() {
    switch(value) {
      case 0: return 'PixbufRotation.NONE';
      case 90: return 'PixbufRotation.COUNTERCLOCKWISE';
      case 180: return 'PixbufRotation.UPSIDEDOWN';
      case 270: return 'PixbufRotation.CLOCKWISE';
      default: return 'new PixbufRotation($value)';
    }
  }
}

typedef List PixbufSaveFunc(List<int> buf);
class PixbufSimpleAnim extends PixbufAnimation {
  PixbufSimpleAnim.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GdkPixbuf', 'PixbufSimpleAnim');

  static const String LOOP_PROPERTY = 'loop';
  factory PixbufSimpleAnim(int width, int height, num rate) => _staticInfo.callStatic('new', [width, height, rate]);
  void addFrame(Pixbuf pixbuf) => _staticInfo.callMethodOnReceiver('add_frame', this, [pixbuf]);
  bool get loop => _staticInfo.callMethodOnReceiver('get_loop', this, []);
  void set loop(bool loop) => _staticInfo.callMethodOnReceiver('set_loop', this, [loop]);
}

class PixbufSimpleAnimIter extends PixbufAnimationIter {
  PixbufSimpleAnimIter.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GdkPixbuf', 'PixbufSimpleAnimIter');

}

class Pixdata extends GObjectBase {
  Pixdata.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GdkPixbuf', 'Pixdata');

  void deserialize(List<int> stream) => _staticInfo.callMethodOnReceiver('deserialize', this, [stream]);
  List serialize() => _staticInfo.callMethodOnReceiver('serialize', this, []);
  GLibString toCsource(String name, PixdataDumpType dumpType) => _staticInfo.callMethodOnReceiver('to_csource', this, [name, dumpType]);
  int get magic => getFieldOfObject('magic', 0);
  void set magic(int value) => setFieldOfObject('magic', 0, value);
  int get length => getFieldOfObject('length', 1);
  void set length(int value) => setFieldOfObject('length', 1, value);
  int get pixdataType => getFieldOfObject('pixdata_type', 2);
  void set pixdataType(int value) => setFieldOfObject('pixdata_type', 2, value);
  int get rowstride => getFieldOfObject('rowstride', 3);
  void set rowstride(int value) => setFieldOfObject('rowstride', 3, value);
  int get width => getFieldOfObject('width', 4);
  void set width(int value) => setFieldOfObject('width', 4, value);
  int get height => getFieldOfObject('height', 5);
  void set height(int value) => setFieldOfObject('height', 5, value);
  List<int> get pixelData => getFieldOfObject('pixel_data', 6);
  void set pixelData(List<int> value) => setFieldOfObject('pixel_data', 6, value);
}

class PixdataDumpType extends GEnumBase {
  const PixdataDumpType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GdkPixbuf', 'PixdataDumpType');

  static const PixdataDumpType PIXDATA_STREAM = const PixdataDumpType(0);
  bool get pixdataStream => (value & 0) == 0;
  static const PixdataDumpType PIXDATA_STRUCT = const PixdataDumpType(1);
  bool get pixdataStruct => (value & 1) == 1;
  static const PixdataDumpType MACROS = const PixdataDumpType(2);
  bool get macros => (value & 2) == 2;
  static const PixdataDumpType GTYPES = const PixdataDumpType(0);
  bool get gtypes => (value & 0) == 0;
  static const PixdataDumpType CTYPES = const PixdataDumpType(256);
  bool get ctypes => (value & 256) == 256;
  static const PixdataDumpType STATIC = const PixdataDumpType(512);
  bool get static_ => (value & 512) == 512;
  static const PixdataDumpType CONST = const PixdataDumpType(1024);
  bool get const_ => (value & 1024) == 1024;
  static const PixdataDumpType RLE_DECODER = const PixdataDumpType(65536);
  bool get rleDecoder => (value & 65536) == 65536;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'PixdataDumpType.PIXDATA_STRUCT';
      case 2: return 'PixdataDumpType.MACROS';
      default: return 'new PixdataDumpType($value)';
    }
  }
  String toString() {
    if (value == 0) {
      return 'PixdataDumpType.PIXDATA_STREAM';
    }
    List codes = [];
    for (var i=1; i <= 65536; i <<= 1) {
      if (value & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  PixdataDumpType operator|(PixdataDumpType other) =>
    new PixdataDumpType(value | other.value);
  PixdataDumpType operator&(PixdataDumpType other) =>
    new PixdataDumpType(value & other.value);
}

class PixdataType extends GEnumBase {
  const PixdataType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GdkPixbuf', 'PixdataType');

  static const PixdataType NULL = const PixdataType(0);
  static const PixdataType COLOR_TYPE_RGB = const PixdataType(1);
  bool get colorTypeRgb => (value & 1) == 1;
  static const PixdataType COLOR_TYPE_RGBA = const PixdataType(2);
  bool get colorTypeRgba => (value & 2) == 2;
  static const PixdataType COLOR_TYPE_MASK = const PixdataType(255);
  bool get colorTypeMask => (value & 255) == 255;
  static const PixdataType SAMPLE_WIDTH_8 = const PixdataType(65536);
  bool get sampleWidth_8 => (value & 65536) == 65536;
  static const PixdataType SAMPLE_WIDTH_MASK = const PixdataType(983040);
  bool get sampleWidthMask => (value & 983040) == 983040;
  static const PixdataType ENCODING_RAW = const PixdataType(16777216);
  bool get encodingRaw => (value & 16777216) == 16777216;
  static const PixdataType ENCODING_RLE = const PixdataType(33554432);
  bool get encodingRle => (value & 33554432) == 33554432;
  static const PixdataType ENCODING_MASK = const PixdataType(251658240);
  bool get encodingMask => (value & 251658240) == 251658240;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'PixdataType.COLOR_TYPE_RGB';
      case 2: return 'PixdataType.COLOR_TYPE_RGBA';
      default: return 'new PixdataType($value)';
    }
  }
  String toString() {
    if (value == 0) {
      return 'PixdataType.NULL';
    }
    List codes = [];
    for (var i=1; i <= 134217728; i <<= 1) {
      if (value & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  PixdataType operator|(PixdataType other) =>
    new PixdataType(value | other.value);
  PixdataType operator&(PixdataType other) =>
    new PixdataType(value & other.value);
}

int pixbufErrorQuark() => callStaticGlobal('GdkPixbuf', 'pixbuf_error_quark', []);

bool _initLibraryStarted = false;

void initLibrary() {
  if (_initLibraryStarted) return;
  _initLibraryStarted = true;
  gio.initLibrary();
  gmodule.initLibrary();
  registerInterceptorTypeForNamedType("GdkPixbuf", "Colorspace",Colorspace);
  registerInterceptorTypeForNamedType("GdkPixbuf", "InterpType",InterpType);
  registerInterceptorTypeForNamedType("GdkPixbuf", "Pixbuf",Pixbuf);
  registerInterceptorTypeForNamedType("GdkPixbuf", "PixbufAlphaMode",PixbufAlphaMode);
  registerInterceptorTypeForNamedType("GdkPixbuf", "PixbufAnimation",PixbufAnimation);
  registerInterceptorTypeForNamedType("GdkPixbuf", "PixbufAnimationIter",PixbufAnimationIter);
  registerInterceptorTypeForNamedType("GdkPixbuf", "PixbufError",PixbufErrorCode);
  registerInterceptorTypeForNamedType("GdkPixbuf", "PixbufFormat",PixbufFormat);
  registerInterceptorTypeForNamedType("GdkPixbuf", "PixbufLoader",PixbufLoader);
  registerInterceptorTypeForNamedType("GdkPixbuf", "PixbufRotation",PixbufRotation);
  registerInterceptorTypeForNamedType("GdkPixbuf", "PixbufSimpleAnim",PixbufSimpleAnim);
  registerInterceptorTypeForNamedType("GdkPixbuf", "PixbufSimpleAnimIter",PixbufSimpleAnimIter);
  registerInterceptorTypeForNamedType("GdkPixbuf", "Pixdata",Pixdata);
  registerInterceptorTypeForNamedType("GdkPixbuf", "PixdataDumpType",PixdataDumpType);
  registerInterceptorTypeForNamedType("GdkPixbuf", "PixdataType",PixdataType);
  registerInterceptorTypeForErrorDomain("gdk-pixbuf-error-quark", PixbufError);
}
