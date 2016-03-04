library gdk.gdart;

import "gdart.dart";

import "dart:async";

import "cairo.dart" hide initLibrary;
import "cairo.dart" as cairo;
import "pango.dart" hide Context, initLibrary;
import "pango.dart" as pango;
import "gobject.dart" hide initLibrary;
import "gio.dart" hide AppLaunchContext, initLibrary;
import "gio.dart" as gio;
import "glib.dart" hide initLibrary;
import "gdkpixbuf.dart" hide initLibrary;
import "gdkpixbuf.dart" as gdkpixbuf;

class AppLaunchContext extends gio.AppLaunchContext {
  AppLaunchContext.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'AppLaunchContext');

  Display get display => _staticInfo.getGPropertyOnReceiver('display', this);
  static const String DISPLAY_PROPERTY = 'display';
  factory AppLaunchContext() => _staticInfo.callStatic('new', []);
  void setDesktop(int desktop) => _staticInfo.callMethodOnReceiver('set_desktop', this, [desktop]);
  void set display(Display display) => _staticInfo.callMethodOnReceiver('set_display', this, [display]);
  void setIcon(Icon icon) => _staticInfo.callMethodOnReceiver('set_icon', this, [icon]);
  void setIconName(String iconName) => _staticInfo.callMethodOnReceiver('set_icon_name', this, [iconName]);
  void setScreen(Screen screen) => _staticInfo.callMethodOnReceiver('set_screen', this, [screen]);
  void setTimestamp(int timestamp) => _staticInfo.callMethodOnReceiver('set_timestamp', this, [timestamp]);
}

class Atom extends GObjectBase {
  Atom.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'Atom');

  String name() => _staticInfo.callMethodOnReceiver('name', this, []);
  static Atom intern(String atomName, bool onlyIfExists) => _staticInfo.callStatic('intern', [atomName, onlyIfExists]);
  static Atom internStaticString(String atomName) => _staticInfo.callStatic('intern_static_string', [atomName]);
}

class AxisUse extends GEnumBase {
  const AxisUse(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'AxisUse');

  static const AxisUse IGNORE = const AxisUse(0);
  static const AxisUse X = const AxisUse(1);
  static const AxisUse Y = const AxisUse(2);
  static const AxisUse PRESSURE = const AxisUse(3);
  static const AxisUse XTILT = const AxisUse(4);
  static const AxisUse YTILT = const AxisUse(5);
  static const AxisUse WHEEL = const AxisUse(6);
  static const AxisUse LAST = const AxisUse(7);
  String toString() {
    switch(index) {
      case 0: return 'AxisUse.IGNORE';
      case 1: return 'AxisUse.X';
      case 2: return 'AxisUse.Y';
      case 3: return 'AxisUse.PRESSURE';
      case 4: return 'AxisUse.XTILT';
      case 5: return 'AxisUse.YTILT';
      case 6: return 'AxisUse.WHEEL';
      case 7: return 'AxisUse.LAST';
      default: return 'new AxisUse($index)';
    }
  }
}

class ByteOrder extends GEnumBase {
  const ByteOrder(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'ByteOrder');

  static const ByteOrder LSB_FIRST = const ByteOrder(0);
  static const ByteOrder MSB_FIRST = const ByteOrder(1);
  String toString() {
    switch(index) {
      case 0: return 'ByteOrder.LSB_FIRST';
      case 1: return 'ByteOrder.MSB_FIRST';
      default: return 'new ByteOrder($index)';
    }
  }
}

class Color extends GObjectBase {
  Color.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'Color');

  Color copy() => _staticInfo.callMethodOnReceiver('copy', this, []);
  bool equal(Color colorb) => _staticInfo.callMethodOnReceiver('equal', this, [colorb]);
  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
  int hash() => _staticInfo.callMethodOnReceiver('hash', this, []);
  String toString() => _staticInfo.callMethodOnReceiver('to_string', this, []);
  static List parse(String spec) => _staticInfo.callStatic('parse', [spec]);
  int get pixel => getFieldOfObject('pixel', 0);
  void set pixel(int value) => setFieldOfObject('pixel', 0, value);
  int get red => getFieldOfObject('red', 1);
  void set red(int value) => setFieldOfObject('red', 1, value);
  int get green => getFieldOfObject('green', 2);
  void set green(int value) => setFieldOfObject('green', 2, value);
  int get blue => getFieldOfObject('blue', 3);
  void set blue(int value) => setFieldOfObject('blue', 3, value);
}

class CrossingMode extends GEnumBase {
  const CrossingMode(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'CrossingMode');

  static const CrossingMode NORMAL = const CrossingMode(0);
  static const CrossingMode GRAB = const CrossingMode(1);
  static const CrossingMode UNGRAB = const CrossingMode(2);
  static const CrossingMode GTK_GRAB = const CrossingMode(3);
  static const CrossingMode GTK_UNGRAB = const CrossingMode(4);
  static const CrossingMode STATE_CHANGED = const CrossingMode(5);
  static const CrossingMode TOUCH_BEGIN = const CrossingMode(6);
  static const CrossingMode TOUCH_END = const CrossingMode(7);
  static const CrossingMode DEVICE_SWITCH = const CrossingMode(8);
  String toString() {
    switch(index) {
      case 0: return 'CrossingMode.NORMAL';
      case 1: return 'CrossingMode.GRAB';
      case 2: return 'CrossingMode.UNGRAB';
      case 3: return 'CrossingMode.GTK_GRAB';
      case 4: return 'CrossingMode.GTK_UNGRAB';
      case 5: return 'CrossingMode.STATE_CHANGED';
      case 6: return 'CrossingMode.TOUCH_BEGIN';
      case 7: return 'CrossingMode.TOUCH_END';
      case 8: return 'CrossingMode.DEVICE_SWITCH';
      default: return 'new CrossingMode($index)';
    }
  }
}

class Cursor extends GObjectObject {
  Cursor.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'Cursor');

  void set cursorType(CursorType value) => _staticInfo.setGPropertyOnReceiver('cursor-type', this, value);
  static const String CURSOR_TYPE_PROPERTY = 'cursor-type';
  void set display(Display value) => _staticInfo.setGPropertyOnReceiver('display', this, value);
  static const String DISPLAY_PROPERTY = 'display';
  factory Cursor(CursorType cursorType) => _staticInfo.callStatic('new', [cursorType]);
  factory Cursor.forDisplay(Display display, CursorType cursorType) => _staticInfo.callStatic('new_for_display', [display, cursorType]);
  factory Cursor.fromName(Display display, String name) => _staticInfo.callStatic('new_from_name', [display, name]);
  factory Cursor.fromPixbuf(Display display, Pixbuf pixbuf, int x, int y) => _staticInfo.callStatic('new_from_pixbuf', [display, pixbuf, x, y]);
  factory Cursor.fromSurface(Display display, Surface surface, num x, num y) => _staticInfo.callStatic('new_from_surface', [display, surface, x, y]);
  CursorType get cursorType_ => _staticInfo.callMethodOnReceiver('get_cursor_type', this, []);
  Display get display_ => _staticInfo.callMethodOnReceiver('get_display', this, []);
  Pixbuf get image => _staticInfo.callMethodOnReceiver('get_image', this, []);
  List getSurface() => _staticInfo.callMethodOnReceiver('get_surface', this, []);
  Cursor ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
}

class CursorType extends GEnumBase {
  const CursorType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'CursorType');

  static const CursorType X_CURSOR = const CursorType(0);
  static const CursorType ARROW = const CursorType(2);
  static const CursorType BASED_ARROW_DOWN = const CursorType(4);
  static const CursorType BASED_ARROW_UP = const CursorType(6);
  static const CursorType BOAT = const CursorType(8);
  static const CursorType BOGOSITY = const CursorType(10);
  static const CursorType BOTTOM_LEFT_CORNER = const CursorType(12);
  static const CursorType BOTTOM_RIGHT_CORNER = const CursorType(14);
  static const CursorType BOTTOM_SIDE = const CursorType(16);
  static const CursorType BOTTOM_TEE = const CursorType(18);
  static const CursorType BOX_SPIRAL = const CursorType(20);
  static const CursorType CENTER_PTR = const CursorType(22);
  static const CursorType CIRCLE = const CursorType(24);
  static const CursorType CLOCK = const CursorType(26);
  static const CursorType COFFEE_MUG = const CursorType(28);
  static const CursorType CROSS = const CursorType(30);
  static const CursorType CROSS_REVERSE = const CursorType(32);
  static const CursorType CROSSHAIR = const CursorType(34);
  static const CursorType DIAMOND_CROSS = const CursorType(36);
  static const CursorType DOT = const CursorType(38);
  static const CursorType DOTBOX = const CursorType(40);
  static const CursorType DOUBLE_ARROW = const CursorType(42);
  static const CursorType DRAFT_LARGE = const CursorType(44);
  static const CursorType DRAFT_SMALL = const CursorType(46);
  static const CursorType DRAPED_BOX = const CursorType(48);
  static const CursorType EXCHANGE = const CursorType(50);
  static const CursorType FLEUR = const CursorType(52);
  static const CursorType GOBBLER = const CursorType(54);
  static const CursorType GUMBY = const CursorType(56);
  static const CursorType HAND1 = const CursorType(58);
  static const CursorType HAND2 = const CursorType(60);
  static const CursorType HEART = const CursorType(62);
  static const CursorType ICON = const CursorType(64);
  static const CursorType IRON_CROSS = const CursorType(66);
  static const CursorType LEFT_PTR = const CursorType(68);
  static const CursorType LEFT_SIDE = const CursorType(70);
  static const CursorType LEFT_TEE = const CursorType(72);
  static const CursorType LEFTBUTTON = const CursorType(74);
  static const CursorType LL_ANGLE = const CursorType(76);
  static const CursorType LR_ANGLE = const CursorType(78);
  static const CursorType MAN = const CursorType(80);
  static const CursorType MIDDLEBUTTON = const CursorType(82);
  static const CursorType MOUSE = const CursorType(84);
  static const CursorType PENCIL = const CursorType(86);
  static const CursorType PIRATE = const CursorType(88);
  static const CursorType PLUS = const CursorType(90);
  static const CursorType QUESTION_ARROW = const CursorType(92);
  static const CursorType RIGHT_PTR = const CursorType(94);
  static const CursorType RIGHT_SIDE = const CursorType(96);
  static const CursorType RIGHT_TEE = const CursorType(98);
  static const CursorType RIGHTBUTTON = const CursorType(100);
  static const CursorType RTL_LOGO = const CursorType(102);
  static const CursorType SAILBOAT = const CursorType(104);
  static const CursorType SB_DOWN_ARROW = const CursorType(106);
  static const CursorType SB_H_DOUBLE_ARROW = const CursorType(108);
  static const CursorType SB_LEFT_ARROW = const CursorType(110);
  static const CursorType SB_RIGHT_ARROW = const CursorType(112);
  static const CursorType SB_UP_ARROW = const CursorType(114);
  static const CursorType SB_V_DOUBLE_ARROW = const CursorType(116);
  static const CursorType SHUTTLE = const CursorType(118);
  static const CursorType SIZING = const CursorType(120);
  static const CursorType SPIDER = const CursorType(122);
  static const CursorType SPRAYCAN = const CursorType(124);
  static const CursorType STAR = const CursorType(126);
  static const CursorType TARGET = const CursorType(128);
  static const CursorType TCROSS = const CursorType(130);
  static const CursorType TOP_LEFT_ARROW = const CursorType(132);
  static const CursorType TOP_LEFT_CORNER = const CursorType(134);
  static const CursorType TOP_RIGHT_CORNER = const CursorType(136);
  static const CursorType TOP_SIDE = const CursorType(138);
  static const CursorType TOP_TEE = const CursorType(140);
  static const CursorType TREK = const CursorType(142);
  static const CursorType UL_ANGLE = const CursorType(144);
  static const CursorType UMBRELLA = const CursorType(146);
  static const CursorType UR_ANGLE = const CursorType(148);
  static const CursorType WATCH = const CursorType(150);
  static const CursorType XTERM = const CursorType(152);
  static const CursorType LAST_CURSOR = const CursorType(153);
  static const CursorType BLANK_CURSOR = const CursorType(-2);
  static const CursorType CURSOR_IS_PIXMAP = const CursorType(-1);
  String toString() {
    switch(index) {
      case 0: return 'CursorType.X_CURSOR';
      case 2: return 'CursorType.ARROW';
      case 4: return 'CursorType.BASED_ARROW_DOWN';
      case 6: return 'CursorType.BASED_ARROW_UP';
      case 8: return 'CursorType.BOAT';
      case 10: return 'CursorType.BOGOSITY';
      case 12: return 'CursorType.BOTTOM_LEFT_CORNER';
      case 14: return 'CursorType.BOTTOM_RIGHT_CORNER';
      case 16: return 'CursorType.BOTTOM_SIDE';
      case 18: return 'CursorType.BOTTOM_TEE';
      case 20: return 'CursorType.BOX_SPIRAL';
      case 22: return 'CursorType.CENTER_PTR';
      case 24: return 'CursorType.CIRCLE';
      case 26: return 'CursorType.CLOCK';
      case 28: return 'CursorType.COFFEE_MUG';
      case 30: return 'CursorType.CROSS';
      case 32: return 'CursorType.CROSS_REVERSE';
      case 34: return 'CursorType.CROSSHAIR';
      case 36: return 'CursorType.DIAMOND_CROSS';
      case 38: return 'CursorType.DOT';
      case 40: return 'CursorType.DOTBOX';
      case 42: return 'CursorType.DOUBLE_ARROW';
      case 44: return 'CursorType.DRAFT_LARGE';
      case 46: return 'CursorType.DRAFT_SMALL';
      case 48: return 'CursorType.DRAPED_BOX';
      case 50: return 'CursorType.EXCHANGE';
      case 52: return 'CursorType.FLEUR';
      case 54: return 'CursorType.GOBBLER';
      case 56: return 'CursorType.GUMBY';
      case 58: return 'CursorType.HAND1';
      case 60: return 'CursorType.HAND2';
      case 62: return 'CursorType.HEART';
      case 64: return 'CursorType.ICON';
      case 66: return 'CursorType.IRON_CROSS';
      case 68: return 'CursorType.LEFT_PTR';
      case 70: return 'CursorType.LEFT_SIDE';
      case 72: return 'CursorType.LEFT_TEE';
      case 74: return 'CursorType.LEFTBUTTON';
      case 76: return 'CursorType.LL_ANGLE';
      case 78: return 'CursorType.LR_ANGLE';
      case 80: return 'CursorType.MAN';
      case 82: return 'CursorType.MIDDLEBUTTON';
      case 84: return 'CursorType.MOUSE';
      case 86: return 'CursorType.PENCIL';
      case 88: return 'CursorType.PIRATE';
      case 90: return 'CursorType.PLUS';
      case 92: return 'CursorType.QUESTION_ARROW';
      case 94: return 'CursorType.RIGHT_PTR';
      case 96: return 'CursorType.RIGHT_SIDE';
      case 98: return 'CursorType.RIGHT_TEE';
      case 100: return 'CursorType.RIGHTBUTTON';
      case 102: return 'CursorType.RTL_LOGO';
      case 104: return 'CursorType.SAILBOAT';
      case 106: return 'CursorType.SB_DOWN_ARROW';
      case 108: return 'CursorType.SB_H_DOUBLE_ARROW';
      case 110: return 'CursorType.SB_LEFT_ARROW';
      case 112: return 'CursorType.SB_RIGHT_ARROW';
      case 114: return 'CursorType.SB_UP_ARROW';
      case 116: return 'CursorType.SB_V_DOUBLE_ARROW';
      case 118: return 'CursorType.SHUTTLE';
      case 120: return 'CursorType.SIZING';
      case 122: return 'CursorType.SPIDER';
      case 124: return 'CursorType.SPRAYCAN';
      case 126: return 'CursorType.STAR';
      case 128: return 'CursorType.TARGET';
      case 130: return 'CursorType.TCROSS';
      case 132: return 'CursorType.TOP_LEFT_ARROW';
      case 134: return 'CursorType.TOP_LEFT_CORNER';
      case 136: return 'CursorType.TOP_RIGHT_CORNER';
      case 138: return 'CursorType.TOP_SIDE';
      case 140: return 'CursorType.TOP_TEE';
      case 142: return 'CursorType.TREK';
      case 144: return 'CursorType.UL_ANGLE';
      case 146: return 'CursorType.UMBRELLA';
      case 148: return 'CursorType.UR_ANGLE';
      case 150: return 'CursorType.WATCH';
      case 152: return 'CursorType.XTERM';
      case 153: return 'CursorType.LAST_CURSOR';
      case -2: return 'CursorType.BLANK_CURSOR';
      case -1: return 'CursorType.CURSOR_IS_PIXMAP';
      default: return 'new CursorType($index)';
    }
  }
}

