library pango.gdart;

import "gdart.dart";

import "cairo.dart" as cairo;
import "glib.dart" hide initLibrary;
import "gobject.dart" hide initLibrary;
import "gobject.dart" as gobject;

class Alignment extends GEnumBase {
  const Alignment(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'Alignment');

  static const Alignment LEFT = const Alignment(0);
  static const Alignment CENTER = const Alignment(1);
  static const Alignment RIGHT = const Alignment(2);
  String toString() {
    switch(index) {
      case 0: return 'Alignment.LEFT';
      case 1: return 'Alignment.CENTER';
      case 2: return 'Alignment.RIGHT';
      default: return 'new Alignment($index)';
    }
  }
}

class Analysis extends GObjectBase {
  Analysis.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'Analysis');

  EngineShape get shapeEngine => getFieldOfObject('shape_engine', 0);
  void set shapeEngine(EngineShape value) => setFieldOfObject('shape_engine', 0, value);
  EngineLang get langEngine => getFieldOfObject('lang_engine', 1);
  void set langEngine(EngineLang value) => setFieldOfObject('lang_engine', 1, value);
  Font get font => getFieldOfObject('font', 2);
  void set font(Font value) => setFieldOfObject('font', 2, value);
  int get level => getFieldOfObject('level', 3);
  void set level(int value) => setFieldOfObject('level', 3, value);
  int get gravity => getFieldOfObject('gravity', 4);
  void set gravity(int value) => setFieldOfObject('gravity', 4, value);
  int get flags => getFieldOfObject('flags', 5);
  void set flags(int value) => setFieldOfObject('flags', 5, value);
  int get script => getFieldOfObject('script', 6);
  void set script(int value) => setFieldOfObject('script', 6, value);
  Language get language => getFieldOfObject('language', 7);
  void set language(Language value) => setFieldOfObject('language', 7, value);
  SList /* this will fail */ get extraAttrs => getFieldOfObject('extra_attrs', 8);
  void set extraAttrs(SList value /* this will fail */) => setFieldOfObject('extra_attrs', 8, value);
}

class AttrClass extends GObjectBase {
  AttrClass.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'AttrClass');

  AttrType get type => getFieldOfObject('type', 0);
  void set type(AttrType value) => setFieldOfObject('type', 0, value);
  dynamic /* this will fail */ get copy => getFieldOfObject('copy', 1);
}

class AttrColor extends GObjectBase {
  AttrColor.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'AttrColor');

  Attribute get attr => getFieldOfObject('attr', 0);
  void set attr(Attribute value) => setFieldOfObject('attr', 0, value);
  Color get color => getFieldOfObject('color', 1);
  void set color(Color value) => setFieldOfObject('color', 1, value);
}

typedef bool AttrFilterFunc(Attribute attribute);
class AttrFloat extends GObjectBase {
  AttrFloat.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'AttrFloat');

  Attribute get attr => getFieldOfObject('attr', 0);
  void set attr(Attribute value) => setFieldOfObject('attr', 0, value);
  num get value => getFieldOfObject('value', 1);
  void set value(num value) => setFieldOfObject('value', 1, value);
}

class AttrFontDesc extends GObjectBase {
  AttrFontDesc.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'AttrFontDesc');

  Attribute get attr => getFieldOfObject('attr', 0);
  void set attr(Attribute value) => setFieldOfObject('attr', 0, value);
  FontDescription get desc => getFieldOfObject('desc', 1);
  void set desc(FontDescription value) => setFieldOfObject('desc', 1, value);
}

class AttrFontFeatures extends GObjectBase {
  AttrFontFeatures.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'AttrFontFeatures');

  Attribute get attr => getFieldOfObject('attr', 0);
  void set attr(Attribute value) => setFieldOfObject('attr', 0, value);
  String get features => getFieldOfObject('features', 1);
  void set features(String value) => setFieldOfObject('features', 1, value);
}

class AttrInt extends GObjectBase {
  AttrInt.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'AttrInt');

  Attribute get attr => getFieldOfObject('attr', 0);
  void set attr(Attribute value) => setFieldOfObject('attr', 0, value);
  int get value => getFieldOfObject('value', 1);
  void set value(int value) => setFieldOfObject('value', 1, value);
}

class AttrIterator extends GObjectBase {
  AttrIterator.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'AttrIterator');

  void destroy() => _staticInfo.callMethodOnReceiver('destroy', this, []);
  SList /* this will fail */ get attrs => _staticInfo.callMethodOnReceiver('get_attrs', this, []);
  void getFont(FontDescription desc, Language language, SList extraAttrs /* this will fail */) => _staticInfo.callMethodOnReceiver('get_font', this, [desc, language, extraAttrs]);
  bool next() => _staticInfo.callMethodOnReceiver('next', this, []);
  List range() => _staticInfo.callMethodOnReceiver('range', this, []);
}

class AttrLanguage extends GObjectBase {
  AttrLanguage.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'AttrLanguage');

  Attribute get attr => getFieldOfObject('attr', 0);
  void set attr(Attribute value) => setFieldOfObject('attr', 0, value);
  Language get value => getFieldOfObject('value', 1);
  void set value(Language value) => setFieldOfObject('value', 1, value);
}

class AttrList extends GObjectBase {
  AttrList.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'AttrList');

  factory AttrList() => _staticInfo.callStatic('new', []);
  void change(Attribute attr) => _staticInfo.callMethodOnReceiver('change', this, [attr]);
  AttrList copy() => _staticInfo.callMethodOnReceiver('copy', this, []);
  AttrList filter(AttrFilterFunc func) => _staticInfo.callMethodOnReceiver('filter', this, [func]);
  void insert(Attribute attr) => _staticInfo.callMethodOnReceiver('insert', this, [attr]);
  void insertBefore(Attribute attr) => _staticInfo.callMethodOnReceiver('insert_before', this, [attr]);
  AttrList ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  void splice(AttrList other, int pos, int len) => _staticInfo.callMethodOnReceiver('splice', this, [other, pos, len]);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
}

class AttrShape extends GObjectBase {
  AttrShape.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'AttrShape');

  Attribute get attr => getFieldOfObject('attr', 0);
  void set attr(Attribute value) => setFieldOfObject('attr', 0, value);
  Rectangle get inkRect => getFieldOfObject('ink_rect', 1);
  void set inkRect(Rectangle value) => setFieldOfObject('ink_rect', 1, value);
  Rectangle get logicalRect => getFieldOfObject('logical_rect', 2);
  void set logicalRect(Rectangle value) => setFieldOfObject('logical_rect', 2, value);
  dynamic /* this will fail */ get data => getFieldOfObject('data', 3);
  void set data(dynamic value /* this will fail */) => setFieldOfObject('data', 3, value);
  dynamic /* this will fail */ get copyFunc => getFieldOfObject('copy_func', 4);
  void set copyFunc(dynamic value /* this will fail */) => setFieldOfObject('copy_func', 4, value);
  DestroyNotify get destroyFunc => getFieldOfObject('destroy_func', 5);
  void set destroyFunc(DestroyNotify value) => setFieldOfObject('destroy_func', 5, value);
}

class AttrSize extends GObjectBase {
  AttrSize.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'AttrSize');

  Attribute get attr => getFieldOfObject('attr', 0);
  void set attr(Attribute value) => setFieldOfObject('attr', 0, value);
  int get size => getFieldOfObject('size', 1);
  void set size(int value) => setFieldOfObject('size', 1, value);
  int get absolute => getFieldOfObject('absolute', 2);
  void set absolute(int value) => setFieldOfObject('absolute', 2, value);
}

class AttrString extends GObjectBase {
  AttrString.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'AttrString');

  Attribute get attr => getFieldOfObject('attr', 0);
  void set attr(Attribute value) => setFieldOfObject('attr', 0, value);
  String get value => getFieldOfObject('value', 1);
  void set value(String value) => setFieldOfObject('value', 1, value);
}

class AttrType extends GEnumBase {
  const AttrType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'AttrType');

  static const AttrType INVALID = const AttrType(0);
  static const AttrType LANGUAGE = const AttrType(1);
  static const AttrType FAMILY = const AttrType(2);
  static const AttrType STYLE = const AttrType(3);
  static const AttrType WEIGHT = const AttrType(4);
  static const AttrType VARIANT = const AttrType(5);
  static const AttrType STRETCH = const AttrType(6);
  static const AttrType SIZE = const AttrType(7);
  static const AttrType FONT_DESC = const AttrType(8);
  static const AttrType FOREGROUND = const AttrType(9);
  static const AttrType BACKGROUND = const AttrType(10);
  static const AttrType UNDERLINE = const AttrType(11);
  static const AttrType STRIKETHROUGH = const AttrType(12);
  static const AttrType RISE = const AttrType(13);
  static const AttrType SHAPE = const AttrType(14);
  static const AttrType SCALE = const AttrType(15);
  static const AttrType FALLBACK = const AttrType(16);
  static const AttrType LETTER_SPACING = const AttrType(17);
  static const AttrType UNDERLINE_COLOR = const AttrType(18);
  static const AttrType STRIKETHROUGH_COLOR = const AttrType(19);
  static const AttrType ABSOLUTE_SIZE = const AttrType(20);
  static const AttrType GRAVITY = const AttrType(21);
  static const AttrType GRAVITY_HINT = const AttrType(22);
  static const AttrType FONT_FEATURES = const AttrType(23);
  static const AttrType FOREGROUND_ALPHA = const AttrType(24);
  static const AttrType BACKGROUND_ALPHA = const AttrType(25);
  String toString() {
    switch(index) {
      case 0: return 'AttrType.INVALID';
      case 1: return 'AttrType.LANGUAGE';
      case 2: return 'AttrType.FAMILY';
      case 3: return 'AttrType.STYLE';
      case 4: return 'AttrType.WEIGHT';
      case 5: return 'AttrType.VARIANT';
      case 6: return 'AttrType.STRETCH';
      case 7: return 'AttrType.SIZE';
      case 8: return 'AttrType.FONT_DESC';
      case 9: return 'AttrType.FOREGROUND';
      case 10: return 'AttrType.BACKGROUND';
      case 11: return 'AttrType.UNDERLINE';
      case 12: return 'AttrType.STRIKETHROUGH';
      case 13: return 'AttrType.RISE';
      case 14: return 'AttrType.SHAPE';
      case 15: return 'AttrType.SCALE';
      case 16: return 'AttrType.FALLBACK';
      case 17: return 'AttrType.LETTER_SPACING';
      case 18: return 'AttrType.UNDERLINE_COLOR';
      case 19: return 'AttrType.STRIKETHROUGH_COLOR';
      case 20: return 'AttrType.ABSOLUTE_SIZE';
      case 21: return 'AttrType.GRAVITY';
      case 22: return 'AttrType.GRAVITY_HINT';
      case 23: return 'AttrType.FONT_FEATURES';
      case 24: return 'AttrType.FOREGROUND_ALPHA';
      case 25: return 'AttrType.BACKGROUND_ALPHA';
      default: return 'new AttrType($index)';
    }
  }
  static String getName(AttrType type) => _staticInfo.callStatic('get_name', [type]);
  static AttrType register(String name) => _staticInfo.callStatic('register', [name]);
}

