library gio.gdart;

import "gdart.dart";

import "dart:async";

import "glib.dart" hide initLibrary;
import "gobject.dart" hide initLibrary;
import "gobject.dart" as gobject;

abstract class Action extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'Action');



  static const String ENABLED_PROPERTY = 'enabled';
  static const String NAME_PROPERTY = 'name';
  static const String PARAMETER_TYPE_PROPERTY = 'parameter-type';
  static const String STATE_PROPERTY = 'state';
  static const String STATE_TYPE_PROPERTY = 'state-type';
  static bool nameIsValid(String actionName) => _staticInfo.callStatic('name_is_valid', [actionName]);
  static List parseDetailedName(String detailedName) => _staticInfo.callStatic('parse_detailed_name', [detailedName]);
  static String printDetailedName(String actionName, Variant targetValue) => _staticInfo.callStatic('print_detailed_name', [actionName, targetValue]);
  void activate(Variant parameter) => _staticInfo.callMethodOnReceiver('activate', this, [parameter]);
  void changeState(Variant value) => _staticInfo.callMethodOnReceiver('change_state', this, [value]);
  bool get enabled => _staticInfo.callMethodOnReceiver('get_enabled', this, []);
  String get name => _staticInfo.callMethodOnReceiver('get_name', this, []);
  VariantType get parameterType => _staticInfo.callMethodOnReceiver('get_parameter_type', this, []);
  Variant get state => _staticInfo.callMethodOnReceiver('get_state', this, []);
  Variant get stateHint => _staticInfo.callMethodOnReceiver('get_state_hint', this, []);
  VariantType get stateType => _staticInfo.callMethodOnReceiver('get_state_type', this, []);
}

class ActionEntry extends GObjectBase {
  ActionEntry.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'ActionEntry');

  String get name => getFieldOfObject('name', 0);
  void set name(String value) => setFieldOfObject('name', 0, value);
  String get parameterType => getFieldOfObject('parameter_type', 2);
  void set parameterType(String value) => setFieldOfObject('parameter_type', 2, value);
  String get state => getFieldOfObject('state', 3);
  void set state(String value) => setFieldOfObject('state', 3, value);
  List<int> get padding => getFieldOfObject('padding', 5);
}

abstract class ActionGroup extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'ActionGroup');



  void actionAdded(String actionName) => _staticInfo.callMethodOnReceiver('action_added', this, [actionName]);
  void actionEnabledChanged(String actionName, bool enabled) => _staticInfo.callMethodOnReceiver('action_enabled_changed', this, [actionName, enabled]);
  void actionRemoved(String actionName) => _staticInfo.callMethodOnReceiver('action_removed', this, [actionName]);
  void actionStateChanged(String actionName, Variant state) => _staticInfo.callMethodOnReceiver('action_state_changed', this, [actionName, state]);
  void activateAction(String actionName, Variant parameter) => _staticInfo.callMethodOnReceiver('activate_action', this, [actionName, parameter]);
  void changeActionState(String actionName, Variant value) => _staticInfo.callMethodOnReceiver('change_action_state', this, [actionName, value]);
  bool getActionEnabled(String actionName) => _staticInfo.callMethodOnReceiver('get_action_enabled', this, [actionName]);
  VariantType getActionParameterType(String actionName) => _staticInfo.callMethodOnReceiver('get_action_parameter_type', this, [actionName]);
  Variant getActionState(String actionName) => _staticInfo.callMethodOnReceiver('get_action_state', this, [actionName]);
  Variant getActionStateHint(String actionName) => _staticInfo.callMethodOnReceiver('get_action_state_hint', this, [actionName]);
  VariantType getActionStateType(String actionName) => _staticInfo.callMethodOnReceiver('get_action_state_type', this, [actionName]);
  bool hasAction(String actionName) => _staticInfo.callMethodOnReceiver('has_action', this, [actionName]);
  List<String> listActions() => _staticInfo.callMethodOnReceiver('list_actions', this, []);
  List queryAction(String actionName) => _staticInfo.callMethodOnReceiver('query_action', this, [actionName]);
  int _connectToActionAdded(bool after, void func(String actionName)) => signalConnect('action-added', func, after);
  Stream<String> get onActionAdded {
    int signalId;
    StreamController<String> controller;
    controller = new StreamController<String>(
      onListen: () {
          signalId = _connectToActionAdded(false, (String actionName) {
              controller.add(actionName);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<String> get afterActionAdded {
    int signalId;
    StreamController<String> controller;
    controller = new StreamController<String>(
      onListen: () {
          signalId = _connectToActionAdded(true, (String actionName) {
              controller.add(actionName);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToActionEnabledChanged(bool after, void func(String actionName, bool enabled)) => signalConnect('action-enabled-changed', func, after);
  Stream<ActionGroupActionEnabledChangedEvent> get onActionEnabledChanged {
    int signalId;
    StreamController<ActionGroupActionEnabledChangedEvent> controller;
    controller = new StreamController<ActionGroupActionEnabledChangedEvent>(
      onListen: () {
          signalId = _connectToActionEnabledChanged(false, (String actionName, bool enabled) {
              var result = new ActionGroupActionEnabledChangedEvent(actionName, enabled);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<ActionGroupActionEnabledChangedEvent> get afterActionEnabledChanged {
    int signalId;
    StreamController<ActionGroupActionEnabledChangedEvent> controller;
    controller = new StreamController<ActionGroupActionEnabledChangedEvent>(
      onListen: () {
          signalId = _connectToActionEnabledChanged(true, (String actionName, bool enabled) {
              var result = new ActionGroupActionEnabledChangedEvent(actionName, enabled);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToActionRemoved(bool after, void func(String actionName)) => signalConnect('action-removed', func, after);
  Stream<String> get onActionRemoved {
    int signalId;
    StreamController<String> controller;
    controller = new StreamController<String>(
      onListen: () {
          signalId = _connectToActionRemoved(false, (String actionName) {
              controller.add(actionName);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<String> get afterActionRemoved {
    int signalId;
    StreamController<String> controller;
    controller = new StreamController<String>(
      onListen: () {
          signalId = _connectToActionRemoved(true, (String actionName) {
              controller.add(actionName);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToActionStateChanged(bool after, void func(String actionName, Variant value)) => signalConnect('action-state-changed', func, after);
  Stream<ActionGroupActionStateChangedEvent> get onActionStateChanged {
    int signalId;
    StreamController<ActionGroupActionStateChangedEvent> controller;
    controller = new StreamController<ActionGroupActionStateChangedEvent>(
      onListen: () {
          signalId = _connectToActionStateChanged(false, (String actionName, Variant value) {
              var result = new ActionGroupActionStateChangedEvent(actionName, value);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<ActionGroupActionStateChangedEvent> get afterActionStateChanged {
    int signalId;
    StreamController<ActionGroupActionStateChangedEvent> controller;
    controller = new StreamController<ActionGroupActionStateChangedEvent>(
      onListen: () {
          signalId = _connectToActionStateChanged(true, (String actionName, Variant value) {
              var result = new ActionGroupActionStateChangedEvent(actionName, value);
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

class ActionGroupActionEnabledChangedEvent {
  final String actionName;
  final bool enabled;

  ActionGroupActionEnabledChangedEvent(this.actionName, this.enabled);
}

class ActionGroupActionStateChangedEvent {
  final String actionName;
  final Variant value;

  ActionGroupActionStateChangedEvent(this.actionName, this.value);
}

abstract class ActionMap extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'ActionMap');



  void addAction(Action action) => _staticInfo.callMethodOnReceiver('add_action', this, [action]);
  void addActionEntries(List<ActionEntry> entries, dynamic userData /* this will fail */) => _staticInfo.callMethodOnReceiver('add_action_entries', this, [entries, userData]);
  Action lookupAction(String actionName) => _staticInfo.callMethodOnReceiver('lookup_action', this, [actionName]);
  void removeAction(String actionName) => _staticInfo.callMethodOnReceiver('remove_action', this, [actionName]);
}

abstract class AppInfo extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'AppInfo');



  static AppInfo createFromCommandline(String commandline, String applicationName, AppInfoCreateFlags flags) => _staticInfo.callStatic('create_from_commandline', [commandline, applicationName, flags]);
  static GLibList /* this will fail */ getAll() => _staticInfo.callStatic('get_all', []);
  static GLibList /* this will fail */ getAllForType(String contentType) => _staticInfo.callStatic('get_all_for_type', [contentType]);
  static AppInfo getDefaultForType(String contentType, bool mustSupportUris) => _staticInfo.callStatic('get_default_for_type', [contentType, mustSupportUris]);
  static AppInfo getDefaultForUriScheme(String uriScheme) => _staticInfo.callStatic('get_default_for_uri_scheme', [uriScheme]);
  static GLibList /* this will fail */ getFallbackForType(String contentType) => _staticInfo.callStatic('get_fallback_for_type', [contentType]);
  static GLibList /* this will fail */ getRecommendedForType(String contentType) => _staticInfo.callStatic('get_recommended_for_type', [contentType]);
  static void launchDefaultForUri(String uri, AppLaunchContext launchContext) => _staticInfo.callStatic('launch_default_for_uri', [uri, launchContext]);
  static void resetTypeAssociations(String contentType) => _staticInfo.callStatic('reset_type_associations', [contentType]);
  void addSupportsType(String contentType) => _staticInfo.callMethodOnReceiver('add_supports_type', this, [contentType]);
  bool canDelete() => _staticInfo.callMethodOnReceiver('can_delete', this, []);
  bool canRemoveSupportsType() => _staticInfo.callMethodOnReceiver('can_remove_supports_type', this, []);
  bool delete() => _staticInfo.callMethodOnReceiver('delete', this, []);
  AppInfo dup() => _staticInfo.callMethodOnReceiver('dup', this, []);
  bool equal(AppInfo appinfo2) => _staticInfo.callMethodOnReceiver('equal', this, [appinfo2]);
  String get commandline => _staticInfo.callMethodOnReceiver('get_commandline', this, []);
  String get description => _staticInfo.callMethodOnReceiver('get_description', this, []);
  String get displayName => _staticInfo.callMethodOnReceiver('get_display_name', this, []);
  String get executable => _staticInfo.callMethodOnReceiver('get_executable', this, []);
  Icon get icon => _staticInfo.callMethodOnReceiver('get_icon', this, []);
  String get id => _staticInfo.callMethodOnReceiver('get_id', this, []);
  String get name => _staticInfo.callMethodOnReceiver('get_name', this, []);
  List<String> get supportedTypes => _staticInfo.callMethodOnReceiver('get_supported_types', this, []);
  void launch(GLibList files /* this will fail */, AppLaunchContext launchContext) => _staticInfo.callMethodOnReceiver('launch', this, [files, launchContext]);
  void launchUris(GLibList uris /* this will fail */, AppLaunchContext launchContext) => _staticInfo.callMethodOnReceiver('launch_uris', this, [uris, launchContext]);
  void removeSupportsType(String contentType) => _staticInfo.callMethodOnReceiver('remove_supports_type', this, [contentType]);
  void setAsDefaultForExtension(String extension) => _staticInfo.callMethodOnReceiver('set_as_default_for_extension', this, [extension]);
  void setAsDefaultForType(String contentType) => _staticInfo.callMethodOnReceiver('set_as_default_for_type', this, [contentType]);
  void setAsLastUsedForType(String contentType) => _staticInfo.callMethodOnReceiver('set_as_last_used_for_type', this, [contentType]);
  bool shouldShow() => _staticInfo.callMethodOnReceiver('should_show', this, []);
  bool supportsFiles() => _staticInfo.callMethodOnReceiver('supports_files', this, []);
  bool supportsUris() => _staticInfo.callMethodOnReceiver('supports_uris', this, []);
}

class AppInfoCreateFlags extends GEnumBase {
  const AppInfoCreateFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'AppInfoCreateFlags');

  static const AppInfoCreateFlags NONE = const AppInfoCreateFlags(0);
  bool get none => (index & 0) == 0;
  static const AppInfoCreateFlags NEEDS_TERMINAL = const AppInfoCreateFlags(1);
  bool get needsTerminal => (index & 1) == 1;
  static const AppInfoCreateFlags SUPPORTS_URIS = const AppInfoCreateFlags(2);
  bool get supportsUris => (index & 2) == 2;
  static const AppInfoCreateFlags SUPPORTS_STARTUP_NOTIFICATION = const AppInfoCreateFlags(4);
  bool get supportsStartupNotification => (index & 4) == 4;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'AppInfoCreateFlags.NEEDS_TERMINAL';
      case 2: return 'AppInfoCreateFlags.SUPPORTS_URIS';
      case 4: return 'AppInfoCreateFlags.SUPPORTS_STARTUP_NOTIFICATION';
      default: return 'new AppInfoCreateFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'AppInfoCreateFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 4; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  AppInfoCreateFlags operator|(AppInfoCreateFlags other) =>
    new AppInfoCreateFlags(index | other.index);
  AppInfoCreateFlags operator&(AppInfoCreateFlags other) =>
    new AppInfoCreateFlags(index & other.index);
}

class AppInfoMonitor extends GObjectObject {
  AppInfoMonitor.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'AppInfoMonitor');

  static AppInfoMonitor get_() => _staticInfo.callStatic('get', []);
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

class AppLaunchContext extends GObjectObject {
  AppLaunchContext.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'AppLaunchContext');

  factory AppLaunchContext() => _staticInfo.callStatic('new', []);
  String getDisplay(AppInfo info, GLibList files /* this will fail */) => _staticInfo.callMethodOnReceiver('get_display', this, [info, files]);
  List<String> get environment => _staticInfo.callMethodOnReceiver('get_environment', this, []);
  String getStartupNotifyId(AppInfo info, GLibList files /* this will fail */) => _staticInfo.callMethodOnReceiver('get_startup_notify_id', this, [info, files]);
  void launchFailed(String startupNotifyId) => _staticInfo.callMethodOnReceiver('launch_failed', this, [startupNotifyId]);
  void setenv(String variable, String value) => _staticInfo.callMethodOnReceiver('setenv', this, [variable, value]);
  void unsetenv(String variable) => _staticInfo.callMethodOnReceiver('unsetenv', this, [variable]);
  int _connectToLaunchFailed(bool after, void func(String startupNotifyId)) => signalConnect('launch-failed', func, after);
  Stream<String> get onLaunchFailed {
    int signalId;
    StreamController<String> controller;
    controller = new StreamController<String>(
      onListen: () {
          signalId = _connectToLaunchFailed(false, (String startupNotifyId) {
              controller.add(startupNotifyId);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<String> get afterLaunchFailed {
    int signalId;
    StreamController<String> controller;
    controller = new StreamController<String>(
      onListen: () {
          signalId = _connectToLaunchFailed(true, (String startupNotifyId) {
              controller.add(startupNotifyId);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToLaunched(bool after, void func(AppInfo info, Variant platformData)) => signalConnect('launched', func, after);
  Stream<AppLaunchContextLaunchedEvent> get onLaunched {
    int signalId;
    StreamController<AppLaunchContextLaunchedEvent> controller;
    controller = new StreamController<AppLaunchContextLaunchedEvent>(
      onListen: () {
          signalId = _connectToLaunched(false, (AppInfo info, Variant platformData) {
              var result = new AppLaunchContextLaunchedEvent(info, platformData);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<AppLaunchContextLaunchedEvent> get afterLaunched {
    int signalId;
    StreamController<AppLaunchContextLaunchedEvent> controller;
    controller = new StreamController<AppLaunchContextLaunchedEvent>(
      onListen: () {
          signalId = _connectToLaunched(true, (AppInfo info, Variant platformData) {
              var result = new AppLaunchContextLaunchedEvent(info, platformData);
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

class AppLaunchContextLaunchedEvent {
  final AppInfo info;
  final Variant platformData;

  AppLaunchContextLaunchedEvent(this.info, this.platformData);
}

class Application extends GObjectObject with ActionGroup, ActionMap {
  Application.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'Application');

  static const String ACTION_GROUP_PROPERTY = 'action-group';
  static const String APPLICATION_ID_PROPERTY = 'application-id';
  static const String FLAGS_PROPERTY = 'flags';
  static const String INACTIVITY_TIMEOUT_PROPERTY = 'inactivity-timeout';
  static const String IS_BUSY_PROPERTY = 'is-busy';
  static const String IS_REGISTERED_PROPERTY = 'is-registered';
  static const String IS_REMOTE_PROPERTY = 'is-remote';
  static const String RESOURCE_BASE_PATH_PROPERTY = 'resource-base-path';
  factory Application(String applicationId, ApplicationFlags flags) => _staticInfo.callStatic('new', [applicationId, flags]);
  static Application getDefault() => _staticInfo.callStatic('get_default', []);
  static bool idIsValid(String applicationId) => _staticInfo.callStatic('id_is_valid', [applicationId]);
  void activate() => _staticInfo.callMethodOnReceiver('activate', this, []);
  void addMainOption(String longName, int shortName, OptionFlags flags, OptionArg arg, String description, String argDescription) => _staticInfo.callMethodOnReceiver('add_main_option', this, [longName, shortName, flags, arg, description, argDescription]);
  void addMainOptionEntries(List<OptionEntry> entries) => _staticInfo.callMethodOnReceiver('add_main_option_entries', this, [entries]);
  void addOptionGroup(OptionGroup group) => _staticInfo.callMethodOnReceiver('add_option_group', this, [group]);
  void bindBusyProperty(GObjectObject object, String property) => _staticInfo.callMethodOnReceiver('bind_busy_property', this, [object, property]);
  String get applicationId => _staticInfo.callMethodOnReceiver('get_application_id', this, []);
  DBusConnection get dbusConnection => _staticInfo.callMethodOnReceiver('get_dbus_connection', this, []);
  String get dbusObjectPath => _staticInfo.callMethodOnReceiver('get_dbus_object_path', this, []);
  ApplicationFlags get flags => _staticInfo.callMethodOnReceiver('get_flags', this, []);
  int get inactivityTimeout => _staticInfo.callMethodOnReceiver('get_inactivity_timeout', this, []);
  bool get isBusy => _staticInfo.callMethodOnReceiver('get_is_busy', this, []);
  bool get isRegistered => _staticInfo.callMethodOnReceiver('get_is_registered', this, []);
  bool get isRemote => _staticInfo.callMethodOnReceiver('get_is_remote', this, []);
  String get resourceBasePath => _staticInfo.callMethodOnReceiver('get_resource_base_path', this, []);
  void hold() => _staticInfo.callMethodOnReceiver('hold', this, []);
  void markBusy() => _staticInfo.callMethodOnReceiver('mark_busy', this, []);
  void open(List<File> files, String hint) => _staticInfo.callMethodOnReceiver('open', this, [files, hint]);
  void quit() => _staticInfo.callMethodOnReceiver('quit', this, []);
  void register(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('register', this, [cancellable]);
  void release() => _staticInfo.callMethodOnReceiver('release', this, []);
  int run(List<String> argv) => _staticInfo.callMethodOnReceiver('run', this, [argv]);
  void sendNotification(String id, Notification notification) => _staticInfo.callMethodOnReceiver('send_notification', this, [id, notification]);
  void set actionGroup(ActionGroup actionGroup) => _staticInfo.callMethodOnReceiver('set_action_group', this, [actionGroup]);
  void set applicationId(String applicationId) => _staticInfo.callMethodOnReceiver('set_application_id', this, [applicationId]);
  void setDefault() => _staticInfo.callMethodOnReceiver('set_default', this, []);
  void set flags(ApplicationFlags flags) => _staticInfo.callMethodOnReceiver('set_flags', this, [flags]);
  void set inactivityTimeout(int inactivityTimeout) => _staticInfo.callMethodOnReceiver('set_inactivity_timeout', this, [inactivityTimeout]);
  void set resourceBasePath(String resourcePath) => _staticInfo.callMethodOnReceiver('set_resource_base_path', this, [resourcePath]);
  void unbindBusyProperty(GObjectObject object, String property) => _staticInfo.callMethodOnReceiver('unbind_busy_property', this, [object, property]);
  void unmarkBusy() => _staticInfo.callMethodOnReceiver('unmark_busy', this, []);
  void withdrawNotification(String id) => _staticInfo.callMethodOnReceiver('withdraw_notification', this, [id]);
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
  int connectToCommandLine(bool after, int func(ApplicationCommandLine commandLine)) => signalConnect('command-line', func, after);
  int connectToHandleLocalOptions(bool after, int func(VariantDict options)) => signalConnect('handle-local-options', func, after);
  int _connectToOpen(bool after, void func(List<File> files, String hint)) => signalConnect('open', func, after);
  Stream<ApplicationOpenEvent> get onOpen {
    int signalId;
    StreamController<ApplicationOpenEvent> controller;
    controller = new StreamController<ApplicationOpenEvent>(
      onListen: () {
          signalId = _connectToOpen(false, (List<File> files, String hint) {
              var result = new ApplicationOpenEvent(files, hint);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<ApplicationOpenEvent> get afterOpen {
    int signalId;
    StreamController<ApplicationOpenEvent> controller;
    controller = new StreamController<ApplicationOpenEvent>(
      onListen: () {
          signalId = _connectToOpen(true, (List<File> files, String hint) {
              var result = new ApplicationOpenEvent(files, hint);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToShutdown(bool after, void func()) => signalConnect('shutdown', func, after);
  Stream get onShutdown {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToShutdown(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterShutdown {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToShutdown(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToStartup(bool after, void func()) => signalConnect('startup', func, after);
  Stream get onStartup {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToStartup(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterStartup {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToStartup(true, () {
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

class ApplicationOpenEvent {
  final List<File> files;
  final String hint;

  ApplicationOpenEvent(this.files, this.hint);
}

class ApplicationCommandLine extends GObjectObject {
  ApplicationCommandLine.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'ApplicationCommandLine');

  void set arguments(Variant value) => _staticInfo.setGPropertyOnReceiver('arguments', this, value);
  static const String ARGUMENTS_PROPERTY = 'arguments';
  static const String IS_REMOTE_PROPERTY = 'is-remote';
  void set options(Variant value) => _staticInfo.setGPropertyOnReceiver('options', this, value);
  static const String OPTIONS_PROPERTY = 'options';
  void set platformData(Variant value) => _staticInfo.setGPropertyOnReceiver('platform-data', this, value);
  static const String PLATFORM_DATA_PROPERTY = 'platform-data';
  File createFileForArg(String arg) => _staticInfo.callMethodOnReceiver('create_file_for_arg', this, [arg]);
  List getArguments() => _staticInfo.callMethodOnReceiver('get_arguments', this, []);
  String get cwd => _staticInfo.callMethodOnReceiver('get_cwd', this, []);
  List<String> get environ => _staticInfo.callMethodOnReceiver('get_environ', this, []);
  int get exitStatus => _staticInfo.callMethodOnReceiver('get_exit_status', this, []);
  bool get isRemote => _staticInfo.callMethodOnReceiver('get_is_remote', this, []);
  VariantDict get optionsDict => _staticInfo.callMethodOnReceiver('get_options_dict', this, []);
  Variant get platformData_ => _staticInfo.callMethodOnReceiver('get_platform_data', this, []);
  InputStream get stdin => _staticInfo.callMethodOnReceiver('get_stdin', this, []);
  String getenv(String name) => _staticInfo.callMethodOnReceiver('getenv', this, [name]);
  void set exitStatus(int exitStatus) => _staticInfo.callMethodOnReceiver('set_exit_status', this, [exitStatus]);
}

class ApplicationFlags extends GEnumBase {
  const ApplicationFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'ApplicationFlags');

  static const ApplicationFlags FLAGS_NONE = const ApplicationFlags(0);
  bool get flagsNone => (index & 0) == 0;
  static const ApplicationFlags IS_SERVICE = const ApplicationFlags(1);
  bool get isService => (index & 1) == 1;
  static const ApplicationFlags IS_LAUNCHER = const ApplicationFlags(2);
  bool get isLauncher => (index & 2) == 2;
  static const ApplicationFlags HANDLES_OPEN = const ApplicationFlags(4);
  bool get handlesOpen => (index & 4) == 4;
  static const ApplicationFlags HANDLES_COMMAND_LINE = const ApplicationFlags(8);
  bool get handlesCommandLine => (index & 8) == 8;
  static const ApplicationFlags SEND_ENVIRONMENT = const ApplicationFlags(16);
  bool get sendEnvironment => (index & 16) == 16;
  static const ApplicationFlags NON_UNIQUE = const ApplicationFlags(32);
  bool get nonUnique => (index & 32) == 32;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'ApplicationFlags.IS_SERVICE';
      case 2: return 'ApplicationFlags.IS_LAUNCHER';
      case 4: return 'ApplicationFlags.HANDLES_OPEN';
      case 8: return 'ApplicationFlags.HANDLES_COMMAND_LINE';
      case 16: return 'ApplicationFlags.SEND_ENVIRONMENT';
      case 32: return 'ApplicationFlags.NON_UNIQUE';
      default: return 'new ApplicationFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'ApplicationFlags.FLAGS_NONE';
    }
    List codes = [];
    for (var i=1; i <= 32; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  ApplicationFlags operator|(ApplicationFlags other) =>
    new ApplicationFlags(index | other.index);
  ApplicationFlags operator&(ApplicationFlags other) =>
    new ApplicationFlags(index & other.index);
}

class AskPasswordFlags extends GEnumBase {
  const AskPasswordFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'AskPasswordFlags');

  static const AskPasswordFlags NULL = const AskPasswordFlags(0);
  static const AskPasswordFlags NEED_PASSWORD = const AskPasswordFlags(1);
  bool get needPassword => (index & 1) == 1;
  static const AskPasswordFlags NEED_USERNAME = const AskPasswordFlags(2);
  bool get needUsername => (index & 2) == 2;
  static const AskPasswordFlags NEED_DOMAIN = const AskPasswordFlags(4);
  bool get needDomain => (index & 4) == 4;
  static const AskPasswordFlags SAVING_SUPPORTED = const AskPasswordFlags(8);
  bool get savingSupported => (index & 8) == 8;
  static const AskPasswordFlags ANONYMOUS_SUPPORTED = const AskPasswordFlags(16);
  bool get anonymousSupported => (index & 16) == 16;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'AskPasswordFlags.NEED_PASSWORD';
      case 2: return 'AskPasswordFlags.NEED_USERNAME';
      case 4: return 'AskPasswordFlags.NEED_DOMAIN';
      case 8: return 'AskPasswordFlags.SAVING_SUPPORTED';
      case 16: return 'AskPasswordFlags.ANONYMOUS_SUPPORTED';
      default: return 'new AskPasswordFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'AskPasswordFlags.NULL';
    }
    List codes = [];
    for (var i=1; i <= 16; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  AskPasswordFlags operator|(AskPasswordFlags other) =>
    new AskPasswordFlags(index | other.index);
  AskPasswordFlags operator&(AskPasswordFlags other) =>
    new AskPasswordFlags(index & other.index);
}

abstract class AsyncInitable extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'AsyncInitable');



  static void newvAsync(int objectType, int nParameters, Parameter parameters, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callStatic('newv_async', [objectType, nParameters, parameters, ioPriority, cancellable, callback]);
  void initAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('init_async', this, [ioPriority, cancellable, callback]);
  void initFinish(AsyncResult res) => _staticInfo.callMethodOnReceiver('init_finish', this, [res]);
  GObjectObject newFinish(AsyncResult res) => _staticInfo.callMethodOnReceiver('new_finish', this, [res]);
}

typedef void AsyncReadyCallback(GObjectObject sourceObject, AsyncResult res);
abstract class AsyncResult extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'AsyncResult');



  GObjectObject get sourceObject => _staticInfo.callMethodOnReceiver('get_source_object', this, []);
  void getUserData() => _staticInfo.callMethodOnReceiver('get_user_data', this, []);
  bool isTagged(dynamic sourceTag /* this will fail */) => _staticInfo.callMethodOnReceiver('is_tagged', this, [sourceTag]);
  void legacyPropagateError() => _staticInfo.callMethodOnReceiver('legacy_propagate_error', this, []);
}

class BufferedInputStream extends FilterInputStream with Seekable {
  BufferedInputStream.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'BufferedInputStream');

  static const String BUFFER_SIZE_PROPERTY = 'buffer-size';
  factory BufferedInputStream(InputStream baseStream) => _staticInfo.callStatic('new', [baseStream]);
  factory BufferedInputStream.sized(InputStream baseStream, int size) => _staticInfo.callStatic('new_sized', [baseStream, size]);
  int fill(int count, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('fill', this, [count, cancellable]);
  void fillAsync(int count, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('fill_async', this, [count, ioPriority, cancellable, callback]);
  int fillFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('fill_finish', this, [result]);
  int get available => _staticInfo.callMethodOnReceiver('get_available', this, []);
  int get bufferSize => _staticInfo.callMethodOnReceiver('get_buffer_size', this, []);
  int peek(List<int> buffer, int offset) => _staticInfo.callMethodOnReceiver('peek', this, [buffer, offset]);
  List peekBuffer() => _staticInfo.callMethodOnReceiver('peek_buffer', this, []);
  int readByte(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('read_byte', this, [cancellable]);
  void set bufferSize(int size) => _staticInfo.callMethodOnReceiver('set_buffer_size', this, [size]);
}

class BufferedOutputStream extends FilterOutputStream with Seekable {
  BufferedOutputStream.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'BufferedOutputStream');

  static const String AUTO_GROW_PROPERTY = 'auto-grow';
  static const String BUFFER_SIZE_PROPERTY = 'buffer-size';
  factory BufferedOutputStream(OutputStream baseStream) => _staticInfo.callStatic('new', [baseStream]);
  factory BufferedOutputStream.sized(OutputStream baseStream, int size) => _staticInfo.callStatic('new_sized', [baseStream, size]);
  bool get autoGrow => _staticInfo.callMethodOnReceiver('get_auto_grow', this, []);
  int get bufferSize => _staticInfo.callMethodOnReceiver('get_buffer_size', this, []);
  void set autoGrow(bool autoGrow) => _staticInfo.callMethodOnReceiver('set_auto_grow', this, [autoGrow]);
  void set bufferSize(int size) => _staticInfo.callMethodOnReceiver('set_buffer_size', this, [size]);
}

typedef void BusAcquiredCallback(DBusConnection connection, String name);
typedef void BusNameAcquiredCallback(DBusConnection connection, String name);
typedef void BusNameAppearedCallback(DBusConnection connection, String name, String nameOwner);
typedef void BusNameLostCallback(DBusConnection connection, String name);
class BusNameOwnerFlags extends GEnumBase {
  const BusNameOwnerFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'BusNameOwnerFlags');

  static const BusNameOwnerFlags NONE = const BusNameOwnerFlags(0);
  bool get none => (index & 0) == 0;
  static const BusNameOwnerFlags ALLOW_REPLACEMENT = const BusNameOwnerFlags(1);
  bool get allowReplacement => (index & 1) == 1;
  static const BusNameOwnerFlags REPLACE = const BusNameOwnerFlags(2);
  bool get replace => (index & 2) == 2;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'BusNameOwnerFlags.ALLOW_REPLACEMENT';
      case 2: return 'BusNameOwnerFlags.REPLACE';
      default: return 'new BusNameOwnerFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'BusNameOwnerFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 2; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  BusNameOwnerFlags operator|(BusNameOwnerFlags other) =>
    new BusNameOwnerFlags(index | other.index);
  BusNameOwnerFlags operator&(BusNameOwnerFlags other) =>
    new BusNameOwnerFlags(index & other.index);
}

typedef void BusNameVanishedCallback(DBusConnection connection, String name);
class BusNameWatcherFlags extends GEnumBase {
  const BusNameWatcherFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'BusNameWatcherFlags');

  static const BusNameWatcherFlags NONE = const BusNameWatcherFlags(0);
  bool get none => (index & 0) == 0;
  static const BusNameWatcherFlags AUTO_START = const BusNameWatcherFlags(1);
  bool get autoStart => (index & 1) == 1;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'BusNameWatcherFlags.AUTO_START';
      default: return 'new BusNameWatcherFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'BusNameWatcherFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 1; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  BusNameWatcherFlags operator|(BusNameWatcherFlags other) =>
    new BusNameWatcherFlags(index | other.index);
  BusNameWatcherFlags operator&(BusNameWatcherFlags other) =>
    new BusNameWatcherFlags(index & other.index);
}

class BusType extends GEnumBase {
  const BusType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'BusType');

  static const BusType STARTER = const BusType(-1);
  static const BusType NONE = const BusType(0);
  static const BusType SYSTEM = const BusType(1);
  static const BusType SESSION = const BusType(2);
  String toString() {
    switch(index) {
      case -1: return 'BusType.STARTER';
      case 0: return 'BusType.NONE';
      case 1: return 'BusType.SYSTEM';
      case 2: return 'BusType.SESSION';
      default: return 'new BusType($index)';
    }
  }
}

class BytesIcon extends GObjectObject with Icon, LoadableIcon {
  BytesIcon.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'BytesIcon');

  void set bytes(Bytes value) => _staticInfo.setGPropertyOnReceiver('bytes', this, value);
  static const String BYTES_PROPERTY = 'bytes';
  factory BytesIcon(Bytes bytes) => _staticInfo.callStatic('new', [bytes]);
  Bytes get bytes_ => _staticInfo.callMethodOnReceiver('get_bytes', this, []);
}

class Cancellable extends GObjectObject {
  Cancellable.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'Cancellable');

  factory Cancellable() => _staticInfo.callStatic('new', []);
  static Cancellable getCurrent() => _staticInfo.callStatic('get_current', []);
  void cancel() => _staticInfo.callMethodOnReceiver('cancel', this, []);
  int connect(Callback callback) => _staticInfo.callMethodOnReceiver('connect', this, [callback]);
  void disconnect(int handlerId) => _staticInfo.callMethodOnReceiver('disconnect', this, [handlerId]);
  int get fd => _staticInfo.callMethodOnReceiver('get_fd', this, []);
  bool isCancelled() => _staticInfo.callMethodOnReceiver('is_cancelled', this, []);
  bool makePollfd(PollFD pollfd) => _staticInfo.callMethodOnReceiver('make_pollfd', this, [pollfd]);
  void popCurrent() => _staticInfo.callMethodOnReceiver('pop_current', this, []);
  void pushCurrent() => _staticInfo.callMethodOnReceiver('push_current', this, []);
  void releaseFd() => _staticInfo.callMethodOnReceiver('release_fd', this, []);
  void reset() => _staticInfo.callMethodOnReceiver('reset', this, []);
  void setErrorIfCancelled() => _staticInfo.callMethodOnReceiver('set_error_if_cancelled', this, []);
  int _connectToCancelled(bool after, void func()) => signalConnect('cancelled', func, after);
  Stream get onCancelled {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToCancelled(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterCancelled {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToCancelled(true, () {
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

typedef bool CancellableSourceFunc(Cancellable cancellable);
class CharsetConverter extends GObjectObject with Converter, Initable {
  CharsetConverter.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'CharsetConverter');

  String get fromCharset => _staticInfo.getGPropertyOnReceiver('from-charset', this);
  void set fromCharset(String value) => _staticInfo.setGPropertyOnReceiver('from-charset', this, value);
  static const String FROM_CHARSET_PROPERTY = 'from-charset';
  String get toCharset => _staticInfo.getGPropertyOnReceiver('to-charset', this);
  void set toCharset(String value) => _staticInfo.setGPropertyOnReceiver('to-charset', this, value);
  static const String TO_CHARSET_PROPERTY = 'to-charset';
  static const String USE_FALLBACK_PROPERTY = 'use-fallback';
  factory CharsetConverter(String toCharset, String fromCharset) => _staticInfo.callStatic('new', [toCharset, fromCharset]);
  int get numFallbacks => _staticInfo.callMethodOnReceiver('get_num_fallbacks', this, []);
  bool get useFallback => _staticInfo.callMethodOnReceiver('get_use_fallback', this, []);
  void set useFallback(bool useFallback) => _staticInfo.callMethodOnReceiver('set_use_fallback', this, [useFallback]);
}

abstract class Converter extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'Converter');



  List convert(List<int> inbuf, dynamic outbuf /* this will fail */, int outbufSize, ConverterFlags flags) => _staticInfo.callMethodOnReceiver('convert', this, [inbuf, outbuf, outbufSize, flags]);
  void reset() => _staticInfo.callMethodOnReceiver('reset', this, []);
}

class ConverterFlags extends GEnumBase {
  const ConverterFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'ConverterFlags');

  static const ConverterFlags NONE = const ConverterFlags(0);
  bool get none => (index & 0) == 0;
  static const ConverterFlags INPUT_AT_END = const ConverterFlags(1);
  bool get inputAtEnd => (index & 1) == 1;
  static const ConverterFlags FLUSH = const ConverterFlags(2);
  bool get flush => (index & 2) == 2;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'ConverterFlags.INPUT_AT_END';
      case 2: return 'ConverterFlags.FLUSH';
      default: return 'new ConverterFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'ConverterFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 2; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  ConverterFlags operator|(ConverterFlags other) =>
    new ConverterFlags(index | other.index);
  ConverterFlags operator&(ConverterFlags other) =>
    new ConverterFlags(index & other.index);
}

class ConverterInputStream extends FilterInputStream with PollableInputStream {
  ConverterInputStream.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'ConverterInputStream');

  void set converter(Converter value) => _staticInfo.setGPropertyOnReceiver('converter', this, value);
  static const String CONVERTER_PROPERTY = 'converter';
  factory ConverterInputStream(InputStream baseStream, Converter converter) => _staticInfo.callStatic('new', [baseStream, converter]);
  Converter get converter_ => _staticInfo.callMethodOnReceiver('get_converter', this, []);
}

class ConverterOutputStream extends FilterOutputStream with PollableOutputStream {
  ConverterOutputStream.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'ConverterOutputStream');

  void set converter(Converter value) => _staticInfo.setGPropertyOnReceiver('converter', this, value);
  static const String CONVERTER_PROPERTY = 'converter';
  factory ConverterOutputStream(OutputStream baseStream, Converter converter) => _staticInfo.callStatic('new', [baseStream, converter]);
  Converter get converter_ => _staticInfo.callMethodOnReceiver('get_converter', this, []);
}

class ConverterResult extends GEnumBase {
  const ConverterResult(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'ConverterResult');

  static const ConverterResult ERROR = const ConverterResult(0);
  static const ConverterResult CONVERTED = const ConverterResult(1);
  static const ConverterResult FINISHED = const ConverterResult(2);
  static const ConverterResult FLUSHED = const ConverterResult(3);
  String toString() {
    switch(index) {
      case 0: return 'ConverterResult.ERROR';
      case 1: return 'ConverterResult.CONVERTED';
      case 2: return 'ConverterResult.FINISHED';
      case 3: return 'ConverterResult.FLUSHED';
      default: return 'new ConverterResult($index)';
    }
  }
}

class Credentials extends GObjectObject {
  Credentials.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'Credentials');

  factory Credentials() => _staticInfo.callStatic('new', []);
  int get unixPid => _staticInfo.callMethodOnReceiver('get_unix_pid', this, []);
  int get unixUser => _staticInfo.callMethodOnReceiver('get_unix_user', this, []);
  void isSameUser(Credentials otherCredentials) => _staticInfo.callMethodOnReceiver('is_same_user', this, [otherCredentials]);
  void setNative(CredentialsType nativeType, dynamic native /* this will fail */) => _staticInfo.callMethodOnReceiver('set_native', this, [nativeType, native]);
  void set unixUser(int uid) => _staticInfo.callMethodOnReceiver('set_unix_user', this, [uid]);
  String toString() => _staticInfo.callMethodOnReceiver('to_string', this, []);
}

class CredentialsType extends GEnumBase {
  const CredentialsType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'CredentialsType');

  static const CredentialsType INVALID = const CredentialsType(0);
  static const CredentialsType LINUX_UCRED = const CredentialsType(1);
  static const CredentialsType FREEBSD_CMSGCRED = const CredentialsType(2);
  static const CredentialsType OPENBSD_SOCKPEERCRED = const CredentialsType(3);
  static const CredentialsType SOLARIS_UCRED = const CredentialsType(4);
  static const CredentialsType NETBSD_UNPCBID = const CredentialsType(5);
  String toString() {
    switch(index) {
      case 0: return 'CredentialsType.INVALID';
      case 1: return 'CredentialsType.LINUX_UCRED';
      case 2: return 'CredentialsType.FREEBSD_CMSGCRED';
      case 3: return 'CredentialsType.OPENBSD_SOCKPEERCRED';
      case 4: return 'CredentialsType.SOLARIS_UCRED';
      case 5: return 'CredentialsType.NETBSD_UNPCBID';
      default: return 'new CredentialsType($index)';
    }
  }
}

class DBusActionGroup extends GObjectObject with ActionGroup, RemoteActionGroup {
  DBusActionGroup.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusActionGroup');

  static DBusActionGroup get_(DBusConnection connection, String busName, String objectPath) => _staticInfo.callStatic('get', [connection, busName, objectPath]);
}

class DBusAnnotationInfo extends GObjectBase {
  DBusAnnotationInfo.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusAnnotationInfo');

  DBusAnnotationInfo ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
  static String lookup(List<DBusAnnotationInfo> annotations, String name) => _staticInfo.callStatic('lookup', [annotations, name]);
  int get refCount => getFieldOfObject('ref_count', 0);
  void set refCount(int value) => setFieldOfObject('ref_count', 0, value);
  String get key => getFieldOfObject('key', 1);
  void set key(String value) => setFieldOfObject('key', 1, value);
  String get value => getFieldOfObject('value', 2);
  void set value(String value) => setFieldOfObject('value', 2, value);
  List<DBusAnnotationInfo> get annotations => getFieldOfObject('annotations', 3);
  void set annotations(List<DBusAnnotationInfo> value) => setFieldOfObject('annotations', 3, value);
}

class DBusArgInfo extends GObjectBase {
  DBusArgInfo.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusArgInfo');

  DBusArgInfo ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
  int get refCount => getFieldOfObject('ref_count', 0);
  void set refCount(int value) => setFieldOfObject('ref_count', 0, value);
  String get name => getFieldOfObject('name', 1);
  void set name(String value) => setFieldOfObject('name', 1, value);
  String get signature => getFieldOfObject('signature', 2);
  void set signature(String value) => setFieldOfObject('signature', 2, value);
  List<DBusAnnotationInfo> get annotations => getFieldOfObject('annotations', 3);
  void set annotations(List<DBusAnnotationInfo> value) => setFieldOfObject('annotations', 3, value);
}

class DBusAuthObserver extends GObjectObject {
  DBusAuthObserver.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusAuthObserver');

  factory DBusAuthObserver() => _staticInfo.callStatic('new', []);
  bool allowMechanism(String mechanism) => _staticInfo.callMethodOnReceiver('allow_mechanism', this, [mechanism]);
  bool authorizeAuthenticatedPeer(IOStream stream, Credentials credentials) => _staticInfo.callMethodOnReceiver('authorize_authenticated_peer', this, [stream, credentials]);
  int _connectToAllowMechanism(bool after, bool func(String mechanism)) => signalConnect('allow-mechanism', func, after);
  Stream<DBusAuthObserverAllowMechanismEvent> get onAllowMechanism {
    int signalId;
    StreamController<DBusAuthObserverAllowMechanismEvent> controller;
    controller = new StreamController<DBusAuthObserverAllowMechanismEvent>(
      onListen: () {
          signalId = _connectToAllowMechanism(false, (String mechanism) {
              var result = new DBusAuthObserverAllowMechanismEvent(mechanism);
              controller.add(result);
              return result._cancelPropagation;
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<DBusAuthObserverAllowMechanismEvent> get afterAllowMechanism {
    int signalId;
    StreamController<DBusAuthObserverAllowMechanismEvent> controller;
    controller = new StreamController<DBusAuthObserverAllowMechanismEvent>(
      onListen: () {
          signalId = _connectToAllowMechanism(true, (String mechanism) {
              var result = new DBusAuthObserverAllowMechanismEvent(mechanism);
              controller.add(result);
              return result._cancelPropagation;
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToAuthorizeAuthenticatedPeer(bool after, bool func(IOStream stream, Credentials credentials)) => signalConnect('authorize-authenticated-peer', func, after);
  Stream<DBusAuthObserverAuthorizeAuthenticatedPeerEvent> get onAuthorizeAuthenticatedPeer {
    int signalId;
    StreamController<DBusAuthObserverAuthorizeAuthenticatedPeerEvent> controller;
    controller = new StreamController<DBusAuthObserverAuthorizeAuthenticatedPeerEvent>(
      onListen: () {
          signalId = _connectToAuthorizeAuthenticatedPeer(false, (IOStream stream, Credentials credentials) {
              var result = new DBusAuthObserverAuthorizeAuthenticatedPeerEvent(stream, credentials);
              controller.add(result);
              return result._cancelPropagation;
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<DBusAuthObserverAuthorizeAuthenticatedPeerEvent> get afterAuthorizeAuthenticatedPeer {
    int signalId;
    StreamController<DBusAuthObserverAuthorizeAuthenticatedPeerEvent> controller;
    controller = new StreamController<DBusAuthObserverAuthorizeAuthenticatedPeerEvent>(
      onListen: () {
          signalId = _connectToAuthorizeAuthenticatedPeer(true, (IOStream stream, Credentials credentials) {
              var result = new DBusAuthObserverAuthorizeAuthenticatedPeerEvent(stream, credentials);
              controller.add(result);
              return result._cancelPropagation;
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
}

class DBusAuthObserverAllowMechanismEvent {
  final String mechanism;
  bool _cancelPropagation = false;
  void cancelPropagation() {
    _cancelPropagation = true;
  }
  DBusAuthObserverAllowMechanismEvent(this.mechanism);
}

class DBusAuthObserverAuthorizeAuthenticatedPeerEvent {
  final IOStream stream;
  final Credentials credentials;
  bool _cancelPropagation = false;
  void cancelPropagation() {
    _cancelPropagation = true;
  }
  DBusAuthObserverAuthorizeAuthenticatedPeerEvent(this.stream, this.credentials);
}

class DBusCallFlags extends GEnumBase {
  const DBusCallFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusCallFlags');

  static const DBusCallFlags NONE = const DBusCallFlags(0);
  bool get none => (index & 0) == 0;
  static const DBusCallFlags NO_AUTO_START = const DBusCallFlags(1);
  bool get noAutoStart => (index & 1) == 1;
  static const DBusCallFlags ALLOW_INTERACTIVE_AUTHORIZATION = const DBusCallFlags(2);
  bool get allowInteractiveAuthorization => (index & 2) == 2;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'DBusCallFlags.NO_AUTO_START';
      case 2: return 'DBusCallFlags.ALLOW_INTERACTIVE_AUTHORIZATION';
      default: return 'new DBusCallFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'DBusCallFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 2; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  DBusCallFlags operator|(DBusCallFlags other) =>
    new DBusCallFlags(index | other.index);
  DBusCallFlags operator&(DBusCallFlags other) =>
    new DBusCallFlags(index & other.index);
}

class DBusCapabilityFlags extends GEnumBase {
  const DBusCapabilityFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusCapabilityFlags');

  static const DBusCapabilityFlags NONE = const DBusCapabilityFlags(0);
  bool get none => (index & 0) == 0;
  static const DBusCapabilityFlags UNIX_FD_PASSING = const DBusCapabilityFlags(1);
  bool get unixFdPassing => (index & 1) == 1;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'DBusCapabilityFlags.UNIX_FD_PASSING';
      default: return 'new DBusCapabilityFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'DBusCapabilityFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 1; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  DBusCapabilityFlags operator|(DBusCapabilityFlags other) =>
    new DBusCapabilityFlags(index | other.index);
  DBusCapabilityFlags operator&(DBusCapabilityFlags other) =>
    new DBusCapabilityFlags(index & other.index);
}

class DBusConnection extends GObjectObject with AsyncInitable, Initable {
  DBusConnection.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusConnection');

  void set address(String value) => _staticInfo.setGPropertyOnReceiver('address', this, value);
  static const String ADDRESS_PROPERTY = 'address';
  void set authenticationObserver(DBusAuthObserver value) => _staticInfo.setGPropertyOnReceiver('authentication-observer', this, value);
  static const String AUTHENTICATION_OBSERVER_PROPERTY = 'authentication-observer';
  static const String CAPABILITIES_PROPERTY = 'capabilities';
  bool get closed => _staticInfo.getGPropertyOnReceiver('closed', this);
  static const String CLOSED_PROPERTY = 'closed';
  static const String EXIT_ON_CLOSE_PROPERTY = 'exit-on-close';
  void set flags(DBusConnectionFlags value) => _staticInfo.setGPropertyOnReceiver('flags', this, value);
  static const String FLAGS_PROPERTY = 'flags';
  void set guid(String value) => _staticInfo.setGPropertyOnReceiver('guid', this, value);
  static const String GUID_PROPERTY = 'guid';
  void set stream(IOStream value) => _staticInfo.setGPropertyOnReceiver('stream', this, value);
  static const String STREAM_PROPERTY = 'stream';
  static const String UNIQUE_NAME_PROPERTY = 'unique-name';
  factory DBusConnection.finish(AsyncResult res) => _staticInfo.callStatic('new_finish', [res]);
  factory DBusConnection.forAddressFinish(AsyncResult res) => _staticInfo.callStatic('new_for_address_finish', [res]);
  factory DBusConnection.forAddressSync(String address, DBusConnectionFlags flags, DBusAuthObserver observer, Cancellable cancellable) => _staticInfo.callStatic('new_for_address_sync', [address, flags, observer, cancellable]);
  factory DBusConnection.sync(IOStream stream, String guid, DBusConnectionFlags flags, DBusAuthObserver observer, Cancellable cancellable) => _staticInfo.callStatic('new_sync', [stream, guid, flags, observer, cancellable]);
  static void new_(IOStream stream, String guid, DBusConnectionFlags flags, DBusAuthObserver observer, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callStatic('new', [stream, guid, flags, observer, cancellable, callback]);
  static void newForAddress(String address, DBusConnectionFlags flags, DBusAuthObserver observer, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callStatic('new_for_address', [address, flags, observer, cancellable, callback]);
  int addFilter(DBusMessageFilterFunction filterFunction) => _staticInfo.callMethodOnReceiver('add_filter', this, [filterFunction]);
  void call(String busName, String objectPath, String interfaceName, String methodName, Variant parameters, VariantType replyType, DBusCallFlags flags, int timeoutMsec, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('call', this, [busName, objectPath, interfaceName, methodName, parameters, replyType, flags, timeoutMsec, cancellable, callback]);
  Variant callFinish(AsyncResult res) => _staticInfo.callMethodOnReceiver('call_finish', this, [res]);
  Variant callSync(String busName, String objectPath, String interfaceName, String methodName, Variant parameters, VariantType replyType, DBusCallFlags flags, int timeoutMsec, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('call_sync', this, [busName, objectPath, interfaceName, methodName, parameters, replyType, flags, timeoutMsec, cancellable]);
  void callWithUnixFdList(String busName, String objectPath, String interfaceName, String methodName, Variant parameters, VariantType replyType, DBusCallFlags flags, int timeoutMsec, UnixFDList fdList, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('call_with_unix_fd_list', this, [busName, objectPath, interfaceName, methodName, parameters, replyType, flags, timeoutMsec, fdList, cancellable, callback]);
  List callWithUnixFdListFinish(AsyncResult res) => _staticInfo.callMethodOnReceiver('call_with_unix_fd_list_finish', this, [res]);
  List callWithUnixFdListSync(String busName, String objectPath, String interfaceName, String methodName, Variant parameters, VariantType replyType, DBusCallFlags flags, int timeoutMsec, UnixFDList fdList, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('call_with_unix_fd_list_sync', this, [busName, objectPath, interfaceName, methodName, parameters, replyType, flags, timeoutMsec, fdList, cancellable]);
  void close(Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('close', this, [cancellable, callback]);
  void closeFinish(AsyncResult res) => _staticInfo.callMethodOnReceiver('close_finish', this, [res]);
  void closeSync(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('close_sync', this, [cancellable]);
  void emitSignal(String destinationBusName, String objectPath, String interfaceName, String signalName, Variant parameters) => _staticInfo.callMethodOnReceiver('emit_signal', this, [destinationBusName, objectPath, interfaceName, signalName, parameters]);
  int exportActionGroup(String objectPath, ActionGroup actionGroup) => _staticInfo.callMethodOnReceiver('export_action_group', this, [objectPath, actionGroup]);
  int exportMenuModel(String objectPath, MenuModel menu) => _staticInfo.callMethodOnReceiver('export_menu_model', this, [objectPath, menu]);
  void flush(Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('flush', this, [cancellable, callback]);
  void flushFinish(AsyncResult res) => _staticInfo.callMethodOnReceiver('flush_finish', this, [res]);
  void flushSync(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('flush_sync', this, [cancellable]);
  DBusCapabilityFlags get capabilities => _staticInfo.callMethodOnReceiver('get_capabilities', this, []);
  bool get exitOnClose => _staticInfo.callMethodOnReceiver('get_exit_on_close', this, []);
  String get guid_ => _staticInfo.callMethodOnReceiver('get_guid', this, []);
  int get lastSerial => _staticInfo.callMethodOnReceiver('get_last_serial', this, []);
  Credentials get peerCredentials => _staticInfo.callMethodOnReceiver('get_peer_credentials', this, []);
  IOStream get stream_ => _staticInfo.callMethodOnReceiver('get_stream', this, []);
  String get uniqueName => _staticInfo.callMethodOnReceiver('get_unique_name', this, []);
  bool isClosed() => _staticInfo.callMethodOnReceiver('is_closed', this, []);
  int registerObject(String objectPath, DBusInterfaceInfo interfaceInfo, Closure methodCallClosure, Closure getPropertyClosure, Closure setPropertyClosure) => _staticInfo.callMethodOnReceiver('register_object', this, [objectPath, interfaceInfo, methodCallClosure, getPropertyClosure, setPropertyClosure]);
  int registerSubtree(String objectPath, DBusSubtreeVTable vtable, DBusSubtreeFlags flags, dynamic userData /* this will fail */, DestroyNotify userDataFreeFunc) => _staticInfo.callMethodOnReceiver('register_subtree', this, [objectPath, vtable, flags, userData, userDataFreeFunc]);
  void removeFilter(int filterId) => _staticInfo.callMethodOnReceiver('remove_filter', this, [filterId]);
  int sendMessage(DBusMessage message, DBusSendMessageFlags flags) => _staticInfo.callMethodOnReceiver('send_message', this, [message, flags]);
  int sendMessageWithReply(DBusMessage message, DBusSendMessageFlags flags, int timeoutMsec, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('send_message_with_reply', this, [message, flags, timeoutMsec, cancellable, callback]);
  DBusMessage sendMessageWithReplyFinish(AsyncResult res) => _staticInfo.callMethodOnReceiver('send_message_with_reply_finish', this, [res]);
  List sendMessageWithReplySync(DBusMessage message, DBusSendMessageFlags flags, int timeoutMsec, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('send_message_with_reply_sync', this, [message, flags, timeoutMsec, cancellable]);
  void set exitOnClose(bool exitOnClose) => _staticInfo.callMethodOnReceiver('set_exit_on_close', this, [exitOnClose]);
  int signalSubscribe(String sender, String interfaceName, String member, String objectPath, String arg0, DBusSignalFlags flags, DBusSignalCallback callback) => _staticInfo.callMethodOnReceiver('signal_subscribe', this, [sender, interfaceName, member, objectPath, arg0, flags, callback]);
  void signalUnsubscribe(int subscriptionId) => _staticInfo.callMethodOnReceiver('signal_unsubscribe', this, [subscriptionId]);
  void startMessageProcessing() => _staticInfo.callMethodOnReceiver('start_message_processing', this, []);
  void unexportActionGroup(int exportId) => _staticInfo.callMethodOnReceiver('unexport_action_group', this, [exportId]);
  void unexportMenuModel(int exportId) => _staticInfo.callMethodOnReceiver('unexport_menu_model', this, [exportId]);
  bool unregisterObject(int registrationId) => _staticInfo.callMethodOnReceiver('unregister_object', this, [registrationId]);
  bool unregisterSubtree(int registrationId) => _staticInfo.callMethodOnReceiver('unregister_subtree', this, [registrationId]);
  int _connectToClosed(bool after, void func(bool remotePeerVanished, GErrorBase error)) => signalConnect('closed', func, after);
  Stream<DBusConnectionClosedEvent> get onClosed {
    int signalId;
    StreamController<DBusConnectionClosedEvent> controller;
    controller = new StreamController<DBusConnectionClosedEvent>(
      onListen: () {
          signalId = _connectToClosed(false, (bool remotePeerVanished, GErrorBase error) {
              var result = new DBusConnectionClosedEvent(remotePeerVanished, error);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<DBusConnectionClosedEvent> get afterClosed {
    int signalId;
    StreamController<DBusConnectionClosedEvent> controller;
    controller = new StreamController<DBusConnectionClosedEvent>(
      onListen: () {
          signalId = _connectToClosed(true, (bool remotePeerVanished, GErrorBase error) {
              var result = new DBusConnectionClosedEvent(remotePeerVanished, error);
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

class DBusConnectionClosedEvent {
  final bool remotePeerVanished;
  final GErrorBase error;

  DBusConnectionClosedEvent(this.remotePeerVanished, this.error);
}

class DBusConnectionFlags extends GEnumBase {
  const DBusConnectionFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusConnectionFlags');

  static const DBusConnectionFlags NONE = const DBusConnectionFlags(0);
  bool get none => (index & 0) == 0;
  static const DBusConnectionFlags AUTHENTICATION_CLIENT = const DBusConnectionFlags(1);
  bool get authenticationClient => (index & 1) == 1;
  static const DBusConnectionFlags AUTHENTICATION_SERVER = const DBusConnectionFlags(2);
  bool get authenticationServer => (index & 2) == 2;
  static const DBusConnectionFlags AUTHENTICATION_ALLOW_ANONYMOUS = const DBusConnectionFlags(4);
  bool get authenticationAllowAnonymous => (index & 4) == 4;
  static const DBusConnectionFlags MESSAGE_BUS_CONNECTION = const DBusConnectionFlags(8);
  bool get messageBusConnection => (index & 8) == 8;
  static const DBusConnectionFlags DELAY_MESSAGE_PROCESSING = const DBusConnectionFlags(16);
  bool get delayMessageProcessing => (index & 16) == 16;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'DBusConnectionFlags.AUTHENTICATION_CLIENT';
      case 2: return 'DBusConnectionFlags.AUTHENTICATION_SERVER';
      case 4: return 'DBusConnectionFlags.AUTHENTICATION_ALLOW_ANONYMOUS';
      case 8: return 'DBusConnectionFlags.MESSAGE_BUS_CONNECTION';
      case 16: return 'DBusConnectionFlags.DELAY_MESSAGE_PROCESSING';
      default: return 'new DBusConnectionFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'DBusConnectionFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 16; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  DBusConnectionFlags operator|(DBusConnectionFlags other) =>
    new DBusConnectionFlags(index | other.index);
  DBusConnectionFlags operator&(DBusConnectionFlags other) =>
    new DBusConnectionFlags(index & other.index);
}

class DBusErrorCode extends GEnumBase {
  const DBusErrorCode(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusError');

  static const DBusErrorCode FAILED = const DBusErrorCode(0);
  static const DBusErrorCode NO_MEMORY = const DBusErrorCode(1);
  static const DBusErrorCode SERVICE_UNKNOWN = const DBusErrorCode(2);
  static const DBusErrorCode NAME_HAS_NO_OWNER = const DBusErrorCode(3);
  static const DBusErrorCode NO_REPLY = const DBusErrorCode(4);
  static const DBusErrorCode IO_ERROR = const DBusErrorCode(5);
  static const DBusErrorCode BAD_ADDRESS = const DBusErrorCode(6);
  static const DBusErrorCode NOT_SUPPORTED = const DBusErrorCode(7);
  static const DBusErrorCode LIMITS_EXCEEDED = const DBusErrorCode(8);
  static const DBusErrorCode ACCESS_DENIED = const DBusErrorCode(9);
  static const DBusErrorCode AUTH_FAILED = const DBusErrorCode(10);
  static const DBusErrorCode NO_SERVER = const DBusErrorCode(11);
  static const DBusErrorCode TIMEOUT = const DBusErrorCode(12);
  static const DBusErrorCode NO_NETWORK = const DBusErrorCode(13);
  static const DBusErrorCode ADDRESS_IN_USE = const DBusErrorCode(14);
  static const DBusErrorCode DISCONNECTED = const DBusErrorCode(15);
  static const DBusErrorCode INVALID_ARGS = const DBusErrorCode(16);
  static const DBusErrorCode FILE_NOT_FOUND = const DBusErrorCode(17);
  static const DBusErrorCode FILE_EXISTS = const DBusErrorCode(18);
  static const DBusErrorCode UNKNOWN_METHOD = const DBusErrorCode(19);
  static const DBusErrorCode TIMED_OUT = const DBusErrorCode(20);
  static const DBusErrorCode MATCH_RULE_NOT_FOUND = const DBusErrorCode(21);
  static const DBusErrorCode MATCH_RULE_INVALID = const DBusErrorCode(22);
  static const DBusErrorCode SPAWN_EXEC_FAILED = const DBusErrorCode(23);
  static const DBusErrorCode SPAWN_FORK_FAILED = const DBusErrorCode(24);
  static const DBusErrorCode SPAWN_CHILD_EXITED = const DBusErrorCode(25);
  static const DBusErrorCode SPAWN_CHILD_SIGNALED = const DBusErrorCode(26);
  static const DBusErrorCode SPAWN_FAILED = const DBusErrorCode(27);
  static const DBusErrorCode SPAWN_SETUP_FAILED = const DBusErrorCode(28);
  static const DBusErrorCode SPAWN_CONFIG_INVALID = const DBusErrorCode(29);
  static const DBusErrorCode SPAWN_SERVICE_INVALID = const DBusErrorCode(30);
  static const DBusErrorCode SPAWN_SERVICE_NOT_FOUND = const DBusErrorCode(31);
  static const DBusErrorCode SPAWN_PERMISSIONS_INVALID = const DBusErrorCode(32);
  static const DBusErrorCode SPAWN_FILE_INVALID = const DBusErrorCode(33);
  static const DBusErrorCode SPAWN_NO_MEMORY = const DBusErrorCode(34);
  static const DBusErrorCode UNIX_PROCESS_ID_UNKNOWN = const DBusErrorCode(35);
  static const DBusErrorCode INVALID_SIGNATURE = const DBusErrorCode(36);
  static const DBusErrorCode INVALID_FILE_CONTENT = const DBusErrorCode(37);
  static const DBusErrorCode SELINUX_SECURITY_CONTEXT_UNKNOWN = const DBusErrorCode(38);
  static const DBusErrorCode ADT_AUDIT_DATA_UNKNOWN = const DBusErrorCode(39);
  static const DBusErrorCode OBJECT_PATH_IN_USE = const DBusErrorCode(40);
  static const DBusErrorCode UNKNOWN_OBJECT = const DBusErrorCode(41);
  static const DBusErrorCode UNKNOWN_INTERFACE = const DBusErrorCode(42);
  static const DBusErrorCode UNKNOWN_PROPERTY = const DBusErrorCode(43);
  static const DBusErrorCode PROPERTY_READ_ONLY = const DBusErrorCode(44);
  String toString() {
    switch(index) {
      case 0: return 'DBusErrorCode.FAILED';
      case 1: return 'DBusErrorCode.NO_MEMORY';
      case 2: return 'DBusErrorCode.SERVICE_UNKNOWN';
      case 3: return 'DBusErrorCode.NAME_HAS_NO_OWNER';
      case 4: return 'DBusErrorCode.NO_REPLY';
      case 5: return 'DBusErrorCode.IO_ERROR';
      case 6: return 'DBusErrorCode.BAD_ADDRESS';
      case 7: return 'DBusErrorCode.NOT_SUPPORTED';
      case 8: return 'DBusErrorCode.LIMITS_EXCEEDED';
      case 9: return 'DBusErrorCode.ACCESS_DENIED';
      case 10: return 'DBusErrorCode.AUTH_FAILED';
      case 11: return 'DBusErrorCode.NO_SERVER';
      case 12: return 'DBusErrorCode.TIMEOUT';
      case 13: return 'DBusErrorCode.NO_NETWORK';
      case 14: return 'DBusErrorCode.ADDRESS_IN_USE';
      case 15: return 'DBusErrorCode.DISCONNECTED';
      case 16: return 'DBusErrorCode.INVALID_ARGS';
      case 17: return 'DBusErrorCode.FILE_NOT_FOUND';
      case 18: return 'DBusErrorCode.FILE_EXISTS';
      case 19: return 'DBusErrorCode.UNKNOWN_METHOD';
      case 20: return 'DBusErrorCode.TIMED_OUT';
      case 21: return 'DBusErrorCode.MATCH_RULE_NOT_FOUND';
      case 22: return 'DBusErrorCode.MATCH_RULE_INVALID';
      case 23: return 'DBusErrorCode.SPAWN_EXEC_FAILED';
      case 24: return 'DBusErrorCode.SPAWN_FORK_FAILED';
      case 25: return 'DBusErrorCode.SPAWN_CHILD_EXITED';
      case 26: return 'DBusErrorCode.SPAWN_CHILD_SIGNALED';
      case 27: return 'DBusErrorCode.SPAWN_FAILED';
      case 28: return 'DBusErrorCode.SPAWN_SETUP_FAILED';
      case 29: return 'DBusErrorCode.SPAWN_CONFIG_INVALID';
      case 30: return 'DBusErrorCode.SPAWN_SERVICE_INVALID';
      case 31: return 'DBusErrorCode.SPAWN_SERVICE_NOT_FOUND';
      case 32: return 'DBusErrorCode.SPAWN_PERMISSIONS_INVALID';
      case 33: return 'DBusErrorCode.SPAWN_FILE_INVALID';
      case 34: return 'DBusErrorCode.SPAWN_NO_MEMORY';
      case 35: return 'DBusErrorCode.UNIX_PROCESS_ID_UNKNOWN';
      case 36: return 'DBusErrorCode.INVALID_SIGNATURE';
      case 37: return 'DBusErrorCode.INVALID_FILE_CONTENT';
      case 38: return 'DBusErrorCode.SELINUX_SECURITY_CONTEXT_UNKNOWN';
      case 39: return 'DBusErrorCode.ADT_AUDIT_DATA_UNKNOWN';
      case 40: return 'DBusErrorCode.OBJECT_PATH_IN_USE';
      case 41: return 'DBusErrorCode.UNKNOWN_OBJECT';
      case 42: return 'DBusErrorCode.UNKNOWN_INTERFACE';
      case 43: return 'DBusErrorCode.UNKNOWN_PROPERTY';
      case 44: return 'DBusErrorCode.PROPERTY_READ_ONLY';
      default: return 'new DBusErrorCode($index)';
    }
  }
  static String encodeGerror(GErrorBase error) => _staticInfo.callStatic('encode_gerror', [error]);
  static String getRemoteError(GErrorBase error) => _staticInfo.callStatic('get_remote_error', [error]);
  static bool isRemoteError(GErrorBase error) => _staticInfo.callStatic('is_remote_error', [error]);
  static GErrorBase newForDbusError(String dbusErrorName, String dbusErrorMessage) => _staticInfo.callStatic('new_for_dbus_error', [dbusErrorName, dbusErrorMessage]);
  static int quark() => _staticInfo.callStatic('quark', []);
  static bool registerError(int errorDomain, int errorCode, String dbusErrorName) => _staticInfo.callStatic('register_error', [errorDomain, errorCode, dbusErrorName]);
  static void registerErrorDomain(String errorDomainQuarkName, int quarkVolatile, DBusErrorEntry entries, int numEntries) => _staticInfo.callStatic('register_error_domain', [errorDomainQuarkName, quarkVolatile, entries, numEntries]);
  static bool stripRemoteError(GErrorBase error) => _staticInfo.callStatic('strip_remote_error', [error]);
  static bool unregisterError(int errorDomain, int errorCode, String dbusErrorName) => _staticInfo.callStatic('unregister_error', [errorDomain, errorCode, dbusErrorName]);
}

class DBusError extends GErrorBase {
  static final int _quark = lookupErrorQuarkFromString('g-dbus-error-quark');
  DBusError(DBusErrorCode code, String message)
      : super.fromFields(_quark, code, message);
}

class DBusErrorEntry extends GObjectBase {
  DBusErrorEntry.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusErrorEntry');

  int get errorCode => getFieldOfObject('error_code', 0);
  void set errorCode(int value) => setFieldOfObject('error_code', 0, value);
  String get dbusErrorName => getFieldOfObject('dbus_error_name', 1);
  void set dbusErrorName(String value) => setFieldOfObject('dbus_error_name', 1, value);
}

abstract class DBusInterface extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusInterface');



  DBusObject get object => _staticInfo.callMethodOnReceiver('get_object', this, []);
  DBusInterfaceInfo get info => _staticInfo.callMethodOnReceiver('get_info', this, []);
  void set object(DBusObject object) => _staticInfo.callMethodOnReceiver('set_object', this, [object]);
}

typedef Variant DBusInterfaceGetPropertyFunc(DBusConnection connection, String sender, String objectPath, String interfaceName, String propertyName, GErrorBase error);
class DBusInterfaceInfo extends GObjectBase {
  DBusInterfaceInfo.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusInterfaceInfo');

  void cacheBuild() => _staticInfo.callMethodOnReceiver('cache_build', this, []);
  void cacheRelease() => _staticInfo.callMethodOnReceiver('cache_release', this, []);
  GLibString generateXml(int indent) => _staticInfo.callMethodOnReceiver('generate_xml', this, [indent]);
  DBusMethodInfo lookupMethod(String name) => _staticInfo.callMethodOnReceiver('lookup_method', this, [name]);
  DBusPropertyInfo lookupProperty(String name) => _staticInfo.callMethodOnReceiver('lookup_property', this, [name]);
  DBusSignalInfo lookupSignal(String name) => _staticInfo.callMethodOnReceiver('lookup_signal', this, [name]);
  DBusInterfaceInfo ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
  int get refCount => getFieldOfObject('ref_count', 0);
  void set refCount(int value) => setFieldOfObject('ref_count', 0, value);
  String get name => getFieldOfObject('name', 1);
  void set name(String value) => setFieldOfObject('name', 1, value);
  List<DBusMethodInfo> get methods => getFieldOfObject('methods', 2);
  void set methods(List<DBusMethodInfo> value) => setFieldOfObject('methods', 2, value);
  List<DBusSignalInfo> get signals => getFieldOfObject('signals', 3);
  void set signals(List<DBusSignalInfo> value) => setFieldOfObject('signals', 3, value);
  List<DBusPropertyInfo> get properties => getFieldOfObject('properties', 4);
  void set properties(List<DBusPropertyInfo> value) => setFieldOfObject('properties', 4, value);
  List<DBusAnnotationInfo> get annotations => getFieldOfObject('annotations', 5);
  void set annotations(List<DBusAnnotationInfo> value) => setFieldOfObject('annotations', 5, value);
}

typedef void DBusInterfaceMethodCallFunc(DBusConnection connection, String sender, String objectPath, String interfaceName, String methodName, Variant parameters, DBusMethodInvocation invocation);
typedef bool DBusInterfaceSetPropertyFunc(DBusConnection connection, String sender, String objectPath, String interfaceName, String propertyName, Variant value, GErrorBase error);
class DBusInterfaceSkeleton extends GObjectObject with DBusInterface {
  DBusInterfaceSkeleton.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusInterfaceSkeleton');

  DBusInterfaceSkeletonFlags get gFlags => _staticInfo.getGPropertyOnReceiver('g-flags', this);
  void set gFlags(DBusInterfaceSkeletonFlags value) => _staticInfo.setGPropertyOnReceiver('g-flags', this, value);
  static const String G_FLAGS_PROPERTY = 'g-flags';
  void export_(DBusConnection connection, String objectPath) => _staticInfo.callMethodOnReceiver('export', this, [connection, objectPath]);
  void flush() => _staticInfo.callMethodOnReceiver('flush', this, []);
  DBusConnection get connection => _staticInfo.callMethodOnReceiver('get_connection', this, []);
  GLibList /* this will fail */ get connections => _staticInfo.callMethodOnReceiver('get_connections', this, []);
  DBusInterfaceSkeletonFlags get flags => _staticInfo.callMethodOnReceiver('get_flags', this, []);
  DBusInterfaceInfo get info => _staticInfo.callMethodOnReceiver('get_info', this, []);
  String get objectPath => _staticInfo.callMethodOnReceiver('get_object_path', this, []);
  Variant get properties => _staticInfo.callMethodOnReceiver('get_properties', this, []);
  bool hasConnection(DBusConnection connection) => _staticInfo.callMethodOnReceiver('has_connection', this, [connection]);
  void set flags(DBusInterfaceSkeletonFlags flags) => _staticInfo.callMethodOnReceiver('set_flags', this, [flags]);
  void unexport() => _staticInfo.callMethodOnReceiver('unexport', this, []);
  void unexportFromConnection(DBusConnection connection) => _staticInfo.callMethodOnReceiver('unexport_from_connection', this, [connection]);
  int _connectToGAuthorizeMethod(bool after, bool func(DBusMethodInvocation invocation)) => signalConnect('g-authorize-method', func, after);
  Stream<DBusInterfaceSkeletonGAuthorizeMethodEvent> get onGAuthorizeMethod {
    int signalId;
    StreamController<DBusInterfaceSkeletonGAuthorizeMethodEvent> controller;
    controller = new StreamController<DBusInterfaceSkeletonGAuthorizeMethodEvent>(
      onListen: () {
          signalId = _connectToGAuthorizeMethod(false, (DBusMethodInvocation invocation) {
              var result = new DBusInterfaceSkeletonGAuthorizeMethodEvent(invocation);
              controller.add(result);
              return result._cancelPropagation;
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<DBusInterfaceSkeletonGAuthorizeMethodEvent> get afterGAuthorizeMethod {
    int signalId;
    StreamController<DBusInterfaceSkeletonGAuthorizeMethodEvent> controller;
    controller = new StreamController<DBusInterfaceSkeletonGAuthorizeMethodEvent>(
      onListen: () {
          signalId = _connectToGAuthorizeMethod(true, (DBusMethodInvocation invocation) {
              var result = new DBusInterfaceSkeletonGAuthorizeMethodEvent(invocation);
              controller.add(result);
              return result._cancelPropagation;
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
}

class DBusInterfaceSkeletonGAuthorizeMethodEvent {
  final DBusMethodInvocation invocation;
  bool _cancelPropagation = false;
  void cancelPropagation() {
    _cancelPropagation = true;
  }
  DBusInterfaceSkeletonGAuthorizeMethodEvent(this.invocation);
}

class DBusInterfaceSkeletonFlags extends GEnumBase {
  const DBusInterfaceSkeletonFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusInterfaceSkeletonFlags');

  static const DBusInterfaceSkeletonFlags NONE = const DBusInterfaceSkeletonFlags(0);
  bool get none => (index & 0) == 0;
  static const DBusInterfaceSkeletonFlags HANDLE_METHOD_INVOCATIONS_IN_THREAD = const DBusInterfaceSkeletonFlags(1);
  bool get handleMethodInvocationsInThread => (index & 1) == 1;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'DBusInterfaceSkeletonFlags.HANDLE_METHOD_INVOCATIONS_IN_THREAD';
      default: return 'new DBusInterfaceSkeletonFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'DBusInterfaceSkeletonFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 1; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  DBusInterfaceSkeletonFlags operator|(DBusInterfaceSkeletonFlags other) =>
    new DBusInterfaceSkeletonFlags(index | other.index);
  DBusInterfaceSkeletonFlags operator&(DBusInterfaceSkeletonFlags other) =>
    new DBusInterfaceSkeletonFlags(index & other.index);
}

class DBusInterfaceVTable extends GObjectBase {
  DBusInterfaceVTable.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusInterfaceVTable');

  DBusInterfaceMethodCallFunc get methodCall => getFieldOfObject('method_call', 0);
  void set methodCall(DBusInterfaceMethodCallFunc value) => setFieldOfObject('method_call', 0, value);
  DBusInterfaceGetPropertyFunc get getProperty => getFieldOfObject('get_property', 1);
  void set getProperty(DBusInterfaceGetPropertyFunc value) => setFieldOfObject('get_property', 1, value);
  DBusInterfaceSetPropertyFunc get setProperty => getFieldOfObject('set_property', 2);
  void set setProperty(DBusInterfaceSetPropertyFunc value) => setFieldOfObject('set_property', 2, value);
  List<dynamic /* this will fail */> get padding => getFieldOfObject('padding', 3);
}

class DBusMenuModel extends MenuModel {
  DBusMenuModel.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusMenuModel');

  static DBusMenuModel get_(DBusConnection connection, String busName, String objectPath) => _staticInfo.callStatic('get', [connection, busName, objectPath]);
}

class DBusMessage extends GObjectObject {
  DBusMessage.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusMessage');

  static const String LOCKED_PROPERTY = 'locked';
  factory DBusMessage() => _staticInfo.callStatic('new', []);
  factory DBusMessage.fromBlob(List<int> blob, DBusCapabilityFlags capabilities) => _staticInfo.callStatic('new_from_blob', [blob, capabilities]);
  factory DBusMessage.methodCall(String name, String path, String interface_, String method) => _staticInfo.callStatic('new_method_call', [name, path, interface_, method]);
  factory DBusMessage.signal(String path, String interface_, String signal) => _staticInfo.callStatic('new_signal', [path, interface_, signal]);
  static int bytesNeeded(List<int> blob) => _staticInfo.callStatic('bytes_needed', [blob]);
  DBusMessage copy() => _staticInfo.callMethodOnReceiver('copy', this, []);
  String get arg0 => _staticInfo.callMethodOnReceiver('get_arg0', this, []);
  Variant get body => _staticInfo.callMethodOnReceiver('get_body', this, []);
  DBusMessageByteOrder get byteOrder => _staticInfo.callMethodOnReceiver('get_byte_order', this, []);
  String get destination => _staticInfo.callMethodOnReceiver('get_destination', this, []);
  String get errorName => _staticInfo.callMethodOnReceiver('get_error_name', this, []);
  DBusMessageFlags get flags => _staticInfo.callMethodOnReceiver('get_flags', this, []);
  Variant getHeader(DBusMessageHeaderField headerField) => _staticInfo.callMethodOnReceiver('get_header', this, [headerField]);
  List<int> get headerFields => _staticInfo.callMethodOnReceiver('get_header_fields', this, []);
  String get interface => _staticInfo.callMethodOnReceiver('get_interface', this, []);
  bool get locked => _staticInfo.callMethodOnReceiver('get_locked', this, []);
  String get member => _staticInfo.callMethodOnReceiver('get_member', this, []);
  DBusMessageType get messageType => _staticInfo.callMethodOnReceiver('get_message_type', this, []);
  int get numUnixFds => _staticInfo.callMethodOnReceiver('get_num_unix_fds', this, []);
  String get path => _staticInfo.callMethodOnReceiver('get_path', this, []);
  int get replySerial => _staticInfo.callMethodOnReceiver('get_reply_serial', this, []);
  String get sender => _staticInfo.callMethodOnReceiver('get_sender', this, []);
  int get serial => _staticInfo.callMethodOnReceiver('get_serial', this, []);
  String get signature => _staticInfo.callMethodOnReceiver('get_signature', this, []);
  UnixFDList get unixFdList => _staticInfo.callMethodOnReceiver('get_unix_fd_list', this, []);
  void lock() => _staticInfo.callMethodOnReceiver('lock', this, []);
  DBusMessage newMethodErrorLiteral(String errorName, String errorMessage) => _staticInfo.callMethodOnReceiver('new_method_error_literal', this, [errorName, errorMessage]);
  DBusMessage newMethodReply() => _staticInfo.callMethodOnReceiver('new_method_reply', this, []);
  String print(int indent) => _staticInfo.callMethodOnReceiver('print', this, [indent]);
  void set body(Variant body) => _staticInfo.callMethodOnReceiver('set_body', this, [body]);
  void set byteOrder(DBusMessageByteOrder byteOrder) => _staticInfo.callMethodOnReceiver('set_byte_order', this, [byteOrder]);
  void set destination(String value) => _staticInfo.callMethodOnReceiver('set_destination', this, [value]);
  void set errorName(String value) => _staticInfo.callMethodOnReceiver('set_error_name', this, [value]);
  void set flags(DBusMessageFlags flags) => _staticInfo.callMethodOnReceiver('set_flags', this, [flags]);
  void setHeader(DBusMessageHeaderField headerField, Variant value) => _staticInfo.callMethodOnReceiver('set_header', this, [headerField, value]);
  void set interface(String value) => _staticInfo.callMethodOnReceiver('set_interface', this, [value]);
  void set member(String value) => _staticInfo.callMethodOnReceiver('set_member', this, [value]);
  void set messageType(DBusMessageType type) => _staticInfo.callMethodOnReceiver('set_message_type', this, [type]);
  void set numUnixFds(int value) => _staticInfo.callMethodOnReceiver('set_num_unix_fds', this, [value]);
  void set path(String value) => _staticInfo.callMethodOnReceiver('set_path', this, [value]);
  void set replySerial(int value) => _staticInfo.callMethodOnReceiver('set_reply_serial', this, [value]);
  void set sender(String value) => _staticInfo.callMethodOnReceiver('set_sender', this, [value]);
  void set serial(int serial) => _staticInfo.callMethodOnReceiver('set_serial', this, [serial]);
  void set signature(String value) => _staticInfo.callMethodOnReceiver('set_signature', this, [value]);
  void set unixFdList(UnixFDList fdList) => _staticInfo.callMethodOnReceiver('set_unix_fd_list', this, [fdList]);
  List toBlob(DBusCapabilityFlags capabilities) => _staticInfo.callMethodOnReceiver('to_blob', this, [capabilities]);
  void toGerror() => _staticInfo.callMethodOnReceiver('to_gerror', this, []);
}

class DBusMessageByteOrder extends GEnumBase {
  const DBusMessageByteOrder(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusMessageByteOrder');

  static const DBusMessageByteOrder BIG_ENDIAN = const DBusMessageByteOrder(66);
  static const DBusMessageByteOrder LITTLE_ENDIAN = const DBusMessageByteOrder(108);
  String toString() {
    switch(index) {
      case 66: return 'DBusMessageByteOrder.BIG_ENDIAN';
      case 108: return 'DBusMessageByteOrder.LITTLE_ENDIAN';
      default: return 'new DBusMessageByteOrder($index)';
    }
  }
}

typedef DBusMessage DBusMessageFilterFunction(DBusConnection connection, DBusMessage message, bool incoming);
class DBusMessageFlags extends GEnumBase {
  const DBusMessageFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusMessageFlags');

  static const DBusMessageFlags NONE = const DBusMessageFlags(0);
  bool get none => (index & 0) == 0;
  static const DBusMessageFlags NO_REPLY_EXPECTED = const DBusMessageFlags(1);
  bool get noReplyExpected => (index & 1) == 1;
  static const DBusMessageFlags NO_AUTO_START = const DBusMessageFlags(2);
  bool get noAutoStart => (index & 2) == 2;
  static const DBusMessageFlags ALLOW_INTERACTIVE_AUTHORIZATION = const DBusMessageFlags(4);
  bool get allowInteractiveAuthorization => (index & 4) == 4;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'DBusMessageFlags.NO_REPLY_EXPECTED';
      case 2: return 'DBusMessageFlags.NO_AUTO_START';
      case 4: return 'DBusMessageFlags.ALLOW_INTERACTIVE_AUTHORIZATION';
      default: return 'new DBusMessageFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'DBusMessageFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 4; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  DBusMessageFlags operator|(DBusMessageFlags other) =>
    new DBusMessageFlags(index | other.index);
  DBusMessageFlags operator&(DBusMessageFlags other) =>
    new DBusMessageFlags(index & other.index);
}

class DBusMessageHeaderField extends GEnumBase {
  const DBusMessageHeaderField(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusMessageHeaderField');

  static const DBusMessageHeaderField INVALID = const DBusMessageHeaderField(0);
  static const DBusMessageHeaderField PATH = const DBusMessageHeaderField(1);
  static const DBusMessageHeaderField INTERFACE = const DBusMessageHeaderField(2);
  static const DBusMessageHeaderField MEMBER = const DBusMessageHeaderField(3);
  static const DBusMessageHeaderField ERROR_NAME = const DBusMessageHeaderField(4);
  static const DBusMessageHeaderField REPLY_SERIAL = const DBusMessageHeaderField(5);
  static const DBusMessageHeaderField DESTINATION = const DBusMessageHeaderField(6);
  static const DBusMessageHeaderField SENDER = const DBusMessageHeaderField(7);
  static const DBusMessageHeaderField SIGNATURE = const DBusMessageHeaderField(8);
  static const DBusMessageHeaderField NUM_UNIX_FDS = const DBusMessageHeaderField(9);
  String toString() {
    switch(index) {
      case 0: return 'DBusMessageHeaderField.INVALID';
      case 1: return 'DBusMessageHeaderField.PATH';
      case 2: return 'DBusMessageHeaderField.INTERFACE';
      case 3: return 'DBusMessageHeaderField.MEMBER';
      case 4: return 'DBusMessageHeaderField.ERROR_NAME';
      case 5: return 'DBusMessageHeaderField.REPLY_SERIAL';
      case 6: return 'DBusMessageHeaderField.DESTINATION';
      case 7: return 'DBusMessageHeaderField.SENDER';
      case 8: return 'DBusMessageHeaderField.SIGNATURE';
      case 9: return 'DBusMessageHeaderField.NUM_UNIX_FDS';
      default: return 'new DBusMessageHeaderField($index)';
    }
  }
}

class DBusMessageType extends GEnumBase {
  const DBusMessageType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusMessageType');

  static const DBusMessageType INVALID = const DBusMessageType(0);
  static const DBusMessageType METHOD_CALL = const DBusMessageType(1);
  static const DBusMessageType METHOD_RETURN = const DBusMessageType(2);
  static const DBusMessageType ERROR = const DBusMessageType(3);
  static const DBusMessageType SIGNAL = const DBusMessageType(4);
  String toString() {
    switch(index) {
      case 0: return 'DBusMessageType.INVALID';
      case 1: return 'DBusMessageType.METHOD_CALL';
      case 2: return 'DBusMessageType.METHOD_RETURN';
      case 3: return 'DBusMessageType.ERROR';
      case 4: return 'DBusMessageType.SIGNAL';
      default: return 'new DBusMessageType($index)';
    }
  }
}

class DBusMethodInfo extends GObjectBase {
  DBusMethodInfo.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusMethodInfo');

  DBusMethodInfo ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
  int get refCount => getFieldOfObject('ref_count', 0);
  void set refCount(int value) => setFieldOfObject('ref_count', 0, value);
  String get name => getFieldOfObject('name', 1);
  void set name(String value) => setFieldOfObject('name', 1, value);
  List<DBusArgInfo> get inArgs => getFieldOfObject('in_args', 2);
  void set inArgs(List<DBusArgInfo> value) => setFieldOfObject('in_args', 2, value);
  List<DBusArgInfo> get outArgs => getFieldOfObject('out_args', 3);
  void set outArgs(List<DBusArgInfo> value) => setFieldOfObject('out_args', 3, value);
  List<DBusAnnotationInfo> get annotations => getFieldOfObject('annotations', 4);
  void set annotations(List<DBusAnnotationInfo> value) => setFieldOfObject('annotations', 4, value);
}

class DBusMethodInvocation extends GObjectObject {
  DBusMethodInvocation.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusMethodInvocation');

  DBusConnection get connection => _staticInfo.callMethodOnReceiver('get_connection', this, []);
  String get interfaceName => _staticInfo.callMethodOnReceiver('get_interface_name', this, []);
  DBusMessage get message => _staticInfo.callMethodOnReceiver('get_message', this, []);
  DBusMethodInfo get methodInfo => _staticInfo.callMethodOnReceiver('get_method_info', this, []);
  String get methodName => _staticInfo.callMethodOnReceiver('get_method_name', this, []);
  String get objectPath => _staticInfo.callMethodOnReceiver('get_object_path', this, []);
  Variant get parameters => _staticInfo.callMethodOnReceiver('get_parameters', this, []);
  DBusPropertyInfo get propertyInfo => _staticInfo.callMethodOnReceiver('get_property_info', this, []);
  String get sender => _staticInfo.callMethodOnReceiver('get_sender', this, []);
  void returnDbusError(String errorName, String errorMessage) => _staticInfo.callMethodOnReceiver('return_dbus_error', this, [errorName, errorMessage]);
  void returnErrorLiteral(int domain, int code, String message) => _staticInfo.callMethodOnReceiver('return_error_literal', this, [domain, code, message]);
  void returnGerror(GErrorBase error) => _staticInfo.callMethodOnReceiver('return_gerror', this, [error]);
  void returnValue(Variant parameters) => _staticInfo.callMethodOnReceiver('return_value', this, [parameters]);
  void returnValueWithUnixFdList(Variant parameters, UnixFDList fdList) => _staticInfo.callMethodOnReceiver('return_value_with_unix_fd_list', this, [parameters, fdList]);
}

class DBusNodeInfo extends GObjectBase {
  DBusNodeInfo.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusNodeInfo');

  factory DBusNodeInfo.forXml(String xmlData) => _staticInfo.callStatic('new_for_xml', [xmlData]);
  GLibString generateXml(int indent) => _staticInfo.callMethodOnReceiver('generate_xml', this, [indent]);
  DBusInterfaceInfo lookupInterface(String name) => _staticInfo.callMethodOnReceiver('lookup_interface', this, [name]);
  DBusNodeInfo ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
  int get refCount => getFieldOfObject('ref_count', 0);
  void set refCount(int value) => setFieldOfObject('ref_count', 0, value);
  String get path => getFieldOfObject('path', 1);
  void set path(String value) => setFieldOfObject('path', 1, value);
  List<DBusInterfaceInfo> get interfaces => getFieldOfObject('interfaces', 2);
  void set interfaces(List<DBusInterfaceInfo> value) => setFieldOfObject('interfaces', 2, value);
  List<DBusNodeInfo> get nodes => getFieldOfObject('nodes', 3);
  void set nodes(List<DBusNodeInfo> value) => setFieldOfObject('nodes', 3, value);
  List<DBusAnnotationInfo> get annotations => getFieldOfObject('annotations', 4);
  void set annotations(List<DBusAnnotationInfo> value) => setFieldOfObject('annotations', 4, value);
}

abstract class DBusObject extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusObject');



  DBusInterface getInterface(String interfaceName) => _staticInfo.callMethodOnReceiver('get_interface', this, [interfaceName]);
  GLibList /* this will fail */ get interfaces => _staticInfo.callMethodOnReceiver('get_interfaces', this, []);
  String get objectPath => _staticInfo.callMethodOnReceiver('get_object_path', this, []);
  int _connectToInterfaceAdded(bool after, void func(DBusInterface interface)) => signalConnect('interface-added', func, after);
  Stream<DBusInterface> get onInterfaceAdded {
    int signalId;
    StreamController<DBusInterface> controller;
    controller = new StreamController<DBusInterface>(
      onListen: () {
          signalId = _connectToInterfaceAdded(false, (DBusInterface interface) {
              controller.add(interface);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<DBusInterface> get afterInterfaceAdded {
    int signalId;
    StreamController<DBusInterface> controller;
    controller = new StreamController<DBusInterface>(
      onListen: () {
          signalId = _connectToInterfaceAdded(true, (DBusInterface interface) {
              controller.add(interface);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToInterfaceRemoved(bool after, void func(DBusInterface interface)) => signalConnect('interface-removed', func, after);
  Stream<DBusInterface> get onInterfaceRemoved {
    int signalId;
    StreamController<DBusInterface> controller;
    controller = new StreamController<DBusInterface>(
      onListen: () {
          signalId = _connectToInterfaceRemoved(false, (DBusInterface interface) {
              controller.add(interface);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<DBusInterface> get afterInterfaceRemoved {
    int signalId;
    StreamController<DBusInterface> controller;
    controller = new StreamController<DBusInterface>(
      onListen: () {
          signalId = _connectToInterfaceRemoved(true, (DBusInterface interface) {
              controller.add(interface);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
}

abstract class DBusObjectManager extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusObjectManager');



  DBusInterface getInterface(String objectPath, String interfaceName) => _staticInfo.callMethodOnReceiver('get_interface', this, [objectPath, interfaceName]);
  DBusObject getObject(String objectPath) => _staticInfo.callMethodOnReceiver('get_object', this, [objectPath]);
  String get objectPath => _staticInfo.callMethodOnReceiver('get_object_path', this, []);
  GLibList /* this will fail */ get objects => _staticInfo.callMethodOnReceiver('get_objects', this, []);
  int _connectToInterfaceAdded(bool after, void func(DBusObject object, DBusInterface interface)) => signalConnect('interface-added', func, after);
  Stream<DBusObjectManagerInterfaceAddedEvent> get onInterfaceAdded {
    int signalId;
    StreamController<DBusObjectManagerInterfaceAddedEvent> controller;
    controller = new StreamController<DBusObjectManagerInterfaceAddedEvent>(
      onListen: () {
          signalId = _connectToInterfaceAdded(false, (DBusObject object, DBusInterface interface) {
              var result = new DBusObjectManagerInterfaceAddedEvent(object, interface);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<DBusObjectManagerInterfaceAddedEvent> get afterInterfaceAdded {
    int signalId;
    StreamController<DBusObjectManagerInterfaceAddedEvent> controller;
    controller = new StreamController<DBusObjectManagerInterfaceAddedEvent>(
      onListen: () {
          signalId = _connectToInterfaceAdded(true, (DBusObject object, DBusInterface interface) {
              var result = new DBusObjectManagerInterfaceAddedEvent(object, interface);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToInterfaceRemoved(bool after, void func(DBusObject object, DBusInterface interface)) => signalConnect('interface-removed', func, after);
  Stream<DBusObjectManagerInterfaceRemovedEvent> get onInterfaceRemoved {
    int signalId;
    StreamController<DBusObjectManagerInterfaceRemovedEvent> controller;
    controller = new StreamController<DBusObjectManagerInterfaceRemovedEvent>(
      onListen: () {
          signalId = _connectToInterfaceRemoved(false, (DBusObject object, DBusInterface interface) {
              var result = new DBusObjectManagerInterfaceRemovedEvent(object, interface);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<DBusObjectManagerInterfaceRemovedEvent> get afterInterfaceRemoved {
    int signalId;
    StreamController<DBusObjectManagerInterfaceRemovedEvent> controller;
    controller = new StreamController<DBusObjectManagerInterfaceRemovedEvent>(
      onListen: () {
          signalId = _connectToInterfaceRemoved(true, (DBusObject object, DBusInterface interface) {
              var result = new DBusObjectManagerInterfaceRemovedEvent(object, interface);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToObjectAdded(bool after, void func(DBusObject object)) => signalConnect('object-added', func, after);
  Stream<DBusObject> get onObjectAdded {
    int signalId;
    StreamController<DBusObject> controller;
    controller = new StreamController<DBusObject>(
      onListen: () {
          signalId = _connectToObjectAdded(false, (DBusObject object) {
              controller.add(object);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<DBusObject> get afterObjectAdded {
    int signalId;
    StreamController<DBusObject> controller;
    controller = new StreamController<DBusObject>(
      onListen: () {
          signalId = _connectToObjectAdded(true, (DBusObject object) {
              controller.add(object);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToObjectRemoved(bool after, void func(DBusObject object)) => signalConnect('object-removed', func, after);
  Stream<DBusObject> get onObjectRemoved {
    int signalId;
    StreamController<DBusObject> controller;
    controller = new StreamController<DBusObject>(
      onListen: () {
          signalId = _connectToObjectRemoved(false, (DBusObject object) {
              controller.add(object);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<DBusObject> get afterObjectRemoved {
    int signalId;
    StreamController<DBusObject> controller;
    controller = new StreamController<DBusObject>(
      onListen: () {
          signalId = _connectToObjectRemoved(true, (DBusObject object) {
              controller.add(object);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
}

class DBusObjectManagerInterfaceAddedEvent {
  final DBusObject object;
  final DBusInterface interface;

  DBusObjectManagerInterfaceAddedEvent(this.object, this.interface);
}

class DBusObjectManagerInterfaceRemovedEvent {
  final DBusObject object;
  final DBusInterface interface;

  DBusObjectManagerInterfaceRemovedEvent(this.object, this.interface);
}

class DBusObjectManagerClient extends GObjectObject with AsyncInitable, DBusObjectManager, Initable {
  DBusObjectManagerClient.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusObjectManagerClient');

  void set busType(BusType value) => _staticInfo.setGPropertyOnReceiver('bus-type', this, value);
  static const String BUS_TYPE_PROPERTY = 'bus-type';
  void set connection(DBusConnection value) => _staticInfo.setGPropertyOnReceiver('connection', this, value);
  static const String CONNECTION_PROPERTY = 'connection';
  void set flags(DBusObjectManagerClientFlags value) => _staticInfo.setGPropertyOnReceiver('flags', this, value);
  static const String FLAGS_PROPERTY = 'flags';
  dynamic /* this will fail */ get getProxyTypeDestroyNotify => _staticInfo.getGPropertyOnReceiver('get-proxy-type-destroy-notify', this);
  void set getProxyTypeDestroyNotify(dynamic value /* this will fail */) => _staticInfo.setGPropertyOnReceiver('get-proxy-type-destroy-notify', this, value);
  static const String GET_PROXY_TYPE_DESTROY_NOTIFY_PROPERTY = 'get-proxy-type-destroy-notify';
  dynamic /* this will fail */ get getProxyTypeFunc => _staticInfo.getGPropertyOnReceiver('get-proxy-type-func', this);
  void set getProxyTypeFunc(dynamic value /* this will fail */) => _staticInfo.setGPropertyOnReceiver('get-proxy-type-func', this, value);
  static const String GET_PROXY_TYPE_FUNC_PROPERTY = 'get-proxy-type-func';
  dynamic /* this will fail */ get getProxyTypeUserData => _staticInfo.getGPropertyOnReceiver('get-proxy-type-user-data', this);
  void set getProxyTypeUserData(dynamic value /* this will fail */) => _staticInfo.setGPropertyOnReceiver('get-proxy-type-user-data', this, value);
  static const String GET_PROXY_TYPE_USER_DATA_PROPERTY = 'get-proxy-type-user-data';
  void set name(String value) => _staticInfo.setGPropertyOnReceiver('name', this, value);
  static const String NAME_PROPERTY = 'name';
  static const String NAME_OWNER_PROPERTY = 'name-owner';
  String get objectPath => _staticInfo.getGPropertyOnReceiver('object-path', this);
  void set objectPath(String value) => _staticInfo.setGPropertyOnReceiver('object-path', this, value);
  static const String OBJECT_PATH_PROPERTY = 'object-path';
  factory DBusObjectManagerClient.finish(AsyncResult res) => _staticInfo.callStatic('new_finish', [res]);
  factory DBusObjectManagerClient.forBusFinish(AsyncResult res) => _staticInfo.callStatic('new_for_bus_finish', [res]);
  factory DBusObjectManagerClient.forBusSync(BusType busType, DBusObjectManagerClientFlags flags, String name, String objectPath, DBusProxyTypeFunc getProxyTypeFunc, Cancellable cancellable) => _staticInfo.callStatic('new_for_bus_sync', [busType, flags, name, objectPath, getProxyTypeFunc, cancellable]);
  factory DBusObjectManagerClient.sync(DBusConnection connection, DBusObjectManagerClientFlags flags, String name, String objectPath, DBusProxyTypeFunc getProxyTypeFunc, Cancellable cancellable) => _staticInfo.callStatic('new_sync', [connection, flags, name, objectPath, getProxyTypeFunc, cancellable]);
  static void new_(DBusConnection connection, DBusObjectManagerClientFlags flags, String name, String objectPath, DBusProxyTypeFunc getProxyTypeFunc, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callStatic('new', [connection, flags, name, objectPath, getProxyTypeFunc, cancellable, callback]);
  static void newForBus(BusType busType, DBusObjectManagerClientFlags flags, String name, String objectPath, DBusProxyTypeFunc getProxyTypeFunc, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callStatic('new_for_bus', [busType, flags, name, objectPath, getProxyTypeFunc, cancellable, callback]);
  DBusConnection get connection_ => _staticInfo.callMethodOnReceiver('get_connection', this, []);
  DBusObjectManagerClientFlags get flags_ => _staticInfo.callMethodOnReceiver('get_flags', this, []);
  String get name_ => _staticInfo.callMethodOnReceiver('get_name', this, []);
  String get nameOwner => _staticInfo.callMethodOnReceiver('get_name_owner', this, []);
  int _connectToInterfaceProxyPropertiesChanged(bool after, void func(DBusObjectProxy objectProxy, DBusProxy interfaceProxy, Variant changedProperties, List<String> invalidatedProperties)) => signalConnect('interface-proxy-properties-changed', func, after);
  Stream<DBusObjectManagerClientInterfaceProxyPropertiesChangedEvent> get onInterfaceProxyPropertiesChanged {
    int signalId;
    StreamController<DBusObjectManagerClientInterfaceProxyPropertiesChangedEvent> controller;
    controller = new StreamController<DBusObjectManagerClientInterfaceProxyPropertiesChangedEvent>(
      onListen: () {
          signalId = _connectToInterfaceProxyPropertiesChanged(false, (DBusObjectProxy objectProxy, DBusProxy interfaceProxy, Variant changedProperties, List<String> invalidatedProperties) {
              var result = new DBusObjectManagerClientInterfaceProxyPropertiesChangedEvent(objectProxy, interfaceProxy, changedProperties, invalidatedProperties);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<DBusObjectManagerClientInterfaceProxyPropertiesChangedEvent> get afterInterfaceProxyPropertiesChanged {
    int signalId;
    StreamController<DBusObjectManagerClientInterfaceProxyPropertiesChangedEvent> controller;
    controller = new StreamController<DBusObjectManagerClientInterfaceProxyPropertiesChangedEvent>(
      onListen: () {
          signalId = _connectToInterfaceProxyPropertiesChanged(true, (DBusObjectProxy objectProxy, DBusProxy interfaceProxy, Variant changedProperties, List<String> invalidatedProperties) {
              var result = new DBusObjectManagerClientInterfaceProxyPropertiesChangedEvent(objectProxy, interfaceProxy, changedProperties, invalidatedProperties);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToInterfaceProxySignal(bool after, void func(DBusObjectProxy objectProxy, DBusProxy interfaceProxy, String senderName, String signalName, Variant parameters)) => signalConnect('interface-proxy-signal', func, after);
  Stream<DBusObjectManagerClientInterfaceProxySignalEvent> get onInterfaceProxySignal {
    int signalId;
    StreamController<DBusObjectManagerClientInterfaceProxySignalEvent> controller;
    controller = new StreamController<DBusObjectManagerClientInterfaceProxySignalEvent>(
      onListen: () {
          signalId = _connectToInterfaceProxySignal(false, (DBusObjectProxy objectProxy, DBusProxy interfaceProxy, String senderName, String signalName, Variant parameters) {
              var result = new DBusObjectManagerClientInterfaceProxySignalEvent(objectProxy, interfaceProxy, senderName, signalName, parameters);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<DBusObjectManagerClientInterfaceProxySignalEvent> get afterInterfaceProxySignal {
    int signalId;
    StreamController<DBusObjectManagerClientInterfaceProxySignalEvent> controller;
    controller = new StreamController<DBusObjectManagerClientInterfaceProxySignalEvent>(
      onListen: () {
          signalId = _connectToInterfaceProxySignal(true, (DBusObjectProxy objectProxy, DBusProxy interfaceProxy, String senderName, String signalName, Variant parameters) {
              var result = new DBusObjectManagerClientInterfaceProxySignalEvent(objectProxy, interfaceProxy, senderName, signalName, parameters);
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

class DBusObjectManagerClientInterfaceProxyPropertiesChangedEvent {
  final DBusObjectProxy objectProxy;
  final DBusProxy interfaceProxy;
  final Variant changedProperties;
  final List<String> invalidatedProperties;

  DBusObjectManagerClientInterfaceProxyPropertiesChangedEvent(this.objectProxy, this.interfaceProxy, this.changedProperties, this.invalidatedProperties);
}

class DBusObjectManagerClientInterfaceProxySignalEvent {
  final DBusObjectProxy objectProxy;
  final DBusProxy interfaceProxy;
  final String senderName;
  final String signalName;
  final Variant parameters;

  DBusObjectManagerClientInterfaceProxySignalEvent(this.objectProxy, this.interfaceProxy, this.senderName, this.signalName, this.parameters);
}

class DBusObjectManagerClientFlags extends GEnumBase {
  const DBusObjectManagerClientFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusObjectManagerClientFlags');

  static const DBusObjectManagerClientFlags NONE = const DBusObjectManagerClientFlags(0);
  bool get none => (index & 0) == 0;
  static const DBusObjectManagerClientFlags DO_NOT_AUTO_START = const DBusObjectManagerClientFlags(1);
  bool get doNotAutoStart => (index & 1) == 1;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'DBusObjectManagerClientFlags.DO_NOT_AUTO_START';
      default: return 'new DBusObjectManagerClientFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'DBusObjectManagerClientFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 1; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  DBusObjectManagerClientFlags operator|(DBusObjectManagerClientFlags other) =>
    new DBusObjectManagerClientFlags(index | other.index);
  DBusObjectManagerClientFlags operator&(DBusObjectManagerClientFlags other) =>
    new DBusObjectManagerClientFlags(index & other.index);
}

class DBusObjectManagerServer extends GObjectObject with DBusObjectManager {
  DBusObjectManagerServer.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusObjectManagerServer');

  static const String CONNECTION_PROPERTY = 'connection';
  String get objectPath => _staticInfo.getGPropertyOnReceiver('object-path', this);
  void set objectPath(String value) => _staticInfo.setGPropertyOnReceiver('object-path', this, value);
  static const String OBJECT_PATH_PROPERTY = 'object-path';
  factory DBusObjectManagerServer(String objectPath) => _staticInfo.callStatic('new', [objectPath]);
  void export_(DBusObjectSkeleton object) => _staticInfo.callMethodOnReceiver('export', this, [object]);
  void exportUniquely(DBusObjectSkeleton object) => _staticInfo.callMethodOnReceiver('export_uniquely', this, [object]);
  DBusConnection get connection => _staticInfo.callMethodOnReceiver('get_connection', this, []);
  bool isExported(DBusObjectSkeleton object) => _staticInfo.callMethodOnReceiver('is_exported', this, [object]);
  void set connection(DBusConnection connection) => _staticInfo.callMethodOnReceiver('set_connection', this, [connection]);
  bool unexport(String objectPath) => _staticInfo.callMethodOnReceiver('unexport', this, [objectPath]);
}

class DBusObjectProxy extends GObjectObject with DBusObject {
  DBusObjectProxy.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusObjectProxy');

  DBusConnection get gConnection => _staticInfo.getGPropertyOnReceiver('g-connection', this);
  void set gConnection(DBusConnection value) => _staticInfo.setGPropertyOnReceiver('g-connection', this, value);
  static const String G_CONNECTION_PROPERTY = 'g-connection';
  String get gObjectPath => _staticInfo.getGPropertyOnReceiver('g-object-path', this);
  void set gObjectPath(String value) => _staticInfo.setGPropertyOnReceiver('g-object-path', this, value);
  static const String G_OBJECT_PATH_PROPERTY = 'g-object-path';
  factory DBusObjectProxy(DBusConnection connection, String objectPath) => _staticInfo.callStatic('new', [connection, objectPath]);
  DBusConnection get connection => _staticInfo.callMethodOnReceiver('get_connection', this, []);
}

class DBusObjectSkeleton extends GObjectObject with DBusObject {
  DBusObjectSkeleton.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusObjectSkeleton');

  String get gObjectPath => _staticInfo.getGPropertyOnReceiver('g-object-path', this);
  void set gObjectPath(String value) => _staticInfo.setGPropertyOnReceiver('g-object-path', this, value);
  static const String G_OBJECT_PATH_PROPERTY = 'g-object-path';
  factory DBusObjectSkeleton(String objectPath) => _staticInfo.callStatic('new', [objectPath]);
  void addInterface(DBusInterfaceSkeleton interface_) => _staticInfo.callMethodOnReceiver('add_interface', this, [interface_]);
  void flush() => _staticInfo.callMethodOnReceiver('flush', this, []);
  void removeInterface(DBusInterfaceSkeleton interface_) => _staticInfo.callMethodOnReceiver('remove_interface', this, [interface_]);
  void removeInterfaceByName(String interfaceName) => _staticInfo.callMethodOnReceiver('remove_interface_by_name', this, [interfaceName]);
  void setObjectPath(String objectPath) => _staticInfo.callMethodOnReceiver('set_object_path', this, [objectPath]);
  int _connectToAuthorizeMethod(bool after, bool func(DBusInterfaceSkeleton interface, DBusMethodInvocation invocation)) => signalConnect('authorize-method', func, after);
  Stream<DBusObjectSkeletonAuthorizeMethodEvent> get onAuthorizeMethod {
    int signalId;
    StreamController<DBusObjectSkeletonAuthorizeMethodEvent> controller;
    controller = new StreamController<DBusObjectSkeletonAuthorizeMethodEvent>(
      onListen: () {
          signalId = _connectToAuthorizeMethod(false, (DBusInterfaceSkeleton interface, DBusMethodInvocation invocation) {
              var result = new DBusObjectSkeletonAuthorizeMethodEvent(interface, invocation);
              controller.add(result);
              return result._cancelPropagation;
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<DBusObjectSkeletonAuthorizeMethodEvent> get afterAuthorizeMethod {
    int signalId;
    StreamController<DBusObjectSkeletonAuthorizeMethodEvent> controller;
    controller = new StreamController<DBusObjectSkeletonAuthorizeMethodEvent>(
      onListen: () {
          signalId = _connectToAuthorizeMethod(true, (DBusInterfaceSkeleton interface, DBusMethodInvocation invocation) {
              var result = new DBusObjectSkeletonAuthorizeMethodEvent(interface, invocation);
              controller.add(result);
              return result._cancelPropagation;
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
}

class DBusObjectSkeletonAuthorizeMethodEvent {
  final DBusInterfaceSkeleton interface;
  final DBusMethodInvocation invocation;
  bool _cancelPropagation = false;
  void cancelPropagation() {
    _cancelPropagation = true;
  }
  DBusObjectSkeletonAuthorizeMethodEvent(this.interface, this.invocation);
}

class DBusPropertyInfo extends GObjectBase {
  DBusPropertyInfo.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusPropertyInfo');

  DBusPropertyInfo ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
  int get refCount => getFieldOfObject('ref_count', 0);
  void set refCount(int value) => setFieldOfObject('ref_count', 0, value);
  String get name => getFieldOfObject('name', 1);
  void set name(String value) => setFieldOfObject('name', 1, value);
  String get signature => getFieldOfObject('signature', 2);
  void set signature(String value) => setFieldOfObject('signature', 2, value);
  DBusPropertyInfoFlags get flags => getFieldOfObject('flags', 3);
  void set flags(DBusPropertyInfoFlags value) => setFieldOfObject('flags', 3, value);
  List<DBusAnnotationInfo> get annotations => getFieldOfObject('annotations', 4);
  void set annotations(List<DBusAnnotationInfo> value) => setFieldOfObject('annotations', 4, value);
}

class DBusPropertyInfoFlags extends GEnumBase {
  const DBusPropertyInfoFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusPropertyInfoFlags');

  static const DBusPropertyInfoFlags NONE = const DBusPropertyInfoFlags(0);
  bool get none => (index & 0) == 0;
  static const DBusPropertyInfoFlags READABLE = const DBusPropertyInfoFlags(1);
  bool get readable => (index & 1) == 1;
  static const DBusPropertyInfoFlags WRITABLE = const DBusPropertyInfoFlags(2);
  bool get writable => (index & 2) == 2;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'DBusPropertyInfoFlags.READABLE';
      case 2: return 'DBusPropertyInfoFlags.WRITABLE';
      default: return 'new DBusPropertyInfoFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'DBusPropertyInfoFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 2; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  DBusPropertyInfoFlags operator|(DBusPropertyInfoFlags other) =>
    new DBusPropertyInfoFlags(index | other.index);
  DBusPropertyInfoFlags operator&(DBusPropertyInfoFlags other) =>
    new DBusPropertyInfoFlags(index & other.index);
}

class DBusProxy extends GObjectObject with AsyncInitable, DBusInterface, Initable {
  DBusProxy.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusProxy');

  void set gBusType(BusType value) => _staticInfo.setGPropertyOnReceiver('g-bus-type', this, value);
  static const String G_BUS_TYPE_PROPERTY = 'g-bus-type';
  DBusConnection get gConnection => _staticInfo.getGPropertyOnReceiver('g-connection', this);
  void set gConnection(DBusConnection value) => _staticInfo.setGPropertyOnReceiver('g-connection', this, value);
  static const String G_CONNECTION_PROPERTY = 'g-connection';
  int get gDefaultTimeout => _staticInfo.getGPropertyOnReceiver('g-default-timeout', this);
  void set gDefaultTimeout(int value) => _staticInfo.setGPropertyOnReceiver('g-default-timeout', this, value);
  static const String G_DEFAULT_TIMEOUT_PROPERTY = 'g-default-timeout';
  DBusProxyFlags get gFlags => _staticInfo.getGPropertyOnReceiver('g-flags', this);
  void set gFlags(DBusProxyFlags value) => _staticInfo.setGPropertyOnReceiver('g-flags', this, value);
  static const String G_FLAGS_PROPERTY = 'g-flags';
  DBusInterfaceInfo get gInterfaceInfo => _staticInfo.getGPropertyOnReceiver('g-interface-info', this);
  void set gInterfaceInfo(DBusInterfaceInfo value) => _staticInfo.setGPropertyOnReceiver('g-interface-info', this, value);
  static const String G_INTERFACE_INFO_PROPERTY = 'g-interface-info';
  String get gInterfaceName => _staticInfo.getGPropertyOnReceiver('g-interface-name', this);
  void set gInterfaceName(String value) => _staticInfo.setGPropertyOnReceiver('g-interface-name', this, value);
  static const String G_INTERFACE_NAME_PROPERTY = 'g-interface-name';
  String get gName => _staticInfo.getGPropertyOnReceiver('g-name', this);
  void set gName(String value) => _staticInfo.setGPropertyOnReceiver('g-name', this, value);
  static const String G_NAME_PROPERTY = 'g-name';
  String get gNameOwner => _staticInfo.getGPropertyOnReceiver('g-name-owner', this);
  static const String G_NAME_OWNER_PROPERTY = 'g-name-owner';
  String get gObjectPath => _staticInfo.getGPropertyOnReceiver('g-object-path', this);
  void set gObjectPath(String value) => _staticInfo.setGPropertyOnReceiver('g-object-path', this, value);
  static const String G_OBJECT_PATH_PROPERTY = 'g-object-path';
  factory DBusProxy.finish(AsyncResult res) => _staticInfo.callStatic('new_finish', [res]);
  factory DBusProxy.forBusFinish(AsyncResult res) => _staticInfo.callStatic('new_for_bus_finish', [res]);
  factory DBusProxy.forBusSync(BusType busType, DBusProxyFlags flags, DBusInterfaceInfo info, String name, String objectPath, String interfaceName, Cancellable cancellable) => _staticInfo.callStatic('new_for_bus_sync', [busType, flags, info, name, objectPath, interfaceName, cancellable]);
  factory DBusProxy.sync(DBusConnection connection, DBusProxyFlags flags, DBusInterfaceInfo info, String name, String objectPath, String interfaceName, Cancellable cancellable) => _staticInfo.callStatic('new_sync', [connection, flags, info, name, objectPath, interfaceName, cancellable]);
  static void new_(DBusConnection connection, DBusProxyFlags flags, DBusInterfaceInfo info, String name, String objectPath, String interfaceName, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callStatic('new', [connection, flags, info, name, objectPath, interfaceName, cancellable, callback]);
  static void newForBus(BusType busType, DBusProxyFlags flags, DBusInterfaceInfo info, String name, String objectPath, String interfaceName, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callStatic('new_for_bus', [busType, flags, info, name, objectPath, interfaceName, cancellable, callback]);
  void call(String methodName, Variant parameters, DBusCallFlags flags, int timeoutMsec, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('call', this, [methodName, parameters, flags, timeoutMsec, cancellable, callback]);
  Variant callFinish(AsyncResult res) => _staticInfo.callMethodOnReceiver('call_finish', this, [res]);
  Variant callSync(String methodName, Variant parameters, DBusCallFlags flags, int timeoutMsec, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('call_sync', this, [methodName, parameters, flags, timeoutMsec, cancellable]);
  void callWithUnixFdList(String methodName, Variant parameters, DBusCallFlags flags, int timeoutMsec, UnixFDList fdList, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('call_with_unix_fd_list', this, [methodName, parameters, flags, timeoutMsec, fdList, cancellable, callback]);
  List callWithUnixFdListFinish(AsyncResult res) => _staticInfo.callMethodOnReceiver('call_with_unix_fd_list_finish', this, [res]);
  List callWithUnixFdListSync(String methodName, Variant parameters, DBusCallFlags flags, int timeoutMsec, UnixFDList fdList, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('call_with_unix_fd_list_sync', this, [methodName, parameters, flags, timeoutMsec, fdList, cancellable]);
  Variant getCachedProperty(String propertyName) => _staticInfo.callMethodOnReceiver('get_cached_property', this, [propertyName]);
  List<String> get cachedPropertyNames => _staticInfo.callMethodOnReceiver('get_cached_property_names', this, []);
  DBusConnection get connection => _staticInfo.callMethodOnReceiver('get_connection', this, []);
  int get defaultTimeout => _staticInfo.callMethodOnReceiver('get_default_timeout', this, []);
  DBusProxyFlags get flags => _staticInfo.callMethodOnReceiver('get_flags', this, []);
  DBusInterfaceInfo get interfaceInfo => _staticInfo.callMethodOnReceiver('get_interface_info', this, []);
  String get interfaceName => _staticInfo.callMethodOnReceiver('get_interface_name', this, []);
  String get name => _staticInfo.callMethodOnReceiver('get_name', this, []);
  String get nameOwner => _staticInfo.callMethodOnReceiver('get_name_owner', this, []);
  String get objectPath => _staticInfo.callMethodOnReceiver('get_object_path', this, []);
  void setCachedProperty(String propertyName, Variant value) => _staticInfo.callMethodOnReceiver('set_cached_property', this, [propertyName, value]);
  void set defaultTimeout(int timeoutMsec) => _staticInfo.callMethodOnReceiver('set_default_timeout', this, [timeoutMsec]);
  void set interfaceInfo(DBusInterfaceInfo info) => _staticInfo.callMethodOnReceiver('set_interface_info', this, [info]);
  int _connectToGPropertiesChanged(bool after, void func(Variant changedProperties, List<String> invalidatedProperties)) => signalConnect('g-properties-changed', func, after);
  Stream<DBusProxyGPropertiesChangedEvent> get onGPropertiesChanged {
    int signalId;
    StreamController<DBusProxyGPropertiesChangedEvent> controller;
    controller = new StreamController<DBusProxyGPropertiesChangedEvent>(
      onListen: () {
          signalId = _connectToGPropertiesChanged(false, (Variant changedProperties, List<String> invalidatedProperties) {
              var result = new DBusProxyGPropertiesChangedEvent(changedProperties, invalidatedProperties);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<DBusProxyGPropertiesChangedEvent> get afterGPropertiesChanged {
    int signalId;
    StreamController<DBusProxyGPropertiesChangedEvent> controller;
    controller = new StreamController<DBusProxyGPropertiesChangedEvent>(
      onListen: () {
          signalId = _connectToGPropertiesChanged(true, (Variant changedProperties, List<String> invalidatedProperties) {
              var result = new DBusProxyGPropertiesChangedEvent(changedProperties, invalidatedProperties);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToGSignal(bool after, void func(String senderName, String signalName, Variant parameters)) => signalConnect('g-signal', func, after);
  Stream<DBusProxyGSignalEvent> get onGSignal {
    int signalId;
    StreamController<DBusProxyGSignalEvent> controller;
    controller = new StreamController<DBusProxyGSignalEvent>(
      onListen: () {
          signalId = _connectToGSignal(false, (String senderName, String signalName, Variant parameters) {
              var result = new DBusProxyGSignalEvent(senderName, signalName, parameters);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<DBusProxyGSignalEvent> get afterGSignal {
    int signalId;
    StreamController<DBusProxyGSignalEvent> controller;
    controller = new StreamController<DBusProxyGSignalEvent>(
      onListen: () {
          signalId = _connectToGSignal(true, (String senderName, String signalName, Variant parameters) {
              var result = new DBusProxyGSignalEvent(senderName, signalName, parameters);
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

class DBusProxyGPropertiesChangedEvent {
  final Variant changedProperties;
  final List<String> invalidatedProperties;

  DBusProxyGPropertiesChangedEvent(this.changedProperties, this.invalidatedProperties);
}

class DBusProxyGSignalEvent {
  final String senderName;
  final String signalName;
  final Variant parameters;

  DBusProxyGSignalEvent(this.senderName, this.signalName, this.parameters);
}

class DBusProxyFlags extends GEnumBase {
  const DBusProxyFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusProxyFlags');

  static const DBusProxyFlags NONE = const DBusProxyFlags(0);
  bool get none => (index & 0) == 0;
  static const DBusProxyFlags DO_NOT_LOAD_PROPERTIES = const DBusProxyFlags(1);
  bool get doNotLoadProperties => (index & 1) == 1;
  static const DBusProxyFlags DO_NOT_CONNECT_SIGNALS = const DBusProxyFlags(2);
  bool get doNotConnectSignals => (index & 2) == 2;
  static const DBusProxyFlags DO_NOT_AUTO_START = const DBusProxyFlags(4);
  bool get doNotAutoStart => (index & 4) == 4;
  static const DBusProxyFlags GET_INVALIDATED_PROPERTIES = const DBusProxyFlags(8);
  bool get getInvalidatedProperties => (index & 8) == 8;
  static const DBusProxyFlags DO_NOT_AUTO_START_AT_CONSTRUCTION = const DBusProxyFlags(16);
  bool get doNotAutoStartAtConstruction => (index & 16) == 16;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'DBusProxyFlags.DO_NOT_LOAD_PROPERTIES';
      case 2: return 'DBusProxyFlags.DO_NOT_CONNECT_SIGNALS';
      case 4: return 'DBusProxyFlags.DO_NOT_AUTO_START';
      case 8: return 'DBusProxyFlags.GET_INVALIDATED_PROPERTIES';
      case 16: return 'DBusProxyFlags.DO_NOT_AUTO_START_AT_CONSTRUCTION';
      default: return 'new DBusProxyFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'DBusProxyFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 16; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  DBusProxyFlags operator|(DBusProxyFlags other) =>
    new DBusProxyFlags(index | other.index);
  DBusProxyFlags operator&(DBusProxyFlags other) =>
    new DBusProxyFlags(index & other.index);
}

typedef int DBusProxyTypeFunc(DBusObjectManagerClient manager, String objectPath, String interfaceName);
class DBusSendMessageFlags extends GEnumBase {
  const DBusSendMessageFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusSendMessageFlags');

  static const DBusSendMessageFlags NONE = const DBusSendMessageFlags(0);
  bool get none => (index & 0) == 0;
  static const DBusSendMessageFlags PRESERVE_SERIAL = const DBusSendMessageFlags(1);
  bool get preserveSerial => (index & 1) == 1;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'DBusSendMessageFlags.PRESERVE_SERIAL';
      default: return 'new DBusSendMessageFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'DBusSendMessageFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 1; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  DBusSendMessageFlags operator|(DBusSendMessageFlags other) =>
    new DBusSendMessageFlags(index | other.index);
  DBusSendMessageFlags operator&(DBusSendMessageFlags other) =>
    new DBusSendMessageFlags(index & other.index);
}

class DBusServer extends GObjectObject with Initable {
  DBusServer.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusServer');

  bool get active => _staticInfo.getGPropertyOnReceiver('active', this);
  static const String ACTIVE_PROPERTY = 'active';
  String get address => _staticInfo.getGPropertyOnReceiver('address', this);
  void set address(String value) => _staticInfo.setGPropertyOnReceiver('address', this, value);
  static const String ADDRESS_PROPERTY = 'address';
  DBusAuthObserver get authenticationObserver => _staticInfo.getGPropertyOnReceiver('authentication-observer', this);
  void set authenticationObserver(DBusAuthObserver value) => _staticInfo.setGPropertyOnReceiver('authentication-observer', this, value);
  static const String AUTHENTICATION_OBSERVER_PROPERTY = 'authentication-observer';
  static const String CLIENT_ADDRESS_PROPERTY = 'client-address';
  void set flags(DBusServerFlags value) => _staticInfo.setGPropertyOnReceiver('flags', this, value);
  static const String FLAGS_PROPERTY = 'flags';
  void set guid(String value) => _staticInfo.setGPropertyOnReceiver('guid', this, value);
  static const String GUID_PROPERTY = 'guid';
  factory DBusServer.sync(String address, DBusServerFlags flags, String guid, DBusAuthObserver observer, Cancellable cancellable) => _staticInfo.callStatic('new_sync', [address, flags, guid, observer, cancellable]);
  String get clientAddress => _staticInfo.callMethodOnReceiver('get_client_address', this, []);
  DBusServerFlags get flags_ => _staticInfo.callMethodOnReceiver('get_flags', this, []);
  String get guid_ => _staticInfo.callMethodOnReceiver('get_guid', this, []);
  bool isActive() => _staticInfo.callMethodOnReceiver('is_active', this, []);
  void start() => _staticInfo.callMethodOnReceiver('start', this, []);
  void stop() => _staticInfo.callMethodOnReceiver('stop', this, []);
  int _connectToNewConnection(bool after, bool func(DBusConnection connection)) => signalConnect('new-connection', func, after);
  Stream<DBusServerNewConnectionEvent> get onNewConnection {
    int signalId;
    StreamController<DBusServerNewConnectionEvent> controller;
    controller = new StreamController<DBusServerNewConnectionEvent>(
      onListen: () {
          signalId = _connectToNewConnection(false, (DBusConnection connection) {
              var result = new DBusServerNewConnectionEvent(connection);
              controller.add(result);
              return result._cancelPropagation;
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<DBusServerNewConnectionEvent> get afterNewConnection {
    int signalId;
    StreamController<DBusServerNewConnectionEvent> controller;
    controller = new StreamController<DBusServerNewConnectionEvent>(
      onListen: () {
          signalId = _connectToNewConnection(true, (DBusConnection connection) {
              var result = new DBusServerNewConnectionEvent(connection);
              controller.add(result);
              return result._cancelPropagation;
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
}

class DBusServerNewConnectionEvent {
  final DBusConnection connection;
  bool _cancelPropagation = false;
  void cancelPropagation() {
    _cancelPropagation = true;
  }
  DBusServerNewConnectionEvent(this.connection);
}

class DBusServerFlags extends GEnumBase {
  const DBusServerFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusServerFlags');

  static const DBusServerFlags NONE = const DBusServerFlags(0);
  bool get none => (index & 0) == 0;
  static const DBusServerFlags RUN_IN_THREAD = const DBusServerFlags(1);
  bool get runInThread => (index & 1) == 1;
  static const DBusServerFlags AUTHENTICATION_ALLOW_ANONYMOUS = const DBusServerFlags(2);
  bool get authenticationAllowAnonymous => (index & 2) == 2;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'DBusServerFlags.RUN_IN_THREAD';
      case 2: return 'DBusServerFlags.AUTHENTICATION_ALLOW_ANONYMOUS';
      default: return 'new DBusServerFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'DBusServerFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 2; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  DBusServerFlags operator|(DBusServerFlags other) =>
    new DBusServerFlags(index | other.index);
  DBusServerFlags operator&(DBusServerFlags other) =>
    new DBusServerFlags(index & other.index);
}

typedef void DBusSignalCallback(DBusConnection connection, String senderName, String objectPath, String interfaceName, String signalName, Variant parameters);
class DBusSignalFlags extends GEnumBase {
  const DBusSignalFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusSignalFlags');

  static const DBusSignalFlags NONE = const DBusSignalFlags(0);
  bool get none => (index & 0) == 0;
  static const DBusSignalFlags NO_MATCH_RULE = const DBusSignalFlags(1);
  bool get noMatchRule => (index & 1) == 1;
  static const DBusSignalFlags MATCH_ARG0_NAMESPACE = const DBusSignalFlags(2);
  bool get matchArg0Namespace => (index & 2) == 2;
  static const DBusSignalFlags MATCH_ARG0_PATH = const DBusSignalFlags(4);
  bool get matchArg0Path => (index & 4) == 4;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'DBusSignalFlags.NO_MATCH_RULE';
      case 2: return 'DBusSignalFlags.MATCH_ARG0_NAMESPACE';
      case 4: return 'DBusSignalFlags.MATCH_ARG0_PATH';
      default: return 'new DBusSignalFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'DBusSignalFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 4; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  DBusSignalFlags operator|(DBusSignalFlags other) =>
    new DBusSignalFlags(index | other.index);
  DBusSignalFlags operator&(DBusSignalFlags other) =>
    new DBusSignalFlags(index & other.index);
}

class DBusSignalInfo extends GObjectBase {
  DBusSignalInfo.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusSignalInfo');

  DBusSignalInfo ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
  int get refCount => getFieldOfObject('ref_count', 0);
  void set refCount(int value) => setFieldOfObject('ref_count', 0, value);
  String get name => getFieldOfObject('name', 1);
  void set name(String value) => setFieldOfObject('name', 1, value);
  List<DBusArgInfo> get args => getFieldOfObject('args', 2);
  void set args(List<DBusArgInfo> value) => setFieldOfObject('args', 2, value);
  List<DBusAnnotationInfo> get annotations => getFieldOfObject('annotations', 3);
  void set annotations(List<DBusAnnotationInfo> value) => setFieldOfObject('annotations', 3, value);
}

typedef DBusInterfaceVTable DBusSubtreeDispatchFunc(DBusConnection connection, String sender, String objectPath, String interfaceName, String node, dynamic outUserData /* this will fail */);
class DBusSubtreeFlags extends GEnumBase {
  const DBusSubtreeFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusSubtreeFlags');

  static const DBusSubtreeFlags NONE = const DBusSubtreeFlags(0);
  bool get none => (index & 0) == 0;
  static const DBusSubtreeFlags DISPATCH_TO_UNENUMERATED_NODES = const DBusSubtreeFlags(1);
  bool get dispatchToUnenumeratedNodes => (index & 1) == 1;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'DBusSubtreeFlags.DISPATCH_TO_UNENUMERATED_NODES';
      default: return 'new DBusSubtreeFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'DBusSubtreeFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 1; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  DBusSubtreeFlags operator|(DBusSubtreeFlags other) =>
    new DBusSubtreeFlags(index | other.index);
  DBusSubtreeFlags operator&(DBusSubtreeFlags other) =>
    new DBusSubtreeFlags(index & other.index);
}

typedef DBusInterfaceInfo DBusSubtreeIntrospectFunc(DBusConnection connection, String sender, String objectPath, String node);
class DBusSubtreeVTable extends GObjectBase {
  DBusSubtreeVTable.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DBusSubtreeVTable');

  dynamic /* this will fail */ get enumerate => getFieldOfObject('enumerate', 0);
  void set enumerate(dynamic value /* this will fail */) => setFieldOfObject('enumerate', 0, value);
  DBusSubtreeIntrospectFunc get introspect => getFieldOfObject('introspect', 1);
  void set introspect(DBusSubtreeIntrospectFunc value) => setFieldOfObject('introspect', 1, value);
  DBusSubtreeDispatchFunc get dispatch => getFieldOfObject('dispatch', 2);
  void set dispatch(DBusSubtreeDispatchFunc value) => setFieldOfObject('dispatch', 2, value);
  List<dynamic /* this will fail */> get padding => getFieldOfObject('padding', 3);
}

class DataInputStream extends BufferedInputStream with Seekable {
  DataInputStream.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DataInputStream');

  static const String BYTE_ORDER_PROPERTY = 'byte-order';
  static const String NEWLINE_TYPE_PROPERTY = 'newline-type';
  factory DataInputStream(InputStream baseStream) => _staticInfo.callStatic('new', [baseStream]);
  DataStreamByteOrder get byteOrder => _staticInfo.callMethodOnReceiver('get_byte_order', this, []);
  DataStreamNewlineType get newlineType => _staticInfo.callMethodOnReceiver('get_newline_type', this, []);
  int readByte(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('read_byte', this, [cancellable]);
  int readInt16(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('read_int16', this, [cancellable]);
  int readInt32(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('read_int32', this, [cancellable]);
  int readInt64(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('read_int64', this, [cancellable]);
  List readLine(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('read_line', this, [cancellable]);
  void readLineAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('read_line_async', this, [ioPriority, cancellable, callback]);
  List readLineFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('read_line_finish', this, [result]);
  List readLineFinishUtf8(AsyncResult result) => _staticInfo.callMethodOnReceiver('read_line_finish_utf8', this, [result]);
  List readLineUtf8(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('read_line_utf8', this, [cancellable]);
  int readUint16(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('read_uint16', this, [cancellable]);
  int readUint32(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('read_uint32', this, [cancellable]);
  int readUint64(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('read_uint64', this, [cancellable]);
  List readUntil(String stopChars, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('read_until', this, [stopChars, cancellable]);
  void readUntilAsync(String stopChars, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('read_until_async', this, [stopChars, ioPriority, cancellable, callback]);
  List readUntilFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('read_until_finish', this, [result]);
  List readUpto(String stopChars, int stopCharsLen, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('read_upto', this, [stopChars, stopCharsLen, cancellable]);
  void readUptoAsync(String stopChars, int stopCharsLen, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('read_upto_async', this, [stopChars, stopCharsLen, ioPriority, cancellable, callback]);
  List readUptoFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('read_upto_finish', this, [result]);
  void set byteOrder(DataStreamByteOrder order) => _staticInfo.callMethodOnReceiver('set_byte_order', this, [order]);
  void set newlineType(DataStreamNewlineType type) => _staticInfo.callMethodOnReceiver('set_newline_type', this, [type]);
}

class DataOutputStream extends FilterOutputStream with Seekable {
  DataOutputStream.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DataOutputStream');

  static const String BYTE_ORDER_PROPERTY = 'byte-order';
  factory DataOutputStream(OutputStream baseStream) => _staticInfo.callStatic('new', [baseStream]);
  DataStreamByteOrder get byteOrder => _staticInfo.callMethodOnReceiver('get_byte_order', this, []);
  void putByte(int data, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('put_byte', this, [data, cancellable]);
  void putInt16(int data, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('put_int16', this, [data, cancellable]);
  void putInt32(int data, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('put_int32', this, [data, cancellable]);
  void putInt64(int data, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('put_int64', this, [data, cancellable]);
  void putString(String str, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('put_string', this, [str, cancellable]);
  void putUint16(int data, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('put_uint16', this, [data, cancellable]);
  void putUint32(int data, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('put_uint32', this, [data, cancellable]);
  void putUint64(int data, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('put_uint64', this, [data, cancellable]);
  void set byteOrder(DataStreamByteOrder order) => _staticInfo.callMethodOnReceiver('set_byte_order', this, [order]);
}

class DataStreamByteOrder extends GEnumBase {
  const DataStreamByteOrder(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DataStreamByteOrder');

  static const DataStreamByteOrder BIG_ENDIAN = const DataStreamByteOrder(0);
  static const DataStreamByteOrder LITTLE_ENDIAN = const DataStreamByteOrder(1);
  static const DataStreamByteOrder HOST_ENDIAN = const DataStreamByteOrder(2);
  String toString() {
    switch(index) {
      case 0: return 'DataStreamByteOrder.BIG_ENDIAN';
      case 1: return 'DataStreamByteOrder.LITTLE_ENDIAN';
      case 2: return 'DataStreamByteOrder.HOST_ENDIAN';
      default: return 'new DataStreamByteOrder($index)';
    }
  }
}

class DataStreamNewlineType extends GEnumBase {
  const DataStreamNewlineType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DataStreamNewlineType');

  static const DataStreamNewlineType LF = const DataStreamNewlineType(0);
  static const DataStreamNewlineType CR = const DataStreamNewlineType(1);
  static const DataStreamNewlineType CR_LF = const DataStreamNewlineType(2);
  static const DataStreamNewlineType ANY = const DataStreamNewlineType(3);
  String toString() {
    switch(index) {
      case 0: return 'DataStreamNewlineType.LF';
      case 1: return 'DataStreamNewlineType.CR';
      case 2: return 'DataStreamNewlineType.CR_LF';
      case 3: return 'DataStreamNewlineType.ANY';
      default: return 'new DataStreamNewlineType($index)';
    }
  }
}

class DesktopAppInfo extends GObjectObject with AppInfo {
  DesktopAppInfo.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DesktopAppInfo');

  void set filename(String value) => _staticInfo.setGPropertyOnReceiver('filename', this, value);
  static const String FILENAME_PROPERTY = 'filename';
  factory DesktopAppInfo(String desktopId) => _staticInfo.callStatic('new', [desktopId]);
  factory DesktopAppInfo.fromFilename(String filename) => _staticInfo.callStatic('new_from_filename', [filename]);
  factory DesktopAppInfo.fromKeyfile(KeyFile keyFile) => _staticInfo.callStatic('new_from_keyfile', [keyFile]);
  static GLibList /* this will fail */ getImplementations(String interface) => _staticInfo.callStatic('get_implementations', [interface]);
  static List<List<String>> search(String searchString) => _staticInfo.callStatic('search', [searchString]);
  static void setDesktopEnv(String desktopEnv) => _staticInfo.callStatic('set_desktop_env', [desktopEnv]);
  String getActionName(String actionName) => _staticInfo.callMethodOnReceiver('get_action_name', this, [actionName]);
  bool getBoolean(String key) => _staticInfo.callMethodOnReceiver('get_boolean', this, [key]);
  String get categories => _staticInfo.callMethodOnReceiver('get_categories', this, []);
  String get filename_ => _staticInfo.callMethodOnReceiver('get_filename', this, []);
  String get genericName => _staticInfo.callMethodOnReceiver('get_generic_name', this, []);
  bool get isHidden => _staticInfo.callMethodOnReceiver('get_is_hidden', this, []);
  List<String> get keywords => _staticInfo.callMethodOnReceiver('get_keywords', this, []);
  bool get nodisplay => _staticInfo.callMethodOnReceiver('get_nodisplay', this, []);
  bool getShowIn(String desktopEnv) => _staticInfo.callMethodOnReceiver('get_show_in', this, [desktopEnv]);
  String get startupWmClass => _staticInfo.callMethodOnReceiver('get_startup_wm_class', this, []);
  String getString(String key) => _staticInfo.callMethodOnReceiver('get_string', this, [key]);
  bool hasKey(String key) => _staticInfo.callMethodOnReceiver('has_key', this, [key]);
  void launchAction(String actionName, AppLaunchContext launchContext) => _staticInfo.callMethodOnReceiver('launch_action', this, [actionName, launchContext]);
  void launchUrisAsManager(GLibList uris /* this will fail */, AppLaunchContext launchContext, SpawnFlags spawnFlags, SpawnChildSetupFunc userSetup, DesktopAppLaunchCallback pidCallback) => _staticInfo.callMethodOnReceiver('launch_uris_as_manager', this, [uris, launchContext, spawnFlags, userSetup, pidCallback]);
  List<String> listActions() => _staticInfo.callMethodOnReceiver('list_actions', this, []);
}

abstract class DesktopAppInfoLookup extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DesktopAppInfoLookup');



  AppInfo getDefaultForUriScheme(String uriScheme) => _staticInfo.callMethodOnReceiver('get_default_for_uri_scheme', this, [uriScheme]);
}

typedef void DesktopAppLaunchCallback(DesktopAppInfo appinfo, int pid);
abstract class Drive extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'Drive');



  bool canEject() => _staticInfo.callMethodOnReceiver('can_eject', this, []);
  bool canPollForMedia() => _staticInfo.callMethodOnReceiver('can_poll_for_media', this, []);
  bool canStart() => _staticInfo.callMethodOnReceiver('can_start', this, []);
  bool canStartDegraded() => _staticInfo.callMethodOnReceiver('can_start_degraded', this, []);
  bool canStop() => _staticInfo.callMethodOnReceiver('can_stop', this, []);
  void eject(MountUnmountFlags flags, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('eject', this, [flags, cancellable, callback]);
  void ejectFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('eject_finish', this, [result]);
  void ejectWithOperation(MountUnmountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('eject_with_operation', this, [flags, mountOperation, cancellable, callback]);
  void ejectWithOperationFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('eject_with_operation_finish', this, [result]);
  List<String> enumerateIdentifiers() => _staticInfo.callMethodOnReceiver('enumerate_identifiers', this, []);
  Icon get icon => _staticInfo.callMethodOnReceiver('get_icon', this, []);
  String getIdentifier(String kind) => _staticInfo.callMethodOnReceiver('get_identifier', this, [kind]);
  String get name => _staticInfo.callMethodOnReceiver('get_name', this, []);
  String get sortKey => _staticInfo.callMethodOnReceiver('get_sort_key', this, []);
  DriveStartStopType get startStopType => _staticInfo.callMethodOnReceiver('get_start_stop_type', this, []);
  Icon get symbolicIcon => _staticInfo.callMethodOnReceiver('get_symbolic_icon', this, []);
  GLibList /* this will fail */ get volumes => _staticInfo.callMethodOnReceiver('get_volumes', this, []);
  bool hasMedia() => _staticInfo.callMethodOnReceiver('has_media', this, []);
  bool hasVolumes() => _staticInfo.callMethodOnReceiver('has_volumes', this, []);
  bool isMediaCheckAutomatic() => _staticInfo.callMethodOnReceiver('is_media_check_automatic', this, []);
  bool isMediaRemovable() => _staticInfo.callMethodOnReceiver('is_media_removable', this, []);
  void pollForMedia(Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('poll_for_media', this, [cancellable, callback]);
  void pollForMediaFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('poll_for_media_finish', this, [result]);
  void start(DriveStartFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('start', this, [flags, mountOperation, cancellable, callback]);
  void startFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('start_finish', this, [result]);
  void stop(MountUnmountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('stop', this, [flags, mountOperation, cancellable, callback]);
  void stopFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('stop_finish', this, [result]);
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
  int _connectToDisconnected(bool after, void func()) => signalConnect('disconnected', func, after);
  Stream get onDisconnected {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToDisconnected(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterDisconnected {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToDisconnected(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToEjectButton(bool after, void func()) => signalConnect('eject-button', func, after);
  Stream get onEjectButton {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToEjectButton(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterEjectButton {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToEjectButton(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToStopButton(bool after, void func()) => signalConnect('stop-button', func, after);
  Stream get onStopButton {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToStopButton(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterStopButton {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToStopButton(true, () {
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

class DriveStartFlags extends GEnumBase {
  const DriveStartFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DriveStartFlags');

  static const DriveStartFlags NONE = const DriveStartFlags(0);
  bool get none => (index & 0) == 0;
  static _valueToString(int value) {
    switch(value) {
      default: return 'new DriveStartFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'DriveStartFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 0; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  DriveStartFlags operator|(DriveStartFlags other) =>
    new DriveStartFlags(index | other.index);
  DriveStartFlags operator&(DriveStartFlags other) =>
    new DriveStartFlags(index & other.index);
}

class DriveStartStopType extends GEnumBase {
  const DriveStartStopType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'DriveStartStopType');

  static const DriveStartStopType UNKNOWN = const DriveStartStopType(0);
  static const DriveStartStopType SHUTDOWN = const DriveStartStopType(1);
  static const DriveStartStopType NETWORK = const DriveStartStopType(2);
  static const DriveStartStopType MULTIDISK = const DriveStartStopType(3);
  static const DriveStartStopType PASSWORD = const DriveStartStopType(4);
  String toString() {
    switch(index) {
      case 0: return 'DriveStartStopType.UNKNOWN';
      case 1: return 'DriveStartStopType.SHUTDOWN';
      case 2: return 'DriveStartStopType.NETWORK';
      case 3: return 'DriveStartStopType.MULTIDISK';
      case 4: return 'DriveStartStopType.PASSWORD';
      default: return 'new DriveStartStopType($index)';
    }
  }
}

class Emblem extends GObjectObject with Icon {
  Emblem.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'Emblem');

  void set icon(GObjectObject value) => _staticInfo.setGPropertyOnReceiver('icon', this, value);
  static const String ICON_PROPERTY = 'icon';
  void set origin(EmblemOrigin value) => _staticInfo.setGPropertyOnReceiver('origin', this, value);
  static const String ORIGIN_PROPERTY = 'origin';
  factory Emblem(Icon icon) => _staticInfo.callStatic('new', [icon]);
  factory Emblem.withOrigin(Icon icon, EmblemOrigin origin) => _staticInfo.callStatic('new_with_origin', [icon, origin]);
  Icon get icon_ => _staticInfo.callMethodOnReceiver('get_icon', this, []);
  EmblemOrigin get origin_ => _staticInfo.callMethodOnReceiver('get_origin', this, []);
}

class EmblemOrigin extends GEnumBase {
  const EmblemOrigin(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'EmblemOrigin');

  static const EmblemOrigin UNKNOWN = const EmblemOrigin(0);
  static const EmblemOrigin DEVICE = const EmblemOrigin(1);
  static const EmblemOrigin LIVEMETADATA = const EmblemOrigin(2);
  static const EmblemOrigin TAG = const EmblemOrigin(3);
  String toString() {
    switch(index) {
      case 0: return 'EmblemOrigin.UNKNOWN';
      case 1: return 'EmblemOrigin.DEVICE';
      case 2: return 'EmblemOrigin.LIVEMETADATA';
      case 3: return 'EmblemOrigin.TAG';
      default: return 'new EmblemOrigin($index)';
    }
  }
}

class EmblemedIcon extends GObjectObject with Icon {
  EmblemedIcon.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'EmblemedIcon');

  Icon get gicon => _staticInfo.getGPropertyOnReceiver('gicon', this);
  void set gicon(Icon value) => _staticInfo.setGPropertyOnReceiver('gicon', this, value);
  static const String GICON_PROPERTY = 'gicon';
  factory EmblemedIcon(Icon icon, Emblem emblem) => _staticInfo.callStatic('new', [icon, emblem]);
  void addEmblem(Emblem emblem) => _staticInfo.callMethodOnReceiver('add_emblem', this, [emblem]);
  void clearEmblems() => _staticInfo.callMethodOnReceiver('clear_emblems', this, []);
  GLibList /* this will fail */ get emblems => _staticInfo.callMethodOnReceiver('get_emblems', this, []);
  Icon get icon => _staticInfo.callMethodOnReceiver('get_icon', this, []);
}

abstract class File extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'File');



  static File newForCommandlineArg(String arg) => _staticInfo.callStatic('new_for_commandline_arg', [arg]);
  static File newForCommandlineArgAndCwd(String arg, String cwd) => _staticInfo.callStatic('new_for_commandline_arg_and_cwd', [arg, cwd]);
  static File newForPath(String path) => _staticInfo.callStatic('new_for_path', [path]);
  static File newForUri(String uri) => _staticInfo.callStatic('new_for_uri', [uri]);
  static List newTmp(String tmpl) => _staticInfo.callStatic('new_tmp', [tmpl]);
  static File parseName(String parseName) => _staticInfo.callStatic('parse_name', [parseName]);
  FileOutputStream appendTo(FileCreateFlags flags, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('append_to', this, [flags, cancellable]);
  void appendToAsync(FileCreateFlags flags, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('append_to_async', this, [flags, ioPriority, cancellable, callback]);
  FileOutputStream appendToFinish(AsyncResult res) => _staticInfo.callMethodOnReceiver('append_to_finish', this, [res]);
  void copy(File destination, FileCopyFlags flags, Cancellable cancellable, FileProgressCallback progressCallback) => _staticInfo.callMethodOnReceiver('copy', this, [destination, flags, cancellable, progressCallback]);
  void copyAttributes(File destination, FileCopyFlags flags, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('copy_attributes', this, [destination, flags, cancellable]);
  void copyFinish(AsyncResult res) => _staticInfo.callMethodOnReceiver('copy_finish', this, [res]);
  FileOutputStream create(FileCreateFlags flags, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('create', this, [flags, cancellable]);
  void createAsync(FileCreateFlags flags, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('create_async', this, [flags, ioPriority, cancellable, callback]);
  FileOutputStream createFinish(AsyncResult res) => _staticInfo.callMethodOnReceiver('create_finish', this, [res]);
  FileIOStream createReadwrite(FileCreateFlags flags, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('create_readwrite', this, [flags, cancellable]);
  void createReadwriteAsync(FileCreateFlags flags, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('create_readwrite_async', this, [flags, ioPriority, cancellable, callback]);
  FileIOStream createReadwriteFinish(AsyncResult res) => _staticInfo.callMethodOnReceiver('create_readwrite_finish', this, [res]);
  void delete(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('delete', this, [cancellable]);
  void deleteAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('delete_async', this, [ioPriority, cancellable, callback]);
  void deleteFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('delete_finish', this, [result]);
  File dup() => _staticInfo.callMethodOnReceiver('dup', this, []);
  void ejectMountable(MountUnmountFlags flags, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('eject_mountable', this, [flags, cancellable, callback]);
  void ejectMountableFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('eject_mountable_finish', this, [result]);
  void ejectMountableWithOperation(MountUnmountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('eject_mountable_with_operation', this, [flags, mountOperation, cancellable, callback]);
  void ejectMountableWithOperationFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('eject_mountable_with_operation_finish', this, [result]);
  FileEnumerator enumerateChildren(String attributes, FileQueryInfoFlags flags, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('enumerate_children', this, [attributes, flags, cancellable]);
  void enumerateChildrenAsync(String attributes, FileQueryInfoFlags flags, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('enumerate_children_async', this, [attributes, flags, ioPriority, cancellable, callback]);
  FileEnumerator enumerateChildrenFinish(AsyncResult res) => _staticInfo.callMethodOnReceiver('enumerate_children_finish', this, [res]);
  bool equal(File file2) => _staticInfo.callMethodOnReceiver('equal', this, [file2]);
  Mount findEnclosingMount(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('find_enclosing_mount', this, [cancellable]);
  void findEnclosingMountAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('find_enclosing_mount_async', this, [ioPriority, cancellable, callback]);
  Mount findEnclosingMountFinish(AsyncResult res) => _staticInfo.callMethodOnReceiver('find_enclosing_mount_finish', this, [res]);
  String get basename => _staticInfo.callMethodOnReceiver('get_basename', this, []);
  File getChild(String name) => _staticInfo.callMethodOnReceiver('get_child', this, [name]);
  File getChildForDisplayName(String displayName) => _staticInfo.callMethodOnReceiver('get_child_for_display_name', this, [displayName]);
  File get parent => _staticInfo.callMethodOnReceiver('get_parent', this, []);
  String get parseName_ => _staticInfo.callMethodOnReceiver('get_parse_name', this, []);
  String get path => _staticInfo.callMethodOnReceiver('get_path', this, []);
  String getRelativePath(File descendant) => _staticInfo.callMethodOnReceiver('get_relative_path', this, [descendant]);
  String get uri => _staticInfo.callMethodOnReceiver('get_uri', this, []);
  String get uriScheme => _staticInfo.callMethodOnReceiver('get_uri_scheme', this, []);
  bool hasParent(File parent) => _staticInfo.callMethodOnReceiver('has_parent', this, [parent]);
  bool hasPrefix(File prefix) => _staticInfo.callMethodOnReceiver('has_prefix', this, [prefix]);
  bool hasUriScheme(String uriScheme) => _staticInfo.callMethodOnReceiver('has_uri_scheme', this, [uriScheme]);
  int hash() => _staticInfo.callMethodOnReceiver('hash', this, []);
  bool isNative() => _staticInfo.callMethodOnReceiver('is_native', this, []);
  List loadContents(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('load_contents', this, [cancellable]);
  void loadContentsAsync(Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('load_contents_async', this, [cancellable, callback]);
  List loadContentsFinish(AsyncResult res) => _staticInfo.callMethodOnReceiver('load_contents_finish', this, [res]);
  List loadPartialContentsFinish(AsyncResult res) => _staticInfo.callMethodOnReceiver('load_partial_contents_finish', this, [res]);
  void makeDirectory(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('make_directory', this, [cancellable]);
  void makeDirectoryAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('make_directory_async', this, [ioPriority, cancellable, callback]);
  void makeDirectoryFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('make_directory_finish', this, [result]);
  void makeDirectoryWithParents(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('make_directory_with_parents', this, [cancellable]);
  void makeSymbolicLink(String symlinkValue, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('make_symbolic_link', this, [symlinkValue, cancellable]);
  List measureDiskUsageFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('measure_disk_usage_finish', this, [result]);
  FileMonitor monitor(FileMonitorFlags flags, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('monitor', this, [flags, cancellable]);
  FileMonitor monitorDirectory(FileMonitorFlags flags, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('monitor_directory', this, [flags, cancellable]);
  FileMonitor monitorFile(FileMonitorFlags flags, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('monitor_file', this, [flags, cancellable]);
  void mountEnclosingVolume(MountMountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('mount_enclosing_volume', this, [flags, mountOperation, cancellable, callback]);
  void mountEnclosingVolumeFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('mount_enclosing_volume_finish', this, [result]);
  void mountMountable(MountMountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('mount_mountable', this, [flags, mountOperation, cancellable, callback]);
  File mountMountableFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('mount_mountable_finish', this, [result]);
  void move(File destination, FileCopyFlags flags, Cancellable cancellable, FileProgressCallback progressCallback) => _staticInfo.callMethodOnReceiver('move', this, [destination, flags, cancellable, progressCallback]);
  FileIOStream openReadwrite(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('open_readwrite', this, [cancellable]);
  void openReadwriteAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('open_readwrite_async', this, [ioPriority, cancellable, callback]);
  FileIOStream openReadwriteFinish(AsyncResult res) => _staticInfo.callMethodOnReceiver('open_readwrite_finish', this, [res]);
  void pollMountable(Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('poll_mountable', this, [cancellable, callback]);
  void pollMountableFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('poll_mountable_finish', this, [result]);
  AppInfo queryDefaultHandler(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('query_default_handler', this, [cancellable]);
  bool queryExists(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('query_exists', this, [cancellable]);
  FileType queryFileType(FileQueryInfoFlags flags, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('query_file_type', this, [flags, cancellable]);
  FileInfo queryFilesystemInfo(String attributes, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('query_filesystem_info', this, [attributes, cancellable]);
  void queryFilesystemInfoAsync(String attributes, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('query_filesystem_info_async', this, [attributes, ioPriority, cancellable, callback]);
  FileInfo queryFilesystemInfoFinish(AsyncResult res) => _staticInfo.callMethodOnReceiver('query_filesystem_info_finish', this, [res]);
  FileInfo queryInfo(String attributes, FileQueryInfoFlags flags, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('query_info', this, [attributes, flags, cancellable]);
  void queryInfoAsync(String attributes, FileQueryInfoFlags flags, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('query_info_async', this, [attributes, flags, ioPriority, cancellable, callback]);
  FileInfo queryInfoFinish(AsyncResult res) => _staticInfo.callMethodOnReceiver('query_info_finish', this, [res]);
  FileAttributeInfoList querySettableAttributes(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('query_settable_attributes', this, [cancellable]);
  FileAttributeInfoList queryWritableNamespaces(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('query_writable_namespaces', this, [cancellable]);
  FileInputStream read(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('read', this, [cancellable]);
  void readAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('read_async', this, [ioPriority, cancellable, callback]);
  FileInputStream readFinish(AsyncResult res) => _staticInfo.callMethodOnReceiver('read_finish', this, [res]);
  FileOutputStream replace(String etag, bool makeBackup, FileCreateFlags flags, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('replace', this, [etag, makeBackup, flags, cancellable]);
  void replaceAsync(String etag, bool makeBackup, FileCreateFlags flags, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('replace_async', this, [etag, makeBackup, flags, ioPriority, cancellable, callback]);
  String replaceContents(List<int> contents, String etag, bool makeBackup, FileCreateFlags flags, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('replace_contents', this, [contents, etag, makeBackup, flags, cancellable]);
  void replaceContentsAsync(List<int> contents, String etag, bool makeBackup, FileCreateFlags flags, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('replace_contents_async', this, [contents, etag, makeBackup, flags, cancellable, callback]);
  void replaceContentsBytesAsync(Bytes contents, String etag, bool makeBackup, FileCreateFlags flags, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('replace_contents_bytes_async', this, [contents, etag, makeBackup, flags, cancellable, callback]);
  String replaceContentsFinish(AsyncResult res) => _staticInfo.callMethodOnReceiver('replace_contents_finish', this, [res]);
  FileOutputStream replaceFinish(AsyncResult res) => _staticInfo.callMethodOnReceiver('replace_finish', this, [res]);
  FileIOStream replaceReadwrite(String etag, bool makeBackup, FileCreateFlags flags, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('replace_readwrite', this, [etag, makeBackup, flags, cancellable]);
  void replaceReadwriteAsync(String etag, bool makeBackup, FileCreateFlags flags, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('replace_readwrite_async', this, [etag, makeBackup, flags, ioPriority, cancellable, callback]);
  FileIOStream replaceReadwriteFinish(AsyncResult res) => _staticInfo.callMethodOnReceiver('replace_readwrite_finish', this, [res]);
  File resolveRelativePath(String relativePath) => _staticInfo.callMethodOnReceiver('resolve_relative_path', this, [relativePath]);
  void setAttribute(String attribute, FileAttributeType type, dynamic valueP /* this will fail */, FileQueryInfoFlags flags, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('set_attribute', this, [attribute, type, valueP, flags, cancellable]);
  void setAttributeByteString(String attribute, String value, FileQueryInfoFlags flags, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('set_attribute_byte_string', this, [attribute, value, flags, cancellable]);
  void setAttributeInt32(String attribute, int value, FileQueryInfoFlags flags, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('set_attribute_int32', this, [attribute, value, flags, cancellable]);
  void setAttributeInt64(String attribute, int value, FileQueryInfoFlags flags, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('set_attribute_int64', this, [attribute, value, flags, cancellable]);
  void setAttributeString(String attribute, String value, FileQueryInfoFlags flags, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('set_attribute_string', this, [attribute, value, flags, cancellable]);
  void setAttributeUint32(String attribute, int value, FileQueryInfoFlags flags, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('set_attribute_uint32', this, [attribute, value, flags, cancellable]);
  void setAttributeUint64(String attribute, int value, FileQueryInfoFlags flags, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('set_attribute_uint64', this, [attribute, value, flags, cancellable]);
  void setAttributesAsync(FileInfo info, FileQueryInfoFlags flags, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('set_attributes_async', this, [info, flags, ioPriority, cancellable, callback]);
  FileInfo setAttributesFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('set_attributes_finish', this, [result]);
  void setAttributesFromInfo(FileInfo info, FileQueryInfoFlags flags, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('set_attributes_from_info', this, [info, flags, cancellable]);
  File setDisplayName(String displayName, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('set_display_name', this, [displayName, cancellable]);
  void setDisplayNameAsync(String displayName, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('set_display_name_async', this, [displayName, ioPriority, cancellable, callback]);
  File setDisplayNameFinish(AsyncResult res) => _staticInfo.callMethodOnReceiver('set_display_name_finish', this, [res]);
  void startMountable(DriveStartFlags flags, MountOperation startOperation, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('start_mountable', this, [flags, startOperation, cancellable, callback]);
  void startMountableFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('start_mountable_finish', this, [result]);
  void stopMountable(MountUnmountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('stop_mountable', this, [flags, mountOperation, cancellable, callback]);
  void stopMountableFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('stop_mountable_finish', this, [result]);
  bool supportsThreadContexts() => _staticInfo.callMethodOnReceiver('supports_thread_contexts', this, []);
  void trash(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('trash', this, [cancellable]);
  void trashAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('trash_async', this, [ioPriority, cancellable, callback]);
  void trashFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('trash_finish', this, [result]);
  void unmountMountable(MountUnmountFlags flags, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('unmount_mountable', this, [flags, cancellable, callback]);
  void unmountMountableFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('unmount_mountable_finish', this, [result]);
  void unmountMountableWithOperation(MountUnmountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('unmount_mountable_with_operation', this, [flags, mountOperation, cancellable, callback]);
  void unmountMountableWithOperationFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('unmount_mountable_with_operation_finish', this, [result]);
}

class FileAttributeInfo extends GObjectBase {
  FileAttributeInfo.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'FileAttributeInfo');

  String get name => getFieldOfObject('name', 0);
  void set name(String value) => setFieldOfObject('name', 0, value);
  FileAttributeType get type => getFieldOfObject('type', 1);
  void set type(FileAttributeType value) => setFieldOfObject('type', 1, value);
  FileAttributeInfoFlags get flags => getFieldOfObject('flags', 2);
  void set flags(FileAttributeInfoFlags value) => setFieldOfObject('flags', 2, value);
}

class FileAttributeInfoFlags extends GEnumBase {
  const FileAttributeInfoFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'FileAttributeInfoFlags');

  static const FileAttributeInfoFlags NONE = const FileAttributeInfoFlags(0);
  bool get none => (index & 0) == 0;
  static const FileAttributeInfoFlags COPY_WITH_FILE = const FileAttributeInfoFlags(1);
  bool get copyWithFile => (index & 1) == 1;
  static const FileAttributeInfoFlags COPY_WHEN_MOVED = const FileAttributeInfoFlags(2);
  bool get copyWhenMoved => (index & 2) == 2;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'FileAttributeInfoFlags.COPY_WITH_FILE';
      case 2: return 'FileAttributeInfoFlags.COPY_WHEN_MOVED';
      default: return 'new FileAttributeInfoFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'FileAttributeInfoFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 2; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  FileAttributeInfoFlags operator|(FileAttributeInfoFlags other) =>
    new FileAttributeInfoFlags(index | other.index);
  FileAttributeInfoFlags operator&(FileAttributeInfoFlags other) =>
    new FileAttributeInfoFlags(index & other.index);
}

class FileAttributeInfoList extends GObjectBase {
  FileAttributeInfoList.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'FileAttributeInfoList');

  factory FileAttributeInfoList() => _staticInfo.callStatic('new', []);
  void add(String name, FileAttributeType type, FileAttributeInfoFlags flags) => _staticInfo.callMethodOnReceiver('add', this, [name, type, flags]);
  FileAttributeInfoList dup() => _staticInfo.callMethodOnReceiver('dup', this, []);
  FileAttributeInfo lookup(String name) => _staticInfo.callMethodOnReceiver('lookup', this, [name]);
  FileAttributeInfoList ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
  FileAttributeInfo get infos => getFieldOfObject('infos', 0);
  void set infos(FileAttributeInfo value) => setFieldOfObject('infos', 0, value);
  int get nInfos => getFieldOfObject('n_infos', 1);
  void set nInfos(int value) => setFieldOfObject('n_infos', 1, value);
}

class FileAttributeMatcher extends GObjectBase {
  FileAttributeMatcher.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'FileAttributeMatcher');

  factory FileAttributeMatcher(String attributes) => _staticInfo.callStatic('new', [attributes]);
  bool enumerateNamespace(String ns) => _staticInfo.callMethodOnReceiver('enumerate_namespace', this, [ns]);
  String enumerateNext() => _staticInfo.callMethodOnReceiver('enumerate_next', this, []);
  bool matches(String attribute) => _staticInfo.callMethodOnReceiver('matches', this, [attribute]);
  bool matchesOnly(String attribute) => _staticInfo.callMethodOnReceiver('matches_only', this, [attribute]);
  FileAttributeMatcher ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  FileAttributeMatcher subtract(FileAttributeMatcher subtract) => _staticInfo.callMethodOnReceiver('subtract', this, [subtract]);
  String toString() => _staticInfo.callMethodOnReceiver('to_string', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
}

class FileAttributeStatus extends GEnumBase {
  const FileAttributeStatus(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'FileAttributeStatus');

  static const FileAttributeStatus UNSET = const FileAttributeStatus(0);
  static const FileAttributeStatus SET = const FileAttributeStatus(1);
  static const FileAttributeStatus ERROR_SETTING = const FileAttributeStatus(2);
  String toString() {
    switch(index) {
      case 0: return 'FileAttributeStatus.UNSET';
      case 1: return 'FileAttributeStatus.SET';
      case 2: return 'FileAttributeStatus.ERROR_SETTING';
      default: return 'new FileAttributeStatus($index)';
    }
  }
}

class FileAttributeType extends GEnumBase {
  const FileAttributeType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'FileAttributeType');

  static const FileAttributeType INVALID = const FileAttributeType(0);
  static const FileAttributeType STRING = const FileAttributeType(1);
  static const FileAttributeType BYTE_STRING = const FileAttributeType(2);
  static const FileAttributeType BOOLEAN = const FileAttributeType(3);
  static const FileAttributeType UINT32 = const FileAttributeType(4);
  static const FileAttributeType INT32 = const FileAttributeType(5);
  static const FileAttributeType UINT64 = const FileAttributeType(6);
  static const FileAttributeType INT64 = const FileAttributeType(7);
  static const FileAttributeType OBJECT = const FileAttributeType(8);
  static const FileAttributeType STRINGV = const FileAttributeType(9);
  String toString() {
    switch(index) {
      case 0: return 'FileAttributeType.INVALID';
      case 1: return 'FileAttributeType.STRING';
      case 2: return 'FileAttributeType.BYTE_STRING';
      case 3: return 'FileAttributeType.BOOLEAN';
      case 4: return 'FileAttributeType.UINT32';
      case 5: return 'FileAttributeType.INT32';
      case 6: return 'FileAttributeType.UINT64';
      case 7: return 'FileAttributeType.INT64';
      case 8: return 'FileAttributeType.OBJECT';
      case 9: return 'FileAttributeType.STRINGV';
      default: return 'new FileAttributeType($index)';
    }
  }
}

class FileCopyFlags extends GEnumBase {
  const FileCopyFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'FileCopyFlags');

  static const FileCopyFlags NONE = const FileCopyFlags(0);
  bool get none => (index & 0) == 0;
  static const FileCopyFlags OVERWRITE = const FileCopyFlags(1);
  bool get overwrite => (index & 1) == 1;
  static const FileCopyFlags BACKUP = const FileCopyFlags(2);
  bool get backup => (index & 2) == 2;
  static const FileCopyFlags NOFOLLOW_SYMLINKS = const FileCopyFlags(4);
  bool get nofollowSymlinks => (index & 4) == 4;
  static const FileCopyFlags ALL_METADATA = const FileCopyFlags(8);
  bool get allMetadata => (index & 8) == 8;
  static const FileCopyFlags NO_FALLBACK_FOR_MOVE = const FileCopyFlags(16);
  bool get noFallbackForMove => (index & 16) == 16;
  static const FileCopyFlags TARGET_DEFAULT_PERMS = const FileCopyFlags(32);
  bool get targetDefaultPerms => (index & 32) == 32;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'FileCopyFlags.OVERWRITE';
      case 2: return 'FileCopyFlags.BACKUP';
      case 4: return 'FileCopyFlags.NOFOLLOW_SYMLINKS';
      case 8: return 'FileCopyFlags.ALL_METADATA';
      case 16: return 'FileCopyFlags.NO_FALLBACK_FOR_MOVE';
      case 32: return 'FileCopyFlags.TARGET_DEFAULT_PERMS';
      default: return 'new FileCopyFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'FileCopyFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 32; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  FileCopyFlags operator|(FileCopyFlags other) =>
    new FileCopyFlags(index | other.index);
  FileCopyFlags operator&(FileCopyFlags other) =>
    new FileCopyFlags(index & other.index);
}

class FileCreateFlags extends GEnumBase {
  const FileCreateFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'FileCreateFlags');

  static const FileCreateFlags NONE = const FileCreateFlags(0);
  bool get none => (index & 0) == 0;
  static const FileCreateFlags PRIVATE = const FileCreateFlags(1);
  bool get private => (index & 1) == 1;
  static const FileCreateFlags REPLACE_DESTINATION = const FileCreateFlags(2);
  bool get replaceDestination => (index & 2) == 2;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'FileCreateFlags.PRIVATE';
      case 2: return 'FileCreateFlags.REPLACE_DESTINATION';
      default: return 'new FileCreateFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'FileCreateFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 2; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  FileCreateFlags operator|(FileCreateFlags other) =>
    new FileCreateFlags(index | other.index);
  FileCreateFlags operator&(FileCreateFlags other) =>
    new FileCreateFlags(index & other.index);
}

abstract class FileDescriptorBased extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'FileDescriptorBased');



  int get fd => _staticInfo.callMethodOnReceiver('get_fd', this, []);
}

class FileEnumerator extends GObjectObject {
  FileEnumerator.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'FileEnumerator');

  void set container(File value) => _staticInfo.setGPropertyOnReceiver('container', this, value);
  static const String CONTAINER_PROPERTY = 'container';
  void close(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('close', this, [cancellable]);
  void closeAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('close_async', this, [ioPriority, cancellable, callback]);
  void closeFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('close_finish', this, [result]);
  File getChild(FileInfo info) => _staticInfo.callMethodOnReceiver('get_child', this, [info]);
  File get container_ => _staticInfo.callMethodOnReceiver('get_container', this, []);
  bool hasPending() => _staticInfo.callMethodOnReceiver('has_pending', this, []);
  bool isClosed() => _staticInfo.callMethodOnReceiver('is_closed', this, []);
  List iterate(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('iterate', this, [cancellable]);
  FileInfo nextFile(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('next_file', this, [cancellable]);
  void nextFilesAsync(int numFiles, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('next_files_async', this, [numFiles, ioPriority, cancellable, callback]);
  GLibList /* this will fail */ nextFilesFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('next_files_finish', this, [result]);
  void setPending(bool pending) => _staticInfo.callMethodOnReceiver('set_pending', this, [pending]);
}

class FileIOStream extends IOStream with Seekable {
  FileIOStream.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'FileIOStream');

  String get etag => _staticInfo.callMethodOnReceiver('get_etag', this, []);
  FileInfo queryInfo(String attributes, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('query_info', this, [attributes, cancellable]);
  void queryInfoAsync(String attributes, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('query_info_async', this, [attributes, ioPriority, cancellable, callback]);
  FileInfo queryInfoFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('query_info_finish', this, [result]);
}

class FileIcon extends GObjectObject with Icon, LoadableIcon {
  FileIcon.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'FileIcon');

  void set file(File value) => _staticInfo.setGPropertyOnReceiver('file', this, value);
  static const String FILE_PROPERTY = 'file';
  factory FileIcon(File file) => _staticInfo.callStatic('new', [file]);
  File get file_ => _staticInfo.callMethodOnReceiver('get_file', this, []);
}

class FileInfo extends GObjectObject {
  FileInfo.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'FileInfo');

  factory FileInfo() => _staticInfo.callStatic('new', []);
  void clearStatus() => _staticInfo.callMethodOnReceiver('clear_status', this, []);
  void copyInto(FileInfo destInfo) => _staticInfo.callMethodOnReceiver('copy_into', this, [destInfo]);
  FileInfo dup() => _staticInfo.callMethodOnReceiver('dup', this, []);
  String getAttributeAsString(String attribute) => _staticInfo.callMethodOnReceiver('get_attribute_as_string', this, [attribute]);
  bool getAttributeBoolean(String attribute) => _staticInfo.callMethodOnReceiver('get_attribute_boolean', this, [attribute]);
  String getAttributeByteString(String attribute) => _staticInfo.callMethodOnReceiver('get_attribute_byte_string', this, [attribute]);
  List getAttributeData(String attribute) => _staticInfo.callMethodOnReceiver('get_attribute_data', this, [attribute]);
  int getAttributeInt32(String attribute) => _staticInfo.callMethodOnReceiver('get_attribute_int32', this, [attribute]);
  int getAttributeInt64(String attribute) => _staticInfo.callMethodOnReceiver('get_attribute_int64', this, [attribute]);
  GObjectObject getAttributeObject(String attribute) => _staticInfo.callMethodOnReceiver('get_attribute_object', this, [attribute]);
  FileAttributeStatus getAttributeStatus(String attribute) => _staticInfo.callMethodOnReceiver('get_attribute_status', this, [attribute]);
  String getAttributeString(String attribute) => _staticInfo.callMethodOnReceiver('get_attribute_string', this, [attribute]);
  List<String> getAttributeStringv(String attribute) => _staticInfo.callMethodOnReceiver('get_attribute_stringv', this, [attribute]);
  FileAttributeType getAttributeType(String attribute) => _staticInfo.callMethodOnReceiver('get_attribute_type', this, [attribute]);
  int getAttributeUint32(String attribute) => _staticInfo.callMethodOnReceiver('get_attribute_uint32', this, [attribute]);
  int getAttributeUint64(String attribute) => _staticInfo.callMethodOnReceiver('get_attribute_uint64', this, [attribute]);
  String get contentType => _staticInfo.callMethodOnReceiver('get_content_type', this, []);
  GLibDateTime get deletionDate => _staticInfo.callMethodOnReceiver('get_deletion_date', this, []);
  String get displayName => _staticInfo.callMethodOnReceiver('get_display_name', this, []);
  String get editName => _staticInfo.callMethodOnReceiver('get_edit_name', this, []);
  String get etag => _staticInfo.callMethodOnReceiver('get_etag', this, []);
  FileType get fileType => _staticInfo.callMethodOnReceiver('get_file_type', this, []);
  Icon get icon => _staticInfo.callMethodOnReceiver('get_icon', this, []);
  bool get isBackup => _staticInfo.callMethodOnReceiver('get_is_backup', this, []);
  bool get isHidden => _staticInfo.callMethodOnReceiver('get_is_hidden', this, []);
  bool get isSymlink => _staticInfo.callMethodOnReceiver('get_is_symlink', this, []);
  TimeVal get modificationTime => _staticInfo.callMethodOnReceiver('get_modification_time', this, []);
  String get name => _staticInfo.callMethodOnReceiver('get_name', this, []);
  int get size => _staticInfo.callMethodOnReceiver('get_size', this, []);
  int get sortOrder => _staticInfo.callMethodOnReceiver('get_sort_order', this, []);
  Icon get symbolicIcon => _staticInfo.callMethodOnReceiver('get_symbolic_icon', this, []);
  String get symlinkTarget => _staticInfo.callMethodOnReceiver('get_symlink_target', this, []);
  bool hasAttribute(String attribute) => _staticInfo.callMethodOnReceiver('has_attribute', this, [attribute]);
  bool hasNamespace(String nameSpace) => _staticInfo.callMethodOnReceiver('has_namespace', this, [nameSpace]);
  List<String> listAttributes(String nameSpace) => _staticInfo.callMethodOnReceiver('list_attributes', this, [nameSpace]);
  void removeAttribute(String attribute) => _staticInfo.callMethodOnReceiver('remove_attribute', this, [attribute]);
  void setAttribute(String attribute, FileAttributeType type, dynamic valueP /* this will fail */) => _staticInfo.callMethodOnReceiver('set_attribute', this, [attribute, type, valueP]);
  void setAttributeBoolean(String attribute, bool attrValue) => _staticInfo.callMethodOnReceiver('set_attribute_boolean', this, [attribute, attrValue]);
  void setAttributeByteString(String attribute, String attrValue) => _staticInfo.callMethodOnReceiver('set_attribute_byte_string', this, [attribute, attrValue]);
  void setAttributeInt32(String attribute, int attrValue) => _staticInfo.callMethodOnReceiver('set_attribute_int32', this, [attribute, attrValue]);
  void setAttributeInt64(String attribute, int attrValue) => _staticInfo.callMethodOnReceiver('set_attribute_int64', this, [attribute, attrValue]);
  void setAttributeMask(FileAttributeMatcher mask) => _staticInfo.callMethodOnReceiver('set_attribute_mask', this, [mask]);
  void setAttributeObject(String attribute, GObjectObject attrValue) => _staticInfo.callMethodOnReceiver('set_attribute_object', this, [attribute, attrValue]);
  bool setAttributeStatus(String attribute, FileAttributeStatus status) => _staticInfo.callMethodOnReceiver('set_attribute_status', this, [attribute, status]);
  void setAttributeString(String attribute, String attrValue) => _staticInfo.callMethodOnReceiver('set_attribute_string', this, [attribute, attrValue]);
  void setAttributeStringv(String attribute, List<String> attrValue) => _staticInfo.callMethodOnReceiver('set_attribute_stringv', this, [attribute, attrValue]);
  void setAttributeUint32(String attribute, int attrValue) => _staticInfo.callMethodOnReceiver('set_attribute_uint32', this, [attribute, attrValue]);
  void setAttributeUint64(String attribute, int attrValue) => _staticInfo.callMethodOnReceiver('set_attribute_uint64', this, [attribute, attrValue]);
  void set contentType(String contentType) => _staticInfo.callMethodOnReceiver('set_content_type', this, [contentType]);
  void set displayName(String displayName) => _staticInfo.callMethodOnReceiver('set_display_name', this, [displayName]);
  void set editName(String editName) => _staticInfo.callMethodOnReceiver('set_edit_name', this, [editName]);
  void set fileType(FileType type) => _staticInfo.callMethodOnReceiver('set_file_type', this, [type]);
  void set icon(Icon icon) => _staticInfo.callMethodOnReceiver('set_icon', this, [icon]);
  void set isHidden(bool isHidden) => _staticInfo.callMethodOnReceiver('set_is_hidden', this, [isHidden]);
  void set isSymlink(bool isSymlink) => _staticInfo.callMethodOnReceiver('set_is_symlink', this, [isSymlink]);
  void set modificationTime(TimeVal mtime) => _staticInfo.callMethodOnReceiver('set_modification_time', this, [mtime]);
  void set name(String name) => _staticInfo.callMethodOnReceiver('set_name', this, [name]);
  void set size(int size) => _staticInfo.callMethodOnReceiver('set_size', this, [size]);
  void set sortOrder(int sortOrder) => _staticInfo.callMethodOnReceiver('set_sort_order', this, [sortOrder]);
  void set symbolicIcon(Icon icon) => _staticInfo.callMethodOnReceiver('set_symbolic_icon', this, [icon]);
  void set symlinkTarget(String symlinkTarget) => _staticInfo.callMethodOnReceiver('set_symlink_target', this, [symlinkTarget]);
  void unsetAttributeMask() => _staticInfo.callMethodOnReceiver('unset_attribute_mask', this, []);
}

class FileInputStream extends InputStream with Seekable {
  FileInputStream.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'FileInputStream');

  FileInfo queryInfo(String attributes, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('query_info', this, [attributes, cancellable]);
  void queryInfoAsync(String attributes, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('query_info_async', this, [attributes, ioPriority, cancellable, callback]);
  FileInfo queryInfoFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('query_info_finish', this, [result]);
}

class FileMeasureFlags extends GEnumBase {
  const FileMeasureFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'FileMeasureFlags');

  static const FileMeasureFlags NONE = const FileMeasureFlags(0);
  bool get none => (index & 0) == 0;
  static const FileMeasureFlags REPORT_ANY_ERROR = const FileMeasureFlags(2);
  bool get reportAnyError => (index & 2) == 2;
  static const FileMeasureFlags APPARENT_SIZE = const FileMeasureFlags(4);
  bool get apparentSize => (index & 4) == 4;
  static const FileMeasureFlags NO_XDEV = const FileMeasureFlags(8);
  bool get noXdev => (index & 8) == 8;
  static _valueToString(int value) {
    switch(value) {
      case 2: return 'FileMeasureFlags.REPORT_ANY_ERROR';
      case 4: return 'FileMeasureFlags.APPARENT_SIZE';
      case 8: return 'FileMeasureFlags.NO_XDEV';
      default: return 'new FileMeasureFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'FileMeasureFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 8; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  FileMeasureFlags operator|(FileMeasureFlags other) =>
    new FileMeasureFlags(index | other.index);
  FileMeasureFlags operator&(FileMeasureFlags other) =>
    new FileMeasureFlags(index & other.index);
}

typedef void FileMeasureProgressCallback(bool reporting, int currentSize, int numDirs, int numFiles);
class FileMonitor extends GObjectObject {
  FileMonitor.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'FileMonitor');

  bool get cancelled => _staticInfo.getGPropertyOnReceiver('cancelled', this);
  static const String CANCELLED_PROPERTY = 'cancelled';
  int get rateLimit => _staticInfo.getGPropertyOnReceiver('rate-limit', this);
  static const String RATE_LIMIT_PROPERTY = 'rate-limit';
  bool cancel() => _staticInfo.callMethodOnReceiver('cancel', this, []);
  void emitEvent(File child, File otherFile, FileMonitorEvent eventType) => _staticInfo.callMethodOnReceiver('emit_event', this, [child, otherFile, eventType]);
  bool isCancelled() => _staticInfo.callMethodOnReceiver('is_cancelled', this, []);
  void set rateLimit(int limitMsecs) => _staticInfo.callMethodOnReceiver('set_rate_limit', this, [limitMsecs]);
  int _connectToChanged(bool after, void func(File file, File otherFile, FileMonitorEvent eventType)) => signalConnect('changed', func, after);
  Stream<FileMonitorChangedEvent> get onChanged {
    int signalId;
    StreamController<FileMonitorChangedEvent> controller;
    controller = new StreamController<FileMonitorChangedEvent>(
      onListen: () {
          signalId = _connectToChanged(false, (File file, File otherFile, FileMonitorEvent eventType) {
              var result = new FileMonitorChangedEvent(file, otherFile, eventType);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<FileMonitorChangedEvent> get afterChanged {
    int signalId;
    StreamController<FileMonitorChangedEvent> controller;
    controller = new StreamController<FileMonitorChangedEvent>(
      onListen: () {
          signalId = _connectToChanged(true, (File file, File otherFile, FileMonitorEvent eventType) {
              var result = new FileMonitorChangedEvent(file, otherFile, eventType);
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

class FileMonitorChangedEvent {
  final File file;
  final File otherFile;
  final FileMonitorEvent eventType;

  FileMonitorChangedEvent(this.file, this.otherFile, this.eventType);
}

class FileMonitorEvent extends GEnumBase {
  const FileMonitorEvent(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'FileMonitorEvent');

  static const FileMonitorEvent CHANGED = const FileMonitorEvent(0);
  static const FileMonitorEvent CHANGES_DONE_HINT = const FileMonitorEvent(1);
  static const FileMonitorEvent DELETED = const FileMonitorEvent(2);
  static const FileMonitorEvent CREATED = const FileMonitorEvent(3);
  static const FileMonitorEvent ATTRIBUTE_CHANGED = const FileMonitorEvent(4);
  static const FileMonitorEvent PRE_UNMOUNT = const FileMonitorEvent(5);
  static const FileMonitorEvent UNMOUNTED = const FileMonitorEvent(6);
  static const FileMonitorEvent MOVED = const FileMonitorEvent(7);
  static const FileMonitorEvent RENAMED = const FileMonitorEvent(8);
  static const FileMonitorEvent MOVED_IN = const FileMonitorEvent(9);
  static const FileMonitorEvent MOVED_OUT = const FileMonitorEvent(10);
  String toString() {
    switch(index) {
      case 0: return 'FileMonitorEvent.CHANGED';
      case 1: return 'FileMonitorEvent.CHANGES_DONE_HINT';
      case 2: return 'FileMonitorEvent.DELETED';
      case 3: return 'FileMonitorEvent.CREATED';
      case 4: return 'FileMonitorEvent.ATTRIBUTE_CHANGED';
      case 5: return 'FileMonitorEvent.PRE_UNMOUNT';
      case 6: return 'FileMonitorEvent.UNMOUNTED';
      case 7: return 'FileMonitorEvent.MOVED';
      case 8: return 'FileMonitorEvent.RENAMED';
      case 9: return 'FileMonitorEvent.MOVED_IN';
      case 10: return 'FileMonitorEvent.MOVED_OUT';
      default: return 'new FileMonitorEvent($index)';
    }
  }
}

class FileMonitorFlags extends GEnumBase {
  const FileMonitorFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'FileMonitorFlags');

  static const FileMonitorFlags NONE = const FileMonitorFlags(0);
  bool get none => (index & 0) == 0;
  static const FileMonitorFlags WATCH_MOUNTS = const FileMonitorFlags(1);
  bool get watchMounts => (index & 1) == 1;
  static const FileMonitorFlags SEND_MOVED = const FileMonitorFlags(2);
  bool get sendMoved => (index & 2) == 2;
  static const FileMonitorFlags WATCH_HARD_LINKS = const FileMonitorFlags(4);
  bool get watchHardLinks => (index & 4) == 4;
  static const FileMonitorFlags WATCH_MOVES = const FileMonitorFlags(8);
  bool get watchMoves => (index & 8) == 8;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'FileMonitorFlags.WATCH_MOUNTS';
      case 2: return 'FileMonitorFlags.SEND_MOVED';
      case 4: return 'FileMonitorFlags.WATCH_HARD_LINKS';
      case 8: return 'FileMonitorFlags.WATCH_MOVES';
      default: return 'new FileMonitorFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'FileMonitorFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 8; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  FileMonitorFlags operator|(FileMonitorFlags other) =>
    new FileMonitorFlags(index | other.index);
  FileMonitorFlags operator&(FileMonitorFlags other) =>
    new FileMonitorFlags(index & other.index);
}

class FileOutputStream extends OutputStream with Seekable {
  FileOutputStream.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'FileOutputStream');

  String get etag => _staticInfo.callMethodOnReceiver('get_etag', this, []);
  FileInfo queryInfo(String attributes, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('query_info', this, [attributes, cancellable]);
  void queryInfoAsync(String attributes, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('query_info_async', this, [attributes, ioPriority, cancellable, callback]);
  FileInfo queryInfoFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('query_info_finish', this, [result]);
}

typedef void FileProgressCallback(int currentNumBytes, int totalNumBytes);
class FileQueryInfoFlags extends GEnumBase {
  const FileQueryInfoFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'FileQueryInfoFlags');

  static const FileQueryInfoFlags NONE = const FileQueryInfoFlags(0);
  bool get none => (index & 0) == 0;
  static const FileQueryInfoFlags NOFOLLOW_SYMLINKS = const FileQueryInfoFlags(1);
  bool get nofollowSymlinks => (index & 1) == 1;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'FileQueryInfoFlags.NOFOLLOW_SYMLINKS';
      default: return 'new FileQueryInfoFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'FileQueryInfoFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 1; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  FileQueryInfoFlags operator|(FileQueryInfoFlags other) =>
    new FileQueryInfoFlags(index | other.index);
  FileQueryInfoFlags operator&(FileQueryInfoFlags other) =>
    new FileQueryInfoFlags(index & other.index);
}

typedef bool FileReadMoreCallback(String fileContents, int fileSize);
class FileType extends GEnumBase {
  const FileType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'FileType');

  static const FileType UNKNOWN = const FileType(0);
  static const FileType REGULAR = const FileType(1);
  static const FileType DIRECTORY = const FileType(2);
  static const FileType SYMBOLIC_LINK = const FileType(3);
  static const FileType SPECIAL = const FileType(4);
  static const FileType SHORTCUT = const FileType(5);
  static const FileType MOUNTABLE = const FileType(6);
  String toString() {
    switch(index) {
      case 0: return 'FileType.UNKNOWN';
      case 1: return 'FileType.REGULAR';
      case 2: return 'FileType.DIRECTORY';
      case 3: return 'FileType.SYMBOLIC_LINK';
      case 4: return 'FileType.SPECIAL';
      case 5: return 'FileType.SHORTCUT';
      case 6: return 'FileType.MOUNTABLE';
      default: return 'new FileType($index)';
    }
  }
}

class FilenameCompleter extends GObjectObject {
  FilenameCompleter.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'FilenameCompleter');

  factory FilenameCompleter() => _staticInfo.callStatic('new', []);
  String getCompletionSuffix(String initialText) => _staticInfo.callMethodOnReceiver('get_completion_suffix', this, [initialText]);
  List<String> getCompletions(String initialText) => _staticInfo.callMethodOnReceiver('get_completions', this, [initialText]);
  void setDirsOnly(bool dirsOnly) => _staticInfo.callMethodOnReceiver('set_dirs_only', this, [dirsOnly]);
  int _connectToGotCompletionData(bool after, void func()) => signalConnect('got-completion-data', func, after);
  Stream get onGotCompletionData {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToGotCompletionData(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterGotCompletionData {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToGotCompletionData(true, () {
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

class FilesystemPreviewType extends GEnumBase {
  const FilesystemPreviewType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'FilesystemPreviewType');

  static const FilesystemPreviewType IF_ALWAYS = const FilesystemPreviewType(0);
  static const FilesystemPreviewType IF_LOCAL = const FilesystemPreviewType(1);
  static const FilesystemPreviewType NEVER = const FilesystemPreviewType(2);
  String toString() {
    switch(index) {
      case 0: return 'FilesystemPreviewType.IF_ALWAYS';
      case 1: return 'FilesystemPreviewType.IF_LOCAL';
      case 2: return 'FilesystemPreviewType.NEVER';
      default: return 'new FilesystemPreviewType($index)';
    }
  }
}

class FilterInputStream extends InputStream {
  FilterInputStream.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'FilterInputStream');

  void set baseStream(InputStream value) => _staticInfo.setGPropertyOnReceiver('base-stream', this, value);
  static const String BASE_STREAM_PROPERTY = 'base-stream';
  static const String CLOSE_BASE_STREAM_PROPERTY = 'close-base-stream';
  InputStream get baseStream_ => _staticInfo.callMethodOnReceiver('get_base_stream', this, []);
  bool get closeBaseStream => _staticInfo.callMethodOnReceiver('get_close_base_stream', this, []);
  void set closeBaseStream(bool closeBase) => _staticInfo.callMethodOnReceiver('set_close_base_stream', this, [closeBase]);
}

class FilterOutputStream extends OutputStream {
  FilterOutputStream.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'FilterOutputStream');

  void set baseStream(OutputStream value) => _staticInfo.setGPropertyOnReceiver('base-stream', this, value);
  static const String BASE_STREAM_PROPERTY = 'base-stream';
  static const String CLOSE_BASE_STREAM_PROPERTY = 'close-base-stream';
  OutputStream get baseStream_ => _staticInfo.callMethodOnReceiver('get_base_stream', this, []);
  bool get closeBaseStream => _staticInfo.callMethodOnReceiver('get_close_base_stream', this, []);
  void set closeBaseStream(bool closeBase) => _staticInfo.callMethodOnReceiver('set_close_base_stream', this, [closeBase]);
}

class IOErrorEnumCode extends GEnumBase {
  const IOErrorEnumCode(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'IOErrorEnum');

  static const IOErrorEnumCode FAILED = const IOErrorEnumCode(0);
  static const IOErrorEnumCode NOT_FOUND = const IOErrorEnumCode(1);
  static const IOErrorEnumCode EXISTS = const IOErrorEnumCode(2);
  static const IOErrorEnumCode IS_DIRECTORY = const IOErrorEnumCode(3);
  static const IOErrorEnumCode NOT_DIRECTORY = const IOErrorEnumCode(4);
  static const IOErrorEnumCode NOT_EMPTY = const IOErrorEnumCode(5);
  static const IOErrorEnumCode NOT_REGULAR_FILE = const IOErrorEnumCode(6);
  static const IOErrorEnumCode NOT_SYMBOLIC_LINK = const IOErrorEnumCode(7);
  static const IOErrorEnumCode NOT_MOUNTABLE_FILE = const IOErrorEnumCode(8);
  static const IOErrorEnumCode FILENAME_TOO_LONG = const IOErrorEnumCode(9);
  static const IOErrorEnumCode INVALID_FILENAME = const IOErrorEnumCode(10);
  static const IOErrorEnumCode TOO_MANY_LINKS = const IOErrorEnumCode(11);
  static const IOErrorEnumCode NO_SPACE = const IOErrorEnumCode(12);
  static const IOErrorEnumCode INVALID_ARGUMENT = const IOErrorEnumCode(13);
  static const IOErrorEnumCode PERMISSION_DENIED = const IOErrorEnumCode(14);
  static const IOErrorEnumCode NOT_SUPPORTED = const IOErrorEnumCode(15);
  static const IOErrorEnumCode NOT_MOUNTED = const IOErrorEnumCode(16);
  static const IOErrorEnumCode ALREADY_MOUNTED = const IOErrorEnumCode(17);
  static const IOErrorEnumCode CLOSED = const IOErrorEnumCode(18);
  static const IOErrorEnumCode CANCELLED = const IOErrorEnumCode(19);
  static const IOErrorEnumCode PENDING = const IOErrorEnumCode(20);
  static const IOErrorEnumCode READ_ONLY = const IOErrorEnumCode(21);
  static const IOErrorEnumCode CANT_CREATE_BACKUP = const IOErrorEnumCode(22);
  static const IOErrorEnumCode WRONG_ETAG = const IOErrorEnumCode(23);
  static const IOErrorEnumCode TIMED_OUT = const IOErrorEnumCode(24);
  static const IOErrorEnumCode WOULD_RECURSE = const IOErrorEnumCode(25);
  static const IOErrorEnumCode BUSY = const IOErrorEnumCode(26);
  static const IOErrorEnumCode WOULD_BLOCK = const IOErrorEnumCode(27);
  static const IOErrorEnumCode HOST_NOT_FOUND = const IOErrorEnumCode(28);
  static const IOErrorEnumCode WOULD_MERGE = const IOErrorEnumCode(29);
  static const IOErrorEnumCode FAILED_HANDLED = const IOErrorEnumCode(30);
  static const IOErrorEnumCode TOO_MANY_OPEN_FILES = const IOErrorEnumCode(31);
  static const IOErrorEnumCode NOT_INITIALIZED = const IOErrorEnumCode(32);
  static const IOErrorEnumCode ADDRESS_IN_USE = const IOErrorEnumCode(33);
  static const IOErrorEnumCode PARTIAL_INPUT = const IOErrorEnumCode(34);
  static const IOErrorEnumCode INVALID_DATA = const IOErrorEnumCode(35);
  static const IOErrorEnumCode DBUS_ERROR = const IOErrorEnumCode(36);
  static const IOErrorEnumCode HOST_UNREACHABLE = const IOErrorEnumCode(37);
  static const IOErrorEnumCode NETWORK_UNREACHABLE = const IOErrorEnumCode(38);
  static const IOErrorEnumCode CONNECTION_REFUSED = const IOErrorEnumCode(39);
  static const IOErrorEnumCode PROXY_FAILED = const IOErrorEnumCode(40);
  static const IOErrorEnumCode PROXY_AUTH_FAILED = const IOErrorEnumCode(41);
  static const IOErrorEnumCode PROXY_NEED_AUTH = const IOErrorEnumCode(42);
  static const IOErrorEnumCode PROXY_NOT_ALLOWED = const IOErrorEnumCode(43);
  static const IOErrorEnumCode BROKEN_PIPE = const IOErrorEnumCode(44);
  static const IOErrorEnumCode CONNECTION_CLOSED = const IOErrorEnumCode(44);
  static const IOErrorEnumCode NOT_CONNECTED = const IOErrorEnumCode(45);
  String toString() {
    switch(index) {
      case 0: return 'IOErrorEnumCode.FAILED';
      case 1: return 'IOErrorEnumCode.NOT_FOUND';
      case 2: return 'IOErrorEnumCode.EXISTS';
      case 3: return 'IOErrorEnumCode.IS_DIRECTORY';
      case 4: return 'IOErrorEnumCode.NOT_DIRECTORY';
      case 5: return 'IOErrorEnumCode.NOT_EMPTY';
      case 6: return 'IOErrorEnumCode.NOT_REGULAR_FILE';
      case 7: return 'IOErrorEnumCode.NOT_SYMBOLIC_LINK';
      case 8: return 'IOErrorEnumCode.NOT_MOUNTABLE_FILE';
      case 9: return 'IOErrorEnumCode.FILENAME_TOO_LONG';
      case 10: return 'IOErrorEnumCode.INVALID_FILENAME';
      case 11: return 'IOErrorEnumCode.TOO_MANY_LINKS';
      case 12: return 'IOErrorEnumCode.NO_SPACE';
      case 13: return 'IOErrorEnumCode.INVALID_ARGUMENT';
      case 14: return 'IOErrorEnumCode.PERMISSION_DENIED';
      case 15: return 'IOErrorEnumCode.NOT_SUPPORTED';
      case 16: return 'IOErrorEnumCode.NOT_MOUNTED';
      case 17: return 'IOErrorEnumCode.ALREADY_MOUNTED';
      case 18: return 'IOErrorEnumCode.CLOSED';
      case 19: return 'IOErrorEnumCode.CANCELLED';
      case 20: return 'IOErrorEnumCode.PENDING';
      case 21: return 'IOErrorEnumCode.READ_ONLY';
      case 22: return 'IOErrorEnumCode.CANT_CREATE_BACKUP';
      case 23: return 'IOErrorEnumCode.WRONG_ETAG';
      case 24: return 'IOErrorEnumCode.TIMED_OUT';
      case 25: return 'IOErrorEnumCode.WOULD_RECURSE';
      case 26: return 'IOErrorEnumCode.BUSY';
      case 27: return 'IOErrorEnumCode.WOULD_BLOCK';
      case 28: return 'IOErrorEnumCode.HOST_NOT_FOUND';
      case 29: return 'IOErrorEnumCode.WOULD_MERGE';
      case 30: return 'IOErrorEnumCode.FAILED_HANDLED';
      case 31: return 'IOErrorEnumCode.TOO_MANY_OPEN_FILES';
      case 32: return 'IOErrorEnumCode.NOT_INITIALIZED';
      case 33: return 'IOErrorEnumCode.ADDRESS_IN_USE';
      case 34: return 'IOErrorEnumCode.PARTIAL_INPUT';
      case 35: return 'IOErrorEnumCode.INVALID_DATA';
      case 36: return 'IOErrorEnumCode.DBUS_ERROR';
      case 37: return 'IOErrorEnumCode.HOST_UNREACHABLE';
      case 38: return 'IOErrorEnumCode.NETWORK_UNREACHABLE';
      case 39: return 'IOErrorEnumCode.CONNECTION_REFUSED';
      case 40: return 'IOErrorEnumCode.PROXY_FAILED';
      case 41: return 'IOErrorEnumCode.PROXY_AUTH_FAILED';
      case 42: return 'IOErrorEnumCode.PROXY_NEED_AUTH';
      case 43: return 'IOErrorEnumCode.PROXY_NOT_ALLOWED';
      case 44: return 'IOErrorEnumCode.CONNECTION_CLOSED';
      case 45: return 'IOErrorEnumCode.NOT_CONNECTED';
      default: return 'new IOErrorEnumCode($index)';
    }
  }
}

class IOErrorEnum extends GErrorBase {
  static final int _quark = lookupErrorQuarkFromString('g-io-error-quark');
  IOErrorEnum(IOErrorEnumCode code, String message)
      : super.fromFields(_quark, code, message);
}

class IOExtension extends GObjectBase {
  IOExtension.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'IOExtension');

  String get name => _staticInfo.callMethodOnReceiver('get_name', this, []);
  int get priority => _staticInfo.callMethodOnReceiver('get_priority', this, []);
  int get type => _staticInfo.callMethodOnReceiver('get_type', this, []);
}

class IOExtensionPoint extends GObjectBase {
  IOExtensionPoint.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'IOExtensionPoint');

  IOExtension getExtensionByName(String name) => _staticInfo.callMethodOnReceiver('get_extension_by_name', this, [name]);
  GLibList /* this will fail */ get extensions => _staticInfo.callMethodOnReceiver('get_extensions', this, []);
  int get requiredType => _staticInfo.callMethodOnReceiver('get_required_type', this, []);
  void set requiredType(int type) => _staticInfo.callMethodOnReceiver('set_required_type', this, [type]);
  static IOExtension implement(String extensionPointName, int type, String extensionName, int priority) => _staticInfo.callStatic('implement', [extensionPointName, type, extensionName, priority]);
  static IOExtensionPoint lookup(String name) => _staticInfo.callStatic('lookup', [name]);
  static IOExtensionPoint register(String name) => _staticInfo.callStatic('register', [name]);
}

class IOModule extends TypeModule with TypePlugin {
  IOModule.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'IOModule');

  factory IOModule(String filename) => _staticInfo.callStatic('new', [filename]);
  static List<String> query() => _staticInfo.callStatic('query', []);
  void load() => _staticInfo.callMethodOnReceiver('load', this, []);
  void unload() => _staticInfo.callMethodOnReceiver('unload', this, []);
}

class IOModuleScope extends GObjectBase {
  IOModuleScope.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'IOModuleScope');

  void block(String basename) => _staticInfo.callMethodOnReceiver('block', this, [basename]);
  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
}

class IOModuleScopeFlags extends GEnumBase {
  const IOModuleScopeFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'IOModuleScopeFlags');

  static const IOModuleScopeFlags NONE = const IOModuleScopeFlags(0);
  static const IOModuleScopeFlags BLOCK_DUPLICATES = const IOModuleScopeFlags(1);
  String toString() {
    switch(index) {
      case 0: return 'IOModuleScopeFlags.NONE';
      case 1: return 'IOModuleScopeFlags.BLOCK_DUPLICATES';
      default: return 'new IOModuleScopeFlags($index)';
    }
  }
}

class IOSchedulerJob extends GObjectBase {
  IOSchedulerJob.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'IOSchedulerJob');

  bool sendToMainloop(SourceFunc func) => _staticInfo.callMethodOnReceiver('send_to_mainloop', this, [func]);
  void sendToMainloopAsync(SourceFunc func) => _staticInfo.callMethodOnReceiver('send_to_mainloop_async', this, [func]);
}

typedef bool IOSchedulerJobFunc(IOSchedulerJob job, Cancellable cancellable);
class IOStream extends GObjectObject {
  IOStream.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'IOStream');

  bool get closed => _staticInfo.getGPropertyOnReceiver('closed', this);
  static const String CLOSED_PROPERTY = 'closed';
  static const String INPUT_STREAM_PROPERTY = 'input-stream';
  static const String OUTPUT_STREAM_PROPERTY = 'output-stream';
  static void spliceFinish(AsyncResult result) => _staticInfo.callStatic('splice_finish', [result]);
  void clearPending() => _staticInfo.callMethodOnReceiver('clear_pending', this, []);
  void close(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('close', this, [cancellable]);
  void closeAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('close_async', this, [ioPriority, cancellable, callback]);
  void closeFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('close_finish', this, [result]);
  InputStream get inputStream => _staticInfo.callMethodOnReceiver('get_input_stream', this, []);
  OutputStream get outputStream => _staticInfo.callMethodOnReceiver('get_output_stream', this, []);
  bool hasPending() => _staticInfo.callMethodOnReceiver('has_pending', this, []);
  bool isClosed() => _staticInfo.callMethodOnReceiver('is_closed', this, []);
  void setPending() => _staticInfo.callMethodOnReceiver('set_pending', this, []);
  void spliceAsync(IOStream stream2, IOStreamSpliceFlags flags, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('splice_async', this, [stream2, flags, ioPriority, cancellable, callback]);
}

class IOStreamAdapter extends GObjectBase {
  IOStreamAdapter.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'IOStreamAdapter');

}

class IOStreamSpliceFlags extends GEnumBase {
  const IOStreamSpliceFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'IOStreamSpliceFlags');

  static const IOStreamSpliceFlags NONE = const IOStreamSpliceFlags(0);
  bool get none => (index & 0) == 0;
  static const IOStreamSpliceFlags CLOSE_STREAM1 = const IOStreamSpliceFlags(1);
  bool get closeStream1 => (index & 1) == 1;
  static const IOStreamSpliceFlags CLOSE_STREAM2 = const IOStreamSpliceFlags(2);
  bool get closeStream2 => (index & 2) == 2;
  static const IOStreamSpliceFlags WAIT_FOR_BOTH = const IOStreamSpliceFlags(4);
  bool get waitForBoth => (index & 4) == 4;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'IOStreamSpliceFlags.CLOSE_STREAM1';
      case 2: return 'IOStreamSpliceFlags.CLOSE_STREAM2';
      case 4: return 'IOStreamSpliceFlags.WAIT_FOR_BOTH';
      default: return 'new IOStreamSpliceFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'IOStreamSpliceFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 4; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  IOStreamSpliceFlags operator|(IOStreamSpliceFlags other) =>
    new IOStreamSpliceFlags(index | other.index);
  IOStreamSpliceFlags operator&(IOStreamSpliceFlags other) =>
    new IOStreamSpliceFlags(index & other.index);
}

abstract class Icon extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'Icon');



  static Icon deserialize(Variant value) => _staticInfo.callStatic('deserialize', [value]);
  static int hash(dynamic icon /* this will fail */) => _staticInfo.callStatic('hash', [icon]);
  static Icon newForString(String str) => _staticInfo.callStatic('new_for_string', [str]);
  bool equal(Icon icon2) => _staticInfo.callMethodOnReceiver('equal', this, [icon2]);
  Variant serialize() => _staticInfo.callMethodOnReceiver('serialize', this, []);
  String toString() => _staticInfo.callMethodOnReceiver('to_string', this, []);
}

class InetAddress extends GObjectObject {
  InetAddress.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'InetAddress');

  dynamic /* this will fail */ get bytes => _staticInfo.getGPropertyOnReceiver('bytes', this);
  void set bytes(dynamic value /* this will fail */) => _staticInfo.setGPropertyOnReceiver('bytes', this, value);
  static const String BYTES_PROPERTY = 'bytes';
  void set family(SocketFamily value) => _staticInfo.setGPropertyOnReceiver('family', this, value);
  static const String FAMILY_PROPERTY = 'family';
  static const String IS_ANY_PROPERTY = 'is-any';
  static const String IS_LINK_LOCAL_PROPERTY = 'is-link-local';
  static const String IS_LOOPBACK_PROPERTY = 'is-loopback';
  static const String IS_MC_GLOBAL_PROPERTY = 'is-mc-global';
  static const String IS_MC_LINK_LOCAL_PROPERTY = 'is-mc-link-local';
  static const String IS_MC_NODE_LOCAL_PROPERTY = 'is-mc-node-local';
  static const String IS_MC_ORG_LOCAL_PROPERTY = 'is-mc-org-local';
  static const String IS_MC_SITE_LOCAL_PROPERTY = 'is-mc-site-local';
  static const String IS_MULTICAST_PROPERTY = 'is-multicast';
  static const String IS_SITE_LOCAL_PROPERTY = 'is-site-local';
  factory InetAddress.any(SocketFamily family) => _staticInfo.callStatic('new_any', [family]);
  factory InetAddress.fromBytes(List<int> bytes, SocketFamily family) => _staticInfo.callStatic('new_from_bytes', [bytes, family]);
  factory InetAddress.fromString(String string) => _staticInfo.callStatic('new_from_string', [string]);
  factory InetAddress.loopback(SocketFamily family) => _staticInfo.callStatic('new_loopback', [family]);
  bool equal(InetAddress otherAddress) => _staticInfo.callMethodOnReceiver('equal', this, [otherAddress]);
  SocketFamily get family_ => _staticInfo.callMethodOnReceiver('get_family', this, []);
  bool get isAny => _staticInfo.callMethodOnReceiver('get_is_any', this, []);
  bool get isLinkLocal => _staticInfo.callMethodOnReceiver('get_is_link_local', this, []);
  bool get isLoopback => _staticInfo.callMethodOnReceiver('get_is_loopback', this, []);
  bool get isMcGlobal => _staticInfo.callMethodOnReceiver('get_is_mc_global', this, []);
  bool get isMcLinkLocal => _staticInfo.callMethodOnReceiver('get_is_mc_link_local', this, []);
  bool get isMcNodeLocal => _staticInfo.callMethodOnReceiver('get_is_mc_node_local', this, []);
  bool get isMcOrgLocal => _staticInfo.callMethodOnReceiver('get_is_mc_org_local', this, []);
  bool get isMcSiteLocal => _staticInfo.callMethodOnReceiver('get_is_mc_site_local', this, []);
  bool get isMulticast => _staticInfo.callMethodOnReceiver('get_is_multicast', this, []);
  bool get isSiteLocal => _staticInfo.callMethodOnReceiver('get_is_site_local', this, []);
  int get nativeSize => _staticInfo.callMethodOnReceiver('get_native_size', this, []);
  String toString() => _staticInfo.callMethodOnReceiver('to_string', this, []);
}

class InetAddressMask extends GObjectObject with Initable {
  InetAddressMask.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'InetAddressMask');

  void set address(InetAddress value) => _staticInfo.setGPropertyOnReceiver('address', this, value);
  static const String ADDRESS_PROPERTY = 'address';
  static const String FAMILY_PROPERTY = 'family';
  void set length(int value) => _staticInfo.setGPropertyOnReceiver('length', this, value);
  static const String LENGTH_PROPERTY = 'length';
  factory InetAddressMask(InetAddress addr, int length) => _staticInfo.callStatic('new', [addr, length]);
  factory InetAddressMask.fromString(String maskString) => _staticInfo.callStatic('new_from_string', [maskString]);
  bool equal(InetAddressMask mask2) => _staticInfo.callMethodOnReceiver('equal', this, [mask2]);
  InetAddress get address_ => _staticInfo.callMethodOnReceiver('get_address', this, []);
  SocketFamily get family => _staticInfo.callMethodOnReceiver('get_family', this, []);
  int get length_ => _staticInfo.callMethodOnReceiver('get_length', this, []);
  bool matches(InetAddress address) => _staticInfo.callMethodOnReceiver('matches', this, [address]);
  String toString() => _staticInfo.callMethodOnReceiver('to_string', this, []);
}

class InetSocketAddress extends SocketAddress with SocketConnectable {
  InetSocketAddress.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'InetSocketAddress');

  void set address(InetAddress value) => _staticInfo.setGPropertyOnReceiver('address', this, value);
  static const String ADDRESS_PROPERTY = 'address';
  void set flowinfo(int value) => _staticInfo.setGPropertyOnReceiver('flowinfo', this, value);
  static const String FLOWINFO_PROPERTY = 'flowinfo';
  void set port(int value) => _staticInfo.setGPropertyOnReceiver('port', this, value);
  static const String PORT_PROPERTY = 'port';
  void set scopeId(int value) => _staticInfo.setGPropertyOnReceiver('scope-id', this, value);
  static const String SCOPE_ID_PROPERTY = 'scope-id';
  factory InetSocketAddress(InetAddress address, int port) => _staticInfo.callStatic('new', [address, port]);
  factory InetSocketAddress.fromString(String address, int port) => _staticInfo.callStatic('new_from_string', [address, port]);
  InetAddress get address_ => _staticInfo.callMethodOnReceiver('get_address', this, []);
  int get flowinfo_ => _staticInfo.callMethodOnReceiver('get_flowinfo', this, []);
  int get port_ => _staticInfo.callMethodOnReceiver('get_port', this, []);
  int get scopeId_ => _staticInfo.callMethodOnReceiver('get_scope_id', this, []);
}

abstract class Initable extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'Initable');



  static GObjectObject newv(int objectType, List<Parameter> parameters, Cancellable cancellable) => _staticInfo.callStatic('newv', [objectType, parameters, cancellable]);
  void init(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('init', this, [cancellable]);
}

class InputStream extends GObjectObject {
  InputStream.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'InputStream');

  void clearPending() => _staticInfo.callMethodOnReceiver('clear_pending', this, []);
  void close(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('close', this, [cancellable]);
  void closeAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('close_async', this, [ioPriority, cancellable, callback]);
  void closeFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('close_finish', this, [result]);
  bool hasPending() => _staticInfo.callMethodOnReceiver('has_pending', this, []);
  bool isClosed() => _staticInfo.callMethodOnReceiver('is_closed', this, []);
  int read(List<int> buffer, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('read', this, [buffer, cancellable]);
  int readAll(List<int> buffer, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('read_all', this, [buffer, cancellable]);
  void readAllAsync(List<int> buffer, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('read_all_async', this, [buffer, ioPriority, cancellable, callback]);
  int readAllFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('read_all_finish', this, [result]);
  void readAsync(List<int> buffer, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('read_async', this, [buffer, ioPriority, cancellable, callback]);
  Bytes readBytes(int count, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('read_bytes', this, [count, cancellable]);
  void readBytesAsync(int count, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('read_bytes_async', this, [count, ioPriority, cancellable, callback]);
  Bytes readBytesFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('read_bytes_finish', this, [result]);
  int readFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('read_finish', this, [result]);
  void setPending() => _staticInfo.callMethodOnReceiver('set_pending', this, []);
  int skip(int count, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('skip', this, [count, cancellable]);
  void skipAsync(int count, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('skip_async', this, [count, ioPriority, cancellable, callback]);
  int skipFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('skip_finish', this, [result]);
}

class InputVector extends GObjectBase {
  InputVector.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'InputVector');

  dynamic /* this will fail */ get buffer => getFieldOfObject('buffer', 0);
  void set buffer(dynamic value /* this will fail */) => setFieldOfObject('buffer', 0, value);
  int get size => getFieldOfObject('size', 1);
  void set size(int value) => setFieldOfObject('size', 1, value);
}

abstract class ListModel extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'ListModel');



  int get itemType => _staticInfo.callMethodOnReceiver('get_item_type', this, []);
  int get nItems => _staticInfo.callMethodOnReceiver('get_n_items', this, []);
  GObjectObject getItem(int position) => _staticInfo.callMethodOnReceiver('get_item', this, [position]);
  void itemsChanged(int position, int removed, int added) => _staticInfo.callMethodOnReceiver('items_changed', this, [position, removed, added]);
  int _connectToItemsChanged(bool after, void func(int position, int removed, int added)) => signalConnect('items-changed', func, after);
  Stream<ListModelItemsChangedEvent> get onItemsChanged {
    int signalId;
    StreamController<ListModelItemsChangedEvent> controller;
    controller = new StreamController<ListModelItemsChangedEvent>(
      onListen: () {
          signalId = _connectToItemsChanged(false, (int position, int removed, int added) {
              var result = new ListModelItemsChangedEvent(position, removed, added);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<ListModelItemsChangedEvent> get afterItemsChanged {
    int signalId;
    StreamController<ListModelItemsChangedEvent> controller;
    controller = new StreamController<ListModelItemsChangedEvent>(
      onListen: () {
          signalId = _connectToItemsChanged(true, (int position, int removed, int added) {
              var result = new ListModelItemsChangedEvent(position, removed, added);
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

class ListModelItemsChangedEvent {
  final int position;
  final int removed;
  final int added;

  ListModelItemsChangedEvent(this.position, this.removed, this.added);
}

class ListStore extends GObjectObject with ListModel {
  ListStore.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'ListStore');

  int get itemType => _staticInfo.getGPropertyOnReceiver('item-type', this);
  void set itemType(int value) => _staticInfo.setGPropertyOnReceiver('item-type', this, value);
  static const String ITEM_TYPE_PROPERTY = 'item-type';
  factory ListStore(int itemType) => _staticInfo.callStatic('new', [itemType]);
  void append(GObjectObject item) => _staticInfo.callMethodOnReceiver('append', this, [item]);
  void insert(int position, GObjectObject item) => _staticInfo.callMethodOnReceiver('insert', this, [position, item]);
  int insertSorted(GObjectObject item, CompareDataFunc compareFunc) => _staticInfo.callMethodOnReceiver('insert_sorted', this, [item, compareFunc]);
  void remove(int position) => _staticInfo.callMethodOnReceiver('remove', this, [position]);
  void removeAll() => _staticInfo.callMethodOnReceiver('remove_all', this, []);
  void sort(CompareDataFunc compareFunc) => _staticInfo.callMethodOnReceiver('sort', this, [compareFunc]);
  void splice(int position, int nRemovals, List<GObjectObject> additions) => _staticInfo.callMethodOnReceiver('splice', this, [position, nRemovals, additions]);
}

abstract class LoadableIcon extends GObjectBase implements Icon {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'LoadableIcon');



  List load(int size, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('load', this, [size, cancellable]);
  void loadAsync(int size, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('load_async', this, [size, cancellable, callback]);
  List loadFinish(AsyncResult res) => _staticInfo.callMethodOnReceiver('load_finish', this, [res]);
}

class MemoryInputStream extends InputStream with PollableInputStream, Seekable {
  MemoryInputStream.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'MemoryInputStream');

  factory MemoryInputStream() => _staticInfo.callStatic('new', []);
  factory MemoryInputStream.fromBytes(Bytes bytes) => _staticInfo.callStatic('new_from_bytes', [bytes]);
  factory MemoryInputStream.fromData(List<int> data, DestroyNotify destroy) => _staticInfo.callStatic('new_from_data', [data, destroy]);
  void addBytes(Bytes bytes) => _staticInfo.callMethodOnReceiver('add_bytes', this, [bytes]);
  void addData(List<int> data, DestroyNotify destroy) => _staticInfo.callMethodOnReceiver('add_data', this, [data, destroy]);
}

class MemoryOutputStream extends OutputStream with PollableOutputStream, Seekable {
  MemoryOutputStream.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'MemoryOutputStream');

  void set data(dynamic value /* this will fail */) => _staticInfo.setGPropertyOnReceiver('data', this, value);
  static const String DATA_PROPERTY = 'data';
  static const String DATA_SIZE_PROPERTY = 'data-size';
  void set size(int value) => _staticInfo.setGPropertyOnReceiver('size', this, value);
  static const String SIZE_PROPERTY = 'size';
  factory MemoryOutputStream.resizable() => _staticInfo.callStatic('new_resizable', []);
  void memoryOutputStreamGetData() => _staticInfo.callMethodOnReceiver('get_data', this, []);
  int get dataSize => _staticInfo.callMethodOnReceiver('get_data_size', this, []);
  int get size_ => _staticInfo.callMethodOnReceiver('get_size', this, []);
  Bytes stealAsBytes() => _staticInfo.callMethodOnReceiver('steal_as_bytes', this, []);
  void memoryOutputStreamStealData() => _staticInfo.callMethodOnReceiver('steal_data', this, []);
}

class Menu extends MenuModel {
  Menu.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'Menu');

  factory Menu() => _staticInfo.callStatic('new', []);
  void append(String label, String detailedAction) => _staticInfo.callMethodOnReceiver('append', this, [label, detailedAction]);
  void appendItem(MenuItem item) => _staticInfo.callMethodOnReceiver('append_item', this, [item]);
  void appendSection(String label, MenuModel section) => _staticInfo.callMethodOnReceiver('append_section', this, [label, section]);
  void appendSubmenu(String label, MenuModel submenu) => _staticInfo.callMethodOnReceiver('append_submenu', this, [label, submenu]);
  void freeze() => _staticInfo.callMethodOnReceiver('freeze', this, []);
  void insert(int position, String label, String detailedAction) => _staticInfo.callMethodOnReceiver('insert', this, [position, label, detailedAction]);
  void insertItem(int position, MenuItem item) => _staticInfo.callMethodOnReceiver('insert_item', this, [position, item]);
  void insertSection(int position, String label, MenuModel section) => _staticInfo.callMethodOnReceiver('insert_section', this, [position, label, section]);
  void insertSubmenu(int position, String label, MenuModel submenu) => _staticInfo.callMethodOnReceiver('insert_submenu', this, [position, label, submenu]);
  void prepend(String label, String detailedAction) => _staticInfo.callMethodOnReceiver('prepend', this, [label, detailedAction]);
  void prependItem(MenuItem item) => _staticInfo.callMethodOnReceiver('prepend_item', this, [item]);
  void prependSection(String label, MenuModel section) => _staticInfo.callMethodOnReceiver('prepend_section', this, [label, section]);
  void prependSubmenu(String label, MenuModel submenu) => _staticInfo.callMethodOnReceiver('prepend_submenu', this, [label, submenu]);
  void remove(int position) => _staticInfo.callMethodOnReceiver('remove', this, [position]);
  void removeAll() => _staticInfo.callMethodOnReceiver('remove_all', this, []);
}

class MenuAttributeIter extends GObjectObject {
  MenuAttributeIter.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'MenuAttributeIter');

  String get name => _staticInfo.callMethodOnReceiver('get_name', this, []);
  List getNext() => _staticInfo.callMethodOnReceiver('get_next', this, []);
  Variant get value => _staticInfo.callMethodOnReceiver('get_value', this, []);
  bool next() => _staticInfo.callMethodOnReceiver('next', this, []);
}

class MenuItem extends GObjectObject {
  MenuItem.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'MenuItem');

  factory MenuItem(String label, String detailedAction) => _staticInfo.callStatic('new', [label, detailedAction]);
  factory MenuItem.fromModel(MenuModel model, int itemIndex) => _staticInfo.callStatic('new_from_model', [model, itemIndex]);
  factory MenuItem.section(String label, MenuModel section) => _staticInfo.callStatic('new_section', [label, section]);
  factory MenuItem.submenu(String label, MenuModel submenu) => _staticInfo.callStatic('new_submenu', [label, submenu]);
  Variant getAttributeValue(String attribute, VariantType expectedType) => _staticInfo.callMethodOnReceiver('get_attribute_value', this, [attribute, expectedType]);
  MenuModel getLink(String link) => _staticInfo.callMethodOnReceiver('get_link', this, [link]);
  void setActionAndTargetValue(String action, Variant targetValue) => _staticInfo.callMethodOnReceiver('set_action_and_target_value', this, [action, targetValue]);
  void setAttributeValue(String attribute, Variant value) => _staticInfo.callMethodOnReceiver('set_attribute_value', this, [attribute, value]);
  void setDetailedAction(String detailedAction) => _staticInfo.callMethodOnReceiver('set_detailed_action', this, [detailedAction]);
  void setIcon(Icon icon) => _staticInfo.callMethodOnReceiver('set_icon', this, [icon]);
  void setLabel(String label) => _staticInfo.callMethodOnReceiver('set_label', this, [label]);
  void setLink(String link, MenuModel model) => _staticInfo.callMethodOnReceiver('set_link', this, [link, model]);
  void setSection(MenuModel section) => _staticInfo.callMethodOnReceiver('set_section', this, [section]);
  void setSubmenu(MenuModel submenu) => _staticInfo.callMethodOnReceiver('set_submenu', this, [submenu]);
}

class MenuLinkIter extends GObjectObject {
  MenuLinkIter.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'MenuLinkIter');

  String get name => _staticInfo.callMethodOnReceiver('get_name', this, []);
  List getNext() => _staticInfo.callMethodOnReceiver('get_next', this, []);
  MenuModel get value => _staticInfo.callMethodOnReceiver('get_value', this, []);
  bool next() => _staticInfo.callMethodOnReceiver('next', this, []);
}

class MenuModel extends GObjectObject {
  MenuModel.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'MenuModel');

  Variant getItemAttributeValue(int itemIndex, String attribute, VariantType expectedType) => _staticInfo.callMethodOnReceiver('get_item_attribute_value', this, [itemIndex, attribute, expectedType]);
  MenuModel getItemLink(int itemIndex, String link) => _staticInfo.callMethodOnReceiver('get_item_link', this, [itemIndex, link]);
  int get nItems => _staticInfo.callMethodOnReceiver('get_n_items', this, []);
  bool isMutable() => _staticInfo.callMethodOnReceiver('is_mutable', this, []);
  void itemsChanged(int position, int removed, int added) => _staticInfo.callMethodOnReceiver('items_changed', this, [position, removed, added]);
  MenuAttributeIter iterateItemAttributes(int itemIndex) => _staticInfo.callMethodOnReceiver('iterate_item_attributes', this, [itemIndex]);
  MenuLinkIter iterateItemLinks(int itemIndex) => _staticInfo.callMethodOnReceiver('iterate_item_links', this, [itemIndex]);
  int _connectToItemsChanged(bool after, void func(int position, int removed, int added)) => signalConnect('items-changed', func, after);
  Stream<MenuModelItemsChangedEvent> get onItemsChanged {
    int signalId;
    StreamController<MenuModelItemsChangedEvent> controller;
    controller = new StreamController<MenuModelItemsChangedEvent>(
      onListen: () {
          signalId = _connectToItemsChanged(false, (int position, int removed, int added) {
              var result = new MenuModelItemsChangedEvent(position, removed, added);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<MenuModelItemsChangedEvent> get afterItemsChanged {
    int signalId;
    StreamController<MenuModelItemsChangedEvent> controller;
    controller = new StreamController<MenuModelItemsChangedEvent>(
      onListen: () {
          signalId = _connectToItemsChanged(true, (int position, int removed, int added) {
              var result = new MenuModelItemsChangedEvent(position, removed, added);
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

class MenuModelItemsChangedEvent {
  final int position;
  final int removed;
  final int added;

  MenuModelItemsChangedEvent(this.position, this.removed, this.added);
}

abstract class Mount extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'Mount');



  bool canEject() => _staticInfo.callMethodOnReceiver('can_eject', this, []);
  bool canUnmount() => _staticInfo.callMethodOnReceiver('can_unmount', this, []);
  void eject(MountUnmountFlags flags, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('eject', this, [flags, cancellable, callback]);
  void ejectFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('eject_finish', this, [result]);
  void ejectWithOperation(MountUnmountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('eject_with_operation', this, [flags, mountOperation, cancellable, callback]);
  void ejectWithOperationFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('eject_with_operation_finish', this, [result]);
  File get defaultLocation => _staticInfo.callMethodOnReceiver('get_default_location', this, []);
  Drive get drive => _staticInfo.callMethodOnReceiver('get_drive', this, []);
  Icon get icon => _staticInfo.callMethodOnReceiver('get_icon', this, []);
  String get name => _staticInfo.callMethodOnReceiver('get_name', this, []);
  File get root => _staticInfo.callMethodOnReceiver('get_root', this, []);
  String get sortKey => _staticInfo.callMethodOnReceiver('get_sort_key', this, []);
  Icon get symbolicIcon => _staticInfo.callMethodOnReceiver('get_symbolic_icon', this, []);
  String get uuid => _staticInfo.callMethodOnReceiver('get_uuid', this, []);
  Volume get volume => _staticInfo.callMethodOnReceiver('get_volume', this, []);
  void guessContentType(bool forceRescan, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('guess_content_type', this, [forceRescan, cancellable, callback]);
  List<String> guessContentTypeFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('guess_content_type_finish', this, [result]);
  List<String> guessContentTypeSync(bool forceRescan, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('guess_content_type_sync', this, [forceRescan, cancellable]);
  bool isShadowed() => _staticInfo.callMethodOnReceiver('is_shadowed', this, []);
  void remount(MountMountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('remount', this, [flags, mountOperation, cancellable, callback]);
  void remountFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('remount_finish', this, [result]);
  void shadow() => _staticInfo.callMethodOnReceiver('shadow', this, []);
  void unmount(MountUnmountFlags flags, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('unmount', this, [flags, cancellable, callback]);
  void unmountFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('unmount_finish', this, [result]);
  void unmountWithOperation(MountUnmountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('unmount_with_operation', this, [flags, mountOperation, cancellable, callback]);
  void unmountWithOperationFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('unmount_with_operation_finish', this, [result]);
  void unshadow() => _staticInfo.callMethodOnReceiver('unshadow', this, []);
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
  int _connectToPreUnmount(bool after, void func()) => signalConnect('pre-unmount', func, after);
  Stream get onPreUnmount {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToPreUnmount(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterPreUnmount {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToPreUnmount(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToUnmounted(bool after, void func()) => signalConnect('unmounted', func, after);
  Stream get onUnmounted {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToUnmounted(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterUnmounted {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToUnmounted(true, () {
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

class MountMountFlags extends GEnumBase {
  const MountMountFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'MountMountFlags');

  static const MountMountFlags NONE = const MountMountFlags(0);
  bool get none => (index & 0) == 0;
  static _valueToString(int value) {
    switch(value) {
      default: return 'new MountMountFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'MountMountFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 0; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  MountMountFlags operator|(MountMountFlags other) =>
    new MountMountFlags(index | other.index);
  MountMountFlags operator&(MountMountFlags other) =>
    new MountMountFlags(index & other.index);
}

class MountOperation extends GObjectObject {
  MountOperation.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'MountOperation');

  static const String ANONYMOUS_PROPERTY = 'anonymous';
  static const String CHOICE_PROPERTY = 'choice';
  static const String DOMAIN_PROPERTY = 'domain';
  static const String PASSWORD_PROPERTY = 'password';
  static const String PASSWORD_SAVE_PROPERTY = 'password-save';
  static const String USERNAME_PROPERTY = 'username';
  factory MountOperation() => _staticInfo.callStatic('new', []);
  bool get anonymous => _staticInfo.callMethodOnReceiver('get_anonymous', this, []);
  int get choice => _staticInfo.callMethodOnReceiver('get_choice', this, []);
  String get domain => _staticInfo.callMethodOnReceiver('get_domain', this, []);
  String get password => _staticInfo.callMethodOnReceiver('get_password', this, []);
  PasswordSave get passwordSave => _staticInfo.callMethodOnReceiver('get_password_save', this, []);
  String get username => _staticInfo.callMethodOnReceiver('get_username', this, []);
  void reply(MountOperationResult result) => _staticInfo.callMethodOnReceiver('reply', this, [result]);
  void set anonymous(bool anonymous) => _staticInfo.callMethodOnReceiver('set_anonymous', this, [anonymous]);
  void set choice(int choice) => _staticInfo.callMethodOnReceiver('set_choice', this, [choice]);
  void set domain(String domain) => _staticInfo.callMethodOnReceiver('set_domain', this, [domain]);
  void set password(String password) => _staticInfo.callMethodOnReceiver('set_password', this, [password]);
  void set passwordSave(PasswordSave save) => _staticInfo.callMethodOnReceiver('set_password_save', this, [save]);
  void set username(String username) => _staticInfo.callMethodOnReceiver('set_username', this, [username]);
  int _connectToAborted(bool after, void func()) => signalConnect('aborted', func, after);
  Stream get onAborted {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToAborted(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterAborted {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToAborted(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToAskPassword(bool after, void func(String message, String defaultUser, String defaultDomain, AskPasswordFlags flags)) => signalConnect('ask-password', func, after);
  Stream<MountOperationAskPasswordEvent> get onAskPassword {
    int signalId;
    StreamController<MountOperationAskPasswordEvent> controller;
    controller = new StreamController<MountOperationAskPasswordEvent>(
      onListen: () {
          signalId = _connectToAskPassword(false, (String message, String defaultUser, String defaultDomain, AskPasswordFlags flags) {
              var result = new MountOperationAskPasswordEvent(message, defaultUser, defaultDomain, flags);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<MountOperationAskPasswordEvent> get afterAskPassword {
    int signalId;
    StreamController<MountOperationAskPasswordEvent> controller;
    controller = new StreamController<MountOperationAskPasswordEvent>(
      onListen: () {
          signalId = _connectToAskPassword(true, (String message, String defaultUser, String defaultDomain, AskPasswordFlags flags) {
              var result = new MountOperationAskPasswordEvent(message, defaultUser, defaultDomain, flags);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToAskQuestion(bool after, void func(String message, List<String> choices)) => signalConnect('ask-question', func, after);
  Stream<MountOperationAskQuestionEvent> get onAskQuestion {
    int signalId;
    StreamController<MountOperationAskQuestionEvent> controller;
    controller = new StreamController<MountOperationAskQuestionEvent>(
      onListen: () {
          signalId = _connectToAskQuestion(false, (String message, List<String> choices) {
              var result = new MountOperationAskQuestionEvent(message, choices);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<MountOperationAskQuestionEvent> get afterAskQuestion {
    int signalId;
    StreamController<MountOperationAskQuestionEvent> controller;
    controller = new StreamController<MountOperationAskQuestionEvent>(
      onListen: () {
          signalId = _connectToAskQuestion(true, (String message, List<String> choices) {
              var result = new MountOperationAskQuestionEvent(message, choices);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToReply(bool after, void func(MountOperationResult result_)) => signalConnect('reply', func, after);
  Stream<MountOperationResult> get onReply {
    int signalId;
    StreamController<MountOperationResult> controller;
    controller = new StreamController<MountOperationResult>(
      onListen: () {
          signalId = _connectToReply(false, (MountOperationResult result_) {
              controller.add(result_);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<MountOperationResult> get afterReply {
    int signalId;
    StreamController<MountOperationResult> controller;
    controller = new StreamController<MountOperationResult>(
      onListen: () {
          signalId = _connectToReply(true, (MountOperationResult result_) {
              controller.add(result_);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToShowProcesses(bool after, void func(String message, List<int> processes, List<String> choices)) => signalConnect('show-processes', func, after);
  Stream<MountOperationShowProcessesEvent> get onShowProcesses {
    int signalId;
    StreamController<MountOperationShowProcessesEvent> controller;
    controller = new StreamController<MountOperationShowProcessesEvent>(
      onListen: () {
          signalId = _connectToShowProcesses(false, (String message, List<int> processes, List<String> choices) {
              var result = new MountOperationShowProcessesEvent(message, processes, choices);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<MountOperationShowProcessesEvent> get afterShowProcesses {
    int signalId;
    StreamController<MountOperationShowProcessesEvent> controller;
    controller = new StreamController<MountOperationShowProcessesEvent>(
      onListen: () {
          signalId = _connectToShowProcesses(true, (String message, List<int> processes, List<String> choices) {
              var result = new MountOperationShowProcessesEvent(message, processes, choices);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToShowUnmountProgress(bool after, void func(String message, int timeLeft, int bytesLeft)) => signalConnect('show-unmount-progress', func, after);
  Stream<MountOperationShowUnmountProgressEvent> get onShowUnmountProgress {
    int signalId;
    StreamController<MountOperationShowUnmountProgressEvent> controller;
    controller = new StreamController<MountOperationShowUnmountProgressEvent>(
      onListen: () {
          signalId = _connectToShowUnmountProgress(false, (String message, int timeLeft, int bytesLeft) {
              var result = new MountOperationShowUnmountProgressEvent(message, timeLeft, bytesLeft);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<MountOperationShowUnmountProgressEvent> get afterShowUnmountProgress {
    int signalId;
    StreamController<MountOperationShowUnmountProgressEvent> controller;
    controller = new StreamController<MountOperationShowUnmountProgressEvent>(
      onListen: () {
          signalId = _connectToShowUnmountProgress(true, (String message, int timeLeft, int bytesLeft) {
              var result = new MountOperationShowUnmountProgressEvent(message, timeLeft, bytesLeft);
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

class MountOperationAskPasswordEvent {
  final String message;
  final String defaultUser;
  final String defaultDomain;
  final AskPasswordFlags flags;

  MountOperationAskPasswordEvent(this.message, this.defaultUser, this.defaultDomain, this.flags);
}

class MountOperationAskQuestionEvent {
  final String message;
  final List<String> choices;

  MountOperationAskQuestionEvent(this.message, this.choices);
}

class MountOperationShowProcessesEvent {
  final String message;
  final List<int> processes;
  final List<String> choices;

  MountOperationShowProcessesEvent(this.message, this.processes, this.choices);
}

class MountOperationShowUnmountProgressEvent {
  final String message;
  final int timeLeft;
  final int bytesLeft;

  MountOperationShowUnmountProgressEvent(this.message, this.timeLeft, this.bytesLeft);
}

class MountOperationResult extends GEnumBase {
  const MountOperationResult(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'MountOperationResult');

  static const MountOperationResult HANDLED = const MountOperationResult(0);
  static const MountOperationResult ABORTED = const MountOperationResult(1);
  static const MountOperationResult UNHANDLED = const MountOperationResult(2);
  String toString() {
    switch(index) {
      case 0: return 'MountOperationResult.HANDLED';
      case 1: return 'MountOperationResult.ABORTED';
      case 2: return 'MountOperationResult.UNHANDLED';
      default: return 'new MountOperationResult($index)';
    }
  }
}

class MountUnmountFlags extends GEnumBase {
  const MountUnmountFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'MountUnmountFlags');

  static const MountUnmountFlags NONE = const MountUnmountFlags(0);
  bool get none => (index & 0) == 0;
  static const MountUnmountFlags FORCE = const MountUnmountFlags(1);
  bool get force => (index & 1) == 1;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'MountUnmountFlags.FORCE';
      default: return 'new MountUnmountFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'MountUnmountFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 1; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  MountUnmountFlags operator|(MountUnmountFlags other) =>
    new MountUnmountFlags(index | other.index);
  MountUnmountFlags operator&(MountUnmountFlags other) =>
    new MountUnmountFlags(index & other.index);
}

class NativeSocketAddress extends GObjectBase {
  NativeSocketAddress.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'NativeSocketAddress');

}

class NativeVolumeMonitor extends VolumeMonitor {
  NativeVolumeMonitor.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'NativeVolumeMonitor');

}

class NetworkAddress extends GObjectObject with SocketConnectable {
  NetworkAddress.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'NetworkAddress');

  void set hostname(String value) => _staticInfo.setGPropertyOnReceiver('hostname', this, value);
  static const String HOSTNAME_PROPERTY = 'hostname';
  void set port(int value) => _staticInfo.setGPropertyOnReceiver('port', this, value);
  static const String PORT_PROPERTY = 'port';
  void set scheme(String value) => _staticInfo.setGPropertyOnReceiver('scheme', this, value);
  static const String SCHEME_PROPERTY = 'scheme';
  factory NetworkAddress(String hostname, int port) => _staticInfo.callStatic('new', [hostname, port]);
  factory NetworkAddress.loopback(int port) => _staticInfo.callStatic('new_loopback', [port]);
  static NetworkAddress parse(String hostAndPort, int defaultPort) => _staticInfo.callStatic('parse', [hostAndPort, defaultPort]);
  static NetworkAddress parseUri(String uri, int defaultPort) => _staticInfo.callStatic('parse_uri', [uri, defaultPort]);
  String get hostname_ => _staticInfo.callMethodOnReceiver('get_hostname', this, []);
  int get port_ => _staticInfo.callMethodOnReceiver('get_port', this, []);
  String get scheme_ => _staticInfo.callMethodOnReceiver('get_scheme', this, []);
}

class NetworkConnectivity extends GEnumBase {
  const NetworkConnectivity(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'NetworkConnectivity');

  static const NetworkConnectivity LOCAL = const NetworkConnectivity(1);
  static const NetworkConnectivity LIMITED = const NetworkConnectivity(2);
  static const NetworkConnectivity PORTAL = const NetworkConnectivity(3);
  static const NetworkConnectivity FULL = const NetworkConnectivity(4);
  String toString() {
    switch(index) {
      case 1: return 'NetworkConnectivity.LOCAL';
      case 2: return 'NetworkConnectivity.LIMITED';
      case 3: return 'NetworkConnectivity.PORTAL';
      case 4: return 'NetworkConnectivity.FULL';
      default: return 'new NetworkConnectivity($index)';
    }
  }
}

abstract class NetworkMonitor extends GObjectBase implements Initable {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'NetworkMonitor');



  static const String CONNECTIVITY_PROPERTY = 'connectivity';
  static const String NETWORK_AVAILABLE_PROPERTY = 'network-available';
  static const String NETWORK_METERED_PROPERTY = 'network-metered';
  static NetworkMonitor getDefault() => _staticInfo.callStatic('get_default', []);
  void canReach(SocketConnectable connectable, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('can_reach', this, [connectable, cancellable]);
  void canReachAsync(SocketConnectable connectable, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('can_reach_async', this, [connectable, cancellable, callback]);
  void canReachFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('can_reach_finish', this, [result]);
  NetworkConnectivity get connectivity => _staticInfo.callMethodOnReceiver('get_connectivity', this, []);
  bool get networkAvailable => _staticInfo.callMethodOnReceiver('get_network_available', this, []);
  bool get networkMetered => _staticInfo.callMethodOnReceiver('get_network_metered', this, []);
  int _connectToNetworkChanged(bool after, void func(bool available)) => signalConnect('network-changed', func, after);
  Stream<bool> get onNetworkChanged {
    int signalId;
    StreamController<bool> controller;
    controller = new StreamController<bool>(
      onListen: () {
          signalId = _connectToNetworkChanged(false, (bool available) {
              controller.add(available);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<bool> get afterNetworkChanged {
    int signalId;
    StreamController<bool> controller;
    controller = new StreamController<bool>(
      onListen: () {
          signalId = _connectToNetworkChanged(true, (bool available) {
              controller.add(available);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
}

class NetworkService extends GObjectObject with SocketConnectable {
  NetworkService.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'NetworkService');

  void set domain(String value) => _staticInfo.setGPropertyOnReceiver('domain', this, value);
  static const String DOMAIN_PROPERTY = 'domain';
  void set protocol(String value) => _staticInfo.setGPropertyOnReceiver('protocol', this, value);
  static const String PROTOCOL_PROPERTY = 'protocol';
  static const String SCHEME_PROPERTY = 'scheme';
  void set service(String value) => _staticInfo.setGPropertyOnReceiver('service', this, value);
  static const String SERVICE_PROPERTY = 'service';
  factory NetworkService(String service, String protocol, String domain) => _staticInfo.callStatic('new', [service, protocol, domain]);
  String get domain_ => _staticInfo.callMethodOnReceiver('get_domain', this, []);
  String get protocol_ => _staticInfo.callMethodOnReceiver('get_protocol', this, []);
  String get scheme => _staticInfo.callMethodOnReceiver('get_scheme', this, []);
  String get service_ => _staticInfo.callMethodOnReceiver('get_service', this, []);
  void set scheme(String scheme) => _staticInfo.callMethodOnReceiver('set_scheme', this, [scheme]);
}

class Notification extends GObjectObject {
  Notification.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'Notification');

  factory Notification(String title) => _staticInfo.callStatic('new', [title]);
  void addButton(String label, String detailedAction) => _staticInfo.callMethodOnReceiver('add_button', this, [label, detailedAction]);
  void addButtonWithTarget(String label, String action, Variant target) => _staticInfo.callMethodOnReceiver('add_button_with_target', this, [label, action, target]);
  void setBody(String body) => _staticInfo.callMethodOnReceiver('set_body', this, [body]);
  void setDefaultAction(String detailedAction) => _staticInfo.callMethodOnReceiver('set_default_action', this, [detailedAction]);
  void setDefaultActionAndTarget(String action, Variant target) => _staticInfo.callMethodOnReceiver('set_default_action_and_target', this, [action, target]);
  void setIcon(Icon icon) => _staticInfo.callMethodOnReceiver('set_icon', this, [icon]);
  void setPriority(NotificationPriority priority) => _staticInfo.callMethodOnReceiver('set_priority', this, [priority]);
  void setTitle(String title) => _staticInfo.callMethodOnReceiver('set_title', this, [title]);
  void setUrgent(bool urgent) => _staticInfo.callMethodOnReceiver('set_urgent', this, [urgent]);
}

class NotificationPriority extends GEnumBase {
  const NotificationPriority(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'NotificationPriority');

  static const NotificationPriority NORMAL = const NotificationPriority(0);
  static const NotificationPriority LOW = const NotificationPriority(1);
  static const NotificationPriority HIGH = const NotificationPriority(2);
  static const NotificationPriority URGENT = const NotificationPriority(3);
  String toString() {
    switch(index) {
      case 0: return 'NotificationPriority.NORMAL';
      case 1: return 'NotificationPriority.LOW';
      case 2: return 'NotificationPriority.HIGH';
      case 3: return 'NotificationPriority.URGENT';
      default: return 'new NotificationPriority($index)';
    }
  }
}

class OutputMessage extends GObjectBase {
  OutputMessage.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'OutputMessage');

  SocketAddress get address => getFieldOfObject('address', 0);
  void set address(SocketAddress value) => setFieldOfObject('address', 0, value);
  OutputVector get vectors => getFieldOfObject('vectors', 1);
  void set vectors(OutputVector value) => setFieldOfObject('vectors', 1, value);
  int get numVectors => getFieldOfObject('num_vectors', 2);
  void set numVectors(int value) => setFieldOfObject('num_vectors', 2, value);
  int get bytesSent => getFieldOfObject('bytes_sent', 3);
  void set bytesSent(int value) => setFieldOfObject('bytes_sent', 3, value);
  List<SocketControlMessage> get controlMessages => getFieldOfObject('control_messages', 4);
  void set controlMessages(List<SocketControlMessage> value) => setFieldOfObject('control_messages', 4, value);
  int get numControlMessages => getFieldOfObject('num_control_messages', 5);
  void set numControlMessages(int value) => setFieldOfObject('num_control_messages', 5, value);
}

class OutputStream extends GObjectObject {
  OutputStream.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'OutputStream');

  void clearPending() => _staticInfo.callMethodOnReceiver('clear_pending', this, []);
  void close(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('close', this, [cancellable]);
  void closeAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('close_async', this, [ioPriority, cancellable, callback]);
  void closeFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('close_finish', this, [result]);
  void flush(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('flush', this, [cancellable]);
  void flushAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('flush_async', this, [ioPriority, cancellable, callback]);
  void flushFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('flush_finish', this, [result]);
  bool hasPending() => _staticInfo.callMethodOnReceiver('has_pending', this, []);
  bool isClosed() => _staticInfo.callMethodOnReceiver('is_closed', this, []);
  bool isClosing() => _staticInfo.callMethodOnReceiver('is_closing', this, []);
  void setPending() => _staticInfo.callMethodOnReceiver('set_pending', this, []);
  int splice(InputStream source, OutputStreamSpliceFlags flags, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('splice', this, [source, flags, cancellable]);
  void spliceAsync(InputStream source, OutputStreamSpliceFlags flags, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('splice_async', this, [source, flags, ioPriority, cancellable, callback]);
  int spliceFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('splice_finish', this, [result]);
  int write(List<int> buffer, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('write', this, [buffer, cancellable]);
  int writeAll(List<int> buffer, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('write_all', this, [buffer, cancellable]);
  void writeAllAsync(List<int> buffer, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('write_all_async', this, [buffer, ioPriority, cancellable, callback]);
  int writeAllFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('write_all_finish', this, [result]);
  void writeAsync(List<int> buffer, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('write_async', this, [buffer, ioPriority, cancellable, callback]);
  int writeBytes(Bytes bytes, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('write_bytes', this, [bytes, cancellable]);
  void writeBytesAsync(Bytes bytes, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('write_bytes_async', this, [bytes, ioPriority, cancellable, callback]);
  int writeBytesFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('write_bytes_finish', this, [result]);
  int writeFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('write_finish', this, [result]);
}

class OutputStreamSpliceFlags extends GEnumBase {
  const OutputStreamSpliceFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'OutputStreamSpliceFlags');

  static const OutputStreamSpliceFlags NONE = const OutputStreamSpliceFlags(0);
  bool get none => (index & 0) == 0;
  static const OutputStreamSpliceFlags CLOSE_SOURCE = const OutputStreamSpliceFlags(1);
  bool get closeSource => (index & 1) == 1;
  static const OutputStreamSpliceFlags CLOSE_TARGET = const OutputStreamSpliceFlags(2);
  bool get closeTarget => (index & 2) == 2;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'OutputStreamSpliceFlags.CLOSE_SOURCE';
      case 2: return 'OutputStreamSpliceFlags.CLOSE_TARGET';
      default: return 'new OutputStreamSpliceFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'OutputStreamSpliceFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 2; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  OutputStreamSpliceFlags operator|(OutputStreamSpliceFlags other) =>
    new OutputStreamSpliceFlags(index | other.index);
  OutputStreamSpliceFlags operator&(OutputStreamSpliceFlags other) =>
    new OutputStreamSpliceFlags(index & other.index);
}

class OutputVector extends GObjectBase {
  OutputVector.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'OutputVector');

  dynamic /* this will fail */ get buffer => getFieldOfObject('buffer', 0);
  void set buffer(dynamic value /* this will fail */) => setFieldOfObject('buffer', 0, value);
  int get size => getFieldOfObject('size', 1);
  void set size(int value) => setFieldOfObject('size', 1, value);
}

class PasswordSave extends GEnumBase {
  const PasswordSave(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'PasswordSave');

  static const PasswordSave NEVER = const PasswordSave(0);
  static const PasswordSave FOR_SESSION = const PasswordSave(1);
  static const PasswordSave PERMANENTLY = const PasswordSave(2);
  String toString() {
    switch(index) {
      case 0: return 'PasswordSave.NEVER';
      case 1: return 'PasswordSave.FOR_SESSION';
      case 2: return 'PasswordSave.PERMANENTLY';
      default: return 'new PasswordSave($index)';
    }
  }
}

class Permission extends GObjectObject {
  Permission.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'Permission');

  static const String ALLOWED_PROPERTY = 'allowed';
  static const String CAN_ACQUIRE_PROPERTY = 'can-acquire';
  static const String CAN_RELEASE_PROPERTY = 'can-release';
  void acquire(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('acquire', this, [cancellable]);
  void acquireAsync(Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('acquire_async', this, [cancellable, callback]);
  void acquireFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('acquire_finish', this, [result]);
  bool get allowed => _staticInfo.callMethodOnReceiver('get_allowed', this, []);
  bool get canAcquire => _staticInfo.callMethodOnReceiver('get_can_acquire', this, []);
  bool get canRelease => _staticInfo.callMethodOnReceiver('get_can_release', this, []);
  void implUpdate(bool allowed, bool canAcquire, bool canRelease) => _staticInfo.callMethodOnReceiver('impl_update', this, [allowed, canAcquire, canRelease]);
  void release(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('release', this, [cancellable]);
  void releaseAsync(Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('release_async', this, [cancellable, callback]);
  void releaseFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('release_finish', this, [result]);
}

abstract class PollableInputStream extends GObjectBase implements InputStream {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'PollableInputStream');



  bool canPoll() => _staticInfo.callMethodOnReceiver('can_poll', this, []);
  Source createSource(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('create_source', this, [cancellable]);
  bool isReadable() => _staticInfo.callMethodOnReceiver('is_readable', this, []);
  int readNonblocking(List<int> buffer, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('read_nonblocking', this, [buffer, cancellable]);
}

abstract class PollableOutputStream extends GObjectBase implements OutputStream {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'PollableOutputStream');



  bool canPoll() => _staticInfo.callMethodOnReceiver('can_poll', this, []);
  Source createSource(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('create_source', this, [cancellable]);
  bool isWritable() => _staticInfo.callMethodOnReceiver('is_writable', this, []);
  int writeNonblocking(List<int> buffer, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('write_nonblocking', this, [buffer, cancellable]);
}

typedef bool PollableSourceFunc(GObjectObject pollableStream);
class PropertyAction extends GObjectObject with Action {
  PropertyAction.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'PropertyAction');

  bool get enabled => _staticInfo.getGPropertyOnReceiver('enabled', this);
  static const String ENABLED_PROPERTY = 'enabled';
  bool get invertBoolean => _staticInfo.getGPropertyOnReceiver('invert-boolean', this);
  void set invertBoolean(bool value) => _staticInfo.setGPropertyOnReceiver('invert-boolean', this, value);
  static const String INVERT_BOOLEAN_PROPERTY = 'invert-boolean';
  String get name => _staticInfo.getGPropertyOnReceiver('name', this);
  void set name(String value) => _staticInfo.setGPropertyOnReceiver('name', this, value);
  static const String NAME_PROPERTY = 'name';
  void set object(GObjectObject value) => _staticInfo.setGPropertyOnReceiver('object', this, value);
  static const String OBJECT_PROPERTY = 'object';
  VariantType get parameterType => _staticInfo.getGPropertyOnReceiver('parameter-type', this);
  static const String PARAMETER_TYPE_PROPERTY = 'parameter-type';
  void set propertyName(String value) => _staticInfo.setGPropertyOnReceiver('property-name', this, value);
  static const String PROPERTY_NAME_PROPERTY = 'property-name';
  Variant get state => _staticInfo.getGPropertyOnReceiver('state', this);
  static const String STATE_PROPERTY = 'state';
  VariantType get stateType => _staticInfo.getGPropertyOnReceiver('state-type', this);
  static const String STATE_TYPE_PROPERTY = 'state-type';
  factory PropertyAction(String name, GObjectObject object, String propertyName) => _staticInfo.callStatic('new', [name, object, propertyName]);
}

abstract class Proxy extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'Proxy');



  static Proxy getDefaultForProtocol(String protocol) => _staticInfo.callStatic('get_default_for_protocol', [protocol]);
  IOStream connect(IOStream connection, ProxyAddress proxyAddress, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('connect', this, [connection, proxyAddress, cancellable]);
  void connectAsync(IOStream connection, ProxyAddress proxyAddress, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('connect_async', this, [connection, proxyAddress, cancellable, callback]);
  IOStream connectFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('connect_finish', this, [result]);
  bool supportsHostname() => _staticInfo.callMethodOnReceiver('supports_hostname', this, []);
}

class ProxyAddress extends InetSocketAddress with SocketConnectable {
  ProxyAddress.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'ProxyAddress');

  void set destinationHostname(String value) => _staticInfo.setGPropertyOnReceiver('destination-hostname', this, value);
  static const String DESTINATION_HOSTNAME_PROPERTY = 'destination-hostname';
  void set destinationPort(int value) => _staticInfo.setGPropertyOnReceiver('destination-port', this, value);
  static const String DESTINATION_PORT_PROPERTY = 'destination-port';
  void set destinationProtocol(String value) => _staticInfo.setGPropertyOnReceiver('destination-protocol', this, value);
  static const String DESTINATION_PROTOCOL_PROPERTY = 'destination-protocol';
  void set password(String value) => _staticInfo.setGPropertyOnReceiver('password', this, value);
  static const String PASSWORD_PROPERTY = 'password';
  void set protocol(String value) => _staticInfo.setGPropertyOnReceiver('protocol', this, value);
  static const String PROTOCOL_PROPERTY = 'protocol';
  void set uri(String value) => _staticInfo.setGPropertyOnReceiver('uri', this, value);
  static const String URI_PROPERTY = 'uri';
  void set username(String value) => _staticInfo.setGPropertyOnReceiver('username', this, value);
  static const String USERNAME_PROPERTY = 'username';
  factory ProxyAddress(InetAddress inetaddr, int port, String protocol, String destHostname, int destPort, String username, String password) => _staticInfo.callStatic('new', [inetaddr, port, protocol, destHostname, destPort, username, password]);
  String get destinationHostname_ => _staticInfo.callMethodOnReceiver('get_destination_hostname', this, []);
  int get destinationPort_ => _staticInfo.callMethodOnReceiver('get_destination_port', this, []);
  String get destinationProtocol_ => _staticInfo.callMethodOnReceiver('get_destination_protocol', this, []);
  String get password_ => _staticInfo.callMethodOnReceiver('get_password', this, []);
  String get protocol_ => _staticInfo.callMethodOnReceiver('get_protocol', this, []);
  String get uri_ => _staticInfo.callMethodOnReceiver('get_uri', this, []);
  String get username_ => _staticInfo.callMethodOnReceiver('get_username', this, []);
}

class ProxyAddressEnumerator extends SocketAddressEnumerator {
  ProxyAddressEnumerator.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'ProxyAddressEnumerator');

  SocketConnectable get connectable => _staticInfo.getGPropertyOnReceiver('connectable', this);
  void set connectable(SocketConnectable value) => _staticInfo.setGPropertyOnReceiver('connectable', this, value);
  static const String CONNECTABLE_PROPERTY = 'connectable';
  int get defaultPort => _staticInfo.getGPropertyOnReceiver('default-port', this);
  void set defaultPort(int value) => _staticInfo.setGPropertyOnReceiver('default-port', this, value);
  static const String DEFAULT_PORT_PROPERTY = 'default-port';
  ProxyResolver get proxyResolver => _staticInfo.getGPropertyOnReceiver('proxy-resolver', this);
  void set proxyResolver(ProxyResolver value) => _staticInfo.setGPropertyOnReceiver('proxy-resolver', this, value);
  static const String PROXY_RESOLVER_PROPERTY = 'proxy-resolver';
  String get uri => _staticInfo.getGPropertyOnReceiver('uri', this);
  void set uri(String value) => _staticInfo.setGPropertyOnReceiver('uri', this, value);
  static const String URI_PROPERTY = 'uri';
}

abstract class ProxyResolver extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'ProxyResolver');



  static ProxyResolver getDefault() => _staticInfo.callStatic('get_default', []);
  bool isSupported() => _staticInfo.callMethodOnReceiver('is_supported', this, []);
  List<String> lookup(String uri, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('lookup', this, [uri, cancellable]);
  void lookupAsync(String uri, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('lookup_async', this, [uri, cancellable, callback]);
  List<String> lookupFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('lookup_finish', this, [result]);
}

abstract class RemoteActionGroup extends GObjectBase implements ActionGroup {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'RemoteActionGroup');



  void activateActionFull(String actionName, Variant parameter, Variant platformData) => _staticInfo.callMethodOnReceiver('activate_action_full', this, [actionName, parameter, platformData]);
  void changeActionStateFull(String actionName, Variant value, Variant platformData) => _staticInfo.callMethodOnReceiver('change_action_state_full', this, [actionName, value, platformData]);
}

class Resolver extends GObjectObject {
  Resolver.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'Resolver');

  static Resolver getDefault() => _staticInfo.callStatic('get_default', []);
  String lookupByAddress(InetAddress address, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('lookup_by_address', this, [address, cancellable]);
  void lookupByAddressAsync(InetAddress address, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('lookup_by_address_async', this, [address, cancellable, callback]);
  String lookupByAddressFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('lookup_by_address_finish', this, [result]);
  GLibList /* this will fail */ lookupByName(String hostname, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('lookup_by_name', this, [hostname, cancellable]);
  void lookupByNameAsync(String hostname, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('lookup_by_name_async', this, [hostname, cancellable, callback]);
  GLibList /* this will fail */ lookupByNameFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('lookup_by_name_finish', this, [result]);
  GLibList /* this will fail */ lookupRecords(String rrname, ResolverRecordType recordType, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('lookup_records', this, [rrname, recordType, cancellable]);
  void lookupRecordsAsync(String rrname, ResolverRecordType recordType, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('lookup_records_async', this, [rrname, recordType, cancellable, callback]);
  GLibList /* this will fail */ lookupRecordsFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('lookup_records_finish', this, [result]);
  GLibList /* this will fail */ lookupService(String service, String protocol, String domain, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('lookup_service', this, [service, protocol, domain, cancellable]);
  void lookupServiceAsync(String service, String protocol, String domain, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('lookup_service_async', this, [service, protocol, domain, cancellable, callback]);
  GLibList /* this will fail */ lookupServiceFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('lookup_service_finish', this, [result]);
  void setDefault() => _staticInfo.callMethodOnReceiver('set_default', this, []);
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

class ResolverErrorCode extends GEnumBase {
  const ResolverErrorCode(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'ResolverError');

  static const ResolverErrorCode NOT_FOUND = const ResolverErrorCode(0);
  static const ResolverErrorCode TEMPORARY_FAILURE = const ResolverErrorCode(1);
  static const ResolverErrorCode INTERNAL = const ResolverErrorCode(2);
  String toString() {
    switch(index) {
      case 0: return 'ResolverErrorCode.NOT_FOUND';
      case 1: return 'ResolverErrorCode.TEMPORARY_FAILURE';
      case 2: return 'ResolverErrorCode.INTERNAL';
      default: return 'new ResolverErrorCode($index)';
    }
  }
  static int quark() => _staticInfo.callStatic('quark', []);
}

class ResolverError extends GErrorBase {
  static final int _quark = lookupErrorQuarkFromString('g-resolver-error-quark');
  ResolverError(ResolverErrorCode code, String message)
      : super.fromFields(_quark, code, message);
}

class ResolverRecordType extends GEnumBase {
  const ResolverRecordType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'ResolverRecordType');

  static const ResolverRecordType SRV = const ResolverRecordType(1);
  static const ResolverRecordType MX = const ResolverRecordType(2);
  static const ResolverRecordType TXT = const ResolverRecordType(3);
  static const ResolverRecordType SOA = const ResolverRecordType(4);
  static const ResolverRecordType NS = const ResolverRecordType(5);
  String toString() {
    switch(index) {
      case 1: return 'ResolverRecordType.SRV';
      case 2: return 'ResolverRecordType.MX';
      case 3: return 'ResolverRecordType.TXT';
      case 4: return 'ResolverRecordType.SOA';
      case 5: return 'ResolverRecordType.NS';
      default: return 'new ResolverRecordType($index)';
    }
  }
}

class Resource extends GObjectBase {
  Resource.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'Resource');

  factory Resource.fromData(Bytes data) => _staticInfo.callStatic('new_from_data', [data]);
  void Register() => _staticInfo.callMethodOnReceiver('_register', this, []);
  void Unregister() => _staticInfo.callMethodOnReceiver('_unregister', this, []);
  List<String> enumerateChildren(String path, ResourceLookupFlags lookupFlags) => _staticInfo.callMethodOnReceiver('enumerate_children', this, [path, lookupFlags]);
  List getInfo(String path, ResourceLookupFlags lookupFlags) => _staticInfo.callMethodOnReceiver('get_info', this, [path, lookupFlags]);
  Bytes lookupData(String path, ResourceLookupFlags lookupFlags) => _staticInfo.callMethodOnReceiver('lookup_data', this, [path, lookupFlags]);
  InputStream openStream(String path, ResourceLookupFlags lookupFlags) => _staticInfo.callMethodOnReceiver('open_stream', this, [path, lookupFlags]);
  Resource ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
  static Resource load(String filename) => _staticInfo.callStatic('load', [filename]);
}

class ResourceErrorCode extends GEnumBase {
  const ResourceErrorCode(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'ResourceError');

  static const ResourceErrorCode NOT_FOUND = const ResourceErrorCode(0);
  static const ResourceErrorCode INTERNAL = const ResourceErrorCode(1);
  String toString() {
    switch(index) {
      case 0: return 'ResourceErrorCode.NOT_FOUND';
      case 1: return 'ResourceErrorCode.INTERNAL';
      default: return 'new ResourceErrorCode($index)';
    }
  }
  static int quark() => _staticInfo.callStatic('quark', []);
}

class ResourceError extends GErrorBase {
  static final int _quark = lookupErrorQuarkFromString('g-resource-error-quark');
  ResourceError(ResourceErrorCode code, String message)
      : super.fromFields(_quark, code, message);
}

class ResourceFlags extends GEnumBase {
  const ResourceFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'ResourceFlags');

  static const ResourceFlags NONE = const ResourceFlags(0);
  bool get none => (index & 0) == 0;
  static const ResourceFlags COMPRESSED = const ResourceFlags(1);
  bool get compressed => (index & 1) == 1;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'ResourceFlags.COMPRESSED';
      default: return 'new ResourceFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'ResourceFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 1; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  ResourceFlags operator|(ResourceFlags other) =>
    new ResourceFlags(index | other.index);
  ResourceFlags operator&(ResourceFlags other) =>
    new ResourceFlags(index & other.index);
}

class ResourceLookupFlags extends GEnumBase {
  const ResourceLookupFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'ResourceLookupFlags');

  static const ResourceLookupFlags NONE = const ResourceLookupFlags(0);
  bool get none => (index & 0) == 0;
  static _valueToString(int value) {
    switch(value) {
      default: return 'new ResourceLookupFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'ResourceLookupFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 0; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  ResourceLookupFlags operator|(ResourceLookupFlags other) =>
    new ResourceLookupFlags(index | other.index);
  ResourceLookupFlags operator&(ResourceLookupFlags other) =>
    new ResourceLookupFlags(index & other.index);
}

abstract class Seekable extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'Seekable');



  bool canSeek() => _staticInfo.callMethodOnReceiver('can_seek', this, []);
  bool canTruncate() => _staticInfo.callMethodOnReceiver('can_truncate', this, []);
  void seek(int offset, SeekType type, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('seek', this, [offset, type, cancellable]);
  int tell() => _staticInfo.callMethodOnReceiver('tell', this, []);
  void truncate(int offset, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('truncate', this, [offset, cancellable]);
}

class Settings extends GObjectObject {
  Settings.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'Settings');

  bool get delayApply => _staticInfo.getGPropertyOnReceiver('delay-apply', this);
  static const String DELAY_APPLY_PROPERTY = 'delay-apply';
  static const String HAS_UNAPPLIED_PROPERTY = 'has-unapplied';
  String get path => _staticInfo.getGPropertyOnReceiver('path', this);
  void set path(String value) => _staticInfo.setGPropertyOnReceiver('path', this, value);
  static const String PATH_PROPERTY = 'path';
  String get schema => _staticInfo.getGPropertyOnReceiver('schema', this);
  void set schema(String value) => _staticInfo.setGPropertyOnReceiver('schema', this, value);
  static const String SCHEMA_PROPERTY = 'schema';
  String get schemaId => _staticInfo.getGPropertyOnReceiver('schema-id', this);
  void set schemaId(String value) => _staticInfo.setGPropertyOnReceiver('schema-id', this, value);
  static const String SCHEMA_ID_PROPERTY = 'schema-id';
  SettingsSchema get settingsSchema => _staticInfo.getGPropertyOnReceiver('settings-schema', this);
  void set settingsSchema(SettingsSchema value) => _staticInfo.setGPropertyOnReceiver('settings-schema', this, value);
  static const String SETTINGS_SCHEMA_PROPERTY = 'settings-schema';
  factory Settings(String schemaId) => _staticInfo.callStatic('new', [schemaId]);
  factory Settings.full(SettingsSchema schema, SettingsBackend backend, String path) => _staticInfo.callStatic('new_full', [schema, backend, path]);
  factory Settings.withBackend(String schemaId, SettingsBackend backend) => _staticInfo.callStatic('new_with_backend', [schemaId, backend]);
  factory Settings.withBackendAndPath(String schemaId, SettingsBackend backend, String path) => _staticInfo.callStatic('new_with_backend_and_path', [schemaId, backend, path]);
  factory Settings.withPath(String schemaId, String path) => _staticInfo.callStatic('new_with_path', [schemaId, path]);
  static List<String> listRelocatableSchemas() => _staticInfo.callStatic('list_relocatable_schemas', []);
  static List<String> listSchemas() => _staticInfo.callStatic('list_schemas', []);
  static void sync() => _staticInfo.callStatic('sync', []);
  static void unbind(GObjectObject object, String property) => _staticInfo.callStatic('unbind', [object, property]);
  void apply() => _staticInfo.callMethodOnReceiver('apply', this, []);
  void bind(String key, GObjectObject object, String property, SettingsBindFlags flags) => _staticInfo.callMethodOnReceiver('bind', this, [key, object, property, flags]);
  void bindWritable(String key, GObjectObject object, String property, bool inverted) => _staticInfo.callMethodOnReceiver('bind_writable', this, [key, object, property, inverted]);
  Action createAction(String key) => _staticInfo.callMethodOnReceiver('create_action', this, [key]);
  void delay() => _staticInfo.callMethodOnReceiver('delay', this, []);
  bool getBoolean(String key) => _staticInfo.callMethodOnReceiver('get_boolean', this, [key]);
  Settings getChild(String name) => _staticInfo.callMethodOnReceiver('get_child', this, [name]);
  Variant getDefaultValue(String key) => _staticInfo.callMethodOnReceiver('get_default_value', this, [key]);
  num getDouble(String key) => _staticInfo.callMethodOnReceiver('get_double', this, [key]);
  int getEnum(String key) => _staticInfo.callMethodOnReceiver('get_enum', this, [key]);
  int getFlags(String key) => _staticInfo.callMethodOnReceiver('get_flags', this, [key]);
  bool get hasUnapplied => _staticInfo.callMethodOnReceiver('get_has_unapplied', this, []);
  int getInt(String key) => _staticInfo.callMethodOnReceiver('get_int', this, [key]);
  void getMapped(String key, SettingsGetMapping mapping) => _staticInfo.callMethodOnReceiver('get_mapped', this, [key, mapping]);
  Variant getRange(String key) => _staticInfo.callMethodOnReceiver('get_range', this, [key]);
  String getString(String key) => _staticInfo.callMethodOnReceiver('get_string', this, [key]);
  List<String> getStrv(String key) => _staticInfo.callMethodOnReceiver('get_strv', this, [key]);
  int getUint(String key) => _staticInfo.callMethodOnReceiver('get_uint', this, [key]);
  Variant getUserValue(String key) => _staticInfo.callMethodOnReceiver('get_user_value', this, [key]);
  Variant getValue(String key) => _staticInfo.callMethodOnReceiver('get_value', this, [key]);
  bool isWritable(String name) => _staticInfo.callMethodOnReceiver('is_writable', this, [name]);
  List<String> listChildren() => _staticInfo.callMethodOnReceiver('list_children', this, []);
  List<String> listKeys() => _staticInfo.callMethodOnReceiver('list_keys', this, []);
  bool rangeCheck(String key, Variant value) => _staticInfo.callMethodOnReceiver('range_check', this, [key, value]);
  void reset(String key) => _staticInfo.callMethodOnReceiver('reset', this, [key]);
  void revert() => _staticInfo.callMethodOnReceiver('revert', this, []);
  bool setBoolean(String key, bool value) => _staticInfo.callMethodOnReceiver('set_boolean', this, [key, value]);
  bool setDouble(String key, num value) => _staticInfo.callMethodOnReceiver('set_double', this, [key, value]);
  bool setEnum(String key, int value) => _staticInfo.callMethodOnReceiver('set_enum', this, [key, value]);
  bool setFlags(String key, int value) => _staticInfo.callMethodOnReceiver('set_flags', this, [key, value]);
  bool setInt(String key, int value) => _staticInfo.callMethodOnReceiver('set_int', this, [key, value]);
  bool setString(String key, String value) => _staticInfo.callMethodOnReceiver('set_string', this, [key, value]);
  bool setStrv(String key, List<String> value) => _staticInfo.callMethodOnReceiver('set_strv', this, [key, value]);
  bool setUint(String key, int value) => _staticInfo.callMethodOnReceiver('set_uint', this, [key, value]);
  bool setValue(String key, Variant value) => _staticInfo.callMethodOnReceiver('set_value', this, [key, value]);
  int _connectToChangeEvent(bool after, bool func(List<int> keys)) => signalConnect('change-event', func, after);
  Stream<SettingsChangeEventEvent> get onChangeEvent {
    int signalId;
    StreamController<SettingsChangeEventEvent> controller;
    controller = new StreamController<SettingsChangeEventEvent>(
      onListen: () {
          signalId = _connectToChangeEvent(false, (List<int> keys) {
              var result = new SettingsChangeEventEvent(keys);
              controller.add(result);
              return result._cancelPropagation;
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<SettingsChangeEventEvent> get afterChangeEvent {
    int signalId;
    StreamController<SettingsChangeEventEvent> controller;
    controller = new StreamController<SettingsChangeEventEvent>(
      onListen: () {
          signalId = _connectToChangeEvent(true, (List<int> keys) {
              var result = new SettingsChangeEventEvent(keys);
              controller.add(result);
              return result._cancelPropagation;
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToChanged(bool after, void func(String key)) => signalConnect('changed', func, after);
  Stream<String> get onChanged {
    int signalId;
    StreamController<String> controller;
    controller = new StreamController<String>(
      onListen: () {
          signalId = _connectToChanged(false, (String key) {
              controller.add(key);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<String> get afterChanged {
    int signalId;
    StreamController<String> controller;
    controller = new StreamController<String>(
      onListen: () {
          signalId = _connectToChanged(true, (String key) {
              controller.add(key);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToWritableChangeEvent(bool after, bool func(int key)) => signalConnect('writable-change-event', func, after);
  Stream<SettingsWritableChangeEventEvent> get onWritableChangeEvent {
    int signalId;
    StreamController<SettingsWritableChangeEventEvent> controller;
    controller = new StreamController<SettingsWritableChangeEventEvent>(
      onListen: () {
          signalId = _connectToWritableChangeEvent(false, (int key) {
              var result = new SettingsWritableChangeEventEvent(key);
              controller.add(result);
              return result._cancelPropagation;
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<SettingsWritableChangeEventEvent> get afterWritableChangeEvent {
    int signalId;
    StreamController<SettingsWritableChangeEventEvent> controller;
    controller = new StreamController<SettingsWritableChangeEventEvent>(
      onListen: () {
          signalId = _connectToWritableChangeEvent(true, (int key) {
              var result = new SettingsWritableChangeEventEvent(key);
              controller.add(result);
              return result._cancelPropagation;
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToWritableChanged(bool after, void func(String key)) => signalConnect('writable-changed', func, after);
  Stream<String> get onWritableChanged {
    int signalId;
    StreamController<String> controller;
    controller = new StreamController<String>(
      onListen: () {
          signalId = _connectToWritableChanged(false, (String key) {
              controller.add(key);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<String> get afterWritableChanged {
    int signalId;
    StreamController<String> controller;
    controller = new StreamController<String>(
      onListen: () {
          signalId = _connectToWritableChanged(true, (String key) {
              controller.add(key);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
}

class SettingsChangeEventEvent {
  final List<int> keys;
  bool _cancelPropagation = false;
  void cancelPropagation() {
    _cancelPropagation = true;
  }
  SettingsChangeEventEvent(this.keys);
}

class SettingsWritableChangeEventEvent {
  final int key;
  bool _cancelPropagation = false;
  void cancelPropagation() {
    _cancelPropagation = true;
  }
  SettingsWritableChangeEventEvent(this.key);
}

class SettingsBackend extends GObjectBase {
  SettingsBackend.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'SettingsBackend');

}

class SettingsBindFlags extends GEnumBase {
  const SettingsBindFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'SettingsBindFlags');

  static const SettingsBindFlags DEFAULT = const SettingsBindFlags(0);
  bool get default_ => (index & 0) == 0;
  static const SettingsBindFlags GET = const SettingsBindFlags(1);
  bool get get_ => (index & 1) == 1;
  static const SettingsBindFlags SET = const SettingsBindFlags(2);
  bool get set_ => (index & 2) == 2;
  static const SettingsBindFlags NO_SENSITIVITY = const SettingsBindFlags(4);
  bool get noSensitivity => (index & 4) == 4;
  static const SettingsBindFlags GET_NO_CHANGES = const SettingsBindFlags(8);
  bool get getNoChanges => (index & 8) == 8;
  static const SettingsBindFlags INVERT_BOOLEAN = const SettingsBindFlags(16);
  bool get invertBoolean => (index & 16) == 16;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'SettingsBindFlags.GET';
      case 2: return 'SettingsBindFlags.SET';
      case 4: return 'SettingsBindFlags.NO_SENSITIVITY';
      case 8: return 'SettingsBindFlags.GET_NO_CHANGES';
      case 16: return 'SettingsBindFlags.INVERT_BOOLEAN';
      default: return 'new SettingsBindFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'SettingsBindFlags.DEFAULT';
    }
    List codes = [];
    for (var i=1; i <= 16; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  SettingsBindFlags operator|(SettingsBindFlags other) =>
    new SettingsBindFlags(index | other.index);
  SettingsBindFlags operator&(SettingsBindFlags other) =>
    new SettingsBindFlags(index & other.index);
}

typedef bool SettingsBindGetMapping(Value value, Variant variant);
typedef Variant SettingsBindSetMapping(Value value, VariantType expectedType);
typedef List SettingsGetMapping(Variant value);
class SettingsSchema extends GObjectBase {
  SettingsSchema.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'SettingsSchema');

  String get id => _staticInfo.callMethodOnReceiver('get_id', this, []);
  SettingsSchemaKey getKey(String name) => _staticInfo.callMethodOnReceiver('get_key', this, [name]);
  String get path => _staticInfo.callMethodOnReceiver('get_path', this, []);
  bool hasKey(String name) => _staticInfo.callMethodOnReceiver('has_key', this, [name]);
  List<String> listChildren() => _staticInfo.callMethodOnReceiver('list_children', this, []);
  List<String> listKeys() => _staticInfo.callMethodOnReceiver('list_keys', this, []);
  SettingsSchema ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
}

class SettingsSchemaKey extends GObjectBase {
  SettingsSchemaKey.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'SettingsSchemaKey');

  Variant get defaultValue => _staticInfo.callMethodOnReceiver('get_default_value', this, []);
  String get description => _staticInfo.callMethodOnReceiver('get_description', this, []);
  String get name => _staticInfo.callMethodOnReceiver('get_name', this, []);
  Variant get range => _staticInfo.callMethodOnReceiver('get_range', this, []);
  String get summary => _staticInfo.callMethodOnReceiver('get_summary', this, []);
  VariantType get valueType => _staticInfo.callMethodOnReceiver('get_value_type', this, []);
  bool rangeCheck(Variant value) => _staticInfo.callMethodOnReceiver('range_check', this, [value]);
  SettingsSchemaKey ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
}

class SettingsSchemaSource extends GObjectBase {
  SettingsSchemaSource.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'SettingsSchemaSource');

  factory SettingsSchemaSource.fromDirectory(String directory, SettingsSchemaSource parent, bool trusted) => _staticInfo.callStatic('new_from_directory', [directory, parent, trusted]);
  List listSchemas(bool recursive) => _staticInfo.callMethodOnReceiver('list_schemas', this, [recursive]);
  SettingsSchema lookup(String schemaId, bool recursive) => _staticInfo.callMethodOnReceiver('lookup', this, [schemaId, recursive]);
  SettingsSchemaSource ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
  static SettingsSchemaSource getDefault() => _staticInfo.callStatic('get_default', []);
}

class SimpleAction extends GObjectObject with Action {
  SimpleAction.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'SimpleAction');

  bool get enabled => _staticInfo.getGPropertyOnReceiver('enabled', this);
  static const String ENABLED_PROPERTY = 'enabled';
  String get name => _staticInfo.getGPropertyOnReceiver('name', this);
  void set name(String value) => _staticInfo.setGPropertyOnReceiver('name', this, value);
  static const String NAME_PROPERTY = 'name';
  VariantType get parameterType => _staticInfo.getGPropertyOnReceiver('parameter-type', this);
  void set parameterType(VariantType value) => _staticInfo.setGPropertyOnReceiver('parameter-type', this, value);
  static const String PARAMETER_TYPE_PROPERTY = 'parameter-type';
  Variant get state => _staticInfo.getGPropertyOnReceiver('state', this);
  static const String STATE_PROPERTY = 'state';
  VariantType get stateType => _staticInfo.getGPropertyOnReceiver('state-type', this);
  static const String STATE_TYPE_PROPERTY = 'state-type';
  factory SimpleAction(String name, VariantType parameterType) => _staticInfo.callStatic('new', [name, parameterType]);
  factory SimpleAction.stateful(String name, VariantType parameterType, Variant state) => _staticInfo.callStatic('new_stateful', [name, parameterType, state]);
  void set enabled(bool enabled) => _staticInfo.callMethodOnReceiver('set_enabled', this, [enabled]);
  void set state(Variant value) => _staticInfo.callMethodOnReceiver('set_state', this, [value]);
  void setStateHint(Variant stateHint) => _staticInfo.callMethodOnReceiver('set_state_hint', this, [stateHint]);
  int _connectToActivate(bool after, void func(Variant parameter)) => signalConnect('activate', func, after);
  Stream<Variant> get onActivate {
    int signalId;
    StreamController<Variant> controller;
    controller = new StreamController<Variant>(
      onListen: () {
          signalId = _connectToActivate(false, (Variant parameter) {
              controller.add(parameter);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<Variant> get afterActivate {
    int signalId;
    StreamController<Variant> controller;
    controller = new StreamController<Variant>(
      onListen: () {
          signalId = _connectToActivate(true, (Variant parameter) {
              controller.add(parameter);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToChangeState(bool after, void func(Variant value)) => signalConnect('change-state', func, after);
  Stream<Variant> get onChangeState {
    int signalId;
    StreamController<Variant> controller;
    controller = new StreamController<Variant>(
      onListen: () {
          signalId = _connectToChangeState(false, (Variant value) {
              controller.add(value);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<Variant> get afterChangeState {
    int signalId;
    StreamController<Variant> controller;
    controller = new StreamController<Variant>(
      onListen: () {
          signalId = _connectToChangeState(true, (Variant value) {
              controller.add(value);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
}

class SimpleActionGroup extends GObjectObject with ActionGroup, ActionMap {
  SimpleActionGroup.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'SimpleActionGroup');

  factory SimpleActionGroup() => _staticInfo.callStatic('new', []);
  void addEntries(List<ActionEntry> entries, dynamic userData /* this will fail */) => _staticInfo.callMethodOnReceiver('add_entries', this, [entries, userData]);
  void insert(Action action) => _staticInfo.callMethodOnReceiver('insert', this, [action]);
  Action lookup(String actionName) => _staticInfo.callMethodOnReceiver('lookup', this, [actionName]);
  void remove(String actionName) => _staticInfo.callMethodOnReceiver('remove', this, [actionName]);
}

class SimpleAsyncResult extends GObjectObject with AsyncResult {
  SimpleAsyncResult.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'SimpleAsyncResult');

  factory SimpleAsyncResult(GObjectObject sourceObject, AsyncReadyCallback callback, dynamic sourceTag /* this will fail */) => _staticInfo.callStatic('new', [sourceObject, callback, sourceTag]);
  factory SimpleAsyncResult.fromError(GObjectObject sourceObject, AsyncReadyCallback callback, GErrorBase error) => _staticInfo.callStatic('new_from_error', [sourceObject, callback, error]);
  static bool isValid(AsyncResult result, GObjectObject source, dynamic sourceTag /* this will fail */) => _staticInfo.callStatic('is_valid', [result, source, sourceTag]);
  void complete() => _staticInfo.callMethodOnReceiver('complete', this, []);
  void completeInIdle() => _staticInfo.callMethodOnReceiver('complete_in_idle', this, []);
  bool getOResGboolean() => _staticInfo.callMethodOnReceiver('get_op_res_gboolean', this, []);
  int getOpResGssize() => _staticInfo.callMethodOnReceiver('get_op_res_gssize', this, []);
  void propagateError() => _staticInfo.callMethodOnReceiver('propagate_error', this, []);
  void setCheckCancellable(Cancellable checkCancellable) => _staticInfo.callMethodOnReceiver('set_check_cancellable', this, [checkCancellable]);
  void setFromError(GErrorBase error) => _staticInfo.callMethodOnReceiver('set_from_error', this, [error]);
  void setHandleCancellation(bool handleCancellation) => _staticInfo.callMethodOnReceiver('set_handle_cancellation', this, [handleCancellation]);
  void setOpResGboolean(bool opRes) => _staticInfo.callMethodOnReceiver('set_op_res_gboolean', this, [opRes]);
  void setOpResGssize(int opRes) => _staticInfo.callMethodOnReceiver('set_op_res_gssize', this, [opRes]);
}

typedef void SimpleAsyncThreadFunc(SimpleAsyncResult res, GObjectObject object, Cancellable cancellable);
class SimpleIOStream extends IOStream {
  SimpleIOStream.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'SimpleIOStream');

  InputStream get inputStream => _staticInfo.getGPropertyOnReceiver('input-stream', this);
  void set inputStream(InputStream value) => _staticInfo.setGPropertyOnReceiver('input-stream', this, value);
  static const String INPUT_STREAM_PROPERTY = 'input-stream';
  OutputStream get outputStream => _staticInfo.getGPropertyOnReceiver('output-stream', this);
  void set outputStream(OutputStream value) => _staticInfo.setGPropertyOnReceiver('output-stream', this, value);
  static const String OUTPUT_STREAM_PROPERTY = 'output-stream';
  factory SimpleIOStream(InputStream inputStream, OutputStream outputStream) => _staticInfo.callStatic('new', [inputStream, outputStream]);
}

class SimplePermission extends Permission {
  SimplePermission.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'SimplePermission');

  factory SimplePermission(bool allowed) => _staticInfo.callStatic('new', [allowed]);
}

class SimpleProxyResolver extends GObjectObject with ProxyResolver {
  SimpleProxyResolver.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'SimpleProxyResolver');

  String get defaultProxy => _staticInfo.getGPropertyOnReceiver('default-proxy', this);
  static const String DEFAULT_PROXY_PROPERTY = 'default-proxy';
  List<String> get ignoreHosts => _staticInfo.getGPropertyOnReceiver('ignore-hosts', this);
  static const String IGNORE_HOSTS_PROPERTY = 'ignore-hosts';
  static ProxyResolver new_(String defaultProxy, String ignoreHosts) => _staticInfo.callStatic('new', [defaultProxy, ignoreHosts]);
  void set defaultProxy(String defaultProxy) => _staticInfo.callMethodOnReceiver('set_default_proxy', this, [defaultProxy]);
  void set ignoreHosts(List<String> ignoreHosts) => _staticInfo.callMethodOnReceiver('set_ignore_hosts', this, [ignoreHosts]);
  void setUriProxy(String uriScheme, String proxy) => _staticInfo.callMethodOnReceiver('set_uri_proxy', this, [uriScheme, proxy]);
}

class Socket extends GObjectObject with Initable {
  Socket.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'Socket');

  static const String BLOCKING_PROPERTY = 'blocking';
  static const String BROADCAST_PROPERTY = 'broadcast';
  void set family(SocketFamily value) => _staticInfo.setGPropertyOnReceiver('family', this, value);
  static const String FAMILY_PROPERTY = 'family';
  void set fd(int value) => _staticInfo.setGPropertyOnReceiver('fd', this, value);
  static const String FD_PROPERTY = 'fd';
  static const String KEEPALIVE_PROPERTY = 'keepalive';
  static const String LISTEN_BACKLOG_PROPERTY = 'listen-backlog';
  static const String LOCAL_ADDRESS_PROPERTY = 'local-address';
  static const String MULTICAST_LOOPBACK_PROPERTY = 'multicast-loopback';
  static const String MULTICAST_TTL_PROPERTY = 'multicast-ttl';
  void set protocol(SocketProtocol value) => _staticInfo.setGPropertyOnReceiver('protocol', this, value);
  static const String PROTOCOL_PROPERTY = 'protocol';
  static const String REMOTE_ADDRESS_PROPERTY = 'remote-address';
  static const String TIMEOUT_PROPERTY = 'timeout';
  static const String TTL_PROPERTY = 'ttl';
  SocketType get type => _staticInfo.getGPropertyOnReceiver('type', this);
  void set type(SocketType value) => _staticInfo.setGPropertyOnReceiver('type', this, value);
  static const String TYPE_PROPERTY = 'type';
  factory Socket(SocketFamily family, SocketType type, SocketProtocol protocol) => _staticInfo.callStatic('new', [family, type, protocol]);
  factory Socket.fromFd(int fd) => _staticInfo.callStatic('new_from_fd', [fd]);
  Socket accept(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('accept', this, [cancellable]);
  void bind(SocketAddress address, bool allowReuse) => _staticInfo.callMethodOnReceiver('bind', this, [address, allowReuse]);
  void checkConnectResult() => _staticInfo.callMethodOnReceiver('check_connect_result', this, []);
  void close() => _staticInfo.callMethodOnReceiver('close', this, []);
  IOCondition conditionCheck(IOCondition condition) => _staticInfo.callMethodOnReceiver('condition_check', this, [condition]);
  void conditionTimedWait(IOCondition condition, int timeout, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('condition_timed_wait', this, [condition, timeout, cancellable]);
  void conditionWait(IOCondition condition, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('condition_wait', this, [condition, cancellable]);
  void connect(SocketAddress address, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('connect', this, [address, cancellable]);
  SocketConnection connectionFactoryCreateConnection() => _staticInfo.callMethodOnReceiver('connection_factory_create_connection', this, []);
  int get availableBytes => _staticInfo.callMethodOnReceiver('get_available_bytes', this, []);
  bool get blocking => _staticInfo.callMethodOnReceiver('get_blocking', this, []);
  bool get broadcast => _staticInfo.callMethodOnReceiver('get_broadcast', this, []);
  Credentials get credentials => _staticInfo.callMethodOnReceiver('get_credentials', this, []);
  SocketFamily get family_ => _staticInfo.callMethodOnReceiver('get_family', this, []);
  int get fd_ => _staticInfo.callMethodOnReceiver('get_fd', this, []);
  bool get keepalive => _staticInfo.callMethodOnReceiver('get_keepalive', this, []);
  int get listenBacklog => _staticInfo.callMethodOnReceiver('get_listen_backlog', this, []);
  SocketAddress get localAddress => _staticInfo.callMethodOnReceiver('get_local_address', this, []);
  bool get multicastLoopback => _staticInfo.callMethodOnReceiver('get_multicast_loopback', this, []);
  int get multicastTtl => _staticInfo.callMethodOnReceiver('get_multicast_ttl', this, []);
  int getOption(int level, int optname) => _staticInfo.callMethodOnReceiver('get_option', this, [level, optname]);
  SocketProtocol get protocol_ => _staticInfo.callMethodOnReceiver('get_protocol', this, []);
  SocketAddress get remoteAddress => _staticInfo.callMethodOnReceiver('get_remote_address', this, []);
  SocketType get socketType => _staticInfo.callMethodOnReceiver('get_socket_type', this, []);
  int get timeout => _staticInfo.callMethodOnReceiver('get_timeout', this, []);
  int get ttl => _staticInfo.callMethodOnReceiver('get_ttl', this, []);
  bool isClosed() => _staticInfo.callMethodOnReceiver('is_closed', this, []);
  bool isConnected() => _staticInfo.callMethodOnReceiver('is_connected', this, []);
  void joinMulticastGroup(InetAddress group, bool sourceSpecific, String iface) => _staticInfo.callMethodOnReceiver('join_multicast_group', this, [group, sourceSpecific, iface]);
  void leaveMulticastGroup(InetAddress group, bool sourceSpecific, String iface) => _staticInfo.callMethodOnReceiver('leave_multicast_group', this, [group, sourceSpecific, iface]);
  void listen() => _staticInfo.callMethodOnReceiver('listen', this, []);
  int receive(List<int> buffer, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('receive', this, [buffer, cancellable]);
  List receiveFrom(List<int> buffer, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('receive_from', this, [buffer, cancellable]);
  List receiveMessage(List<InputVector> vectors, List<SocketControlMessage> messages, int flags, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('receive_message', this, [vectors, messages, flags, cancellable]);
  int receiveWithBlocking(List<int> buffer, bool blocking, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('receive_with_blocking', this, [buffer, blocking, cancellable]);
  int send(List<int> buffer, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('send', this, [buffer, cancellable]);
  int sendMessage(SocketAddress address, List<OutputVector> vectors, List<SocketControlMessage> messages, int flags, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('send_message', this, [address, vectors, messages, flags, cancellable]);
  int sendMessages(List<OutputMessage> messages, int flags, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('send_messages', this, [messages, flags, cancellable]);
  int sendTo(SocketAddress address, List<int> buffer, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('send_to', this, [address, buffer, cancellable]);
  int sendWithBlocking(List<int> buffer, bool blocking, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('send_with_blocking', this, [buffer, blocking, cancellable]);
  void set blocking(bool blocking) => _staticInfo.callMethodOnReceiver('set_blocking', this, [blocking]);
  void set broadcast(bool broadcast) => _staticInfo.callMethodOnReceiver('set_broadcast', this, [broadcast]);
  void set keepalive(bool keepalive) => _staticInfo.callMethodOnReceiver('set_keepalive', this, [keepalive]);
  void set listenBacklog(int backlog) => _staticInfo.callMethodOnReceiver('set_listen_backlog', this, [backlog]);
  void set multicastLoopback(bool loopback) => _staticInfo.callMethodOnReceiver('set_multicast_loopback', this, [loopback]);
  void set multicastTtl(int ttl) => _staticInfo.callMethodOnReceiver('set_multicast_ttl', this, [ttl]);
  void setOption(int level, int optname, int value) => _staticInfo.callMethodOnReceiver('set_option', this, [level, optname, value]);
  void set timeout(int timeout) => _staticInfo.callMethodOnReceiver('set_timeout', this, [timeout]);
  void set ttl(int ttl) => _staticInfo.callMethodOnReceiver('set_ttl', this, [ttl]);
  void shutdown(bool shutdownRead, bool shutdownWrite) => _staticInfo.callMethodOnReceiver('shutdown', this, [shutdownRead, shutdownWrite]);
  bool speaksIpv4() => _staticInfo.callMethodOnReceiver('speaks_ipv4', this, []);
}

class SocketAddress extends GObjectObject with SocketConnectable {
  SocketAddress.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'SocketAddress');

  static const String FAMILY_PROPERTY = 'family';
  factory SocketAddress.fromNative_(dynamic native /* this will fail */, int len) => _staticInfo.callStatic('new_from_native', [native, len]);
  SocketFamily get family => _staticInfo.callMethodOnReceiver('get_family', this, []);
  int get nativeSize => _staticInfo.callMethodOnReceiver('get_native_size', this, []);
  void toNative(dynamic dest /* this will fail */, int destlen) => _staticInfo.callMethodOnReceiver('to_native', this, [dest, destlen]);
}

class SocketAddressEnumerator extends GObjectObject {
  SocketAddressEnumerator.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'SocketAddressEnumerator');

  SocketAddress next(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('next', this, [cancellable]);
  void nextAsync(Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('next_async', this, [cancellable, callback]);
  SocketAddress nextFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('next_finish', this, [result]);
}

class SocketClient extends GObjectObject {
  SocketClient.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'SocketClient');

  static const String ENABLE_PROXY_PROPERTY = 'enable-proxy';
  static const String FAMILY_PROPERTY = 'family';
  static const String LOCAL_ADDRESS_PROPERTY = 'local-address';
  static const String PROTOCOL_PROPERTY = 'protocol';
  static const String PROXY_RESOLVER_PROPERTY = 'proxy-resolver';
  static const String TIMEOUT_PROPERTY = 'timeout';
  static const String TLS_PROPERTY = 'tls';
  static const String TLS_VALIDATION_FLAGS_PROPERTY = 'tls-validation-flags';
  SocketType get type => _staticInfo.getGPropertyOnReceiver('type', this);
  void set type(SocketType value) => _staticInfo.setGPropertyOnReceiver('type', this, value);
  static const String TYPE_PROPERTY = 'type';
  factory SocketClient() => _staticInfo.callStatic('new', []);
  void addApplicationProxy(String protocol) => _staticInfo.callMethodOnReceiver('add_application_proxy', this, [protocol]);
  SocketConnection connect(SocketConnectable connectable, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('connect', this, [connectable, cancellable]);
  void connectAsync(SocketConnectable connectable, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('connect_async', this, [connectable, cancellable, callback]);
  SocketConnection connectFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('connect_finish', this, [result]);
  SocketConnection connectToHost(String hostAndPort, int defaultPort, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('connect_to_host', this, [hostAndPort, defaultPort, cancellable]);
  void connectToHostAsync(String hostAndPort, int defaultPort, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('connect_to_host_async', this, [hostAndPort, defaultPort, cancellable, callback]);
  SocketConnection connectToHostFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('connect_to_host_finish', this, [result]);
  SocketConnection connectToService(String domain, String service, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('connect_to_service', this, [domain, service, cancellable]);
  void connectToServiceAsync(String domain, String service, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('connect_to_service_async', this, [domain, service, cancellable, callback]);
  SocketConnection connectToServiceFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('connect_to_service_finish', this, [result]);
  SocketConnection connectToUri(String uri, int defaultPort, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('connect_to_uri', this, [uri, defaultPort, cancellable]);
  void connectToUriAsync(String uri, int defaultPort, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('connect_to_uri_async', this, [uri, defaultPort, cancellable, callback]);
  SocketConnection connectToUriFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('connect_to_uri_finish', this, [result]);
  bool get enableProxy => _staticInfo.callMethodOnReceiver('get_enable_proxy', this, []);
  SocketFamily get family => _staticInfo.callMethodOnReceiver('get_family', this, []);
  SocketAddress get localAddress => _staticInfo.callMethodOnReceiver('get_local_address', this, []);
  SocketProtocol get protocol => _staticInfo.callMethodOnReceiver('get_protocol', this, []);
  ProxyResolver get proxyResolver => _staticInfo.callMethodOnReceiver('get_proxy_resolver', this, []);
  SocketType get socketType => _staticInfo.callMethodOnReceiver('get_socket_type', this, []);
  int get timeout => _staticInfo.callMethodOnReceiver('get_timeout', this, []);
  bool get tls => _staticInfo.callMethodOnReceiver('get_tls', this, []);
  TlsCertificateFlags get tlsValidationFlags => _staticInfo.callMethodOnReceiver('get_tls_validation_flags', this, []);
  void set enableProxy(bool enable) => _staticInfo.callMethodOnReceiver('set_enable_proxy', this, [enable]);
  void set family(SocketFamily family) => _staticInfo.callMethodOnReceiver('set_family', this, [family]);
  void set localAddress(SocketAddress address) => _staticInfo.callMethodOnReceiver('set_local_address', this, [address]);
  void set protocol(SocketProtocol protocol) => _staticInfo.callMethodOnReceiver('set_protocol', this, [protocol]);
  void set proxyResolver(ProxyResolver proxyResolver) => _staticInfo.callMethodOnReceiver('set_proxy_resolver', this, [proxyResolver]);
  void set socketType(SocketType type) => _staticInfo.callMethodOnReceiver('set_socket_type', this, [type]);
  void set timeout(int timeout) => _staticInfo.callMethodOnReceiver('set_timeout', this, [timeout]);
  void set tls(bool tls) => _staticInfo.callMethodOnReceiver('set_tls', this, [tls]);
  void set tlsValidationFlags(TlsCertificateFlags flags) => _staticInfo.callMethodOnReceiver('set_tls_validation_flags', this, [flags]);
  int _connectToEvent(bool after, void func(SocketClientEvent event, SocketConnectable connectable, IOStream connection)) => signalConnect('event', func, after);
  Stream<SocketClientEventEvent> get onEvent {
    int signalId;
    StreamController<SocketClientEventEvent> controller;
    controller = new StreamController<SocketClientEventEvent>(
      onListen: () {
          signalId = _connectToEvent(false, (SocketClientEvent event, SocketConnectable connectable, IOStream connection) {
              var result = new SocketClientEventEvent(event, connectable, connection);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<SocketClientEventEvent> get afterEvent {
    int signalId;
    StreamController<SocketClientEventEvent> controller;
    controller = new StreamController<SocketClientEventEvent>(
      onListen: () {
          signalId = _connectToEvent(true, (SocketClientEvent event, SocketConnectable connectable, IOStream connection) {
              var result = new SocketClientEventEvent(event, connectable, connection);
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

class SocketClientEventEvent {
  final SocketClientEvent event;
  final SocketConnectable connectable;
  final IOStream connection;

  SocketClientEventEvent(this.event, this.connectable, this.connection);
}

class SocketClientEvent extends GEnumBase {
  const SocketClientEvent(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'SocketClientEvent');

  static const SocketClientEvent RESOLVING = const SocketClientEvent(0);
  static const SocketClientEvent RESOLVED = const SocketClientEvent(1);
  static const SocketClientEvent CONNECTING = const SocketClientEvent(2);
  static const SocketClientEvent CONNECTED = const SocketClientEvent(3);
  static const SocketClientEvent PROXY_NEGOTIATING = const SocketClientEvent(4);
  static const SocketClientEvent PROXY_NEGOTIATED = const SocketClientEvent(5);
  static const SocketClientEvent TLS_HANDSHAKING = const SocketClientEvent(6);
  static const SocketClientEvent TLS_HANDSHAKED = const SocketClientEvent(7);
  static const SocketClientEvent COMPLETE = const SocketClientEvent(8);
  String toString() {
    switch(index) {
      case 0: return 'SocketClientEvent.RESOLVING';
      case 1: return 'SocketClientEvent.RESOLVED';
      case 2: return 'SocketClientEvent.CONNECTING';
      case 3: return 'SocketClientEvent.CONNECTED';
      case 4: return 'SocketClientEvent.PROXY_NEGOTIATING';
      case 5: return 'SocketClientEvent.PROXY_NEGOTIATED';
      case 6: return 'SocketClientEvent.TLS_HANDSHAKING';
      case 7: return 'SocketClientEvent.TLS_HANDSHAKED';
      case 8: return 'SocketClientEvent.COMPLETE';
      default: return 'new SocketClientEvent($index)';
    }
  }
}

abstract class SocketConnectable extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'SocketConnectable');



  SocketAddressEnumerator enumerate() => _staticInfo.callMethodOnReceiver('enumerate', this, []);
  SocketAddressEnumerator proxyEnumerate() => _staticInfo.callMethodOnReceiver('proxy_enumerate', this, []);
}

class SocketConnection extends IOStream {
  SocketConnection.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'SocketConnection');

  void set socket(Socket value) => _staticInfo.setGPropertyOnReceiver('socket', this, value);
  static const String SOCKET_PROPERTY = 'socket';
  static int factoryLookupType(SocketFamily family, SocketType type, int protocolId) => _staticInfo.callStatic('factory_lookup_type', [family, type, protocolId]);
  static void factoryRegisterType(int gType, SocketFamily family, SocketType type, int protocol) => _staticInfo.callStatic('factory_register_type', [gType, family, type, protocol]);
  void connect(SocketAddress address, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('connect', this, [address, cancellable]);
  void connectAsync(SocketAddress address, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('connect_async', this, [address, cancellable, callback]);
  void connectFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('connect_finish', this, [result]);
  SocketAddress get localAddress => _staticInfo.callMethodOnReceiver('get_local_address', this, []);
  SocketAddress get remoteAddress => _staticInfo.callMethodOnReceiver('get_remote_address', this, []);
  Socket get socket_ => _staticInfo.callMethodOnReceiver('get_socket', this, []);
  bool isConnected() => _staticInfo.callMethodOnReceiver('is_connected', this, []);
}

class SocketControlMessage extends GObjectObject {
  SocketControlMessage.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'SocketControlMessage');

  static SocketControlMessage deserialize(int level, int type, List<int> data) => _staticInfo.callStatic('deserialize', [level, type, data]);
  int get level => _staticInfo.callMethodOnReceiver('get_level', this, []);
  int get msgType => _staticInfo.callMethodOnReceiver('get_msg_type', this, []);
  int get size => _staticInfo.callMethodOnReceiver('get_size', this, []);
  void serialize(dynamic data /* this will fail */) => _staticInfo.callMethodOnReceiver('serialize', this, [data]);
}

class SocketFamily extends GEnumBase {
  const SocketFamily(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'SocketFamily');

  static const SocketFamily INVALID = const SocketFamily(0);
  static const SocketFamily UNIX = const SocketFamily(1);
  static const SocketFamily IPV4 = const SocketFamily(2);
  static const SocketFamily IPV6 = const SocketFamily(10);
  String toString() {
    switch(index) {
      case 0: return 'SocketFamily.INVALID';
      case 1: return 'SocketFamily.UNIX';
      case 2: return 'SocketFamily.IPV4';
      case 10: return 'SocketFamily.IPV6';
      default: return 'new SocketFamily($index)';
    }
  }
}

class SocketListener extends GObjectObject {
  SocketListener.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'SocketListener');

  int get listenBacklog => _staticInfo.getGPropertyOnReceiver('listen-backlog', this);
  void set listenBacklog(int value) => _staticInfo.setGPropertyOnReceiver('listen-backlog', this, value);
  static const String LISTEN_BACKLOG_PROPERTY = 'listen-backlog';
  factory SocketListener() => _staticInfo.callStatic('new', []);
  List accept(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('accept', this, [cancellable]);
  void acceptAsync(Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('accept_async', this, [cancellable, callback]);
  List acceptFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('accept_finish', this, [result]);
  List acceptSocket(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('accept_socket', this, [cancellable]);
  void acceptSocketAsync(Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('accept_socket_async', this, [cancellable, callback]);
  List acceptSocketFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('accept_socket_finish', this, [result]);
  SocketAddress addAddress(SocketAddress address, SocketType type, SocketProtocol protocol, GObjectObject sourceObject) => _staticInfo.callMethodOnReceiver('add_address', this, [address, type, protocol, sourceObject]);
  int addAnyInetPort(GObjectObject sourceObject) => _staticInfo.callMethodOnReceiver('add_any_inet_port', this, [sourceObject]);
  void addInetPort(int port, GObjectObject sourceObject) => _staticInfo.callMethodOnReceiver('add_inet_port', this, [port, sourceObject]);
  void addSocket(Socket socket, GObjectObject sourceObject) => _staticInfo.callMethodOnReceiver('add_socket', this, [socket, sourceObject]);
  void close() => _staticInfo.callMethodOnReceiver('close', this, []);
  void setBacklog(int listenBacklog) => _staticInfo.callMethodOnReceiver('set_backlog', this, [listenBacklog]);
  int _connectToEvent(bool after, void func(SocketListenerEvent event, Socket socket)) => signalConnect('event', func, after);
  Stream<SocketListenerEventEvent> get onEvent {
    int signalId;
    StreamController<SocketListenerEventEvent> controller;
    controller = new StreamController<SocketListenerEventEvent>(
      onListen: () {
          signalId = _connectToEvent(false, (SocketListenerEvent event, Socket socket) {
              var result = new SocketListenerEventEvent(event, socket);
              controller.add(result);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<SocketListenerEventEvent> get afterEvent {
    int signalId;
    StreamController<SocketListenerEventEvent> controller;
    controller = new StreamController<SocketListenerEventEvent>(
      onListen: () {
          signalId = _connectToEvent(true, (SocketListenerEvent event, Socket socket) {
              var result = new SocketListenerEventEvent(event, socket);
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

class SocketListenerEventEvent {
  final SocketListenerEvent event;
  final Socket socket;

  SocketListenerEventEvent(this.event, this.socket);
}

class SocketListenerEvent extends GEnumBase {
  const SocketListenerEvent(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'SocketListenerEvent');

  static const SocketListenerEvent BINDING = const SocketListenerEvent(0);
  static const SocketListenerEvent BOUND = const SocketListenerEvent(1);
  static const SocketListenerEvent LISTENING = const SocketListenerEvent(2);
  static const SocketListenerEvent LISTENED = const SocketListenerEvent(3);
  String toString() {
    switch(index) {
      case 0: return 'SocketListenerEvent.BINDING';
      case 1: return 'SocketListenerEvent.BOUND';
      case 2: return 'SocketListenerEvent.LISTENING';
      case 3: return 'SocketListenerEvent.LISTENED';
      default: return 'new SocketListenerEvent($index)';
    }
  }
}

class SocketMsgFlags extends GEnumBase {
  const SocketMsgFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'SocketMsgFlags');

  static const SocketMsgFlags NONE = const SocketMsgFlags(0);
  bool get none => (index & 0) == 0;
  static const SocketMsgFlags OOB = const SocketMsgFlags(1);
  bool get oob => (index & 1) == 1;
  static const SocketMsgFlags PEEK = const SocketMsgFlags(2);
  bool get peek => (index & 2) == 2;
  static const SocketMsgFlags DONTROUTE = const SocketMsgFlags(4);
  bool get dontroute => (index & 4) == 4;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'SocketMsgFlags.OOB';
      case 2: return 'SocketMsgFlags.PEEK';
      case 4: return 'SocketMsgFlags.DONTROUTE';
      default: return 'new SocketMsgFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'SocketMsgFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 4; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  SocketMsgFlags operator|(SocketMsgFlags other) =>
    new SocketMsgFlags(index | other.index);
  SocketMsgFlags operator&(SocketMsgFlags other) =>
    new SocketMsgFlags(index & other.index);
}

class SocketProtocol extends GEnumBase {
  const SocketProtocol(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'SocketProtocol');

  static const SocketProtocol UNKNOWN = const SocketProtocol(-1);
  static const SocketProtocol DEFAULT = const SocketProtocol(0);
  static const SocketProtocol TCP = const SocketProtocol(6);
  static const SocketProtocol UDP = const SocketProtocol(17);
  static const SocketProtocol SCTP = const SocketProtocol(132);
  String toString() {
    switch(index) {
      case -1: return 'SocketProtocol.UNKNOWN';
      case 0: return 'SocketProtocol.DEFAULT';
      case 6: return 'SocketProtocol.TCP';
      case 17: return 'SocketProtocol.UDP';
      case 132: return 'SocketProtocol.SCTP';
      default: return 'new SocketProtocol($index)';
    }
  }
}

class SocketService extends SocketListener {
  SocketService.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'SocketService');

  bool get active => _staticInfo.getGPropertyOnReceiver('active', this);
  void set active(bool value) => _staticInfo.setGPropertyOnReceiver('active', this, value);
  static const String ACTIVE_PROPERTY = 'active';
  factory SocketService() => _staticInfo.callStatic('new', []);
  bool isActive() => _staticInfo.callMethodOnReceiver('is_active', this, []);
  void start() => _staticInfo.callMethodOnReceiver('start', this, []);
  void stop() => _staticInfo.callMethodOnReceiver('stop', this, []);
  int _connectToIncoming(bool after, bool func(SocketConnection connection, GObjectObject sourceObject)) => signalConnect('incoming', func, after);
  Stream<SocketServiceIncomingEvent> get onIncoming {
    int signalId;
    StreamController<SocketServiceIncomingEvent> controller;
    controller = new StreamController<SocketServiceIncomingEvent>(
      onListen: () {
          signalId = _connectToIncoming(false, (SocketConnection connection, GObjectObject sourceObject) {
              var result = new SocketServiceIncomingEvent(connection, sourceObject);
              controller.add(result);
              return result._cancelPropagation;
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<SocketServiceIncomingEvent> get afterIncoming {
    int signalId;
    StreamController<SocketServiceIncomingEvent> controller;
    controller = new StreamController<SocketServiceIncomingEvent>(
      onListen: () {
          signalId = _connectToIncoming(true, (SocketConnection connection, GObjectObject sourceObject) {
              var result = new SocketServiceIncomingEvent(connection, sourceObject);
              controller.add(result);
              return result._cancelPropagation;
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
}

class SocketServiceIncomingEvent {
  final SocketConnection connection;
  final GObjectObject sourceObject;
  bool _cancelPropagation = false;
  void cancelPropagation() {
    _cancelPropagation = true;
  }
  SocketServiceIncomingEvent(this.connection, this.sourceObject);
}

typedef bool SocketSourceFunc(Socket socket, IOCondition condition);
class SocketType extends GEnumBase {
  const SocketType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'SocketType');

  static const SocketType INVALID = const SocketType(0);
  static const SocketType STREAM = const SocketType(1);
  static const SocketType DATAGRAM = const SocketType(2);
  static const SocketType SEQPACKET = const SocketType(3);
  String toString() {
    switch(index) {
      case 0: return 'SocketType.INVALID';
      case 1: return 'SocketType.STREAM';
      case 2: return 'SocketType.DATAGRAM';
      case 3: return 'SocketType.SEQPACKET';
      default: return 'new SocketType($index)';
    }
  }
}

class SrvTarget extends GObjectBase {
  SrvTarget.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'SrvTarget');

  factory SrvTarget(String hostname, int port, int priority, int weight) => _staticInfo.callStatic('new', [hostname, port, priority, weight]);
  SrvTarget copy() => _staticInfo.callMethodOnReceiver('copy', this, []);
  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
  String get hostname => _staticInfo.callMethodOnReceiver('get_hostname', this, []);
  int get port => _staticInfo.callMethodOnReceiver('get_port', this, []);
  int get priority => _staticInfo.callMethodOnReceiver('get_priority', this, []);
  int get weight => _staticInfo.callMethodOnReceiver('get_weight', this, []);
}

class StaticResource extends GObjectBase {
  StaticResource.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'StaticResource');

  void fini() => _staticInfo.callMethodOnReceiver('fini', this, []);
  Resource get resource => _staticInfo.callMethodOnReceiver('get_resource', this, []);
  void init() => _staticInfo.callMethodOnReceiver('init', this, []);
  int get data => getFieldOfObject('data', 0);
  int get dataLen => getFieldOfObject('data_len', 1);
  StaticResource get next => getFieldOfObject('next', 3);
  dynamic /* this will fail */ get padding => getFieldOfObject('padding', 4);
}

class Subprocess extends GObjectObject with Initable {
  Subprocess.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'Subprocess');

  void set argv(List<String> value) => _staticInfo.setGPropertyOnReceiver('argv', this, value);
  static const String ARGV_PROPERTY = 'argv';
  void set flags(SubprocessFlags value) => _staticInfo.setGPropertyOnReceiver('flags', this, value);
  static const String FLAGS_PROPERTY = 'flags';
  factory Subprocess(List<String> argv, SubprocessFlags flags) => _staticInfo.callStatic('new', [argv, flags]);
  List communicate(Bytes stdinBuf, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('communicate', this, [stdinBuf, cancellable]);
  void communicateAsync(Bytes stdinBuf, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('communicate_async', this, [stdinBuf, cancellable, callback]);
  List communicateFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('communicate_finish', this, [result]);
  List communicateUtf8(String stdinBuf, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('communicate_utf8', this, [stdinBuf, cancellable]);
  void communicateUtf8Async(String stdinBuf, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('communicate_utf8_async', this, [stdinBuf, cancellable, callback]);
  List communicateUtf8Finish(AsyncResult result) => _staticInfo.callMethodOnReceiver('communicate_utf8_finish', this, [result]);
  void forceExit() => _staticInfo.callMethodOnReceiver('force_exit', this, []);
  int get exitStatus => _staticInfo.callMethodOnReceiver('get_exit_status', this, []);
  String get identifier => _staticInfo.callMethodOnReceiver('get_identifier', this, []);
  bool get ifExited => _staticInfo.callMethodOnReceiver('get_if_exited', this, []);
  bool get ifSignaled => _staticInfo.callMethodOnReceiver('get_if_signaled', this, []);
  int get status => _staticInfo.callMethodOnReceiver('get_status', this, []);
  InputStream get stderrPipe => _staticInfo.callMethodOnReceiver('get_stderr_pipe', this, []);
  OutputStream get stdinPipe => _staticInfo.callMethodOnReceiver('get_stdin_pipe', this, []);
  InputStream get stdoutPipe => _staticInfo.callMethodOnReceiver('get_stdout_pipe', this, []);
  bool get successful => _staticInfo.callMethodOnReceiver('get_successful', this, []);
  int get termSig => _staticInfo.callMethodOnReceiver('get_term_sig', this, []);
  void sendSignal(int signalNum) => _staticInfo.callMethodOnReceiver('send_signal', this, [signalNum]);
  void wait(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('wait', this, [cancellable]);
  void waitAsync(Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('wait_async', this, [cancellable, callback]);
  void waitCheck(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('wait_check', this, [cancellable]);
  void waitCheckAsync(Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('wait_check_async', this, [cancellable, callback]);
  void waitCheckFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('wait_check_finish', this, [result]);
  void waitFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('wait_finish', this, [result]);
}

class SubprocessFlags extends GEnumBase {
  const SubprocessFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'SubprocessFlags');

  static const SubprocessFlags NONE = const SubprocessFlags(0);
  bool get none => (index & 0) == 0;
  static const SubprocessFlags STDIN_PIPE = const SubprocessFlags(1);
  bool get stdinPipe => (index & 1) == 1;
  static const SubprocessFlags STDIN_INHERIT = const SubprocessFlags(2);
  bool get stdinInherit => (index & 2) == 2;
  static const SubprocessFlags STDOUT_PIPE = const SubprocessFlags(4);
  bool get stdoutPipe => (index & 4) == 4;
  static const SubprocessFlags STDOUT_SILENCE = const SubprocessFlags(8);
  bool get stdoutSilence => (index & 8) == 8;
  static const SubprocessFlags STDERR_PIPE = const SubprocessFlags(16);
  bool get stderrPipe => (index & 16) == 16;
  static const SubprocessFlags STDERR_SILENCE = const SubprocessFlags(32);
  bool get stderrSilence => (index & 32) == 32;
  static const SubprocessFlags STDERR_MERGE = const SubprocessFlags(64);
  bool get stderrMerge => (index & 64) == 64;
  static const SubprocessFlags INHERIT_FDS = const SubprocessFlags(128);
  bool get inheritFds => (index & 128) == 128;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'SubprocessFlags.STDIN_PIPE';
      case 2: return 'SubprocessFlags.STDIN_INHERIT';
      case 4: return 'SubprocessFlags.STDOUT_PIPE';
      case 8: return 'SubprocessFlags.STDOUT_SILENCE';
      case 16: return 'SubprocessFlags.STDERR_PIPE';
      case 32: return 'SubprocessFlags.STDERR_SILENCE';
      case 64: return 'SubprocessFlags.STDERR_MERGE';
      case 128: return 'SubprocessFlags.INHERIT_FDS';
      default: return 'new SubprocessFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'SubprocessFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 128; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  SubprocessFlags operator|(SubprocessFlags other) =>
    new SubprocessFlags(index | other.index);
  SubprocessFlags operator&(SubprocessFlags other) =>
    new SubprocessFlags(index & other.index);
}

class SubprocessLauncher extends GObjectObject {
  SubprocessLauncher.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'SubprocessLauncher');

  static const String FLAGS_PROPERTY = 'flags';
  factory SubprocessLauncher(SubprocessFlags flags) => _staticInfo.callStatic('new', [flags]);
  String getenv(String variable) => _staticInfo.callMethodOnReceiver('getenv', this, [variable]);
  void setChildSetup(SpawnChildSetupFunc childSetup) => _staticInfo.callMethodOnReceiver('set_child_setup', this, [childSetup]);
  void setCwd(String cwd) => _staticInfo.callMethodOnReceiver('set_cwd', this, [cwd]);
  void setEnviron(String env) => _staticInfo.callMethodOnReceiver('set_environ', this, [env]);
  void set flags(SubprocessFlags flags) => _staticInfo.callMethodOnReceiver('set_flags', this, [flags]);
  void setStderrFilePath(String path) => _staticInfo.callMethodOnReceiver('set_stderr_file_path', this, [path]);
  void setStdinFilePath(String path) => _staticInfo.callMethodOnReceiver('set_stdin_file_path', this, [path]);
  void setStdoutFilePath(String path) => _staticInfo.callMethodOnReceiver('set_stdout_file_path', this, [path]);
  void setenv(String variable, String value, bool overwrite) => _staticInfo.callMethodOnReceiver('setenv', this, [variable, value, overwrite]);
  Subprocess spawnv(List<String> argv) => _staticInfo.callMethodOnReceiver('spawnv', this, [argv]);
  void takeFd(int sourceFd, int targetFd) => _staticInfo.callMethodOnReceiver('take_fd', this, [sourceFd, targetFd]);
  void takeStderrFd(int fd) => _staticInfo.callMethodOnReceiver('take_stderr_fd', this, [fd]);
  void takeStdinFd(int fd) => _staticInfo.callMethodOnReceiver('take_stdin_fd', this, [fd]);
  void takeStdoutFd(int fd) => _staticInfo.callMethodOnReceiver('take_stdout_fd', this, [fd]);
  void unsetenv(String variable) => _staticInfo.callMethodOnReceiver('unsetenv', this, [variable]);
}

class Task extends GObjectObject with AsyncResult {
  Task.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'Task');

  static const String COMPLETED_PROPERTY = 'completed';
  factory Task(GObjectObject sourceObject, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callStatic('new', [sourceObject, cancellable, callback]);
  static bool isValid(AsyncResult result, GObjectObject sourceObject) => _staticInfo.callStatic('is_valid', [result, sourceObject]);
  static void reportError(GObjectObject sourceObject, AsyncReadyCallback callback, dynamic sourceTag /* this will fail */, GErrorBase error) => _staticInfo.callStatic('report_error', [sourceObject, callback, sourceTag, error]);
  Cancellable get cancellable => _staticInfo.callMethodOnReceiver('get_cancellable', this, []);
  bool get checkCancellable => _staticInfo.callMethodOnReceiver('get_check_cancellable', this, []);
  bool get completed => _staticInfo.callMethodOnReceiver('get_completed', this, []);
  MainContext get context => _staticInfo.callMethodOnReceiver('get_context', this, []);
  int get priority => _staticInfo.callMethodOnReceiver('get_priority', this, []);
  bool get returnOnCancel => _staticInfo.callMethodOnReceiver('get_return_on_cancel', this, []);
  GObjectObject get sourceObject => _staticInfo.callMethodOnReceiver('get_source_object', this, []);
  void getSourceTag() => _staticInfo.callMethodOnReceiver('get_source_tag', this, []);
  void getTaskData() => _staticInfo.callMethodOnReceiver('get_task_data', this, []);
  bool hadError() => _staticInfo.callMethodOnReceiver('had_error', this, []);
  void propagateBoolean() => _staticInfo.callMethodOnReceiver('propagate_boolean', this, []);
  int propagateInt() => _staticInfo.callMethodOnReceiver('propagate_int', this, []);
  void propagatePointer() => _staticInfo.callMethodOnReceiver('propagate_pointer', this, []);
  void returnBoolean(bool result) => _staticInfo.callMethodOnReceiver('return_boolean', this, [result]);
  void returnError(GErrorBase error) => _staticInfo.callMethodOnReceiver('return_error', this, [error]);
  bool returnErrorIfCancelled() => _staticInfo.callMethodOnReceiver('return_error_if_cancelled', this, []);
  void returnInt(int result) => _staticInfo.callMethodOnReceiver('return_int', this, [result]);
  void returnPointer(dynamic result /* this will fail */, DestroyNotify resultDestroy) => _staticInfo.callMethodOnReceiver('return_pointer', this, [result, resultDestroy]);
  void set checkCancellable(bool checkCancellable) => _staticInfo.callMethodOnReceiver('set_check_cancellable', this, [checkCancellable]);
  void set priority(int priority) => _staticInfo.callMethodOnReceiver('set_priority', this, [priority]);
  bool setReturnOnCancel(bool returnOnCancel) => _staticInfo.callMethodOnReceiver('set_return_on_cancel', this, [returnOnCancel]);
  void setSourceTag(dynamic sourceTag /* this will fail */) => _staticInfo.callMethodOnReceiver('set_source_tag', this, [sourceTag]);
  void setTaskData(dynamic taskData /* this will fail */, DestroyNotify taskDataDestroy) => _staticInfo.callMethodOnReceiver('set_task_data', this, [taskData, taskDataDestroy]);
}

typedef void TaskThreadFunc(Task task, GObjectObject sourceObject, dynamic taskData /* this will fail */, Cancellable cancellable);
class TcpConnection extends SocketConnection {
  TcpConnection.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'TcpConnection');

  static const String GRACEFUL_DISCONNECT_PROPERTY = 'graceful-disconnect';
  bool get gracefulDisconnect => _staticInfo.callMethodOnReceiver('get_graceful_disconnect', this, []);
  void set gracefulDisconnect(bool gracefulDisconnect) => _staticInfo.callMethodOnReceiver('set_graceful_disconnect', this, [gracefulDisconnect]);
}

class TcpWrapperConnection extends TcpConnection {
  TcpWrapperConnection.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'TcpWrapperConnection');

  void set baseIoStream(IOStream value) => _staticInfo.setGPropertyOnReceiver('base-io-stream', this, value);
  static const String BASE_IO_STREAM_PROPERTY = 'base-io-stream';
  factory TcpWrapperConnection(IOStream baseIoStream, Socket socket) => _staticInfo.callStatic('new', [baseIoStream, socket]);
  IOStream get baseIoStream_ => _staticInfo.callMethodOnReceiver('get_base_io_stream', this, []);
}

class TestDBus extends GObjectObject {
  TestDBus.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'TestDBus');

  void set flags(TestDBusFlags value) => _staticInfo.setGPropertyOnReceiver('flags', this, value);
  static const String FLAGS_PROPERTY = 'flags';
  factory TestDBus(TestDBusFlags flags) => _staticInfo.callStatic('new', [flags]);
  static void unset() => _staticInfo.callStatic('unset', []);
  void addServiceDir(String path) => _staticInfo.callMethodOnReceiver('add_service_dir', this, [path]);
  void down() => _staticInfo.callMethodOnReceiver('down', this, []);
  String get busAddress => _staticInfo.callMethodOnReceiver('get_bus_address', this, []);
  TestDBusFlags get flags_ => _staticInfo.callMethodOnReceiver('get_flags', this, []);
  void stop() => _staticInfo.callMethodOnReceiver('stop', this, []);
  void up() => _staticInfo.callMethodOnReceiver('up', this, []);
}

class TestDBusFlags extends GEnumBase {
  const TestDBusFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'TestDBusFlags');

  static const TestDBusFlags NONE = const TestDBusFlags(0);
  bool get none => (index & 0) == 0;
  static _valueToString(int value) {
    switch(value) {
      default: return 'new TestDBusFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'TestDBusFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 0; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  TestDBusFlags operator|(TestDBusFlags other) =>
    new TestDBusFlags(index | other.index);
  TestDBusFlags operator&(TestDBusFlags other) =>
    new TestDBusFlags(index & other.index);
}

class ThemedIcon extends GObjectObject with Icon {
  ThemedIcon.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'ThemedIcon');

  void set name(String value) => _staticInfo.setGPropertyOnReceiver('name', this, value);
  static const String NAME_PROPERTY = 'name';
  void set names(List<String> value) => _staticInfo.setGPropertyOnReceiver('names', this, value);
  static const String NAMES_PROPERTY = 'names';
  bool get useDefaultFallbacks => _staticInfo.getGPropertyOnReceiver('use-default-fallbacks', this);
  void set useDefaultFallbacks(bool value) => _staticInfo.setGPropertyOnReceiver('use-default-fallbacks', this, value);
  static const String USE_DEFAULT_FALLBACKS_PROPERTY = 'use-default-fallbacks';
  factory ThemedIcon(String iconname) => _staticInfo.callStatic('new', [iconname]);
  factory ThemedIcon.fromNames(List<String> iconnames) => _staticInfo.callStatic('new_from_names', [iconnames]);
  factory ThemedIcon.withDefaultFallbacks(String iconname) => _staticInfo.callStatic('new_with_default_fallbacks', [iconname]);
  void appendName(String iconname) => _staticInfo.callMethodOnReceiver('append_name', this, [iconname]);
  List<String> get names_ => _staticInfo.callMethodOnReceiver('get_names', this, []);
  void prependName(String iconname) => _staticInfo.callMethodOnReceiver('prepend_name', this, [iconname]);
}

class ThreadedSocketService extends SocketService {
  ThreadedSocketService.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'ThreadedSocketService');

  int get maxThreads => _staticInfo.getGPropertyOnReceiver('max-threads', this);
  void set maxThreads(int value) => _staticInfo.setGPropertyOnReceiver('max-threads', this, value);
  static const String MAX_THREADS_PROPERTY = 'max-threads';
  factory ThreadedSocketService(int maxThreads) => _staticInfo.callStatic('new', [maxThreads]);
  int _connectToRun(bool after, bool func(SocketConnection connection, GObjectObject sourceObject)) => signalConnect('run', func, after);
  Stream<ThreadedSocketServiceRunEvent> get onRun {
    int signalId;
    StreamController<ThreadedSocketServiceRunEvent> controller;
    controller = new StreamController<ThreadedSocketServiceRunEvent>(
      onListen: () {
          signalId = _connectToRun(false, (SocketConnection connection, GObjectObject sourceObject) {
              var result = new ThreadedSocketServiceRunEvent(connection, sourceObject);
              controller.add(result);
              return result._cancelPropagation;
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<ThreadedSocketServiceRunEvent> get afterRun {
    int signalId;
    StreamController<ThreadedSocketServiceRunEvent> controller;
    controller = new StreamController<ThreadedSocketServiceRunEvent>(
      onListen: () {
          signalId = _connectToRun(true, (SocketConnection connection, GObjectObject sourceObject) {
              var result = new ThreadedSocketServiceRunEvent(connection, sourceObject);
              controller.add(result);
              return result._cancelPropagation;
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
}

class ThreadedSocketServiceRunEvent {
  final SocketConnection connection;
  final GObjectObject sourceObject;
  bool _cancelPropagation = false;
  void cancelPropagation() {
    _cancelPropagation = true;
  }
  ThreadedSocketServiceRunEvent(this.connection, this.sourceObject);
}

class TlsAuthenticationMode extends GEnumBase {
  const TlsAuthenticationMode(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'TlsAuthenticationMode');

  static const TlsAuthenticationMode NONE = const TlsAuthenticationMode(0);
  static const TlsAuthenticationMode REQUESTED = const TlsAuthenticationMode(1);
  static const TlsAuthenticationMode REQUIRED = const TlsAuthenticationMode(2);
  String toString() {
    switch(index) {
      case 0: return 'TlsAuthenticationMode.NONE';
      case 1: return 'TlsAuthenticationMode.REQUESTED';
      case 2: return 'TlsAuthenticationMode.REQUIRED';
      default: return 'new TlsAuthenticationMode($index)';
    }
  }
}

abstract class TlsBackend extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'TlsBackend');



  static TlsBackend getDefault() => _staticInfo.callStatic('get_default', []);
  int get certificateType => _staticInfo.callMethodOnReceiver('get_certificate_type', this, []);
  int get clientConnectionType => _staticInfo.callMethodOnReceiver('get_client_connection_type', this, []);
  TlsDatabase get defaultDatabase => _staticInfo.callMethodOnReceiver('get_default_database', this, []);
  int get fileDatabaseType => _staticInfo.callMethodOnReceiver('get_file_database_type', this, []);
  int get serverConnectionType => _staticInfo.callMethodOnReceiver('get_server_connection_type', this, []);
  bool supportsTls() => _staticInfo.callMethodOnReceiver('supports_tls', this, []);
}

class TlsCertificate extends GObjectObject {
  TlsCertificate.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'TlsCertificate');

  List<dynamic /* this will fail */> get certificate => _staticInfo.getGPropertyOnReceiver('certificate', this);
  void set certificate(List<dynamic /* this will fail */> value) => _staticInfo.setGPropertyOnReceiver('certificate', this, value);
  static const String CERTIFICATE_PROPERTY = 'certificate';
  String get certificatePem => _staticInfo.getGPropertyOnReceiver('certificate-pem', this);
  void set certificatePem(String value) => _staticInfo.setGPropertyOnReceiver('certificate-pem', this, value);
  static const String CERTIFICATE_PEM_PROPERTY = 'certificate-pem';
  void set issuer(TlsCertificate value) => _staticInfo.setGPropertyOnReceiver('issuer', this, value);
  static const String ISSUER_PROPERTY = 'issuer';
  void set privateKey(List<dynamic /* this will fail */> value) => _staticInfo.setGPropertyOnReceiver('private-key', this, value);
  static const String PRIVATE_KEY_PROPERTY = 'private-key';
  void set privateKeyPem(String value) => _staticInfo.setGPropertyOnReceiver('private-key-pem', this, value);
  static const String PRIVATE_KEY_PEM_PROPERTY = 'private-key-pem';
  factory TlsCertificate.fromFile(String file) => _staticInfo.callStatic('new_from_file', [file]);
  factory TlsCertificate.fromFiles(String certFile, String keyFile) => _staticInfo.callStatic('new_from_files', [certFile, keyFile]);
  factory TlsCertificate.fromPem(String data, int length) => _staticInfo.callStatic('new_from_pem', [data, length]);
  static GLibList /* this will fail */ listNewFromFile(String file) => _staticInfo.callStatic('list_new_from_file', [file]);
  TlsCertificate get issuer_ => _staticInfo.callMethodOnReceiver('get_issuer', this, []);
  bool isSame(TlsCertificate certTwo) => _staticInfo.callMethodOnReceiver('is_same', this, [certTwo]);
  TlsCertificateFlags verify(SocketConnectable identity, TlsCertificate trustedCa) => _staticInfo.callMethodOnReceiver('verify', this, [identity, trustedCa]);
}

class TlsCertificateFlags extends GEnumBase {
  const TlsCertificateFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'TlsCertificateFlags');

  static const TlsCertificateFlags NULL = const TlsCertificateFlags(0);
  static const TlsCertificateFlags UNKNOWN_CA = const TlsCertificateFlags(1);
  bool get unknownCa => (index & 1) == 1;
  static const TlsCertificateFlags BAD_IDENTITY = const TlsCertificateFlags(2);
  bool get badIdentity => (index & 2) == 2;
  static const TlsCertificateFlags NOT_ACTIVATED = const TlsCertificateFlags(4);
  bool get notActivated => (index & 4) == 4;
  static const TlsCertificateFlags EXPIRED = const TlsCertificateFlags(8);
  bool get expired => (index & 8) == 8;
  static const TlsCertificateFlags REVOKED = const TlsCertificateFlags(16);
  bool get revoked => (index & 16) == 16;
  static const TlsCertificateFlags INSECURE = const TlsCertificateFlags(32);
  bool get insecure => (index & 32) == 32;
  static const TlsCertificateFlags GENERIC_ERROR = const TlsCertificateFlags(64);
  bool get genericError => (index & 64) == 64;
  static const TlsCertificateFlags VALIDATE_ALL = const TlsCertificateFlags(127);
  bool get validateAll => (index & 127) == 127;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'TlsCertificateFlags.UNKNOWN_CA';
      case 2: return 'TlsCertificateFlags.BAD_IDENTITY';
      case 4: return 'TlsCertificateFlags.NOT_ACTIVATED';
      case 8: return 'TlsCertificateFlags.EXPIRED';
      case 16: return 'TlsCertificateFlags.REVOKED';
      case 32: return 'TlsCertificateFlags.INSECURE';
      case 64: return 'TlsCertificateFlags.GENERIC_ERROR';
      default: return 'new TlsCertificateFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'TlsCertificateFlags.NULL';
    }
    List codes = [];
    for (var i=1; i <= 64; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  TlsCertificateFlags operator|(TlsCertificateFlags other) =>
    new TlsCertificateFlags(index | other.index);
  TlsCertificateFlags operator&(TlsCertificateFlags other) =>
    new TlsCertificateFlags(index & other.index);
}

class TlsCertificateRequestFlags extends GEnumBase {
  const TlsCertificateRequestFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'TlsCertificateRequestFlags');

  static const TlsCertificateRequestFlags NONE = const TlsCertificateRequestFlags(0);
  String toString() {
    switch(index) {
      case 0: return 'TlsCertificateRequestFlags.NONE';
      default: return 'new TlsCertificateRequestFlags($index)';
    }
  }
}

abstract class TlsClientConnection extends GObjectBase implements TlsConnection {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'TlsClientConnection');



  static const String ACCEPTED_CAS_PROPERTY = 'accepted-cas';
  static const String SERVER_IDENTITY_PROPERTY = 'server-identity';
  static const String USE_SSL3_PROPERTY = 'use-ssl3';
  static const String VALIDATION_FLAGS_PROPERTY = 'validation-flags';
  static TlsClientConnection new_(IOStream baseIoStream, SocketConnectable serverIdentity) => _staticInfo.callStatic('new', [baseIoStream, serverIdentity]);
  void copySessionState(TlsClientConnection source) => _staticInfo.callMethodOnReceiver('copy_session_state', this, [source]);
  GLibList /* this will fail */ get acceptedCas => _staticInfo.callMethodOnReceiver('get_accepted_cas', this, []);
  SocketConnectable get serverIdentity => _staticInfo.callMethodOnReceiver('get_server_identity', this, []);
  bool get useSsl3 => _staticInfo.callMethodOnReceiver('get_use_ssl3', this, []);
  TlsCertificateFlags get validationFlags => _staticInfo.callMethodOnReceiver('get_validation_flags', this, []);
  void set serverIdentity(SocketConnectable identity) => _staticInfo.callMethodOnReceiver('set_server_identity', this, [identity]);
  void set useSsl3(bool useSsl3) => _staticInfo.callMethodOnReceiver('set_use_ssl3', this, [useSsl3]);
  void set validationFlags(TlsCertificateFlags flags) => _staticInfo.callMethodOnReceiver('set_validation_flags', this, [flags]);
}

class TlsConnection extends IOStream {
  TlsConnection.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'TlsConnection');

  IOStream get baseIoStream => _staticInfo.getGPropertyOnReceiver('base-io-stream', this);
  void set baseIoStream(IOStream value) => _staticInfo.setGPropertyOnReceiver('base-io-stream', this, value);
  static const String BASE_IO_STREAM_PROPERTY = 'base-io-stream';
  static const String CERTIFICATE_PROPERTY = 'certificate';
  static const String DATABASE_PROPERTY = 'database';
  static const String INTERACTION_PROPERTY = 'interaction';
  static const String PEER_CERTIFICATE_PROPERTY = 'peer-certificate';
  static const String PEER_CERTIFICATE_ERRORS_PROPERTY = 'peer-certificate-errors';
  static const String REHANDSHAKE_MODE_PROPERTY = 'rehandshake-mode';
  static const String REQUIRE_CLOSE_NOTIFY_PROPERTY = 'require-close-notify';
  static const String USE_SYSTEM_CERTDB_PROPERTY = 'use-system-certdb';
  bool emitAcceptCertificate(TlsCertificate peerCert, TlsCertificateFlags errors) => _staticInfo.callMethodOnReceiver('emit_accept_certificate', this, [peerCert, errors]);
  TlsCertificate get certificate => _staticInfo.callMethodOnReceiver('get_certificate', this, []);
  TlsDatabase get database => _staticInfo.callMethodOnReceiver('get_database', this, []);
  TlsInteraction get interaction => _staticInfo.callMethodOnReceiver('get_interaction', this, []);
  TlsCertificate get peerCertificate => _staticInfo.callMethodOnReceiver('get_peer_certificate', this, []);
  TlsCertificateFlags get peerCertificateErrors => _staticInfo.callMethodOnReceiver('get_peer_certificate_errors', this, []);
  TlsRehandshakeMode get rehandshakeMode => _staticInfo.callMethodOnReceiver('get_rehandshake_mode', this, []);
  bool get requireCloseNotify => _staticInfo.callMethodOnReceiver('get_require_close_notify', this, []);
  bool get useSystemCertdb => _staticInfo.callMethodOnReceiver('get_use_system_certdb', this, []);
  void handshake(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('handshake', this, [cancellable]);
  void handshakeAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('handshake_async', this, [ioPriority, cancellable, callback]);
  void handshakeFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('handshake_finish', this, [result]);
  void set certificate(TlsCertificate certificate) => _staticInfo.callMethodOnReceiver('set_certificate', this, [certificate]);
  void set database(TlsDatabase database) => _staticInfo.callMethodOnReceiver('set_database', this, [database]);
  void set interaction(TlsInteraction interaction) => _staticInfo.callMethodOnReceiver('set_interaction', this, [interaction]);
  void set rehandshakeMode(TlsRehandshakeMode mode) => _staticInfo.callMethodOnReceiver('set_rehandshake_mode', this, [mode]);
  void set requireCloseNotify(bool requireCloseNotify) => _staticInfo.callMethodOnReceiver('set_require_close_notify', this, [requireCloseNotify]);
  void set useSystemCertdb(bool useSystemCertdb) => _staticInfo.callMethodOnReceiver('set_use_system_certdb', this, [useSystemCertdb]);
  int _connectToAcceptCertificate(bool after, bool func(TlsCertificate peerCert, TlsCertificateFlags errors)) => signalConnect('accept-certificate', func, after);
  Stream<TlsConnectionAcceptCertificateEvent> get onAcceptCertificate {
    int signalId;
    StreamController<TlsConnectionAcceptCertificateEvent> controller;
    controller = new StreamController<TlsConnectionAcceptCertificateEvent>(
      onListen: () {
          signalId = _connectToAcceptCertificate(false, (TlsCertificate peerCert, TlsCertificateFlags errors) {
              var result = new TlsConnectionAcceptCertificateEvent(peerCert, errors);
              controller.add(result);
              return result._cancelPropagation;
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<TlsConnectionAcceptCertificateEvent> get afterAcceptCertificate {
    int signalId;
    StreamController<TlsConnectionAcceptCertificateEvent> controller;
    controller = new StreamController<TlsConnectionAcceptCertificateEvent>(
      onListen: () {
          signalId = _connectToAcceptCertificate(true, (TlsCertificate peerCert, TlsCertificateFlags errors) {
              var result = new TlsConnectionAcceptCertificateEvent(peerCert, errors);
              controller.add(result);
              return result._cancelPropagation;
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
}

class TlsConnectionAcceptCertificateEvent {
  final TlsCertificate peerCert;
  final TlsCertificateFlags errors;
  bool _cancelPropagation = false;
  void cancelPropagation() {
    _cancelPropagation = true;
  }
  TlsConnectionAcceptCertificateEvent(this.peerCert, this.errors);
}

class TlsDatabase extends GObjectObject {
  TlsDatabase.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'TlsDatabase');

  String createCertificateHandle(TlsCertificate certificate) => _staticInfo.callMethodOnReceiver('create_certificate_handle', this, [certificate]);
  TlsCertificate lookupCertificateForHandle(String handle, TlsInteraction interaction, TlsDatabaseLookupFlags flags, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('lookup_certificate_for_handle', this, [handle, interaction, flags, cancellable]);
  void lookupCertificateForHandleAsync(String handle, TlsInteraction interaction, TlsDatabaseLookupFlags flags, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('lookup_certificate_for_handle_async', this, [handle, interaction, flags, cancellable, callback]);
  TlsCertificate lookupCertificateForHandleFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('lookup_certificate_for_handle_finish', this, [result]);
  TlsCertificate lookupCertificateIssuer(TlsCertificate certificate, TlsInteraction interaction, TlsDatabaseLookupFlags flags, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('lookup_certificate_issuer', this, [certificate, interaction, flags, cancellable]);
  void lookupCertificateIssuerAsync(TlsCertificate certificate, TlsInteraction interaction, TlsDatabaseLookupFlags flags, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('lookup_certificate_issuer_async', this, [certificate, interaction, flags, cancellable, callback]);
  TlsCertificate lookupCertificateIssuerFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('lookup_certificate_issuer_finish', this, [result]);
  GLibList /* this will fail */ lookupCertificatesIssuedBy(List<dynamic /* this will fail */> issuerRawDn, TlsInteraction interaction, TlsDatabaseLookupFlags flags, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('lookup_certificates_issued_by', this, [issuerRawDn, interaction, flags, cancellable]);
  void lookupCertificatesIssuedByAsync(List<dynamic /* this will fail */> issuerRawDn, TlsInteraction interaction, TlsDatabaseLookupFlags flags, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('lookup_certificates_issued_by_async', this, [issuerRawDn, interaction, flags, cancellable, callback]);
  GLibList /* this will fail */ lookupCertificatesIssuedByFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('lookup_certificates_issued_by_finish', this, [result]);
  TlsCertificateFlags verifyChain(TlsCertificate chain, String purpose, SocketConnectable identity, TlsInteraction interaction, TlsDatabaseVerifyFlags flags, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('verify_chain', this, [chain, purpose, identity, interaction, flags, cancellable]);
  void verifyChainAsync(TlsCertificate chain, String purpose, SocketConnectable identity, TlsInteraction interaction, TlsDatabaseVerifyFlags flags, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('verify_chain_async', this, [chain, purpose, identity, interaction, flags, cancellable, callback]);
  TlsCertificateFlags verifyChainFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('verify_chain_finish', this, [result]);
}

class TlsDatabaseLookupFlags extends GEnumBase {
  const TlsDatabaseLookupFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'TlsDatabaseLookupFlags');

  static const TlsDatabaseLookupFlags NONE = const TlsDatabaseLookupFlags(0);
  static const TlsDatabaseLookupFlags KEYPAIR = const TlsDatabaseLookupFlags(1);
  String toString() {
    switch(index) {
      case 0: return 'TlsDatabaseLookupFlags.NONE';
      case 1: return 'TlsDatabaseLookupFlags.KEYPAIR';
      default: return 'new TlsDatabaseLookupFlags($index)';
    }
  }
}

class TlsDatabaseVerifyFlags extends GEnumBase {
  const TlsDatabaseVerifyFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'TlsDatabaseVerifyFlags');

  static const TlsDatabaseVerifyFlags NONE = const TlsDatabaseVerifyFlags(0);
  bool get none => (index & 0) == 0;
  static _valueToString(int value) {
    switch(value) {
      default: return 'new TlsDatabaseVerifyFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'TlsDatabaseVerifyFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 0; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  TlsDatabaseVerifyFlags operator|(TlsDatabaseVerifyFlags other) =>
    new TlsDatabaseVerifyFlags(index | other.index);
  TlsDatabaseVerifyFlags operator&(TlsDatabaseVerifyFlags other) =>
    new TlsDatabaseVerifyFlags(index & other.index);
}

class TlsErrorCode extends GEnumBase {
  const TlsErrorCode(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'TlsError');

  static const TlsErrorCode UNAVAILABLE = const TlsErrorCode(0);
  static const TlsErrorCode MISC = const TlsErrorCode(1);
  static const TlsErrorCode BAD_CERTIFICATE = const TlsErrorCode(2);
  static const TlsErrorCode NOT_TLS = const TlsErrorCode(3);
  static const TlsErrorCode HANDSHAKE = const TlsErrorCode(4);
  static const TlsErrorCode CERTIFICATE_REQUIRED = const TlsErrorCode(5);
  static const TlsErrorCode EOF = const TlsErrorCode(6);
  String toString() {
    switch(index) {
      case 0: return 'TlsErrorCode.UNAVAILABLE';
      case 1: return 'TlsErrorCode.MISC';
      case 2: return 'TlsErrorCode.BAD_CERTIFICATE';
      case 3: return 'TlsErrorCode.NOT_TLS';
      case 4: return 'TlsErrorCode.HANDSHAKE';
      case 5: return 'TlsErrorCode.CERTIFICATE_REQUIRED';
      case 6: return 'TlsErrorCode.EOF';
      default: return 'new TlsErrorCode($index)';
    }
  }
  static int quark() => _staticInfo.callStatic('quark', []);
}

class TlsError extends GErrorBase {
  static final int _quark = lookupErrorQuarkFromString('g-tls-error-quark');
  TlsError(TlsErrorCode code, String message)
      : super.fromFields(_quark, code, message);
}

abstract class TlsFileDatabase extends GObjectBase implements TlsDatabase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'TlsFileDatabase');



  String get anchors => _staticInfo.getGPropertyOnReceiver('anchors', this);
  void set anchors(String value) => _staticInfo.setGPropertyOnReceiver('anchors', this, value);
  static const String ANCHORS_PROPERTY = 'anchors';
  static TlsFileDatabase new_(String anchors) => _staticInfo.callStatic('new', [anchors]);
}

class TlsInteraction extends GObjectObject {
  TlsInteraction.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'TlsInteraction');

  TlsInteractionResult askPassword(TlsPassword password, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('ask_password', this, [password, cancellable]);
  void askPasswordAsync(TlsPassword password, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('ask_password_async', this, [password, cancellable, callback]);
  TlsInteractionResult askPasswordFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('ask_password_finish', this, [result]);
  TlsInteractionResult invokeAskPassword(TlsPassword password, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('invoke_ask_password', this, [password, cancellable]);
  TlsInteractionResult invokeRequestCertificate(TlsConnection connection, TlsCertificateRequestFlags flags, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('invoke_request_certificate', this, [connection, flags, cancellable]);
  TlsInteractionResult requestCertificate(TlsConnection connection, TlsCertificateRequestFlags flags, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('request_certificate', this, [connection, flags, cancellable]);
  void requestCertificateAsync(TlsConnection connection, TlsCertificateRequestFlags flags, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('request_certificate_async', this, [connection, flags, cancellable, callback]);
  TlsInteractionResult requestCertificateFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('request_certificate_finish', this, [result]);
}

class TlsInteractionResult extends GEnumBase {
  const TlsInteractionResult(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'TlsInteractionResult');

  static const TlsInteractionResult UNHANDLED = const TlsInteractionResult(0);
  static const TlsInteractionResult HANDLED = const TlsInteractionResult(1);
  static const TlsInteractionResult FAILED = const TlsInteractionResult(2);
  String toString() {
    switch(index) {
      case 0: return 'TlsInteractionResult.UNHANDLED';
      case 1: return 'TlsInteractionResult.HANDLED';
      case 2: return 'TlsInteractionResult.FAILED';
      default: return 'new TlsInteractionResult($index)';
    }
  }
}

class TlsPassword extends GObjectObject {
  TlsPassword.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'TlsPassword');

  static const String DESCRIPTION_PROPERTY = 'description';
  static const String FLAGS_PROPERTY = 'flags';
  static const String WARNING_PROPERTY = 'warning';
  factory TlsPassword(TlsPasswordFlags flags, String description) => _staticInfo.callStatic('new', [flags, description]);
  String get description => _staticInfo.callMethodOnReceiver('get_description', this, []);
  TlsPasswordFlags get flags => _staticInfo.callMethodOnReceiver('get_flags', this, []);
  int getValue(int length) => _staticInfo.callMethodOnReceiver('get_value', this, [length]);
  String get warning => _staticInfo.callMethodOnReceiver('get_warning', this, []);
  void set description(String description) => _staticInfo.callMethodOnReceiver('set_description', this, [description]);
  void set flags(TlsPasswordFlags flags) => _staticInfo.callMethodOnReceiver('set_flags', this, [flags]);
  void setValue(int value, int length) => _staticInfo.callMethodOnReceiver('set_value', this, [value, length]);
  void setValueFull(int value, int length, DestroyNotify destroy) => _staticInfo.callMethodOnReceiver('set_value_full', this, [value, length, destroy]);
  void set warning(String warning) => _staticInfo.callMethodOnReceiver('set_warning', this, [warning]);
}

class TlsPasswordFlags extends GEnumBase {
  const TlsPasswordFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'TlsPasswordFlags');

  static const TlsPasswordFlags NONE = const TlsPasswordFlags(0);
  bool get none => (index & 0) == 0;
  static const TlsPasswordFlags RETRY = const TlsPasswordFlags(2);
  bool get retry => (index & 2) == 2;
  static const TlsPasswordFlags MANY_TRIES = const TlsPasswordFlags(4);
  bool get manyTries => (index & 4) == 4;
  static const TlsPasswordFlags FINAL_TRY = const TlsPasswordFlags(8);
  bool get finalTry => (index & 8) == 8;
  static _valueToString(int value) {
    switch(value) {
      case 2: return 'TlsPasswordFlags.RETRY';
      case 4: return 'TlsPasswordFlags.MANY_TRIES';
      case 8: return 'TlsPasswordFlags.FINAL_TRY';
      default: return 'new TlsPasswordFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'TlsPasswordFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 8; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  TlsPasswordFlags operator|(TlsPasswordFlags other) =>
    new TlsPasswordFlags(index | other.index);
  TlsPasswordFlags operator&(TlsPasswordFlags other) =>
    new TlsPasswordFlags(index & other.index);
}

class TlsRehandshakeMode extends GEnumBase {
  const TlsRehandshakeMode(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'TlsRehandshakeMode');

  static const TlsRehandshakeMode NEVER = const TlsRehandshakeMode(0);
  static const TlsRehandshakeMode SAFELY = const TlsRehandshakeMode(1);
  static const TlsRehandshakeMode UNSAFELY = const TlsRehandshakeMode(2);
  String toString() {
    switch(index) {
      case 0: return 'TlsRehandshakeMode.NEVER';
      case 1: return 'TlsRehandshakeMode.SAFELY';
      case 2: return 'TlsRehandshakeMode.UNSAFELY';
      default: return 'new TlsRehandshakeMode($index)';
    }
  }
}

abstract class TlsServerConnection extends GObjectBase implements TlsConnection {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'TlsServerConnection');



  TlsAuthenticationMode get authenticationMode => _staticInfo.getGPropertyOnReceiver('authentication-mode', this);
  void set authenticationMode(TlsAuthenticationMode value) => _staticInfo.setGPropertyOnReceiver('authentication-mode', this, value);
  static const String AUTHENTICATION_MODE_PROPERTY = 'authentication-mode';
  static TlsServerConnection new_(IOStream baseIoStream, TlsCertificate certificate) => _staticInfo.callStatic('new', [baseIoStream, certificate]);
}

class UnixConnection extends SocketConnection {
  UnixConnection.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'UnixConnection');

  Credentials receiveCredentials(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('receive_credentials', this, [cancellable]);
  void receiveCredentialsAsync(Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('receive_credentials_async', this, [cancellable, callback]);
  Credentials receiveCredentialsFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('receive_credentials_finish', this, [result]);
  int receiveFd(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('receive_fd', this, [cancellable]);
  void sendCredentials(Cancellable cancellable) => _staticInfo.callMethodOnReceiver('send_credentials', this, [cancellable]);
  void sendCredentialsAsync(Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('send_credentials_async', this, [cancellable, callback]);
  void sendCredentialsFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('send_credentials_finish', this, [result]);
  void sendFd(int fd, Cancellable cancellable) => _staticInfo.callMethodOnReceiver('send_fd', this, [fd, cancellable]);
}

class UnixCredentialsMessage extends SocketControlMessage {
  UnixCredentialsMessage.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'UnixCredentialsMessage');

  void set credentials(Credentials value) => _staticInfo.setGPropertyOnReceiver('credentials', this, value);
  static const String CREDENTIALS_PROPERTY = 'credentials';
  factory UnixCredentialsMessage() => _staticInfo.callStatic('new', []);
  factory UnixCredentialsMessage.withCredentials(Credentials credentials) => _staticInfo.callStatic('new_with_credentials', [credentials]);
  static bool isSupported() => _staticInfo.callStatic('is_supported', []);
  Credentials get credentials_ => _staticInfo.callMethodOnReceiver('get_credentials', this, []);
}

class UnixFDList extends GObjectObject {
  UnixFDList.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'UnixFDList');

  factory UnixFDList() => _staticInfo.callStatic('new', []);
  factory UnixFDList.fromArray(List<int> fds) => _staticInfo.callStatic('new_from_array', [fds]);
  int append(int fd) => _staticInfo.callMethodOnReceiver('append', this, [fd]);
  int get_(int index_) => _staticInfo.callMethodOnReceiver('get', this, [index_]);
  int get length => _staticInfo.callMethodOnReceiver('get_length', this, []);
  List peekFds() => _staticInfo.callMethodOnReceiver('peek_fds', this, []);
  List stealFds() => _staticInfo.callMethodOnReceiver('steal_fds', this, []);
}

class UnixFDMessage extends SocketControlMessage {
  UnixFDMessage.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'UnixFDMessage');

  void set fdList(UnixFDList value) => _staticInfo.setGPropertyOnReceiver('fd-list', this, value);
  static const String FD_LIST_PROPERTY = 'fd-list';
  factory UnixFDMessage() => _staticInfo.callStatic('new', []);
  factory UnixFDMessage.withFdList(UnixFDList fdList) => _staticInfo.callStatic('new_with_fd_list', [fdList]);
  void appendFd(int fd) => _staticInfo.callMethodOnReceiver('append_fd', this, [fd]);
  UnixFDList get fdList_ => _staticInfo.callMethodOnReceiver('get_fd_list', this, []);
  List stealFds() => _staticInfo.callMethodOnReceiver('steal_fds', this, []);
}

class UnixInputStream extends InputStream with FileDescriptorBased, PollableInputStream {
  UnixInputStream.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'UnixInputStream');

  static const String CLOSE_FD_PROPERTY = 'close-fd';
  void set fd(int value) => _staticInfo.setGPropertyOnReceiver('fd', this, value);
  static const String FD_PROPERTY = 'fd';
  factory UnixInputStream(int fd, bool closeFd) => _staticInfo.callStatic('new', [fd, closeFd]);
  bool get closeFd => _staticInfo.callMethodOnReceiver('get_close_fd', this, []);
  int get fd_ => _staticInfo.callMethodOnReceiver('get_fd', this, []);
  void set closeFd(bool closeFd) => _staticInfo.callMethodOnReceiver('set_close_fd', this, [closeFd]);
}

class UnixMountEntry extends GObjectBase {
  UnixMountEntry.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'UnixMountEntry');

}

class UnixMountMonitor extends GObjectObject {
  UnixMountMonitor.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'UnixMountMonitor');

  factory UnixMountMonitor() => _staticInfo.callStatic('new', []);
  static UnixMountMonitor get_() => _staticInfo.callStatic('get', []);
  void setRateLimit(int limitMsec) => _staticInfo.callMethodOnReceiver('set_rate_limit', this, [limitMsec]);
  int _connectToMountpointsChanged(bool after, void func()) => signalConnect('mountpoints-changed', func, after);
  Stream get onMountpointsChanged {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToMountpointsChanged(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterMountpointsChanged {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToMountpointsChanged(true, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToMountsChanged(bool after, void func()) => signalConnect('mounts-changed', func, after);
  Stream get onMountsChanged {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToMountsChanged(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterMountsChanged {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToMountsChanged(true, () {
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

class UnixMountPoint extends GObjectBase {
  UnixMountPoint.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'UnixMountPoint');

  int compare(UnixMountPoint mount2) => _staticInfo.callMethodOnReceiver('compare', this, [mount2]);
  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
  String get devicePath => _staticInfo.callMethodOnReceiver('get_device_path', this, []);
  String get fsType => _staticInfo.callMethodOnReceiver('get_fs_type', this, []);
  String get mountPath => _staticInfo.callMethodOnReceiver('get_mount_path', this, []);
  String get options => _staticInfo.callMethodOnReceiver('get_options', this, []);
  bool guessCanEject() => _staticInfo.callMethodOnReceiver('guess_can_eject', this, []);
  Icon guessIcon() => _staticInfo.callMethodOnReceiver('guess_icon', this, []);
  String guessName() => _staticInfo.callMethodOnReceiver('guess_name', this, []);
  Icon guessSymbolicIcon() => _staticInfo.callMethodOnReceiver('guess_symbolic_icon', this, []);
  bool isLoopback() => _staticInfo.callMethodOnReceiver('is_loopback', this, []);
  bool isReadonly() => _staticInfo.callMethodOnReceiver('is_readonly', this, []);
  bool isUserMountable() => _staticInfo.callMethodOnReceiver('is_user_mountable', this, []);
}

class UnixOutputStream extends OutputStream with FileDescriptorBased, PollableOutputStream {
  UnixOutputStream.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'UnixOutputStream');

  static const String CLOSE_FD_PROPERTY = 'close-fd';
  void set fd(int value) => _staticInfo.setGPropertyOnReceiver('fd', this, value);
  static const String FD_PROPERTY = 'fd';
  factory UnixOutputStream(int fd, bool closeFd) => _staticInfo.callStatic('new', [fd, closeFd]);
  bool get closeFd => _staticInfo.callMethodOnReceiver('get_close_fd', this, []);
  int get fd_ => _staticInfo.callMethodOnReceiver('get_fd', this, []);
  void set closeFd(bool closeFd) => _staticInfo.callMethodOnReceiver('set_close_fd', this, [closeFd]);
}

class UnixSocketAddress extends SocketAddress with SocketConnectable {
  UnixSocketAddress.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'UnixSocketAddress');

  bool get abstract_ => _staticInfo.getGPropertyOnReceiver('abstract', this);
  void set abstract_(bool value) => _staticInfo.setGPropertyOnReceiver('abstract', this, value);
  static const String ABSTRACT_PROPERTY = 'abstract';
  void set addressType(UnixSocketAddressType value) => _staticInfo.setGPropertyOnReceiver('address-type', this, value);
  static const String ADDRESS_TYPE_PROPERTY = 'address-type';
  void set path(String value) => _staticInfo.setGPropertyOnReceiver('path', this, value);
  static const String PATH_PROPERTY = 'path';
  List<dynamic /* this will fail */> get pathAsArray => _staticInfo.getGPropertyOnReceiver('path-as-array', this);
  void set pathAsArray(List<dynamic /* this will fail */> value) => _staticInfo.setGPropertyOnReceiver('path-as-array', this, value);
  static const String PATH_AS_ARRAY_PROPERTY = 'path-as-array';
  factory UnixSocketAddress(String path) => _staticInfo.callStatic('new', [path]);
  factory UnixSocketAddress.fromAbstract_(List<int> path) => _staticInfo.callStatic('new_abstract', [path]);
  factory UnixSocketAddress.withType(List<int> path, UnixSocketAddressType type) => _staticInfo.callStatic('new_with_type', [path, type]);
  static bool abstractNamesSupported() => _staticInfo.callStatic('abstract_names_supported', []);
  UnixSocketAddressType get addressType_ => _staticInfo.callMethodOnReceiver('get_address_type', this, []);
  bool get isAbstract => _staticInfo.callMethodOnReceiver('get_is_abstract', this, []);
  String get path_ => _staticInfo.callMethodOnReceiver('get_path', this, []);
  int get pathLen => _staticInfo.callMethodOnReceiver('get_path_len', this, []);
}

class UnixSocketAddressType extends GEnumBase {
  const UnixSocketAddressType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'UnixSocketAddressType');

  static const UnixSocketAddressType INVALID = const UnixSocketAddressType(0);
  static const UnixSocketAddressType ANONYMOUS = const UnixSocketAddressType(1);
  static const UnixSocketAddressType PATH = const UnixSocketAddressType(2);
  static const UnixSocketAddressType ABSTRACT = const UnixSocketAddressType(3);
  static const UnixSocketAddressType ABSTRACT_PADDED = const UnixSocketAddressType(4);
  String toString() {
    switch(index) {
      case 0: return 'UnixSocketAddressType.INVALID';
      case 1: return 'UnixSocketAddressType.ANONYMOUS';
      case 2: return 'UnixSocketAddressType.PATH';
      case 3: return 'UnixSocketAddressType.ABSTRACT';
      case 4: return 'UnixSocketAddressType.ABSTRACT_PADDED';
      default: return 'new UnixSocketAddressType($index)';
    }
  }
}

class Vfs extends GObjectObject {
  Vfs.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'Vfs');

  static Vfs getDefault() => _staticInfo.callStatic('get_default', []);
  static Vfs getLocal() => _staticInfo.callStatic('get_local', []);
  File getFileForPath(String path) => _staticInfo.callMethodOnReceiver('get_file_for_path', this, [path]);
  File getFileForUri(String uri) => _staticInfo.callMethodOnReceiver('get_file_for_uri', this, [uri]);
  List<String> get supportedUriSchemes => _staticInfo.callMethodOnReceiver('get_supported_uri_schemes', this, []);
  bool isActive() => _staticInfo.callMethodOnReceiver('is_active', this, []);
  File parseName(String parseName) => _staticInfo.callMethodOnReceiver('parse_name', this, [parseName]);
}

abstract class Volume extends GObjectBase {
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'Volume');



  bool canEject() => _staticInfo.callMethodOnReceiver('can_eject', this, []);
  bool canMount() => _staticInfo.callMethodOnReceiver('can_mount', this, []);
  void eject(MountUnmountFlags flags, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('eject', this, [flags, cancellable, callback]);
  void ejectFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('eject_finish', this, [result]);
  void ejectWithOperation(MountUnmountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('eject_with_operation', this, [flags, mountOperation, cancellable, callback]);
  void ejectWithOperationFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('eject_with_operation_finish', this, [result]);
  List<String> enumerateIdentifiers() => _staticInfo.callMethodOnReceiver('enumerate_identifiers', this, []);
  File get activationRoot => _staticInfo.callMethodOnReceiver('get_activation_root', this, []);
  Drive get drive => _staticInfo.callMethodOnReceiver('get_drive', this, []);
  Icon get icon => _staticInfo.callMethodOnReceiver('get_icon', this, []);
  String getIdentifier(String kind) => _staticInfo.callMethodOnReceiver('get_identifier', this, [kind]);
  Mount get mount => _staticInfo.callMethodOnReceiver('get_mount', this, []);
  String get name => _staticInfo.callMethodOnReceiver('get_name', this, []);
  String get sortKey => _staticInfo.callMethodOnReceiver('get_sort_key', this, []);
  Icon get symbolicIcon => _staticInfo.callMethodOnReceiver('get_symbolic_icon', this, []);
  String get uuid => _staticInfo.callMethodOnReceiver('get_uuid', this, []);
  void mount_(MountMountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback) => _staticInfo.callMethodOnReceiver('mount', this, [flags, mountOperation, cancellable, callback]);
  void mountFinish(AsyncResult result) => _staticInfo.callMethodOnReceiver('mount_finish', this, [result]);
  bool shouldAutomount() => _staticInfo.callMethodOnReceiver('should_automount', this, []);
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
  int _connectToRemoved(bool after, void func()) => signalConnect('removed', func, after);
  Stream get onRemoved {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToRemoved(false, () {
              controller.add(null);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream get afterRemoved {
    int signalId;
    StreamController controller;
    controller = new StreamController(
      onListen: () {
          signalId = _connectToRemoved(true, () {
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

class VolumeMonitor extends GObjectObject {
  VolumeMonitor.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'VolumeMonitor');

  static Volume adoptOrphanMount(Mount mount) => _staticInfo.callStatic('adopt_orphan_mount', [mount]);
  static VolumeMonitor get_() => _staticInfo.callStatic('get', []);
  GLibList /* this will fail */ get connectedDrives => _staticInfo.callMethodOnReceiver('get_connected_drives', this, []);
  Mount getMountForUuid(String uuid) => _staticInfo.callMethodOnReceiver('get_mount_for_uuid', this, [uuid]);
  GLibList /* this will fail */ get mounts => _staticInfo.callMethodOnReceiver('get_mounts', this, []);
  Volume getVolumeForUuid(String uuid) => _staticInfo.callMethodOnReceiver('get_volume_for_uuid', this, [uuid]);
  GLibList /* this will fail */ get volumes => _staticInfo.callMethodOnReceiver('get_volumes', this, []);
  int _connectToDriveChanged(bool after, void func(Drive drive)) => signalConnect('drive-changed', func, after);
  Stream<Drive> get onDriveChanged {
    int signalId;
    StreamController<Drive> controller;
    controller = new StreamController<Drive>(
      onListen: () {
          signalId = _connectToDriveChanged(false, (Drive drive) {
              controller.add(drive);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<Drive> get afterDriveChanged {
    int signalId;
    StreamController<Drive> controller;
    controller = new StreamController<Drive>(
      onListen: () {
          signalId = _connectToDriveChanged(true, (Drive drive) {
              controller.add(drive);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToDriveConnected(bool after, void func(Drive drive)) => signalConnect('drive-connected', func, after);
  Stream<Drive> get onDriveConnected {
    int signalId;
    StreamController<Drive> controller;
    controller = new StreamController<Drive>(
      onListen: () {
          signalId = _connectToDriveConnected(false, (Drive drive) {
              controller.add(drive);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<Drive> get afterDriveConnected {
    int signalId;
    StreamController<Drive> controller;
    controller = new StreamController<Drive>(
      onListen: () {
          signalId = _connectToDriveConnected(true, (Drive drive) {
              controller.add(drive);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToDriveDisconnected(bool after, void func(Drive drive)) => signalConnect('drive-disconnected', func, after);
  Stream<Drive> get onDriveDisconnected {
    int signalId;
    StreamController<Drive> controller;
    controller = new StreamController<Drive>(
      onListen: () {
          signalId = _connectToDriveDisconnected(false, (Drive drive) {
              controller.add(drive);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<Drive> get afterDriveDisconnected {
    int signalId;
    StreamController<Drive> controller;
    controller = new StreamController<Drive>(
      onListen: () {
          signalId = _connectToDriveDisconnected(true, (Drive drive) {
              controller.add(drive);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToDriveEjectButton(bool after, void func(Drive drive)) => signalConnect('drive-eject-button', func, after);
  Stream<Drive> get onDriveEjectButton {
    int signalId;
    StreamController<Drive> controller;
    controller = new StreamController<Drive>(
      onListen: () {
          signalId = _connectToDriveEjectButton(false, (Drive drive) {
              controller.add(drive);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<Drive> get afterDriveEjectButton {
    int signalId;
    StreamController<Drive> controller;
    controller = new StreamController<Drive>(
      onListen: () {
          signalId = _connectToDriveEjectButton(true, (Drive drive) {
              controller.add(drive);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToDriveStopButton(bool after, void func(Drive drive)) => signalConnect('drive-stop-button', func, after);
  Stream<Drive> get onDriveStopButton {
    int signalId;
    StreamController<Drive> controller;
    controller = new StreamController<Drive>(
      onListen: () {
          signalId = _connectToDriveStopButton(false, (Drive drive) {
              controller.add(drive);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<Drive> get afterDriveStopButton {
    int signalId;
    StreamController<Drive> controller;
    controller = new StreamController<Drive>(
      onListen: () {
          signalId = _connectToDriveStopButton(true, (Drive drive) {
              controller.add(drive);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToMountAdded(bool after, void func(Mount mount)) => signalConnect('mount-added', func, after);
  Stream<Mount> get onMountAdded {
    int signalId;
    StreamController<Mount> controller;
    controller = new StreamController<Mount>(
      onListen: () {
          signalId = _connectToMountAdded(false, (Mount mount) {
              controller.add(mount);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<Mount> get afterMountAdded {
    int signalId;
    StreamController<Mount> controller;
    controller = new StreamController<Mount>(
      onListen: () {
          signalId = _connectToMountAdded(true, (Mount mount) {
              controller.add(mount);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToMountChanged(bool after, void func(Mount mount)) => signalConnect('mount-changed', func, after);
  Stream<Mount> get onMountChanged {
    int signalId;
    StreamController<Mount> controller;
    controller = new StreamController<Mount>(
      onListen: () {
          signalId = _connectToMountChanged(false, (Mount mount) {
              controller.add(mount);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<Mount> get afterMountChanged {
    int signalId;
    StreamController<Mount> controller;
    controller = new StreamController<Mount>(
      onListen: () {
          signalId = _connectToMountChanged(true, (Mount mount) {
              controller.add(mount);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToMountPreUnmount(bool after, void func(Mount mount)) => signalConnect('mount-pre-unmount', func, after);
  Stream<Mount> get onMountPreUnmount {
    int signalId;
    StreamController<Mount> controller;
    controller = new StreamController<Mount>(
      onListen: () {
          signalId = _connectToMountPreUnmount(false, (Mount mount) {
              controller.add(mount);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<Mount> get afterMountPreUnmount {
    int signalId;
    StreamController<Mount> controller;
    controller = new StreamController<Mount>(
      onListen: () {
          signalId = _connectToMountPreUnmount(true, (Mount mount) {
              controller.add(mount);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToMountRemoved(bool after, void func(Mount mount)) => signalConnect('mount-removed', func, after);
  Stream<Mount> get onMountRemoved {
    int signalId;
    StreamController<Mount> controller;
    controller = new StreamController<Mount>(
      onListen: () {
          signalId = _connectToMountRemoved(false, (Mount mount) {
              controller.add(mount);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<Mount> get afterMountRemoved {
    int signalId;
    StreamController<Mount> controller;
    controller = new StreamController<Mount>(
      onListen: () {
          signalId = _connectToMountRemoved(true, (Mount mount) {
              controller.add(mount);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToVolumeAdded(bool after, void func(Volume volume)) => signalConnect('volume-added', func, after);
  Stream<Volume> get onVolumeAdded {
    int signalId;
    StreamController<Volume> controller;
    controller = new StreamController<Volume>(
      onListen: () {
          signalId = _connectToVolumeAdded(false, (Volume volume) {
              controller.add(volume);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<Volume> get afterVolumeAdded {
    int signalId;
    StreamController<Volume> controller;
    controller = new StreamController<Volume>(
      onListen: () {
          signalId = _connectToVolumeAdded(true, (Volume volume) {
              controller.add(volume);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToVolumeChanged(bool after, void func(Volume volume)) => signalConnect('volume-changed', func, after);
  Stream<Volume> get onVolumeChanged {
    int signalId;
    StreamController<Volume> controller;
    controller = new StreamController<Volume>(
      onListen: () {
          signalId = _connectToVolumeChanged(false, (Volume volume) {
              controller.add(volume);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<Volume> get afterVolumeChanged {
    int signalId;
    StreamController<Volume> controller;
    controller = new StreamController<Volume>(
      onListen: () {
          signalId = _connectToVolumeChanged(true, (Volume volume) {
              controller.add(volume);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  int _connectToVolumeRemoved(bool after, void func(Volume volume)) => signalConnect('volume-removed', func, after);
  Stream<Volume> get onVolumeRemoved {
    int signalId;
    StreamController<Volume> controller;
    controller = new StreamController<Volume>(
      onListen: () {
          signalId = _connectToVolumeRemoved(false, (Volume volume) {
              controller.add(volume);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
  Stream<Volume> get afterVolumeRemoved {
    int signalId;
    StreamController<Volume> controller;
    controller = new StreamController<Volume>(
      onListen: () {
          signalId = _connectToVolumeRemoved(true, (Volume volume) {
              controller.add(volume);
          });
      },
      onCancel: () {
          signalDisconnect(signalId);
      },
      sync: true);
    return controller.stream;
  }
}

class ZlibCompressor extends GObjectObject with Converter {
  ZlibCompressor.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'ZlibCompressor');

  static const String FILE_INFO_PROPERTY = 'file-info';
  ZlibCompressorFormat get format => _staticInfo.getGPropertyOnReceiver('format', this);
  void set format(ZlibCompressorFormat value) => _staticInfo.setGPropertyOnReceiver('format', this, value);
  static const String FORMAT_PROPERTY = 'format';
  int get level => _staticInfo.getGPropertyOnReceiver('level', this);
  void set level(int value) => _staticInfo.setGPropertyOnReceiver('level', this, value);
  static const String LEVEL_PROPERTY = 'level';
  factory ZlibCompressor(ZlibCompressorFormat format, int level) => _staticInfo.callStatic('new', [format, level]);
  FileInfo get fileInfo => _staticInfo.callMethodOnReceiver('get_file_info', this, []);
  void set fileInfo(FileInfo fileInfo) => _staticInfo.callMethodOnReceiver('set_file_info', this, [fileInfo]);
}

class ZlibCompressorFormat extends GEnumBase {
  const ZlibCompressorFormat(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'ZlibCompressorFormat');

  static const ZlibCompressorFormat ZLIB = const ZlibCompressorFormat(0);
  static const ZlibCompressorFormat GZIP = const ZlibCompressorFormat(1);
  static const ZlibCompressorFormat RAW = const ZlibCompressorFormat(2);
  String toString() {
    switch(index) {
      case 0: return 'ZlibCompressorFormat.ZLIB';
      case 1: return 'ZlibCompressorFormat.GZIP';
      case 2: return 'ZlibCompressorFormat.RAW';
      default: return 'new ZlibCompressorFormat($index)';
    }
  }
}

class ZlibDecompressor extends GObjectObject with Converter {
  ZlibDecompressor.fromNative() : super.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('Gio', 'ZlibDecompressor');

  static const String FILE_INFO_PROPERTY = 'file-info';
  ZlibCompressorFormat get format => _staticInfo.getGPropertyOnReceiver('format', this);
  void set format(ZlibCompressorFormat value) => _staticInfo.setGPropertyOnReceiver('format', this, value);
  static const String FORMAT_PROPERTY = 'format';
  factory ZlibDecompressor(ZlibCompressorFormat format) => _staticInfo.callStatic('new', [format]);
  FileInfo get fileInfo => _staticInfo.callMethodOnReceiver('get_file_info', this, []);
}

bool actionNameIsValid(String actionName) => callStaticGlobal('Gio', 'action_name_is_valid', [actionName]);

List actionParseDetailedName(String detailedName) => callStaticGlobal('Gio', 'action_parse_detailed_name', [detailedName]);

String actionPrintDetailedName(String actionName, Variant targetValue) => callStaticGlobal('Gio', 'action_print_detailed_name', [actionName, targetValue]);

AppInfo appInfoCreateFromCommandline(String commandline, String applicationName, AppInfoCreateFlags flags) => callStaticGlobal('Gio', 'app_info_create_from_commandline', [commandline, applicationName, flags]);

GLibList /* this will fail */ appInfoGetAll() => callStaticGlobal('Gio', 'app_info_get_all', []);

GLibList /* this will fail */ appInfoGetAllForType(String contentType) => callStaticGlobal('Gio', 'app_info_get_all_for_type', [contentType]);

AppInfo appInfoGetDefaultForType(String contentType, bool mustSupportUris) => callStaticGlobal('Gio', 'app_info_get_default_for_type', [contentType, mustSupportUris]);

AppInfo appInfoGetDefaultForUriScheme(String uriScheme) => callStaticGlobal('Gio', 'app_info_get_default_for_uri_scheme', [uriScheme]);

GLibList /* this will fail */ appInfoGetFallbackForType(String contentType) => callStaticGlobal('Gio', 'app_info_get_fallback_for_type', [contentType]);

GLibList /* this will fail */ appInfoGetRecommendedForType(String contentType) => callStaticGlobal('Gio', 'app_info_get_recommended_for_type', [contentType]);

void appInfoLaunchDefaultForUri(String uri, AppLaunchContext launchContext) => callStaticGlobal('Gio', 'app_info_launch_default_for_uri', [uri, launchContext]);

void appInfoResetTypeAssociations(String contentType) => callStaticGlobal('Gio', 'app_info_reset_type_associations', [contentType]);

void asyncInitableNewvAsync(int objectType, int nParameters, Parameter parameters, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback) => callStaticGlobal('Gio', 'async_initable_newv_async', [objectType, nParameters, parameters, ioPriority, cancellable, callback]);

void busGet(BusType busType, Cancellable cancellable, AsyncReadyCallback callback) => callStaticGlobal('Gio', 'bus_get', [busType, cancellable, callback]);

DBusConnection busGetFinish(AsyncResult res) => callStaticGlobal('Gio', 'bus_get_finish', [res]);

DBusConnection busGetSync(BusType busType, Cancellable cancellable) => callStaticGlobal('Gio', 'bus_get_sync', [busType, cancellable]);

int busOwnNameOnConnection(DBusConnection connection, String name, BusNameOwnerFlags flags, Closure nameAcquiredClosure, Closure nameLostClosure) => callStaticGlobal('Gio', 'bus_own_name_on_connection', [connection, name, flags, nameAcquiredClosure, nameLostClosure]);

int busOwnName(BusType busType, String name, BusNameOwnerFlags flags, Closure busAcquiredClosure, Closure nameAcquiredClosure, Closure nameLostClosure) => callStaticGlobal('Gio', 'bus_own_name', [busType, name, flags, busAcquiredClosure, nameAcquiredClosure, nameLostClosure]);

void busUnownName(int ownerId) => callStaticGlobal('Gio', 'bus_unown_name', [ownerId]);

void busUnwatchName(int watcherId) => callStaticGlobal('Gio', 'bus_unwatch_name', [watcherId]);

int busWatchNameOnConnection(DBusConnection connection, String name, BusNameWatcherFlags flags, Closure nameAppearedClosure, Closure nameVanishedClosure) => callStaticGlobal('Gio', 'bus_watch_name_on_connection', [connection, name, flags, nameAppearedClosure, nameVanishedClosure]);

int busWatchName(BusType busType, String name, BusNameWatcherFlags flags, Closure nameAppearedClosure, Closure nameVanishedClosure) => callStaticGlobal('Gio', 'bus_watch_name', [busType, name, flags, nameAppearedClosure, nameVanishedClosure]);

bool contentTypeCanBeExecutable(String type) => callStaticGlobal('Gio', 'content_type_can_be_executable', [type]);

bool contentTypeEquals(String type1, String type2) => callStaticGlobal('Gio', 'content_type_equals', [type1, type2]);

String contentTypeFromMimeType(String mimeType) => callStaticGlobal('Gio', 'content_type_from_mime_type', [mimeType]);

String contentTypeGetDescription(String type) => callStaticGlobal('Gio', 'content_type_get_description', [type]);

String contentTypeGetGenericIconName(String type) => callStaticGlobal('Gio', 'content_type_get_generic_icon_name', [type]);

Icon contentTypeGetIcon(String type) => callStaticGlobal('Gio', 'content_type_get_icon', [type]);

String contentTypeGetMimeType(String type) => callStaticGlobal('Gio', 'content_type_get_mime_type', [type]);

Icon contentTypeGetSymbolicIcon(String type) => callStaticGlobal('Gio', 'content_type_get_symbolic_icon', [type]);

List contentTypeGuess(String filename, List<int> data) => callStaticGlobal('Gio', 'content_type_guess', [filename, data]);

List<String> contentTypeGuessForTree(File root) => callStaticGlobal('Gio', 'content_type_guess_for_tree', [root]);

bool contentTypeIsA(String type, String supertype) => callStaticGlobal('Gio', 'content_type_is_a', [type, supertype]);

bool contentTypeIsUnknown(String type) => callStaticGlobal('Gio', 'content_type_is_unknown', [type]);

GLibList /* this will fail */ contentTypesGetRegistered() => callStaticGlobal('Gio', 'content_types_get_registered', []);

String dbusAddressEscapeValue(String string) => callStaticGlobal('Gio', 'dbus_address_escape_value', [string]);

String dbusAddressGetForBusSync(BusType busType, Cancellable cancellable) => callStaticGlobal('Gio', 'dbus_address_get_for_bus_sync', [busType, cancellable]);

void dbusAddressGetStream(String address, Cancellable cancellable, AsyncReadyCallback callback) => callStaticGlobal('Gio', 'dbus_address_get_stream', [address, cancellable, callback]);

IOStream dbusAddressGetStreamFinish(AsyncResult res, String outGuid) => callStaticGlobal('Gio', 'dbus_address_get_stream_finish', [res, outGuid]);

IOStream dbusAddressGetStreamSync(String address, String outGuid, Cancellable cancellable) => callStaticGlobal('Gio', 'dbus_address_get_stream_sync', [address, outGuid, cancellable]);

String dbusAnnotationInfoLookup(List<DBusAnnotationInfo> annotations, String name) => callStaticGlobal('Gio', 'dbus_annotation_info_lookup', [annotations, name]);

String dbusErrorEncodeGerror(GErrorBase error) => callStaticGlobal('Gio', 'dbus_error_encode_gerror', [error]);

String dbusErrorGetRemoteError(GErrorBase error) => callStaticGlobal('Gio', 'dbus_error_get_remote_error', [error]);

bool dbusErrorIsRemoteError(GErrorBase error) => callStaticGlobal('Gio', 'dbus_error_is_remote_error', [error]);

GErrorBase dbusErrorNewForDbusError(String dbusErrorName, String dbusErrorMessage) => callStaticGlobal('Gio', 'dbus_error_new_for_dbus_error', [dbusErrorName, dbusErrorMessage]);

int dbusErrorQuark() => callStaticGlobal('Gio', 'dbus_error_quark', []);

bool dbusErrorRegisterError(int errorDomain, int errorCode, String dbusErrorName) => callStaticGlobal('Gio', 'dbus_error_register_error', [errorDomain, errorCode, dbusErrorName]);

void dbusErrorRegisterErrorDomain(String errorDomainQuarkName, int quarkVolatile, DBusErrorEntry entries, int numEntries) => callStaticGlobal('Gio', 'dbus_error_register_error_domain', [errorDomainQuarkName, quarkVolatile, entries, numEntries]);

bool dbusErrorStripRemoteError(GErrorBase error) => callStaticGlobal('Gio', 'dbus_error_strip_remote_error', [error]);

bool dbusErrorUnregisterError(int errorDomain, int errorCode, String dbusErrorName) => callStaticGlobal('Gio', 'dbus_error_unregister_error', [errorDomain, errorCode, dbusErrorName]);

String dbusGenerateGuid() => callStaticGlobal('Gio', 'dbus_generate_guid', []);

Variant dbusGvalueToGvariant(Value gvalue, VariantType type) => callStaticGlobal('Gio', 'dbus_gvalue_to_gvariant', [gvalue, type]);

Value dbusGvariantToGvalue(Variant value) => callStaticGlobal('Gio', 'dbus_gvariant_to_gvalue', [value]);

bool dbusIsAddress(String string) => callStaticGlobal('Gio', 'dbus_is_address', [string]);

bool dbusIsGuid(String string) => callStaticGlobal('Gio', 'dbus_is_guid', [string]);

bool dbusIsInterfaceName(String string) => callStaticGlobal('Gio', 'dbus_is_interface_name', [string]);

bool dbusIsMemberName(String string) => callStaticGlobal('Gio', 'dbus_is_member_name', [string]);

bool dbusIsName(String string) => callStaticGlobal('Gio', 'dbus_is_name', [string]);

void dbusIsSupportedAddress(String string) => callStaticGlobal('Gio', 'dbus_is_supported_address', [string]);

bool dbusIsUniqueName(String string) => callStaticGlobal('Gio', 'dbus_is_unique_name', [string]);

File fileNewForCommandlineArg(String arg) => callStaticGlobal('Gio', 'file_new_for_commandline_arg', [arg]);

File fileNewForCommandlineArgAndCwd(String arg, String cwd) => callStaticGlobal('Gio', 'file_new_for_commandline_arg_and_cwd', [arg, cwd]);

File fileNewForPath(String path) => callStaticGlobal('Gio', 'file_new_for_path', [path]);

File fileNewForUri(String uri) => callStaticGlobal('Gio', 'file_new_for_uri', [uri]);

List fileNewTmp(String tmpl) => callStaticGlobal('Gio', 'file_new_tmp', [tmpl]);

File fileParseName(String parseName) => callStaticGlobal('Gio', 'file_parse_name', [parseName]);

Icon iconDeserialize(Variant value) => callStaticGlobal('Gio', 'icon_deserialize', [value]);

int iconHash(dynamic icon /* this will fail */) => callStaticGlobal('Gio', 'icon_hash', [icon]);

Icon iconNewForString(String str) => callStaticGlobal('Gio', 'icon_new_for_string', [str]);

GObjectObject initableNewv(int objectType, List<Parameter> parameters, Cancellable cancellable) => callStaticGlobal('Gio', 'initable_newv', [objectType, parameters, cancellable]);

IOErrorEnum ioErrorFromErrno(int errNo) => callStaticGlobal('Gio', 'io_error_from_errno', [errNo]);

int ioErrorQuark() => callStaticGlobal('Gio', 'io_error_quark', []);

IOExtension ioExtensionPointImplement(String extensionPointName, int type, String extensionName, int priority) => callStaticGlobal('Gio', 'io_extension_point_implement', [extensionPointName, type, extensionName, priority]);

IOExtensionPoint ioExtensionPointLookup(String name) => callStaticGlobal('Gio', 'io_extension_point_lookup', [name]);

IOExtensionPoint ioExtensionPointRegister(String name) => callStaticGlobal('Gio', 'io_extension_point_register', [name]);

GLibList /* this will fail */ ioModulesLoadAllInDirectory(String dirname) => callStaticGlobal('Gio', 'io_modules_load_all_in_directory', [dirname]);

GLibList /* this will fail */ ioModulesLoadAllInDirectoryWithScope(String dirname, IOModuleScope scope) => callStaticGlobal('Gio', 'io_modules_load_all_in_directory_with_scope', [dirname, scope]);

void ioModulesScanAllInDirectory(String dirname) => callStaticGlobal('Gio', 'io_modules_scan_all_in_directory', [dirname]);

void ioModulesScanAllInDirectoryWithScope(String dirname, IOModuleScope scope) => callStaticGlobal('Gio', 'io_modules_scan_all_in_directory_with_scope', [dirname, scope]);

void ioSchedulerCancelAllJobs() => callStaticGlobal('Gio', 'io_scheduler_cancel_all_jobs', []);

void ioSchedulerPushJob(IOSchedulerJobFunc jobFunc, int ioPriority, Cancellable cancellable) => callStaticGlobal('Gio', 'io_scheduler_push_job', [jobFunc, ioPriority, cancellable]);

NetworkMonitor networkMonitorGetDefault() => callStaticGlobal('Gio', 'network_monitor_get_default', []);

void networkingInit() => callStaticGlobal('Gio', 'networking_init', []);

Source pollableSourceNew(GObjectObject pollableStream) => callStaticGlobal('Gio', 'pollable_source_new', [pollableStream]);

Source pollableSourceNewFull(GObjectObject pollableStream, Source childSource, Cancellable cancellable) => callStaticGlobal('Gio', 'pollable_source_new_full', [pollableStream, childSource, cancellable]);

int pollableStreamRead(InputStream stream, List<int> buffer, bool blocking, Cancellable cancellable) => callStaticGlobal('Gio', 'pollable_stream_read', [stream, buffer, blocking, cancellable]);

int pollableStreamWrite(OutputStream stream, List<int> buffer, bool blocking, Cancellable cancellable) => callStaticGlobal('Gio', 'pollable_stream_write', [stream, buffer, blocking, cancellable]);

int pollableStreamWriteAll(OutputStream stream, List<int> buffer, bool blocking, Cancellable cancellable) => callStaticGlobal('Gio', 'pollable_stream_write_all', [stream, buffer, blocking, cancellable]);

Proxy proxyGetDefaultForProtocol(String protocol) => callStaticGlobal('Gio', 'proxy_get_default_for_protocol', [protocol]);

ProxyResolver proxyResolverGetDefault() => callStaticGlobal('Gio', 'proxy_resolver_get_default', []);

int resolverErrorQuark() => callStaticGlobal('Gio', 'resolver_error_quark', []);

int resourceErrorQuark() => callStaticGlobal('Gio', 'resource_error_quark', []);

Resource resourceLoad(String filename) => callStaticGlobal('Gio', 'resource_load', [filename]);

List<String> resourcesEnumerateChildren(String path, ResourceLookupFlags lookupFlags) => callStaticGlobal('Gio', 'resources_enumerate_children', [path, lookupFlags]);

List resourcesGetInfo(String path, ResourceLookupFlags lookupFlags) => callStaticGlobal('Gio', 'resources_get_info', [path, lookupFlags]);

Bytes resourcesLookupData(String path, ResourceLookupFlags lookupFlags) => callStaticGlobal('Gio', 'resources_lookup_data', [path, lookupFlags]);

InputStream resourcesOpenStream(String path, ResourceLookupFlags lookupFlags) => callStaticGlobal('Gio', 'resources_open_stream', [path, lookupFlags]);

void resourcesRegister(Resource resource) => callStaticGlobal('Gio', 'resources_register', [resource]);

void resourcesUnregister(Resource resource) => callStaticGlobal('Gio', 'resources_unregister', [resource]);

SettingsSchemaSource settingsSchemaSourceGetDefault() => callStaticGlobal('Gio', 'settings_schema_source_get_default', []);

void simpleAsyncReportGerrorInIdle(GObjectObject object, AsyncReadyCallback callback, GErrorBase error) => callStaticGlobal('Gio', 'simple_async_report_gerror_in_idle', [object, callback, error]);

TlsBackend tlsBackendGetDefault() => callStaticGlobal('Gio', 'tls_backend_get_default', []);

TlsClientConnection tlsClientConnectionNew(IOStream baseIoStream, SocketConnectable serverIdentity) => callStaticGlobal('Gio', 'tls_client_connection_new', [baseIoStream, serverIdentity]);

int tlsErrorQuark() => callStaticGlobal('Gio', 'tls_error_quark', []);

TlsFileDatabase tlsFileDatabaseNew(String anchors) => callStaticGlobal('Gio', 'tls_file_database_new', [anchors]);

TlsServerConnection tlsServerConnectionNew(IOStream baseIoStream, TlsCertificate certificate) => callStaticGlobal('Gio', 'tls_server_connection_new', [baseIoStream, certificate]);

bool unixIsMountPathSystemInternal(String mountPath) => callStaticGlobal('Gio', 'unix_is_mount_path_system_internal', [mountPath]);

int unixMountCompare(UnixMountEntry mount1, UnixMountEntry mount2) => callStaticGlobal('Gio', 'unix_mount_compare', [mount1, mount2]);

void unixMountFree(UnixMountEntry mountEntry) => callStaticGlobal('Gio', 'unix_mount_free', [mountEntry]);

String unixMountGetDevicePath(UnixMountEntry mountEntry) => callStaticGlobal('Gio', 'unix_mount_get_device_path', [mountEntry]);

String unixMountGetFsType(UnixMountEntry mountEntry) => callStaticGlobal('Gio', 'unix_mount_get_fs_type', [mountEntry]);

String unixMountGetMountPath(UnixMountEntry mountEntry) => callStaticGlobal('Gio', 'unix_mount_get_mount_path', [mountEntry]);

bool unixMountGuessCanEject(UnixMountEntry mountEntry) => callStaticGlobal('Gio', 'unix_mount_guess_can_eject', [mountEntry]);

Icon unixMountGuessIcon(UnixMountEntry mountEntry) => callStaticGlobal('Gio', 'unix_mount_guess_icon', [mountEntry]);

String unixMountGuessName(UnixMountEntry mountEntry) => callStaticGlobal('Gio', 'unix_mount_guess_name', [mountEntry]);

bool unixMountGuessShouldDisplay(UnixMountEntry mountEntry) => callStaticGlobal('Gio', 'unix_mount_guess_should_display', [mountEntry]);

Icon unixMountGuessSymbolicIcon(UnixMountEntry mountEntry) => callStaticGlobal('Gio', 'unix_mount_guess_symbolic_icon', [mountEntry]);

bool unixMountIsReadonly(UnixMountEntry mountEntry) => callStaticGlobal('Gio', 'unix_mount_is_readonly', [mountEntry]);

bool unixMountIsSystemInternal(UnixMountEntry mountEntry) => callStaticGlobal('Gio', 'unix_mount_is_system_internal', [mountEntry]);

bool unixMountPointsChangedSince(int time) => callStaticGlobal('Gio', 'unix_mount_points_changed_since', [time]);

bool unixMountsChangedSince(int time) => callStaticGlobal('Gio', 'unix_mounts_changed_since', [time]);

bool _initLibraryStarted = false;

void initLibrary() {
  if (_initLibraryStarted) return;
  _initLibraryStarted = true;
  gobject.initLibrary();
  registerInterceptorTypeForNamedType("Gio", "ActionEntry",ActionEntry);
  registerInterceptorTypeForNamedType("Gio", "AppInfoCreateFlags",AppInfoCreateFlags);
  registerInterceptorTypeForNamedType("Gio", "AppInfoMonitor",AppInfoMonitor);
  registerInterceptorTypeForNamedType("Gio", "AppLaunchContext",AppLaunchContext);
  registerInterceptorTypeForNamedType("Gio", "Application",Application);
  registerInterceptorTypeForNamedType("Gio", "ApplicationCommandLine",ApplicationCommandLine);
  registerInterceptorTypeForNamedType("Gio", "ApplicationFlags",ApplicationFlags);
  registerInterceptorTypeForNamedType("Gio", "AskPasswordFlags",AskPasswordFlags);
  registerInterceptorTypeForNamedType("Gio", "BufferedInputStream",BufferedInputStream);
  registerInterceptorTypeForNamedType("Gio", "BufferedOutputStream",BufferedOutputStream);
  registerInterceptorTypeForNamedType("Gio", "BusNameOwnerFlags",BusNameOwnerFlags);
  registerInterceptorTypeForNamedType("Gio", "BusNameWatcherFlags",BusNameWatcherFlags);
  registerInterceptorTypeForNamedType("Gio", "BusType",BusType);
  registerInterceptorTypeForNamedType("Gio", "BytesIcon",BytesIcon);
  registerInterceptorTypeForNamedType("Gio", "Cancellable",Cancellable);
  registerInterceptorTypeForNamedType("Gio", "CharsetConverter",CharsetConverter);
  registerInterceptorTypeForNamedType("Gio", "ConverterFlags",ConverterFlags);
  registerInterceptorTypeForNamedType("Gio", "ConverterInputStream",ConverterInputStream);
  registerInterceptorTypeForNamedType("Gio", "ConverterOutputStream",ConverterOutputStream);
  registerInterceptorTypeForNamedType("Gio", "ConverterResult",ConverterResult);
  registerInterceptorTypeForNamedType("Gio", "Credentials",Credentials);
  registerInterceptorTypeForNamedType("Gio", "CredentialsType",CredentialsType);
  registerInterceptorTypeForNamedType("Gio", "DBusActionGroup",DBusActionGroup);
  registerInterceptorTypeForNamedType("Gio", "DBusAnnotationInfo",DBusAnnotationInfo);
  registerInterceptorTypeForNamedType("Gio", "DBusArgInfo",DBusArgInfo);
  registerInterceptorTypeForNamedType("Gio", "DBusAuthObserver",DBusAuthObserver);
  registerInterceptorTypeForNamedType("Gio", "DBusCallFlags",DBusCallFlags);
  registerInterceptorTypeForNamedType("Gio", "DBusCapabilityFlags",DBusCapabilityFlags);
  registerInterceptorTypeForNamedType("Gio", "DBusConnection",DBusConnection);
  registerInterceptorTypeForNamedType("Gio", "DBusConnectionFlags",DBusConnectionFlags);
  registerInterceptorTypeForNamedType("Gio", "DBusError",DBusErrorCode);
  registerInterceptorTypeForNamedType("Gio", "DBusErrorEntry",DBusErrorEntry);
  registerInterceptorTypeForNamedType("Gio", "DBusInterfaceInfo",DBusInterfaceInfo);
  registerInterceptorTypeForNamedType("Gio", "DBusInterfaceSkeleton",DBusInterfaceSkeleton);
  registerInterceptorTypeForNamedType("Gio", "DBusInterfaceSkeletonFlags",DBusInterfaceSkeletonFlags);
  registerInterceptorTypeForNamedType("Gio", "DBusInterfaceVTable",DBusInterfaceVTable);
  registerInterceptorTypeForNamedType("Gio", "DBusMenuModel",DBusMenuModel);
  registerInterceptorTypeForNamedType("Gio", "DBusMessage",DBusMessage);
  registerInterceptorTypeForNamedType("Gio", "DBusMessageByteOrder",DBusMessageByteOrder);
  registerInterceptorTypeForNamedType("Gio", "DBusMessageFlags",DBusMessageFlags);
  registerInterceptorTypeForNamedType("Gio", "DBusMessageHeaderField",DBusMessageHeaderField);
  registerInterceptorTypeForNamedType("Gio", "DBusMessageType",DBusMessageType);
  registerInterceptorTypeForNamedType("Gio", "DBusMethodInfo",DBusMethodInfo);
  registerInterceptorTypeForNamedType("Gio", "DBusMethodInvocation",DBusMethodInvocation);
  registerInterceptorTypeForNamedType("Gio", "DBusNodeInfo",DBusNodeInfo);
  registerInterceptorTypeForNamedType("Gio", "DBusObjectManagerClient",DBusObjectManagerClient);
  registerInterceptorTypeForNamedType("Gio", "DBusObjectManagerClientFlags",DBusObjectManagerClientFlags);
  registerInterceptorTypeForNamedType("Gio", "DBusObjectManagerServer",DBusObjectManagerServer);
  registerInterceptorTypeForNamedType("Gio", "DBusObjectProxy",DBusObjectProxy);
  registerInterceptorTypeForNamedType("Gio", "DBusObjectSkeleton",DBusObjectSkeleton);
  registerInterceptorTypeForNamedType("Gio", "DBusPropertyInfo",DBusPropertyInfo);
  registerInterceptorTypeForNamedType("Gio", "DBusPropertyInfoFlags",DBusPropertyInfoFlags);
  registerInterceptorTypeForNamedType("Gio", "DBusProxy",DBusProxy);
  registerInterceptorTypeForNamedType("Gio", "DBusProxyFlags",DBusProxyFlags);
  registerInterceptorTypeForNamedType("Gio", "DBusSendMessageFlags",DBusSendMessageFlags);
  registerInterceptorTypeForNamedType("Gio", "DBusServer",DBusServer);
  registerInterceptorTypeForNamedType("Gio", "DBusServerFlags",DBusServerFlags);
  registerInterceptorTypeForNamedType("Gio", "DBusSignalFlags",DBusSignalFlags);
  registerInterceptorTypeForNamedType("Gio", "DBusSignalInfo",DBusSignalInfo);
  registerInterceptorTypeForNamedType("Gio", "DBusSubtreeFlags",DBusSubtreeFlags);
  registerInterceptorTypeForNamedType("Gio", "DBusSubtreeVTable",DBusSubtreeVTable);
  registerInterceptorTypeForNamedType("Gio", "DataInputStream",DataInputStream);
  registerInterceptorTypeForNamedType("Gio", "DataOutputStream",DataOutputStream);
  registerInterceptorTypeForNamedType("Gio", "DataStreamByteOrder",DataStreamByteOrder);
  registerInterceptorTypeForNamedType("Gio", "DataStreamNewlineType",DataStreamNewlineType);
  registerInterceptorTypeForNamedType("Gio", "DesktopAppInfo",DesktopAppInfo);
  registerInterceptorTypeForNamedType("Gio", "DriveStartFlags",DriveStartFlags);
  registerInterceptorTypeForNamedType("Gio", "DriveStartStopType",DriveStartStopType);
  registerInterceptorTypeForNamedType("Gio", "Emblem",Emblem);
  registerInterceptorTypeForNamedType("Gio", "EmblemOrigin",EmblemOrigin);
  registerInterceptorTypeForNamedType("Gio", "EmblemedIcon",EmblemedIcon);
  registerInterceptorTypeForNamedType("Gio", "FileAttributeInfo",FileAttributeInfo);
  registerInterceptorTypeForNamedType("Gio", "FileAttributeInfoFlags",FileAttributeInfoFlags);
  registerInterceptorTypeForNamedType("Gio", "FileAttributeInfoList",FileAttributeInfoList);
  registerInterceptorTypeForNamedType("Gio", "FileAttributeMatcher",FileAttributeMatcher);
  registerInterceptorTypeForNamedType("Gio", "FileAttributeStatus",FileAttributeStatus);
  registerInterceptorTypeForNamedType("Gio", "FileAttributeType",FileAttributeType);
  registerInterceptorTypeForNamedType("Gio", "FileCopyFlags",FileCopyFlags);
  registerInterceptorTypeForNamedType("Gio", "FileCreateFlags",FileCreateFlags);
  registerInterceptorTypeForNamedType("Gio", "FileEnumerator",FileEnumerator);
  registerInterceptorTypeForNamedType("Gio", "FileIOStream",FileIOStream);
  registerInterceptorTypeForNamedType("Gio", "FileIcon",FileIcon);
  registerInterceptorTypeForNamedType("Gio", "FileInfo",FileInfo);
  registerInterceptorTypeForNamedType("Gio", "FileInputStream",FileInputStream);
  registerInterceptorTypeForNamedType("Gio", "FileMeasureFlags",FileMeasureFlags);
  registerInterceptorTypeForNamedType("Gio", "FileMonitor",FileMonitor);
  registerInterceptorTypeForNamedType("Gio", "FileMonitorEvent",FileMonitorEvent);
  registerInterceptorTypeForNamedType("Gio", "FileMonitorFlags",FileMonitorFlags);
  registerInterceptorTypeForNamedType("Gio", "FileOutputStream",FileOutputStream);
  registerInterceptorTypeForNamedType("Gio", "FileQueryInfoFlags",FileQueryInfoFlags);
  registerInterceptorTypeForNamedType("Gio", "FileType",FileType);
  registerInterceptorTypeForNamedType("Gio", "FilenameCompleter",FilenameCompleter);
  registerInterceptorTypeForNamedType("Gio", "FilesystemPreviewType",FilesystemPreviewType);
  registerInterceptorTypeForNamedType("Gio", "FilterInputStream",FilterInputStream);
  registerInterceptorTypeForNamedType("Gio", "FilterOutputStream",FilterOutputStream);
  registerInterceptorTypeForNamedType("Gio", "IOErrorEnum",IOErrorEnumCode);
  registerInterceptorTypeForNamedType("Gio", "IOExtension",IOExtension);
  registerInterceptorTypeForNamedType("Gio", "IOExtensionPoint",IOExtensionPoint);
  registerInterceptorTypeForNamedType("Gio", "IOModule",IOModule);
  registerInterceptorTypeForNamedType("Gio", "IOModuleScope",IOModuleScope);
  registerInterceptorTypeForNamedType("Gio", "IOModuleScopeFlags",IOModuleScopeFlags);
  registerInterceptorTypeForNamedType("Gio", "IOSchedulerJob",IOSchedulerJob);
  registerInterceptorTypeForNamedType("Gio", "IOStream",IOStream);
  registerInterceptorTypeForNamedType("Gio", "IOStreamAdapter",IOStreamAdapter);
  registerInterceptorTypeForNamedType("Gio", "IOStreamSpliceFlags",IOStreamSpliceFlags);
  registerInterceptorTypeForNamedType("Gio", "InetAddress",InetAddress);
  registerInterceptorTypeForNamedType("Gio", "InetAddressMask",InetAddressMask);
  registerInterceptorTypeForNamedType("Gio", "InetSocketAddress",InetSocketAddress);
  registerInterceptorTypeForNamedType("Gio", "InputStream",InputStream);
  registerInterceptorTypeForNamedType("Gio", "InputVector",InputVector);
  registerInterceptorTypeForNamedType("Gio", "ListStore",ListStore);
  registerInterceptorTypeForNamedType("Gio", "MemoryInputStream",MemoryInputStream);
  registerInterceptorTypeForNamedType("Gio", "MemoryOutputStream",MemoryOutputStream);
  registerInterceptorTypeForNamedType("Gio", "Menu",Menu);
  registerInterceptorTypeForNamedType("Gio", "MenuAttributeIter",MenuAttributeIter);
  registerInterceptorTypeForNamedType("Gio", "MenuItem",MenuItem);
  registerInterceptorTypeForNamedType("Gio", "MenuLinkIter",MenuLinkIter);
  registerInterceptorTypeForNamedType("Gio", "MenuModel",MenuModel);
  registerInterceptorTypeForNamedType("Gio", "MountMountFlags",MountMountFlags);
  registerInterceptorTypeForNamedType("Gio", "MountOperation",MountOperation);
  registerInterceptorTypeForNamedType("Gio", "MountOperationResult",MountOperationResult);
  registerInterceptorTypeForNamedType("Gio", "MountUnmountFlags",MountUnmountFlags);
  registerInterceptorTypeForNamedType("Gio", "NativeSocketAddress",NativeSocketAddress);
  registerInterceptorTypeForNamedType("Gio", "NativeVolumeMonitor",NativeVolumeMonitor);
  registerInterceptorTypeForNamedType("Gio", "NetworkAddress",NetworkAddress);
  registerInterceptorTypeForNamedType("Gio", "NetworkConnectivity",NetworkConnectivity);
  registerInterceptorTypeForNamedType("Gio", "NetworkService",NetworkService);
  registerInterceptorTypeForNamedType("Gio", "Notification",Notification);
  registerInterceptorTypeForNamedType("Gio", "NotificationPriority",NotificationPriority);
  registerInterceptorTypeForNamedType("Gio", "OutputMessage",OutputMessage);
  registerInterceptorTypeForNamedType("Gio", "OutputStream",OutputStream);
  registerInterceptorTypeForNamedType("Gio", "OutputStreamSpliceFlags",OutputStreamSpliceFlags);
  registerInterceptorTypeForNamedType("Gio", "OutputVector",OutputVector);
  registerInterceptorTypeForNamedType("Gio", "PasswordSave",PasswordSave);
  registerInterceptorTypeForNamedType("Gio", "Permission",Permission);
  registerInterceptorTypeForNamedType("Gio", "PropertyAction",PropertyAction);
  registerInterceptorTypeForNamedType("Gio", "ProxyAddress",ProxyAddress);
  registerInterceptorTypeForNamedType("Gio", "ProxyAddressEnumerator",ProxyAddressEnumerator);
  registerInterceptorTypeForNamedType("Gio", "Resolver",Resolver);
  registerInterceptorTypeForNamedType("Gio", "ResolverError",ResolverErrorCode);
  registerInterceptorTypeForNamedType("Gio", "ResolverRecordType",ResolverRecordType);
  registerInterceptorTypeForNamedType("Gio", "Resource",Resource);
  registerInterceptorTypeForNamedType("Gio", "ResourceError",ResourceErrorCode);
  registerInterceptorTypeForNamedType("Gio", "ResourceFlags",ResourceFlags);
  registerInterceptorTypeForNamedType("Gio", "ResourceLookupFlags",ResourceLookupFlags);
  registerInterceptorTypeForNamedType("Gio", "Settings",Settings);
  registerInterceptorTypeForNamedType("Gio", "SettingsBackend",SettingsBackend);
  registerInterceptorTypeForNamedType("Gio", "SettingsBindFlags",SettingsBindFlags);
  registerInterceptorTypeForNamedType("Gio", "SettingsSchema",SettingsSchema);
  registerInterceptorTypeForNamedType("Gio", "SettingsSchemaKey",SettingsSchemaKey);
  registerInterceptorTypeForNamedType("Gio", "SettingsSchemaSource",SettingsSchemaSource);
  registerInterceptorTypeForNamedType("Gio", "SimpleAction",SimpleAction);
  registerInterceptorTypeForNamedType("Gio", "SimpleActionGroup",SimpleActionGroup);
  registerInterceptorTypeForNamedType("Gio", "SimpleAsyncResult",SimpleAsyncResult);
  registerInterceptorTypeForNamedType("Gio", "SimpleIOStream",SimpleIOStream);
  registerInterceptorTypeForNamedType("Gio", "SimplePermission",SimplePermission);
  registerInterceptorTypeForNamedType("Gio", "SimpleProxyResolver",SimpleProxyResolver);
  registerInterceptorTypeForNamedType("Gio", "Socket",Socket);
  registerInterceptorTypeForNamedType("Gio", "SocketAddress",SocketAddress);
  registerInterceptorTypeForNamedType("Gio", "SocketAddressEnumerator",SocketAddressEnumerator);
  registerInterceptorTypeForNamedType("Gio", "SocketClient",SocketClient);
  registerInterceptorTypeForNamedType("Gio", "SocketClientEvent",SocketClientEvent);
  registerInterceptorTypeForNamedType("Gio", "SocketConnection",SocketConnection);
  registerInterceptorTypeForNamedType("Gio", "SocketControlMessage",SocketControlMessage);
  registerInterceptorTypeForNamedType("Gio", "SocketFamily",SocketFamily);
  registerInterceptorTypeForNamedType("Gio", "SocketListener",SocketListener);
  registerInterceptorTypeForNamedType("Gio", "SocketListenerEvent",SocketListenerEvent);
  registerInterceptorTypeForNamedType("Gio", "SocketMsgFlags",SocketMsgFlags);
  registerInterceptorTypeForNamedType("Gio", "SocketProtocol",SocketProtocol);
  registerInterceptorTypeForNamedType("Gio", "SocketService",SocketService);
  registerInterceptorTypeForNamedType("Gio", "SocketType",SocketType);
  registerInterceptorTypeForNamedType("Gio", "SrvTarget",SrvTarget);
  registerInterceptorTypeForNamedType("Gio", "StaticResource",StaticResource);
  registerInterceptorTypeForNamedType("Gio", "Subprocess",Subprocess);
  registerInterceptorTypeForNamedType("Gio", "SubprocessFlags",SubprocessFlags);
  registerInterceptorTypeForNamedType("Gio", "SubprocessLauncher",SubprocessLauncher);
  registerInterceptorTypeForNamedType("Gio", "Task",Task);
  registerInterceptorTypeForNamedType("Gio", "TcpConnection",TcpConnection);
  registerInterceptorTypeForNamedType("Gio", "TcpWrapperConnection",TcpWrapperConnection);
  registerInterceptorTypeForNamedType("Gio", "TestDBus",TestDBus);
  registerInterceptorTypeForNamedType("Gio", "TestDBusFlags",TestDBusFlags);
  registerInterceptorTypeForNamedType("Gio", "ThemedIcon",ThemedIcon);
  registerInterceptorTypeForNamedType("Gio", "ThreadedSocketService",ThreadedSocketService);
  registerInterceptorTypeForNamedType("Gio", "TlsAuthenticationMode",TlsAuthenticationMode);
  registerInterceptorTypeForNamedType("Gio", "TlsCertificate",TlsCertificate);
  registerInterceptorTypeForNamedType("Gio", "TlsCertificateFlags",TlsCertificateFlags);
  registerInterceptorTypeForNamedType("Gio", "TlsCertificateRequestFlags",TlsCertificateRequestFlags);
  registerInterceptorTypeForNamedType("Gio", "TlsConnection",TlsConnection);
  registerInterceptorTypeForNamedType("Gio", "TlsDatabase",TlsDatabase);
  registerInterceptorTypeForNamedType("Gio", "TlsDatabaseLookupFlags",TlsDatabaseLookupFlags);
  registerInterceptorTypeForNamedType("Gio", "TlsDatabaseVerifyFlags",TlsDatabaseVerifyFlags);
  registerInterceptorTypeForNamedType("Gio", "TlsError",TlsErrorCode);
  registerInterceptorTypeForNamedType("Gio", "TlsInteraction",TlsInteraction);
  registerInterceptorTypeForNamedType("Gio", "TlsInteractionResult",TlsInteractionResult);
  registerInterceptorTypeForNamedType("Gio", "TlsPassword",TlsPassword);
  registerInterceptorTypeForNamedType("Gio", "TlsPasswordFlags",TlsPasswordFlags);
  registerInterceptorTypeForNamedType("Gio", "TlsRehandshakeMode",TlsRehandshakeMode);
  registerInterceptorTypeForNamedType("Gio", "UnixConnection",UnixConnection);
  registerInterceptorTypeForNamedType("Gio", "UnixCredentialsMessage",UnixCredentialsMessage);
  registerInterceptorTypeForNamedType("Gio", "UnixFDList",UnixFDList);
  registerInterceptorTypeForNamedType("Gio", "UnixFDMessage",UnixFDMessage);
  registerInterceptorTypeForNamedType("Gio", "UnixInputStream",UnixInputStream);
  registerInterceptorTypeForNamedType("Gio", "UnixMountEntry",UnixMountEntry);
  registerInterceptorTypeForNamedType("Gio", "UnixMountMonitor",UnixMountMonitor);
  registerInterceptorTypeForNamedType("Gio", "UnixMountPoint",UnixMountPoint);
  registerInterceptorTypeForNamedType("Gio", "UnixOutputStream",UnixOutputStream);
  registerInterceptorTypeForNamedType("Gio", "UnixSocketAddress",UnixSocketAddress);
  registerInterceptorTypeForNamedType("Gio", "UnixSocketAddressType",UnixSocketAddressType);
  registerInterceptorTypeForNamedType("Gio", "Vfs",Vfs);
  registerInterceptorTypeForNamedType("Gio", "VolumeMonitor",VolumeMonitor);
  registerInterceptorTypeForNamedType("Gio", "ZlibCompressor",ZlibCompressor);
  registerInterceptorTypeForNamedType("Gio", "ZlibCompressorFormat",ZlibCompressorFormat);
  registerInterceptorTypeForNamedType("Gio", "ZlibDecompressor",ZlibDecompressor);
  registerInterceptorTypeForErrorDomain("g-dbus-error-quark", DBusError);
  registerInterceptorTypeForErrorDomain("g-io-error-quark", IOErrorEnum);
  registerInterceptorTypeForErrorDomain("g-resolver-error-quark", ResolverError);
  registerInterceptorTypeForErrorDomain("g-resource-error-quark", ResourceError);
  registerInterceptorTypeForErrorDomain("g-tls-error-quark", TlsError);
}
