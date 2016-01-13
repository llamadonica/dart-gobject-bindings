library atk.gdart;

import "gdart.dart";

import "dart:async";

import "glib.dart" hide initLibrary;
import "gobject.dart" hide initLibrary;
import "gobject.dart" as gobject;

abstract class Action extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'Action');

  dynamic getGProperty(String name);
  void setGProperty(String name, dynamic value);
  bool doAction(int i) => _staticInfo.callMethodOnReceiver('do_action', this, [i]);
  String getDescription(int i) => _staticInfo.callMethodOnReceiver('get_description', this, [i]);
  String getKeybinding(int i) => _staticInfo.callMethodOnReceiver('get_keybinding', this, [i]);
  String getLocalizedName(int i) => _staticInfo.callMethodOnReceiver('get_localized_name', this, [i]);
  int get nActions => _staticInfo.callMethodOnReceiver('get_n_actions', this, []);
  String getName(int i) => _staticInfo.callMethodOnReceiver('get_name', this, [i]);
  bool setDescription(int i, String desc) => _staticInfo.callMethodOnReceiver('set_description', this, [i, desc]);
}

class Attribute extends GObjectBase {
  Attribute.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'Attribute');

  static void setFree(SList attribSet /* this will fail */) => _staticInfo.callStatic('set_free', [attribSet]);
  String get name => getFieldOfObject('name', 0);
  void set name(String value) => setFieldOfObject('name', 0, value);
  String get value => getFieldOfObject('value', 1);
  void set value(String value) => setFieldOfObject('value', 1, value);
}