class Attribute extends GObjectBase {
  Attribute.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'Attribute');

  void destroy() => _staticInfo.callMethodOnReceiver('destroy', this, []);
  bool equal(Attribute attr2) => _staticInfo.callMethodOnReceiver('equal', this, [attr2]);
  void init(AttrClass klass) => _staticInfo.callMethodOnReceiver('init', this, [klass]);
  AttrClass get klass => getFieldOfObject('klass', 0);
  void set klass(AttrClass value) => setFieldOfObject('klass', 0, value);
  int get startIndex => getFieldOfObject('start_index', 1);
  void set startIndex(int value) => setFieldOfObject('start_index', 1, value);
  int get endIndex => getFieldOfObject('end_index', 2);
  void set endIndex(int value) => setFieldOfObject('end_index', 2, value);
}

class BidiType extends GEnumBase {
  const BidiType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'BidiType');

  static const BidiType L = const BidiType(0);
  static const BidiType LRE = const BidiType(1);
  static const BidiType LRO = const BidiType(2);
  static const BidiType R = const BidiType(3);
  static const BidiType AL = const BidiType(4);
  static const BidiType RLE = const BidiType(5);
  static const BidiType RLO = const BidiType(6);
  static const BidiType PDF = const BidiType(7);
  static const BidiType EN = const BidiType(8);
  static const BidiType ES = const BidiType(9);
  static const BidiType ET = const BidiType(10);
  static const BidiType AN = const BidiType(11);
  static const BidiType CS = const BidiType(12);
  static const BidiType NSM = const BidiType(13);
  static const BidiType BN = const BidiType(14);
  static const BidiType B = const BidiType(15);
  static const BidiType S = const BidiType(16);
  static const BidiType WS = const BidiType(17);
  static const BidiType ON = const BidiType(18);
  String toString() {
    switch(index) {
      case 0: return 'BidiType.L';
      case 1: return 'BidiType.LRE';
      case 2: return 'BidiType.LRO';
      case 3: return 'BidiType.R';
      case 4: return 'BidiType.AL';
      case 5: return 'BidiType.RLE';
      case 6: return 'BidiType.RLO';
      case 7: return 'BidiType.PDF';
      case 8: return 'BidiType.EN';
      case 9: return 'BidiType.ES';
      case 10: return 'BidiType.ET';
      case 11: return 'BidiType.AN';
      case 12: return 'BidiType.CS';
      case 13: return 'BidiType.NSM';
      case 14: return 'BidiType.BN';
      case 15: return 'BidiType.B';
      case 16: return 'BidiType.S';
      case 17: return 'BidiType.WS';
      case 18: return 'BidiType.ON';
      default: return 'new BidiType($index)';
    }
  }
  static BidiType forUnichar(int ch) => _staticInfo.callStatic('for_unichar', [ch]);
}

class Color extends GObjectBase {
  Color.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'Color');

  Color copy() => _staticInfo.callMethodOnReceiver('copy', this, []);
  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
  bool parse(String spec) => _staticInfo.callMethodOnReceiver('parse', this, [spec]);
  String toString() => _staticInfo.callMethodOnReceiver('to_string', this, []);
  int get red => getFieldOfObject('red', 0);
  void set red(int value) => setFieldOfObject('red', 0, value);
  int get green => getFieldOfObject('green', 1);
  void set green(int value) => setFieldOfObject('green', 1, value);
  int get blue => getFieldOfObject('blue', 2);
  void set blue(int value) => setFieldOfObject('blue', 2, value);
}

class Context extends GObjectObject {
  Context.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'Context');

  factory Context() => _staticInfo.callStatic('new', []);
  void changed() => _staticInfo.callMethodOnReceiver('changed', this, []);
  Direction get baseDir => _staticInfo.callMethodOnReceiver('get_base_dir', this, []);
  Gravity get baseGravity => _staticInfo.callMethodOnReceiver('get_base_gravity', this, []);
  FontDescription get fontDescription => _staticInfo.callMethodOnReceiver('get_font_description', this, []);
  FontMap get fontMap => _staticInfo.callMethodOnReceiver('get_font_map', this, []);
  Gravity get gravity => _staticInfo.callMethodOnReceiver('get_gravity', this, []);
  GravityHint get gravityHint => _staticInfo.callMethodOnReceiver('get_gravity_hint', this, []);
  Language get language => _staticInfo.callMethodOnReceiver('get_language', this, []);
  Matrix get matrix => _staticInfo.callMethodOnReceiver('get_matrix', this, []);
  FontMetrics getMetrics(FontDescription desc, Language language) => _staticInfo.callMethodOnReceiver('get_metrics', this, [desc, language]);
  int get serial => _staticInfo.callMethodOnReceiver('get_serial', this, []);
  List listFamilies() => _staticInfo.callMethodOnReceiver('list_families', this, []);
  Font loadFont(FontDescription desc) => _staticInfo.callMethodOnReceiver('load_font', this, [desc]);
  Fontset loadFontset(FontDescription desc, Language language) => _staticInfo.callMethodOnReceiver('load_fontset', this, [desc, language]);
  void set baseDir(Direction direction) => _staticInfo.callMethodOnReceiver('set_base_dir', this, [direction]);
  void set baseGravity(Gravity gravity) => _staticInfo.callMethodOnReceiver('set_base_gravity', this, [gravity]);
  void set fontDescription(FontDescription desc) => _staticInfo.callMethodOnReceiver('set_font_description', this, [desc]);
  void set fontMap(FontMap fontMap) => _staticInfo.callMethodOnReceiver('set_font_map', this, [fontMap]);
  void set gravityHint(GravityHint hint) => _staticInfo.callMethodOnReceiver('set_gravity_hint', this, [hint]);
  void set language(Language language) => _staticInfo.callMethodOnReceiver('set_language', this, [language]);
  void set matrix(Matrix matrix) => _staticInfo.callMethodOnReceiver('set_matrix', this, [matrix]);
}

class Coverage extends GObjectBase {
  Coverage.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'Coverage');

  CoverageLevel get_(int index_) => _staticInfo.callMethodOnReceiver('get', this, [index_]);
  void max(Coverage other) => _staticInfo.callMethodOnReceiver('max', this, [other]);
  void set_(int index_, CoverageLevel level) => _staticInfo.callMethodOnReceiver('set', this, [index_, level]);
  List toBytes() => _staticInfo.callMethodOnReceiver('to_bytes', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
}

class CoverageLevel extends GEnumBase {
  const CoverageLevel(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'CoverageLevel');

  static const CoverageLevel NONE = const CoverageLevel(0);
  static const CoverageLevel FALLBACK = const CoverageLevel(1);
  static const CoverageLevel APPROXIMATE = const CoverageLevel(2);
  static const CoverageLevel EXACT = const CoverageLevel(3);
  String toString() {
    switch(index) {
      case 0: return 'CoverageLevel.NONE';
      case 1: return 'CoverageLevel.FALLBACK';
      case 2: return 'CoverageLevel.APPROXIMATE';
      case 3: return 'CoverageLevel.EXACT';
      default: return 'new CoverageLevel($index)';
    }
  }
}

class Direction extends GEnumBase {
  const Direction(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'Direction');

  static const Direction LTR = const Direction(0);
  static const Direction RTL = const Direction(1);
  static const Direction TTB_LTR = const Direction(2);
  static const Direction TTB_RTL = const Direction(3);
  static const Direction WEAK_LTR = const Direction(4);
  static const Direction WEAK_RTL = const Direction(5);
  static const Direction NEUTRAL = const Direction(6);
  String toString() {
    switch(index) {
      case 0: return 'Direction.LTR';
      case 1: return 'Direction.RTL';
      case 2: return 'Direction.TTB_LTR';
      case 3: return 'Direction.TTB_RTL';
      case 4: return 'Direction.WEAK_LTR';
      case 5: return 'Direction.WEAK_RTL';
      case 6: return 'Direction.NEUTRAL';
      default: return 'new Direction($index)';
    }
  }
}

class EllipsizeMode extends GEnumBase {
  const EllipsizeMode(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'EllipsizeMode');

  static const EllipsizeMode NONE = const EllipsizeMode(0);
  static const EllipsizeMode START = const EllipsizeMode(1);
  static const EllipsizeMode MIDDLE = const EllipsizeMode(2);
  static const EllipsizeMode END = const EllipsizeMode(3);
  String toString() {
    switch(index) {
      case 0: return 'EllipsizeMode.NONE';
      case 1: return 'EllipsizeMode.START';
      case 2: return 'EllipsizeMode.MIDDLE';
      case 3: return 'EllipsizeMode.END';
      default: return 'new EllipsizeMode($index)';
    }
  }
}

class Engine extends GObjectObject {
  Engine.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'Engine');

}

class EngineInfo extends GObjectBase {
  EngineInfo.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'EngineInfo');

  String get id => getFieldOfObject('id', 0);
  void set id(String value) => setFieldOfObject('id', 0, value);
  String get engineType => getFieldOfObject('engine_type', 1);
  void set engineType(String value) => setFieldOfObject('engine_type', 1, value);
  String get renderType => getFieldOfObject('render_type', 2);
  void set renderType(String value) => setFieldOfObject('render_type', 2, value);
  EngineScriptInfo get scripts => getFieldOfObject('scripts', 3);
  void set scripts(EngineScriptInfo value) => setFieldOfObject('scripts', 3, value);
  int get nScripts => getFieldOfObject('n_scripts', 4);
  void set nScripts(int value) => setFieldOfObject('n_scripts', 4, value);
}

class EngineLang extends Engine {
  EngineLang.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'EngineLang');

}

class EngineScriptInfo extends GObjectBase {
  EngineScriptInfo.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'EngineScriptInfo');

  Script get script => getFieldOfObject('script', 0);
  void set script(Script value) => setFieldOfObject('script', 0, value);
  String get langs => getFieldOfObject('langs', 1);
  void set langs(String value) => setFieldOfObject('langs', 1, value);
}

class EngineShape extends Engine {
  EngineShape.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'EngineShape');

}

class Font extends GObjectObject {
  Font.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'Font');

  static void descriptionsFree(List<FontDescription> descs) => _staticInfo.callStatic('descriptions_free', [descs]);
  FontDescription describe() => _staticInfo.callMethodOnReceiver('describe', this, []);
  FontDescription describeWithAbsoluteSize() => _staticInfo.callMethodOnReceiver('describe_with_absolute_size', this, []);
  FontMap get fontMap => _staticInfo.callMethodOnReceiver('get_font_map', this, []);
  List getGlyphExtents(int glyph) => _staticInfo.callMethodOnReceiver('get_glyph_extents', this, [glyph]);
  FontMetrics getMetrics(Language language) => _staticInfo.callMethodOnReceiver('get_metrics', this, [language]);
}