class Device extends GObjectObject {
  Device.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'Device');

  static const String ASSOCIATED_DEVICE_PROPERTY = 'associated-device';
  DeviceManager get deviceManager => _staticInfo.getGPropertyOnReceiver('device-manager', this);
  void set deviceManager(DeviceManager value) => _staticInfo.setGPropertyOnReceiver('device-manager', this, value);
  static const String DEVICE_MANAGER_PROPERTY = 'device-manager';
  void set display(Display value) => _staticInfo.setGPropertyOnReceiver('display', this, value);
  static const String DISPLAY_PROPERTY = 'display';
  void set hasCursor(bool value) => _staticInfo.setGPropertyOnReceiver('has-cursor', this, value);
  static const String HAS_CURSOR_PROPERTY = 'has-cursor';
  InputMode get inputMode => _staticInfo.getGPropertyOnReceiver('input-mode', this);
  void set inputMode(InputMode value) => _staticInfo.setGPropertyOnReceiver('input-mode', this, value);
  static const String INPUT_MODE_PROPERTY = 'input-mode';
  InputSource get inputSource => _staticInfo.getGPropertyOnReceiver('input-source', this);
  void set inputSource(InputSource value) => _staticInfo.setGPropertyOnReceiver('input-source', this, value);
  static const String INPUT_SOURCE_PROPERTY = 'input-source';
  static const String N_AXES_PROPERTY = 'n-axes';
  void set name(String value) => _staticInfo.setGPropertyOnReceiver('name', this, value);
  static const String NAME_PROPERTY = 'name';
  void set productId(String value) => _staticInfo.setGPropertyOnReceiver('product-id', this, value);
  static const String PRODUCT_ID_PROPERTY = 'product-id';
  DeviceType get type => _staticInfo.getGPropertyOnReceiver('type', this);
  void set type(DeviceType value) => _staticInfo.setGPropertyOnReceiver('type', this, value);
  static const String TYPE_PROPERTY = 'type';
  void set vendorId(String value) => _staticInfo.setGPropertyOnReceiver('vendor-id', this, value);
  static const String VENDOR_ID_PROPERTY = 'vendor-id';
  static List grabInfoLibgtkOnly(Display display, Device device) => _staticInfo.callStatic('grab_info_libgtk_only', [display, device]);
  Device get associatedDevice => _staticInfo.callMethodOnReceiver('get_associated_device', this, []);
  AxisUse getAxisUse(int index_) => _staticInfo.callMethodOnReceiver('get_axis_use', this, [index_]);
  DeviceType get deviceType => _staticInfo.callMethodOnReceiver('get_device_type', this, []);
  Display get display_ => _staticInfo.callMethodOnReceiver('get_display', this, []);
  bool get hasCursor_ => _staticInfo.callMethodOnReceiver('get_has_cursor', this, []);
  List getKey(int index_) => _staticInfo.callMethodOnReceiver('get_key', this, [index_]);
  Window get lastEventWindow => _staticInfo.callMethodOnReceiver('get_last_event_window', this, []);
  InputMode get mode => _staticInfo.callMethodOnReceiver('get_mode', this, []);
  int get nAxes => _staticInfo.callMethodOnReceiver('get_n_axes', this, []);
  int get nKeys => _staticInfo.callMethodOnReceiver('get_n_keys', this, []);
  String get name_ => _staticInfo.callMethodOnReceiver('get_name', this, []);
  List getPosition() => _staticInfo.callMethodOnReceiver('get_position', this, []);
  List getPositionDouble() => _staticInfo.callMethodOnReceiver('get_position_double', this, []);
  String get productId_ => _staticInfo.callMethodOnReceiver('get_product_id', this, []);
  InputSource get source => _staticInfo.callMethodOnReceiver('get_source', this, []);
  String get vendorId_ => _staticInfo.callMethodOnReceiver('get_vendor_id', this, []);
  List getWindowAtPosition() => _staticInfo.callMethodOnReceiver('get_window_at_position', this, []);
  List getWindowAtPositionDouble() => _staticInfo.callMethodOnReceiver('get_window_at_position_double', this, []);
  GrabStatus grab(Window window, GrabOwnership grabOwnership, bool ownerEvents, EventMask eventMask, Cursor cursor, int time_) => _staticInfo.callMethodOnReceiver('grab', this, [window, grabOwnership, ownerEvents, eventMask, cursor, time_]);
  GLibList /* this will fail */ listAxes() => _staticInfo.callMethodOnReceiver('list_axes', this, []);
  GLibList /* this will fail */ listSlaveDevices() => _staticInfo.callMethodOnReceiver('list_slave_devices', this, []);
  void setAxisUse(int index_, AxisUse use) => _staticInfo.callMethodOnReceiver('set_axis_use', this, [index_, use]);
  void setKey(int index_, int keyval, ModifierType modifiers) => _staticInfo.callMethodOnReceiver('set_key', this, [index_, keyval, modifiers]);
  bool setMode(InputMode mode) => _staticInfo.callMethodOnReceiver('set_mode', this, [mode]);
  void ungrab(int time_) => _staticInfo.callMethodOnReceiver('ungrab', this, [time_]);
  void warp(Screen screen, int x, int y) => _staticInfo.callMethodOnReceiver('warp', this, [screen, x, y]);
  int _connectToChanged(bool after, void func()) => signalConnect('changed', func, after);
  Stream get onChanged {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToChanged(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterChanged {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToChanged(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
}

class DeviceManager extends GObjectObject {
  DeviceManager.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'DeviceManager');

  void set display(Display value) => _staticInfo.setGPropertyOnReceiver('display', this, value);
  static const String DISPLAY_PROPERTY = 'display';
  Device get clientPointer => _staticInfo.callMethodOnReceiver('get_client_pointer', this, []);
  Display get display_ => _staticInfo.callMethodOnReceiver('get_display', this, []);
  GLibList /* this will fail */ listDevices(DeviceType type) => _staticInfo.callMethodOnReceiver('list_devices', this, [type]);
  int _connectToDeviceAdded(bool after, void func(Device device)) => signalConnect('device-added', func, after);
  Stream<Device> get onDeviceAdded {
    int signalId;
    StreamController<Device> controller;
    controller = new StreamController<Device>(
      onListen: () {
          signalId = _connectToDeviceAdded(false, (Device device) {
              controller.add(device);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<Device> get afterDeviceAdded {
    int signalId;
    StreamController<Device> controller;
    controller = new StreamController<Device>(
      onListen: () {
          signalId = _connectToDeviceAdded(true, (Device device) {
              controller.add(device);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToDeviceChanged(bool after, void func(Device device)) => signalConnect('device-changed', func, after);
  Stream<Device> get onDeviceChanged {
    int signalId;
    StreamController<Device> controller;
    controller = new StreamController<Device>(
      onListen: () {
          signalId = _connectToDeviceChanged(false, (Device device) {
              controller.add(device);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<Device> get afterDeviceChanged {
    int signalId;
    StreamController<Device> controller;
    controller = new StreamController<Device>(
      onListen: () {
          signalId = _connectToDeviceChanged(true, (Device device) {
              controller.add(device);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToDeviceRemoved(bool after, void func(Device device)) => signalConnect('device-removed', func, after);
  Stream<Device> get onDeviceRemoved {
    int signalId;
    StreamController<Device> controller;
    controller = new StreamController<Device>(
      onListen: () {
          signalId = _connectToDeviceRemoved(false, (Device device) {
              controller.add(device);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<Device> get afterDeviceRemoved {
    int signalId;
    StreamController<Device> controller;
    controller = new StreamController<Device>(
      onListen: () {
          signalId = _connectToDeviceRemoved(true, (Device device) {
              controller.add(device);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
}

class DeviceType extends GEnumBase {
  const DeviceType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'DeviceType');

  static const DeviceType MASTER = const DeviceType(0);
  static const DeviceType SLAVE = const DeviceType(1);
  static const DeviceType FLOATING = const DeviceType(2);
  String toString() {
    switch(index) {
      case 0: return 'DeviceType.MASTER';
      case 1: return 'DeviceType.SLAVE';
      case 2: return 'DeviceType.FLOATING';
      default: return 'new DeviceType($index)';
    }
  }
}

class Display extends GObjectObject {
  Display.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'Display');

  static Display getDefault() => _staticInfo.callStatic('get_default', []);
  static Display open(String displayName) => _staticInfo.callStatic('open', [displayName]);
  static Display openDefaultLibgtkOnly() => _staticInfo.callStatic('open_default_libgtk_only', []);
  void beep() => _staticInfo.callMethodOnReceiver('beep', this, []);
  void close() => _staticInfo.callMethodOnReceiver('close', this, []);
  bool deviceIsGrabbed(Device device) => _staticInfo.callMethodOnReceiver('device_is_grabbed', this, [device]);
  void flush() => _staticInfo.callMethodOnReceiver('flush', this, []);
  AppLaunchContext get appLaunchContext => _staticInfo.callMethodOnReceiver('get_app_launch_context', this, []);
  int get defaultCursorSize => _staticInfo.callMethodOnReceiver('get_default_cursor_size', this, []);
  Window get defaultGroup => _staticInfo.callMethodOnReceiver('get_default_group', this, []);
  Screen get defaultScreen => _staticInfo.callMethodOnReceiver('get_default_screen', this, []);
  DeviceManager get deviceManager => _staticInfo.callMethodOnReceiver('get_device_manager', this, []);
  Event get event => _staticInfo.callMethodOnReceiver('get_event', this, []);
  List getMaximalCursorSize() => _staticInfo.callMethodOnReceiver('get_maximal_cursor_size', this, []);
  int get nScreens => _staticInfo.callMethodOnReceiver('get_n_screens', this, []);
  String get name => _staticInfo.callMethodOnReceiver('get_name', this, []);
  List getPointer() => _staticInfo.callMethodOnReceiver('get_pointer', this, []);
  Screen getScreen(int screenNum) => _staticInfo.callMethodOnReceiver('get_screen', this, [screenNum]);
  List getWindowAtPointer() => _staticInfo.callMethodOnReceiver('get_window_at_pointer', this, []);
  bool hasPending() => _staticInfo.callMethodOnReceiver('has_pending', this, []);
  bool isClosed() => _staticInfo.callMethodOnReceiver('is_closed', this, []);
  void keyboardUngrab(int time_) => _staticInfo.callMethodOnReceiver('keyboard_ungrab', this, [time_]);
  GLibList /* this will fail */ listDevices() => _staticInfo.callMethodOnReceiver('list_devices', this, []);
  void notifyStartupComplete(String startupId) => _staticInfo.callMethodOnReceiver('notify_startup_complete', this, [startupId]);
  Event peekEvent() => _staticInfo.callMethodOnReceiver('peek_event', this, []);
  bool pointerIsGrabbed() => _staticInfo.callMethodOnReceiver('pointer_is_grabbed', this, []);
  void pointerUngrab(int time_) => _staticInfo.callMethodOnReceiver('pointer_ungrab', this, [time_]);
  void putEvent(Event event) => _staticInfo.callMethodOnReceiver('put_event', this, [event]);
  bool requestSelectionNotification(Atom selection) => _staticInfo.callMethodOnReceiver('request_selection_notification', this, [selection]);
  void setDoubleClickDistance(int distance) => _staticInfo.callMethodOnReceiver('set_double_click_distance', this, [distance]);
  void setDoubleClickTime(int msec) => _staticInfo.callMethodOnReceiver('set_double_click_time', this, [msec]);
  void storeClipboard(Window clipboardWindow, int time_, List<Atom> targets) => _staticInfo.callMethodOnReceiver('store_clipboard', this, [clipboardWindow, time_, targets]);
  bool supportsClipboardPersistence() => _staticInfo.callMethodOnReceiver('supports_clipboard_persistence', this, []);
  bool supportsComposite() => _staticInfo.callMethodOnReceiver('supports_composite', this, []);
  bool supportsCursorAlpha() => _staticInfo.callMethodOnReceiver('supports_cursor_alpha', this, []);
  bool supportsCursorColor() => _staticInfo.callMethodOnReceiver('supports_cursor_color', this, []);
  bool supportsInputShapes() => _staticInfo.callMethodOnReceiver('supports_input_shapes', this, []);
  bool supportsSelectionNotification() => _staticInfo.callMethodOnReceiver('supports_selection_notification', this, []);
  bool supportsShapes() => _staticInfo.callMethodOnReceiver('supports_shapes', this, []);
  void sync() => _staticInfo.callMethodOnReceiver('sync', this, []);
  void warpPointer(Screen screen, int x, int y) => _staticInfo.callMethodOnReceiver('warp_pointer', this, [screen, x, y]);
  int _connectToClosed(bool after, void func(bool isError)) => signalConnect('closed', func, after);
  Stream<bool> get onClosed {
    int signalId;
    StreamController<bool> controller;
    controller = new StreamController<bool>(
      onListen: () {
          signalId = _connectToClosed(false, (bool isError) {
              controller.add(isError);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<bool> get afterClosed {
    int signalId;
    StreamController<bool> controller;
    controller = new StreamController<bool>(
      onListen: () {
          signalId = _connectToClosed(true, (bool isError) {
              controller.add(isError);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToOpened(bool after, void func()) => signalConnect('opened', func, after);
  Stream get onOpened {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToOpened(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterOpened {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToOpened(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
}

class DisplayManager extends GObjectObject {
  DisplayManager.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'DisplayManager');

  static const String DEFAULT_DISPLAY_PROPERTY = 'default-display';
  static DisplayManager get_() => _staticInfo.callStatic('get', []);
  Display get defaultDisplay => _staticInfo.callMethodOnReceiver('get_default_display', this, []);
  SList /* this will fail */ listDisplays() => _staticInfo.callMethodOnReceiver('list_displays', this, []);
  Display openDisplay(String name) => _staticInfo.callMethodOnReceiver('open_display', this, [name]);
  void set defaultDisplay(Display display) => _staticInfo.callMethodOnReceiver('set_default_display', this, [display]);
  int _connectToDisplayOpened(bool after, void func(Display display)) => signalConnect('display-opened', func, after);
  Stream<Display> get onDisplayOpened {
    int signalId;
    StreamController<Display> controller;
    controller = new StreamController<Display>(
      onListen: () {
          signalId = _connectToDisplayOpened(false, (Display display) {
              controller.add(display);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<Display> get afterDisplayOpened {
    int signalId;
    StreamController<Display> controller;
    controller = new StreamController<Display>(
      onListen: () {
          signalId = _connectToDisplayOpened(true, (Display display) {
              controller.add(display);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
}

class DragAction extends GEnumBase {
  const DragAction(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'DragAction');

  static const DragAction NULL = const DragAction(0);
  static const DragAction DEFAULT = const DragAction(1);
  bool get default_ => (index & 1) == 1;
  static const DragAction COPY = const DragAction(2);
  bool get copy => (index & 2) == 2;
  static const DragAction MOVE = const DragAction(4);
  bool get move => (index & 4) == 4;
  static const DragAction LINK = const DragAction(8);
  bool get link => (index & 8) == 8;
  static const DragAction PRIVATE = const DragAction(16);
  bool get private => (index & 16) == 16;
  static const DragAction ASK = const DragAction(32);
  bool get ask => (index & 32) == 32;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'DragAction.DEFAULT';
      case 2: return 'DragAction.COPY';
      case 4: return 'DragAction.MOVE';
      case 8: return 'DragAction.LINK';
      case 16: return 'DragAction.PRIVATE';
      case 32: return 'DragAction.ASK';
      default: return 'new DragAction($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'DragAction.NULL';
    }
    List codes = [];
    for (var i=1; i <= 32; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  DragAction operator|(DragAction other) =>
    new DragAction(index | other.index);
  DragAction operator&(DragAction other) =>
    new DragAction(index & other.index);
}

class DragContext extends GObjectObject {
  DragContext.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'DragContext');

  DragAction get actions => _staticInfo.callMethodOnReceiver('get_actions', this, []);
  Window get destWindow => _staticInfo.callMethodOnReceiver('get_dest_window', this, []);
  Device get device => _staticInfo.callMethodOnReceiver('get_device', this, []);
  DragProtocol get protocol => _staticInfo.callMethodOnReceiver('get_protocol', this, []);
  DragAction get selectedAction => _staticInfo.callMethodOnReceiver('get_selected_action', this, []);
  Window get sourceWindow => _staticInfo.callMethodOnReceiver('get_source_window', this, []);
  DragAction get suggestedAction => _staticInfo.callMethodOnReceiver('get_suggested_action', this, []);
  GLibList /* this will fail */ listTargets() => _staticInfo.callMethodOnReceiver('list_targets', this, []);
  void set device(Device device) => _staticInfo.callMethodOnReceiver('set_device', this, [device]);
}

class DragProtocol extends GEnumBase {
  const DragProtocol(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'DragProtocol');

  static const DragProtocol NONE = const DragProtocol(0);
  static const DragProtocol MOTIF = const DragProtocol(1);
  static const DragProtocol XDND = const DragProtocol(2);
  static const DragProtocol ROOTWIN = const DragProtocol(3);
  static const DragProtocol WIN32_DROPFILES = const DragProtocol(4);
  static const DragProtocol OLE2 = const DragProtocol(5);
  static const DragProtocol LOCAL = const DragProtocol(6);
  static const DragProtocol WAYLAND = const DragProtocol(7);
  String toString() {
    switch(index) {
      case 0: return 'DragProtocol.NONE';
      case 1: return 'DragProtocol.MOTIF';
      case 2: return 'DragProtocol.XDND';
      case 3: return 'DragProtocol.ROOTWIN';
      case 4: return 'DragProtocol.WIN32_DROPFILES';
      case 5: return 'DragProtocol.OLE2';
      case 6: return 'DragProtocol.LOCAL';
      case 7: return 'DragProtocol.WAYLAND';
      default: return 'new DragProtocol($index)';
    }
  }
}

class Event extends GObjectBase {
  Event.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'Event');

  factory Event(EventType type) => _staticInfo.callStatic('new', [type]);
  List GetAngle(Event event2) => _staticInfo.callMethodOnReceiver('_get_angle', this, [event2]);
  List GetCenter(Event event2) => _staticInfo.callMethodOnReceiver('_get_center', this, [event2]);
  List GetDistance(Event event2) => _staticInfo.callMethodOnReceiver('_get_distance', this, [event2]);
  Event copy() => _staticInfo.callMethodOnReceiver('copy', this, []);
  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
  List getAxis(AxisUse axisUse) => _staticInfo.callMethodOnReceiver('get_axis', this, [axisUse]);
  List getButton() => _staticInfo.callMethodOnReceiver('get_button', this, []);
  List getClickCount() => _staticInfo.callMethodOnReceiver('get_click_count', this, []);
  List getCoords() => _staticInfo.callMethodOnReceiver('get_coords', this, []);
  Device get device => _staticInfo.callMethodOnReceiver('get_device', this, []);
  EventSequence get eventSequence => _staticInfo.callMethodOnReceiver('get_event_sequence', this, []);
  EventType get eventType => _staticInfo.callMethodOnReceiver('get_event_type', this, []);
  List getKeycode() => _staticInfo.callMethodOnReceiver('get_keycode', this, []);
  List getKeyval() => _staticInfo.callMethodOnReceiver('get_keyval', this, []);
  List getRootCoords() => _staticInfo.callMethodOnReceiver('get_root_coords', this, []);
  Screen get screen => _staticInfo.callMethodOnReceiver('get_screen', this, []);
  List getScrollDeltas() => _staticInfo.callMethodOnReceiver('get_scroll_deltas', this, []);
  List getScrollDirection() => _staticInfo.callMethodOnReceiver('get_scroll_direction', this, []);
  Device get sourceDevice => _staticInfo.callMethodOnReceiver('get_source_device', this, []);
  List getState() => _staticInfo.callMethodOnReceiver('get_state', this, []);
  int get time => _staticInfo.callMethodOnReceiver('get_time', this, []);
  Window get window => _staticInfo.callMethodOnReceiver('get_window', this, []);
  void put() => _staticInfo.callMethodOnReceiver('put', this, []);
  void set device(Device device) => _staticInfo.callMethodOnReceiver('set_device', this, [device]);
  void set screen(Screen screen) => _staticInfo.callMethodOnReceiver('set_screen', this, [screen]);
  void set sourceDevice(Device device) => _staticInfo.callMethodOnReceiver('set_source_device', this, [device]);
  bool triggersContextMenu() => _staticInfo.callMethodOnReceiver('triggers_context_menu', this, []);
  static Event get_() => _staticInfo.callStatic('get', []);
  static void handlerSet(EventFunc func) => _staticInfo.callStatic('handler_set', [func]);
  static Event peek() => _staticInfo.callStatic('peek', []);
  static void requestMotions(EventMotion event) => _staticInfo.callStatic('request_motions', [event]);
  EventType get type => getFieldOfObject('type', 0);
  void set type(EventType value) => setFieldOfObject('type', 0, value);
  EventAny get any => getFieldOfObject('any', 1);
  void set any(EventAny value) => setFieldOfObject('any', 1, value);
  EventExpose get expose => getFieldOfObject('expose', 2);
  void set expose(EventExpose value) => setFieldOfObject('expose', 2, value);
  EventVisibility get visibility => getFieldOfObject('visibility', 3);
  void set visibility(EventVisibility value) => setFieldOfObject('visibility', 3, value);
  EventMotion get motion => getFieldOfObject('motion', 4);
  void set motion(EventMotion value) => setFieldOfObject('motion', 4, value);
  EventButton get button => getFieldOfObject('button', 5);
  void set button(EventButton value) => setFieldOfObject('button', 5, value);
  EventTouch get touch => getFieldOfObject('touch', 6);
  void set touch(EventTouch value) => setFieldOfObject('touch', 6, value);
  EventScroll get scroll => getFieldOfObject('scroll', 7);
  void set scroll(EventScroll value) => setFieldOfObject('scroll', 7, value);
  EventKey get key => getFieldOfObject('key', 8);
  void set key(EventKey value) => setFieldOfObject('key', 8, value);
  EventCrossing get crossing => getFieldOfObject('crossing', 9);
  void set crossing(EventCrossing value) => setFieldOfObject('crossing', 9, value);
  EventFocus get focusChange => getFieldOfObject('focus_change', 10);
  void set focusChange(EventFocus value) => setFieldOfObject('focus_change', 10, value);
  EventConfigure get configure => getFieldOfObject('configure', 11);
  void set configure(EventConfigure value) => setFieldOfObject('configure', 11, value);
  EventProperty get property => getFieldOfObject('property', 12);
  void set property(EventProperty value) => setFieldOfObject('property', 12, value);
  EventSelection get selection => getFieldOfObject('selection', 13);
  void set selection(EventSelection value) => setFieldOfObject('selection', 13, value);
  EventOwnerChange get ownerChange => getFieldOfObject('owner_change', 14);
  void set ownerChange(EventOwnerChange value) => setFieldOfObject('owner_change', 14, value);
  EventProximity get proximity => getFieldOfObject('proximity', 15);
  void set proximity(EventProximity value) => setFieldOfObject('proximity', 15, value);
  EventDND get dnd => getFieldOfObject('dnd', 16);
  void set dnd(EventDND value) => setFieldOfObject('dnd', 16, value);
  EventWindowState get windowState => getFieldOfObject('window_state', 17);
  void set windowState(EventWindowState value) => setFieldOfObject('window_state', 17, value);
  EventSetting get setting => getFieldOfObject('setting', 18);
  void set setting(EventSetting value) => setFieldOfObject('setting', 18, value);
  EventGrabBroken get grabBroken => getFieldOfObject('grab_broken', 19);
  void set grabBroken(EventGrabBroken value) => setFieldOfObject('grab_broken', 19, value);
  EventTouchpadSwipe get touchpadSwipe => getFieldOfObject('touchpad_swipe', 20);
  void set touchpadSwipe(EventTouchpadSwipe value) => setFieldOfObject('touchpad_swipe', 20, value);
  EventTouchpadPinch get touchpadPinch => getFieldOfObject('touchpad_pinch', 21);
  void set touchpadPinch(EventTouchpadPinch value) => setFieldOfObject('touchpad_pinch', 21, value);
}

class EventAny extends GObjectBase {
  EventAny.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'EventAny');

  EventType get type => getFieldOfObject('type', 0);
  void set type(EventType value) => setFieldOfObject('type', 0, value);
  Window get window => getFieldOfObject('window', 1);
  void set window(Window value) => setFieldOfObject('window', 1, value);
  int get sendEvent => getFieldOfObject('send_event', 2);
  void set sendEvent(int value) => setFieldOfObject('send_event', 2, value);
}

class EventButton extends GObjectBase {
  EventButton.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'EventButton');

  EventType get type => getFieldOfObject('type', 0);
  void set type(EventType value) => setFieldOfObject('type', 0, value);
  Window get window => getFieldOfObject('window', 1);
  void set window(Window value) => setFieldOfObject('window', 1, value);
  int get sendEvent => getFieldOfObject('send_event', 2);
  void set sendEvent(int value) => setFieldOfObject('send_event', 2, value);
  int get time => getFieldOfObject('time', 3);
  void set time(int value) => setFieldOfObject('time', 3, value);
  num get x => getFieldOfObject('x', 4);
  void set x(num value) => setFieldOfObject('x', 4, value);
  num get y => getFieldOfObject('y', 5);
  void set y(num value) => setFieldOfObject('y', 5, value);
  num get axes => getFieldOfObject('axes', 6);
  void set axes(num value) => setFieldOfObject('axes', 6, value);
  ModifierType get state => getFieldOfObject('state', 7);
  void set state(ModifierType value) => setFieldOfObject('state', 7, value);
  int get button => getFieldOfObject('button', 8);
  void set button(int value) => setFieldOfObject('button', 8, value);
  Device get device => getFieldOfObject('device', 9);
  void set device(Device value) => setFieldOfObject('device', 9, value);
  num get xRoot => getFieldOfObject('x_root', 10);
  void set xRoot(num value) => setFieldOfObject('x_root', 10, value);
  num get yRoot => getFieldOfObject('y_root', 11);
  void set yRoot(num value) => setFieldOfObject('y_root', 11, value);
}

class EventConfigure extends GObjectBase {
  EventConfigure.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'EventConfigure');

  EventType get type => getFieldOfObject('type', 0);
  void set type(EventType value) => setFieldOfObject('type', 0, value);
  Window get window => getFieldOfObject('window', 1);
  void set window(Window value) => setFieldOfObject('window', 1, value);
  int get sendEvent => getFieldOfObject('send_event', 2);
  void set sendEvent(int value) => setFieldOfObject('send_event', 2, value);
  int get x => getFieldOfObject('x', 3);
  void set x(int value) => setFieldOfObject('x', 3, value);
  int get y => getFieldOfObject('y', 4);
  void set y(int value) => setFieldOfObject('y', 4, value);
  int get width => getFieldOfObject('width', 5);
  void set width(int value) => setFieldOfObject('width', 5, value);
  int get height => getFieldOfObject('height', 6);
  void set height(int value) => setFieldOfObject('height', 6, value);
}

class EventCrossing extends GObjectBase {
  EventCrossing.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'EventCrossing');

  EventType get type => getFieldOfObject('type', 0);
  void set type(EventType value) => setFieldOfObject('type', 0, value);
  Window get window => getFieldOfObject('window', 1);
  void set window(Window value) => setFieldOfObject('window', 1, value);
  int get sendEvent => getFieldOfObject('send_event', 2);
  void set sendEvent(int value) => setFieldOfObject('send_event', 2, value);
  Window get subwindow => getFieldOfObject('subwindow', 3);
  void set subwindow(Window value) => setFieldOfObject('subwindow', 3, value);
  int get time => getFieldOfObject('time', 4);
  void set time(int value) => setFieldOfObject('time', 4, value);
  num get x => getFieldOfObject('x', 5);
  void set x(num value) => setFieldOfObject('x', 5, value);
  num get y => getFieldOfObject('y', 6);
  void set y(num value) => setFieldOfObject('y', 6, value);
  num get xRoot => getFieldOfObject('x_root', 7);
  void set xRoot(num value) => setFieldOfObject('x_root', 7, value);
  num get yRoot => getFieldOfObject('y_root', 8);
  void set yRoot(num value) => setFieldOfObject('y_root', 8, value);
  CrossingMode get mode => getFieldOfObject('mode', 9);
  void set mode(CrossingMode value) => setFieldOfObject('mode', 9, value);
  NotifyType get detail => getFieldOfObject('detail', 10);
  void set detail(NotifyType value) => setFieldOfObject('detail', 10, value);
  bool get focus => getFieldOfObject('focus', 11);
  void set focus(bool value) => setFieldOfObject('focus', 11, value);
  ModifierType get state => getFieldOfObject('state', 12);
  void set state(ModifierType value) => setFieldOfObject('state', 12, value);
}

class EventDND extends GObjectBase {
  EventDND.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'EventDND');

  EventType get type => getFieldOfObject('type', 0);
  void set type(EventType value) => setFieldOfObject('type', 0, value);
  Window get window => getFieldOfObject('window', 1);
  void set window(Window value) => setFieldOfObject('window', 1, value);
  int get sendEvent => getFieldOfObject('send_event', 2);
  void set sendEvent(int value) => setFieldOfObject('send_event', 2, value);
  DragContext get context => getFieldOfObject('context', 3);
  void set context(DragContext value) => setFieldOfObject('context', 3, value);
  int get time => getFieldOfObject('time', 4);
  void set time(int value) => setFieldOfObject('time', 4, value);
  int get xRoot => getFieldOfObject('x_root', 5);
  void set xRoot(int value) => setFieldOfObject('x_root', 5, value);
  int get yRoot => getFieldOfObject('y_root', 6);
  void set yRoot(int value) => setFieldOfObject('y_root', 6, value);
}

class EventExpose extends GObjectBase {
  EventExpose.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'EventExpose');

  EventType get type => getFieldOfObject('type', 0);
  void set type(EventType value) => setFieldOfObject('type', 0, value);
  Window get window => getFieldOfObject('window', 1);
  void set window(Window value) => setFieldOfObject('window', 1, value);
  int get sendEvent => getFieldOfObject('send_event', 2);
  void set sendEvent(int value) => setFieldOfObject('send_event', 2, value);
  Rectangle get area => getFieldOfObject('area', 3);
  void set area(Rectangle value) => setFieldOfObject('area', 3, value);
  Region get region => getFieldOfObject('region', 4);
  void set region(Region value) => setFieldOfObject('region', 4, value);
  int get count => getFieldOfObject('count', 5);
  void set count(int value) => setFieldOfObject('count', 5, value);
}

class EventFocus extends GObjectBase {
  EventFocus.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'EventFocus');

  EventType get type => getFieldOfObject('type', 0);
  void set type(EventType value) => setFieldOfObject('type', 0, value);
  Window get window => getFieldOfObject('window', 1);
  void set window(Window value) => setFieldOfObject('window', 1, value);
  int get sendEvent => getFieldOfObject('send_event', 2);
  void set sendEvent(int value) => setFieldOfObject('send_event', 2, value);
  int get in_ => getFieldOfObject('in', 3);
  void set in_(int value) => setFieldOfObject('in', 3, value);
}

typedef void EventFunc(Event event);
class EventGrabBroken extends GObjectBase {
  EventGrabBroken.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'EventGrabBroken');

  EventType get type => getFieldOfObject('type', 0);
  void set type(EventType value) => setFieldOfObject('type', 0, value);
  Window get window => getFieldOfObject('window', 1);
  void set window(Window value) => setFieldOfObject('window', 1, value);
  int get sendEvent => getFieldOfObject('send_event', 2);
  void set sendEvent(int value) => setFieldOfObject('send_event', 2, value);
  bool get keyboard => getFieldOfObject('keyboard', 3);
  void set keyboard(bool value) => setFieldOfObject('keyboard', 3, value);
  bool get implicit => getFieldOfObject('implicit', 4);
  void set implicit(bool value) => setFieldOfObject('implicit', 4, value);
  Window get grabWindow => getFieldOfObject('grab_window', 5);
  void set grabWindow(Window value) => setFieldOfObject('grab_window', 5, value);
}

class EventKey extends GObjectBase {
  EventKey.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'EventKey');

  EventType get type => getFieldOfObject('type', 0);
  void set type(EventType value) => setFieldOfObject('type', 0, value);
  Window get window => getFieldOfObject('window', 1);
  void set window(Window value) => setFieldOfObject('window', 1, value);
  int get sendEvent => getFieldOfObject('send_event', 2);
  void set sendEvent(int value) => setFieldOfObject('send_event', 2, value);
  int get time => getFieldOfObject('time', 3);
  void set time(int value) => setFieldOfObject('time', 3, value);
  ModifierType get state => getFieldOfObject('state', 4);
  void set state(ModifierType value) => setFieldOfObject('state', 4, value);
  int get keyval => getFieldOfObject('keyval', 5);
  void set keyval(int value) => setFieldOfObject('keyval', 5, value);
  int get length => getFieldOfObject('length', 6);
  void set length(int value) => setFieldOfObject('length', 6, value);
  String get string => getFieldOfObject('string', 7);
  void set string(String value) => setFieldOfObject('string', 7, value);
  int get hardwareKeycode => getFieldOfObject('hardware_keycode', 8);
  void set hardwareKeycode(int value) => setFieldOfObject('hardware_keycode', 8, value);
  int get group => getFieldOfObject('group', 9);
  void set group(int value) => setFieldOfObject('group', 9, value);
  int get isModifier => getFieldOfObject('is_modifier', 10);
  void set isModifier(int value) => setFieldOfObject('is_modifier', 10, value);
}

class EventMask extends GEnumBase {
  const EventMask(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'EventMask');

  static const EventMask NULL = const EventMask(0);
  static const EventMask EXPOSURE_MASK = const EventMask(2);
  bool get exposureMask => (index & 2) == 2;
  static const EventMask POINTER_MOTION_MASK = const EventMask(4);
  bool get pointerMotionMask => (index & 4) == 4;
  static const EventMask POINTER_MOTION_HINT_MASK = const EventMask(8);
  bool get pointerMotionHintMask => (index & 8) == 8;
  static const EventMask BUTTON_MOTION_MASK = const EventMask(16);
  bool get buttonMotionMask => (index & 16) == 16;
  static const EventMask BUTTON1_MOTION_MASK = const EventMask(32);
  bool get button1MotionMask => (index & 32) == 32;
  static const EventMask BUTTON2_MOTION_MASK = const EventMask(64);
  bool get button2MotionMask => (index & 64) == 64;
  static const EventMask BUTTON3_MOTION_MASK = const EventMask(128);
  bool get button3MotionMask => (index & 128) == 128;
  static const EventMask BUTTON_PRESS_MASK = const EventMask(256);
  bool get buttonPressMask => (index & 256) == 256;
  static const EventMask BUTTON_RELEASE_MASK = const EventMask(512);
  bool get buttonReleaseMask => (index & 512) == 512;
  static const EventMask KEY_PRESS_MASK = const EventMask(1024);
  bool get keyPressMask => (index & 1024) == 1024;
  static const EventMask KEY_RELEASE_MASK = const EventMask(2048);
  bool get keyReleaseMask => (index & 2048) == 2048;
  static const EventMask ENTER_NOTIFY_MASK = const EventMask(4096);
  bool get enterNotifyMask => (index & 4096) == 4096;
  static const EventMask LEAVE_NOTIFY_MASK = const EventMask(8192);
  bool get leaveNotifyMask => (index & 8192) == 8192;
  static const EventMask FOCUS_CHANGE_MASK = const EventMask(16384);
  bool get focusChangeMask => (index & 16384) == 16384;
  static const EventMask STRUCTURE_MASK = const EventMask(32768);
  bool get structureMask => (index & 32768) == 32768;
  static const EventMask PROPERTY_CHANGE_MASK = const EventMask(65536);
  bool get propertyChangeMask => (index & 65536) == 65536;
  static const EventMask VISIBILITY_NOTIFY_MASK = const EventMask(131072);
  bool get visibilityNotifyMask => (index & 131072) == 131072;
  static const EventMask PROXIMITY_IN_MASK = const EventMask(262144);
  bool get proximityInMask => (index & 262144) == 262144;
  static const EventMask PROXIMITY_OUT_MASK = const EventMask(524288);
  bool get proximityOutMask => (index & 524288) == 524288;
  static const EventMask SUBSTRUCTURE_MASK = const EventMask(1048576);
  bool get substructureMask => (index & 1048576) == 1048576;
  static const EventMask SCROLL_MASK = const EventMask(2097152);
  bool get scrollMask => (index & 2097152) == 2097152;
  static const EventMask TOUCH_MASK = const EventMask(4194304);
  bool get touchMask => (index & 4194304) == 4194304;
  static const EventMask SMOOTH_SCROLL_MASK = const EventMask(8388608);
  bool get smoothScrollMask => (index & 8388608) == 8388608;
  static const EventMask TOUCHPAD_GESTURE_MASK = const EventMask(16777216);
  bool get touchpadGestureMask => (index & 16777216) == 16777216;
  static const EventMask ALL_EVENTS_MASK = const EventMask(16777214);
  bool get allEventsMask => (index & 16777214) == 16777214;
  static _valueToString(int value) {
    switch(value) {
      case 2: return 'EventMask.EXPOSURE_MASK';
      case 4: return 'EventMask.POINTER_MOTION_MASK';
      case 8: return 'EventMask.POINTER_MOTION_HINT_MASK';
      case 16: return 'EventMask.BUTTON_MOTION_MASK';
      case 32: return 'EventMask.BUTTON1_MOTION_MASK';
      case 64: return 'EventMask.BUTTON2_MOTION_MASK';
      case 128: return 'EventMask.BUTTON3_MOTION_MASK';
      default: return 'new EventMask($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'EventMask.NULL';
    }
    List codes = [];
    for (var i=1; i <= 16777216; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  EventMask operator|(EventMask other) =>
    new EventMask(index | other.index);
  EventMask operator&(EventMask other) =>
    new EventMask(index & other.index);
}

class EventMotion extends GObjectBase {
  EventMotion.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'EventMotion');

  EventType get type => getFieldOfObject('type', 0);
  void set type(EventType value) => setFieldOfObject('type', 0, value);
  Window get window => getFieldOfObject('window', 1);
  void set window(Window value) => setFieldOfObject('window', 1, value);
  int get sendEvent => getFieldOfObject('send_event', 2);
  void set sendEvent(int value) => setFieldOfObject('send_event', 2, value);
  int get time => getFieldOfObject('time', 3);
  void set time(int value) => setFieldOfObject('time', 3, value);
  num get x => getFieldOfObject('x', 4);
  void set x(num value) => setFieldOfObject('x', 4, value);
  num get y => getFieldOfObject('y', 5);
  void set y(num value) => setFieldOfObject('y', 5, value);
  num get axes => getFieldOfObject('axes', 6);
  void set axes(num value) => setFieldOfObject('axes', 6, value);
  ModifierType get state => getFieldOfObject('state', 7);
  void set state(ModifierType value) => setFieldOfObject('state', 7, value);
  int get isHint => getFieldOfObject('is_hint', 8);
  void set isHint(int value) => setFieldOfObject('is_hint', 8, value);
  Device get device => getFieldOfObject('device', 9);
  void set device(Device value) => setFieldOfObject('device', 9, value);
  num get xRoot => getFieldOfObject('x_root', 10);
  void set xRoot(num value) => setFieldOfObject('x_root', 10, value);
  num get yRoot => getFieldOfObject('y_root', 11);
  void set yRoot(num value) => setFieldOfObject('y_root', 11, value);
}

class EventOwnerChange extends GObjectBase {
  EventOwnerChange.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'EventOwnerChange');

  EventType get type => getFieldOfObject('type', 0);
  void set type(EventType value) => setFieldOfObject('type', 0, value);
  Window get window => getFieldOfObject('window', 1);
  void set window(Window value) => setFieldOfObject('window', 1, value);
  int get sendEvent => getFieldOfObject('send_event', 2);
  void set sendEvent(int value) => setFieldOfObject('send_event', 2, value);
  Window get owner => getFieldOfObject('owner', 3);
  void set owner(Window value) => setFieldOfObject('owner', 3, value);
  OwnerChange get reason => getFieldOfObject('reason', 4);
  void set reason(OwnerChange value) => setFieldOfObject('reason', 4, value);
  Atom get selection => getFieldOfObject('selection', 5);
  void set selection(Atom value) => setFieldOfObject('selection', 5, value);
  int get time => getFieldOfObject('time', 6);
  void set time(int value) => setFieldOfObject('time', 6, value);
  int get selectionTime => getFieldOfObject('selection_time', 7);
  void set selectionTime(int value) => setFieldOfObject('selection_time', 7, value);
}

class EventProperty extends GObjectBase {
  EventProperty.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'EventProperty');

  EventType get type => getFieldOfObject('type', 0);
  void set type(EventType value) => setFieldOfObject('type', 0, value);
  Window get window => getFieldOfObject('window', 1);
  void set window(Window value) => setFieldOfObject('window', 1, value);
  int get sendEvent => getFieldOfObject('send_event', 2);
  void set sendEvent(int value) => setFieldOfObject('send_event', 2, value);
  Atom get atom => getFieldOfObject('atom', 3);
  void set atom(Atom value) => setFieldOfObject('atom', 3, value);
  int get time => getFieldOfObject('time', 4);
  void set time(int value) => setFieldOfObject('time', 4, value);
  PropertyState get state => getFieldOfObject('state', 5);
  void set state(PropertyState value) => setFieldOfObject('state', 5, value);
}

class EventProximity extends GObjectBase {
  EventProximity.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'EventProximity');

  EventType get type => getFieldOfObject('type', 0);
  void set type(EventType value) => setFieldOfObject('type', 0, value);
  Window get window => getFieldOfObject('window', 1);
  void set window(Window value) => setFieldOfObject('window', 1, value);
  int get sendEvent => getFieldOfObject('send_event', 2);
  void set sendEvent(int value) => setFieldOfObject('send_event', 2, value);
  int get time => getFieldOfObject('time', 3);
  void set time(int value) => setFieldOfObject('time', 3, value);
  Device get device => getFieldOfObject('device', 4);
  void set device(Device value) => setFieldOfObject('device', 4, value);
}

class EventScroll extends GObjectBase {
  EventScroll.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'EventScroll');

  EventType get type => getFieldOfObject('type', 0);
  void set type(EventType value) => setFieldOfObject('type', 0, value);
  Window get window => getFieldOfObject('window', 1);
  void set window(Window value) => setFieldOfObject('window', 1, value);
  int get sendEvent => getFieldOfObject('send_event', 2);
  void set sendEvent(int value) => setFieldOfObject('send_event', 2, value);
  int get time => getFieldOfObject('time', 3);
  void set time(int value) => setFieldOfObject('time', 3, value);
  num get x => getFieldOfObject('x', 4);
  void set x(num value) => setFieldOfObject('x', 4, value);
  num get y => getFieldOfObject('y', 5);
  void set y(num value) => setFieldOfObject('y', 5, value);
  ModifierType get state => getFieldOfObject('state', 6);
  void set state(ModifierType value) => setFieldOfObject('state', 6, value);
  ScrollDirection get direction => getFieldOfObject('direction', 7);
  void set direction(ScrollDirection value) => setFieldOfObject('direction', 7, value);
  Device get device => getFieldOfObject('device', 8);
  void set device(Device value) => setFieldOfObject('device', 8, value);
  num get xRoot => getFieldOfObject('x_root', 9);
  void set xRoot(num value) => setFieldOfObject('x_root', 9, value);
  num get yRoot => getFieldOfObject('y_root', 10);
  void set yRoot(num value) => setFieldOfObject('y_root', 10, value);
  num get deltaX => getFieldOfObject('delta_x', 11);
  void set deltaX(num value) => setFieldOfObject('delta_x', 11, value);
  num get deltaY => getFieldOfObject('delta_y', 12);
  void set deltaY(num value) => setFieldOfObject('delta_y', 12, value);
}

class EventSelection extends GObjectBase {
  EventSelection.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'EventSelection');

  EventType get type => getFieldOfObject('type', 0);
  void set type(EventType value) => setFieldOfObject('type', 0, value);
  Window get window => getFieldOfObject('window', 1);
  void set window(Window value) => setFieldOfObject('window', 1, value);
  int get sendEvent => getFieldOfObject('send_event', 2);
  void set sendEvent(int value) => setFieldOfObject('send_event', 2, value);
  Atom get selection => getFieldOfObject('selection', 3);
  void set selection(Atom value) => setFieldOfObject('selection', 3, value);
  Atom get target => getFieldOfObject('target', 4);
  void set target(Atom value) => setFieldOfObject('target', 4, value);
  Atom get property => getFieldOfObject('property', 5);
  void set property(Atom value) => setFieldOfObject('property', 5, value);
  int get time => getFieldOfObject('time', 6);
  void set time(int value) => setFieldOfObject('time', 6, value);
  Window get requestor => getFieldOfObject('requestor', 7);
  void set requestor(Window value) => setFieldOfObject('requestor', 7, value);
}

class EventSequence extends GObjectBase {
  EventSequence.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'EventSequence');

}

class EventSetting extends GObjectBase {
  EventSetting.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'EventSetting');

  EventType get type => getFieldOfObject('type', 0);
  void set type(EventType value) => setFieldOfObject('type', 0, value);
  Window get window => getFieldOfObject('window', 1);
  void set window(Window value) => setFieldOfObject('window', 1, value);
  int get sendEvent => getFieldOfObject('send_event', 2);
  void set sendEvent(int value) => setFieldOfObject('send_event', 2, value);
  SettingAction get action => getFieldOfObject('action', 3);
  void set action(SettingAction value) => setFieldOfObject('action', 3, value);
  String get name => getFieldOfObject('name', 4);
  void set name(String value) => setFieldOfObject('name', 4, value);
}

class EventTouch extends GObjectBase {
  EventTouch.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'EventTouch');

  EventType get type => getFieldOfObject('type', 0);
  void set type(EventType value) => setFieldOfObject('type', 0, value);
  Window get window => getFieldOfObject('window', 1);
  void set window(Window value) => setFieldOfObject('window', 1, value);
  int get sendEvent => getFieldOfObject('send_event', 2);
  void set sendEvent(int value) => setFieldOfObject('send_event', 2, value);
  int get time => getFieldOfObject('time', 3);
  void set time(int value) => setFieldOfObject('time', 3, value);
  num get x => getFieldOfObject('x', 4);
  void set x(num value) => setFieldOfObject('x', 4, value);
  num get y => getFieldOfObject('y', 5);
  void set y(num value) => setFieldOfObject('y', 5, value);
  num get axes => getFieldOfObject('axes', 6);
  void set axes(num value) => setFieldOfObject('axes', 6, value);
  ModifierType get state => getFieldOfObject('state', 7);
  void set state(ModifierType value) => setFieldOfObject('state', 7, value);
  EventSequence get sequence => getFieldOfObject('sequence', 8);
  void set sequence(EventSequence value) => setFieldOfObject('sequence', 8, value);
  bool get emulatingPointer => getFieldOfObject('emulating_pointer', 9);
  void set emulatingPointer(bool value) => setFieldOfObject('emulating_pointer', 9, value);
  Device get device => getFieldOfObject('device', 10);
  void set device(Device value) => setFieldOfObject('device', 10, value);
  num get xRoot => getFieldOfObject('x_root', 11);
  void set xRoot(num value) => setFieldOfObject('x_root', 11, value);
  num get yRoot => getFieldOfObject('y_root', 12);
  void set yRoot(num value) => setFieldOfObject('y_root', 12, value);
}

class EventTouchpadPinch extends GObjectBase {
  EventTouchpadPinch.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'EventTouchpadPinch');

  EventType get type => getFieldOfObject('type', 0);
  void set type(EventType value) => setFieldOfObject('type', 0, value);
  Window get window => getFieldOfObject('window', 1);
  void set window(Window value) => setFieldOfObject('window', 1, value);
  int get sendEvent => getFieldOfObject('send_event', 2);
  void set sendEvent(int value) => setFieldOfObject('send_event', 2, value);
  TouchpadGesturePhase get phase => getFieldOfObject('phase', 3);
  void set phase(TouchpadGesturePhase value) => setFieldOfObject('phase', 3, value);
  int get nFingers => getFieldOfObject('n_fingers', 4);
  void set nFingers(int value) => setFieldOfObject('n_fingers', 4, value);
  int get time => getFieldOfObject('time', 5);
  void set time(int value) => setFieldOfObject('time', 5, value);
  num get x => getFieldOfObject('x', 6);
  void set x(num value) => setFieldOfObject('x', 6, value);
  num get y => getFieldOfObject('y', 7);
  void set y(num value) => setFieldOfObject('y', 7, value);
  num get dx => getFieldOfObject('dx', 8);
  void set dx(num value) => setFieldOfObject('dx', 8, value);
  num get dy => getFieldOfObject('dy', 9);
  void set dy(num value) => setFieldOfObject('dy', 9, value);
  num get angleDelta => getFieldOfObject('angle_delta', 10);
  void set angleDelta(num value) => setFieldOfObject('angle_delta', 10, value);
  num get scale => getFieldOfObject('scale', 11);
  void set scale(num value) => setFieldOfObject('scale', 11, value);
  num get xRoot => getFieldOfObject('x_root', 12);
  void set xRoot(num value) => setFieldOfObject('x_root', 12, value);
  num get yRoot => getFieldOfObject('y_root', 13);
  void set yRoot(num value) => setFieldOfObject('y_root', 13, value);
  ModifierType get state => getFieldOfObject('state', 14);
  void set state(ModifierType value) => setFieldOfObject('state', 14, value);
}

class EventTouchpadSwipe extends GObjectBase {
  EventTouchpadSwipe.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'EventTouchpadSwipe');

  EventType get type => getFieldOfObject('type', 0);
  void set type(EventType value) => setFieldOfObject('type', 0, value);
  Window get window => getFieldOfObject('window', 1);
  void set window(Window value) => setFieldOfObject('window', 1, value);
  int get sendEvent => getFieldOfObject('send_event', 2);
  void set sendEvent(int value) => setFieldOfObject('send_event', 2, value);
  TouchpadGesturePhase get phase => getFieldOfObject('phase', 3);
  void set phase(TouchpadGesturePhase value) => setFieldOfObject('phase', 3, value);
  int get nFingers => getFieldOfObject('n_fingers', 4);
  void set nFingers(int value) => setFieldOfObject('n_fingers', 4, value);
  int get time => getFieldOfObject('time', 5);
  void set time(int value) => setFieldOfObject('time', 5, value);
  num get x => getFieldOfObject('x', 6);
  void set x(num value) => setFieldOfObject('x', 6, value);
  num get y => getFieldOfObject('y', 7);
  void set y(num value) => setFieldOfObject('y', 7, value);
  num get dx => getFieldOfObject('dx', 8);
  void set dx(num value) => setFieldOfObject('dx', 8, value);
  num get dy => getFieldOfObject('dy', 9);
  void set dy(num value) => setFieldOfObject('dy', 9, value);
  num get xRoot => getFieldOfObject('x_root', 10);
  void set xRoot(num value) => setFieldOfObject('x_root', 10, value);
  num get yRoot => getFieldOfObject('y_root', 11);
  void set yRoot(num value) => setFieldOfObject('y_root', 11, value);
  ModifierType get state => getFieldOfObject('state', 12);
  void set state(ModifierType value) => setFieldOfObject('state', 12, value);
}

class EventType extends GEnumBase {
  const EventType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'EventType');

  static const EventType NOTHING = const EventType(-1);
  static const EventType DELETE = const EventType(0);
  static const EventType DESTROY = const EventType(1);
  static const EventType EXPOSE = const EventType(2);
  static const EventType MOTION_NOTIFY = const EventType(3);
  static const EventType BUTTON_PRESS = const EventType(4);
  static const EventType DOUBLE_BUTTON_PRESS = const EventType(5);
  static const EventType TRIPLE_BUTTON_PRESS = const EventType(6);
  static const EventType BUTTON_RELEASE = const EventType(7);
  static const EventType KEY_PRESS = const EventType(8);
  static const EventType KEY_RELEASE = const EventType(9);
  static const EventType ENTER_NOTIFY = const EventType(10);
  static const EventType LEAVE_NOTIFY = const EventType(11);
  static const EventType FOCUS_CHANGE = const EventType(12);
  static const EventType CONFIGURE = const EventType(13);
  static const EventType MAP = const EventType(14);
  static const EventType UNMAP = const EventType(15);
  static const EventType PROPERTY_NOTIFY = const EventType(16);
  static const EventType SELECTION_CLEAR = const EventType(17);
  static const EventType SELECTION_REQUEST = const EventType(18);
  static const EventType SELECTION_NOTIFY = const EventType(19);
  static const EventType PROXIMITY_IN = const EventType(20);
  static const EventType PROXIMITY_OUT = const EventType(21);
  static const EventType DRAG_ENTER = const EventType(22);
  static const EventType DRAG_LEAVE = const EventType(23);
  static const EventType DRAG_MOTION = const EventType(24);
  static const EventType DRAG_STATUS = const EventType(25);
  static const EventType DROP_START = const EventType(26);
  static const EventType DROP_FINISHED = const EventType(27);
  static const EventType CLIENT_EVENT = const EventType(28);
  static const EventType VISIBILITY_NOTIFY = const EventType(29);
  static const EventType SCROLL = const EventType(31);
  static const EventType WINDOW_STATE = const EventType(32);
  static const EventType SETTING = const EventType(33);
  static const EventType OWNER_CHANGE = const EventType(34);
  static const EventType GRAB_BROKEN = const EventType(35);
  static const EventType DAMAGE = const EventType(36);
  static const EventType TOUCH_BEGIN = const EventType(37);
  static const EventType TOUCH_UPDATE = const EventType(38);
  static const EventType TOUCH_END = const EventType(39);
  static const EventType TOUCH_CANCEL = const EventType(40);
  static const EventType TOUCHPAD_SWIPE = const EventType(41);
  static const EventType TOUCHPAD_PINCH = const EventType(42);
  static const EventType EVENT_LAST = const EventType(43);
  String toString() {
    switch(index) {
      case -1: return 'EventType.NOTHING';
      case 0: return 'EventType.DELETE';
      case 1: return 'EventType.DESTROY';
      case 2: return 'EventType.EXPOSE';
      case 3: return 'EventType.MOTION_NOTIFY';
      case 4: return 'EventType.BUTTON_PRESS';
      case 5: return 'EventType.DOUBLE_BUTTON_PRESS';
      case 6: return 'EventType.TRIPLE_BUTTON_PRESS';
      case 7: return 'EventType.BUTTON_RELEASE';
      case 8: return 'EventType.KEY_PRESS';
      case 9: return 'EventType.KEY_RELEASE';
      case 10: return 'EventType.ENTER_NOTIFY';
      case 11: return 'EventType.LEAVE_NOTIFY';
      case 12: return 'EventType.FOCUS_CHANGE';
      case 13: return 'EventType.CONFIGURE';
      case 14: return 'EventType.MAP';
      case 15: return 'EventType.UNMAP';
      case 16: return 'EventType.PROPERTY_NOTIFY';
      case 17: return 'EventType.SELECTION_CLEAR';
      case 18: return 'EventType.SELECTION_REQUEST';
      case 19: return 'EventType.SELECTION_NOTIFY';
      case 20: return 'EventType.PROXIMITY_IN';
      case 21: return 'EventType.PROXIMITY_OUT';
      case 22: return 'EventType.DRAG_ENTER';
      case 23: return 'EventType.DRAG_LEAVE';
      case 24: return 'EventType.DRAG_MOTION';
      case 25: return 'EventType.DRAG_STATUS';
      case 26: return 'EventType.DROP_START';
      case 27: return 'EventType.DROP_FINISHED';
      case 28: return 'EventType.CLIENT_EVENT';
      case 29: return 'EventType.VISIBILITY_NOTIFY';
      case 31: return 'EventType.SCROLL';
      case 32: return 'EventType.WINDOW_STATE';
      case 33: return 'EventType.SETTING';
      case 34: return 'EventType.OWNER_CHANGE';
      case 35: return 'EventType.GRAB_BROKEN';
      case 36: return 'EventType.DAMAGE';
      case 37: return 'EventType.TOUCH_BEGIN';
      case 38: return 'EventType.TOUCH_UPDATE';
      case 39: return 'EventType.TOUCH_END';
      case 40: return 'EventType.TOUCH_CANCEL';
      case 41: return 'EventType.TOUCHPAD_SWIPE';
      case 42: return 'EventType.TOUCHPAD_PINCH';
      case 43: return 'EventType.EVENT_LAST';
      default: return 'new EventType($index)';
    }
  }
}

class EventVisibility extends GObjectBase {
  EventVisibility.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'EventVisibility');

  EventType get type => getFieldOfObject('type', 0);
  void set type(EventType value) => setFieldOfObject('type', 0, value);
  Window get window => getFieldOfObject('window', 1);
  void set window(Window value) => setFieldOfObject('window', 1, value);
  int get sendEvent => getFieldOfObject('send_event', 2);
  void set sendEvent(int value) => setFieldOfObject('send_event', 2, value);
  VisibilityState get state => getFieldOfObject('state', 3);
  void set state(VisibilityState value) => setFieldOfObject('state', 3, value);
}

class EventWindowState extends GObjectBase {
  EventWindowState.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'EventWindowState');

  EventType get type => getFieldOfObject('type', 0);
  void set type(EventType value) => setFieldOfObject('type', 0, value);
  Window get window => getFieldOfObject('window', 1);
  void set window(Window value) => setFieldOfObject('window', 1, value);
  int get sendEvent => getFieldOfObject('send_event', 2);
  void set sendEvent(int value) => setFieldOfObject('send_event', 2, value);
  WindowState get changedMask => getFieldOfObject('changed_mask', 3);
  void set changedMask(WindowState value) => setFieldOfObject('changed_mask', 3, value);
  WindowState get newWindowState => getFieldOfObject('new_window_state', 4);
  void set newWindowState(WindowState value) => setFieldOfObject('new_window_state', 4, value);
}

typedef FilterReturn FilterFunc(dynamic xevent /* this will fail */, Event event);
class FilterReturn extends GEnumBase {
  const FilterReturn(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'FilterReturn');

  static const FilterReturn CONTINUE = const FilterReturn(0);
  static const FilterReturn TRANSLATE = const FilterReturn(1);
  static const FilterReturn REMOVE = const FilterReturn(2);
  String toString() {
    switch(index) {
      case 0: return 'FilterReturn.CONTINUE';
      case 1: return 'FilterReturn.TRANSLATE';
      case 2: return 'FilterReturn.REMOVE';
      default: return 'new FilterReturn($index)';
    }
  }
}

class FrameClock extends GObjectObject {
  FrameClock.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'FrameClock');

  void beginUpdating() => _staticInfo.callMethodOnReceiver('begin_updating', this, []);
  void endUpdating() => _staticInfo.callMethodOnReceiver('end_updating', this, []);
  FrameTimings get currentTimings => _staticInfo.callMethodOnReceiver('get_current_timings', this, []);
  int get frameCounter => _staticInfo.callMethodOnReceiver('get_frame_counter', this, []);
  int get frameTime => _staticInfo.callMethodOnReceiver('get_frame_time', this, []);
  int get historyStart => _staticInfo.callMethodOnReceiver('get_history_start', this, []);
  void getRefreshInfo(int baseTime, int refreshIntervalReturn, int presentationTimeReturn) => _staticInfo.callMethodOnReceiver('get_refresh_info', this, [baseTime, refreshIntervalReturn, presentationTimeReturn]);
  FrameTimings getTimings(int frameCounter) => _staticInfo.callMethodOnReceiver('get_timings', this, [frameCounter]);
  void requestPhase(FrameClockPhase phase) => _staticInfo.callMethodOnReceiver('request_phase', this, [phase]);
  int _connectToAfterPaint(bool after, void func()) => signalConnect('after-paint', func, after);
  Stream get onAfterPaint {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToAfterPaint(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterAfterPaint {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToAfterPaint(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToBeforePaint(bool after, void func()) => signalConnect('before-paint', func, after);
  Stream get onBeforePaint {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToBeforePaint(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterBeforePaint {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToBeforePaint(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToFlushEvents(bool after, void func()) => signalConnect('flush-events', func, after);
  Stream get onFlushEvents {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToFlushEvents(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterFlushEvents {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToFlushEvents(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToLayout(bool after, void func()) => signalConnect('layout', func, after);
  Stream get onLayout {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToLayout(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterLayout {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToLayout(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToPaint(bool after, void func()) => signalConnect('paint', func, after);
  Stream get onPaint {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToPaint(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterPaint {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToPaint(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToResumeEvents(bool after, void func()) => signalConnect('resume-events', func, after);
  Stream get onResumeEvents {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToResumeEvents(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterResumeEvents {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToResumeEvents(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToUpdate(bool after, void func()) => signalConnect('update', func, after);
  Stream get onUpdate {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToUpdate(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterUpdate {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToUpdate(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
}

class FrameClockPhase extends GEnumBase {
  const FrameClockPhase(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'FrameClockPhase');

  static const FrameClockPhase NONE = const FrameClockPhase(0);
  bool get none => (index & 0) == 0;
  static const FrameClockPhase FLUSH_EVENTS = const FrameClockPhase(1);
  bool get flushEvents => (index & 1) == 1;
  static const FrameClockPhase BEFORE_PAINT = const FrameClockPhase(2);
  bool get beforePaint => (index & 2) == 2;
  static const FrameClockPhase UPDATE = const FrameClockPhase(4);
  bool get update => (index & 4) == 4;
  static const FrameClockPhase LAYOUT = const FrameClockPhase(8);
  bool get layout => (index & 8) == 8;
  static const FrameClockPhase PAINT = const FrameClockPhase(16);
  bool get paint => (index & 16) == 16;
  static const FrameClockPhase RESUME_EVENTS = const FrameClockPhase(32);
  bool get resumeEvents => (index & 32) == 32;
  static const FrameClockPhase AFTER_PAINT = const FrameClockPhase(64);
  bool get afterPaint => (index & 64) == 64;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'FrameClockPhase.FLUSH_EVENTS';
      case 2: return 'FrameClockPhase.BEFORE_PAINT';
      case 4: return 'FrameClockPhase.UPDATE';
      case 8: return 'FrameClockPhase.LAYOUT';
      case 16: return 'FrameClockPhase.PAINT';
      case 32: return 'FrameClockPhase.RESUME_EVENTS';
      case 64: return 'FrameClockPhase.AFTER_PAINT';
      default: return 'new FrameClockPhase($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'FrameClockPhase.NONE';
    }
    List codes = [];
    for (var i=1; i <= 64; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  FrameClockPhase operator|(FrameClockPhase other) =>
    new FrameClockPhase(index | other.index);
  FrameClockPhase operator&(FrameClockPhase other) =>
    new FrameClockPhase(index & other.index);
}

class FrameClockPrivate extends GObjectBase {
  FrameClockPrivate.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'FrameClockPrivate');

}

class FrameTimings extends GObjectBase {
  FrameTimings.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'FrameTimings');

  bool get complete => _staticInfo.callMethodOnReceiver('get_complete', this, []);
  int get frameCounter => _staticInfo.callMethodOnReceiver('get_frame_counter', this, []);
  int get frameTime => _staticInfo.callMethodOnReceiver('get_frame_time', this, []);
  int get predictedPresentationTime => _staticInfo.callMethodOnReceiver('get_predicted_presentation_time', this, []);
  int get presentationTime => _staticInfo.callMethodOnReceiver('get_presentation_time', this, []);
  int get refreshInterval => _staticInfo.callMethodOnReceiver('get_refresh_interval', this, []);
  FrameTimings ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
}

class FullscreenMode extends GEnumBase {
  const FullscreenMode(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'FullscreenMode');

  static const FullscreenMode CURRENT_MONITOR = const FullscreenMode(0);
  static const FullscreenMode ALL_MONITORS = const FullscreenMode(1);
  String toString() {
    switch(index) {
      case 0: return 'FullscreenMode.CURRENT_MONITOR';
      case 1: return 'FullscreenMode.ALL_MONITORS';
      default: return 'new FullscreenMode($index)';
    }
  }
}

class GLContext extends GObjectObject {
  GLContext.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'GLContext');

  void set display(Display value) => _staticInfo.setGPropertyOnReceiver('display', this, value);
  static const String DISPLAY_PROPERTY = 'display';
  void set sharedContext(GLContext value) => _staticInfo.setGPropertyOnReceiver('shared-context', this, value);
  static const String SHARED_CONTEXT_PROPERTY = 'shared-context';
  void set window(Window value) => _staticInfo.setGPropertyOnReceiver('window', this, value);
  static const String WINDOW_PROPERTY = 'window';
  static void clearCurrent() => _staticInfo.callStatic('clear_current', []);
  static GLContext getCurrent() => _staticInfo.callStatic('get_current', []);
  bool get debugEnabled => _staticInfo.callMethodOnReceiver('get_debug_enabled', this, []);
  Display get display_ => _staticInfo.callMethodOnReceiver('get_display', this, []);
  bool get forwardCompatible => _staticInfo.callMethodOnReceiver('get_forward_compatible', this, []);
  List getRequiredVersion() => _staticInfo.callMethodOnReceiver('get_required_version', this, []);
  GLContext get sharedContext_ => _staticInfo.callMethodOnReceiver('get_shared_context', this, []);
  List getVersion() => _staticInfo.callMethodOnReceiver('get_version', this, []);
  Window get window_ => _staticInfo.callMethodOnReceiver('get_window', this, []);
  void makeCurrent() => _staticInfo.callMethodOnReceiver('make_current', this, []);
  void realize() => _staticInfo.callMethodOnReceiver('realize', this, []);
  void set debugEnabled(bool enabled) => _staticInfo.callMethodOnReceiver('set_debug_enabled', this, [enabled]);
  void set forwardCompatible(bool compatible) => _staticInfo.callMethodOnReceiver('set_forward_compatible', this, [compatible]);
  void setRequiredVersion(int major, int minor) => _staticInfo.callMethodOnReceiver('set_required_version', this, [major, minor]);
}

class GLErrorCode extends GEnumBase {
  const GLErrorCode(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'GLError');

  static const GLErrorCode NOT_AVAILABLE = const GLErrorCode(0);
  static const GLErrorCode UNSUPPORTED_FORMAT = const GLErrorCode(1);
  static const GLErrorCode UNSUPPORTED_PROFILE = const GLErrorCode(2);
  String toString() {
    switch(index) {
      case 0: return 'GLErrorCode.NOT_AVAILABLE';
      case 1: return 'GLErrorCode.UNSUPPORTED_FORMAT';
      case 2: return 'GLErrorCode.UNSUPPORTED_PROFILE';
      default: return 'new GLErrorCode($index)';
    }
  }
  static int quark() => _staticInfo.callStatic('quark', []);
}

class GLError extends GErrorBase {
  static final int _quark = lookupErrorQuarkFromString('gdk-gl-error-quark');
  GLError(GLErrorCode code, String message)
      : super.fromFields(_quark, code, message);
}

class Geometry extends GObjectBase {
  Geometry.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'Geometry');
  factory Geometry() => _staticInfo.allocateNew();

  int get minWidth => getFieldOfObject('min_width', 0);
  void set minWidth(int value) => setFieldOfObject('min_width', 0, value);
  int get minHeight => getFieldOfObject('min_height', 1);
  void set minHeight(int value) => setFieldOfObject('min_height', 1, value);
  int get maxWidth => getFieldOfObject('max_width', 2);
  void set maxWidth(int value) => setFieldOfObject('max_width', 2, value);
  int get maxHeight => getFieldOfObject('max_height', 3);
  void set maxHeight(int value) => setFieldOfObject('max_height', 3, value);
  int get baseWidth => getFieldOfObject('base_width', 4);
  void set baseWidth(int value) => setFieldOfObject('base_width', 4, value);
  int get baseHeight => getFieldOfObject('base_height', 5);
  void set baseHeight(int value) => setFieldOfObject('base_height', 5, value);
  int get widthInc => getFieldOfObject('width_inc', 6);
  void set widthInc(int value) => setFieldOfObject('width_inc', 6, value);
  int get heightInc => getFieldOfObject('height_inc', 7);
  void set heightInc(int value) => setFieldOfObject('height_inc', 7, value);
  num get minAspect => getFieldOfObject('min_aspect', 8);
  void set minAspect(num value) => setFieldOfObject('min_aspect', 8, value);
  num get maxAspect => getFieldOfObject('max_aspect', 9);
  void set maxAspect(num value) => setFieldOfObject('max_aspect', 9, value);
  Gravity get winGravity => getFieldOfObject('win_gravity', 10);
  void set winGravity(Gravity value) => setFieldOfObject('win_gravity', 10, value);
}

class GrabOwnership extends GEnumBase {
  const GrabOwnership(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'GrabOwnership');

  static const GrabOwnership NONE = const GrabOwnership(0);
  static const GrabOwnership WINDOW = const GrabOwnership(1);
  static const GrabOwnership APPLICATION = const GrabOwnership(2);
  String toString() {
    switch(index) {
      case 0: return 'GrabOwnership.NONE';
      case 1: return 'GrabOwnership.WINDOW';
      case 2: return 'GrabOwnership.APPLICATION';
      default: return 'new GrabOwnership($index)';
    }
  }
}

class GrabStatus extends GEnumBase {
  const GrabStatus(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'GrabStatus');

  static const GrabStatus SUCCESS = const GrabStatus(0);
  static const GrabStatus ALREADY_GRABBED = const GrabStatus(1);
  static const GrabStatus INVALID_TIME = const GrabStatus(2);
  static const GrabStatus NOT_VIEWABLE = const GrabStatus(3);
  static const GrabStatus FROZEN = const GrabStatus(4);
  static const GrabStatus FAILED = const GrabStatus(5);
  String toString() {
    switch(index) {
      case 0: return 'GrabStatus.SUCCESS';
      case 1: return 'GrabStatus.ALREADY_GRABBED';
      case 2: return 'GrabStatus.INVALID_TIME';
      case 3: return 'GrabStatus.NOT_VIEWABLE';
      case 4: return 'GrabStatus.FROZEN';
      case 5: return 'GrabStatus.FAILED';
      default: return 'new GrabStatus($index)';
    }
  }
}

class Gravity extends GEnumBase {
  const Gravity(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'Gravity');

  static const Gravity NORTH_WEST = const Gravity(1);
  static const Gravity NORTH = const Gravity(2);
  static const Gravity NORTH_EAST = const Gravity(3);
  static const Gravity WEST = const Gravity(4);
  static const Gravity CENTER = const Gravity(5);
  static const Gravity EAST = const Gravity(6);
  static const Gravity SOUTH_WEST = const Gravity(7);
  static const Gravity SOUTH = const Gravity(8);
  static const Gravity SOUTH_EAST = const Gravity(9);
  static const Gravity STATIC = const Gravity(10);
  String toString() {
    switch(index) {
      case 1: return 'Gravity.NORTH_WEST';
      case 2: return 'Gravity.NORTH';
      case 3: return 'Gravity.NORTH_EAST';
      case 4: return 'Gravity.WEST';
      case 5: return 'Gravity.CENTER';
      case 6: return 'Gravity.EAST';
      case 7: return 'Gravity.SOUTH_WEST';
      case 8: return 'Gravity.SOUTH';
      case 9: return 'Gravity.SOUTH_EAST';
      case 10: return 'Gravity.STATIC';
      default: return 'new Gravity($index)';
    }
  }
}

class InputMode extends GEnumBase {
  const InputMode(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'InputMode');

  static const InputMode DISABLED = const InputMode(0);
  static const InputMode SCREEN = const InputMode(1);
  static const InputMode WINDOW = const InputMode(2);
  String toString() {
    switch(index) {
      case 0: return 'InputMode.DISABLED';
      case 1: return 'InputMode.SCREEN';
      case 2: return 'InputMode.WINDOW';
      default: return 'new InputMode($index)';
    }
  }
}

class InputSource extends GEnumBase {
  const InputSource(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'InputSource');

  static const InputSource MOUSE = const InputSource(0);
  static const InputSource PEN = const InputSource(1);
  static const InputSource ERASER = const InputSource(2);
  static const InputSource CURSOR = const InputSource(3);
  static const InputSource KEYBOARD = const InputSource(4);
  static const InputSource TOUCHSCREEN = const InputSource(5);
  static const InputSource TOUCHPAD = const InputSource(6);
  String toString() {
    switch(index) {
      case 0: return 'InputSource.MOUSE';
      case 1: return 'InputSource.PEN';
      case 2: return 'InputSource.ERASER';
      case 3: return 'InputSource.CURSOR';
      case 4: return 'InputSource.KEYBOARD';
      case 5: return 'InputSource.TOUCHSCREEN';
      case 6: return 'InputSource.TOUCHPAD';
      default: return 'new InputSource($index)';
    }
  }
}

class Keymap extends GObjectObject {
  Keymap.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'Keymap');

  static Keymap getDefault() => _staticInfo.callStatic('get_default', []);
  static Keymap getForDisplay(Display display) => _staticInfo.callStatic('get_for_display', [display]);
  ModifierType addVirtualModifiers(ModifierType state) => _staticInfo.callMethodOnReceiver('add_virtual_modifiers', this, [state]);
  bool get capsLockState => _staticInfo.callMethodOnReceiver('get_caps_lock_state', this, []);
  Direction get direction => _staticInfo.callMethodOnReceiver('get_direction', this, []);
  List getEntriesForKeycode(int hardwareKeycode) => _staticInfo.callMethodOnReceiver('get_entries_for_keycode', this, [hardwareKeycode]);
  List getEntriesForKeyval(int keyval) => _staticInfo.callMethodOnReceiver('get_entries_for_keyval', this, [keyval]);
  ModifierType getModifierMask(ModifierIntent intent) => _staticInfo.callMethodOnReceiver('get_modifier_mask', this, [intent]);
  int get modifierState => _staticInfo.callMethodOnReceiver('get_modifier_state', this, []);
  bool get numLockState => _staticInfo.callMethodOnReceiver('get_num_lock_state', this, []);
  bool get scrollLockState => _staticInfo.callMethodOnReceiver('get_scroll_lock_state', this, []);
  bool haveBidiLayouts() => _staticInfo.callMethodOnReceiver('have_bidi_layouts', this, []);
  int lookupKey(KeymapKey key) => _staticInfo.callMethodOnReceiver('lookup_key', this, [key]);
  List mapVirtualModifiers(ModifierType state) => _staticInfo.callMethodOnReceiver('map_virtual_modifiers', this, [state]);
  List translateKeyboardState(int hardwareKeycode, ModifierType state, int group) => _staticInfo.callMethodOnReceiver('translate_keyboard_state', this, [hardwareKeycode, state, group]);
  int _connectToDirectionChanged(bool after, void func()) => signalConnect('direction-changed', func, after);
  Stream get onDirectionChanged {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToDirectionChanged(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterDirectionChanged {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToDirectionChanged(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToKeysChanged(bool after, void func()) => signalConnect('keys-changed', func, after);
  Stream get onKeysChanged {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToKeysChanged(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterKeysChanged {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToKeysChanged(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToStateChanged(bool after, void func()) => signalConnect('state-changed', func, after);
  Stream get onStateChanged {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToStateChanged(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterStateChanged {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToStateChanged(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
}

class KeymapKey extends GObjectBase {
  KeymapKey.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'KeymapKey');

  int get keycode => getFieldOfObject('keycode', 0);
  void set keycode(int value) => setFieldOfObject('keycode', 0, value);
  int get group => getFieldOfObject('group', 1);
  void set group(int value) => setFieldOfObject('group', 1, value);
  int get level => getFieldOfObject('level', 2);
  void set level(int value) => setFieldOfObject('level', 2, value);
}

class ModifierIntent extends GEnumBase {
  const ModifierIntent(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'ModifierIntent');

  static const ModifierIntent PRIMARY_ACCELERATOR = const ModifierIntent(0);
  static const ModifierIntent CONTEXT_MENU = const ModifierIntent(1);
  static const ModifierIntent EXTEND_SELECTION = const ModifierIntent(2);
  static const ModifierIntent MODIFY_SELECTION = const ModifierIntent(3);
  static const ModifierIntent NO_TEXT_INPUT = const ModifierIntent(4);
  static const ModifierIntent SHIFT_GROUP = const ModifierIntent(5);
  static const ModifierIntent DEFAULT_MOD_MASK = const ModifierIntent(6);
  String toString() {
    switch(index) {
      case 0: return 'ModifierIntent.PRIMARY_ACCELERATOR';
      case 1: return 'ModifierIntent.CONTEXT_MENU';
      case 2: return 'ModifierIntent.EXTEND_SELECTION';
      case 3: return 'ModifierIntent.MODIFY_SELECTION';
      case 4: return 'ModifierIntent.NO_TEXT_INPUT';
      case 5: return 'ModifierIntent.SHIFT_GROUP';
      case 6: return 'ModifierIntent.DEFAULT_MOD_MASK';
      default: return 'new ModifierIntent($index)';
    }
  }
}

class ModifierType extends GEnumBase {
  const ModifierType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'ModifierType');

  static const ModifierType NULL = const ModifierType(0);
  static const ModifierType SHIFT_MASK = const ModifierType(1);
  bool get shiftMask => (index & 1) == 1;
  static const ModifierType LOCK_MASK = const ModifierType(2);
  bool get lockMask => (index & 2) == 2;
  static const ModifierType CONTROL_MASK = const ModifierType(4);
  bool get controlMask => (index & 4) == 4;
  static const ModifierType MOD1_MASK = const ModifierType(8);
  bool get mod1Mask => (index & 8) == 8;
  static const ModifierType MOD2_MASK = const ModifierType(16);
  bool get mod2Mask => (index & 16) == 16;
  static const ModifierType MOD3_MASK = const ModifierType(32);
  bool get mod3Mask => (index & 32) == 32;
  static const ModifierType MOD4_MASK = const ModifierType(64);
  bool get mod4Mask => (index & 64) == 64;
  static const ModifierType MOD5_MASK = const ModifierType(128);
  bool get mod5Mask => (index & 128) == 128;
  static const ModifierType BUTTON1_MASK = const ModifierType(256);
  bool get button1Mask => (index & 256) == 256;
  static const ModifierType BUTTON2_MASK = const ModifierType(512);
  bool get button2Mask => (index & 512) == 512;
  static const ModifierType BUTTON3_MASK = const ModifierType(1024);
  bool get button3Mask => (index & 1024) == 1024;
  static const ModifierType BUTTON4_MASK = const ModifierType(2048);
  bool get button4Mask => (index & 2048) == 2048;
  static const ModifierType BUTTON5_MASK = const ModifierType(4096);
  bool get button5Mask => (index & 4096) == 4096;
  static const ModifierType MODIFIER_RESERVED_13_MASK = const ModifierType(8192);
  bool get modifierReserved_13Mask => (index & 8192) == 8192;
  static const ModifierType MODIFIER_RESERVED_14_MASK = const ModifierType(16384);
  bool get modifierReserved_14Mask => (index & 16384) == 16384;
  static const ModifierType MODIFIER_RESERVED_15_MASK = const ModifierType(32768);
  bool get modifierReserved_15Mask => (index & 32768) == 32768;
  static const ModifierType MODIFIER_RESERVED_16_MASK = const ModifierType(65536);
  bool get modifierReserved_16Mask => (index & 65536) == 65536;
  static const ModifierType MODIFIER_RESERVED_17_MASK = const ModifierType(131072);
  bool get modifierReserved_17Mask => (index & 131072) == 131072;
  static const ModifierType MODIFIER_RESERVED_18_MASK = const ModifierType(262144);
  bool get modifierReserved_18Mask => (index & 262144) == 262144;
  static const ModifierType MODIFIER_RESERVED_19_MASK = const ModifierType(524288);
  bool get modifierReserved_19Mask => (index & 524288) == 524288;
  static const ModifierType MODIFIER_RESERVED_20_MASK = const ModifierType(1048576);
  bool get modifierReserved_20Mask => (index & 1048576) == 1048576;
  static const ModifierType MODIFIER_RESERVED_21_MASK = const ModifierType(2097152);
  bool get modifierReserved_21Mask => (index & 2097152) == 2097152;
  static const ModifierType MODIFIER_RESERVED_22_MASK = const ModifierType(4194304);
  bool get modifierReserved_22Mask => (index & 4194304) == 4194304;
  static const ModifierType MODIFIER_RESERVED_23_MASK = const ModifierType(8388608);
  bool get modifierReserved_23Mask => (index & 8388608) == 8388608;
  static const ModifierType MODIFIER_RESERVED_24_MASK = const ModifierType(16777216);
  bool get modifierReserved_24Mask => (index & 16777216) == 16777216;
  static const ModifierType MODIFIER_RESERVED_25_MASK = const ModifierType(33554432);
  bool get modifierReserved_25Mask => (index & 33554432) == 33554432;
  static const ModifierType SUPER_MASK = const ModifierType(67108864);
  bool get superMask => (index & 67108864) == 67108864;
  static const ModifierType HYPER_MASK = const ModifierType(134217728);
  bool get hyperMask => (index & 134217728) == 134217728;
  static const ModifierType META_MASK = const ModifierType(268435456);
  bool get metaMask => (index & 268435456) == 268435456;
  static const ModifierType MODIFIER_RESERVED_29_MASK = const ModifierType(536870912);
  bool get modifierReserved_29Mask => (index & 536870912) == 536870912;
  static const ModifierType RELEASE_MASK = const ModifierType(1073741824);
  bool get releaseMask => (index & 1073741824) == 1073741824;
  static const ModifierType MODIFIER_MASK = const ModifierType(1543512063);
  bool get modifierMask => (index & 1543512063) == 1543512063;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'ModifierType.SHIFT_MASK';
      case 2: return 'ModifierType.LOCK_MASK';
      case 4: return 'ModifierType.CONTROL_MASK';
      case 8: return 'ModifierType.MOD1_MASK';
      case 16: return 'ModifierType.MOD2_MASK';
      case 32: return 'ModifierType.MOD3_MASK';
      case 64: return 'ModifierType.MOD4_MASK';
      case 128: return 'ModifierType.MOD5_MASK';
      default: return 'new ModifierType($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'ModifierType.NULL';
    }
    List codes = [];
    for (var i=1; i <= 1073741824; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  ModifierType operator|(ModifierType other) =>
    new ModifierType(index | other.index);
  ModifierType operator&(ModifierType other) =>
    new ModifierType(index & other.index);
}

class NotifyType extends GEnumBase {
  const NotifyType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'NotifyType');

  static const NotifyType ANCESTOR = const NotifyType(0);
  static const NotifyType VIRTUAL = const NotifyType(1);
  static const NotifyType INFERIOR = const NotifyType(2);
  static const NotifyType NONLINEAR = const NotifyType(3);
  static const NotifyType NONLINEAR_VIRTUAL = const NotifyType(4);
  static const NotifyType UNKNOWN = const NotifyType(5);
  String toString() {
    switch(index) {
      case 0: return 'NotifyType.ANCESTOR';
      case 1: return 'NotifyType.VIRTUAL';
      case 2: return 'NotifyType.INFERIOR';
      case 3: return 'NotifyType.NONLINEAR';
      case 4: return 'NotifyType.NONLINEAR_VIRTUAL';
      case 5: return 'NotifyType.UNKNOWN';
      default: return 'new NotifyType($index)';
    }
  }
}

class OwnerChange extends GEnumBase {
  const OwnerChange(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'OwnerChange');

  static const OwnerChange NEW_OWNER = const OwnerChange(0);
  static const OwnerChange DESTROY = const OwnerChange(1);
  static const OwnerChange CLOSE = const OwnerChange(2);
  String toString() {
    switch(index) {
      case 0: return 'OwnerChange.NEW_OWNER';
      case 1: return 'OwnerChange.DESTROY';
      case 2: return 'OwnerChange.CLOSE';
      default: return 'new OwnerChange($index)';
    }
  }
}

class Point extends GObjectBase {
  Point.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'Point');

  int get x => getFieldOfObject('x', 0);
  void set x(int value) => setFieldOfObject('x', 0, value);
  int get y => getFieldOfObject('y', 1);
  void set y(int value) => setFieldOfObject('y', 1, value);
}

class PropMode extends GEnumBase {
  const PropMode(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'PropMode');

  static const PropMode REPLACE = const PropMode(0);
  static const PropMode PREPEND = const PropMode(1);
  static const PropMode APPEND = const PropMode(2);
  String toString() {
    switch(index) {
      case 0: return 'PropMode.REPLACE';
      case 1: return 'PropMode.PREPEND';
      case 2: return 'PropMode.APPEND';
      default: return 'new PropMode($index)';
    }
  }
}

class PropertyState extends GEnumBase {
  const PropertyState(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'PropertyState');

  static const PropertyState NEW_VALUE = const PropertyState(0);
  static const PropertyState DELETE = const PropertyState(1);
  String toString() {
    switch(index) {
      case 0: return 'PropertyState.NEW_VALUE';
      case 1: return 'PropertyState.DELETE';
      default: return 'new PropertyState($index)';
    }
  }
}

class RGBA extends GObjectBase {
  RGBA.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'RGBA');

  RGBA copy() => _staticInfo.callMethodOnReceiver('copy', this, []);
  bool equal(RGBA p2) => _staticInfo.callMethodOnReceiver('equal', this, [p2]);
  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
  int hash() => _staticInfo.callMethodOnReceiver('hash', this, []);
  bool parse(String spec) => _staticInfo.callMethodOnReceiver('parse', this, [spec]);
  String toString() => _staticInfo.callMethodOnReceiver('to_string', this, []);
  num get red => getFieldOfObject('red', 0);
  void set red(num value) => setFieldOfObject('red', 0, value);
  num get green => getFieldOfObject('green', 1);
  void set green(num value) => setFieldOfObject('green', 1, value);
  num get blue => getFieldOfObject('blue', 2);
  void set blue(num value) => setFieldOfObject('blue', 2, value);
  num get alpha => getFieldOfObject('alpha', 3);
  void set alpha(num value) => setFieldOfObject('alpha', 3, value);
}

class Rectangle extends GObjectBase {
  Rectangle.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'Rectangle');

  List intersect(Rectangle src2) => _staticInfo.callMethodOnReceiver('intersect', this, [src2]);
  Rectangle union(Rectangle src2) => _staticInfo.callMethodOnReceiver('union', this, [src2]);
  int get x => getFieldOfObject('x', 0);
  void set x(int value) => setFieldOfObject('x', 0, value);
  int get y => getFieldOfObject('y', 1);
  void set y(int value) => setFieldOfObject('y', 1, value);
  int get width => getFieldOfObject('width', 2);
  void set width(int value) => setFieldOfObject('width', 2, value);
  int get height => getFieldOfObject('height', 3);
  void set height(int value) => setFieldOfObject('height', 3, value);
}

class Screen extends GObjectObject {
  Screen.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'Screen');

  static const String FONT_OPTIONS_PROPERTY = 'font-options';
  static const String RESOLUTION_PROPERTY = 'resolution';
  static Screen getDefault() => _staticInfo.callStatic('get_default', []);
  static int height() => _staticInfo.callStatic('height', []);
  static int heightMm() => _staticInfo.callStatic('height_mm', []);
  static int width() => _staticInfo.callStatic('width', []);
  static int widthMm() => _staticInfo.callStatic('width_mm', []);
  Window get activeWindow => _staticInfo.callMethodOnReceiver('get_active_window', this, []);
  Display get display => _staticInfo.callMethodOnReceiver('get_display', this, []);
  FontOptions get fontOptions => _staticInfo.callMethodOnReceiver('get_font_options', this, []);
  int get height_ => _staticInfo.callMethodOnReceiver('get_height', this, []);
  int get heightMm_ => _staticInfo.callMethodOnReceiver('get_height_mm', this, []);
  int getMonitorAtPoint(int x, int y) => _staticInfo.callMethodOnReceiver('get_monitor_at_point', this, [x, y]);
  int getMonitorAtWindow(Window window) => _staticInfo.callMethodOnReceiver('get_monitor_at_window', this, [window]);
  Rectangle getMonitorGeometry(int monitorNum) => _staticInfo.callMethodOnReceiver('get_monitor_geometry', this, [monitorNum]);
  int getMonitorHeightMm(int monitorNum) => _staticInfo.callMethodOnReceiver('get_monitor_height_mm', this, [monitorNum]);
  String getMonitorPlugName(int monitorNum) => _staticInfo.callMethodOnReceiver('get_monitor_plug_name', this, [monitorNum]);
  int getMonitorScaleFactor(int monitorNum) => _staticInfo.callMethodOnReceiver('get_monitor_scale_factor', this, [monitorNum]);
  int getMonitorWidthMm(int monitorNum) => _staticInfo.callMethodOnReceiver('get_monitor_width_mm', this, [monitorNum]);
  Rectangle getMonitorWorkarea(int monitorNum) => _staticInfo.callMethodOnReceiver('get_monitor_workarea', this, [monitorNum]);
  int get nMonitors => _staticInfo.callMethodOnReceiver('get_n_monitors', this, []);
  int get number => _staticInfo.callMethodOnReceiver('get_number', this, []);
  int get primaryMonitor => _staticInfo.callMethodOnReceiver('get_primary_monitor', this, []);
  num get resolution => _staticInfo.callMethodOnReceiver('get_resolution', this, []);
  Visual get rgbaVisual => _staticInfo.callMethodOnReceiver('get_rgba_visual', this, []);
  Window get rootWindow => _staticInfo.callMethodOnReceiver('get_root_window', this, []);
  bool getSetting(String name, Value value) => _staticInfo.callMethodOnReceiver('get_setting', this, [name, value]);
  Visual get systemVisual => _staticInfo.callMethodOnReceiver('get_system_visual', this, []);
  GLibList /* this will fail */ get toplevelWindows => _staticInfo.callMethodOnReceiver('get_toplevel_windows', this, []);
  int get width_ => _staticInfo.callMethodOnReceiver('get_width', this, []);
  int get widthMm_ => _staticInfo.callMethodOnReceiver('get_width_mm', this, []);
  GLibList /* this will fail */ get windowStack => _staticInfo.callMethodOnReceiver('get_window_stack', this, []);
  bool isComposited() => _staticInfo.callMethodOnReceiver('is_composited', this, []);
  GLibList /* this will fail */ listVisuals() => _staticInfo.callMethodOnReceiver('list_visuals', this, []);
  String makeDisplayName() => _staticInfo.callMethodOnReceiver('make_display_name', this, []);
  void set fontOptions(FontOptions options) => _staticInfo.callMethodOnReceiver('set_font_options', this, [options]);
  void set resolution(num dpi) => _staticInfo.callMethodOnReceiver('set_resolution', this, [dpi]);
  int _connectToCompositedChanged(bool after, void func()) => signalConnect('composited-changed', func, after);
  Stream get onCompositedChanged {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToCompositedChanged(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterCompositedChanged {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToCompositedChanged(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToMonitorsChanged(bool after, void func()) => signalConnect('monitors-changed', func, after);
  Stream get onMonitorsChanged {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToMonitorsChanged(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterMonitorsChanged {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToMonitorsChanged(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToSizeChanged(bool after, void func()) => signalConnect('size-changed', func, after);
  Stream get onSizeChanged {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToSizeChanged(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterSizeChanged {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToSizeChanged(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
}

class ScrollDirection extends GEnumBase {
  const ScrollDirection(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'ScrollDirection');

  static const ScrollDirection UP = const ScrollDirection(0);
  static const ScrollDirection DOWN = const ScrollDirection(1);
  static const ScrollDirection LEFT = const ScrollDirection(2);
  static const ScrollDirection RIGHT = const ScrollDirection(3);
  static const ScrollDirection SMOOTH = const ScrollDirection(4);
  String toString() {
    switch(index) {
      case 0: return 'ScrollDirection.UP';
      case 1: return 'ScrollDirection.DOWN';
      case 2: return 'ScrollDirection.LEFT';
      case 3: return 'ScrollDirection.RIGHT';
      case 4: return 'ScrollDirection.SMOOTH';
      default: return 'new ScrollDirection($index)';
    }
  }
}

class SettingAction extends GEnumBase {
  const SettingAction(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'SettingAction');

  static const SettingAction NEW = const SettingAction(0);
  static const SettingAction CHANGED = const SettingAction(1);
  static const SettingAction DELETED = const SettingAction(2);
  String toString() {
    switch(index) {
      case 0: return 'SettingAction.NEW';
      case 1: return 'SettingAction.CHANGED';
      case 2: return 'SettingAction.DELETED';
      default: return 'new SettingAction($index)';
    }
  }
}

class Status extends GEnumBase {
  const Status(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'Status');

  static const Status OK = const Status(0);
  static const Status ERROR = const Status(-1);
  static const Status ERROR_PARAM = const Status(-2);
  static const Status ERROR_FILE = const Status(-3);
  static const Status ERROR_MEM = const Status(-4);
  String toString() {
    switch(index) {
      case 0: return 'Status.OK';
      case -1: return 'Status.ERROR';
      case -2: return 'Status.ERROR_PARAM';
      case -3: return 'Status.ERROR_FILE';
      case -4: return 'Status.ERROR_MEM';
      default: return 'new Status($index)';
    }
  }
}

class TimeCoord extends GObjectBase {
  TimeCoord.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'TimeCoord');

  int get time => getFieldOfObject('time', 0);
  void set time(int value) => setFieldOfObject('time', 0, value);
  List<num> get axes => getFieldOfObject('axes', 1);
  void set axes(List<num> value) => setFieldOfObject('axes', 1, value);
}

class TouchpadGesturePhase extends GEnumBase {
  const TouchpadGesturePhase(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'TouchpadGesturePhase');

  static const TouchpadGesturePhase BEGIN = const TouchpadGesturePhase(0);
  static const TouchpadGesturePhase UPDATE = const TouchpadGesturePhase(1);
  static const TouchpadGesturePhase END = const TouchpadGesturePhase(2);
  static const TouchpadGesturePhase CANCEL = const TouchpadGesturePhase(3);
  String toString() {
    switch(index) {
      case 0: return 'TouchpadGesturePhase.BEGIN';
      case 1: return 'TouchpadGesturePhase.UPDATE';
      case 2: return 'TouchpadGesturePhase.END';
      case 3: return 'TouchpadGesturePhase.CANCEL';
      default: return 'new TouchpadGesturePhase($index)';
    }
  }
}

class VisibilityState extends GEnumBase {
  const VisibilityState(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'VisibilityState');

  static const VisibilityState UNOBSCURED = const VisibilityState(0);
  static const VisibilityState PARTIAL = const VisibilityState(1);
  static const VisibilityState FULLY_OBSCURED = const VisibilityState(2);
  String toString() {
    switch(index) {
      case 0: return 'VisibilityState.UNOBSCURED';
      case 1: return 'VisibilityState.PARTIAL';
      case 2: return 'VisibilityState.FULLY_OBSCURED';
      default: return 'new VisibilityState($index)';
    }
  }
}

class Visual extends GObjectObject {
  Visual.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'Visual');

  static Visual getBest() => _staticInfo.callStatic('get_best', []);
  static int getBestDepth() => _staticInfo.callStatic('get_best_depth', []);
  static VisualType getBestType() => _staticInfo.callStatic('get_best_type', []);
  static Visual getBestWithBoth(int depth, VisualType visualType) => _staticInfo.callStatic('get_best_with_both', [depth, visualType]);
  static Visual getBestWithDepth(int depth) => _staticInfo.callStatic('get_best_with_depth', [depth]);
  static Visual getBestWithType(VisualType visualType) => _staticInfo.callStatic('get_best_with_type', [visualType]);
  static Visual getSystem() => _staticInfo.callStatic('get_system', []);
  int get bitsPerRgb => _staticInfo.callMethodOnReceiver('get_bits_per_rgb', this, []);
  List getBluePixelDetails() => _staticInfo.callMethodOnReceiver('get_blue_pixel_details', this, []);
  ByteOrder get byteOrder => _staticInfo.callMethodOnReceiver('get_byte_order', this, []);
  int get colormapSize => _staticInfo.callMethodOnReceiver('get_colormap_size', this, []);
  int get depth => _staticInfo.callMethodOnReceiver('get_depth', this, []);
  List getGreenPixelDetails() => _staticInfo.callMethodOnReceiver('get_green_pixel_details', this, []);
  List getRedPixelDetails() => _staticInfo.callMethodOnReceiver('get_red_pixel_details', this, []);
  Screen get screen => _staticInfo.callMethodOnReceiver('get_screen', this, []);
  VisualType get visualType => _staticInfo.callMethodOnReceiver('get_visual_type', this, []);
}

class VisualType extends GEnumBase {
  const VisualType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'VisualType');

  static const VisualType STATIC_GRAY = const VisualType(0);
  static const VisualType GRAYSCALE = const VisualType(1);
  static const VisualType STATIC_COLOR = const VisualType(2);
  static const VisualType PSEUDO_COLOR = const VisualType(3);
  static const VisualType TRUE_COLOR = const VisualType(4);
  static const VisualType DIRECT_COLOR = const VisualType(5);
  String toString() {
    switch(index) {
      case 0: return 'VisualType.STATIC_GRAY';
      case 1: return 'VisualType.GRAYSCALE';
      case 2: return 'VisualType.STATIC_COLOR';
      case 3: return 'VisualType.PSEUDO_COLOR';
      case 4: return 'VisualType.TRUE_COLOR';
      case 5: return 'VisualType.DIRECT_COLOR';
      default: return 'new VisualType($index)';
    }
  }
}

class WMDecoration extends GEnumBase {
  const WMDecoration(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'WMDecoration');

  static const WMDecoration NULL = const WMDecoration(0);
  static const WMDecoration ALL = const WMDecoration(1);
  bool get all => (index & 1) == 1;
  static const WMDecoration BORDER = const WMDecoration(2);
  bool get border => (index & 2) == 2;
  static const WMDecoration RESIZEH = const WMDecoration(4);
  bool get resizeh => (index & 4) == 4;
  static const WMDecoration TITLE = const WMDecoration(8);
  bool get title => (index & 8) == 8;
  static const WMDecoration MENU = const WMDecoration(16);
  bool get menu => (index & 16) == 16;
  static const WMDecoration MINIMIZE = const WMDecoration(32);
  bool get minimize => (index & 32) == 32;
  static const WMDecoration MAXIMIZE = const WMDecoration(64);
  bool get maximize => (index & 64) == 64;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'WMDecoration.ALL';
      case 2: return 'WMDecoration.BORDER';
      case 4: return 'WMDecoration.RESIZEH';
      case 8: return 'WMDecoration.TITLE';
      case 16: return 'WMDecoration.MENU';
      case 32: return 'WMDecoration.MINIMIZE';
      case 64: return 'WMDecoration.MAXIMIZE';
      default: return 'new WMDecoration($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'WMDecoration.NULL';
    }
    List codes = [];
    for (var i=1; i <= 64; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  WMDecoration operator|(WMDecoration other) =>
    new WMDecoration(index | other.index);
  WMDecoration operator&(WMDecoration other) =>
    new WMDecoration(index & other.index);
}

class WMFunction extends GEnumBase {
  const WMFunction(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'WMFunction');

  static const WMFunction NULL = const WMFunction(0);
  static const WMFunction ALL = const WMFunction(1);
  bool get all => (index & 1) == 1;
  static const WMFunction RESIZE = const WMFunction(2);
  bool get resize => (index & 2) == 2;
  static const WMFunction MOVE = const WMFunction(4);
  bool get move => (index & 4) == 4;
  static const WMFunction MINIMIZE = const WMFunction(8);
  bool get minimize => (index & 8) == 8;
  static const WMFunction MAXIMIZE = const WMFunction(16);
  bool get maximize => (index & 16) == 16;
  static const WMFunction CLOSE = const WMFunction(32);
  bool get close => (index & 32) == 32;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'WMFunction.ALL';
      case 2: return 'WMFunction.RESIZE';
      case 4: return 'WMFunction.MOVE';
      case 8: return 'WMFunction.MINIMIZE';
      case 16: return 'WMFunction.MAXIMIZE';
      case 32: return 'WMFunction.CLOSE';
      default: return 'new WMFunction($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'WMFunction.NULL';
    }
    List codes = [];
    for (var i=1; i <= 32; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  WMFunction operator|(WMFunction other) =>
    new WMFunction(index | other.index);
  WMFunction operator&(WMFunction other) =>
    new WMFunction(index & other.index);
}

class Window extends GObjectObject {
  Window.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'Window');

  static const String CURSOR_PROPERTY = 'cursor';
  factory Window(Window parent, WindowAttr attributes, WindowAttributesType attributesMask) => _staticInfo.callStatic('new', [parent, attributes, attributesMask]);
  static List atPointer() => _staticInfo.callStatic('at_pointer', []);
  static List constrainSize(Geometry geometry, WindowHints flags, int width, int height) => _staticInfo.callStatic('constrain_size', [geometry, flags, width, height]);
  static void processAllUpdates() => _staticInfo.callStatic('process_all_updates', []);
  static void setDebugUpdates(bool setting) => _staticInfo.callStatic('set_debug_updates', [setting]);
  void beep() => _staticInfo.callMethodOnReceiver('beep', this, []);
  void beginMoveDrag(int button, int rootX, int rootY, int timestamp) => _staticInfo.callMethodOnReceiver('begin_move_drag', this, [button, rootX, rootY, timestamp]);
  void beginMoveDragForDevice(Device device, int button, int rootX, int rootY, int timestamp) => _staticInfo.callMethodOnReceiver('begin_move_drag_for_device', this, [device, button, rootX, rootY, timestamp]);
  void beginPaintRect(Rectangle rectangle) => _staticInfo.callMethodOnReceiver('begin_paint_rect', this, [rectangle]);
  void beginPaintRegion(Region region) => _staticInfo.callMethodOnReceiver('begin_paint_region', this, [region]);
  void beginResizeDrag(WindowEdge edge, int button, int rootX, int rootY, int timestamp) => _staticInfo.callMethodOnReceiver('begin_resize_drag', this, [edge, button, rootX, rootY, timestamp]);
  void beginResizeDragForDevice(WindowEdge edge, Device device, int button, int rootX, int rootY, int timestamp) => _staticInfo.callMethodOnReceiver('begin_resize_drag_for_device', this, [edge, device, button, rootX, rootY, timestamp]);
  void configureFinished() => _staticInfo.callMethodOnReceiver('configure_finished', this, []);
  List coordsFromParent(num parentX, num parentY) => _staticInfo.callMethodOnReceiver('coords_from_parent', this, [parentX, parentY]);
  List coordsToParent(num x, num y) => _staticInfo.callMethodOnReceiver('coords_to_parent', this, [x, y]);
  GLContext createGlContext() => _staticInfo.callMethodOnReceiver('create_gl_context', this, []);
  Surface createSimilarImageSurface(int format, int width, int height, int scale) => _staticInfo.callMethodOnReceiver('create_similar_image_surface', this, [format, width, height, scale]);
  Surface createSimilarSurface(Content content, int width, int height) => _staticInfo.callMethodOnReceiver('create_similar_surface', this, [content, width, height]);
  void deiconify() => _staticInfo.callMethodOnReceiver('deiconify', this, []);
  void destroy() => _staticInfo.callMethodOnReceiver('destroy', this, []);
  void destroyNotify() => _staticInfo.callMethodOnReceiver('destroy_notify', this, []);
  void enableSynchronizedConfigure() => _staticInfo.callMethodOnReceiver('enable_synchronized_configure', this, []);
  void endPaint() => _staticInfo.callMethodOnReceiver('end_paint', this, []);
  bool ensureNative() => _staticInfo.callMethodOnReceiver('ensure_native', this, []);
  void flush() => _staticInfo.callMethodOnReceiver('flush', this, []);
  void focus(int timestamp) => _staticInfo.callMethodOnReceiver('focus', this, [timestamp]);
  void freezeToplevelUpdatesLibgtkOnly() => _staticInfo.callMethodOnReceiver('freeze_toplevel_updates_libgtk_only', this, []);
  void freezeUpdates() => _staticInfo.callMethodOnReceiver('freeze_updates', this, []);
  void fullscreen() => _staticInfo.callMethodOnReceiver('fullscreen', this, []);
  void fullscreenOnMonitor(int monitor) => _staticInfo.callMethodOnReceiver('fullscreen_on_monitor', this, [monitor]);
  void geometryChanged() => _staticInfo.callMethodOnReceiver('geometry_changed', this, []);
  bool get acceptFocus => _staticInfo.callMethodOnReceiver('get_accept_focus', this, []);
  CairoPattern get backgroundPattern => _staticInfo.callMethodOnReceiver('get_background_pattern', this, []);
  GLibList /* this will fail */ get children => _staticInfo.callMethodOnReceiver('get_children', this, []);
  GLibList /* this will fail */ getChildrenWithUserData(dynamic userData /* this will fail */) => _staticInfo.callMethodOnReceiver('get_children_with_user_data', this, [userData]);
  Region get clipRegion => _staticInfo.callMethodOnReceiver('get_clip_region', this, []);
  bool get composited => _staticInfo.callMethodOnReceiver('get_composited', this, []);
  Cursor get cursor => _staticInfo.callMethodOnReceiver('get_cursor', this, []);
  List getDecorations() => _staticInfo.callMethodOnReceiver('get_decorations', this, []);
  Cursor getDeviceCursor(Device device) => _staticInfo.callMethodOnReceiver('get_device_cursor', this, [device]);
  EventMask getDeviceEvents(Device device) => _staticInfo.callMethodOnReceiver('get_device_events', this, [device]);
  List getDevicePosition(Device device) => _staticInfo.callMethodOnReceiver('get_device_position', this, [device]);
  List getDevicePositionDouble(Device device) => _staticInfo.callMethodOnReceiver('get_device_position_double', this, [device]);
  Display get display => _staticInfo.callMethodOnReceiver('get_display', this, []);
  List getDragProtocol() => _staticInfo.callMethodOnReceiver('get_drag_protocol', this, []);
  Window get effectiveParent => _staticInfo.callMethodOnReceiver('get_effective_parent', this, []);
  Window get effectiveToplevel => _staticInfo.callMethodOnReceiver('get_effective_toplevel', this, []);
  bool get eventCompression => _staticInfo.callMethodOnReceiver('get_event_compression', this, []);
  EventMask get events => _staticInfo.callMethodOnReceiver('get_events', this, []);
  bool get focusOnMap => _staticInfo.callMethodOnReceiver('get_focus_on_map', this, []);
  FrameClock get frameClock => _staticInfo.callMethodOnReceiver('get_frame_clock', this, []);
  Rectangle get frameExtents => _staticInfo.callMethodOnReceiver('get_frame_extents', this, []);
  FullscreenMode get fullscreenMode => _staticInfo.callMethodOnReceiver('get_fullscreen_mode', this, []);
  List getGeometry() => _staticInfo.callMethodOnReceiver('get_geometry', this, []);
  Window get group => _staticInfo.callMethodOnReceiver('get_group', this, []);
  int get height => _staticInfo.callMethodOnReceiver('get_height', this, []);
  bool get modalHint => _staticInfo.callMethodOnReceiver('get_modal_hint', this, []);
  List getOrigin() => _staticInfo.callMethodOnReceiver('get_origin', this, []);
  Window get parent => _staticInfo.callMethodOnReceiver('get_parent', this, []);
  bool get passThrough => _staticInfo.callMethodOnReceiver('get_pass_through', this, []);
  List getPointer() => _staticInfo.callMethodOnReceiver('get_pointer', this, []);
  List getPosition() => _staticInfo.callMethodOnReceiver('get_position', this, []);
  List getRootCoords(int x, int y) => _staticInfo.callMethodOnReceiver('get_root_coords', this, [x, y]);
  List getRootOrigin() => _staticInfo.callMethodOnReceiver('get_root_origin', this, []);
  int get scaleFactor => _staticInfo.callMethodOnReceiver('get_scale_factor', this, []);
  Screen get screen => _staticInfo.callMethodOnReceiver('get_screen', this, []);
  EventMask getSourceEvents(InputSource source) => _staticInfo.callMethodOnReceiver('get_source_events', this, [source]);
  WindowState get state => _staticInfo.callMethodOnReceiver('get_state', this, []);
  bool get supportMultidevice => _staticInfo.callMethodOnReceiver('get_support_multidevice', this, []);
  Window get toplevel => _staticInfo.callMethodOnReceiver('get_toplevel', this, []);
  WindowTypeHint get typeHint => _staticInfo.callMethodOnReceiver('get_type_hint', this, []);
  Region get updateArea => _staticInfo.callMethodOnReceiver('get_update_area', this, []);
  dynamic /* this will fail */ get userData => _staticInfo.callMethodOnReceiver('get_user_data', this, []);
  Region get visibleRegion => _staticInfo.callMethodOnReceiver('get_visible_region', this, []);
  Visual get visual => _staticInfo.callMethodOnReceiver('get_visual', this, []);
  int get width => _staticInfo.callMethodOnReceiver('get_width', this, []);
  WindowType get windowType => _staticInfo.callMethodOnReceiver('get_window_type', this, []);
  bool hasNative() => _staticInfo.callMethodOnReceiver('has_native', this, []);
  void hide() => _staticInfo.callMethodOnReceiver('hide', this, []);
  void iconify() => _staticInfo.callMethodOnReceiver('iconify', this, []);
  void inputShapeCombineRegion(Region shapeRegion, int offsetX, int offsetY) => _staticInfo.callMethodOnReceiver('input_shape_combine_region', this, [shapeRegion, offsetX, offsetY]);
  void invalidateMaybeRecurse(Region region, WindowChildFunc childFunc) => _staticInfo.callMethodOnReceiver('invalidate_maybe_recurse', this, [region, childFunc]);
  void invalidateRect(Rectangle rect, bool invalidateChildren) => _staticInfo.callMethodOnReceiver('invalidate_rect', this, [rect, invalidateChildren]);
  void invalidateRegion(Region region, bool invalidateChildren) => _staticInfo.callMethodOnReceiver('invalidate_region', this, [region, invalidateChildren]);
  bool isDestroyed() => _staticInfo.callMethodOnReceiver('is_destroyed', this, []);
  bool isInputOnly() => _staticInfo.callMethodOnReceiver('is_input_only', this, []);
  bool isShaped() => _staticInfo.callMethodOnReceiver('is_shaped', this, []);
  bool isViewable() => _staticInfo.callMethodOnReceiver('is_viewable', this, []);
  bool isVisible() => _staticInfo.callMethodOnReceiver('is_visible', this, []);
  void lower() => _staticInfo.callMethodOnReceiver('lower', this, []);
  void markPaintFromClip(Context cr) => _staticInfo.callMethodOnReceiver('mark_paint_from_clip', this, [cr]);
  void maximize() => _staticInfo.callMethodOnReceiver('maximize', this, []);
  void mergeChildInputShapes() => _staticInfo.callMethodOnReceiver('merge_child_input_shapes', this, []);
  void mergeChildShapes() => _staticInfo.callMethodOnReceiver('merge_child_shapes', this, []);
  void move(int x, int y) => _staticInfo.callMethodOnReceiver('move', this, [x, y]);
  void moveRegion(Region region, int dx, int dy) => _staticInfo.callMethodOnReceiver('move_region', this, [region, dx, dy]);
  void moveResize(int x, int y, int width, int height) => _staticInfo.callMethodOnReceiver('move_resize', this, [x, y, width, height]);
  GLibList /* this will fail */ peekChildren() => _staticInfo.callMethodOnReceiver('peek_children', this, []);
  void processUpdates(bool updateChildren) => _staticInfo.callMethodOnReceiver('process_updates', this, [updateChildren]);
  void raise() => _staticInfo.callMethodOnReceiver('raise', this, []);
  void registerDnd() => _staticInfo.callMethodOnReceiver('register_dnd', this, []);
  void reparent(Window newParent, int x, int y) => _staticInfo.callMethodOnReceiver('reparent', this, [newParent, x, y]);
  void resize(int width, int height) => _staticInfo.callMethodOnReceiver('resize', this, [width, height]);
  void restack(Window sibling, bool above) => _staticInfo.callMethodOnReceiver('restack', this, [sibling, above]);
  void scroll(int dx, int dy) => _staticInfo.callMethodOnReceiver('scroll', this, [dx, dy]);
  void set acceptFocus(bool acceptFocus) => _staticInfo.callMethodOnReceiver('set_accept_focus', this, [acceptFocus]);
  void setBackground(Color color) => _staticInfo.callMethodOnReceiver('set_background', this, [color]);
  void set backgroundPattern(CairoPattern pattern) => _staticInfo.callMethodOnReceiver('set_background_pattern', this, [pattern]);
  void setBackgroundRgba(RGBA rgba) => _staticInfo.callMethodOnReceiver('set_background_rgba', this, [rgba]);
  void setChildInputShapes() => _staticInfo.callMethodOnReceiver('set_child_input_shapes', this, []);
  void setChildShapes() => _staticInfo.callMethodOnReceiver('set_child_shapes', this, []);
  void set composited(bool composited) => _staticInfo.callMethodOnReceiver('set_composited', this, [composited]);
  void set cursor(Cursor cursor) => _staticInfo.callMethodOnReceiver('set_cursor', this, [cursor]);
  void setDecorations(WMDecoration decorations) => _staticInfo.callMethodOnReceiver('set_decorations', this, [decorations]);
  void setDeviceCursor(Device device, Cursor cursor) => _staticInfo.callMethodOnReceiver('set_device_cursor', this, [device, cursor]);
  void setDeviceEvents(Device device, EventMask eventMask) => _staticInfo.callMethodOnReceiver('set_device_events', this, [device, eventMask]);
  void set eventCompression(bool eventCompression) => _staticInfo.callMethodOnReceiver('set_event_compression', this, [eventCompression]);
  void set events(EventMask eventMask) => _staticInfo.callMethodOnReceiver('set_events', this, [eventMask]);
  void set focusOnMap(bool focusOnMap) => _staticInfo.callMethodOnReceiver('set_focus_on_map', this, [focusOnMap]);
  void set fullscreenMode(FullscreenMode mode) => _staticInfo.callMethodOnReceiver('set_fullscreen_mode', this, [mode]);
  void setFunctions(WMFunction functions) => _staticInfo.callMethodOnReceiver('set_functions', this, [functions]);
  void setGeometryHints(Geometry geometry, WindowHints geomMask) => _staticInfo.callMethodOnReceiver('set_geometry_hints', this, [geometry, geomMask]);
  void set group(Window leader) => _staticInfo.callMethodOnReceiver('set_group', this, [leader]);
  void setIconList(GLibList pixbufs /* this will fail */) => _staticInfo.callMethodOnReceiver('set_icon_list', this, [pixbufs]);
  void setIconName(String name) => _staticInfo.callMethodOnReceiver('set_icon_name', this, [name]);
  void setKeepAbove(bool setting) => _staticInfo.callMethodOnReceiver('set_keep_above', this, [setting]);
  void setKeepBelow(bool setting) => _staticInfo.callMethodOnReceiver('set_keep_below', this, [setting]);
  void set modalHint(bool modal) => _staticInfo.callMethodOnReceiver('set_modal_hint', this, [modal]);
  void setOpacity(num opacity) => _staticInfo.callMethodOnReceiver('set_opacity', this, [opacity]);
  void setOpaqueRegion(Region region) => _staticInfo.callMethodOnReceiver('set_opaque_region', this, [region]);
  void setOverrideRedirect(bool overrideRedirect) => _staticInfo.callMethodOnReceiver('set_override_redirect', this, [overrideRedirect]);
  void set passThrough(bool passThrough) => _staticInfo.callMethodOnReceiver('set_pass_through', this, [passThrough]);
  void setRole(String role) => _staticInfo.callMethodOnReceiver('set_role', this, [role]);
  void setShadowWidth(int left, int right, int top, int bottom) => _staticInfo.callMethodOnReceiver('set_shadow_width', this, [left, right, top, bottom]);
  void setSkipPagerHint(bool skipsPager) => _staticInfo.callMethodOnReceiver('set_skip_pager_hint', this, [skipsPager]);
  void setSkipTaskbarHint(bool skipsTaskbar) => _staticInfo.callMethodOnReceiver('set_skip_taskbar_hint', this, [skipsTaskbar]);
  void setSourceEvents(InputSource source, EventMask eventMask) => _staticInfo.callMethodOnReceiver('set_source_events', this, [source, eventMask]);
  void setStartupId(String startupId) => _staticInfo.callMethodOnReceiver('set_startup_id', this, [startupId]);
  bool setStaticGravities(bool useStatic) => _staticInfo.callMethodOnReceiver('set_static_gravities', this, [useStatic]);
  void set supportMultidevice(bool supportMultidevice) => _staticInfo.callMethodOnReceiver('set_support_multidevice', this, [supportMultidevice]);
  void setTitle(String title) => _staticInfo.callMethodOnReceiver('set_title', this, [title]);
  void setTransientFor(Window parent) => _staticInfo.callMethodOnReceiver('set_transient_for', this, [parent]);
  void set typeHint(WindowTypeHint hint) => _staticInfo.callMethodOnReceiver('set_type_hint', this, [hint]);
  void setUrgencyHint(bool urgent) => _staticInfo.callMethodOnReceiver('set_urgency_hint', this, [urgent]);
  void set userData(GObjectObject userData) => _staticInfo.callMethodOnReceiver('set_user_data', this, [userData]);
  void shapeCombineRegion(Region shapeRegion, int offsetX, int offsetY) => _staticInfo.callMethodOnReceiver('shape_combine_region', this, [shapeRegion, offsetX, offsetY]);
  void show() => _staticInfo.callMethodOnReceiver('show', this, []);
  void showUnraised() => _staticInfo.callMethodOnReceiver('show_unraised', this, []);
  bool showWindowMenu(Event event) => _staticInfo.callMethodOnReceiver('show_window_menu', this, [event]);
  void stick() => _staticInfo.callMethodOnReceiver('stick', this, []);
  void thawToplevelUpdatesLibgtkOnly() => _staticInfo.callMethodOnReceiver('thaw_toplevel_updates_libgtk_only', this, []);
  void thawUpdates() => _staticInfo.callMethodOnReceiver('thaw_updates', this, []);
  void unfullscreen() => _staticInfo.callMethodOnReceiver('unfullscreen', this, []);
  void unmaximize() => _staticInfo.callMethodOnReceiver('unmaximize', this, []);
  void unstick() => _staticInfo.callMethodOnReceiver('unstick', this, []);
  void withdraw() => _staticInfo.callMethodOnReceiver('withdraw', this, []);
  int connectToCreateSurface(bool after, Surface func(int width, int height)) => signalConnect('create-surface', func, after);
  int connectToFromEmbedder(bool after, List func(num embedderX, num embedderY)) => signalConnect('from-embedder', func, after);
  int connectToPickEmbeddedChild(bool after, Window func(num x, num y)) => signalConnect('pick-embedded-child', func, after);
  int connectToToEmbedder(bool after, List func(num offscreenX, num offscreenY)) => signalConnect('to-embedder', func, after);
}

class WindowAttr extends GObjectBase {
  WindowAttr.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'WindowAttr');

  String get title => getFieldOfObject('title', 0);
  void set title(String value) => setFieldOfObject('title', 0, value);
  int get eventMask => getFieldOfObject('event_mask', 1);
  void set eventMask(int value) => setFieldOfObject('event_mask', 1, value);
  int get x => getFieldOfObject('x', 2);
  void set x(int value) => setFieldOfObject('x', 2, value);
  int get y => getFieldOfObject('y', 3);
  void set y(int value) => setFieldOfObject('y', 3, value);
  int get width => getFieldOfObject('width', 4);
  void set width(int value) => setFieldOfObject('width', 4, value);
  int get height => getFieldOfObject('height', 5);
  void set height(int value) => setFieldOfObject('height', 5, value);
  WindowWindowClass get wclass => getFieldOfObject('wclass', 6);
  void set wclass(WindowWindowClass value) => setFieldOfObject('wclass', 6, value);
  Visual get visual => getFieldOfObject('visual', 7);
  void set visual(Visual value) => setFieldOfObject('visual', 7, value);
  WindowType get windowType => getFieldOfObject('window_type', 8);
  void set windowType(WindowType value) => setFieldOfObject('window_type', 8, value);
  Cursor get cursor => getFieldOfObject('cursor', 9);
  void set cursor(Cursor value) => setFieldOfObject('cursor', 9, value);
  String get wmclassName => getFieldOfObject('wmclass_name', 10);
  void set wmclassName(String value) => setFieldOfObject('wmclass_name', 10, value);
  String get wmclassClass => getFieldOfObject('wmclass_class', 11);
  void set wmclassClass(String value) => setFieldOfObject('wmclass_class', 11, value);
  bool get overrideRedirect => getFieldOfObject('override_redirect', 12);
  void set overrideRedirect(bool value) => setFieldOfObject('override_redirect', 12, value);
  WindowTypeHint get typeHint => getFieldOfObject('type_hint', 13);
  void set typeHint(WindowTypeHint value) => setFieldOfObject('type_hint', 13, value);
}

class WindowAttributesType extends GEnumBase {
  const WindowAttributesType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'WindowAttributesType');

  static const WindowAttributesType NULL = const WindowAttributesType(0);
  static const WindowAttributesType TITLE = const WindowAttributesType(2);
  bool get title => (index & 2) == 2;
  static const WindowAttributesType X = const WindowAttributesType(4);
  bool get x => (index & 4) == 4;
  static const WindowAttributesType Y = const WindowAttributesType(8);
  bool get y => (index & 8) == 8;
  static const WindowAttributesType CURSOR = const WindowAttributesType(16);
  bool get cursor => (index & 16) == 16;
  static const WindowAttributesType VISUAL = const WindowAttributesType(32);
  bool get visual => (index & 32) == 32;
  static const WindowAttributesType WMCLASS = const WindowAttributesType(64);
  bool get wmclass => (index & 64) == 64;
  static const WindowAttributesType NOREDIR = const WindowAttributesType(128);
  bool get noredir => (index & 128) == 128;
  static const WindowAttributesType TYPE_HINT = const WindowAttributesType(256);
  bool get typeHint => (index & 256) == 256;
  static _valueToString(int value) {
    switch(value) {
      case 2: return 'WindowAttributesType.TITLE';
      case 4: return 'WindowAttributesType.X';
      case 8: return 'WindowAttributesType.Y';
      case 16: return 'WindowAttributesType.CURSOR';
      case 32: return 'WindowAttributesType.VISUAL';
      case 64: return 'WindowAttributesType.WMCLASS';
      case 128: return 'WindowAttributesType.NOREDIR';
      default: return 'new WindowAttributesType($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'WindowAttributesType.NULL';
    }
    List codes = [];
    for (var i=1; i <= 256; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  WindowAttributesType operator|(WindowAttributesType other) =>
    new WindowAttributesType(index | other.index);
  WindowAttributesType operator&(WindowAttributesType other) =>
    new WindowAttributesType(index & other.index);
}

typedef bool WindowChildFunc(Window window);
class WindowEdge extends GEnumBase {
  const WindowEdge(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'WindowEdge');

  static const WindowEdge NORTH_WEST = const WindowEdge(0);
  static const WindowEdge NORTH = const WindowEdge(1);
  static const WindowEdge NORTH_EAST = const WindowEdge(2);
  static const WindowEdge WEST = const WindowEdge(3);
  static const WindowEdge EAST = const WindowEdge(4);
  static const WindowEdge SOUTH_WEST = const WindowEdge(5);
  static const WindowEdge SOUTH = const WindowEdge(6);
  static const WindowEdge SOUTH_EAST = const WindowEdge(7);
  String toString() {
    switch(index) {
      case 0: return 'WindowEdge.NORTH_WEST';
      case 1: return 'WindowEdge.NORTH';
      case 2: return 'WindowEdge.NORTH_EAST';
      case 3: return 'WindowEdge.WEST';
      case 4: return 'WindowEdge.EAST';
      case 5: return 'WindowEdge.SOUTH_WEST';
      case 6: return 'WindowEdge.SOUTH';
      case 7: return 'WindowEdge.SOUTH_EAST';
      default: return 'new WindowEdge($index)';
    }
  }
}

class WindowHints extends GEnumBase {
  const WindowHints(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'WindowHints');

  static const WindowHints NULL = const WindowHints(0);
  static const WindowHints POS = const WindowHints(1);
  bool get pos => (index & 1) == 1;
  static const WindowHints MIN_SIZE = const WindowHints(2);
  bool get minSize => (index & 2) == 2;
  static const WindowHints MAX_SIZE = const WindowHints(4);
  bool get maxSize => (index & 4) == 4;
  static const WindowHints BASE_SIZE = const WindowHints(8);
  bool get baseSize => (index & 8) == 8;
  static const WindowHints ASPECT = const WindowHints(16);
  bool get aspect => (index & 16) == 16;
  static const WindowHints RESIZE_INC = const WindowHints(32);
  bool get resizeInc => (index & 32) == 32;
  static const WindowHints WIN_GRAVITY = const WindowHints(64);
  bool get winGravity => (index & 64) == 64;
  static const WindowHints USER_POS = const WindowHints(128);
  bool get userPos => (index & 128) == 128;
  static const WindowHints USER_SIZE = const WindowHints(256);
  bool get userSize => (index & 256) == 256;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'WindowHints.POS';
      case 2: return 'WindowHints.MIN_SIZE';
      case 4: return 'WindowHints.MAX_SIZE';
      case 8: return 'WindowHints.BASE_SIZE';
      case 16: return 'WindowHints.ASPECT';
      case 32: return 'WindowHints.RESIZE_INC';
      case 64: return 'WindowHints.WIN_GRAVITY';
      case 128: return 'WindowHints.USER_POS';
      default: return 'new WindowHints($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'WindowHints.NULL';
    }
    List codes = [];
    for (var i=1; i <= 256; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  WindowHints operator|(WindowHints other) =>
    new WindowHints(index | other.index);
  WindowHints operator&(WindowHints other) =>
    new WindowHints(index & other.index);
}

typedef void WindowInvalidateHandlerFunc(Window window, Region region);
class WindowRedirect extends GObjectBase {
  WindowRedirect.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'WindowRedirect');

}

class WindowState extends GEnumBase {
  const WindowState(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'WindowState');

  static const WindowState NULL = const WindowState(0);
  static const WindowState WITHDRAWN = const WindowState(1);
  bool get withdrawn => (index & 1) == 1;
  static const WindowState ICONIFIED = const WindowState(2);
  bool get iconified => (index & 2) == 2;
  static const WindowState MAXIMIZED = const WindowState(4);
  bool get maximized => (index & 4) == 4;
  static const WindowState STICKY = const WindowState(8);
  bool get sticky => (index & 8) == 8;
  static const WindowState FULLSCREEN = const WindowState(16);
  bool get fullscreen => (index & 16) == 16;
  static const WindowState ABOVE = const WindowState(32);
  bool get above => (index & 32) == 32;
  static const WindowState BELOW = const WindowState(64);
  bool get below => (index & 64) == 64;
  static const WindowState FOCUSED = const WindowState(128);
  bool get focused => (index & 128) == 128;
  static const WindowState TILED = const WindowState(256);
  bool get tiled => (index & 256) == 256;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'WindowState.WITHDRAWN';
      case 2: return 'WindowState.ICONIFIED';
      case 4: return 'WindowState.MAXIMIZED';
      case 8: return 'WindowState.STICKY';
      case 16: return 'WindowState.FULLSCREEN';
      case 32: return 'WindowState.ABOVE';
      case 64: return 'WindowState.BELOW';
      case 128: return 'WindowState.FOCUSED';
      default: return 'new WindowState($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'WindowState.NULL';
    }
    List codes = [];
    for (var i=1; i <= 256; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  WindowState operator|(WindowState other) =>
    new WindowState(index | other.index);
  WindowState operator&(WindowState other) =>
    new WindowState(index & other.index);
}

class WindowType extends GEnumBase {
  const WindowType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'WindowType');

  static const WindowType ROOT = const WindowType(0);
  static const WindowType TOPLEVEL = const WindowType(1);
  static const WindowType CHILD = const WindowType(2);
  static const WindowType TEMP = const WindowType(3);
  static const WindowType FOREIGN = const WindowType(4);
  static const WindowType OFFSCREEN = const WindowType(5);
  static const WindowType SUBSURFACE = const WindowType(6);
  String toString() {
    switch(index) {
      case 0: return 'WindowType.ROOT';
      case 1: return 'WindowType.TOPLEVEL';
      case 2: return 'WindowType.CHILD';
      case 3: return 'WindowType.TEMP';
      case 4: return 'WindowType.FOREIGN';
      case 5: return 'WindowType.OFFSCREEN';
      case 6: return 'WindowType.SUBSURFACE';
      default: return 'new WindowType($index)';
    }
  }
}

class WindowTypeHint extends GEnumBase {
  const WindowTypeHint(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'WindowTypeHint');

  static const WindowTypeHint NORMAL = const WindowTypeHint(0);
  static const WindowTypeHint DIALOG = const WindowTypeHint(1);
  static const WindowTypeHint MENU = const WindowTypeHint(2);
  static const WindowTypeHint TOOLBAR = const WindowTypeHint(3);
  static const WindowTypeHint SPLASHSCREEN = const WindowTypeHint(4);
  static const WindowTypeHint UTILITY = const WindowTypeHint(5);
  static const WindowTypeHint DOCK = const WindowTypeHint(6);
  static const WindowTypeHint DESKTOP = const WindowTypeHint(7);
  static const WindowTypeHint DROPDOWN_MENU = const WindowTypeHint(8);
  static const WindowTypeHint POPUP_MENU = const WindowTypeHint(9);
  static const WindowTypeHint TOOLTIP = const WindowTypeHint(10);
  static const WindowTypeHint NOTIFICATION = const WindowTypeHint(11);
  static const WindowTypeHint COMBO = const WindowTypeHint(12);
  static const WindowTypeHint DND = const WindowTypeHint(13);
  String toString() {
    switch(index) {
      case 0: return 'WindowTypeHint.NORMAL';
      case 1: return 'WindowTypeHint.DIALOG';
      case 2: return 'WindowTypeHint.MENU';
      case 3: return 'WindowTypeHint.TOOLBAR';
      case 4: return 'WindowTypeHint.SPLASHSCREEN';
      case 5: return 'WindowTypeHint.UTILITY';
      case 6: return 'WindowTypeHint.DOCK';
      case 7: return 'WindowTypeHint.DESKTOP';
      case 8: return 'WindowTypeHint.DROPDOWN_MENU';
      case 9: return 'WindowTypeHint.POPUP_MENU';
      case 10: return 'WindowTypeHint.TOOLTIP';
      case 11: return 'WindowTypeHint.NOTIFICATION';
      case 12: return 'WindowTypeHint.COMBO';
      case 13: return 'WindowTypeHint.DND';
      default: return 'new WindowTypeHint($index)';
    }
  }
}

class WindowWindowClass extends GEnumBase {
  const WindowWindowClass(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gdk', 'WindowWindowClass');

  static const WindowWindowClass INPUT_OUTPUT = const WindowWindowClass(0);
  static const WindowWindowClass INPUT_ONLY = const WindowWindowClass(1);
  String toString() {
    switch(index) {
      case 0: return 'WindowWindowClass.INPUT_OUTPUT';
      case 1: return 'WindowWindowClass.INPUT_ONLY';
      default: return 'new WindowWindowClass($index)';
    }
  }
}

void addOptionEntriesLibgtkOnly(OptionGroup group) => callStaticGlobal('Gdk', 'add_option_entries_libgtk_only', [group]);

Atom atomIntern(String atomName, bool onlyIfExists) => callStaticGlobal('Gdk', 'atom_intern', [atomName, onlyIfExists]);

Atom atomInternStaticString(String atomName) => callStaticGlobal('Gdk', 'atom_intern_static_string', [atomName]);

void beep() => callStaticGlobal('Gdk', 'beep', []);

Context cairoCreate(Window window) => callStaticGlobal('Gdk', 'cairo_create', [window]);

void cairoDrawFromGl(Context cr, Window window, int source, int sourceType, int bufferScale, int x, int y, int width, int height) => callStaticGlobal('Gdk', 'cairo_draw_from_gl', [cr, window, source, sourceType, bufferScale, x, y, width, height]);

List cairoGetClipRectangle(Context cr) => callStaticGlobal('Gdk', 'cairo_get_clip_rectangle', [cr]);

void cairoRectangle(Context cr, Rectangle rectangle) => callStaticGlobal('Gdk', 'cairo_rectangle', [cr, rectangle]);

void cairoRegion(Context cr, Region region) => callStaticGlobal('Gdk', 'cairo_region', [cr, region]);

Region cairoRegionCreateFromSurface(Surface surface) => callStaticGlobal('Gdk', 'cairo_region_create_from_surface', [surface]);

void cairoSetSourceColor(Context cr, Color color) => callStaticGlobal('Gdk', 'cairo_set_source_color', [cr, color]);

void cairoSetSourcePixbuf(Context cr, Pixbuf pixbuf, num pixbufX, num pixbufY) => callStaticGlobal('Gdk', 'cairo_set_source_pixbuf', [cr, pixbuf, pixbufX, pixbufY]);

void cairoSetSourceRgba(Context cr, RGBA rgba) => callStaticGlobal('Gdk', 'cairo_set_source_rgba', [cr, rgba]);

void cairoSetSourceWindow(Context cr, Window window, num x, num y) => callStaticGlobal('Gdk', 'cairo_set_source_window', [cr, window, x, y]);

Surface cairoSurfaceCreateFromPixbuf(Pixbuf pixbuf, int scale, Window forWindow) => callStaticGlobal('Gdk', 'cairo_surface_create_from_pixbuf', [pixbuf, scale, forWindow]);

List colorParse(String spec) => callStaticGlobal('Gdk', 'color_parse', [spec]);

void disableMultidevice() => callStaticGlobal('Gdk', 'disable_multidevice', []);

void dragAbort(DragContext context, int time_) => callStaticGlobal('Gdk', 'drag_abort', [context, time_]);

DragContext dragBegin(Window window, GLibList targets /* this will fail */) => callStaticGlobal('Gdk', 'drag_begin', [window, targets]);

DragContext dragBeginForDevice(Window window, Device device, GLibList targets /* this will fail */) => callStaticGlobal('Gdk', 'drag_begin_for_device', [window, device, targets]);

void dragDrop(DragContext context, int time_) => callStaticGlobal('Gdk', 'drag_drop', [context, time_]);

bool dragDropSucceeded(DragContext context) => callStaticGlobal('Gdk', 'drag_drop_succeeded', [context]);

List dragFindWindowForScreen(DragContext context, Window dragWindow, Screen screen, int xRoot, int yRoot) => callStaticGlobal('Gdk', 'drag_find_window_for_screen', [context, dragWindow, screen, xRoot, yRoot]);

Atom dragGetSelection(DragContext context) => callStaticGlobal('Gdk', 'drag_get_selection', [context]);

bool dragMotion(DragContext context, Window destWindow, DragProtocol protocol, int xRoot, int yRoot, DragAction suggestedAction, DragAction possibleActions, int time_) => callStaticGlobal('Gdk', 'drag_motion', [context, destWindow, protocol, xRoot, yRoot, suggestedAction, possibleActions, time_]);

void dragStatus(DragContext context, DragAction action, int time_) => callStaticGlobal('Gdk', 'drag_status', [context, action, time_]);

void dropFinish(DragContext context, bool success, int time_) => callStaticGlobal('Gdk', 'drop_finish', [context, success, time_]);

void dropReply(DragContext context, bool accepted, int time_) => callStaticGlobal('Gdk', 'drop_reply', [context, accepted, time_]);

int errorTrapPop() => callStaticGlobal('Gdk', 'error_trap_pop', []);

void errorTrapPopIgnored() => callStaticGlobal('Gdk', 'error_trap_pop_ignored', []);

void errorTrapPush() => callStaticGlobal('Gdk', 'error_trap_push', []);

Event eventGet() => callStaticGlobal('Gdk', 'event_get', []);

void eventHandlerSet(EventFunc func) => callStaticGlobal('Gdk', 'event_handler_set', [func]);

Event eventPeek() => callStaticGlobal('Gdk', 'event_peek', []);

void eventRequestMotions(EventMotion event) => callStaticGlobal('Gdk', 'event_request_motions', [event]);

List eventsGetAngle(Event event1, Event event2) => callStaticGlobal('Gdk', 'events_get_angle', [event1, event2]);

List eventsGetCenter(Event event1, Event event2) => callStaticGlobal('Gdk', 'events_get_center', [event1, event2]);

List eventsGetDistance(Event event1, Event event2) => callStaticGlobal('Gdk', 'events_get_distance', [event1, event2]);

bool eventsPending() => callStaticGlobal('Gdk', 'events_pending', []);

void flush() => callStaticGlobal('Gdk', 'flush', []);

Window getDefaultRootWindow() => callStaticGlobal('Gdk', 'get_default_root_window', []);

String getDisplay() => callStaticGlobal('Gdk', 'get_display', []);

String getDisplayArgName() => callStaticGlobal('Gdk', 'get_display_arg_name', []);

String getProgramClass() => callStaticGlobal('Gdk', 'get_program_class', []);

bool getShowEvents() => callStaticGlobal('Gdk', 'get_show_events', []);

int glErrorQuark() => callStaticGlobal('Gdk', 'gl_error_quark', []);

List init(List<String> argv) => callStaticGlobal('Gdk', 'init', [argv]);

List initCheck(List<String> argv) => callStaticGlobal('Gdk', 'init_check', [argv]);

GrabStatus keyboardGrab(Window window, bool ownerEvents, int time_) => callStaticGlobal('Gdk', 'keyboard_grab', [window, ownerEvents, time_]);

void keyboardUngrab(int time_) => callStaticGlobal('Gdk', 'keyboard_ungrab', [time_]);

List keyvalConvertCase(int symbol) => callStaticGlobal('Gdk', 'keyval_convert_case', [symbol]);

int keyvalFromName(String keyvalName) => callStaticGlobal('Gdk', 'keyval_from_name', [keyvalName]);

bool keyvalIsLower(int keyval) => callStaticGlobal('Gdk', 'keyval_is_lower', [keyval]);

bool keyvalIsUpper(int keyval) => callStaticGlobal('Gdk', 'keyval_is_upper', [keyval]);

String keyvalName(int keyval) => callStaticGlobal('Gdk', 'keyval_name', [keyval]);

int keyvalToLower(int keyval) => callStaticGlobal('Gdk', 'keyval_to_lower', [keyval]);

int keyvalToUnicode(int keyval) => callStaticGlobal('Gdk', 'keyval_to_unicode', [keyval]);

int keyvalToUpper(int keyval) => callStaticGlobal('Gdk', 'keyval_to_upper', [keyval]);

GLibList /* this will fail */ listVisuals() => callStaticGlobal('Gdk', 'list_visuals', []);

void notifyStartupComplete() => callStaticGlobal('Gdk', 'notify_startup_complete', []);

void notifyStartupCompleteWithId(String startupId) => callStaticGlobal('Gdk', 'notify_startup_complete_with_id', [startupId]);

Window offscreenWindowGetEmbedder(Window window) => callStaticGlobal('Gdk', 'offscreen_window_get_embedder', [window]);

Surface offscreenWindowGetSurface(Window window) => callStaticGlobal('Gdk', 'offscreen_window_get_surface', [window]);

void offscreenWindowSetEmbedder(Window window, Window embedder) => callStaticGlobal('Gdk', 'offscreen_window_set_embedder', [window, embedder]);

pango.Context pangoContextGet() => callStaticGlobal('Gdk', 'pango_context_get', []);

pango.Context pangoContextGetForScreen(Screen screen) => callStaticGlobal('Gdk', 'pango_context_get_for_screen', [screen]);

List parseArgs(List<String> argv) => callStaticGlobal('Gdk', 'parse_args', [argv]);

Pixbuf pixbufGetFromSurface(Surface surface, int srcX, int srcY, int width, int height) => callStaticGlobal('Gdk', 'pixbuf_get_from_surface', [surface, srcX, srcY, width, height]);

Pixbuf pixbufGetFromWindow(Window window, int srcX, int srcY, int width, int height) => callStaticGlobal('Gdk', 'pixbuf_get_from_window', [window, srcX, srcY, width, height]);

GrabStatus pointerGrab(Window window, bool ownerEvents, EventMask eventMask, Window confineTo, Cursor cursor, int time_) => callStaticGlobal('Gdk', 'pointer_grab', [window, ownerEvents, eventMask, confineTo, cursor, time_]);

bool pointerIsGrabbed() => callStaticGlobal('Gdk', 'pointer_is_grabbed', []);

void pointerUngrab(int time_) => callStaticGlobal('Gdk', 'pointer_ungrab', [time_]);

void preParseLibgtkOnly() => callStaticGlobal('Gdk', 'pre_parse_libgtk_only', []);

void propertyDelete(Window window, Atom property) => callStaticGlobal('Gdk', 'property_delete', [window, property]);

List propertyGet(Window window, Atom property, Atom type, int offset, int length, int pdelete) => callStaticGlobal('Gdk', 'property_get', [window, property, type, offset, length, pdelete]);

List queryDepths() => callStaticGlobal('Gdk', 'query_depths', []);

List queryVisualTypes() => callStaticGlobal('Gdk', 'query_visual_types', []);

void selectionConvert(Window requestor, Atom selection, Atom target, int time_) => callStaticGlobal('Gdk', 'selection_convert', [requestor, selection, target, time_]);

Window selectionOwnerGet(Atom selection) => callStaticGlobal('Gdk', 'selection_owner_get', [selection]);

Window selectionOwnerGetForDisplay(Display display, Atom selection) => callStaticGlobal('Gdk', 'selection_owner_get_for_display', [display, selection]);

bool selectionOwnerSet(Window owner, Atom selection, int time_, bool sendEvent) => callStaticGlobal('Gdk', 'selection_owner_set', [owner, selection, time_, sendEvent]);

bool selectionOwnerSetForDisplay(Display display, Window owner, Atom selection, int time_, bool sendEvent) => callStaticGlobal('Gdk', 'selection_owner_set_for_display', [display, owner, selection, time_, sendEvent]);

void selectionSendNotify(Window requestor, Atom selection, Atom target, Atom property, int time_) => callStaticGlobal('Gdk', 'selection_send_notify', [requestor, selection, target, property, time_]);

void selectionSendNotifyForDisplay(Display display, Window requestor, Atom selection, Atom target, Atom property, int time_) => callStaticGlobal('Gdk', 'selection_send_notify_for_display', [display, requestor, selection, target, property, time_]);

void setAllowedBackends(String backends) => callStaticGlobal('Gdk', 'set_allowed_backends', [backends]);

void setDoubleClickTime(int msec) => callStaticGlobal('Gdk', 'set_double_click_time', [msec]);

void setProgramClass(String programClass) => callStaticGlobal('Gdk', 'set_program_class', [programClass]);

void setShowEvents(bool showEvents) => callStaticGlobal('Gdk', 'set_show_events', [showEvents]);

bool settingGet(String name, Value value) => callStaticGlobal('Gdk', 'setting_get', [name, value]);

void synthesizeWindowState(Window window, WindowState unsetFlags, WindowState setFlags) => callStaticGlobal('Gdk', 'synthesize_window_state', [window, unsetFlags, setFlags]);

void testRenderSync(Window window) => callStaticGlobal('Gdk', 'test_render_sync', [window]);

bool testSimulateButton(Window window, int x, int y, int button, ModifierType modifiers, EventType buttonPressrelease) => callStaticGlobal('Gdk', 'test_simulate_button', [window, x, y, button, modifiers, buttonPressrelease]);

bool testSimulateKey(Window window, int x, int y, int keyval, ModifierType modifiers, EventType keyPressrelease) => callStaticGlobal('Gdk', 'test_simulate_key', [window, x, y, keyval, modifiers, keyPressrelease]);

List textPropertyToUtf8ListForDisplay(Display display, Atom encoding, int format, List<int> text) => callStaticGlobal('Gdk', 'text_property_to_utf8_list_for_display', [display, encoding, format, text]);

int threadsAddIdle(int priority, SourceFunc function) => callStaticGlobal('Gdk', 'threads_add_idle', [priority, function]);

int threadsAddTimeout(int priority, int interval, SourceFunc function) => callStaticGlobal('Gdk', 'threads_add_timeout', [priority, interval, function]);

int threadsAddTimeoutSeconds(int priority, int interval, SourceFunc function) => callStaticGlobal('Gdk', 'threads_add_timeout_seconds', [priority, interval, function]);

void threadsEnter() => callStaticGlobal('Gdk', 'threads_enter', []);

void threadsInit() => callStaticGlobal('Gdk', 'threads_init', []);

void threadsLeave() => callStaticGlobal('Gdk', 'threads_leave', []);

int unicodeToKeyval(int wc) => callStaticGlobal('Gdk', 'unicode_to_keyval', [wc]);

String utf8ToStringTarget(String str) => callStaticGlobal('Gdk', 'utf8_to_string_target', [str]);

bool _initLibraryStarted = false;

void initLibrary() {
  if (_initLibraryStarted) return;
  _initLibraryStarted = true;
  cairo.initLibrary();
  pango.initLibrary();
  gio.initLibrary();
  gdkpixbuf.initLibrary();
  registerInterceptorTypeForNamedType("Gdk", "AppLaunchContext",AppLaunchContext);
  registerInterceptorTypeForNamedType("Gdk", "Atom",Atom);
  registerInterceptorTypeForNamedType("Gdk", "AxisUse",AxisUse);
  registerInterceptorTypeForNamedType("Gdk", "ByteOrder",ByteOrder);
  registerInterceptorTypeForNamedType("Gdk", "Color",Color);
  registerInterceptorTypeForNamedType("Gdk", "CrossingMode",CrossingMode);
  registerInterceptorTypeForNamedType("Gdk", "Cursor",Cursor);
  registerInterceptorTypeForNamedType("Gdk", "CursorType",CursorType);
  registerInterceptorTypeForNamedType("Gdk", "Device",Device);
  registerInterceptorTypeForNamedType("Gdk", "DeviceManager",DeviceManager);
  registerInterceptorTypeForNamedType("Gdk", "DeviceType",DeviceType);
  registerInterceptorTypeForNamedType("Gdk", "Display",Display);
  registerInterceptorTypeForNamedType("Gdk", "DisplayManager",DisplayManager);
  registerInterceptorTypeForNamedType("Gdk", "DragAction",DragAction);
  registerInterceptorTypeForNamedType("Gdk", "DragContext",DragContext);
  registerInterceptorTypeForNamedType("Gdk", "DragProtocol",DragProtocol);
  registerInterceptorTypeForNamedType("Gdk", "Event",Event);
  registerInterceptorTypeForNamedType("Gdk", "EventAny",EventAny);
  registerInterceptorTypeForNamedType("Gdk", "EventButton",EventButton);
  registerInterceptorTypeForNamedType("Gdk", "EventConfigure",EventConfigure);
  registerInterceptorTypeForNamedType("Gdk", "EventCrossing",EventCrossing);
  registerInterceptorTypeForNamedType("Gdk", "EventDND",EventDND);
  registerInterceptorTypeForNamedType("Gdk", "EventExpose",EventExpose);
  registerInterceptorTypeForNamedType("Gdk", "EventFocus",EventFocus);
  registerInterceptorTypeForNamedType("Gdk", "EventGrabBroken",EventGrabBroken);
  registerInterceptorTypeForNamedType("Gdk", "EventKey",EventKey);
  registerInterceptorTypeForNamedType("Gdk", "EventMask",EventMask);
  registerInterceptorTypeForNamedType("Gdk", "EventMotion",EventMotion);
  registerInterceptorTypeForNamedType("Gdk", "EventOwnerChange",EventOwnerChange);
  registerInterceptorTypeForNamedType("Gdk", "EventProperty",EventProperty);
  registerInterceptorTypeForNamedType("Gdk", "EventProximity",EventProximity);
  registerInterceptorTypeForNamedType("Gdk", "EventScroll",EventScroll);
  registerInterceptorTypeForNamedType("Gdk", "EventSelection",EventSelection);
  registerInterceptorTypeForNamedType("Gdk", "EventSequence",EventSequence);
  registerInterceptorTypeForNamedType("Gdk", "EventSetting",EventSetting);
  registerInterceptorTypeForNamedType("Gdk", "EventTouch",EventTouch);
  registerInterceptorTypeForNamedType("Gdk", "EventTouchpadPinch",EventTouchpadPinch);
  registerInterceptorTypeForNamedType("Gdk", "EventTouchpadSwipe",EventTouchpadSwipe);
  registerInterceptorTypeForNamedType("Gdk", "EventType",EventType);
  registerInterceptorTypeForNamedType("Gdk", "EventVisibility",EventVisibility);
  registerInterceptorTypeForNamedType("Gdk", "EventWindowState",EventWindowState);
  registerInterceptorTypeForNamedType("Gdk", "FilterReturn",FilterReturn);
  registerInterceptorTypeForNamedType("Gdk", "FrameClock",FrameClock);
  registerInterceptorTypeForNamedType("Gdk", "FrameClockPhase",FrameClockPhase);
  registerInterceptorTypeForNamedType("Gdk", "FrameClockPrivate",FrameClockPrivate);
  registerInterceptorTypeForNamedType("Gdk", "FrameTimings",FrameTimings);
  registerInterceptorTypeForNamedType("Gdk", "FullscreenMode",FullscreenMode);
  registerInterceptorTypeForNamedType("Gdk", "GLContext",GLContext);
  registerInterceptorTypeForNamedType("Gdk", "GLError",GLErrorCode);
  registerInterceptorTypeForNamedType("Gdk", "Geometry",Geometry);
  registerInterceptorTypeForNamedType("Gdk", "GrabOwnership",GrabOwnership);
  registerInterceptorTypeForNamedType("Gdk", "GrabStatus",GrabStatus);
  registerInterceptorTypeForNamedType("Gdk", "Gravity",Gravity);
  registerInterceptorTypeForNamedType("Gdk", "InputMode",InputMode);
  registerInterceptorTypeForNamedType("Gdk", "InputSource",InputSource);
  registerInterceptorTypeForNamedType("Gdk", "Keymap",Keymap);
  registerInterceptorTypeForNamedType("Gdk", "KeymapKey",KeymapKey);
  registerInterceptorTypeForNamedType("Gdk", "ModifierIntent",ModifierIntent);
  registerInterceptorTypeForNamedType("Gdk", "ModifierType",ModifierType);
  registerInterceptorTypeForNamedType("Gdk", "NotifyType",NotifyType);
  registerInterceptorTypeForNamedType("Gdk", "OwnerChange",OwnerChange);
  registerInterceptorTypeForNamedType("Gdk", "Point",Point);
  registerInterceptorTypeForNamedType("Gdk", "PropMode",PropMode);
  registerInterceptorTypeForNamedType("Gdk", "PropertyState",PropertyState);
  registerInterceptorTypeForNamedType("Gdk", "RGBA",RGBA);
  registerInterceptorTypeForNamedType("Gdk", "Rectangle",Rectangle);
  registerInterceptorTypeForNamedType("Gdk", "Screen",Screen);
  registerInterceptorTypeForNamedType("Gdk", "ScrollDirection",ScrollDirection);
  registerInterceptorTypeForNamedType("Gdk", "SettingAction",SettingAction);
  registerInterceptorTypeForNamedType("Gdk", "Status",Status);
  registerInterceptorTypeForNamedType("Gdk", "TimeCoord",TimeCoord);
  registerInterceptorTypeForNamedType("Gdk", "TouchpadGesturePhase",TouchpadGesturePhase);
  registerInterceptorTypeForNamedType("Gdk", "VisibilityState",VisibilityState);
  registerInterceptorTypeForNamedType("Gdk", "Visual",Visual);
  registerInterceptorTypeForNamedType("Gdk", "VisualType",VisualType);
  registerInterceptorTypeForNamedType("Gdk", "WMDecoration",WMDecoration);
  registerInterceptorTypeForNamedType("Gdk", "WMFunction",WMFunction);
  registerInterceptorTypeForNamedType("Gdk", "Window",Window);
  registerInterceptorTypeForNamedType("Gdk", "WindowAttr",WindowAttr);
  registerInterceptorTypeForNamedType("Gdk", "WindowAttributesType",WindowAttributesType);
  registerInterceptorTypeForNamedType("Gdk", "WindowEdge",WindowEdge);
  registerInterceptorTypeForNamedType("Gdk", "WindowHints",WindowHints);
  registerInterceptorTypeForNamedType("Gdk", "WindowRedirect",WindowRedirect);
  registerInterceptorTypeForNamedType("Gdk", "WindowState",WindowState);
  registerInterceptorTypeForNamedType("Gdk", "WindowType",WindowType);
  registerInterceptorTypeForNamedType("Gdk", "WindowTypeHint",WindowTypeHint);
  registerInterceptorTypeForNamedType("Gdk", "WindowWindowClass",WindowWindowClass);
  registerInterceptorTypeForErrorDomain("gdk-gl-error-quark", GLError);
}