abstract class Component extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'Component');

  dynamic getGProperty(String name);
  void setGProperty(String name, dynamic value);
  bool contains(int x, int y, CoordType coordType) => _staticInfo.callMethodOnReceiver('contains', this, [x, y, coordType]);
  num get alpha => _staticInfo.callMethodOnReceiver('get_alpha', this, []);
  void getExtents(int x, int y, int width, int height, CoordType coordType) => _staticInfo.callMethodOnReceiver('get_extents', this, [x, y, width, height, coordType]);
  Layer get layer => _staticInfo.callMethodOnReceiver('get_layer', this, []);
  int get mdiZorder => _staticInfo.callMethodOnReceiver('get_mdi_zorder', this, []);
  void getComponentPosition(int x, int y, CoordType coordType) => _staticInfo.callMethodOnReceiver('get_position', this, [x, y, coordType]);
  void getSize(int width, int height) => _staticInfo.callMethodOnReceiver('get_size', this, [width, height]);
  bool grabFocus() => _staticInfo.callMethodOnReceiver('grab_focus', this, []);
  AtkObject refAccessibleAtPoint(int x, int y, CoordType coordType) => _staticInfo.callMethodOnReceiver('ref_accessible_at_point', this, [x, y, coordType]);
  void removeFocusHandler(int handlerId) => _staticInfo.callMethodOnReceiver('remove_focus_handler', this, [handlerId]);
  bool setExtents(int x, int y, int width, int height, CoordType coordType) => _staticInfo.callMethodOnReceiver('set_extents', this, [x, y, width, height, coordType]);
  bool setPosition(int x, int y, CoordType coordType) => _staticInfo.callMethodOnReceiver('set_position', this, [x, y, coordType]);
  bool setSize(int width, int height) => _staticInfo.callMethodOnReceiver('set_size', this, [width, height]);
  int _connectToBoundsChanged(bool after, void func(Rectangle arg1)) => signalConnect('bounds-changed', func, after);
  Stream<Rectangle> get onBoundsChanged {
    int signalId;
    StreamController<Rectangle> controller;
    controller = new StreamController<Rectangle>(
      onListen: () {
          signalId = _connectToBoundsChanged(false, (Rectangle arg1) {
              controller.add(arg1);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<Rectangle> get afterBoundsChanged {
    int signalId;
    StreamController<Rectangle> controller;
    controller = new StreamController<Rectangle>(
      onListen: () {
          signalId = _connectToBoundsChanged(true, (Rectangle arg1) {
              controller.add(arg1);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
}

class CoordType extends GEnumBase {
  const CoordType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'CoordType');

  static const CoordType SCREEN = const CoordType(0);
  static const CoordType WINDOW = const CoordType(1);
  String toString() {
    switch(value) {
      case 0: return 'CoordType.SCREEN';
      case 1: return 'CoordType.WINDOW';
      default: return 'new CoordType($value)';
    }
  }
}

abstract class Document extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'Document');

  dynamic getGProperty(String name);
  void setGProperty(String name, dynamic value);
  String getAttributeValue(String attributeName) => _staticInfo.callMethodOnReceiver('get_attribute_value', this, [attributeName]);
  SList /* this will fail */ get attributes => _staticInfo.callMethodOnReceiver('get_attributes', this, []);
  int get currentPageNumber => _staticInfo.callMethodOnReceiver('get_current_page_number', this, []);
  void getDocument() => _staticInfo.callMethodOnReceiver('get_document', this, []);
  String get documentType => _staticInfo.callMethodOnReceiver('get_document_type', this, []);
  String get locale => _staticInfo.callMethodOnReceiver('get_locale', this, []);
  int get pageCount => _staticInfo.callMethodOnReceiver('get_page_count', this, []);
  bool setAttributeValue(String attributeName, String attributeValue) => _staticInfo.callMethodOnReceiver('set_attribute_value', this, [attributeName, attributeValue]);
  int _connectToLoadComplete(bool after, void func()) => signalConnect('load-complete', func, after);
  Stream get onLoadComplete {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToLoadComplete(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterLoadComplete {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToLoadComplete(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToLoadStopped(bool after, void func()) => signalConnect('load-stopped', func, after);
  Stream get onLoadStopped {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToLoadStopped(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterLoadStopped {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToLoadStopped(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToPageChanged(bool after, void func(int pageNumber)) => signalConnect('page-changed', func, after);
  Stream<int> get onPageChanged {
    int signalId;
    StreamController<int> controller;
    controller = new StreamController<int>(
      onListen: () {
          signalId = _connectToPageChanged(false, (int pageNumber) {
              controller.add(pageNumber);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<int> get afterPageChanged {
    int signalId;
    StreamController<int> controller;
    controller = new StreamController<int>(
      onListen: () {
          signalId = _connectToPageChanged(true, (int pageNumber) {
              controller.add(pageNumber);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToReload(bool after, void func()) => signalConnect('reload', func, after);
  Stream get onReload {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToReload(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterReload {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToReload(true, () {
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

abstract class EditableText extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'EditableText');

  dynamic getGProperty(String name);
  void setGProperty(String name, dynamic value);
  void copyText(int startPos, int endPos) => _staticInfo.callMethodOnReceiver('copy_text', this, [startPos, endPos]);
  void cutText(int startPos, int endPos) => _staticInfo.callMethodOnReceiver('cut_text', this, [startPos, endPos]);
  void deleteText(int startPos, int endPos) => _staticInfo.callMethodOnReceiver('delete_text', this, [startPos, endPos]);
  void insertText(String string, int length, int position) => _staticInfo.callMethodOnReceiver('insert_text', this, [string, length, position]);
  void pasteText(int position) => _staticInfo.callMethodOnReceiver('paste_text', this, [position]);
  bool setRunAttributes(SList attribSet /* this will fail */, int startOffset, int endOffset) => _staticInfo.callMethodOnReceiver('set_run_attributes', this, [attribSet, startOffset, endOffset]);
  void setTextContents(String string) => _staticInfo.callMethodOnReceiver('set_text_contents', this, [string]);
}

typedef void EventListener(AtkObject obj);
typedef void EventListenerInit();
typedef void FocusHandler(AtkObject object, bool focusIn);
typedef bool Function();
class GObjectAccessible extends AtkObject {
  GObjectAccessible.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'GObjectAccessible');

  static AtkObject forObject(GObjectObject obj) => _staticInfo.callStatic('for_object', [obj]);
  GObjectObject get object => _staticInfo.callMethodOnReceiver('get_object', this, []);
}

class Hyperlink extends GObjectObject with Action {
  Hyperlink.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'Hyperlink');

  static const String END_INDEX_PROPERTY = 'end-index';
  int get numberOfAnchors => getGProperty('number-of-anchors');
  static const String NUMBER_OF_ANCHORS_PROPERTY = 'number-of-anchors';
  bool get selectedLink => getGProperty('selected-link');
  static const String SELECTED_LINK_PROPERTY = 'selected-link';
  static const String START_INDEX_PROPERTY = 'start-index';
  int get endIndex => _staticInfo.callMethodOnReceiver('get_end_index', this, []);
  int get nAnchors => _staticInfo.callMethodOnReceiver('get_n_anchors', this, []);
  AtkObject getObject(int i) => _staticInfo.callMethodOnReceiver('get_object', this, [i]);
  int get startIndex => _staticInfo.callMethodOnReceiver('get_start_index', this, []);
  String getUri(int i) => _staticInfo.callMethodOnReceiver('get_uri', this, [i]);
  bool isInline() => _staticInfo.callMethodOnReceiver('is_inline', this, []);
  bool isSelectedLink() => _staticInfo.callMethodOnReceiver('is_selected_link', this, []);
  bool isValid() => _staticInfo.callMethodOnReceiver('is_valid', this, []);
  int _connectToLinkActivated(bool after, void func()) => signalConnect('link-activated', func, after);
  Stream get onLinkActivated {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToLinkActivated(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterLinkActivated {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToLinkActivated(true, () {
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

abstract class HyperlinkImpl extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'HyperlinkImpl');

  dynamic getGProperty(String name);
  void setGProperty(String name, dynamic value);
  Hyperlink get hyperlink => _staticInfo.callMethodOnReceiver('get_hyperlink', this, []);
}

class HyperlinkStateFlags extends GEnumBase {
  const HyperlinkStateFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'HyperlinkStateFlags');

  static const HyperlinkStateFlags NULL = const HyperlinkStateFlags(0);
  static const HyperlinkStateFlags INLINE = const HyperlinkStateFlags(1);
  bool get inline => (value & 1) == 1;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'HyperlinkStateFlags.INLINE';
      default: return 'new HyperlinkStateFlags($value)';
    }
  }
  String toString() {
    if (value == 0) {
      return 'HyperlinkStateFlags.NULL';
    }
    List codes = [];
    for (var i=1; i <= 1; i <<= 1) {
      if (value & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  HyperlinkStateFlags operator|(HyperlinkStateFlags other) =>
    new HyperlinkStateFlags(value | other.value);
  HyperlinkStateFlags operator&(HyperlinkStateFlags other) =>
    new HyperlinkStateFlags(value & other.value);
}

abstract class Hypertext extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'Hypertext');

  dynamic getGProperty(String name);
  void setGProperty(String name, dynamic value);
  Hyperlink getLink(int linkIndex) => _staticInfo.callMethodOnReceiver('get_link', this, [linkIndex]);
  int getLinkIndex(int charIndex) => _staticInfo.callMethodOnReceiver('get_link_index', this, [charIndex]);
  int get nLinks => _staticInfo.callMethodOnReceiver('get_n_links', this, []);
  int _connectToLinkSelected(bool after, void func(int arg1)) => signalConnect('link-selected', func, after);
  Stream<int> get onLinkSelected {
    int signalId;
    StreamController<int> controller;
    controller = new StreamController<int>(
      onListen: () {
          signalId = _connectToLinkSelected(false, (int arg1) {
              controller.add(arg1);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<int> get afterLinkSelected {
    int signalId;
    StreamController<int> controller;
    controller = new StreamController<int>(
      onListen: () {
          signalId = _connectToLinkSelected(true, (int arg1) {
              controller.add(arg1);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
}

abstract class Image extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'Image');

  dynamic getGProperty(String name);
  void setGProperty(String name, dynamic value);
  String get imageDescription => _staticInfo.callMethodOnReceiver('get_image_description', this, []);
  String get imageLocale => _staticInfo.callMethodOnReceiver('get_image_locale', this, []);
  void getImagePosition(int x, int y, CoordType coordType) => _staticInfo.callMethodOnReceiver('get_image_position', this, [x, y, coordType]);
  void getImageSize(int width, int height) => _staticInfo.callMethodOnReceiver('get_image_size', this, [width, height]);
  bool setImageDescription(String description) => _staticInfo.callMethodOnReceiver('set_image_description', this, [description]);
}

class Implementor extends GObjectBase {
  Implementor.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'Implementor');

  AtkObject refAccessible() => _staticInfo.callMethodOnReceiver('ref_accessible', this, []);
}

abstract class ImplementorIface extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'ImplementorIface');

  dynamic getGProperty(String name);
  void setGProperty(String name, dynamic value);
}

class KeyEventStruct extends GObjectBase {
  KeyEventStruct.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'KeyEventStruct');

  int get type => getFieldOfObject('type', 0);
  void set type(int value) => setFieldOfObject('type', 0, value);
  int get state => getFieldOfObject('state', 1);
  void set state(int value) => setFieldOfObject('state', 1, value);
  int get keyval => getFieldOfObject('keyval', 2);
  void set keyval(int value) => setFieldOfObject('keyval', 2, value);
  int get length => getFieldOfObject('length', 3);
  void set length(int value) => setFieldOfObject('length', 3, value);
  String get string => getFieldOfObject('string', 4);
  void set string(String value) => setFieldOfObject('string', 4, value);
  int get keycode => getFieldOfObject('keycode', 5);
  void set keycode(int value) => setFieldOfObject('keycode', 5, value);
  int get timestamp => getFieldOfObject('timestamp', 6);
  void set timestamp(int value) => setFieldOfObject('timestamp', 6, value);
}

class KeyEventType extends GEnumBase {
  const KeyEventType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'KeyEventType');

  static const KeyEventType PRESS = const KeyEventType(0);
  static const KeyEventType RELEASE = const KeyEventType(1);
  static const KeyEventType LAST_DEFINED = const KeyEventType(2);
  String toString() {
    switch(value) {
      case 0: return 'KeyEventType.PRESS';
      case 1: return 'KeyEventType.RELEASE';
      case 2: return 'KeyEventType.LAST_DEFINED';
      default: return 'new KeyEventType($value)';
    }
  }
}

typedef int KeySnoopFunc(KeyEventStruct event);
class Layer extends GEnumBase {
  const Layer(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'Layer');

  static const Layer INVALID = const Layer(0);
  static const Layer BACKGROUND = const Layer(1);
  static const Layer CANVAS = const Layer(2);
  static const Layer WIDGET = const Layer(3);
  static const Layer MDI = const Layer(4);
  static const Layer POPUP = const Layer(5);
  static const Layer OVERLAY = const Layer(6);
  static const Layer WINDOW = const Layer(7);
  String toString() {
    switch(value) {
      case 0: return 'Layer.INVALID';
      case 1: return 'Layer.BACKGROUND';
      case 2: return 'Layer.CANVAS';
      case 3: return 'Layer.WIDGET';
      case 4: return 'Layer.MDI';
      case 5: return 'Layer.POPUP';
      case 6: return 'Layer.OVERLAY';
      case 7: return 'Layer.WINDOW';
      default: return 'new Layer($value)';
    }
  }
}

class Misc extends GObjectObject {
  Misc.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'Misc');

  static Misc getInstance() => _staticInfo.callStatic('get_instance', []);
  void threadsEnter() => _staticInfo.callMethodOnReceiver('threads_enter', this, []);
  void threadsLeave() => _staticInfo.callMethodOnReceiver('threads_leave', this, []);
}

class NoOpObject extends AtkObject with Action, Component, Document, EditableText, Hypertext, Image, Selection, Table, TableCell, Text, Value, Window {
  NoOpObject.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'NoOpObject');

  factory NoOpObject(GObjectObject obj) => _staticInfo.callStatic('new', [obj]);
}

class NoOpObjectFactory extends ObjectFactory {
  NoOpObjectFactory.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'NoOpObjectFactory');

  factory NoOpObjectFactory() => _staticInfo.callStatic('new', []);
}

class AtkObject extends GObjectObject {
  AtkObject.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'Object');

  int get accessibleComponentLayer => getGProperty('accessible-component-layer');
  static const String ACCESSIBLE_COMPONENT_LAYER_PROPERTY = 'accessible-component-layer';
  int get accessibleComponentMdiZorder => getGProperty('accessible-component-mdi-zorder');
  static const String ACCESSIBLE_COMPONENT_MDI_ZORDER_PROPERTY = 'accessible-component-mdi-zorder';
  String get accessibleDescription => getGProperty('accessible-description');
  void set accessibleDescription(String value) => setGProperty('accessible-description', value);
  static const String ACCESSIBLE_DESCRIPTION_PROPERTY = 'accessible-description';
  int get accessibleHypertextNlinks => getGProperty('accessible-hypertext-nlinks');
  static const String ACCESSIBLE_HYPERTEXT_NLINKS_PROPERTY = 'accessible-hypertext-nlinks';
  String get accessibleName => getGProperty('accessible-name');
  void set accessibleName(String value) => setGProperty('accessible-name', value);
  static const String ACCESSIBLE_NAME_PROPERTY = 'accessible-name';
  AtkObject get accessibleParent => getGProperty('accessible-parent');
  void set accessibleParent(AtkObject value) => setGProperty('accessible-parent', value);
  static const String ACCESSIBLE_PARENT_PROPERTY = 'accessible-parent';
  int get accessibleRole => getGProperty('accessible-role');
  void set accessibleRole(int value) => setGProperty('accessible-role', value);
  static const String ACCESSIBLE_ROLE_PROPERTY = 'accessible-role';
  String get accessibleTableCaption => getGProperty('accessible-table-caption');
  void set accessibleTableCaption(String value) => setGProperty('accessible-table-caption', value);
  static const String ACCESSIBLE_TABLE_CAPTION_PROPERTY = 'accessible-table-caption';
  AtkObject get accessibleTableCaptionObject => getGProperty('accessible-table-caption-object');
  void set accessibleTableCaptionObject(AtkObject value) => setGProperty('accessible-table-caption-object', value);
  static const String ACCESSIBLE_TABLE_CAPTION_OBJECT_PROPERTY = 'accessible-table-caption-object';
  String get accessibleTableColumnDescription => getGProperty('accessible-table-column-description');
  void set accessibleTableColumnDescription(String value) => setGProperty('accessible-table-column-description', value);
  static const String ACCESSIBLE_TABLE_COLUMN_DESCRIPTION_PROPERTY = 'accessible-table-column-description';
  AtkObject get accessibleTableColumnHeader => getGProperty('accessible-table-column-header');
  void set accessibleTableColumnHeader(AtkObject value) => setGProperty('accessible-table-column-header', value);
  static const String ACCESSIBLE_TABLE_COLUMN_HEADER_PROPERTY = 'accessible-table-column-header';
  String get accessibleTableRowDescription => getGProperty('accessible-table-row-description');
  void set accessibleTableRowDescription(String value) => setGProperty('accessible-table-row-description', value);
  static const String ACCESSIBLE_TABLE_ROW_DESCRIPTION_PROPERTY = 'accessible-table-row-description';
  AtkObject get accessibleTableRowHeader => getGProperty('accessible-table-row-header');
  void set accessibleTableRowHeader(AtkObject value) => setGProperty('accessible-table-row-header', value);
  static const String ACCESSIBLE_TABLE_ROW_HEADER_PROPERTY = 'accessible-table-row-header';
  AtkObject get accessibleTableSummary => getGProperty('accessible-table-summary');
  void set accessibleTableSummary(AtkObject value) => setGProperty('accessible-table-summary', value);
  static const String ACCESSIBLE_TABLE_SUMMARY_PROPERTY = 'accessible-table-summary';
  num get accessibleValue => getGProperty('accessible-value');
  void set accessibleValue(num value) => setGProperty('accessible-value', value);
  static const String ACCESSIBLE_VALUE_PROPERTY = 'accessible-value';
  bool addRelationship(RelationType relationship, AtkObject target) => _staticInfo.callMethodOnReceiver('add_relationship', this, [relationship, target]);
  SList /* this will fail */ get attributes => _staticInfo.callMethodOnReceiver('get_attributes', this, []);
  String get description => _staticInfo.callMethodOnReceiver('get_description', this, []);
  int get indexInParent => _staticInfo.callMethodOnReceiver('get_index_in_parent', this, []);
  Layer get layer => _staticInfo.callMethodOnReceiver('get_layer', this, []);
  int get mdiZorder => _staticInfo.callMethodOnReceiver('get_mdi_zorder', this, []);
  int get nAccessibleChildren => _staticInfo.callMethodOnReceiver('get_n_accessible_children', this, []);
  String get name => _staticInfo.callMethodOnReceiver('get_name', this, []);
  String get objectLocale => _staticInfo.callMethodOnReceiver('get_object_locale', this, []);
  AtkObject get parent => _staticInfo.callMethodOnReceiver('get_parent', this, []);
  Role get role => _staticInfo.callMethodOnReceiver('get_role', this, []);
  void initialize(dynamic data /* this will fail */) => _staticInfo.callMethodOnReceiver('initialize', this, [data]);
  void notifyStateChange(int state, bool value) => _staticInfo.callMethodOnReceiver('notify_state_change', this, [state, value]);
  AtkObject peekParent() => _staticInfo.callMethodOnReceiver('peek_parent', this, []);
  AtkObject refAccessibleChild(int i) => _staticInfo.callMethodOnReceiver('ref_accessible_child', this, [i]);
  RelationSet refRelationSet() => _staticInfo.callMethodOnReceiver('ref_relation_set', this, []);
  StateSet refStateSet() => _staticInfo.callMethodOnReceiver('ref_state_set', this, []);
  void removePropertyChangeHandler(int handlerId) => _staticInfo.callMethodOnReceiver('remove_property_change_handler', this, [handlerId]);
  bool removeRelationship(RelationType relationship, AtkObject target) => _staticInfo.callMethodOnReceiver('remove_relationship', this, [relationship, target]);
  void set description(String description) => _staticInfo.callMethodOnReceiver('set_description', this, [description]);
  void set name(String name) => _staticInfo.callMethodOnReceiver('set_name', this, [name]);
  void set parent(AtkObject parent) => _staticInfo.callMethodOnReceiver('set_parent', this, [parent]);
  void set role(Role role) => _staticInfo.callMethodOnReceiver('set_role', this, [role]);
  RelationSet get relationSet => getFieldOfObject('relation_set', 5);
  int _connectToActiveDescendantChanged(bool after, void func(dynamic arg1 /* this will fail */)) => signalConnect('active-descendant-changed', func, after);
  Stream<dynamic> get onActiveDescendantChanged {
    int signalId;
    StreamController<dynamic> controller;
    controller = new StreamController<dynamic>(
      onListen: () {
          signalId = _connectToActiveDescendantChanged(false, (dynamic arg1 /* this will fail */) {
              controller.add(arg1);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<dynamic> get afterActiveDescendantChanged {
    int signalId;
    StreamController<dynamic> controller;
    controller = new StreamController<dynamic>(
      onListen: () {
          signalId = _connectToActiveDescendantChanged(true, (dynamic arg1 /* this will fail */) {
              controller.add(arg1);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToChildrenChanged(bool after, void func(int arg1, dynamic arg2 /* this will fail */)) => signalConnect('children-changed', func, after);
  Stream<AtkObjectChildrenChangedEvent> get onChildrenChanged {
    int signalId;
    StreamController<AtkObjectChildrenChangedEvent> controller;
    controller = new StreamController<AtkObjectChildrenChangedEvent>(
      onListen: () {
          signalId = _connectToChildrenChanged(false, (int arg1, dynamic arg2 /* this will fail */) {
              var result = new AtkObjectChildrenChangedEvent(arg1, arg2);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<AtkObjectChildrenChangedEvent> get afterChildrenChanged {
    int signalId;
    StreamController<AtkObjectChildrenChangedEvent> controller;
    controller = new StreamController<AtkObjectChildrenChangedEvent>(
      onListen: () {
          signalId = _connectToChildrenChanged(true, (int arg1, dynamic arg2 /* this will fail */) {
              var result = new AtkObjectChildrenChangedEvent(arg1, arg2);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToFocusEvent(bool after, void func(bool arg1)) => signalConnect('focus-event', func, after);
  Stream<bool> get onFocusEvent {
    int signalId;
    StreamController<bool> controller;
    controller = new StreamController<bool>(
      onListen: () {
          signalId = _connectToFocusEvent(false, (bool arg1) {
              controller.add(arg1);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<bool> get afterFocusEvent {
    int signalId;
    StreamController<bool> controller;
    controller = new StreamController<bool>(
      onListen: () {
          signalId = _connectToFocusEvent(true, (bool arg1) {
              controller.add(arg1);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToPropertyChange(bool after, void func(dynamic arg1 /* this will fail */)) => signalConnect('property-change', func, after);
  Stream<dynamic> get onPropertyChange {
    int signalId;
    StreamController<dynamic> controller;
    controller = new StreamController<dynamic>(
      onListen: () {
          signalId = _connectToPropertyChange(false, (dynamic arg1 /* this will fail */) {
              controller.add(arg1);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<dynamic> get afterPropertyChange {
    int signalId;
    StreamController<dynamic> controller;
    controller = new StreamController<dynamic>(
      onListen: () {
          signalId = _connectToPropertyChange(true, (dynamic arg1 /* this will fail */) {
              controller.add(arg1);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToStateChange(bool after, void func(String arg1, bool arg2)) => signalConnect('state-change', func, after);
  Stream<AtkObjectStateChangeEvent> get onStateChange {
    int signalId;
    StreamController<AtkObjectStateChangeEvent> controller;
    controller = new StreamController<AtkObjectStateChangeEvent>(
      onListen: () {
          signalId = _connectToStateChange(false, (String arg1, bool arg2) {
              var result = new AtkObjectStateChangeEvent(arg1, arg2);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<AtkObjectStateChangeEvent> get afterStateChange {
    int signalId;
    StreamController<AtkObjectStateChangeEvent> controller;
    controller = new StreamController<AtkObjectStateChangeEvent>(
      onListen: () {
          signalId = _connectToStateChange(true, (String arg1, bool arg2) {
              var result = new AtkObjectStateChangeEvent(arg1, arg2);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToVisibleDataChanged(bool after, void func()) => signalConnect('visible-data-changed', func, after);
  Stream get onVisibleDataChanged {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToVisibleDataChanged(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterVisibleDataChanged {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToVisibleDataChanged(true, () {
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

class AtkObjectChildrenChangedEvent {
  final int arg1;
  final dynamic arg2 /* this will fail */;

  AtkObjectChildrenChangedEvent(this.arg1, this.arg2);
}

class AtkObjectStateChangeEvent {
  final String arg1;
  final bool arg2;

  AtkObjectStateChangeEvent(this.arg1, this.arg2);
}

class ObjectFactory extends GObjectObject {
  ObjectFactory.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'ObjectFactory');

  AtkObject createAccessible(GObjectObject obj) => _staticInfo.callMethodOnReceiver('create_accessible', this, [obj]);
  int get accessibleType => _staticInfo.callMethodOnReceiver('get_accessible_type', this, []);
  void invalidate() => _staticInfo.callMethodOnReceiver('invalidate', this, []);
}

class Plug extends AtkObject with Component {
  Plug.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'Plug');

  factory Plug() => _staticInfo.callStatic('new', []);
  String get id => _staticInfo.callMethodOnReceiver('get_id', this, []);
}

typedef void PropertyChangeHandler(AtkObject obj, PropertyValues vals);
class PropertyValues extends GObjectBase {
  PropertyValues.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'PropertyValues');

  String get propertyName => getFieldOfObject('property_name', 0);
  void set propertyName(String value) => setFieldOfObject('property_name', 0, value);
  Value get oldValue => getFieldOfObject('old_value', 1);
  void set oldValue(Value value) => setFieldOfObject('old_value', 1, value);
  Value get newValue => getFieldOfObject('new_value', 2);
  void set newValue(Value value) => setFieldOfObject('new_value', 2, value);
}

class Range extends GObjectBase {
  Range.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'Range');

  factory Range(num lowerLimit, num upperLimit, String description) => _staticInfo.callStatic('new', [lowerLimit, upperLimit, description]);
  Range copy() => _staticInfo.callMethodOnReceiver('copy', this, []);
  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
  String get description => _staticInfo.callMethodOnReceiver('get_description', this, []);
  num get lowerLimit => _staticInfo.callMethodOnReceiver('get_lower_limit', this, []);
  num get upperLimit => _staticInfo.callMethodOnReceiver('get_upper_limit', this, []);
}

class Rectangle extends GObjectBase {
  Rectangle.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'Rectangle');

  int get x => getFieldOfObject('x', 0);
  void set x(int value) => setFieldOfObject('x', 0, value);
  int get y => getFieldOfObject('y', 1);
  void set y(int value) => setFieldOfObject('y', 1, value);
  int get width => getFieldOfObject('width', 2);
  void set width(int value) => setFieldOfObject('width', 2, value);
  int get height => getFieldOfObject('height', 3);
  void set height(int value) => setFieldOfObject('height', 3, value);
}

class Registry extends GObjectObject {
  Registry.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'Registry');

  ObjectFactory getFactory(int type) => _staticInfo.callMethodOnReceiver('get_factory', this, [type]);
  int getFactoryType(int type) => _staticInfo.callMethodOnReceiver('get_factory_type', this, [type]);
  void setFactoryType(int type, int factoryType) => _staticInfo.callMethodOnReceiver('set_factory_type', this, [type, factoryType]);
  HashTable get factoryTypeRegistry => getFieldOfObject('factory_type_registry', 1);
  HashTable get factorySingletonCache => getFieldOfObject('factory_singleton_cache', 2);
}

class Relation extends GObjectObject {
  Relation.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'Relation');

  void set relationType(RelationType value) => setGProperty('relation-type', value);
  static const String RELATION_TYPE_PROPERTY = 'relation-type';
  void set target(ValueArray value) => setGProperty('target', value);
  static const String TARGET_PROPERTY = 'target';
  factory Relation(List<AtkObject> targets, RelationType relationship) => _staticInfo.callStatic('new', [targets, relationship]);
  void addTarget(AtkObject target) => _staticInfo.callMethodOnReceiver('add_target', this, [target]);
  RelationType get relationType_ => _staticInfo.callMethodOnReceiver('get_relation_type', this, []);
  List<AtkObject> get target_ => _staticInfo.callMethodOnReceiver('get_target', this, []);
  bool removeTarget(AtkObject target) => _staticInfo.callMethodOnReceiver('remove_target', this, [target]);
  RelationType get relationship => getFieldOfObject('relationship', 2);
}

class RelationSet extends GObjectObject {
  RelationSet.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'RelationSet');

  factory RelationSet() => _staticInfo.callStatic('new', []);
  void add(Relation relation) => _staticInfo.callMethodOnReceiver('add', this, [relation]);
  void addRelationByType(RelationType relationship, AtkObject target) => _staticInfo.callMethodOnReceiver('add_relation_by_type', this, [relationship, target]);
  bool contains(RelationType relationship) => _staticInfo.callMethodOnReceiver('contains', this, [relationship]);
  bool containsTarget(RelationType relationship, AtkObject target) => _staticInfo.callMethodOnReceiver('contains_target', this, [relationship, target]);
  int get nRelations => _staticInfo.callMethodOnReceiver('get_n_relations', this, []);
  Relation getRelation(int i) => _staticInfo.callMethodOnReceiver('get_relation', this, [i]);
  Relation getRelationByType(RelationType relationship) => _staticInfo.callMethodOnReceiver('get_relation_by_type', this, [relationship]);
  void remove(Relation relation) => _staticInfo.callMethodOnReceiver('remove', this, [relation]);
}

class RelationType extends GEnumBase {
  const RelationType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'RelationType');

  static const RelationType NULL = const RelationType(0);
  static const RelationType CONTROLLED_BY = const RelationType(1);
  static const RelationType CONTROLLER_FOR = const RelationType(2);
  static const RelationType LABEL_FOR = const RelationType(3);
  static const RelationType LABELLED_BY = const RelationType(4);
  static const RelationType MEMBER_OF = const RelationType(5);
  static const RelationType NODE_CHILD_OF = const RelationType(6);
  static const RelationType FLOWS_TO = const RelationType(7);
  static const RelationType FLOWS_FROM = const RelationType(8);
  static const RelationType SUBWINDOW_OF = const RelationType(9);
  static const RelationType EMBEDS = const RelationType(10);
  static const RelationType EMBEDDED_BY = const RelationType(11);
  static const RelationType POPUP_FOR = const RelationType(12);
  static const RelationType PARENT_WINDOW_OF = const RelationType(13);
  static const RelationType DESCRIBED_BY = const RelationType(14);
  static const RelationType DESCRIPTION_FOR = const RelationType(15);
  static const RelationType NODE_PARENT_OF = const RelationType(16);
  static const RelationType LAST_DEFINED = const RelationType(17);
  String toString() {
    switch(value) {
      case 0: return 'RelationType.NULL';
      case 1: return 'RelationType.CONTROLLED_BY';
      case 2: return 'RelationType.CONTROLLER_FOR';
      case 3: return 'RelationType.LABEL_FOR';
      case 4: return 'RelationType.LABELLED_BY';
      case 5: return 'RelationType.MEMBER_OF';
      case 6: return 'RelationType.NODE_CHILD_OF';
      case 7: return 'RelationType.FLOWS_TO';
      case 8: return 'RelationType.FLOWS_FROM';
      case 9: return 'RelationType.SUBWINDOW_OF';
      case 10: return 'RelationType.EMBEDS';
      case 11: return 'RelationType.EMBEDDED_BY';
      case 12: return 'RelationType.POPUP_FOR';
      case 13: return 'RelationType.PARENT_WINDOW_OF';
      case 14: return 'RelationType.DESCRIBED_BY';
      case 15: return 'RelationType.DESCRIPTION_FOR';
      case 16: return 'RelationType.NODE_PARENT_OF';
      case 17: return 'RelationType.LAST_DEFINED';
      default: return 'new RelationType($value)';
    }
  }
  static RelationType forName(String name) => _staticInfo.callStatic('for_name', [name]);
  static String getName(RelationType type) => _staticInfo.callStatic('get_name', [type]);
  static RelationType register(String name) => _staticInfo.callStatic('register', [name]);
}

class Role extends GEnumBase {
  const Role(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'Role');

  static const Role INVALID = const Role(0);
  static const Role ACCELERATOR_LABEL = const Role(1);
  static const Role ALERT = const Role(2);
  static const Role ANIMATION = const Role(3);
  static const Role ARROW = const Role(4);
  static const Role CALENDAR = const Role(5);
  static const Role CANVAS = const Role(6);
  static const Role CHECK_BOX = const Role(7);
  static const Role CHECK_MENU_ITEM = const Role(8);
  static const Role COLOR_CHOOSER = const Role(9);
  static const Role COLUMN_HEADER = const Role(10);
  static const Role COMBO_BOX = const Role(11);
  static const Role DATE_EDITOR = const Role(12);
  static const Role DESKTOP_ICON = const Role(13);
  static const Role DESKTOP_FRAME = const Role(14);
  static const Role DIAL = const Role(15);
  static const Role DIALOG = const Role(16);
  static const Role DIRECTORY_PANE = const Role(17);
  static const Role DRAWING_AREA = const Role(18);
  static const Role FILE_CHOOSER = const Role(19);
  static const Role FILLER = const Role(20);
  static const Role FONT_CHOOSER = const Role(21);
  static const Role FRAME = const Role(22);
  static const Role GLASS_PANE = const Role(23);
  static const Role HTML_CONTAINER = const Role(24);
  static const Role ICON = const Role(25);
  static const Role IMAGE = const Role(26);
  static const Role INTERNAL_FRAME = const Role(27);
  static const Role LABEL = const Role(28);
  static const Role LAYERED_PANE = const Role(29);
  static const Role LIST = const Role(30);
  static const Role LIST_ITEM = const Role(31);
  static const Role MENU = const Role(32);
  static const Role MENU_BAR = const Role(33);
  static const Role MENU_ITEM = const Role(34);
  static const Role OPTION_PANE = const Role(35);
  static const Role PAGE_TAB = const Role(36);
  static const Role PAGE_TAB_LIST = const Role(37);
  static const Role PANEL = const Role(38);
  static const Role PASSWORD_TEXT = const Role(39);
  static const Role POPUP_MENU = const Role(40);
  static const Role PROGRESS_BAR = const Role(41);
  static const Role PUSH_BUTTON = const Role(42);
  static const Role RADIO_BUTTON = const Role(43);
  static const Role RADIO_MENU_ITEM = const Role(44);
  static const Role ROOT_PANE = const Role(45);
  static const Role ROW_HEADER = const Role(46);
  static const Role SCROLL_BAR = const Role(47);
  static const Role SCROLL_PANE = const Role(48);
  static const Role SEPARATOR = const Role(49);
  static const Role SLIDER = const Role(50);
  static const Role SPLIT_PANE = const Role(51);
  static const Role SPIN_BUTTON = const Role(52);
  static const Role STATUSBAR = const Role(53);
  static const Role TABLE = const Role(54);
  static const Role TABLE_CELL = const Role(55);
  static const Role TABLE_COLUMN_HEADER = const Role(56);
  static const Role TABLE_ROW_HEADER = const Role(57);
  static const Role TEAR_OFF_MENU_ITEM = const Role(58);
  static const Role TERMINAL = const Role(59);
  static const Role TEXT = const Role(60);
  static const Role TOGGLE_BUTTON = const Role(61);
  static const Role TOOL_BAR = const Role(62);
  static const Role TOOL_TIP = const Role(63);
  static const Role TREE = const Role(64);
  static const Role TREE_TABLE = const Role(65);
  static const Role UNKNOWN = const Role(66);
  static const Role VIEWPORT = const Role(67);
  static const Role WINDOW = const Role(68);
  static const Role HEADER = const Role(69);
  static const Role FOOTER = const Role(70);
  static const Role PARAGRAPH = const Role(71);
  static const Role RULER = const Role(72);
  static const Role APPLICATION = const Role(73);
  static const Role AUTOCOMPLETE = const Role(74);
  static const Role EDIT_BAR = const Role(75);
  static const Role EMBEDDED = const Role(76);
  static const Role ENTRY = const Role(77);
  static const Role CHART = const Role(78);
  static const Role CAPTION = const Role(79);
  static const Role DOCUMENT_FRAME = const Role(80);
  static const Role HEADING = const Role(81);
  static const Role PAGE = const Role(82);
  static const Role SECTION = const Role(83);
  static const Role REDUNDANT_OBJECT = const Role(84);
  static const Role FORM = const Role(85);
  static const Role LINK = const Role(86);
  static const Role INPUT_METHOD_WINDOW = const Role(87);
  static const Role TABLE_ROW = const Role(88);
  static const Role TREE_ITEM = const Role(89);
  static const Role DOCUMENT_SPREADSHEET = const Role(90);
  static const Role DOCUMENT_PRESENTATION = const Role(91);
  static const Role DOCUMENT_TEXT = const Role(92);
  static const Role DOCUMENT_WEB = const Role(93);
  static const Role DOCUMENT_EMAIL = const Role(94);
  static const Role COMMENT = const Role(95);
  static const Role LIST_BOX = const Role(96);
  static const Role GROUPING = const Role(97);
  static const Role IMAGE_MAP = const Role(98);
  static const Role NOTIFICATION = const Role(99);
  static const Role INFO_BAR = const Role(100);
  static const Role LEVEL_BAR = const Role(101);
  static const Role TITLE_BAR = const Role(102);
  static const Role BLOCK_QUOTE = const Role(103);
  static const Role AUDIO = const Role(104);
  static const Role VIDEO = const Role(105);
  static const Role DEFINITION = const Role(106);
  static const Role ARTICLE = const Role(107);
  static const Role LANDMARK = const Role(108);
  static const Role LOG = const Role(109);
  static const Role MARQUEE = const Role(110);
  static const Role MATH = const Role(111);
  static const Role RATING = const Role(112);
  static const Role TIMER = const Role(113);
  static const Role DESCRIPTION_LIST = const Role(114);
  static const Role DESCRIPTION_TERM = const Role(115);
  static const Role DESCRIPTION_VALUE = const Role(116);
  static const Role STATIC = const Role(117);
  static const Role MATH_FRACTION = const Role(118);
  static const Role MATH_ROOT = const Role(119);
  static const Role SUBSCRIPT = const Role(120);
  static const Role SUPERSCRIPT = const Role(121);
  static const Role LAST_DEFINED = const Role(122);
  String toString() {
    switch(value) {
      case 0: return 'Role.INVALID';
      case 1: return 'Role.ACCELERATOR_LABEL';
      case 2: return 'Role.ALERT';
      case 3: return 'Role.ANIMATION';
      case 4: return 'Role.ARROW';
      case 5: return 'Role.CALENDAR';
      case 6: return 'Role.CANVAS';
      case 7: return 'Role.CHECK_BOX';
      case 8: return 'Role.CHECK_MENU_ITEM';
      case 9: return 'Role.COLOR_CHOOSER';
      case 10: return 'Role.COLUMN_HEADER';
      case 11: return 'Role.COMBO_BOX';
      case 12: return 'Role.DATE_EDITOR';
      case 13: return 'Role.DESKTOP_ICON';
      case 14: return 'Role.DESKTOP_FRAME';
      case 15: return 'Role.DIAL';
      case 16: return 'Role.DIALOG';
      case 17: return 'Role.DIRECTORY_PANE';
      case 18: return 'Role.DRAWING_AREA';
      case 19: return 'Role.FILE_CHOOSER';
      case 20: return 'Role.FILLER';
      case 21: return 'Role.FONT_CHOOSER';
      case 22: return 'Role.FRAME';
      case 23: return 'Role.GLASS_PANE';
      case 24: return 'Role.HTML_CONTAINER';
      case 25: return 'Role.ICON';
      case 26: return 'Role.IMAGE';
      case 27: return 'Role.INTERNAL_FRAME';
      case 28: return 'Role.LABEL';
      case 29: return 'Role.LAYERED_PANE';
      case 30: return 'Role.LIST';
      case 31: return 'Role.LIST_ITEM';
      case 32: return 'Role.MENU';
      case 33: return 'Role.MENU_BAR';
      case 34: return 'Role.MENU_ITEM';
      case 35: return 'Role.OPTION_PANE';
      case 36: return 'Role.PAGE_TAB';
      case 37: return 'Role.PAGE_TAB_LIST';
      case 38: return 'Role.PANEL';
      case 39: return 'Role.PASSWORD_TEXT';
      case 40: return 'Role.POPUP_MENU';
      case 41: return 'Role.PROGRESS_BAR';
      case 42: return 'Role.PUSH_BUTTON';
      case 43: return 'Role.RADIO_BUTTON';
      case 44: return 'Role.RADIO_MENU_ITEM';
      case 45: return 'Role.ROOT_PANE';
      case 46: return 'Role.ROW_HEADER';
      case 47: return 'Role.SCROLL_BAR';
      case 48: return 'Role.SCROLL_PANE';
      case 49: return 'Role.SEPARATOR';
      case 50: return 'Role.SLIDER';
      case 51: return 'Role.SPLIT_PANE';
      case 52: return 'Role.SPIN_BUTTON';
      case 53: return 'Role.STATUSBAR';
      case 54: return 'Role.TABLE';
      case 55: return 'Role.TABLE_CELL';
      case 56: return 'Role.TABLE_COLUMN_HEADER';
      case 57: return 'Role.TABLE_ROW_HEADER';
      case 58: return 'Role.TEAR_OFF_MENU_ITEM';
      case 59: return 'Role.TERMINAL';
      case 60: return 'Role.TEXT';
      case 61: return 'Role.TOGGLE_BUTTON';
      case 62: return 'Role.TOOL_BAR';
      case 63: return 'Role.TOOL_TIP';
      case 64: return 'Role.TREE';
      case 65: return 'Role.TREE_TABLE';
      case 66: return 'Role.UNKNOWN';
      case 67: return 'Role.VIEWPORT';
      case 68: return 'Role.WINDOW';
      case 69: return 'Role.HEADER';
      case 70: return 'Role.FOOTER';
      case 71: return 'Role.PARAGRAPH';
      case 72: return 'Role.RULER';
      case 73: return 'Role.APPLICATION';
      case 74: return 'Role.AUTOCOMPLETE';
      case 75: return 'Role.EDIT_BAR';
      case 76: return 'Role.EMBEDDED';
      case 77: return 'Role.ENTRY';
      case 78: return 'Role.CHART';
      case 79: return 'Role.CAPTION';
      case 80: return 'Role.DOCUMENT_FRAME';
      case 81: return 'Role.HEADING';
      case 82: return 'Role.PAGE';
      case 83: return 'Role.SECTION';
      case 84: return 'Role.REDUNDANT_OBJECT';
      case 85: return 'Role.FORM';
      case 86: return 'Role.LINK';
      case 87: return 'Role.INPUT_METHOD_WINDOW';
      case 88: return 'Role.TABLE_ROW';
      case 89: return 'Role.TREE_ITEM';
      case 90: return 'Role.DOCUMENT_SPREADSHEET';
      case 91: return 'Role.DOCUMENT_PRESENTATION';
      case 92: return 'Role.DOCUMENT_TEXT';
      case 93: return 'Role.DOCUMENT_WEB';
      case 94: return 'Role.DOCUMENT_EMAIL';
      case 95: return 'Role.COMMENT';
      case 96: return 'Role.LIST_BOX';
      case 97: return 'Role.GROUPING';
      case 98: return 'Role.IMAGE_MAP';
      case 99: return 'Role.NOTIFICATION';
      case 100: return 'Role.INFO_BAR';
      case 101: return 'Role.LEVEL_BAR';
      case 102: return 'Role.TITLE_BAR';
      case 103: return 'Role.BLOCK_QUOTE';
      case 104: return 'Role.AUDIO';
      case 105: return 'Role.VIDEO';
      case 106: return 'Role.DEFINITION';
      case 107: return 'Role.ARTICLE';
      case 108: return 'Role.LANDMARK';
      case 109: return 'Role.LOG';
      case 110: return 'Role.MARQUEE';
      case 111: return 'Role.MATH';
      case 112: return 'Role.RATING';
      case 113: return 'Role.TIMER';
      case 114: return 'Role.DESCRIPTION_LIST';
      case 115: return 'Role.DESCRIPTION_TERM';
      case 116: return 'Role.DESCRIPTION_VALUE';
      case 117: return 'Role.STATIC';
      case 118: return 'Role.MATH_FRACTION';
      case 119: return 'Role.MATH_ROOT';
      case 120: return 'Role.SUBSCRIPT';
      case 121: return 'Role.SUPERSCRIPT';
      case 122: return 'Role.LAST_DEFINED';
      default: return 'new Role($value)';
    }
  }
  static Role forName(String name) => _staticInfo.callStatic('for_name', [name]);
  static String getLocalizedName(Role role) => _staticInfo.callStatic('get_localized_name', [role]);
  static String getName(Role role) => _staticInfo.callStatic('get_name', [role]);
  static Role register(String name) => _staticInfo.callStatic('register', [name]);
}

abstract class Selection extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'Selection');

  dynamic getGProperty(String name);
  void setGProperty(String name, dynamic value);
  bool addSelection(int i) => _staticInfo.callMethodOnReceiver('add_selection', this, [i]);
  bool clearSelection() => _staticInfo.callMethodOnReceiver('clear_selection', this, []);
  int get selectionCount => _staticInfo.callMethodOnReceiver('get_selection_count', this, []);
  bool isChildSelected(int i) => _staticInfo.callMethodOnReceiver('is_child_selected', this, [i]);
  AtkObject refSelection(int i) => _staticInfo.callMethodOnReceiver('ref_selection', this, [i]);
  bool removeSelection(int i) => _staticInfo.callMethodOnReceiver('remove_selection', this, [i]);
  bool selectAllSelection() => _staticInfo.callMethodOnReceiver('select_all_selection', this, []);
  int _connectToSelectionChanged(bool after, void func()) => signalConnect('selection-changed', func, after);
  Stream get onSelectionChanged {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToSelectionChanged(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterSelectionChanged {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToSelectionChanged(true, () {
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

class Socket extends AtkObject with Component {
  Socket.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'Socket');

  factory Socket() => _staticInfo.callStatic('new', []);
  void embed(String plugId) => _staticInfo.callMethodOnReceiver('embed', this, [plugId]);
  bool isOccupied() => _staticInfo.callMethodOnReceiver('is_occupied', this, []);
}

class StateSet extends GObjectObject {
  StateSet.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'StateSet');

  factory StateSet() => _staticInfo.callStatic('new', []);
  bool addState(StateType type) => _staticInfo.callMethodOnReceiver('add_state', this, [type]);
  void addStates(List<StateType> types) => _staticInfo.callMethodOnReceiver('add_states', this, [types]);
  StateSet andSets(StateSet compareSet) => _staticInfo.callMethodOnReceiver('and_sets', this, [compareSet]);
  void clearStates() => _staticInfo.callMethodOnReceiver('clear_states', this, []);
  bool containsState(StateType type) => _staticInfo.callMethodOnReceiver('contains_state', this, [type]);
  bool containsStates(List<StateType> types) => _staticInfo.callMethodOnReceiver('contains_states', this, [types]);
  bool isEmpty() => _staticInfo.callMethodOnReceiver('is_empty', this, []);
  StateSet orSets(StateSet compareSet) => _staticInfo.callMethodOnReceiver('or_sets', this, [compareSet]);
  bool removeState(StateType type) => _staticInfo.callMethodOnReceiver('remove_state', this, [type]);
  StateSet xorSets(StateSet compareSet) => _staticInfo.callMethodOnReceiver('xor_sets', this, [compareSet]);
}

class StateType extends GEnumBase {
  const StateType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'StateType');

  static const StateType INVALID = const StateType(0);
  static const StateType ACTIVE = const StateType(1);
  static const StateType ARMED = const StateType(2);
  static const StateType BUSY = const StateType(3);
  static const StateType CHECKED = const StateType(4);
  static const StateType DEFUNCT = const StateType(5);
  static const StateType EDITABLE = const StateType(6);
  static const StateType ENABLED = const StateType(7);
  static const StateType EXPANDABLE = const StateType(8);
  static const StateType EXPANDED = const StateType(9);
  static const StateType FOCUSABLE = const StateType(10);
  static const StateType FOCUSED = const StateType(11);
  static const StateType HORIZONTAL = const StateType(12);
  static const StateType ICONIFIED = const StateType(13);
  static const StateType MODAL = const StateType(14);
  static const StateType MULTI_LINE = const StateType(15);
  static const StateType MULTISELECTABLE = const StateType(16);
  static const StateType OPAQUE = const StateType(17);
  static const StateType PRESSED = const StateType(18);
  static const StateType RESIZABLE = const StateType(19);
  static const StateType SELECTABLE = const StateType(20);
  static const StateType SELECTED = const StateType(21);
  static const StateType SENSITIVE = const StateType(22);
  static const StateType SHOWING = const StateType(23);
  static const StateType SINGLE_LINE = const StateType(24);
  static const StateType STALE = const StateType(25);
  static const StateType TRANSIENT = const StateType(26);
  static const StateType VERTICAL = const StateType(27);
  static const StateType VISIBLE = const StateType(28);
  static const StateType MANAGES_DESCENDANTS = const StateType(29);
  static const StateType INDETERMINATE = const StateType(30);
  static const StateType TRUNCATED = const StateType(31);
  static const StateType REQUIRED = const StateType(32);
  static const StateType INVALID_ENTRY = const StateType(33);
  static const StateType SUPPORTS_AUTOCOMPLETION = const StateType(34);
  static const StateType SELECTABLE_TEXT = const StateType(35);
  static const StateType DEFAULT = const StateType(36);
  static const StateType ANIMATED = const StateType(37);
  static const StateType VISITED = const StateType(38);
  static const StateType CHECKABLE = const StateType(39);
  static const StateType HAS_POPUP = const StateType(40);
  static const StateType HAS_TOOLTIP = const StateType(41);
  static const StateType READ_ONLY = const StateType(42);
  static const StateType LAST_DEFINED = const StateType(43);
  String toString() {
    switch(value) {
      case 0: return 'StateType.INVALID';
      case 1: return 'StateType.ACTIVE';
      case 2: return 'StateType.ARMED';
      case 3: return 'StateType.BUSY';
      case 4: return 'StateType.CHECKED';
      case 5: return 'StateType.DEFUNCT';
      case 6: return 'StateType.EDITABLE';
      case 7: return 'StateType.ENABLED';
      case 8: return 'StateType.EXPANDABLE';
      case 9: return 'StateType.EXPANDED';
      case 10: return 'StateType.FOCUSABLE';
      case 11: return 'StateType.FOCUSED';
      case 12: return 'StateType.HORIZONTAL';
      case 13: return 'StateType.ICONIFIED';
      case 14: return 'StateType.MODAL';
      case 15: return 'StateType.MULTI_LINE';
      case 16: return 'StateType.MULTISELECTABLE';
      case 17: return 'StateType.OPAQUE';
      case 18: return 'StateType.PRESSED';
      case 19: return 'StateType.RESIZABLE';
      case 20: return 'StateType.SELECTABLE';
      case 21: return 'StateType.SELECTED';
      case 22: return 'StateType.SENSITIVE';
      case 23: return 'StateType.SHOWING';
      case 24: return 'StateType.SINGLE_LINE';
      case 25: return 'StateType.STALE';
      case 26: return 'StateType.TRANSIENT';
      case 27: return 'StateType.VERTICAL';
      case 28: return 'StateType.VISIBLE';
      case 29: return 'StateType.MANAGES_DESCENDANTS';
      case 30: return 'StateType.INDETERMINATE';
      case 31: return 'StateType.TRUNCATED';
      case 32: return 'StateType.REQUIRED';
      case 33: return 'StateType.INVALID_ENTRY';
      case 34: return 'StateType.SUPPORTS_AUTOCOMPLETION';
      case 35: return 'StateType.SELECTABLE_TEXT';
      case 36: return 'StateType.DEFAULT';
      case 37: return 'StateType.ANIMATED';
      case 38: return 'StateType.VISITED';
      case 39: return 'StateType.CHECKABLE';
      case 40: return 'StateType.HAS_POPUP';
      case 41: return 'StateType.HAS_TOOLTIP';
      case 42: return 'StateType.READ_ONLY';
      case 43: return 'StateType.LAST_DEFINED';
      default: return 'new StateType($value)';
    }
  }
  static StateType forName(String name) => _staticInfo.callStatic('for_name', [name]);
  static String getName(StateType type) => _staticInfo.callStatic('get_name', [type]);
  static StateType register(String name) => _staticInfo.callStatic('register', [name]);
}

abstract class StreamableContent extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'StreamableContent');

  dynamic getGProperty(String name);
  void setGProperty(String name, dynamic value);
  String getMimeType(int i) => _staticInfo.callMethodOnReceiver('get_mime_type', this, [i]);
  int get nMimeTypes => _staticInfo.callMethodOnReceiver('get_n_mime_types', this, []);
  IOChannel getStream(String mimeType) => _staticInfo.callMethodOnReceiver('get_stream', this, [mimeType]);
  String getUri(String mimeType) => _staticInfo.callMethodOnReceiver('get_uri', this, [mimeType]);
}

abstract class Table extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'Table');

  dynamic getGProperty(String name);
  void setGProperty(String name, dynamic value);
  bool addColumnSelection(int column) => _staticInfo.callMethodOnReceiver('add_column_selection', this, [column]);
  bool addRowSelection(int row) => _staticInfo.callMethodOnReceiver('add_row_selection', this, [row]);
  AtkObject get caption => _staticInfo.callMethodOnReceiver('get_caption', this, []);
  int getColumnAtIndex(int index_) => _staticInfo.callMethodOnReceiver('get_column_at_index', this, [index_]);
  String getColumnDescription(int column) => _staticInfo.callMethodOnReceiver('get_column_description', this, [column]);
  int getColumnExtentAt(int row, int column) => _staticInfo.callMethodOnReceiver('get_column_extent_at', this, [row, column]);
  AtkObject getColumnHeader(int column) => _staticInfo.callMethodOnReceiver('get_column_header', this, [column]);
  int getIndexAt(int row, int column) => _staticInfo.callMethodOnReceiver('get_index_at', this, [row, column]);
  int get nColumns => _staticInfo.callMethodOnReceiver('get_n_columns', this, []);
  int get nRows => _staticInfo.callMethodOnReceiver('get_n_rows', this, []);
  int getRowAtIndex(int index_) => _staticInfo.callMethodOnReceiver('get_row_at_index', this, [index_]);
  String getRowDescription(int row) => _staticInfo.callMethodOnReceiver('get_row_description', this, [row]);
  int getRowExtentAt(int row, int column) => _staticInfo.callMethodOnReceiver('get_row_extent_at', this, [row, column]);
  AtkObject getRowHeader(int row) => _staticInfo.callMethodOnReceiver('get_row_header', this, [row]);
  int getSelectedColumns(int selected) => _staticInfo.callMethodOnReceiver('get_selected_columns', this, [selected]);
  int getSelectedRows(int selected) => _staticInfo.callMethodOnReceiver('get_selected_rows', this, [selected]);
  AtkObject get summary => _staticInfo.callMethodOnReceiver('get_summary', this, []);
  bool isColumnSelected(int column) => _staticInfo.callMethodOnReceiver('is_column_selected', this, [column]);
  bool isRowSelected(int row) => _staticInfo.callMethodOnReceiver('is_row_selected', this, [row]);
  bool isSelected(int row, int column) => _staticInfo.callMethodOnReceiver('is_selected', this, [row, column]);
  AtkObject refAt(int row, int column) => _staticInfo.callMethodOnReceiver('ref_at', this, [row, column]);
  bool removeColumnSelection(int column) => _staticInfo.callMethodOnReceiver('remove_column_selection', this, [column]);
  bool removeRowSelection(int row) => _staticInfo.callMethodOnReceiver('remove_row_selection', this, [row]);
  void set caption(AtkObject caption) => _staticInfo.callMethodOnReceiver('set_caption', this, [caption]);
  void setColumnDescription(int column, String description) => _staticInfo.callMethodOnReceiver('set_column_description', this, [column, description]);
  void setColumnHeader(int column, AtkObject header) => _staticInfo.callMethodOnReceiver('set_column_header', this, [column, header]);
  void setRowDescription(int row, String description) => _staticInfo.callMethodOnReceiver('set_row_description', this, [row, description]);
  void setRowHeader(int row, AtkObject header) => _staticInfo.callMethodOnReceiver('set_row_header', this, [row, header]);
  void set summary(AtkObject accessible) => _staticInfo.callMethodOnReceiver('set_summary', this, [accessible]);
  int _connectToColumnDeleted(bool after, void func(int arg1, int arg2)) => signalConnect('column-deleted', func, after);
  Stream<TableColumnDeletedEvent> get onColumnDeleted {
    int signalId;
    StreamController<TableColumnDeletedEvent> controller;
    controller = new StreamController<TableColumnDeletedEvent>(
      onListen: () {
          signalId = _connectToColumnDeleted(false, (int arg1, int arg2) {
              var result = new TableColumnDeletedEvent(arg1, arg2);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<TableColumnDeletedEvent> get afterColumnDeleted {
    int signalId;
    StreamController<TableColumnDeletedEvent> controller;
    controller = new StreamController<TableColumnDeletedEvent>(
      onListen: () {
          signalId = _connectToColumnDeleted(true, (int arg1, int arg2) {
              var result = new TableColumnDeletedEvent(arg1, arg2);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToColumnInserted(bool after, void func(int arg1, int arg2)) => signalConnect('column-inserted', func, after);
  Stream<TableColumnInsertedEvent> get onColumnInserted {
    int signalId;
    StreamController<TableColumnInsertedEvent> controller;
    controller = new StreamController<TableColumnInsertedEvent>(
      onListen: () {
          signalId = _connectToColumnInserted(false, (int arg1, int arg2) {
              var result = new TableColumnInsertedEvent(arg1, arg2);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<TableColumnInsertedEvent> get afterColumnInserted {
    int signalId;
    StreamController<TableColumnInsertedEvent> controller;
    controller = new StreamController<TableColumnInsertedEvent>(
      onListen: () {
          signalId = _connectToColumnInserted(true, (int arg1, int arg2) {
              var result = new TableColumnInsertedEvent(arg1, arg2);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToColumnReordered(bool after, void func()) => signalConnect('column-reordered', func, after);
  Stream get onColumnReordered {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToColumnReordered(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterColumnReordered {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToColumnReordered(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToModelChanged(bool after, void func()) => signalConnect('model-changed', func, after);
  Stream get onModelChanged {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToModelChanged(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterModelChanged {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToModelChanged(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToRowDeleted(bool after, void func(int arg1, int arg2)) => signalConnect('row-deleted', func, after);
  Stream<TableRowDeletedEvent> get onRowDeleted {
    int signalId;
    StreamController<TableRowDeletedEvent> controller;
    controller = new StreamController<TableRowDeletedEvent>(
      onListen: () {
          signalId = _connectToRowDeleted(false, (int arg1, int arg2) {
              var result = new TableRowDeletedEvent(arg1, arg2);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<TableRowDeletedEvent> get afterRowDeleted {
    int signalId;
    StreamController<TableRowDeletedEvent> controller;
    controller = new StreamController<TableRowDeletedEvent>(
      onListen: () {
          signalId = _connectToRowDeleted(true, (int arg1, int arg2) {
              var result = new TableRowDeletedEvent(arg1, arg2);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToRowInserted(bool after, void func(int arg1, int arg2)) => signalConnect('row-inserted', func, after);
  Stream<TableRowInsertedEvent> get onRowInserted {
    int signalId;
    StreamController<TableRowInsertedEvent> controller;
    controller = new StreamController<TableRowInsertedEvent>(
      onListen: () {
          signalId = _connectToRowInserted(false, (int arg1, int arg2) {
              var result = new TableRowInsertedEvent(arg1, arg2);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<TableRowInsertedEvent> get afterRowInserted {
    int signalId;
    StreamController<TableRowInsertedEvent> controller;
    controller = new StreamController<TableRowInsertedEvent>(
      onListen: () {
          signalId = _connectToRowInserted(true, (int arg1, int arg2) {
              var result = new TableRowInsertedEvent(arg1, arg2);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToRowReordered(bool after, void func()) => signalConnect('row-reordered', func, after);
  Stream get onRowReordered {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToRowReordered(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterRowReordered {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToRowReordered(true, () {
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

class TableColumnDeletedEvent {
  final int arg1;
  final int arg2;

  TableColumnDeletedEvent(this.arg1, this.arg2);
}

class TableColumnInsertedEvent {
  final int arg1;
  final int arg2;

  TableColumnInsertedEvent(this.arg1, this.arg2);
}

class TableRowDeletedEvent {
  final int arg1;
  final int arg2;

  TableRowDeletedEvent(this.arg1, this.arg2);
}

class TableRowInsertedEvent {
  final int arg1;
  final int arg2;

  TableRowInsertedEvent(this.arg1, this.arg2);
}

abstract class TableCell extends GObjectBase implements AtkObject {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'TableCell');

  dynamic getGProperty(String name);
  void setGProperty(String name, dynamic value);
  List<AtkObject> get columnHeaderCells => _staticInfo.callMethodOnReceiver('get_column_header_cells', this, []);
  int get columnSpan => _staticInfo.callMethodOnReceiver('get_column_span', this, []);
  List getPosition() => _staticInfo.callMethodOnReceiver('get_position', this, []);
  List getRowColumnSpan() => _staticInfo.callMethodOnReceiver('get_row_column_span', this, []);
  List<AtkObject> get rowHeaderCells => _staticInfo.callMethodOnReceiver('get_row_header_cells', this, []);
  int get rowSpan => _staticInfo.callMethodOnReceiver('get_row_span', this, []);
  AtkObject get table => _staticInfo.callMethodOnReceiver('get_table', this, []);
}

abstract class Text extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'Text');

  dynamic getGProperty(String name);
  void setGProperty(String name, dynamic value);
  static void freeRanges(List<TextRange> ranges) => _staticInfo.callStatic('free_ranges', [ranges]);
  bool textAddSelection(int startOffset, int endOffset) => _staticInfo.callMethodOnReceiver('add_selection', this, [startOffset, endOffset]);
  List<TextRange> getBoundedRanges(TextRectangle rect, CoordType coordType, TextClipType xClipType, TextClipType yClipType) => _staticInfo.callMethodOnReceiver('get_bounded_ranges', this, [rect, coordType, xClipType, yClipType]);
  int get caretOffset => _staticInfo.callMethodOnReceiver('get_caret_offset', this, []);
  int getCharacterAtOffset(int offset) => _staticInfo.callMethodOnReceiver('get_character_at_offset', this, [offset]);
  int get characterCount => _staticInfo.callMethodOnReceiver('get_character_count', this, []);
  void getCharacterExtents(int offset, int x, int y, int width, int height, CoordType coords) => _staticInfo.callMethodOnReceiver('get_character_extents', this, [offset, x, y, width, height, coords]);
  SList /* this will fail */ get defaultAttributes => _staticInfo.callMethodOnReceiver('get_default_attributes', this, []);
  int get nSelections => _staticInfo.callMethodOnReceiver('get_n_selections', this, []);
  int getOffsetAtPoint(int x, int y, CoordType coords) => _staticInfo.callMethodOnReceiver('get_offset_at_point', this, [x, y, coords]);
  void getRangeExtents(int startOffset, int endOffset, CoordType coordType, TextRectangle rect) => _staticInfo.callMethodOnReceiver('get_range_extents', this, [startOffset, endOffset, coordType, rect]);
  List getRunAttributes(int offset) => _staticInfo.callMethodOnReceiver('get_run_attributes', this, [offset]);
  List getSelection(int selectionNum) => _staticInfo.callMethodOnReceiver('get_selection', this, [selectionNum]);
  List getStringAtOffset(int offset, TextGranularity granularity) => _staticInfo.callMethodOnReceiver('get_string_at_offset', this, [offset, granularity]);
  String getText(int startOffset, int endOffset) => _staticInfo.callMethodOnReceiver('get_text', this, [startOffset, endOffset]);
  List getTextAfterOffset(int offset, TextBoundary boundaryType) => _staticInfo.callMethodOnReceiver('get_text_after_offset', this, [offset, boundaryType]);
  List getTextAtOffset(int offset, TextBoundary boundaryType) => _staticInfo.callMethodOnReceiver('get_text_at_offset', this, [offset, boundaryType]);
  List getTextBeforeOffset(int offset, TextBoundary boundaryType) => _staticInfo.callMethodOnReceiver('get_text_before_offset', this, [offset, boundaryType]);
  bool removeSelection(int selectionNum) => _staticInfo.callMethodOnReceiver('remove_selection', this, [selectionNum]);
  bool setCaretOffset(int offset) => _staticInfo.callMethodOnReceiver('set_caret_offset', this, [offset]);
  bool setSelection(int selectionNum, int startOffset, int endOffset) => _staticInfo.callMethodOnReceiver('set_selection', this, [selectionNum, startOffset, endOffset]);
  int _connectToTextAttributesChanged(bool after, void func()) => signalConnect('text-attributes-changed', func, after);
  Stream get onTextAttributesChanged {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToTextAttributesChanged(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterTextAttributesChanged {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToTextAttributesChanged(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToTextCaretMoved(bool after, void func(int arg1)) => signalConnect('text-caret-moved', func, after);
  Stream<int> get onTextCaretMoved {
    int signalId;
    StreamController<int> controller;
    controller = new StreamController<int>(
      onListen: () {
          signalId = _connectToTextCaretMoved(false, (int arg1) {
              controller.add(arg1);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<int> get afterTextCaretMoved {
    int signalId;
    StreamController<int> controller;
    controller = new StreamController<int>(
      onListen: () {
          signalId = _connectToTextCaretMoved(true, (int arg1) {
              controller.add(arg1);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToTextChanged(bool after, void func(int arg1, int arg2)) => signalConnect('text-changed', func, after);
  Stream<TextTextChangedEvent> get onTextChanged {
    int signalId;
    StreamController<TextTextChangedEvent> controller;
    controller = new StreamController<TextTextChangedEvent>(
      onListen: () {
          signalId = _connectToTextChanged(false, (int arg1, int arg2) {
              var result = new TextTextChangedEvent(arg1, arg2);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<TextTextChangedEvent> get afterTextChanged {
    int signalId;
    StreamController<TextTextChangedEvent> controller;
    controller = new StreamController<TextTextChangedEvent>(
      onListen: () {
          signalId = _connectToTextChanged(true, (int arg1, int arg2) {
              var result = new TextTextChangedEvent(arg1, arg2);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToTextInsert(bool after, void func(int arg1, int arg2, String arg3)) => signalConnect('text-insert', func, after);
  Stream<TextTextInsertEvent> get onTextInsert {
    int signalId;
    StreamController<TextTextInsertEvent> controller;
    controller = new StreamController<TextTextInsertEvent>(
      onListen: () {
          signalId = _connectToTextInsert(false, (int arg1, int arg2, String arg3) {
              var result = new TextTextInsertEvent(arg1, arg2, arg3);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<TextTextInsertEvent> get afterTextInsert {
    int signalId;
    StreamController<TextTextInsertEvent> controller;
    controller = new StreamController<TextTextInsertEvent>(
      onListen: () {
          signalId = _connectToTextInsert(true, (int arg1, int arg2, String arg3) {
              var result = new TextTextInsertEvent(arg1, arg2, arg3);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToTextRemove(bool after, void func(int arg1, int arg2, String arg3)) => signalConnect('text-remove', func, after);
  Stream<TextTextRemoveEvent> get onTextRemove {
    int signalId;
    StreamController<TextTextRemoveEvent> controller;
    controller = new StreamController<TextTextRemoveEvent>(
      onListen: () {
          signalId = _connectToTextRemove(false, (int arg1, int arg2, String arg3) {
              var result = new TextTextRemoveEvent(arg1, arg2, arg3);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<TextTextRemoveEvent> get afterTextRemove {
    int signalId;
    StreamController<TextTextRemoveEvent> controller;
    controller = new StreamController<TextTextRemoveEvent>(
      onListen: () {
          signalId = _connectToTextRemove(true, (int arg1, int arg2, String arg3) {
              var result = new TextTextRemoveEvent(arg1, arg2, arg3);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToTextSelectionChanged(bool after, void func()) => signalConnect('text-selection-changed', func, after);
  Stream get onTextSelectionChanged {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToTextSelectionChanged(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterTextSelectionChanged {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToTextSelectionChanged(true, () {
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

class TextTextChangedEvent {
  final int arg1;
  final int arg2;

  TextTextChangedEvent(this.arg1, this.arg2);
}

class TextTextInsertEvent {
  final int arg1;
  final int arg2;
  final String arg3;

  TextTextInsertEvent(this.arg1, this.arg2, this.arg3);
}

class TextTextRemoveEvent {
  final int arg1;
  final int arg2;
  final String arg3;

  TextTextRemoveEvent(this.arg1, this.arg2, this.arg3);
}

class TextAttribute extends GEnumBase {
  const TextAttribute(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'TextAttribute');

  static const TextAttribute INVALID = const TextAttribute(0);
  static const TextAttribute LEFT_MARGIN = const TextAttribute(1);
  static const TextAttribute RIGHT_MARGIN = const TextAttribute(2);
  static const TextAttribute INDENT = const TextAttribute(3);
  static const TextAttribute INVISIBLE = const TextAttribute(4);
  static const TextAttribute EDITABLE = const TextAttribute(5);
  static const TextAttribute PIXELS_ABOVE_LINES = const TextAttribute(6);
  static const TextAttribute PIXELS_BELOW_LINES = const TextAttribute(7);
  static const TextAttribute PIXELS_INSIDE_WRAP = const TextAttribute(8);
  static const TextAttribute BG_FULL_HEIGHT = const TextAttribute(9);
  static const TextAttribute RISE = const TextAttribute(10);
  static const TextAttribute UNDERLINE = const TextAttribute(11);
  static const TextAttribute STRIKETHROUGH = const TextAttribute(12);
  static const TextAttribute SIZE = const TextAttribute(13);
  static const TextAttribute SCALE = const TextAttribute(14);
  static const TextAttribute WEIGHT = const TextAttribute(15);
  static const TextAttribute LANGUAGE = const TextAttribute(16);
  static const TextAttribute FAMILY_NAME = const TextAttribute(17);
  static const TextAttribute BG_COLOR = const TextAttribute(18);
  static const TextAttribute FG_COLOR = const TextAttribute(19);
  static const TextAttribute BG_STIPPLE = const TextAttribute(20);
  static const TextAttribute FG_STIPPLE = const TextAttribute(21);
  static const TextAttribute WRAP_MODE = const TextAttribute(22);
  static const TextAttribute DIRECTION = const TextAttribute(23);
  static const TextAttribute JUSTIFICATION = const TextAttribute(24);
  static const TextAttribute STRETCH = const TextAttribute(25);
  static const TextAttribute VARIANT = const TextAttribute(26);
  static const TextAttribute STYLE = const TextAttribute(27);
  static const TextAttribute LAST_DEFINED = const TextAttribute(28);
  String toString() {
    switch(value) {
      case 0: return 'TextAttribute.INVALID';
      case 1: return 'TextAttribute.LEFT_MARGIN';
      case 2: return 'TextAttribute.RIGHT_MARGIN';
      case 3: return 'TextAttribute.INDENT';
      case 4: return 'TextAttribute.INVISIBLE';
      case 5: return 'TextAttribute.EDITABLE';
      case 6: return 'TextAttribute.PIXELS_ABOVE_LINES';
      case 7: return 'TextAttribute.PIXELS_BELOW_LINES';
      case 8: return 'TextAttribute.PIXELS_INSIDE_WRAP';
      case 9: return 'TextAttribute.BG_FULL_HEIGHT';
      case 10: return 'TextAttribute.RISE';
      case 11: return 'TextAttribute.UNDERLINE';
      case 12: return 'TextAttribute.STRIKETHROUGH';
      case 13: return 'TextAttribute.SIZE';
      case 14: return 'TextAttribute.SCALE';
      case 15: return 'TextAttribute.WEIGHT';
      case 16: return 'TextAttribute.LANGUAGE';
      case 17: return 'TextAttribute.FAMILY_NAME';
      case 18: return 'TextAttribute.BG_COLOR';
      case 19: return 'TextAttribute.FG_COLOR';
      case 20: return 'TextAttribute.BG_STIPPLE';
      case 21: return 'TextAttribute.FG_STIPPLE';
      case 22: return 'TextAttribute.WRAP_MODE';
      case 23: return 'TextAttribute.DIRECTION';
      case 24: return 'TextAttribute.JUSTIFICATION';
      case 25: return 'TextAttribute.STRETCH';
      case 26: return 'TextAttribute.VARIANT';
      case 27: return 'TextAttribute.STYLE';
      case 28: return 'TextAttribute.LAST_DEFINED';
      default: return 'new TextAttribute($value)';
    }
  }
  static TextAttribute forName(String name) => _staticInfo.callStatic('for_name', [name]);
  static String getName(TextAttribute attr) => _staticInfo.callStatic('get_name', [attr]);
  static String getValue(TextAttribute attr, int index_) => _staticInfo.callStatic('get_value', [attr, index_]);
  static TextAttribute register(String name) => _staticInfo.callStatic('register', [name]);
}

class TextBoundary extends GEnumBase {
  const TextBoundary(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'TextBoundary');

  static const TextBoundary CHAR = const TextBoundary(0);
  static const TextBoundary WORD_START = const TextBoundary(1);
  static const TextBoundary WORD_END = const TextBoundary(2);
  static const TextBoundary SENTENCE_START = const TextBoundary(3);
  static const TextBoundary SENTENCE_END = const TextBoundary(4);
  static const TextBoundary LINE_START = const TextBoundary(5);
  static const TextBoundary LINE_END = const TextBoundary(6);
  String toString() {
    switch(value) {
      case 0: return 'TextBoundary.CHAR';
      case 1: return 'TextBoundary.WORD_START';
      case 2: return 'TextBoundary.WORD_END';
      case 3: return 'TextBoundary.SENTENCE_START';
      case 4: return 'TextBoundary.SENTENCE_END';
      case 5: return 'TextBoundary.LINE_START';
      case 6: return 'TextBoundary.LINE_END';
      default: return 'new TextBoundary($value)';
    }
  }
}

class TextClipType extends GEnumBase {
  const TextClipType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'TextClipType');

  static const TextClipType NONE = const TextClipType(0);
  static const TextClipType MIN = const TextClipType(1);
  static const TextClipType MAX = const TextClipType(2);
  static const TextClipType BOTH = const TextClipType(3);
  String toString() {
    switch(value) {
      case 0: return 'TextClipType.NONE';
      case 1: return 'TextClipType.MIN';
      case 2: return 'TextClipType.MAX';
      case 3: return 'TextClipType.BOTH';
      default: return 'new TextClipType($value)';
    }
  }
}

class TextGranularity extends GEnumBase {
  const TextGranularity(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'TextGranularity');

  static const TextGranularity CHAR = const TextGranularity(0);
  static const TextGranularity WORD = const TextGranularity(1);
  static const TextGranularity SENTENCE = const TextGranularity(2);
  static const TextGranularity LINE = const TextGranularity(3);
  static const TextGranularity PARAGRAPH = const TextGranularity(4);
  String toString() {
    switch(value) {
      case 0: return 'TextGranularity.CHAR';
      case 1: return 'TextGranularity.WORD';
      case 2: return 'TextGranularity.SENTENCE';
      case 3: return 'TextGranularity.LINE';
      case 4: return 'TextGranularity.PARAGRAPH';
      default: return 'new TextGranularity($value)';
    }
  }
}

class TextRange extends GObjectBase {
  TextRange.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'TextRange');

  TextRectangle get bounds => getFieldOfObject('bounds', 0);
  void set bounds(TextRectangle value) => setFieldOfObject('bounds', 0, value);
  int get startOffset => getFieldOfObject('start_offset', 1);
  void set startOffset(int value) => setFieldOfObject('start_offset', 1, value);
  int get endOffset => getFieldOfObject('end_offset', 2);
  void set endOffset(int value) => setFieldOfObject('end_offset', 2, value);
  String get content => getFieldOfObject('content', 3);
  void set content(String value) => setFieldOfObject('content', 3, value);
}

class TextRectangle extends GObjectBase {
  TextRectangle.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'TextRectangle');

  int get x => getFieldOfObject('x', 0);
  void set x(int value) => setFieldOfObject('x', 0, value);
  int get y => getFieldOfObject('y', 1);
  void set y(int value) => setFieldOfObject('y', 1, value);
  int get width => getFieldOfObject('width', 2);
  void set width(int value) => setFieldOfObject('width', 2, value);
  int get height => getFieldOfObject('height', 3);
  void set height(int value) => setFieldOfObject('height', 3, value);
}

class Util extends GObjectObject {
  Util.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'Util');

}

abstract class Value extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'Value');

  dynamic getGProperty(String name);
  void setGProperty(String name, dynamic value);
  void getCurrentValue(Value value) => _staticInfo.callMethodOnReceiver('get_current_value', this, [value]);
  num get increment => _staticInfo.callMethodOnReceiver('get_increment', this, []);
  void getMaximumValue(Value value) => _staticInfo.callMethodOnReceiver('get_maximum_value', this, [value]);
  void getMinimumIncrement(Value value) => _staticInfo.callMethodOnReceiver('get_minimum_increment', this, [value]);
  void getMinimumValue(Value value) => _staticInfo.callMethodOnReceiver('get_minimum_value', this, [value]);
  Range get range => _staticInfo.callMethodOnReceiver('get_range', this, []);
  SList /* this will fail */ get subRanges => _staticInfo.callMethodOnReceiver('get_sub_ranges', this, []);
  List getValueAndText() => _staticInfo.callMethodOnReceiver('get_value_and_text', this, []);
  bool setCurrentValue(Value value) => _staticInfo.callMethodOnReceiver('set_current_value', this, [value]);
  void setValue(num newValue) => _staticInfo.callMethodOnReceiver('set_value', this, [newValue]);
  int _connectToValueChanged(bool after, void func(num value, String text)) => signalConnect('value-changed', func, after);
  Stream<ValueValueChangedEvent> get onValueChanged {
    int signalId;
    StreamController<ValueValueChangedEvent> controller;
    controller = new StreamController<ValueValueChangedEvent>(
      onListen: () {
          signalId = _connectToValueChanged(false, (num value, String text) {
              var result = new ValueValueChangedEvent(value, text);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<ValueValueChangedEvent> get afterValueChanged {
    int signalId;
    StreamController<ValueValueChangedEvent> controller;
    controller = new StreamController<ValueValueChangedEvent>(
      onListen: () {
          signalId = _connectToValueChanged(true, (num value, String text) {
              var result = new ValueValueChangedEvent(value, text);
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

class ValueValueChangedEvent {
  final num value;
  final String text;

  ValueValueChangedEvent(this.value, this.text);
}

class ValueType extends GEnumBase {
  const ValueType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'ValueType');

  static const ValueType VERY_WEAK = const ValueType(0);
  static const ValueType WEAK = const ValueType(1);
  static const ValueType ACCEPTABLE = const ValueType(2);
  static const ValueType STRONG = const ValueType(3);
  static const ValueType VERY_STRONG = const ValueType(4);
  static const ValueType VERY_LOW = const ValueType(5);
  static const ValueType LOW = const ValueType(6);
  static const ValueType MEDIUM = const ValueType(7);
  static const ValueType HIGH = const ValueType(8);
  static const ValueType VERY_HIGH = const ValueType(9);
  static const ValueType VERY_BAD = const ValueType(10);
  static const ValueType BAD = const ValueType(11);
  static const ValueType GOOD = const ValueType(12);
  static const ValueType VERY_GOOD = const ValueType(13);
  static const ValueType BEST = const ValueType(14);
  static const ValueType LAST_DEFINED = const ValueType(15);
  String toString() {
    switch(value) {
      case 0: return 'ValueType.VERY_WEAK';
      case 1: return 'ValueType.WEAK';
      case 2: return 'ValueType.ACCEPTABLE';
      case 3: return 'ValueType.STRONG';
      case 4: return 'ValueType.VERY_STRONG';
      case 5: return 'ValueType.VERY_LOW';
      case 6: return 'ValueType.LOW';
      case 7: return 'ValueType.MEDIUM';
      case 8: return 'ValueType.HIGH';
      case 9: return 'ValueType.VERY_HIGH';
      case 10: return 'ValueType.VERY_BAD';
      case 11: return 'ValueType.BAD';
      case 12: return 'ValueType.GOOD';
      case 13: return 'ValueType.VERY_GOOD';
      case 14: return 'ValueType.BEST';
      case 15: return 'ValueType.LAST_DEFINED';
      default: return 'new ValueType($value)';
    }
  }
  static String getLocalizedName(ValueType valueType) => _staticInfo.callStatic('get_localized_name', [valueType]);
  static String getName(ValueType valueType) => _staticInfo.callStatic('get_name', [valueType]);
}

abstract class Window extends GObjectBase implements AtkObject {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Atk', 'Window');

  dynamic getGProperty(String name);
  void setGProperty(String name, dynamic value);
  int _connectToActivate(bool after, void func()) => signalConnect('activate', func, after);
  Stream get onActivate {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToActivate(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterActivate {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToActivate(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToCreate(bool after, void func()) => signalConnect('create', func, after);
  Stream get onCreate {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToCreate(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterCreate {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToCreate(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToDeactivate(bool after, void func()) => signalConnect('deactivate', func, after);
  Stream get onDeactivate {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToDeactivate(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterDeactivate {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToDeactivate(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToDestroy(bool after, void func()) => signalConnect('destroy', func, after);
  Stream get onDestroy {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToDestroy(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterDestroy {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToDestroy(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToMaximize(bool after, void func()) => signalConnect('maximize', func, after);
  Stream get onMaximize {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToMaximize(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterMaximize {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToMaximize(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToMinimize(bool after, void func()) => signalConnect('minimize', func, after);
  Stream get onMinimize {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToMinimize(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterMinimize {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToMinimize(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToMove(bool after, void func()) => signalConnect('move', func, after);
  Stream get onMove {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToMove(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterMove {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToMove(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToResize(bool after, void func()) => signalConnect('resize', func, after);
  Stream get onResize {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToResize(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterResize {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToResize(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToRestore(bool after, void func()) => signalConnect('restore', func, after);
  Stream get onRestore {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToRestore(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterRestore {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToRestore(true, () {
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

void attributeSetFree(SList attribSet /* this will fail */) => callStaticGlobal('Atk', 'attribute_set_free', [attribSet]);

void focusTrackerNotify(AtkObject object) => callStaticGlobal('Atk', 'focus_tracker_notify', [object]);

int getBinaryAge() => callStaticGlobal('Atk', 'get_binary_age', []);

Registry getDefaultRegistry() => callStaticGlobal('Atk', 'get_default_registry', []);

AtkObject getFocusObject() => callStaticGlobal('Atk', 'get_focus_object', []);

int getInterfaceAge() => callStaticGlobal('Atk', 'get_interface_age', []);

int getMajorVersion() => callStaticGlobal('Atk', 'get_major_version', []);

int getMicroVersion() => callStaticGlobal('Atk', 'get_micro_version', []);

int getMinorVersion() => callStaticGlobal('Atk', 'get_minor_version', []);

AtkObject getRoot() => callStaticGlobal('Atk', 'get_root', []);

String getToolkitName() => callStaticGlobal('Atk', 'get_toolkit_name', []);

String getToolkitVersion() => callStaticGlobal('Atk', 'get_toolkit_version', []);

String getVersion() => callStaticGlobal('Atk', 'get_version', []);

RelationType relationTypeForName(String name) => callStaticGlobal('Atk', 'relation_type_for_name', [name]);

String relationTypeGetName(RelationType type) => callStaticGlobal('Atk', 'relation_type_get_name', [type]);

RelationType relationTypeRegister(String name) => callStaticGlobal('Atk', 'relation_type_register', [name]);

void removeFocusTracker(int trackerId) => callStaticGlobal('Atk', 'remove_focus_tracker', [trackerId]);

void removeGlobalEventListener(int listenerId) => callStaticGlobal('Atk', 'remove_global_event_listener', [listenerId]);

void removeKeyEventListener(int listenerId) => callStaticGlobal('Atk', 'remove_key_event_listener', [listenerId]);

Role roleForName(String name) => callStaticGlobal('Atk', 'role_for_name', [name]);

String roleGetLocalizedName(Role role) => callStaticGlobal('Atk', 'role_get_localized_name', [role]);

String roleGetName(Role role) => callStaticGlobal('Atk', 'role_get_name', [role]);

Role roleRegister(String name) => callStaticGlobal('Atk', 'role_register', [name]);

StateType stateTypeForName(String name) => callStaticGlobal('Atk', 'state_type_for_name', [name]);

String stateTypeGetName(StateType type) => callStaticGlobal('Atk', 'state_type_get_name', [type]);

StateType stateTypeRegister(String name) => callStaticGlobal('Atk', 'state_type_register', [name]);

TextAttribute textAttributeForName(String name) => callStaticGlobal('Atk', 'text_attribute_for_name', [name]);

String textAttributeGetName(TextAttribute attr) => callStaticGlobal('Atk', 'text_attribute_get_name', [attr]);

String textAttributeGetValue(TextAttribute attr, int index_) => callStaticGlobal('Atk', 'text_attribute_get_value', [attr, index_]);

TextAttribute textAttributeRegister(String name) => callStaticGlobal('Atk', 'text_attribute_register', [name]);

void textFreeRanges(List<TextRange> ranges) => callStaticGlobal('Atk', 'text_free_ranges', [ranges]);

String valueTypeGetLocalizedName(ValueType valueType) => callStaticGlobal('Atk', 'value_type_get_localized_name', [valueType]);

String valueTypeGetName(ValueType valueType) => callStaticGlobal('Atk', 'value_type_get_name', [valueType]);

bool _initLibraryStarted = false;

void initLibrary() {
  if (_initLibraryStarted) return;
  _initLibraryStarted = true;
  gobject.initLibrary();
  registerInterceptorTypeForNamedType("Atk", "Attribute",Attribute);
  registerInterceptorTypeForNamedType("Atk", "CoordType",CoordType);
  registerInterceptorTypeForNamedType("Atk", "GObjectAccessible",GObjectAccessible);
  registerInterceptorTypeForNamedType("Atk", "Hyperlink",Hyperlink);
  registerInterceptorTypeForNamedType("Atk", "HyperlinkStateFlags",HyperlinkStateFlags);
  registerInterceptorTypeForNamedType("Atk", "Implementor",Implementor);
  registerInterceptorTypeForNamedType("Atk", "KeyEventStruct",KeyEventStruct);
  registerInterceptorTypeForNamedType("Atk", "KeyEventType",KeyEventType);
  registerInterceptorTypeForNamedType("Atk", "Layer",Layer);
  registerInterceptorTypeForNamedType("Atk", "Misc",Misc);
  registerInterceptorTypeForNamedType("Atk", "NoOpObject",NoOpObject);
  registerInterceptorTypeForNamedType("Atk", "NoOpObjectFactory",NoOpObjectFactory);
  registerInterceptorTypeForNamedType("Atk", "Object",AtkObject);
  registerInterceptorTypeForNamedType("Atk", "ObjectFactory",ObjectFactory);
  registerInterceptorTypeForNamedType("Atk", "Plug",Plug);
  registerInterceptorTypeForNamedType("Atk", "PropertyValues",PropertyValues);
  registerInterceptorTypeForNamedType("Atk", "Range",Range);
  registerInterceptorTypeForNamedType("Atk", "Rectangle",Rectangle);
  registerInterceptorTypeForNamedType("Atk", "Registry",Registry);
  registerInterceptorTypeForNamedType("Atk", "Relation",Relation);
  registerInterceptorTypeForNamedType("Atk", "RelationSet",RelationSet);
  registerInterceptorTypeForNamedType("Atk", "RelationType",RelationType);
  registerInterceptorTypeForNamedType("Atk", "Role",Role);
  registerInterceptorTypeForNamedType("Atk", "Socket",Socket);
  registerInterceptorTypeForNamedType("Atk", "StateSet",StateSet);
  registerInterceptorTypeForNamedType("Atk", "StateType",StateType);
  registerInterceptorTypeForNamedType("Atk", "TextAttribute",TextAttribute);
  registerInterceptorTypeForNamedType("Atk", "TextBoundary",TextBoundary);
  registerInterceptorTypeForNamedType("Atk", "TextClipType",TextClipType);
  registerInterceptorTypeForNamedType("Atk", "TextGranularity",TextGranularity);
  registerInterceptorTypeForNamedType("Atk", "TextRange",TextRange);
  registerInterceptorTypeForNamedType("Atk", "TextRectangle",TextRectangle);
  registerInterceptorTypeForNamedType("Atk", "Util",Util);
  registerInterceptorTypeForNamedType("Atk", "ValueType",ValueType);
}