class FontDescription extends GObjectBase {
  FontDescription.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'FontDescription');

  factory FontDescription() => _staticInfo.callStatic('new', []);
  bool betterMatch(FontDescription oldMatch, FontDescription newMatch) => _staticInfo.callMethodOnReceiver('better_match', this, [oldMatch, newMatch]);
  FontDescription copy() => _staticInfo.callMethodOnReceiver('copy', this, []);
  FontDescription copyStatic() => _staticInfo.callMethodOnReceiver('copy_static', this, []);
  bool equal(FontDescription desc2) => _staticInfo.callMethodOnReceiver('equal', this, [desc2]);
  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
  String get family => _staticInfo.callMethodOnReceiver('get_family', this, []);
  Gravity get gravity => _staticInfo.callMethodOnReceiver('get_gravity', this, []);
  FontMask get setFields => _staticInfo.callMethodOnReceiver('get_set_fields', this, []);
  int get size => _staticInfo.callMethodOnReceiver('get_size', this, []);
  bool get sizeIsAbsolute => _staticInfo.callMethodOnReceiver('get_size_is_absolute', this, []);
  Stretch get stretch => _staticInfo.callMethodOnReceiver('get_stretch', this, []);
  Style get style => _staticInfo.callMethodOnReceiver('get_style', this, []);
  Variant get variant => _staticInfo.callMethodOnReceiver('get_variant', this, []);
  Weight get weight => _staticInfo.callMethodOnReceiver('get_weight', this, []);
  int hash() => _staticInfo.callMethodOnReceiver('hash', this, []);
  void merge(FontDescription descToMerge, bool replaceExisting) => _staticInfo.callMethodOnReceiver('merge', this, [descToMerge, replaceExisting]);
  void mergeStatic(FontDescription descToMerge, bool replaceExisting) => _staticInfo.callMethodOnReceiver('merge_static', this, [descToMerge, replaceExisting]);
  void setAbsoluteSize(num size) => _staticInfo.callMethodOnReceiver('set_absolute_size', this, [size]);
  void set family(String family) => _staticInfo.callMethodOnReceiver('set_family', this, [family]);
  void setFamilyStatic(String family) => _staticInfo.callMethodOnReceiver('set_family_static', this, [family]);
  void set gravity(Gravity gravity) => _staticInfo.callMethodOnReceiver('set_gravity', this, [gravity]);
  void set size(int size) => _staticInfo.callMethodOnReceiver('set_size', this, [size]);
  void set stretch(Stretch stretch) => _staticInfo.callMethodOnReceiver('set_stretch', this, [stretch]);
  void set style(Style style) => _staticInfo.callMethodOnReceiver('set_style', this, [style]);
  void set variant(Variant variant) => _staticInfo.callMethodOnReceiver('set_variant', this, [variant]);
  void set weight(Weight weight) => _staticInfo.callMethodOnReceiver('set_weight', this, [weight]);
  String toFilename() => _staticInfo.callMethodOnReceiver('to_filename', this, []);
  String toString() => _staticInfo.callMethodOnReceiver('to_string', this, []);
  void unsetFields(FontMask toUnset) => _staticInfo.callMethodOnReceiver('unset_fields', this, [toUnset]);
  static FontDescription fromString(String str) => _staticInfo.callStatic('from_string', [str]);
}

class FontFace extends GObjectObject {
  FontFace.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'FontFace');

  FontDescription describe() => _staticInfo.callMethodOnReceiver('describe', this, []);
  String get faceName => _staticInfo.callMethodOnReceiver('get_face_name', this, []);
  bool isSynthesized() => _staticInfo.callMethodOnReceiver('is_synthesized', this, []);
  List listSizes() => _staticInfo.callMethodOnReceiver('list_sizes', this, []);
}

class FontFamily extends GObjectObject {
  FontFamily.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'FontFamily');

  String get name => _staticInfo.callMethodOnReceiver('get_name', this, []);
  bool isMonospace() => _staticInfo.callMethodOnReceiver('is_monospace', this, []);
  List listFaces() => _staticInfo.callMethodOnReceiver('list_faces', this, []);
}

class FontMap extends GObjectObject {
  FontMap.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'FontMap');

  void changed() => _staticInfo.callMethodOnReceiver('changed', this, []);
  Context createContext() => _staticInfo.callMethodOnReceiver('create_context', this, []);
  int get serial => _staticInfo.callMethodOnReceiver('get_serial', this, []);
  String get shapeEngineType => _staticInfo.callMethodOnReceiver('get_shape_engine_type', this, []);
  List listFamilies() => _staticInfo.callMethodOnReceiver('list_families', this, []);
  Font loadFont(Context context, FontDescription desc) => _staticInfo.callMethodOnReceiver('load_font', this, [context, desc]);
  Fontset loadFontset(Context context, FontDescription desc, Language language) => _staticInfo.callMethodOnReceiver('load_fontset', this, [context, desc, language]);
}

class FontMask extends GEnumBase {
  const FontMask(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'FontMask');

  static const FontMask NULL = const FontMask(0);
  static const FontMask FAMILY = const FontMask(1);
  bool get family => (index & 1) == 1;
  static const FontMask STYLE = const FontMask(2);
  bool get style => (index & 2) == 2;
  static const FontMask VARIANT = const FontMask(4);
  bool get variant => (index & 4) == 4;
  static const FontMask WEIGHT = const FontMask(8);
  bool get weight => (index & 8) == 8;
  static const FontMask STRETCH = const FontMask(16);
  bool get stretch => (index & 16) == 16;
  static const FontMask SIZE = const FontMask(32);
  bool get size => (index & 32) == 32;
  static const FontMask GRAVITY = const FontMask(64);
  bool get gravity => (index & 64) == 64;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'FontMask.FAMILY';
      case 2: return 'FontMask.STYLE';
      case 4: return 'FontMask.VARIANT';
      case 8: return 'FontMask.WEIGHT';
      case 16: return 'FontMask.STRETCH';
      case 32: return 'FontMask.SIZE';
      case 64: return 'FontMask.GRAVITY';
      default: return 'new FontMask($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'FontMask.NULL';
    }
    List codes = [];
    for (var i=1; i <= 64; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  FontMask operator|(FontMask other) =>
    new FontMask(index | other.index);
  FontMask operator&(FontMask other) =>
    new FontMask(index & other.index);
}

class FontMetrics extends GObjectBase {
  FontMetrics.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'FontMetrics');

  factory FontMetrics() => _staticInfo.callStatic('new', []);
  int get approximateCharWidth => _staticInfo.callMethodOnReceiver('get_approximate_char_width', this, []);
  int get approximateDigitWidth => _staticInfo.callMethodOnReceiver('get_approximate_digit_width', this, []);
  int get ascent => _staticInfo.callMethodOnReceiver('get_ascent', this, []);
  int get descent => _staticInfo.callMethodOnReceiver('get_descent', this, []);
  int get strikethroughPosition => _staticInfo.callMethodOnReceiver('get_strikethrough_position', this, []);
  int get strikethroughThickness => _staticInfo.callMethodOnReceiver('get_strikethrough_thickness', this, []);
  int get underlinePosition => _staticInfo.callMethodOnReceiver('get_underline_position', this, []);
  int get underlineThickness => _staticInfo.callMethodOnReceiver('get_underline_thickness', this, []);
  FontMetrics ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
  int get refCount => getFieldOfObject('ref_count', 0);
}

class Fontset extends GObjectObject {
  Fontset.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'Fontset');

  void foreach(FontsetForeachFunc func) => _staticInfo.callMethodOnReceiver('foreach', this, [func]);
  Font getFont(int wc) => _staticInfo.callMethodOnReceiver('get_font', this, [wc]);
  FontMetrics get metrics => _staticInfo.callMethodOnReceiver('get_metrics', this, []);
}

typedef bool FontsetForeachFunc(Fontset fontset, Font font);
class FontsetSimple extends Fontset {
  FontsetSimple.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'FontsetSimple');

  factory FontsetSimple(Language language) => _staticInfo.callStatic('new', [language]);
  void append(Font font) => _staticInfo.callMethodOnReceiver('append', this, [font]);
  int size() => _staticInfo.callMethodOnReceiver('size', this, []);
}

class GlyphGeometry extends GObjectBase {
  GlyphGeometry.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'GlyphGeometry');

  int get width => getFieldOfObject('width', 0);
  void set width(int value) => setFieldOfObject('width', 0, value);
  int get xOffset => getFieldOfObject('x_offset', 1);
  void set xOffset(int value) => setFieldOfObject('x_offset', 1, value);
  int get yOffset => getFieldOfObject('y_offset', 2);
  void set yOffset(int value) => setFieldOfObject('y_offset', 2, value);
}

class GlyphInfo extends GObjectBase {
  GlyphInfo.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'GlyphInfo');

  int get glyph => getFieldOfObject('glyph', 0);
  void set glyph(int value) => setFieldOfObject('glyph', 0, value);
  GlyphGeometry get geometry => getFieldOfObject('geometry', 1);
  void set geometry(GlyphGeometry value) => setFieldOfObject('geometry', 1, value);
  GlyphVisAttr get attr => getFieldOfObject('attr', 2);
  void set attr(GlyphVisAttr value) => setFieldOfObject('attr', 2, value);
}

class GlyphItem extends GObjectBase {
  GlyphItem.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'GlyphItem');

  SList /* this will fail */ applyAttrs(String text, AttrList list) => _staticInfo.callMethodOnReceiver('apply_attrs', this, [text, list]);
  GlyphItem copy() => _staticInfo.callMethodOnReceiver('copy', this, []);
  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
  void getLogicalWidths(String text, List<int> logicalWidths) => _staticInfo.callMethodOnReceiver('get_logical_widths', this, [text, logicalWidths]);
  void letterSpace(String text, List<LogAttr> logAttrs, int letterSpacing) => _staticInfo.callMethodOnReceiver('letter_space', this, [text, logAttrs, letterSpacing]);
  GlyphItem split(String text, int splitIndex) => _staticInfo.callMethodOnReceiver('split', this, [text, splitIndex]);
  Item get item => getFieldOfObject('item', 0);
  void set item(Item value) => setFieldOfObject('item', 0, value);
  GlyphString get glyphs => getFieldOfObject('glyphs', 1);
  void set glyphs(GlyphString value) => setFieldOfObject('glyphs', 1, value);
}

class GlyphItemIter extends GObjectBase {
  GlyphItemIter.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'GlyphItemIter');

  GlyphItemIter copy() => _staticInfo.callMethodOnReceiver('copy', this, []);
  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
  bool initEnd(GlyphItem glyphItem, String text) => _staticInfo.callMethodOnReceiver('init_end', this, [glyphItem, text]);
  bool initStart(GlyphItem glyphItem, String text) => _staticInfo.callMethodOnReceiver('init_start', this, [glyphItem, text]);
  bool nextCluster() => _staticInfo.callMethodOnReceiver('next_cluster', this, []);
  bool prevCluster() => _staticInfo.callMethodOnReceiver('prev_cluster', this, []);
  GlyphItem get glyphItem => getFieldOfObject('glyph_item', 0);
  void set glyphItem(GlyphItem value) => setFieldOfObject('glyph_item', 0, value);
  String get text => getFieldOfObject('text', 1);
  void set text(String value) => setFieldOfObject('text', 1, value);
  int get startGlyph => getFieldOfObject('start_glyph', 2);
  void set startGlyph(int value) => setFieldOfObject('start_glyph', 2, value);
  int get startIndex => getFieldOfObject('start_index', 3);
  void set startIndex(int value) => setFieldOfObject('start_index', 3, value);
  int get startChar => getFieldOfObject('start_char', 4);
  void set startChar(int value) => setFieldOfObject('start_char', 4, value);
  int get endGlyph => getFieldOfObject('end_glyph', 5);
  void set endGlyph(int value) => setFieldOfObject('end_glyph', 5, value);
  int get endIndex => getFieldOfObject('end_index', 6);
  void set endIndex(int value) => setFieldOfObject('end_index', 6, value);
  int get endChar => getFieldOfObject('end_char', 7);
  void set endChar(int value) => setFieldOfObject('end_char', 7, value);
}

class GlyphString extends GObjectBase {
  GlyphString.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'GlyphString');

  factory GlyphString() => _staticInfo.callStatic('new', []);
  GlyphString copy() => _staticInfo.callMethodOnReceiver('copy', this, []);
  List extents(Font font) => _staticInfo.callMethodOnReceiver('extents', this, [font]);
  List extentsRange(int start, int end, Font font) => _staticInfo.callMethodOnReceiver('extents_range', this, [start, end, font]);
  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
  void getLogicalWidths(String text, int length, int embeddingLevel, List<int> logicalWidths) => _staticInfo.callMethodOnReceiver('get_logical_widths', this, [text, length, embeddingLevel, logicalWidths]);
  int get width => _staticInfo.callMethodOnReceiver('get_width', this, []);
  int indexToX(String text, int length, Analysis analysis, int index_, bool trailing) => _staticInfo.callMethodOnReceiver('index_to_x', this, [text, length, analysis, index_, trailing]);
  void setSize(int newLen) => _staticInfo.callMethodOnReceiver('set_size', this, [newLen]);
  List xToIndex(String text, int length, Analysis analysis, int xPos) => _staticInfo.callMethodOnReceiver('x_to_index', this, [text, length, analysis, xPos]);
  int get numGlyphs => getFieldOfObject('num_glyphs', 0);
  void set numGlyphs(int value) => setFieldOfObject('num_glyphs', 0, value);
  List<GlyphInfo> get glyphs => getFieldOfObject('glyphs', 1);
  void set glyphs(List<GlyphInfo> value) => setFieldOfObject('glyphs', 1, value);
  int get logClusters => getFieldOfObject('log_clusters', 2);
  void set logClusters(int value) => setFieldOfObject('log_clusters', 2, value);
  int get space => getFieldOfObject('space', 3);
}

class GlyphVisAttr extends GObjectBase {
  GlyphVisAttr.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'GlyphVisAttr');

  int get isClusterStart => getFieldOfObject('is_cluster_start', 0);
  void set isClusterStart(int value) => setFieldOfObject('is_cluster_start', 0, value);
}

class Gravity extends GEnumBase {
  const Gravity(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'Gravity');

  static const Gravity SOUTH = const Gravity(0);
  static const Gravity EAST = const Gravity(1);
  static const Gravity NORTH = const Gravity(2);
  static const Gravity WEST = const Gravity(3);
  static const Gravity AUTO = const Gravity(4);
  String toString() {
    switch(index) {
      case 0: return 'Gravity.SOUTH';
      case 1: return 'Gravity.EAST';
      case 2: return 'Gravity.NORTH';
      case 3: return 'Gravity.WEST';
      case 4: return 'Gravity.AUTO';
      default: return 'new Gravity($index)';
    }
  }
  static Gravity getForMatrix(Matrix matrix) => _staticInfo.callStatic('get_for_matrix', [matrix]);
  static Gravity getForScript(Script script, Gravity baseGravity, GravityHint hint) => _staticInfo.callStatic('get_for_script', [script, baseGravity, hint]);
  static Gravity getForScriptAndWidth(Script script, bool wide, Gravity baseGravity, GravityHint hint) => _staticInfo.callStatic('get_for_script_and_width', [script, wide, baseGravity, hint]);
  static num toRotation(Gravity gravity) => _staticInfo.callStatic('to_rotation', [gravity]);
}

class GravityHint extends GEnumBase {
  const GravityHint(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'GravityHint');

  static const GravityHint NATURAL = const GravityHint(0);
  static const GravityHint STRONG = const GravityHint(1);
  static const GravityHint LINE = const GravityHint(2);
  String toString() {
    switch(index) {
      case 0: return 'GravityHint.NATURAL';
      case 1: return 'GravityHint.STRONG';
      case 2: return 'GravityHint.LINE';
      default: return 'new GravityHint($index)';
    }
  }
}

class IncludedModule extends GObjectBase {
  IncludedModule.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'IncludedModule');

  dynamic /* this will fail */ get create => getFieldOfObject('create', 3);
}

class Item extends GObjectBase {
  Item.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'Item');

  factory Item() => _staticInfo.callStatic('new', []);
  Item copy() => _staticInfo.callMethodOnReceiver('copy', this, []);
  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
  Item split(int splitIndex, int splitOffset) => _staticInfo.callMethodOnReceiver('split', this, [splitIndex, splitOffset]);
  int get offset => getFieldOfObject('offset', 0);
  void set offset(int value) => setFieldOfObject('offset', 0, value);
  int get length => getFieldOfObject('length', 1);
  void set length(int value) => setFieldOfObject('length', 1, value);
  int get numChars => getFieldOfObject('num_chars', 2);
  void set numChars(int value) => setFieldOfObject('num_chars', 2, value);
  Analysis get analysis => getFieldOfObject('analysis', 3);
  void set analysis(Analysis value) => setFieldOfObject('analysis', 3, value);
}

class Language extends GObjectBase {
  Language.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'Language');

  String get sampleString => _staticInfo.callMethodOnReceiver('get_sample_string', this, []);
  List getScripts() => _staticInfo.callMethodOnReceiver('get_scripts', this, []);
  bool includesScript(Script script) => _staticInfo.callMethodOnReceiver('includes_script', this, [script]);
  bool matches(String rangeList) => _staticInfo.callMethodOnReceiver('matches', this, [rangeList]);
  String toString() => _staticInfo.callMethodOnReceiver('to_string', this, []);
  static Language fromString(String language) => _staticInfo.callStatic('from_string', [language]);
  static Language getDefault() => _staticInfo.callStatic('get_default', []);
}

class Layout extends GObjectObject {
  Layout.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'Layout');

  factory Layout(Context context) => _staticInfo.callStatic('new', [context]);
  void contextChanged() => _staticInfo.callMethodOnReceiver('context_changed', this, []);
  Layout copy() => _staticInfo.callMethodOnReceiver('copy', this, []);
  Alignment get alignment => _staticInfo.callMethodOnReceiver('get_alignment', this, []);
  AttrList get attributes => _staticInfo.callMethodOnReceiver('get_attributes', this, []);
  bool get autoDir => _staticInfo.callMethodOnReceiver('get_auto_dir', this, []);
  int get baseline => _staticInfo.callMethodOnReceiver('get_baseline', this, []);
  int get characterCount => _staticInfo.callMethodOnReceiver('get_character_count', this, []);
  Context get context => _staticInfo.callMethodOnReceiver('get_context', this, []);
  List getCursorPos(int index_) => _staticInfo.callMethodOnReceiver('get_cursor_pos', this, [index_]);
  EllipsizeMode get ellipsize => _staticInfo.callMethodOnReceiver('get_ellipsize', this, []);
  List getExtents() => _staticInfo.callMethodOnReceiver('get_extents', this, []);
  FontDescription get fontDescription => _staticInfo.callMethodOnReceiver('get_font_description', this, []);
  int get height => _staticInfo.callMethodOnReceiver('get_height', this, []);
  int get indent => _staticInfo.callMethodOnReceiver('get_indent', this, []);
  LayoutIter get iter => _staticInfo.callMethodOnReceiver('get_iter', this, []);
  bool get justify => _staticInfo.callMethodOnReceiver('get_justify', this, []);
  LayoutLine getLine(int line) => _staticInfo.callMethodOnReceiver('get_line', this, [line]);
  int get lineCount => _staticInfo.callMethodOnReceiver('get_line_count', this, []);
  LayoutLine getLineReadonly(int line) => _staticInfo.callMethodOnReceiver('get_line_readonly', this, [line]);
  SList /* this will fail */ get lines => _staticInfo.callMethodOnReceiver('get_lines', this, []);
  SList /* this will fail */ get linesReadonly => _staticInfo.callMethodOnReceiver('get_lines_readonly', this, []);
  List getLogAttrs() => _staticInfo.callMethodOnReceiver('get_log_attrs', this, []);
  List getLogAttrsReadonly() => _staticInfo.callMethodOnReceiver('get_log_attrs_readonly', this, []);
  List getPixelExtents() => _staticInfo.callMethodOnReceiver('get_pixel_extents', this, []);
  List getPixelSize() => _staticInfo.callMethodOnReceiver('get_pixel_size', this, []);
  int get serial => _staticInfo.callMethodOnReceiver('get_serial', this, []);
  bool get singleParagraphMode => _staticInfo.callMethodOnReceiver('get_single_paragraph_mode', this, []);
  List getSize() => _staticInfo.callMethodOnReceiver('get_size', this, []);
  int get spacing => _staticInfo.callMethodOnReceiver('get_spacing', this, []);
  TabArray get tabs => _staticInfo.callMethodOnReceiver('get_tabs', this, []);
  String get text => _staticInfo.callMethodOnReceiver('get_text', this, []);
  int get unknownGlyphsCount => _staticInfo.callMethodOnReceiver('get_unknown_glyphs_count', this, []);
  int get width => _staticInfo.callMethodOnReceiver('get_width', this, []);
  WrapMode get wrap => _staticInfo.callMethodOnReceiver('get_wrap', this, []);
  List indexToLineX(int index_, bool trailing) => _staticInfo.callMethodOnReceiver('index_to_line_x', this, [index_, trailing]);
  Rectangle indexToPos(int index_) => _staticInfo.callMethodOnReceiver('index_to_pos', this, [index_]);
  bool isEllipsized() => _staticInfo.callMethodOnReceiver('is_ellipsized', this, []);
  bool isWrapped() => _staticInfo.callMethodOnReceiver('is_wrapped', this, []);
  List moveCursorVisually(bool strong, int oldIndex, int oldTrailing, int direction) => _staticInfo.callMethodOnReceiver('move_cursor_visually', this, [strong, oldIndex, oldTrailing, direction]);
  void set alignment(Alignment alignment) => _staticInfo.callMethodOnReceiver('set_alignment', this, [alignment]);
  void set attributes(AttrList attrs) => _staticInfo.callMethodOnReceiver('set_attributes', this, [attrs]);
  void set autoDir(bool autoDir) => _staticInfo.callMethodOnReceiver('set_auto_dir', this, [autoDir]);
  void set ellipsize(EllipsizeMode ellipsize) => _staticInfo.callMethodOnReceiver('set_ellipsize', this, [ellipsize]);
  void set fontDescription(FontDescription desc) => _staticInfo.callMethodOnReceiver('set_font_description', this, [desc]);
  void set height(int height) => _staticInfo.callMethodOnReceiver('set_height', this, [height]);
  void set indent(int indent) => _staticInfo.callMethodOnReceiver('set_indent', this, [indent]);
  void set justify(bool justify) => _staticInfo.callMethodOnReceiver('set_justify', this, [justify]);
  void setMarkup(String markup, int length) => _staticInfo.callMethodOnReceiver('set_markup', this, [markup, length]);
  int setMarkupWithAccel(String markup, int length, int accelMarker) => _staticInfo.callMethodOnReceiver('set_markup_with_accel', this, [markup, length, accelMarker]);
  void set singleParagraphMode(bool setting) => _staticInfo.callMethodOnReceiver('set_single_paragraph_mode', this, [setting]);
  void set spacing(int spacing) => _staticInfo.callMethodOnReceiver('set_spacing', this, [spacing]);
  void set tabs(TabArray tabs) => _staticInfo.callMethodOnReceiver('set_tabs', this, [tabs]);
  void setText(String text, int length) => _staticInfo.callMethodOnReceiver('set_text', this, [text, length]);
  void set width(int width) => _staticInfo.callMethodOnReceiver('set_width', this, [width]);
  void set wrap(WrapMode wrap) => _staticInfo.callMethodOnReceiver('set_wrap', this, [wrap]);
  List xyToIndex(int x, int y) => _staticInfo.callMethodOnReceiver('xy_to_index', this, [x, y]);
}

class LayoutIter extends GObjectBase {
  LayoutIter.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'LayoutIter');

  bool atLastLine() => _staticInfo.callMethodOnReceiver('at_last_line', this, []);
  LayoutIter copy() => _staticInfo.callMethodOnReceiver('copy', this, []);
  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
  int get baseline => _staticInfo.callMethodOnReceiver('get_baseline', this, []);
  Rectangle get charExtents => _staticInfo.callMethodOnReceiver('get_char_extents', this, []);
  List getClusterExtents() => _staticInfo.callMethodOnReceiver('get_cluster_extents', this, []);
  int get index => _staticInfo.callMethodOnReceiver('get_index', this, []);
  Layout get layout => _staticInfo.callMethodOnReceiver('get_layout', this, []);
  List getLayoutExtents() => _staticInfo.callMethodOnReceiver('get_layout_extents', this, []);
  LayoutLine get line => _staticInfo.callMethodOnReceiver('get_line', this, []);
  List getLineExtents() => _staticInfo.callMethodOnReceiver('get_line_extents', this, []);
  LayoutLine get lineReadonly => _staticInfo.callMethodOnReceiver('get_line_readonly', this, []);
  List getLineYrange() => _staticInfo.callMethodOnReceiver('get_line_yrange', this, []);
  GlyphItem get run => _staticInfo.callMethodOnReceiver('get_run', this, []);
  List getRunExtents() => _staticInfo.callMethodOnReceiver('get_run_extents', this, []);
  GlyphItem get runReadonly => _staticInfo.callMethodOnReceiver('get_run_readonly', this, []);
  bool nextChar() => _staticInfo.callMethodOnReceiver('next_char', this, []);
  bool nextCluster() => _staticInfo.callMethodOnReceiver('next_cluster', this, []);
  bool nextLine() => _staticInfo.callMethodOnReceiver('next_line', this, []);
  bool nextRun() => _staticInfo.callMethodOnReceiver('next_run', this, []);
}

class LayoutLine extends GObjectBase {
  LayoutLine.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'LayoutLine');

  List getExtents() => _staticInfo.callMethodOnReceiver('get_extents', this, []);
  List getPixelExtents() => _staticInfo.callMethodOnReceiver('get_pixel_extents', this, []);
  List getXRanges(int startIndex, int endIndex) => _staticInfo.callMethodOnReceiver('get_x_ranges', this, [startIndex, endIndex]);
  int indexToX(int index_, bool trailing) => _staticInfo.callMethodOnReceiver('index_to_x', this, [index_, trailing]);
  LayoutLine ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
  List xToIndex(int xPos) => _staticInfo.callMethodOnReceiver('x_to_index', this, [xPos]);
  Layout get layout => getFieldOfObject('layout', 0);
  void set layout(Layout value) => setFieldOfObject('layout', 0, value);
  int get startIndex => getFieldOfObject('start_index', 1);
  void set startIndex(int value) => setFieldOfObject('start_index', 1, value);
  int get length => getFieldOfObject('length', 2);
  void set length(int value) => setFieldOfObject('length', 2, value);
  SList /* this will fail */ get runs => getFieldOfObject('runs', 3);
  void set runs(SList value /* this will fail */) => setFieldOfObject('runs', 3, value);
  int get isParagraphStart => getFieldOfObject('is_paragraph_start', 4);
  void set isParagraphStart(int value) => setFieldOfObject('is_paragraph_start', 4, value);
  int get resolvedDir => getFieldOfObject('resolved_dir', 5);
  void set resolvedDir(int value) => setFieldOfObject('resolved_dir', 5, value);
}

class LogAttr extends GObjectBase {
  LogAttr.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'LogAttr');

  int get isLineBreak => getFieldOfObject('is_line_break', 0);
  void set isLineBreak(int value) => setFieldOfObject('is_line_break', 0, value);
  int get isMandatoryBreak => getFieldOfObject('is_mandatory_break', 1);
  void set isMandatoryBreak(int value) => setFieldOfObject('is_mandatory_break', 1, value);
  int get isCharBreak => getFieldOfObject('is_char_break', 2);
  void set isCharBreak(int value) => setFieldOfObject('is_char_break', 2, value);
  int get isWhite => getFieldOfObject('is_white', 3);
  void set isWhite(int value) => setFieldOfObject('is_white', 3, value);
  int get isCursorPosition => getFieldOfObject('is_cursor_position', 4);
  void set isCursorPosition(int value) => setFieldOfObject('is_cursor_position', 4, value);
  int get isWordStart => getFieldOfObject('is_word_start', 5);
  void set isWordStart(int value) => setFieldOfObject('is_word_start', 5, value);
  int get isWordEnd => getFieldOfObject('is_word_end', 6);
  void set isWordEnd(int value) => setFieldOfObject('is_word_end', 6, value);
  int get isSentenceBoundary => getFieldOfObject('is_sentence_boundary', 7);
  void set isSentenceBoundary(int value) => setFieldOfObject('is_sentence_boundary', 7, value);
  int get isSentenceStart => getFieldOfObject('is_sentence_start', 8);
  void set isSentenceStart(int value) => setFieldOfObject('is_sentence_start', 8, value);
  int get isSentenceEnd => getFieldOfObject('is_sentence_end', 9);
  void set isSentenceEnd(int value) => setFieldOfObject('is_sentence_end', 9, value);
  int get backspaceDeletesCharacter => getFieldOfObject('backspace_deletes_character', 10);
  void set backspaceDeletesCharacter(int value) => setFieldOfObject('backspace_deletes_character', 10, value);
  int get isExpandableSpace => getFieldOfObject('is_expandable_space', 11);
  void set isExpandableSpace(int value) => setFieldOfObject('is_expandable_space', 11, value);
  int get isWordBoundary => getFieldOfObject('is_word_boundary', 12);
  void set isWordBoundary(int value) => setFieldOfObject('is_word_boundary', 12, value);
}

class Map extends GObjectBase {
  Map.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'Map');

}

class MapEntry extends GObjectBase {
  MapEntry.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'MapEntry');

}

class Matrix extends GObjectBase {
  Matrix.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'Matrix');

  void concat(Matrix newMatrix) => _staticInfo.callMethodOnReceiver('concat', this, [newMatrix]);
  Matrix copy() => _staticInfo.callMethodOnReceiver('copy', this, []);
  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
  num get fontScaleFactor => _staticInfo.callMethodOnReceiver('get_font_scale_factor', this, []);
  List getFontScaleFactors() => _staticInfo.callMethodOnReceiver('get_font_scale_factors', this, []);
  void rotate(num degrees) => _staticInfo.callMethodOnReceiver('rotate', this, [degrees]);
  void scale(num scaleX, num scaleY) => _staticInfo.callMethodOnReceiver('scale', this, [scaleX, scaleY]);
  List transformDistance(num dx, num dy) => _staticInfo.callMethodOnReceiver('transform_distance', this, [dx, dy]);
  Rectangle transformPixelRectangle(Rectangle rect) => _staticInfo.callMethodOnReceiver('transform_pixel_rectangle', this, [rect]);
  List transformPoint(num x, num y) => _staticInfo.callMethodOnReceiver('transform_point', this, [x, y]);
  Rectangle transformRectangle(Rectangle rect) => _staticInfo.callMethodOnReceiver('transform_rectangle', this, [rect]);
  void translate(num tx, num ty) => _staticInfo.callMethodOnReceiver('translate', this, [tx, ty]);
  num get xx => getFieldOfObject('xx', 0);
  void set xx(num value) => setFieldOfObject('xx', 0, value);
  num get xy => getFieldOfObject('xy', 1);
  void set xy(num value) => setFieldOfObject('xy', 1, value);
  num get yx => getFieldOfObject('yx', 2);
  void set yx(num value) => setFieldOfObject('yx', 2, value);
  num get yy => getFieldOfObject('yy', 3);
  void set yy(num value) => setFieldOfObject('yy', 3, value);
  num get x0 => getFieldOfObject('x0', 4);
  void set x0(num value) => setFieldOfObject('x0', 4, value);
  num get y0 => getFieldOfObject('y0', 5);
  void set y0(num value) => setFieldOfObject('y0', 5, value);
}

class Rectangle extends GObjectBase {
  Rectangle.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'Rectangle');

  int get x => getFieldOfObject('x', 0);
  void set x(int value) => setFieldOfObject('x', 0, value);
  int get y => getFieldOfObject('y', 1);
  void set y(int value) => setFieldOfObject('y', 1, value);
  int get width => getFieldOfObject('width', 2);
  void set width(int value) => setFieldOfObject('width', 2, value);
  int get height => getFieldOfObject('height', 3);
  void set height(int value) => setFieldOfObject('height', 3, value);
}

class RenderPart extends GEnumBase {
  const RenderPart(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'RenderPart');

  static const RenderPart FOREGROUND = const RenderPart(0);
  static const RenderPart BACKGROUND = const RenderPart(1);
  static const RenderPart UNDERLINE = const RenderPart(2);
  static const RenderPart STRIKETHROUGH = const RenderPart(3);
  String toString() {
    switch(index) {
      case 0: return 'RenderPart.FOREGROUND';
      case 1: return 'RenderPart.BACKGROUND';
      case 2: return 'RenderPart.UNDERLINE';
      case 3: return 'RenderPart.STRIKETHROUGH';
      default: return 'new RenderPart($index)';
    }
  }
}

class Renderer extends GObjectObject {
  Renderer.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'Renderer');

  void activate() => _staticInfo.callMethodOnReceiver('activate', this, []);
  void deactivate() => _staticInfo.callMethodOnReceiver('deactivate', this, []);
  void drawErrorUnderline(int x, int y, int width, int height) => _staticInfo.callMethodOnReceiver('draw_error_underline', this, [x, y, width, height]);
  void drawGlyph(Font font, int glyph, num x, num y) => _staticInfo.callMethodOnReceiver('draw_glyph', this, [font, glyph, x, y]);
  void drawGlyphItem(String text, GlyphItem glyphItem, int x, int y) => _staticInfo.callMethodOnReceiver('draw_glyph_item', this, [text, glyphItem, x, y]);
  void drawGlyphs(Font font, GlyphString glyphs, int x, int y) => _staticInfo.callMethodOnReceiver('draw_glyphs', this, [font, glyphs, x, y]);
  void drawLayout(Layout layout, int x, int y) => _staticInfo.callMethodOnReceiver('draw_layout', this, [layout, x, y]);
  void drawLayoutLine(LayoutLine line, int x, int y) => _staticInfo.callMethodOnReceiver('draw_layout_line', this, [line, x, y]);
  void drawRectangle(RenderPart part_, int x, int y, int width, int height) => _staticInfo.callMethodOnReceiver('draw_rectangle', this, [part_, x, y, width, height]);
  void drawTrapezoid(RenderPart part_, num y1_, num x11, num x21, num y2, num x12, num x22) => _staticInfo.callMethodOnReceiver('draw_trapezoid', this, [part_, y1_, x11, x21, y2, x12, x22]);
  int getAlpha(RenderPart part_) => _staticInfo.callMethodOnReceiver('get_alpha', this, [part_]);
  Color getColor(RenderPart part_) => _staticInfo.callMethodOnReceiver('get_color', this, [part_]);
  Layout get layout => _staticInfo.callMethodOnReceiver('get_layout', this, []);
  LayoutLine get layoutLine => _staticInfo.callMethodOnReceiver('get_layout_line', this, []);
  Matrix get matrix => _staticInfo.callMethodOnReceiver('get_matrix', this, []);
  void partChanged(RenderPart part_) => _staticInfo.callMethodOnReceiver('part_changed', this, [part_]);
  void setAlpha(RenderPart part_, int alpha) => _staticInfo.callMethodOnReceiver('set_alpha', this, [part_, alpha]);
  void setColor(RenderPart part_, Color color) => _staticInfo.callMethodOnReceiver('set_color', this, [part_, color]);
  void set matrix(Matrix matrix) => _staticInfo.callMethodOnReceiver('set_matrix', this, [matrix]);
  Underline get underline => getFieldOfObject('underline', 1);
  bool get strikethrough => getFieldOfObject('strikethrough', 2);
  int get activeCount => getFieldOfObject('active_count', 3);
  RendererPrivate get priv => getFieldOfObject('priv', 5);
}

class RendererPrivate extends GObjectBase {
  RendererPrivate.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'RendererPrivate');

}

class Script extends GEnumBase {
  const Script(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'Script');

  static const Script INVALID_CODE = const Script(-1);
  static const Script COMMON = const Script(0);
  static const Script INHERITED = const Script(1);
  static const Script ARABIC = const Script(2);
  static const Script ARMENIAN = const Script(3);
  static const Script BENGALI = const Script(4);
  static const Script BOPOMOFO = const Script(5);
  static const Script CHEROKEE = const Script(6);
  static const Script COPTIC = const Script(7);
  static const Script CYRILLIC = const Script(8);
  static const Script DESERET = const Script(9);
  static const Script DEVANAGARI = const Script(10);
  static const Script ETHIOPIC = const Script(11);
  static const Script GEORGIAN = const Script(12);
  static const Script GOTHIC = const Script(13);
  static const Script GREEK = const Script(14);
  static const Script GUJARATI = const Script(15);
  static const Script GURMUKHI = const Script(16);
  static const Script HAN = const Script(17);
  static const Script HANGUL = const Script(18);
  static const Script HEBREW = const Script(19);
  static const Script HIRAGANA = const Script(20);
  static const Script KANNADA = const Script(21);
  static const Script KATAKANA = const Script(22);
  static const Script KHMER = const Script(23);
  static const Script LAO = const Script(24);
  static const Script LATIN = const Script(25);
  static const Script MALAYALAM = const Script(26);
  static const Script MONGOLIAN = const Script(27);
  static const Script MYANMAR = const Script(28);
  static const Script OGHAM = const Script(29);
  static const Script OLD_ITALIC = const Script(30);
  static const Script ORIYA = const Script(31);
  static const Script RUNIC = const Script(32);
  static const Script SINHALA = const Script(33);
  static const Script SYRIAC = const Script(34);
  static const Script TAMIL = const Script(35);
  static const Script TELUGU = const Script(36);
  static const Script THAANA = const Script(37);
  static const Script THAI = const Script(38);
  static const Script TIBETAN = const Script(39);
  static const Script CANADIAN_ABORIGINAL = const Script(40);
  static const Script YI = const Script(41);
  static const Script TAGALOG = const Script(42);
  static const Script HANUNOO = const Script(43);
  static const Script BUHID = const Script(44);
  static const Script TAGBANWA = const Script(45);
  static const Script BRAILLE = const Script(46);
  static const Script CYPRIOT = const Script(47);
  static const Script LIMBU = const Script(48);
  static const Script OSMANYA = const Script(49);
  static const Script SHAVIAN = const Script(50);
  static const Script LINEAR_B = const Script(51);
  static const Script TAI_LE = const Script(52);
  static const Script UGARITIC = const Script(53);
  static const Script NEW_TAI_LUE = const Script(54);
  static const Script BUGINESE = const Script(55);
  static const Script GLAGOLITIC = const Script(56);
  static const Script TIFINAGH = const Script(57);
  static const Script SYLOTI_NAGRI = const Script(58);
  static const Script OLD_PERSIAN = const Script(59);
  static const Script KHAROSHTHI = const Script(60);
  static const Script UNKNOWN = const Script(61);
  static const Script BALINESE = const Script(62);
  static const Script CUNEIFORM = const Script(63);
  static const Script PHOENICIAN = const Script(64);
  static const Script PHAGS_PA = const Script(65);
  static const Script NKO = const Script(66);
  static const Script KAYAH_LI = const Script(67);
  static const Script LEPCHA = const Script(68);
  static const Script REJANG = const Script(69);
  static const Script SUNDANESE = const Script(70);
  static const Script SAURASHTRA = const Script(71);
  static const Script CHAM = const Script(72);
  static const Script OL_CHIKI = const Script(73);
  static const Script VAI = const Script(74);
  static const Script CARIAN = const Script(75);
  static const Script LYCIAN = const Script(76);
  static const Script LYDIAN = const Script(77);
  static const Script BATAK = const Script(78);
  static const Script BRAHMI = const Script(79);
  static const Script MANDAIC = const Script(80);
  static const Script CHAKMA = const Script(81);
  static const Script MEROITIC_CURSIVE = const Script(82);
  static const Script MEROITIC_HIEROGLYPHS = const Script(83);
  static const Script MIAO = const Script(84);
  static const Script SHARADA = const Script(85);
  static const Script SORA_SOMPENG = const Script(86);
  static const Script TAKRI = const Script(87);
  String toString() {
    switch(index) {
      case -1: return 'Script.INVALID_CODE';
      case 0: return 'Script.COMMON';
      case 1: return 'Script.INHERITED';
      case 2: return 'Script.ARABIC';
      case 3: return 'Script.ARMENIAN';
      case 4: return 'Script.BENGALI';
      case 5: return 'Script.BOPOMOFO';
      case 6: return 'Script.CHEROKEE';
      case 7: return 'Script.COPTIC';
      case 8: return 'Script.CYRILLIC';
      case 9: return 'Script.DESERET';
      case 10: return 'Script.DEVANAGARI';
      case 11: return 'Script.ETHIOPIC';
      case 12: return 'Script.GEORGIAN';
      case 13: return 'Script.GOTHIC';
      case 14: return 'Script.GREEK';
      case 15: return 'Script.GUJARATI';
      case 16: return 'Script.GURMUKHI';
      case 17: return 'Script.HAN';
      case 18: return 'Script.HANGUL';
      case 19: return 'Script.HEBREW';
      case 20: return 'Script.HIRAGANA';
      case 21: return 'Script.KANNADA';
      case 22: return 'Script.KATAKANA';
      case 23: return 'Script.KHMER';
      case 24: return 'Script.LAO';
      case 25: return 'Script.LATIN';
      case 26: return 'Script.MALAYALAM';
      case 27: return 'Script.MONGOLIAN';
      case 28: return 'Script.MYANMAR';
      case 29: return 'Script.OGHAM';
      case 30: return 'Script.OLD_ITALIC';
      case 31: return 'Script.ORIYA';
      case 32: return 'Script.RUNIC';
      case 33: return 'Script.SINHALA';
      case 34: return 'Script.SYRIAC';
      case 35: return 'Script.TAMIL';
      case 36: return 'Script.TELUGU';
      case 37: return 'Script.THAANA';
      case 38: return 'Script.THAI';
      case 39: return 'Script.TIBETAN';
      case 40: return 'Script.CANADIAN_ABORIGINAL';
      case 41: return 'Script.YI';
      case 42: return 'Script.TAGALOG';
      case 43: return 'Script.HANUNOO';
      case 44: return 'Script.BUHID';
      case 45: return 'Script.TAGBANWA';
      case 46: return 'Script.BRAILLE';
      case 47: return 'Script.CYPRIOT';
      case 48: return 'Script.LIMBU';
      case 49: return 'Script.OSMANYA';
      case 50: return 'Script.SHAVIAN';
      case 51: return 'Script.LINEAR_B';
      case 52: return 'Script.TAI_LE';
      case 53: return 'Script.UGARITIC';
      case 54: return 'Script.NEW_TAI_LUE';
      case 55: return 'Script.BUGINESE';
      case 56: return 'Script.GLAGOLITIC';
      case 57: return 'Script.TIFINAGH';
      case 58: return 'Script.SYLOTI_NAGRI';
      case 59: return 'Script.OLD_PERSIAN';
      case 60: return 'Script.KHAROSHTHI';
      case 61: return 'Script.UNKNOWN';
      case 62: return 'Script.BALINESE';
      case 63: return 'Script.CUNEIFORM';
      case 64: return 'Script.PHOENICIAN';
      case 65: return 'Script.PHAGS_PA';
      case 66: return 'Script.NKO';
      case 67: return 'Script.KAYAH_LI';
      case 68: return 'Script.LEPCHA';
      case 69: return 'Script.REJANG';
      case 70: return 'Script.SUNDANESE';
      case 71: return 'Script.SAURASHTRA';
      case 72: return 'Script.CHAM';
      case 73: return 'Script.OL_CHIKI';
      case 74: return 'Script.VAI';
      case 75: return 'Script.CARIAN';
      case 76: return 'Script.LYCIAN';
      case 77: return 'Script.LYDIAN';
      case 78: return 'Script.BATAK';
      case 79: return 'Script.BRAHMI';
      case 80: return 'Script.MANDAIC';
      case 81: return 'Script.CHAKMA';
      case 82: return 'Script.MEROITIC_CURSIVE';
      case 83: return 'Script.MEROITIC_HIEROGLYPHS';
      case 84: return 'Script.MIAO';
      case 85: return 'Script.SHARADA';
      case 86: return 'Script.SORA_SOMPENG';
      case 87: return 'Script.TAKRI';
      default: return 'new Script($index)';
    }
  }
  static Script forUnichar(int ch) => _staticInfo.callStatic('for_unichar', [ch]);
  static Language getSampleLanguage(Script script) => _staticInfo.callStatic('get_sample_language', [script]);
}

class ScriptForLang extends GObjectBase {
  ScriptForLang.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'ScriptForLang');

  List<int> get lang => getFieldOfObject('lang', 0);
  void set lang(List<int> value) => setFieldOfObject('lang', 0, value);
  List<Script> get scripts => getFieldOfObject('scripts', 1);
  void set scripts(List<Script> value) => setFieldOfObject('scripts', 1, value);
}

class ScriptIter extends GObjectBase {
  ScriptIter.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'ScriptIter');

  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
  List getRange() => _staticInfo.callMethodOnReceiver('get_range', this, []);
  bool next() => _staticInfo.callMethodOnReceiver('next', this, []);
}

class Stretch extends GEnumBase {
  const Stretch(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'Stretch');

  static const Stretch ULTRA_CONDENSED = const Stretch(0);
  static const Stretch EXTRA_CONDENSED = const Stretch(1);
  static const Stretch CONDENSED = const Stretch(2);
  static const Stretch SEMI_CONDENSED = const Stretch(3);
  static const Stretch NORMAL = const Stretch(4);
  static const Stretch SEMI_EXPANDED = const Stretch(5);
  static const Stretch EXPANDED = const Stretch(6);
  static const Stretch EXTRA_EXPANDED = const Stretch(7);
  static const Stretch ULTRA_EXPANDED = const Stretch(8);
  String toString() {
    switch(index) {
      case 0: return 'Stretch.ULTRA_CONDENSED';
      case 1: return 'Stretch.EXTRA_CONDENSED';
      case 2: return 'Stretch.CONDENSED';
      case 3: return 'Stretch.SEMI_CONDENSED';
      case 4: return 'Stretch.NORMAL';
      case 5: return 'Stretch.SEMI_EXPANDED';
      case 6: return 'Stretch.EXPANDED';
      case 7: return 'Stretch.EXTRA_EXPANDED';
      case 8: return 'Stretch.ULTRA_EXPANDED';
      default: return 'new Stretch($index)';
    }
  }
}

class Style extends GEnumBase {
  const Style(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'Style');

  static const Style NORMAL = const Style(0);
  static const Style OBLIQUE = const Style(1);
  static const Style ITALIC = const Style(2);
  String toString() {
    switch(index) {
      case 0: return 'Style.NORMAL';
      case 1: return 'Style.OBLIQUE';
      case 2: return 'Style.ITALIC';
      default: return 'new Style($index)';
    }
  }
}

class TabAlign extends GEnumBase {
  const TabAlign(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'TabAlign');

  static const TabAlign LEFT = const TabAlign(0);
  String toString() {
    switch(index) {
      case 0: return 'TabAlign.LEFT';
      default: return 'new TabAlign($index)';
    }
  }
}

class TabArray extends GObjectBase {
  TabArray.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'TabArray');

  factory TabArray(int initialSize, bool positionsInPixels) => _staticInfo.callStatic('new', [initialSize, positionsInPixels]);
  TabArray copy() => _staticInfo.callMethodOnReceiver('copy', this, []);
  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
  bool get positionsInPixels => _staticInfo.callMethodOnReceiver('get_positions_in_pixels', this, []);
  int get size => _staticInfo.callMethodOnReceiver('get_size', this, []);
  List getTab(int tabIndex) => _staticInfo.callMethodOnReceiver('get_tab', this, [tabIndex]);
  List getTabs() => _staticInfo.callMethodOnReceiver('get_tabs', this, []);
  void resize(int newSize) => _staticInfo.callMethodOnReceiver('resize', this, [newSize]);
  void setTab(int tabIndex, TabAlign alignment, int location) => _staticInfo.callMethodOnReceiver('set_tab', this, [tabIndex, alignment, location]);
}

class Underline extends GEnumBase {
  const Underline(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'Underline');

  static const Underline NONE = const Underline(0);
  static const Underline SINGLE = const Underline(1);
  static const Underline DOUBLE = const Underline(2);
  static const Underline LOW = const Underline(3);
  static const Underline ERROR = const Underline(4);
  String toString() {
    switch(index) {
      case 0: return 'Underline.NONE';
      case 1: return 'Underline.SINGLE';
      case 2: return 'Underline.DOUBLE';
      case 3: return 'Underline.LOW';
      case 4: return 'Underline.ERROR';
      default: return 'new Underline($index)';
    }
  }
}

class Variant extends GEnumBase {
  const Variant(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'Variant');

  static const Variant NORMAL = const Variant(0);
  static const Variant SMALL_CAPS = const Variant(1);
  String toString() {
    switch(index) {
      case 0: return 'Variant.NORMAL';
      case 1: return 'Variant.SMALL_CAPS';
      default: return 'new Variant($index)';
    }
  }
}

class Weight extends GEnumBase {
  const Weight(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'Weight');

  static const Weight THIN = const Weight(100);
  static const Weight ULTRALIGHT = const Weight(200);
  static const Weight LIGHT = const Weight(300);
  static const Weight SEMILIGHT = const Weight(350);
  static const Weight BOOK = const Weight(380);
  static const Weight NORMAL = const Weight(400);
  static const Weight MEDIUM = const Weight(500);
  static const Weight SEMIBOLD = const Weight(600);
  static const Weight BOLD = const Weight(700);
  static const Weight ULTRABOLD = const Weight(800);
  static const Weight HEAVY = const Weight(900);
  static const Weight ULTRAHEAVY = const Weight(1000);
  String toString() {
    switch(index) {
      case 100: return 'Weight.THIN';
      case 200: return 'Weight.ULTRALIGHT';
      case 300: return 'Weight.LIGHT';
      case 350: return 'Weight.SEMILIGHT';
      case 380: return 'Weight.BOOK';
      case 400: return 'Weight.NORMAL';
      case 500: return 'Weight.MEDIUM';
      case 600: return 'Weight.SEMIBOLD';
      case 700: return 'Weight.BOLD';
      case 800: return 'Weight.ULTRABOLD';
      case 900: return 'Weight.HEAVY';
      case 1000: return 'Weight.ULTRAHEAVY';
      default: return 'new Weight($index)';
    }
  }
}

class WrapMode extends GEnumBase {
  const WrapMode(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Pango', 'WrapMode');

  static const WrapMode WORD = const WrapMode(0);
  static const WrapMode CHAR = const WrapMode(1);
  static const WrapMode WORD_CHAR = const WrapMode(2);
  String toString() {
    switch(index) {
      case 0: return 'WrapMode.WORD';
      case 1: return 'WrapMode.CHAR';
      case 2: return 'WrapMode.WORD_CHAR';
      default: return 'new WrapMode($index)';
    }
  }
}

String attrTypeGetName(AttrType type) => callStaticGlobal('Pango', 'attr_type_get_name', [type]);

AttrType attrTypeRegister(String name) => callStaticGlobal('Pango', 'attr_type_register', [name]);

BidiType bidiTypeForUnichar(int ch) => callStaticGlobal('Pango', 'bidi_type_for_unichar', [ch]);

void break_(String text, int length, Analysis analysis, List<LogAttr> attrs) => callStaticGlobal('Pango', 'break', [text, length, analysis, attrs]);

String configKeyGet(String key) => callStaticGlobal('Pango', 'config_key_get', [key]);

String configKeyGetSystem(String key) => callStaticGlobal('Pango', 'config_key_get_system', [key]);

void defaultBreak(String text, int length, Analysis analysis, LogAttr attrs, int attrsLen) => callStaticGlobal('Pango', 'default_break', [text, length, analysis, attrs, attrsLen]);

void extentsToPixels(Rectangle inclusive, Rectangle nearest) => callStaticGlobal('Pango', 'extents_to_pixels', [inclusive, nearest]);

Direction findBaseDir(String text, int length) => callStaticGlobal('Pango', 'find_base_dir', [text, length]);

List findParagraphBoundary(String text, int length) => callStaticGlobal('Pango', 'find_paragraph_boundary', [text, length]);

FontDescription fontDescriptionFromString(String str) => callStaticGlobal('Pango', 'font_description_from_string', [str]);

String getLibSubdirectory() => callStaticGlobal('Pango', 'get_lib_subdirectory', []);

void getLogAttrs(String text, int length, int level, Language language, List<LogAttr> logAttrs) => callStaticGlobal('Pango', 'get_log_attrs', [text, length, level, language, logAttrs]);

bool getMirrorChar(int ch, int mirroredCh) => callStaticGlobal('Pango', 'get_mirror_char', [ch, mirroredCh]);

String getSysconfSubdirectory() => callStaticGlobal('Pango', 'get_sysconf_subdirectory', []);

Gravity gravityGetForMatrix(Matrix matrix) => callStaticGlobal('Pango', 'gravity_get_for_matrix', [matrix]);

Gravity gravityGetForScript(Script script, Gravity baseGravity, GravityHint hint) => callStaticGlobal('Pango', 'gravity_get_for_script', [script, baseGravity, hint]);

Gravity gravityGetForScriptAndWidth(Script script, bool wide, Gravity baseGravity, GravityHint hint) => callStaticGlobal('Pango', 'gravity_get_for_script_and_width', [script, wide, baseGravity, hint]);

num gravityToRotation(Gravity gravity) => callStaticGlobal('Pango', 'gravity_to_rotation', [gravity]);

bool isZeroWidth(int ch) => callStaticGlobal('Pango', 'is_zero_width', [ch]);

GLibList /* this will fail */ itemize(Context context, String text, int startIndex, int length, AttrList attrs, AttrIterator cachedIter) => callStaticGlobal('Pango', 'itemize', [context, text, startIndex, length, attrs, cachedIter]);

GLibList /* this will fail */ itemizeWithBaseDir(Context context, Direction baseDir, String text, int startIndex, int length, AttrList attrs, AttrIterator cachedIter) => callStaticGlobal('Pango', 'itemize_with_base_dir', [context, baseDir, text, startIndex, length, attrs, cachedIter]);

Language languageFromString(String language) => callStaticGlobal('Pango', 'language_from_string', [language]);

Language languageGetDefault() => callStaticGlobal('Pango', 'language_get_default', []);

int log2visGetEmbeddingLevels(String text, int length, Direction pbaseDir) => callStaticGlobal('Pango', 'log2vis_get_embedding_levels', [text, length, pbaseDir]);

List lookupAliases(String fontname) => callStaticGlobal('Pango', 'lookup_aliases', [fontname]);

List markupParserFinish(MarkupParseContext context) => callStaticGlobal('Pango', 'markup_parser_finish', [context]);

MarkupParseContext markupParserNew(int accelMarker) => callStaticGlobal('Pango', 'markup_parser_new', [accelMarker]);

void moduleRegister(IncludedModule module) => callStaticGlobal('Pango', 'module_register', [module]);

List parseEnum(int type, String str, bool warn) => callStaticGlobal('Pango', 'parse_enum', [type, str, warn]);

List parseMarkup(String markupText, int length, int accelMarker) => callStaticGlobal('Pango', 'parse_markup', [markupText, length, accelMarker]);

List parseStretch(String str, bool warn) => callStaticGlobal('Pango', 'parse_stretch', [str, warn]);

List parseStyle(String str, bool warn) => callStaticGlobal('Pango', 'parse_style', [str, warn]);

List parseVariant(String str, bool warn) => callStaticGlobal('Pango', 'parse_variant', [str, warn]);

List parseWeight(String str, bool warn) => callStaticGlobal('Pango', 'parse_weight', [str, warn]);

List quantizeLineGeometry(int thickness, int position) => callStaticGlobal('Pango', 'quantize_line_geometry', [thickness, position]);

List readLine(dynamic stream /* this will fail */) => callStaticGlobal('Pango', 'read_line', [stream]);

GLibList /* this will fail */ reorderItems(GLibList logicalItems /* this will fail */) => callStaticGlobal('Pango', 'reorder_items', [logicalItems]);

List scanInt(String pos) => callStaticGlobal('Pango', 'scan_int', [pos]);

List scanString(String pos) => callStaticGlobal('Pango', 'scan_string', [pos]);

List scanWord(String pos) => callStaticGlobal('Pango', 'scan_word', [pos]);

Script scriptForUnichar(int ch) => callStaticGlobal('Pango', 'script_for_unichar', [ch]);

Language scriptGetSampleLanguage(Script script) => callStaticGlobal('Pango', 'script_get_sample_language', [script]);

void shape(String text, int length, Analysis analysis, GlyphString glyphs) => callStaticGlobal('Pango', 'shape', [text, length, analysis, glyphs]);

void shapeFull(String itemText, int itemLength, String paragraphText, int paragraphLength, Analysis analysis, GlyphString glyphs) => callStaticGlobal('Pango', 'shape_full', [itemText, itemLength, paragraphText, paragraphLength, analysis, glyphs]);

List skipSpace(String pos) => callStaticGlobal('Pango', 'skip_space', [pos]);

List<String> splitFileList(String str) => callStaticGlobal('Pango', 'split_file_list', [str]);

String trimString(String str) => callStaticGlobal('Pango', 'trim_string', [str]);

Direction unicharDirection(int ch) => callStaticGlobal('Pango', 'unichar_direction', [ch]);

int unitsFromDouble(num d) => callStaticGlobal('Pango', 'units_from_double', [d]);

num unitsToDouble(int i) => callStaticGlobal('Pango', 'units_to_double', [i]);

int version() => callStaticGlobal('Pango', 'version', []);

String versionCheck(int requiredMajor, int requiredMinor, int requiredMicro) => callStaticGlobal('Pango', 'version_check', [requiredMajor, requiredMinor, requiredMicro]);

String versionString() => callStaticGlobal('Pango', 'version_string', []);

bool _initLibraryStarted = false;

void initLibrary() {
  if (_initLibraryStarted) return;
  _initLibraryStarted = true;
  cairo.initLibrary();
  gobject.initLibrary();
  registerInterceptorTypeForNamedType("Pango", "Alignment",Alignment);
  registerInterceptorTypeForNamedType("Pango", "Analysis",Analysis);
  registerInterceptorTypeForNamedType("Pango", "AttrClass",AttrClass);
  registerInterceptorTypeForNamedType("Pango", "AttrColor",AttrColor);
  registerInterceptorTypeForNamedType("Pango", "AttrFloat",AttrFloat);
  registerInterceptorTypeForNamedType("Pango", "AttrFontDesc",AttrFontDesc);
  registerInterceptorTypeForNamedType("Pango", "AttrFontFeatures",AttrFontFeatures);
  registerInterceptorTypeForNamedType("Pango", "AttrInt",AttrInt);
  registerInterceptorTypeForNamedType("Pango", "AttrIterator",AttrIterator);
  registerInterceptorTypeForNamedType("Pango", "AttrLanguage",AttrLanguage);
  registerInterceptorTypeForNamedType("Pango", "AttrList",AttrList);
  registerInterceptorTypeForNamedType("Pango", "AttrShape",AttrShape);
  registerInterceptorTypeForNamedType("Pango", "AttrSize",AttrSize);
  registerInterceptorTypeForNamedType("Pango", "AttrString",AttrString);
  registerInterceptorTypeForNamedType("Pango", "AttrType",AttrType);
  registerInterceptorTypeForNamedType("Pango", "Attribute",Attribute);
  registerInterceptorTypeForNamedType("Pango", "BidiType",BidiType);
  registerInterceptorTypeForNamedType("Pango", "Color",Color);
  registerInterceptorTypeForNamedType("Pango", "Context",Context);
  registerInterceptorTypeForNamedType("Pango", "Coverage",Coverage);
  registerInterceptorTypeForNamedType("Pango", "CoverageLevel",CoverageLevel);
  registerInterceptorTypeForNamedType("Pango", "Direction",Direction);
  registerInterceptorTypeForNamedType("Pango", "EllipsizeMode",EllipsizeMode);
  registerInterceptorTypeForNamedType("Pango", "Engine",Engine);
  registerInterceptorTypeForNamedType("Pango", "EngineInfo",EngineInfo);
  registerInterceptorTypeForNamedType("Pango", "EngineLang",EngineLang);
  registerInterceptorTypeForNamedType("Pango", "EngineScriptInfo",EngineScriptInfo);
  registerInterceptorTypeForNamedType("Pango", "EngineShape",EngineShape);
  registerInterceptorTypeForNamedType("Pango", "Font",Font);
  registerInterceptorTypeForNamedType("Pango", "FontDescription",FontDescription);
  registerInterceptorTypeForNamedType("Pango", "FontFace",FontFace);
  registerInterceptorTypeForNamedType("Pango", "FontFamily",FontFamily);
  registerInterceptorTypeForNamedType("Pango", "FontMap",FontMap);
  registerInterceptorTypeForNamedType("Pango", "FontMask",FontMask);
  registerInterceptorTypeForNamedType("Pango", "FontMetrics",FontMetrics);
  registerInterceptorTypeForNamedType("Pango", "Fontset",Fontset);
  registerInterceptorTypeForNamedType("Pango", "FontsetSimple",FontsetSimple);
  registerInterceptorTypeForNamedType("Pango", "GlyphGeometry",GlyphGeometry);
  registerInterceptorTypeForNamedType("Pango", "GlyphInfo",GlyphInfo);
  registerInterceptorTypeForNamedType("Pango", "GlyphItem",GlyphItem);
  registerInterceptorTypeForNamedType("Pango", "GlyphItemIter",GlyphItemIter);
  registerInterceptorTypeForNamedType("Pango", "GlyphString",GlyphString);
  registerInterceptorTypeForNamedType("Pango", "GlyphVisAttr",GlyphVisAttr);
  registerInterceptorTypeForNamedType("Pango", "Gravity",Gravity);
  registerInterceptorTypeForNamedType("Pango", "GravityHint",GravityHint);
  registerInterceptorTypeForNamedType("Pango", "IncludedModule",IncludedModule);
  registerInterceptorTypeForNamedType("Pango", "Item",Item);
  registerInterceptorTypeForNamedType("Pango", "Language",Language);
  registerInterceptorTypeForNamedType("Pango", "Layout",Layout);
  registerInterceptorTypeForNamedType("Pango", "LayoutIter",LayoutIter);
  registerInterceptorTypeForNamedType("Pango", "LayoutLine",LayoutLine);
  registerInterceptorTypeForNamedType("Pango", "LogAttr",LogAttr);
  registerInterceptorTypeForNamedType("Pango", "Map",Map);
  registerInterceptorTypeForNamedType("Pango", "MapEntry",MapEntry);
  registerInterceptorTypeForNamedType("Pango", "Matrix",Matrix);
  registerInterceptorTypeForNamedType("Pango", "Rectangle",Rectangle);
  registerInterceptorTypeForNamedType("Pango", "RenderPart",RenderPart);
  registerInterceptorTypeForNamedType("Pango", "Renderer",Renderer);
  registerInterceptorTypeForNamedType("Pango", "RendererPrivate",RendererPrivate);
  registerInterceptorTypeForNamedType("Pango", "Script",Script);
  registerInterceptorTypeForNamedType("Pango", "ScriptForLang",ScriptForLang);
  registerInterceptorTypeForNamedType("Pango", "ScriptIter",ScriptIter);
  registerInterceptorTypeForNamedType("Pango", "Stretch",Stretch);
  registerInterceptorTypeForNamedType("Pango", "Style",Style);
  registerInterceptorTypeForNamedType("Pango", "TabAlign",TabAlign);
  registerInterceptorTypeForNamedType("Pango", "TabArray",TabArray);
  registerInterceptorTypeForNamedType("Pango", "Underline",Underline);
  registerInterceptorTypeForNamedType("Pango", "Variant",Variant);
  registerInterceptorTypeForNamedType("Pango", "Weight",Weight);
  registerInterceptorTypeForNamedType("Pango", "WrapMode",WrapMode);
}
