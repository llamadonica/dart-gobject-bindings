library glib.gdart;

import "gdart.dart";
import "girepository.dart" as girepository;

class Array extends GObjectBase {
  Array.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'Array');

  String get data => getFieldOfObject('data', 0);
  void set data(String value) => setFieldOfObject('data', 0, value);
  int get len => getFieldOfObject('len', 1);
  void set len(int value) => setFieldOfObject('len', 1, value);
}

class AsciiType extends GEnumBase {
  const AsciiType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'AsciiType');

  static const AsciiType NULL = const AsciiType(0);
  static const AsciiType ALNUM = const AsciiType(1);
  bool get alnum => (index & 1) == 1;
  static const AsciiType ALPHA = const AsciiType(2);
  bool get alpha => (index & 2) == 2;
  static const AsciiType CNTRL = const AsciiType(4);
  bool get cntrl => (index & 4) == 4;
  static const AsciiType DIGIT = const AsciiType(8);
  bool get digit => (index & 8) == 8;
  static const AsciiType GRAPH = const AsciiType(16);
  bool get graph => (index & 16) == 16;
  static const AsciiType LOWER = const AsciiType(32);
  bool get lower => (index & 32) == 32;
  static const AsciiType PRINT = const AsciiType(64);
  bool get print => (index & 64) == 64;
  static const AsciiType PUNCT = const AsciiType(128);
  bool get punct => (index & 128) == 128;
  static const AsciiType SPACE = const AsciiType(256);
  bool get space => (index & 256) == 256;
  static const AsciiType UPPER = const AsciiType(512);
  bool get upper => (index & 512) == 512;
  static const AsciiType XDIGIT = const AsciiType(1024);
  bool get xdigit => (index & 1024) == 1024;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'AsciiType.ALNUM';
      case 2: return 'AsciiType.ALPHA';
      case 4: return 'AsciiType.CNTRL';
      case 8: return 'AsciiType.DIGIT';
      case 16: return 'AsciiType.GRAPH';
      case 32: return 'AsciiType.LOWER';
      case 64: return 'AsciiType.PRINT';
      case 128: return 'AsciiType.PUNCT';
      default: return 'new AsciiType($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'AsciiType.NULL';
    }
    List codes = [];
    for (var i=1; i <= 1024; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  AsciiType operator|(AsciiType other) =>
    new AsciiType(index | other.index);
  AsciiType operator&(AsciiType other) =>
    new AsciiType(index & other.index);
}

class AsyncQueue extends GObjectBase {
  AsyncQueue.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'AsyncQueue');

  int length() => _staticInfo.callMethodOnReceiver('length', this, []);
  int lengthUnlocked() => _staticInfo.callMethodOnReceiver('length_unlocked', this, []);
  void lock() => _staticInfo.callMethodOnReceiver('lock', this, []);
  void push(dynamic data /* this will fail */) => _staticInfo.callMethodOnReceiver('push', this, [data]);
  void pushFront(dynamic item /* this will fail */) => _staticInfo.callMethodOnReceiver('push_front', this, [item]);
  void pushFrontUnlocked(dynamic item /* this will fail */) => _staticInfo.callMethodOnReceiver('push_front_unlocked', this, [item]);
  void pushUnlocked(dynamic data /* this will fail */) => _staticInfo.callMethodOnReceiver('push_unlocked', this, [data]);
  void refUnlocked() => _staticInfo.callMethodOnReceiver('ref_unlocked', this, []);
  bool remove(dynamic item /* this will fail */) => _staticInfo.callMethodOnReceiver('remove', this, [item]);
  bool removeUnlocked(dynamic item /* this will fail */) => _staticInfo.callMethodOnReceiver('remove_unlocked', this, [item]);
  void unlock() => _staticInfo.callMethodOnReceiver('unlock', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
  void unrefAndUnlock() => _staticInfo.callMethodOnReceiver('unref_and_unlock', this, []);
}

class BookmarkFile extends GObjectBase {
  BookmarkFile.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'BookmarkFile');

  void addApplication(String uri, String name, String exec) => _staticInfo.callMethodOnReceiver('add_application', this, [uri, name, exec]);
  void addGroup(String uri, String group) => _staticInfo.callMethodOnReceiver('add_group', this, [uri, group]);
  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
  int getAdded(String uri) => _staticInfo.callMethodOnReceiver('get_added', this, [uri]);
  List getAppInfo(String uri, String name) => _staticInfo.callMethodOnReceiver('get_app_info', this, [uri, name]);
  List getApplications(String uri) => _staticInfo.callMethodOnReceiver('get_applications', this, [uri]);
  String getDescription(String uri) => _staticInfo.callMethodOnReceiver('get_description', this, [uri]);
  List getGroups(String uri) => _staticInfo.callMethodOnReceiver('get_groups', this, [uri]);
  List getIcon(String uri) => _staticInfo.callMethodOnReceiver('get_icon', this, [uri]);
  void getIsPrivate(String uri) => _staticInfo.callMethodOnReceiver('get_is_private', this, [uri]);
  String getMimeType(String uri) => _staticInfo.callMethodOnReceiver('get_mime_type', this, [uri]);
  int getModified(String uri) => _staticInfo.callMethodOnReceiver('get_modified', this, [uri]);
  int get size => _staticInfo.callMethodOnReceiver('get_size', this, []);
  String getTitle(String uri) => _staticInfo.callMethodOnReceiver('get_title', this, [uri]);
  List getUris() => _staticInfo.callMethodOnReceiver('get_uris', this, []);
  int getVisited(String uri) => _staticInfo.callMethodOnReceiver('get_visited', this, [uri]);
  void hasApplication(String uri, String name) => _staticInfo.callMethodOnReceiver('has_application', this, [uri, name]);
  void hasGroup(String uri, String group) => _staticInfo.callMethodOnReceiver('has_group', this, [uri, group]);
  bool hasItem(String uri) => _staticInfo.callMethodOnReceiver('has_item', this, [uri]);
  void loadFromData(String data, int length) => _staticInfo.callMethodOnReceiver('load_from_data', this, [data, length]);
  void loadFromDataDirs(String file, String fullPath) => _staticInfo.callMethodOnReceiver('load_from_data_dirs', this, [file, fullPath]);
  void loadFromFile(String filename) => _staticInfo.callMethodOnReceiver('load_from_file', this, [filename]);
  void moveItem(String oldUri, String newUri) => _staticInfo.callMethodOnReceiver('move_item', this, [oldUri, newUri]);
  void removeApplication(String uri, String name) => _staticInfo.callMethodOnReceiver('remove_application', this, [uri, name]);
  void removeGroup(String uri, String group) => _staticInfo.callMethodOnReceiver('remove_group', this, [uri, group]);
  void removeItem(String uri) => _staticInfo.callMethodOnReceiver('remove_item', this, [uri]);
  void setAdded(String uri, int added) => _staticInfo.callMethodOnReceiver('set_added', this, [uri, added]);
  void setAppInfo(String uri, String name, String exec, int count, int stamp) => _staticInfo.callMethodOnReceiver('set_app_info', this, [uri, name, exec, count, stamp]);
  void setDescription(String uri, String description) => _staticInfo.callMethodOnReceiver('set_description', this, [uri, description]);
  void setGroups(String uri, String groups, int length) => _staticInfo.callMethodOnReceiver('set_groups', this, [uri, groups, length]);
  void setIcon(String uri, String href, String mimeType) => _staticInfo.callMethodOnReceiver('set_icon', this, [uri, href, mimeType]);
  void setIsPrivate(String uri, bool isPrivate) => _staticInfo.callMethodOnReceiver('set_is_private', this, [uri, isPrivate]);
  void setMimeType(String uri, String mimeType) => _staticInfo.callMethodOnReceiver('set_mime_type', this, [uri, mimeType]);
  void setModified(String uri, int modified) => _staticInfo.callMethodOnReceiver('set_modified', this, [uri, modified]);
  void setTitle(String uri, String title) => _staticInfo.callMethodOnReceiver('set_title', this, [uri, title]);
  void setVisited(String uri, int visited) => _staticInfo.callMethodOnReceiver('set_visited', this, [uri, visited]);
  List toData() => _staticInfo.callMethodOnReceiver('to_data', this, []);
  void toFile(String filename) => _staticInfo.callMethodOnReceiver('to_file', this, [filename]);
  static int errorQuark() => _staticInfo.callStatic('error_quark', []);
}

class BookmarkFileErrorCode extends GEnumBase {
  const BookmarkFileErrorCode(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'BookmarkFileError');

  static const BookmarkFileErrorCode INVALID_URI = const BookmarkFileErrorCode(0);
  static const BookmarkFileErrorCode INVALID_VALUE = const BookmarkFileErrorCode(1);
  static const BookmarkFileErrorCode APP_NOT_REGISTERED = const BookmarkFileErrorCode(2);
  static const BookmarkFileErrorCode URI_NOT_FOUND = const BookmarkFileErrorCode(3);
  static const BookmarkFileErrorCode READ = const BookmarkFileErrorCode(4);
  static const BookmarkFileErrorCode UNKNOWN_ENCODING = const BookmarkFileErrorCode(5);
  static const BookmarkFileErrorCode WRITE = const BookmarkFileErrorCode(6);
  static const BookmarkFileErrorCode FILE_NOT_FOUND = const BookmarkFileErrorCode(7);
  String toString() {
    switch(index) {
      case 0: return 'BookmarkFileErrorCode.INVALID_URI';
      case 1: return 'BookmarkFileErrorCode.INVALID_VALUE';
      case 2: return 'BookmarkFileErrorCode.APP_NOT_REGISTERED';
      case 3: return 'BookmarkFileErrorCode.URI_NOT_FOUND';
      case 4: return 'BookmarkFileErrorCode.READ';
      case 5: return 'BookmarkFileErrorCode.UNKNOWN_ENCODING';
      case 6: return 'BookmarkFileErrorCode.WRITE';
      case 7: return 'BookmarkFileErrorCode.FILE_NOT_FOUND';
      default: return 'new BookmarkFileErrorCode($index)';
    }
  }
}

class BookmarkFileError extends GErrorBase {
  static final int _quark = lookupErrorQuarkFromString('g-bookmark-file-error-quark');
  BookmarkFileError(BookmarkFileErrorCode code, String message)
      : super.fromFields(_quark, code, message);
}

class ByteArray extends GObjectBase {
  ByteArray.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'ByteArray');

  static int free(List<int> array, bool freeSegment) => _staticInfo.callStatic('free', [array, freeSegment]);
  static Bytes freeToBytes(List<int> array) => _staticInfo.callStatic('free_to_bytes', [array]);
  static List<int> new_() => _staticInfo.callStatic('new', []);
  static List<int> newTake(List<int> data) => _staticInfo.callStatic('new_take', [data]);
  static void unref(List<int> array) => _staticInfo.callStatic('unref', [array]);
  int get data => getFieldOfObject('data', 0);
  void set data(int value) => setFieldOfObject('data', 0, value);
  int get len => getFieldOfObject('len', 1);
  void set len(int value) => setFieldOfObject('len', 1, value);
}

class Bytes extends GObjectBase {
  Bytes.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'Bytes');

  factory Bytes(List<int> data) => _staticInfo.callStatic('new', [data]);
  factory Bytes.take(List<int> data) => _staticInfo.callStatic('new_take', [data]);
  int compare(Bytes bytes2) => _staticInfo.callMethodOnReceiver('compare', this, [bytes2]);
  bool equal(Bytes bytes2) => _staticInfo.callMethodOnReceiver('equal', this, [bytes2]);
  List getData() => _staticInfo.callMethodOnReceiver('get_data', this, []);
  int get size => _staticInfo.callMethodOnReceiver('get_size', this, []);
  int hash() => _staticInfo.callMethodOnReceiver('hash', this, []);
  Bytes newFromBytes(int offset, int length) => _staticInfo.callMethodOnReceiver('new_from_bytes', this, [offset, length]);
  Bytes ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
  List<int> unrefToArray() => _staticInfo.callMethodOnReceiver('unref_to_array', this, []);
  void unrefToData(int size) => _staticInfo.callMethodOnReceiver('unref_to_data', this, [size]);
}

class Checksum extends GObjectBase {
  Checksum.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'Checksum');

  factory Checksum(ChecksumType checksumType) => _staticInfo.callStatic('new', [checksumType]);
  Checksum copy() => _staticInfo.callMethodOnReceiver('copy', this, []);
  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
  String get string => _staticInfo.callMethodOnReceiver('get_string', this, []);
  void reset() => _staticInfo.callMethodOnReceiver('reset', this, []);
  void update(List<int> data) => _staticInfo.callMethodOnReceiver('update', this, [data]);
  static int typeGetLength(ChecksumType checksumType) => _staticInfo.callStatic('type_get_length', [checksumType]);
}

class ChecksumType extends GEnumBase {
  const ChecksumType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'ChecksumType');

  static const ChecksumType MD5 = const ChecksumType(0);
  static const ChecksumType SHA1 = const ChecksumType(1);
  static const ChecksumType SHA256 = const ChecksumType(2);
  static const ChecksumType SHA512 = const ChecksumType(3);
  String toString() {
    switch(index) {
      case 0: return 'ChecksumType.MD5';
      case 1: return 'ChecksumType.SHA1';
      case 2: return 'ChecksumType.SHA256';
      case 3: return 'ChecksumType.SHA512';
      default: return 'new ChecksumType($index)';
    }
  }
}

typedef void ChildWatchFunc(int pid, int status);
typedef int CompareDataFunc(dynamic a /* this will fail */, dynamic b /* this will fail */);
typedef int CompareFunc(dynamic a /* this will fail */);
class Cond extends GObjectBase {
  Cond.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'Cond');

  void broadcast() => _staticInfo.callMethodOnReceiver('broadcast', this, []);
  void clear() => _staticInfo.callMethodOnReceiver('clear', this, []);
  void init() => _staticInfo.callMethodOnReceiver('init', this, []);
  void signal() => _staticInfo.callMethodOnReceiver('signal', this, []);
  void wait(Mutex mutex) => _staticInfo.callMethodOnReceiver('wait', this, [mutex]);
  bool waitUntil(Mutex mutex, int endTime) => _staticInfo.callMethodOnReceiver('wait_until', this, [mutex, endTime]);
  dynamic /* this will fail */ get p => getFieldOfObject('p', 0);
  List<int> get i => getFieldOfObject('i', 1);
}

class ConvertErrorCode extends GEnumBase {
  const ConvertErrorCode(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'ConvertError');

  static const ConvertErrorCode NO_CONVERSION = const ConvertErrorCode(0);
  static const ConvertErrorCode ILLEGAL_SEQUENCE = const ConvertErrorCode(1);
  static const ConvertErrorCode FAILED = const ConvertErrorCode(2);
  static const ConvertErrorCode PARTIAL_INPUT = const ConvertErrorCode(3);
  static const ConvertErrorCode BAD_URI = const ConvertErrorCode(4);
  static const ConvertErrorCode NOT_ABSOLUTE_PATH = const ConvertErrorCode(5);
  static const ConvertErrorCode NO_MEMORY = const ConvertErrorCode(6);
  String toString() {
    switch(index) {
      case 0: return 'ConvertErrorCode.NO_CONVERSION';
      case 1: return 'ConvertErrorCode.ILLEGAL_SEQUENCE';
      case 2: return 'ConvertErrorCode.FAILED';
      case 3: return 'ConvertErrorCode.PARTIAL_INPUT';
      case 4: return 'ConvertErrorCode.BAD_URI';
      case 5: return 'ConvertErrorCode.NOT_ABSOLUTE_PATH';
      case 6: return 'ConvertErrorCode.NO_MEMORY';
      default: return 'new ConvertErrorCode($index)';
    }
  }
}

class ConvertError extends GErrorBase {
  static final int _quark = lookupErrorQuarkFromString('g_convert_error');
  ConvertError(ConvertErrorCode code, String message)
      : super.fromFields(_quark, code, message);
}

class Data extends GObjectBase {
  Data.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'Data');

}

typedef void DataForeachFunc(int keyId, dynamic data /* this will fail */);
class Date extends GObjectBase {
  Date.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'Date');

  factory Date() => _staticInfo.callStatic('new', []);
  factory Date.dmy(int day, DateMonth month, int year) => _staticInfo.callStatic('new_dmy', [day, month, year]);
  factory Date.fromJulian(int julianDay) => _staticInfo.callStatic('new_julian', [julianDay]);
  void addDays(int nDays) => _staticInfo.callMethodOnReceiver('add_days', this, [nDays]);
  void addMonths(int nMonths) => _staticInfo.callMethodOnReceiver('add_months', this, [nMonths]);
  void addYears(int nYears) => _staticInfo.callMethodOnReceiver('add_years', this, [nYears]);
  void clamp(Date minDate, Date maxDate) => _staticInfo.callMethodOnReceiver('clamp', this, [minDate, maxDate]);
  void clear(int nDates) => _staticInfo.callMethodOnReceiver('clear', this, [nDates]);
  int compare(Date rhs) => _staticInfo.callMethodOnReceiver('compare', this, [rhs]);
  int daysBetween(Date date2) => _staticInfo.callMethodOnReceiver('days_between', this, [date2]);
  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
  int get day => _staticInfo.callMethodOnReceiver('get_day', this, []);
  int get dayOfYear => _staticInfo.callMethodOnReceiver('get_day_of_year', this, []);
  int get iso8601WeekOfYear => _staticInfo.callMethodOnReceiver('get_iso8601_week_of_year', this, []);
  int get julian_ => _staticInfo.callMethodOnReceiver('get_julian', this, []);
  int get mondayWeekOfYear => _staticInfo.callMethodOnReceiver('get_monday_week_of_year', this, []);
  DateMonth get month => _staticInfo.callMethodOnReceiver('get_month', this, []);
  int get sundayWeekOfYear => _staticInfo.callMethodOnReceiver('get_sunday_week_of_year', this, []);
  DateWeekday get weekday => _staticInfo.callMethodOnReceiver('get_weekday', this, []);
  int get year => _staticInfo.callMethodOnReceiver('get_year', this, []);
  bool isFirstOfMonth() => _staticInfo.callMethodOnReceiver('is_first_of_month', this, []);
  bool isLastOfMonth() => _staticInfo.callMethodOnReceiver('is_last_of_month', this, []);
  void order(Date date2) => _staticInfo.callMethodOnReceiver('order', this, [date2]);
  void set day(int day) => _staticInfo.callMethodOnReceiver('set_day', this, [day]);
  void setDmy(int day, DateMonth month, int y) => _staticInfo.callMethodOnReceiver('set_dmy', this, [day, month, y]);
  void set julian(int julianDate) => _staticInfo.callMethodOnReceiver('set_julian', this, [julianDate]);
  void set month(DateMonth month) => _staticInfo.callMethodOnReceiver('set_month', this, [month]);
  void setParse(String str) => _staticInfo.callMethodOnReceiver('set_parse', this, [str]);
  void setTime(int time_) => _staticInfo.callMethodOnReceiver('set_time', this, [time_]);
  void setTimeT(int timet) => _staticInfo.callMethodOnReceiver('set_time_t', this, [timet]);
  void setTimeVal(TimeVal timeval) => _staticInfo.callMethodOnReceiver('set_time_val', this, [timeval]);
  void set year(int year) => _staticInfo.callMethodOnReceiver('set_year', this, [year]);
  void subtractDays(int nDays) => _staticInfo.callMethodOnReceiver('subtract_days', this, [nDays]);
  void subtractMonths(int nMonths) => _staticInfo.callMethodOnReceiver('subtract_months', this, [nMonths]);
  void subtractYears(int nYears) => _staticInfo.callMethodOnReceiver('subtract_years', this, [nYears]);
  void toStructTm(dynamic tm /* this will fail */) => _staticInfo.callMethodOnReceiver('to_struct_tm', this, [tm]);
  bool valid() => _staticInfo.callMethodOnReceiver('valid', this, []);
  static int getDaysInMonth(DateMonth month, int year) => _staticInfo.callStatic('get_days_in_month', [month, year]);
  static int getMondayWeeksInYear(int year) => _staticInfo.callStatic('get_monday_weeks_in_year', [year]);
  static int getSundayWeeksInYear(int year) => _staticInfo.callStatic('get_sunday_weeks_in_year', [year]);
  static bool isLeapYear(int year) => _staticInfo.callStatic('is_leap_year', [year]);
  static int strftime(String s, int slen, String format, Date date) => _staticInfo.callStatic('strftime', [s, slen, format, date]);
  static bool validDay(int day) => _staticInfo.callStatic('valid_day', [day]);
  static bool validDmy(int day, DateMonth month, int year) => _staticInfo.callStatic('valid_dmy', [day, month, year]);
  static bool validJulian(int julianDate) => _staticInfo.callStatic('valid_julian', [julianDate]);
  static bool validMonth(DateMonth month) => _staticInfo.callStatic('valid_month', [month]);
  static bool validWeekday(DateWeekday weekday) => _staticInfo.callStatic('valid_weekday', [weekday]);
  static bool validYear(int year) => _staticInfo.callStatic('valid_year', [year]);
  int get julianDays => getFieldOfObject('julian_days', 0);
  void set julianDays(int value) => setFieldOfObject('julian_days', 0, value);
}

class DateDMY extends GEnumBase {
  const DateDMY(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'DateDMY');

  static const DateDMY DAY = const DateDMY(0);
  static const DateDMY MONTH = const DateDMY(1);
  static const DateDMY YEAR = const DateDMY(2);
  String toString() {
    switch(index) {
      case 0: return 'DateDMY.DAY';
      case 1: return 'DateDMY.MONTH';
      case 2: return 'DateDMY.YEAR';
      default: return 'new DateDMY($index)';
    }
  }
}

class DateMonth extends GEnumBase {
  const DateMonth(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'DateMonth');

  static const DateMonth BAD_MONTH = const DateMonth(0);
  static const DateMonth JANUARY = const DateMonth(1);
  static const DateMonth FEBRUARY = const DateMonth(2);
  static const DateMonth MARCH = const DateMonth(3);
  static const DateMonth APRIL = const DateMonth(4);
  static const DateMonth MAY = const DateMonth(5);
  static const DateMonth JUNE = const DateMonth(6);
  static const DateMonth JULY = const DateMonth(7);
  static const DateMonth AUGUST = const DateMonth(8);
  static const DateMonth SEPTEMBER = const DateMonth(9);
  static const DateMonth OCTOBER = const DateMonth(10);
  static const DateMonth NOVEMBER = const DateMonth(11);
  static const DateMonth DECEMBER = const DateMonth(12);
  String toString() {
    switch(index) {
      case 0: return 'DateMonth.BAD_MONTH';
      case 1: return 'DateMonth.JANUARY';
      case 2: return 'DateMonth.FEBRUARY';
      case 3: return 'DateMonth.MARCH';
      case 4: return 'DateMonth.APRIL';
      case 5: return 'DateMonth.MAY';
      case 6: return 'DateMonth.JUNE';
      case 7: return 'DateMonth.JULY';
      case 8: return 'DateMonth.AUGUST';
      case 9: return 'DateMonth.SEPTEMBER';
      case 10: return 'DateMonth.OCTOBER';
      case 11: return 'DateMonth.NOVEMBER';
      case 12: return 'DateMonth.DECEMBER';
      default: return 'new DateMonth($index)';
    }
  }
}

class GLibDateTime extends GObjectBase {
  GLibDateTime.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'DateTime');

  factory GLibDateTime(TimeZone tz, int year, int month, int day, int hour, int minute, num seconds) => _staticInfo.callStatic('new', [tz, year, month, day, hour, minute, seconds]);
  factory GLibDateTime.fromTimevalLocal(TimeVal tv) => _staticInfo.callStatic('new_from_timeval_local', [tv]);
  factory GLibDateTime.fromTimevalUtc(TimeVal tv) => _staticInfo.callStatic('new_from_timeval_utc', [tv]);
  factory GLibDateTime.fromUnixLocal(int t) => _staticInfo.callStatic('new_from_unix_local', [t]);
  factory GLibDateTime.fromUnixUtc(int t) => _staticInfo.callStatic('new_from_unix_utc', [t]);
  factory GLibDateTime.local(int year, int month, int day, int hour, int minute, num seconds) => _staticInfo.callStatic('new_local', [year, month, day, hour, minute, seconds]);
  factory GLibDateTime.now(TimeZone tz) => _staticInfo.callStatic('new_now', [tz]);
  factory GLibDateTime.nowLocal() => _staticInfo.callStatic('new_now_local', []);
  factory GLibDateTime.nowUtc() => _staticInfo.callStatic('new_now_utc', []);
  factory GLibDateTime.utc(int year, int month, int day, int hour, int minute, num seconds) => _staticInfo.callStatic('new_utc', [year, month, day, hour, minute, seconds]);
  GLibDateTime add(int timespan) => _staticInfo.callMethodOnReceiver('add', this, [timespan]);
  GLibDateTime addDays(int days) => _staticInfo.callMethodOnReceiver('add_days', this, [days]);
  GLibDateTime addFull(int years, int months, int days, int hours, int minutes, num seconds) => _staticInfo.callMethodOnReceiver('add_full', this, [years, months, days, hours, minutes, seconds]);
  GLibDateTime addHours(int hours) => _staticInfo.callMethodOnReceiver('add_hours', this, [hours]);
  GLibDateTime addMinutes(int minutes) => _staticInfo.callMethodOnReceiver('add_minutes', this, [minutes]);
  GLibDateTime addMonths(int months) => _staticInfo.callMethodOnReceiver('add_months', this, [months]);
  GLibDateTime addSeconds(num seconds) => _staticInfo.callMethodOnReceiver('add_seconds', this, [seconds]);
  GLibDateTime addWeeks(int weeks) => _staticInfo.callMethodOnReceiver('add_weeks', this, [weeks]);
  GLibDateTime addYears(int years) => _staticInfo.callMethodOnReceiver('add_years', this, [years]);
  int difference(GLibDateTime begin) => _staticInfo.callMethodOnReceiver('difference', this, [begin]);
  String format(String format) => _staticInfo.callMethodOnReceiver('format', this, [format]);
  int get dayOfMonth => _staticInfo.callMethodOnReceiver('get_day_of_month', this, []);
  int get dayOfWeek => _staticInfo.callMethodOnReceiver('get_day_of_week', this, []);
  int get dayOfYear => _staticInfo.callMethodOnReceiver('get_day_of_year', this, []);
  int get hour => _staticInfo.callMethodOnReceiver('get_hour', this, []);
  int get microsecond => _staticInfo.callMethodOnReceiver('get_microsecond', this, []);
  int get minute => _staticInfo.callMethodOnReceiver('get_minute', this, []);
  int get month => _staticInfo.callMethodOnReceiver('get_month', this, []);
  int get second => _staticInfo.callMethodOnReceiver('get_second', this, []);
  num get seconds => _staticInfo.callMethodOnReceiver('get_seconds', this, []);
  String get timezoneAbbreviation => _staticInfo.callMethodOnReceiver('get_timezone_abbreviation', this, []);
  int get utcOffset => _staticInfo.callMethodOnReceiver('get_utc_offset', this, []);
  int get weekNumberingYear => _staticInfo.callMethodOnReceiver('get_week_numbering_year', this, []);
  int get weekOfYear => _staticInfo.callMethodOnReceiver('get_week_of_year', this, []);
  int get year => _staticInfo.callMethodOnReceiver('get_year', this, []);
  List getYmd() => _staticInfo.callMethodOnReceiver('get_ymd', this, []);
  bool isDaylightSavings() => _staticInfo.callMethodOnReceiver('is_daylight_savings', this, []);
  GLibDateTime ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  GLibDateTime toLocal() => _staticInfo.callMethodOnReceiver('to_local', this, []);
  bool toTimeval(TimeVal tv) => _staticInfo.callMethodOnReceiver('to_timeval', this, [tv]);
  GLibDateTime toTimezone(TimeZone tz) => _staticInfo.callMethodOnReceiver('to_timezone', this, [tz]);
  int toUnix() => _staticInfo.callMethodOnReceiver('to_unix', this, []);
  GLibDateTime toUtc() => _staticInfo.callMethodOnReceiver('to_utc', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
  static int compare(dynamic dt1 /* this will fail */, dynamic dt2 /* this will fail */) => _staticInfo.callStatic('compare', [dt1, dt2]);
  static bool equal(dynamic dt1 /* this will fail */, dynamic dt2 /* this will fail */) => _staticInfo.callStatic('equal', [dt1, dt2]);
  static int hash(dynamic datetime /* this will fail */) => _staticInfo.callStatic('hash', [datetime]);
}

class DateWeekday extends GEnumBase {
  const DateWeekday(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'DateWeekday');

  static const DateWeekday BAD_WEEKDAY = const DateWeekday(0);
  static const DateWeekday MONDAY = const DateWeekday(1);
  static const DateWeekday TUESDAY = const DateWeekday(2);
  static const DateWeekday WEDNESDAY = const DateWeekday(3);
  static const DateWeekday THURSDAY = const DateWeekday(4);
  static const DateWeekday FRIDAY = const DateWeekday(5);
  static const DateWeekday SATURDAY = const DateWeekday(6);
  static const DateWeekday SUNDAY = const DateWeekday(7);
  String toString() {
    switch(index) {
      case 0: return 'DateWeekday.BAD_WEEKDAY';
      case 1: return 'DateWeekday.MONDAY';
      case 2: return 'DateWeekday.TUESDAY';
      case 3: return 'DateWeekday.WEDNESDAY';
      case 4: return 'DateWeekday.THURSDAY';
      case 5: return 'DateWeekday.FRIDAY';
      case 6: return 'DateWeekday.SATURDAY';
      case 7: return 'DateWeekday.SUNDAY';
      default: return 'new DateWeekday($index)';
    }
  }
}

class DebugKey extends GObjectBase {
  DebugKey.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'DebugKey');

  String get key => getFieldOfObject('key', 0);
  void set key(String value) => setFieldOfObject('key', 0, value);
  int get value => getFieldOfObject('value', 1);
  void set value(int value) => setFieldOfObject('value', 1, value);
}

typedef void DestroyNotify();
class Dir extends GObjectBase {
  Dir.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'Dir');

  void close() => _staticInfo.callMethodOnReceiver('close', this, []);
  String readName() => _staticInfo.callMethodOnReceiver('read_name', this, []);
  void rewind() => _staticInfo.callMethodOnReceiver('rewind', this, []);
  static String makeTmp(String tmpl) => _staticInfo.callStatic('make_tmp', [tmpl]);
}

class DoubleIEEE754 extends GObjectBase {
  DoubleIEEE754.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'DoubleIEEE754');

  num get vDouble => getFieldOfObject('v_double', 0);
  void set vDouble(num value) => setFieldOfObject('v_double', 0, value);
}

typedef bool EqualFunc(dynamic a /* this will fail */);
class Error extends GObjectBase {
  Error.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'Error');

  factory Error.literal(int domain, int code, String message) => _staticInfo.callStatic('new_literal', [domain, code, message]);
  GErrorBase copy() => _staticInfo.callMethodOnReceiver('copy', this, []);
  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
  bool matches(int domain, int code) => _staticInfo.callMethodOnReceiver('matches', this, [domain, code]);
  int get domain => getFieldOfObject('domain', 0);
  void set domain(int value) => setFieldOfObject('domain', 0, value);
  int get code => getFieldOfObject('code', 1);
  void set code(int value) => setFieldOfObject('code', 1, value);
  String get message => getFieldOfObject('message', 2);
  void set message(String value) => setFieldOfObject('message', 2, value);
}

class ErrorType extends GEnumBase {
  const ErrorType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'ErrorType');

  static const ErrorType UNKNOWN = const ErrorType(0);
  static const ErrorType UNEXP_EOF = const ErrorType(1);
  static const ErrorType UNEXP_EOF_IN_STRING = const ErrorType(2);
  static const ErrorType UNEXP_EOF_IN_COMMENT = const ErrorType(3);
  static const ErrorType NON_DIGIT_IN_CONST = const ErrorType(4);
  static const ErrorType DIGIT_RADIX = const ErrorType(5);
  static const ErrorType FLOAT_RADIX = const ErrorType(6);
  static const ErrorType FLOAT_MALFORMED = const ErrorType(7);
  String toString() {
    switch(index) {
      case 0: return 'ErrorType.UNKNOWN';
      case 1: return 'ErrorType.UNEXP_EOF';
      case 2: return 'ErrorType.UNEXP_EOF_IN_STRING';
      case 3: return 'ErrorType.UNEXP_EOF_IN_COMMENT';
      case 4: return 'ErrorType.NON_DIGIT_IN_CONST';
      case 5: return 'ErrorType.DIGIT_RADIX';
      case 6: return 'ErrorType.FLOAT_RADIX';
      case 7: return 'ErrorType.FLOAT_MALFORMED';
      default: return 'new ErrorType($index)';
    }
  }
}

class FileErrorCode extends GEnumBase {
  const FileErrorCode(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'FileError');

  static const FileErrorCode EXIST = const FileErrorCode(0);
  static const FileErrorCode ISDIR = const FileErrorCode(1);
  static const FileErrorCode ACCES = const FileErrorCode(2);
  static const FileErrorCode NAMETOOLONG = const FileErrorCode(3);
  static const FileErrorCode NOENT = const FileErrorCode(4);
  static const FileErrorCode NOTDIR = const FileErrorCode(5);
  static const FileErrorCode NXIO = const FileErrorCode(6);
  static const FileErrorCode NODEV = const FileErrorCode(7);
  static const FileErrorCode ROFS = const FileErrorCode(8);
  static const FileErrorCode TXTBSY = const FileErrorCode(9);
  static const FileErrorCode FAULT = const FileErrorCode(10);
  static const FileErrorCode LOOP = const FileErrorCode(11);
  static const FileErrorCode NOSPC = const FileErrorCode(12);
  static const FileErrorCode NOMEM = const FileErrorCode(13);
  static const FileErrorCode MFILE = const FileErrorCode(14);
  static const FileErrorCode NFILE = const FileErrorCode(15);
  static const FileErrorCode BADF = const FileErrorCode(16);
  static const FileErrorCode INVAL = const FileErrorCode(17);
  static const FileErrorCode PIPE = const FileErrorCode(18);
  static const FileErrorCode AGAIN = const FileErrorCode(19);
  static const FileErrorCode INTR = const FileErrorCode(20);
  static const FileErrorCode IO = const FileErrorCode(21);
  static const FileErrorCode PERM = const FileErrorCode(22);
  static const FileErrorCode NOSYS = const FileErrorCode(23);
  static const FileErrorCode FAILED = const FileErrorCode(24);
  String toString() {
    switch(index) {
      case 0: return 'FileErrorCode.EXIST';
      case 1: return 'FileErrorCode.ISDIR';
      case 2: return 'FileErrorCode.ACCES';
      case 3: return 'FileErrorCode.NAMETOOLONG';
      case 4: return 'FileErrorCode.NOENT';
      case 5: return 'FileErrorCode.NOTDIR';
      case 6: return 'FileErrorCode.NXIO';
      case 7: return 'FileErrorCode.NODEV';
      case 8: return 'FileErrorCode.ROFS';
      case 9: return 'FileErrorCode.TXTBSY';
      case 10: return 'FileErrorCode.FAULT';
      case 11: return 'FileErrorCode.LOOP';
      case 12: return 'FileErrorCode.NOSPC';
      case 13: return 'FileErrorCode.NOMEM';
      case 14: return 'FileErrorCode.MFILE';
      case 15: return 'FileErrorCode.NFILE';
      case 16: return 'FileErrorCode.BADF';
      case 17: return 'FileErrorCode.INVAL';
      case 18: return 'FileErrorCode.PIPE';
      case 19: return 'FileErrorCode.AGAIN';
      case 20: return 'FileErrorCode.INTR';
      case 21: return 'FileErrorCode.IO';
      case 22: return 'FileErrorCode.PERM';
      case 23: return 'FileErrorCode.NOSYS';
      case 24: return 'FileErrorCode.FAILED';
      default: return 'new FileErrorCode($index)';
    }
  }
}

class FileError extends GErrorBase {
  static final int _quark = lookupErrorQuarkFromString('g-file-error-quark');
  FileError(FileErrorCode code, String message)
      : super.fromFields(_quark, code, message);
}

class FileTest extends GEnumBase {
  const FileTest(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'FileTest');

  static const FileTest NULL = const FileTest(0);
  static const FileTest IS_REGULAR = const FileTest(1);
  bool get isRegular => (index & 1) == 1;
  static const FileTest IS_SYMLINK = const FileTest(2);
  bool get isSymlink => (index & 2) == 2;
  static const FileTest IS_DIR = const FileTest(4);
  bool get isDir => (index & 4) == 4;
  static const FileTest IS_EXECUTABLE = const FileTest(8);
  bool get isExecutable => (index & 8) == 8;
  static const FileTest EXISTS = const FileTest(16);
  bool get exists => (index & 16) == 16;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'FileTest.IS_REGULAR';
      case 2: return 'FileTest.IS_SYMLINK';
      case 4: return 'FileTest.IS_DIR';
      case 8: return 'FileTest.IS_EXECUTABLE';
      case 16: return 'FileTest.EXISTS';
      default: return 'new FileTest($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'FileTest.NULL';
    }
    List codes = [];
    for (var i=1; i <= 16; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  FileTest operator|(FileTest other) =>
    new FileTest(index | other.index);
  FileTest operator&(FileTest other) =>
    new FileTest(index & other.index);
}

class FloatIEEE754 extends GObjectBase {
  FloatIEEE754.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'FloatIEEE754');

  num get vFloat => getFieldOfObject('v_float', 0);
  void set vFloat(num value) => setFieldOfObject('v_float', 0, value);
}

class FormatSizeFlags extends GEnumBase {
  const FormatSizeFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'FormatSizeFlags');

  static const FormatSizeFlags DEFAULT = const FormatSizeFlags(0);
  bool get default_ => (index & 0) == 0;
  static const FormatSizeFlags LONG_FORMAT = const FormatSizeFlags(1);
  bool get longFormat => (index & 1) == 1;
  static const FormatSizeFlags IEC_UNITS = const FormatSizeFlags(2);
  bool get iecUnits => (index & 2) == 2;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'FormatSizeFlags.LONG_FORMAT';
      case 2: return 'FormatSizeFlags.IEC_UNITS';
      default: return 'new FormatSizeFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'FormatSizeFlags.DEFAULT';
    }
    List codes = [];
    for (var i=1; i <= 2; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  FormatSizeFlags operator|(FormatSizeFlags other) =>
    new FormatSizeFlags(index | other.index);
  FormatSizeFlags operator&(FormatSizeFlags other) =>
    new FormatSizeFlags(index & other.index);
}

typedef void FreeFunc();
typedef void Func(dynamic data /* this will fail */);
typedef void HFunc(dynamic key /* this will fail */, dynamic value /* this will fail */);
typedef bool HRFunc(dynamic key /* this will fail */, dynamic value /* this will fail */);
typedef int HashFunc();
class HashTable extends GObjectBase {
  HashTable.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'HashTable');

  static bool add(HashTable hashTable, dynamic key /* this will fail */) => _staticInfo.callStatic('add', [hashTable, key]);
  static bool contains(HashTable hashTable, dynamic key /* this will fail */) => _staticInfo.callStatic('contains', [hashTable, key]);
  static void destroy(HashTable hashTable) => _staticInfo.callStatic('destroy', [hashTable]);
  static bool insert(HashTable hashTable, dynamic key /* this will fail */, dynamic value /* this will fail */) => _staticInfo.callStatic('insert', [hashTable, key, value]);
  static bool lookupExtended(HashTable hashTable, dynamic lookupKey /* this will fail */, dynamic origKey /* this will fail */, dynamic value /* this will fail */) => _staticInfo.callStatic('lookup_extended', [hashTable, lookupKey, origKey, value]);
  static bool remove(HashTable hashTable, dynamic key /* this will fail */) => _staticInfo.callStatic('remove', [hashTable, key]);
  static void removeAll(HashTable hashTable) => _staticInfo.callStatic('remove_all', [hashTable]);
  static bool replace(HashTable hashTable, dynamic key /* this will fail */, dynamic value /* this will fail */) => _staticInfo.callStatic('replace', [hashTable, key, value]);
  static int size(HashTable hashTable) => _staticInfo.callStatic('size', [hashTable]);
  static bool steal(HashTable hashTable, dynamic key /* this will fail */) => _staticInfo.callStatic('steal', [hashTable, key]);
  static void stealAll(HashTable hashTable) => _staticInfo.callStatic('steal_all', [hashTable]);
  static void unref(HashTable hashTable) => _staticInfo.callStatic('unref', [hashTable]);
}

class HashTableIter extends GObjectBase {
  HashTableIter.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'HashTableIter');

  void init(HashTable hashTable) => _staticInfo.callMethodOnReceiver('init', this, [hashTable]);
  bool next(dynamic key /* this will fail */, dynamic value /* this will fail */) => _staticInfo.callMethodOnReceiver('next', this, [key, value]);
  void remove() => _staticInfo.callMethodOnReceiver('remove', this, []);
  void replace(dynamic value /* this will fail */) => _staticInfo.callMethodOnReceiver('replace', this, [value]);
  void steal() => _staticInfo.callMethodOnReceiver('steal', this, []);
  dynamic /* this will fail */ get dummy1 => getFieldOfObject('dummy1', 0);
  dynamic /* this will fail */ get dummy2 => getFieldOfObject('dummy2', 1);
  dynamic /* this will fail */ get dummy3 => getFieldOfObject('dummy3', 2);
  int get dummy4 => getFieldOfObject('dummy4', 3);
  bool get dummy5 => getFieldOfObject('dummy5', 4);
  dynamic /* this will fail */ get dummy6 => getFieldOfObject('dummy6', 5);
}

class Hmac extends GObjectBase {
  Hmac.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'Hmac');

  void getDigest(int buffer, int digestLen) => _staticInfo.callMethodOnReceiver('get_digest', this, [buffer, digestLen]);
  String get string => _staticInfo.callMethodOnReceiver('get_string', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
  void update(List<int> data) => _staticInfo.callMethodOnReceiver('update', this, [data]);
}

class Hook extends GObjectBase {
  Hook.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'Hook');

  int compareIds(Hook sibling) => _staticInfo.callMethodOnReceiver('compare_ids', this, [sibling]);
  static bool destroy(HookList hookList, int hookId) => _staticInfo.callStatic('destroy', [hookList, hookId]);
  static void destroyLink(HookList hookList, Hook hook) => _staticInfo.callStatic('destroy_link', [hookList, hook]);
  static void free(HookList hookList, Hook hook) => _staticInfo.callStatic('free', [hookList, hook]);
  static void insertBefore(HookList hookList, Hook sibling, Hook hook) => _staticInfo.callStatic('insert_before', [hookList, sibling, hook]);
  static void prepend(HookList hookList, Hook hook) => _staticInfo.callStatic('prepend', [hookList, hook]);
  static void unref(HookList hookList, Hook hook) => _staticInfo.callStatic('unref', [hookList, hook]);
  dynamic /* this will fail */ get data => getFieldOfObject('data', 0);
  void set data(dynamic value /* this will fail */) => setFieldOfObject('data', 0, value);
  Hook get next => getFieldOfObject('next', 1);
  void set next(Hook value) => setFieldOfObject('next', 1, value);
  Hook get prev => getFieldOfObject('prev', 2);
  void set prev(Hook value) => setFieldOfObject('prev', 2, value);
  int get refCount => getFieldOfObject('ref_count', 3);
  void set refCount(int value) => setFieldOfObject('ref_count', 3, value);
  int get hookId => getFieldOfObject('hook_id', 4);
  void set hookId(int value) => setFieldOfObject('hook_id', 4, value);
  int get flags => getFieldOfObject('flags', 5);
  void set flags(int value) => setFieldOfObject('flags', 5, value);
  dynamic /* this will fail */ get func => getFieldOfObject('func', 6);
  void set func(dynamic value /* this will fail */) => setFieldOfObject('func', 6, value);
}

typedef bool HookCheckFunc();
typedef bool HookCheckMarshaller(Hook hook);
typedef int HookCompareFunc(Hook newHook, Hook sibling);
typedef void HookFinalizeFunc(HookList hookList, Hook hook);
typedef bool HookFindFunc(Hook hook);
class HookFlagMask extends GEnumBase {
  const HookFlagMask(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'HookFlagMask');

  static const HookFlagMask NULL = const HookFlagMask(0);
  static const HookFlagMask ACTIVE = const HookFlagMask(1);
  bool get active => (index & 1) == 1;
  static const HookFlagMask IN_CALL = const HookFlagMask(2);
  bool get inCall => (index & 2) == 2;
  static const HookFlagMask MASK = const HookFlagMask(15);
  bool get mask => (index & 15) == 15;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'HookFlagMask.ACTIVE';
      case 2: return 'HookFlagMask.IN_CALL';
      default: return 'new HookFlagMask($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'HookFlagMask.NULL';
    }
    List codes = [];
    for (var i=1; i <= 8; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  HookFlagMask operator|(HookFlagMask other) =>
    new HookFlagMask(index | other.index);
  HookFlagMask operator&(HookFlagMask other) =>
    new HookFlagMask(index & other.index);
}

typedef void HookFunc();
class HookList extends GObjectBase {
  HookList.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'HookList');

  void clear() => _staticInfo.callMethodOnReceiver('clear', this, []);
  void init(int hookSize) => _staticInfo.callMethodOnReceiver('init', this, [hookSize]);
  void invoke(bool mayRecurse) => _staticInfo.callMethodOnReceiver('invoke', this, [mayRecurse]);
  void invokeCheck(bool mayRecurse) => _staticInfo.callMethodOnReceiver('invoke_check', this, [mayRecurse]);
  int get seqId => getFieldOfObject('seq_id', 0);
  void set seqId(int value) => setFieldOfObject('seq_id', 0, value);
  int get hookSize => getFieldOfObject('hook_size', 1);
  void set hookSize(int value) => setFieldOfObject('hook_size', 1, value);
  int get isSetup => getFieldOfObject('is_setup', 2);
  void set isSetup(int value) => setFieldOfObject('is_setup', 2, value);
  Hook get hooks => getFieldOfObject('hooks', 3);
  void set hooks(Hook value) => setFieldOfObject('hooks', 3, value);
  dynamic /* this will fail */ get dummy3 => getFieldOfObject('dummy3', 4);
  void set dummy3(dynamic value /* this will fail */) => setFieldOfObject('dummy3', 4, value);
  HookFinalizeFunc get finalizeHook => getFieldOfObject('finalize_hook', 5);
  void set finalizeHook(HookFinalizeFunc value) => setFieldOfObject('finalize_hook', 5, value);
  List<dynamic /* this will fail */> get dummy => getFieldOfObject('dummy', 6);
  void set dummy(List<dynamic /* this will fail */> value) => setFieldOfObject('dummy', 6, value);
}

typedef void HookMarshaller(Hook hook);
class IConv extends GObjectBase {
  IConv.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'IConv');

  int run(String inbuf, int inbytesLeft, String outbuf, int outbytesLeft) => _staticInfo.callMethodOnReceiver('', this, [inbuf, inbytesLeft, outbuf, outbytesLeft]);
  int close() => _staticInfo.callMethodOnReceiver('close', this, []);
}

class IOChannel extends GObjectBase {
  IOChannel.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'IOChannel');

  factory IOChannel.file(String filename, String mode) => _staticInfo.callStatic('new_file', [filename, mode]);
  factory IOChannel.unixNew(int fd) => _staticInfo.callStatic('unix_new', [fd]);
  void close() => _staticInfo.callMethodOnReceiver('close', this, []);
  IOStatus flush() => _staticInfo.callMethodOnReceiver('flush', this, []);
  IOCondition get bufferCondition => _staticInfo.callMethodOnReceiver('get_buffer_condition', this, []);
  int get bufferSize => _staticInfo.callMethodOnReceiver('get_buffer_size', this, []);
  bool get buffered => _staticInfo.callMethodOnReceiver('get_buffered', this, []);
  bool get closeOnUnref => _staticInfo.callMethodOnReceiver('get_close_on_unref', this, []);
  String get encoding => _staticInfo.callMethodOnReceiver('get_encoding', this, []);
  IOFlags get flags => _staticInfo.callMethodOnReceiver('get_flags', this, []);
  String getLineTerm(int length) => _staticInfo.callMethodOnReceiver('get_line_term', this, [length]);
  void init() => _staticInfo.callMethodOnReceiver('init', this, []);
  IOError read(String buf, int count, int bytesRead) => _staticInfo.callMethodOnReceiver('read', this, [buf, count, bytesRead]);
  List readChars() => _staticInfo.callMethodOnReceiver('read_chars', this, []);
  List readLine() => _staticInfo.callMethodOnReceiver('read_line', this, []);
  IOStatus readLineString(GLibString buffer, int terminatorPos) => _staticInfo.callMethodOnReceiver('read_line_string', this, [buffer, terminatorPos]);
  List readToEnd() => _staticInfo.callMethodOnReceiver('read_to_end', this, []);
  List readUnichar() => _staticInfo.callMethodOnReceiver('read_unichar', this, []);
  IOChannel ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  IOError seek(int offset, SeekType type) => _staticInfo.callMethodOnReceiver('seek', this, [offset, type]);
  IOStatus seekPosition(int offset, SeekType type) => _staticInfo.callMethodOnReceiver('seek_position', this, [offset, type]);
  void set bufferSize(int size) => _staticInfo.callMethodOnReceiver('set_buffer_size', this, [size]);
  void set buffered(bool buffered) => _staticInfo.callMethodOnReceiver('set_buffered', this, [buffered]);
  void set closeOnUnref(bool doClose) => _staticInfo.callMethodOnReceiver('set_close_on_unref', this, [doClose]);
  IOStatus setEncoding(String encoding) => _staticInfo.callMethodOnReceiver('set_encoding', this, [encoding]);
  IOStatus setFlags(IOFlags flags) => _staticInfo.callMethodOnReceiver('set_flags', this, [flags]);
  void setLineTerm(String lineTerm, int length) => _staticInfo.callMethodOnReceiver('set_line_term', this, [lineTerm, length]);
  IOStatus shutdown(bool flush) => _staticInfo.callMethodOnReceiver('shutdown', this, [flush]);
  int unixGetFd() => _staticInfo.callMethodOnReceiver('unix_get_fd', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
  IOError write(String buf, int count, int bytesWritten) => _staticInfo.callMethodOnReceiver('write', this, [buf, count, bytesWritten]);
  List writeChars(List<int> buf, int count) => _staticInfo.callMethodOnReceiver('write_chars', this, [buf, count]);
  IOStatus writeUnichar(int thechar) => _staticInfo.callMethodOnReceiver('write_unichar', this, [thechar]);
  static IOChannelError errorFromErrno(int en) => _staticInfo.callStatic('error_from_errno', [en]);
  static int errorQuark() => _staticInfo.callStatic('error_quark', []);
  int get refCount => getFieldOfObject('ref_count', 0);
  IOFuncs get funcs => getFieldOfObject('funcs', 1);
  IConv get readCd => getFieldOfObject('read_cd', 3);
  IConv get writeCd => getFieldOfObject('write_cd', 4);
  String get lineTerm => getFieldOfObject('line_term', 5);
  int get lineTermLen => getFieldOfObject('line_term_len', 6);
  int get bufSize => getFieldOfObject('buf_size', 7);
  GLibString get readBuf => getFieldOfObject('read_buf', 8);
  GLibString get encodedReadBuf => getFieldOfObject('encoded_read_buf', 9);
  GLibString get writeBuf => getFieldOfObject('write_buf', 10);
  List<int> get partialWriteBuf => getFieldOfObject('partial_write_buf', 11);
  int get useBuffer => getFieldOfObject('use_buffer', 12);
  int get doEncode => getFieldOfObject('do_encode', 13);
  int get isReadable => getFieldOfObject('is_readable', 15);
  int get isWriteable => getFieldOfObject('is_writeable', 16);
  int get isSeekable => getFieldOfObject('is_seekable', 17);
  dynamic /* this will fail */ get reserved1 => getFieldOfObject('reserved1', 18);
  dynamic /* this will fail */ get reserved2 => getFieldOfObject('reserved2', 19);
}

class IOChannelErrorCode extends GEnumBase {
  const IOChannelErrorCode(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'IOChannelError');

  static const IOChannelErrorCode FBIG = const IOChannelErrorCode(0);
  static const IOChannelErrorCode INVAL = const IOChannelErrorCode(1);
  static const IOChannelErrorCode IO = const IOChannelErrorCode(2);
  static const IOChannelErrorCode ISDIR = const IOChannelErrorCode(3);
  static const IOChannelErrorCode NOSPC = const IOChannelErrorCode(4);
  static const IOChannelErrorCode NXIO = const IOChannelErrorCode(5);
  static const IOChannelErrorCode OVERFLOW = const IOChannelErrorCode(6);
  static const IOChannelErrorCode PIPE = const IOChannelErrorCode(7);
  static const IOChannelErrorCode FAILED = const IOChannelErrorCode(8);
  String toString() {
    switch(index) {
      case 0: return 'IOChannelErrorCode.FBIG';
      case 1: return 'IOChannelErrorCode.INVAL';
      case 2: return 'IOChannelErrorCode.IO';
      case 3: return 'IOChannelErrorCode.ISDIR';
      case 4: return 'IOChannelErrorCode.NOSPC';
      case 5: return 'IOChannelErrorCode.NXIO';
      case 6: return 'IOChannelErrorCode.OVERFLOW';
      case 7: return 'IOChannelErrorCode.PIPE';
      case 8: return 'IOChannelErrorCode.FAILED';
      default: return 'new IOChannelErrorCode($index)';
    }
  }
}

class IOChannelError extends GErrorBase {
  static final int _quark = lookupErrorQuarkFromString('g-io-channel-error-quark');
  IOChannelError(IOChannelErrorCode code, String message)
      : super.fromFields(_quark, code, message);
}

class IOCondition extends GEnumBase {
  const IOCondition(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'IOCondition');

  static const IOCondition NULL = const IOCondition(0);
  static const IOCondition IN = const IOCondition(1);
  bool get in_ => (index & 1) == 1;
  static const IOCondition OUT = const IOCondition(4);
  bool get out => (index & 4) == 4;
  static const IOCondition PRI = const IOCondition(2);
  bool get pri => (index & 2) == 2;
  static const IOCondition ERR = const IOCondition(8);
  bool get err => (index & 8) == 8;
  static const IOCondition HUP = const IOCondition(16);
  bool get hup => (index & 16) == 16;
  static const IOCondition NVAL = const IOCondition(32);
  bool get nval => (index & 32) == 32;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'IOCondition.IN';
      case 4: return 'IOCondition.OUT';
      case 2: return 'IOCondition.PRI';
      case 8: return 'IOCondition.ERR';
      case 16: return 'IOCondition.HUP';
      case 32: return 'IOCondition.NVAL';
      default: return 'new IOCondition($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'IOCondition.NULL';
    }
    List codes = [];
    for (var i=1; i <= 32; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  IOCondition operator|(IOCondition other) =>
    new IOCondition(index | other.index);
  IOCondition operator&(IOCondition other) =>
    new IOCondition(index & other.index);
}

class IOError extends GEnumBase {
  const IOError(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'IOError');

  static const IOError NONE = const IOError(0);
  static const IOError AGAIN = const IOError(1);
  static const IOError INVAL = const IOError(2);
  static const IOError UNKNOWN = const IOError(3);
  String toString() {
    switch(index) {
      case 0: return 'IOError.NONE';
      case 1: return 'IOError.AGAIN';
      case 2: return 'IOError.INVAL';
      case 3: return 'IOError.UNKNOWN';
      default: return 'new IOError($index)';
    }
  }
}

class IOFlags extends GEnumBase {
  const IOFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'IOFlags');

  static const IOFlags NULL = const IOFlags(0);
  static const IOFlags APPEND = const IOFlags(1);
  bool get append => (index & 1) == 1;
  static const IOFlags NONBLOCK = const IOFlags(2);
  bool get nonblock => (index & 2) == 2;
  static const IOFlags IS_READABLE = const IOFlags(4);
  bool get isReadable => (index & 4) == 4;
  static const IOFlags IS_WRITABLE = const IOFlags(8);
  bool get isWritable => (index & 8) == 8;
  static const IOFlags IS_WRITEABLE = const IOFlags(8);
  bool get isWriteable => (index & 8) == 8;
  static const IOFlags IS_SEEKABLE = const IOFlags(16);
  bool get isSeekable => (index & 16) == 16;
  static const IOFlags MASK = const IOFlags(31);
  bool get mask => (index & 31) == 31;
  static const IOFlags GET_MASK = const IOFlags(31);
  bool get getMask => (index & 31) == 31;
  static const IOFlags SET_MASK = const IOFlags(3);
  bool get setMask => (index & 3) == 3;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'IOFlags.APPEND';
      case 2: return 'IOFlags.NONBLOCK';
      case 4: return 'IOFlags.IS_READABLE';
      case 8: return 'IOFlags.IS_WRITABLE';
      case 16: return 'IOFlags.IS_SEEKABLE';
      default: return 'new IOFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'IOFlags.NULL';
    }
    List codes = [];
    for (var i=1; i <= 16; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  IOFlags operator|(IOFlags other) =>
    new IOFlags(index | other.index);
  IOFlags operator&(IOFlags other) =>
    new IOFlags(index & other.index);
}

typedef bool IOFunc(IOChannel source, IOCondition condition);
class IOFuncs extends GObjectBase {
  IOFuncs.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'IOFuncs');
}

class IOStatus extends GEnumBase {
  const IOStatus(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'IOStatus');

  static const IOStatus ERROR = const IOStatus(0);
  static const IOStatus NORMAL = const IOStatus(1);
  static const IOStatus EOF = const IOStatus(2);
  static const IOStatus AGAIN = const IOStatus(3);
  String toString() {
    switch(index) {
      case 0: return 'IOStatus.ERROR';
      case 1: return 'IOStatus.NORMAL';
      case 2: return 'IOStatus.EOF';
      case 3: return 'IOStatus.AGAIN';
      default: return 'new IOStatus($index)';
    }
  }
}

class KeyFile extends GObjectBase {
  KeyFile.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'KeyFile');

  factory KeyFile() => _staticInfo.callStatic('new', []);
  void getBoolean(String groupName, String key) => _staticInfo.callMethodOnReceiver('get_boolean', this, [groupName, key]);
  List getBooleanList(String groupName, String key) => _staticInfo.callMethodOnReceiver('get_boolean_list', this, [groupName, key]);
  String getComment(String groupName, String key) => _staticInfo.callMethodOnReceiver('get_comment', this, [groupName, key]);
  num getDouble(String groupName, String key) => _staticInfo.callMethodOnReceiver('get_double', this, [groupName, key]);
  List getDoubleList(String groupName, String key) => _staticInfo.callMethodOnReceiver('get_double_list', this, [groupName, key]);
  List getGroups() => _staticInfo.callMethodOnReceiver('get_groups', this, []);
  int getInt64(String groupName, String key) => _staticInfo.callMethodOnReceiver('get_int64', this, [groupName, key]);
  int getInteger(String groupName, String key) => _staticInfo.callMethodOnReceiver('get_integer', this, [groupName, key]);
  List getIntegerList(String groupName, String key) => _staticInfo.callMethodOnReceiver('get_integer_list', this, [groupName, key]);
  List getKeys(String groupName) => _staticInfo.callMethodOnReceiver('get_keys', this, [groupName]);
  String getLocaleString(String groupName, String key, String locale) => _staticInfo.callMethodOnReceiver('get_locale_string', this, [groupName, key, locale]);
  List getLocaleStringList(String groupName, String key, String locale) => _staticInfo.callMethodOnReceiver('get_locale_string_list', this, [groupName, key, locale]);
  String get startGroup => _staticInfo.callMethodOnReceiver('get_start_group', this, []);
  String getString(String groupName, String key) => _staticInfo.callMethodOnReceiver('get_string', this, [groupName, key]);
  List getStringList(String groupName, String key) => _staticInfo.callMethodOnReceiver('get_string_list', this, [groupName, key]);
  int getUint64(String groupName, String key) => _staticInfo.callMethodOnReceiver('get_uint64', this, [groupName, key]);
  String getValue(String groupName, String key) => _staticInfo.callMethodOnReceiver('get_value', this, [groupName, key]);
  bool hasGroup(String groupName) => _staticInfo.callMethodOnReceiver('has_group', this, [groupName]);
  void loadFromData(String data, int length, KeyFileFlags flags) => _staticInfo.callMethodOnReceiver('load_from_data', this, [data, length, flags]);
  String loadFromDataDirs(String file, KeyFileFlags flags) => _staticInfo.callMethodOnReceiver('load_from_data_dirs', this, [file, flags]);
  String loadFromDirs(String file, List<String> searchDirs, KeyFileFlags flags) => _staticInfo.callMethodOnReceiver('load_from_dirs', this, [file, searchDirs, flags]);
  void loadFromFile(String file, KeyFileFlags flags) => _staticInfo.callMethodOnReceiver('load_from_file', this, [file, flags]);
  void removeComment(String groupName, String key) => _staticInfo.callMethodOnReceiver('remove_comment', this, [groupName, key]);
  void removeGroup(String groupName) => _staticInfo.callMethodOnReceiver('remove_group', this, [groupName]);
  void removeKey(String groupName, String key) => _staticInfo.callMethodOnReceiver('remove_key', this, [groupName, key]);
  void saveToFile(String filename) => _staticInfo.callMethodOnReceiver('save_to_file', this, [filename]);
  void setBoolean(String groupName, String key, bool value) => _staticInfo.callMethodOnReceiver('set_boolean', this, [groupName, key, value]);
  void setBooleanList(String groupName, String key, List<bool> list) => _staticInfo.callMethodOnReceiver('set_boolean_list', this, [groupName, key, list]);
  void setComment(String groupName, String key, String comment) => _staticInfo.callMethodOnReceiver('set_comment', this, [groupName, key, comment]);
  void setDouble(String groupName, String key, num value) => _staticInfo.callMethodOnReceiver('set_double', this, [groupName, key, value]);
  void setDoubleList(String groupName, String key, List<num> list) => _staticInfo.callMethodOnReceiver('set_double_list', this, [groupName, key, list]);
  void setInt64(String groupName, String key, int value) => _staticInfo.callMethodOnReceiver('set_int64', this, [groupName, key, value]);
  void setInteger(String groupName, String key, int value) => _staticInfo.callMethodOnReceiver('set_integer', this, [groupName, key, value]);
  void setIntegerList(String groupName, String key, List<int> list) => _staticInfo.callMethodOnReceiver('set_integer_list', this, [groupName, key, list]);
  void setListSeparator(int separator) => _staticInfo.callMethodOnReceiver('set_list_separator', this, [separator]);
  void setLocaleString(String groupName, String key, String locale, String string) => _staticInfo.callMethodOnReceiver('set_locale_string', this, [groupName, key, locale, string]);
  void setLocaleStringList(String groupName, String key, String locale, List<String> list) => _staticInfo.callMethodOnReceiver('set_locale_string_list', this, [groupName, key, locale, list]);
  void setString(String groupName, String key, String string) => _staticInfo.callMethodOnReceiver('set_string', this, [groupName, key, string]);
  void setStringList(String groupName, String key, List<String> list) => _staticInfo.callMethodOnReceiver('set_string_list', this, [groupName, key, list]);
  void setUint64(String groupName, String key, int value) => _staticInfo.callMethodOnReceiver('set_uint64', this, [groupName, key, value]);
  void setValue(String groupName, String key, String value) => _staticInfo.callMethodOnReceiver('set_value', this, [groupName, key, value]);
  List toData() => _staticInfo.callMethodOnReceiver('to_data', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
  static int errorQuark() => _staticInfo.callStatic('error_quark', []);
}

class KeyFileErrorCode extends GEnumBase {
  const KeyFileErrorCode(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'KeyFileError');

  static const KeyFileErrorCode UNKNOWN_ENCODING = const KeyFileErrorCode(0);
  static const KeyFileErrorCode PARSE = const KeyFileErrorCode(1);
  static const KeyFileErrorCode NOT_FOUND = const KeyFileErrorCode(2);
  static const KeyFileErrorCode KEY_NOT_FOUND = const KeyFileErrorCode(3);
  static const KeyFileErrorCode GROUP_NOT_FOUND = const KeyFileErrorCode(4);
  static const KeyFileErrorCode INVALID_VALUE = const KeyFileErrorCode(5);
  String toString() {
    switch(index) {
      case 0: return 'KeyFileErrorCode.UNKNOWN_ENCODING';
      case 1: return 'KeyFileErrorCode.PARSE';
      case 2: return 'KeyFileErrorCode.NOT_FOUND';
      case 3: return 'KeyFileErrorCode.KEY_NOT_FOUND';
      case 4: return 'KeyFileErrorCode.GROUP_NOT_FOUND';
      case 5: return 'KeyFileErrorCode.INVALID_VALUE';
      default: return 'new KeyFileErrorCode($index)';
    }
  }
}

class KeyFileError extends GErrorBase {
  static final int _quark = lookupErrorQuarkFromString('g-key-file-error-quark');
  KeyFileError(KeyFileErrorCode code, String message)
      : super.fromFields(_quark, code, message);
}

class KeyFileFlags extends GEnumBase {
  const KeyFileFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'KeyFileFlags');

  static const KeyFileFlags NONE = const KeyFileFlags(0);
  bool get none => (index & 0) == 0;
  static const KeyFileFlags KEEP_COMMENTS = const KeyFileFlags(1);
  bool get keepComments => (index & 1) == 1;
  static const KeyFileFlags KEEP_TRANSLATIONS = const KeyFileFlags(2);
  bool get keepTranslations => (index & 2) == 2;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'KeyFileFlags.KEEP_COMMENTS';
      case 2: return 'KeyFileFlags.KEEP_TRANSLATIONS';
      default: return 'new KeyFileFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'KeyFileFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 2; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  KeyFileFlags operator|(KeyFileFlags other) =>
    new KeyFileFlags(index | other.index);
  KeyFileFlags operator&(KeyFileFlags other) =>
    new KeyFileFlags(index & other.index);
}

class GLibList extends GObjectBase {
  GLibList.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'List');

  dynamic /* this will fail */ get data => getFieldOfObject('data', 0);
  void set data(dynamic value /* this will fail */) => setFieldOfObject('data', 0, value);
  GLibList /* this will fail */ get next => getFieldOfObject('next', 1);
  void set next(GLibList value /* this will fail */) => setFieldOfObject('next', 1, value);
  GLibList /* this will fail */ get prev => getFieldOfObject('prev', 2);
  void set prev(GLibList value /* this will fail */) => setFieldOfObject('prev', 2, value);
}

typedef void LogFunc(String logDomain, LogLevelFlags logLevel, String message);
class LogLevelFlags extends GEnumBase {
  const LogLevelFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'LogLevelFlags');

  static const LogLevelFlags NULL = const LogLevelFlags(0);
  static const LogLevelFlags FLAG_RECURSION = const LogLevelFlags(1);
  bool get flagRecursion => (index & 1) == 1;
  static const LogLevelFlags FLAG_FATAL = const LogLevelFlags(2);
  bool get flagFatal => (index & 2) == 2;
  static const LogLevelFlags LEVEL_ERROR = const LogLevelFlags(4);
  bool get levelError => (index & 4) == 4;
  static const LogLevelFlags LEVEL_CRITICAL = const LogLevelFlags(8);
  bool get levelCritical => (index & 8) == 8;
  static const LogLevelFlags LEVEL_WARNING = const LogLevelFlags(16);
  bool get levelWarning => (index & 16) == 16;
  static const LogLevelFlags LEVEL_MESSAGE = const LogLevelFlags(32);
  bool get levelMessage => (index & 32) == 32;
  static const LogLevelFlags LEVEL_INFO = const LogLevelFlags(64);
  bool get levelInfo => (index & 64) == 64;
  static const LogLevelFlags LEVEL_DEBUG = const LogLevelFlags(128);
  bool get levelDebug => (index & 128) == 128;
  static const LogLevelFlags LEVEL_MASK = const LogLevelFlags(-4);
  bool get levelMask => (index & -4) == -4;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'LogLevelFlags.FLAG_RECURSION';
      case 2: return 'LogLevelFlags.FLAG_FATAL';
      case 4: return 'LogLevelFlags.LEVEL_ERROR';
      case 8: return 'LogLevelFlags.LEVEL_CRITICAL';
      case 16: return 'LogLevelFlags.LEVEL_WARNING';
      case 32: return 'LogLevelFlags.LEVEL_MESSAGE';
      case 64: return 'LogLevelFlags.LEVEL_INFO';
      case 128: return 'LogLevelFlags.LEVEL_DEBUG';
      default: return 'new LogLevelFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'LogLevelFlags.NULL';
    }
    List codes = [];
    for (var i=1; i <= 128; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  LogLevelFlags operator|(LogLevelFlags other) =>
    new LogLevelFlags(index | other.index);
  LogLevelFlags operator&(LogLevelFlags other) =>
    new LogLevelFlags(index & other.index);
}

class MainContext extends GObjectBase {
  MainContext.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'MainContext');

  factory MainContext() => _staticInfo.callStatic('new', []);
  bool acquire() => _staticInfo.callMethodOnReceiver('acquire', this, []);
  void addPoll(PollFD fd, int priority) => _staticInfo.callMethodOnReceiver('add_poll', this, [fd, priority]);
  int check(int maxPriority, List<PollFD> fds) => _staticInfo.callMethodOnReceiver('check', this, [maxPriority, fds]);
  void dispatch() => _staticInfo.callMethodOnReceiver('dispatch', this, []);
  Source findSourceByFuncsUserData(SourceFuncs funcs, dynamic userData /* this will fail */) => _staticInfo.callMethodOnReceiver('find_source_by_funcs_user_data', this, [funcs, userData]);
  Source findSourceById(int sourceId) => _staticInfo.callMethodOnReceiver('find_source_by_id', this, [sourceId]);
  Source findSourceByUserData(dynamic userData /* this will fail */) => _staticInfo.callMethodOnReceiver('find_source_by_user_data', this, [userData]);
  void invokeFull(int priority, SourceFunc function) => _staticInfo.callMethodOnReceiver('invoke_full', this, [priority, function]);
  bool isOwner() => _staticInfo.callMethodOnReceiver('is_owner', this, []);
  bool iteration(bool mayBlock) => _staticInfo.callMethodOnReceiver('iteration', this, [mayBlock]);
  bool pending() => _staticInfo.callMethodOnReceiver('pending', this, []);
  void popThreadDefault() => _staticInfo.callMethodOnReceiver('pop_thread_default', this, []);
  bool prepare(int priority) => _staticInfo.callMethodOnReceiver('prepare', this, [priority]);
  void pushThreadDefault() => _staticInfo.callMethodOnReceiver('push_thread_default', this, []);
  List query(int maxPriority) => _staticInfo.callMethodOnReceiver('query', this, [maxPriority]);
  MainContext ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  void release() => _staticInfo.callMethodOnReceiver('release', this, []);
  void removePoll(PollFD fd) => _staticInfo.callMethodOnReceiver('remove_poll', this, [fd]);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
  bool wait(Cond cond, Mutex mutex) => _staticInfo.callMethodOnReceiver('wait', this, [cond, mutex]);
  void wakeup() => _staticInfo.callMethodOnReceiver('wakeup', this, []);
  static MainContext default_() => _staticInfo.callStatic('default', []);
  static MainContext getThreadDefault() => _staticInfo.callStatic('get_thread_default', []);
  static MainContext refThreadDefault() => _staticInfo.callStatic('ref_thread_default', []);
}

class MainLoop extends GObjectBase {
  MainLoop.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'MainLoop');

  factory MainLoop(MainContext context, bool isRunning) => _staticInfo.callStatic('new', [context, isRunning]);
  MainContext get context => _staticInfo.callMethodOnReceiver('get_context', this, []);
  bool isRunning() => _staticInfo.callMethodOnReceiver('is_running', this, []);
  void quit() => _staticInfo.callMethodOnReceiver('quit', this, []);
  MainLoop ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  void run() => _staticInfo.callMethodOnReceiver('run', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
}

class MappedFile extends GObjectBase {
  MappedFile.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'MappedFile');

  factory MappedFile(String filename, bool writable) => _staticInfo.callStatic('new', [filename, writable]);
  factory MappedFile.fromFd(int fd, bool writable) => _staticInfo.callStatic('new_from_fd', [fd, writable]);
  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
  Bytes get bytes => _staticInfo.callMethodOnReceiver('get_bytes', this, []);
  String get contents => _staticInfo.callMethodOnReceiver('get_contents', this, []);
  int get length => _staticInfo.callMethodOnReceiver('get_length', this, []);
  MappedFile ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
}

class MarkupCollectType extends GEnumBase {
  const MarkupCollectType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'MarkupCollectType');

  static const MarkupCollectType INVALID = const MarkupCollectType(0);
  bool get invalid => (index & 0) == 0;
  static const MarkupCollectType STRING = const MarkupCollectType(1);
  bool get string => (index & 1) == 1;
  static const MarkupCollectType STRDUP = const MarkupCollectType(2);
  bool get strdup => (index & 2) == 2;
  static const MarkupCollectType BOOLEAN = const MarkupCollectType(3);
  bool get boolean => (index & 3) == 3;
  static const MarkupCollectType TRISTATE = const MarkupCollectType(4);
  bool get tristate => (index & 4) == 4;
  static const MarkupCollectType OPTIONAL = const MarkupCollectType(65536);
  bool get optional => (index & 65536) == 65536;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'MarkupCollectType.STRING';
      case 2: return 'MarkupCollectType.STRDUP';
      case 4: return 'MarkupCollectType.TRISTATE';
      default: return 'new MarkupCollectType($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'MarkupCollectType.INVALID';
    }
    List codes = [];
    for (var i=1; i <= 65536; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  MarkupCollectType operator|(MarkupCollectType other) =>
    new MarkupCollectType(index | other.index);
  MarkupCollectType operator&(MarkupCollectType other) =>
    new MarkupCollectType(index & other.index);
}

class MarkupErrorCode extends GEnumBase {
  const MarkupErrorCode(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'MarkupError');

  static const MarkupErrorCode BAD_UTF8 = const MarkupErrorCode(0);
  static const MarkupErrorCode EMPTY = const MarkupErrorCode(1);
  static const MarkupErrorCode PARSE = const MarkupErrorCode(2);
  static const MarkupErrorCode UNKNOWN_ELEMENT = const MarkupErrorCode(3);
  static const MarkupErrorCode UNKNOWN_ATTRIBUTE = const MarkupErrorCode(4);
  static const MarkupErrorCode INVALID_CONTENT = const MarkupErrorCode(5);
  static const MarkupErrorCode MISSING_ATTRIBUTE = const MarkupErrorCode(6);
  String toString() {
    switch(index) {
      case 0: return 'MarkupErrorCode.BAD_UTF8';
      case 1: return 'MarkupErrorCode.EMPTY';
      case 2: return 'MarkupErrorCode.PARSE';
      case 3: return 'MarkupErrorCode.UNKNOWN_ELEMENT';
      case 4: return 'MarkupErrorCode.UNKNOWN_ATTRIBUTE';
      case 5: return 'MarkupErrorCode.INVALID_CONTENT';
      case 6: return 'MarkupErrorCode.MISSING_ATTRIBUTE';
      default: return 'new MarkupErrorCode($index)';
    }
  }
}

class MarkupError extends GErrorBase {
  static final int _quark = lookupErrorQuarkFromString('g-markup-error-quark');
  MarkupError(MarkupErrorCode code, String message)
      : super.fromFields(_quark, code, message);
}

class MarkupParseContext extends GObjectBase {
  MarkupParseContext.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'MarkupParseContext');

  factory MarkupParseContext(MarkupParser parser, MarkupParseFlags flags, dynamic userData /* this will fail */, DestroyNotify userDataDnotify) => _staticInfo.callStatic('new', [parser, flags, userData, userDataDnotify]);
  void endParse() => _staticInfo.callMethodOnReceiver('end_parse', this, []);
  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
  String get element => _staticInfo.callMethodOnReceiver('get_element', this, []);
  void getPosition(int lineNumber, int charNumber) => _staticInfo.callMethodOnReceiver('get_position', this, [lineNumber, charNumber]);
  void parse(String text, int textLen) => _staticInfo.callMethodOnReceiver('parse', this, [text, textLen]);
  void push(MarkupParser parser, dynamic userData /* this will fail */) => _staticInfo.callMethodOnReceiver('push', this, [parser, userData]);
  MarkupParseContext ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
}

class MarkupParseFlags extends GEnumBase {
  const MarkupParseFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'MarkupParseFlags');

  static const MarkupParseFlags NULL = const MarkupParseFlags(0);
  static const MarkupParseFlags DO_NOT_USE_THIS_UNSUPPORTED_FLAG = const MarkupParseFlags(1);
  bool get doNotUseThisUnsupportedFlag => (index & 1) == 1;
  static const MarkupParseFlags TREAT_CDATA_AS_TEXT = const MarkupParseFlags(2);
  bool get treatCdataAsText => (index & 2) == 2;
  static const MarkupParseFlags PREFIX_ERROR_POSITION = const MarkupParseFlags(4);
  bool get prefixErrorPosition => (index & 4) == 4;
  static const MarkupParseFlags IGNORE_QUALIFIED = const MarkupParseFlags(8);
  bool get ignoreQualified => (index & 8) == 8;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'MarkupParseFlags.DO_NOT_USE_THIS_UNSUPPORTED_FLAG';
      case 2: return 'MarkupParseFlags.TREAT_CDATA_AS_TEXT';
      case 4: return 'MarkupParseFlags.PREFIX_ERROR_POSITION';
      case 8: return 'MarkupParseFlags.IGNORE_QUALIFIED';
      default: return 'new MarkupParseFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'MarkupParseFlags.NULL';
    }
    List codes = [];
    for (var i=1; i <= 8; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  MarkupParseFlags operator|(MarkupParseFlags other) =>
    new MarkupParseFlags(index | other.index);
  MarkupParseFlags operator&(MarkupParseFlags other) =>
    new MarkupParseFlags(index & other.index);
}

class MarkupParser extends GObjectBase {
  MarkupParser.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'MarkupParser');
}

class MatchInfo extends GObjectBase {
  MatchInfo.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'MatchInfo');

  String expandReferences(String stringToExpand) => _staticInfo.callMethodOnReceiver('expand_references', this, [stringToExpand]);
  String fetch(int matchNum) => _staticInfo.callMethodOnReceiver('fetch', this, [matchNum]);
  List<String> fetchAll() => _staticInfo.callMethodOnReceiver('fetch_all', this, []);
  String fetchNamed(String name) => _staticInfo.callMethodOnReceiver('fetch_named', this, [name]);
  List fetchNamedPos(String name) => _staticInfo.callMethodOnReceiver('fetch_named_pos', this, [name]);
  List fetchPos(int matchNum) => _staticInfo.callMethodOnReceiver('fetch_pos', this, [matchNum]);
  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
  int get matchCount => _staticInfo.callMethodOnReceiver('get_match_count', this, []);
  Regex get regex => _staticInfo.callMethodOnReceiver('get_regex', this, []);
  String get string => _staticInfo.callMethodOnReceiver('get_string', this, []);
  bool isPartialMatch() => _staticInfo.callMethodOnReceiver('is_partial_match', this, []);
  bool matches() => _staticInfo.callMethodOnReceiver('matches', this, []);
  void next() => _staticInfo.callMethodOnReceiver('next', this, []);
  MatchInfo ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
}

class MemVTable extends GObjectBase {
  MemVTable.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'MemVTable');

  dynamic /* this will fail */ get malloc => getFieldOfObject('malloc', 0);
  dynamic /* this will fail */ get realloc => getFieldOfObject('realloc', 1);
  dynamic /* this will fail */ get calloc => getFieldOfObject('calloc', 3);
  dynamic /* this will fail */ get tryMalloc => getFieldOfObject('try_malloc', 4);
  dynamic /* this will fail */ get tryRealloc => getFieldOfObject('try_realloc', 5);
}

class Mutex extends GObjectBase {
  Mutex.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'Mutex');

  void clear() => _staticInfo.callMethodOnReceiver('clear', this, []);
  void init() => _staticInfo.callMethodOnReceiver('init', this, []);
  void lock() => _staticInfo.callMethodOnReceiver('lock', this, []);
  bool trylock() => _staticInfo.callMethodOnReceiver('trylock', this, []);
  void unlock() => _staticInfo.callMethodOnReceiver('unlock', this, []);
  dynamic /* this will fail */ get p => getFieldOfObject('p', 0);
  List<int> get i => getFieldOfObject('i', 1);
}

class Node extends GObjectBase {
  Node.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'Node');

  int childIndex(dynamic data /* this will fail */) => _staticInfo.callMethodOnReceiver('child_index', this, [data]);
  int childPosition(Node child) => _staticInfo.callMethodOnReceiver('child_position', this, [child]);
  int depth() => _staticInfo.callMethodOnReceiver('depth', this, []);
  void destroy() => _staticInfo.callMethodOnReceiver('destroy', this, []);
  bool isAncestor(Node descendant) => _staticInfo.callMethodOnReceiver('is_ancestor', this, [descendant]);
  int maxHeight() => _staticInfo.callMethodOnReceiver('max_height', this, []);
  int nChildren() => _staticInfo.callMethodOnReceiver('n_children', this, []);
  int nNodes(TraverseFlags flags) => _staticInfo.callMethodOnReceiver('n_nodes', this, [flags]);
  void reverseChildren() => _staticInfo.callMethodOnReceiver('reverse_children', this, []);
  void unlink() => _staticInfo.callMethodOnReceiver('unlink', this, []);
  dynamic /* this will fail */ get data => getFieldOfObject('data', 0);
  void set data(dynamic value /* this will fail */) => setFieldOfObject('data', 0, value);
  Node get next => getFieldOfObject('next', 1);
  void set next(Node value) => setFieldOfObject('next', 1, value);
  Node get prev => getFieldOfObject('prev', 2);
  void set prev(Node value) => setFieldOfObject('prev', 2, value);
  Node get parent => getFieldOfObject('parent', 3);
  void set parent(Node value) => setFieldOfObject('parent', 3, value);
  Node get children => getFieldOfObject('children', 4);
  void set children(Node value) => setFieldOfObject('children', 4, value);
}

typedef void NodeForeachFunc(Node node);
typedef bool NodeTraverseFunc(Node node);
class NormalizeMode extends GEnumBase {
  const NormalizeMode(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'NormalizeMode');

  static const NormalizeMode DEFAULT = const NormalizeMode(0);
  static const NormalizeMode NFD = const NormalizeMode(0);
  static const NormalizeMode DEFAULT_COMPOSE = const NormalizeMode(1);
  static const NormalizeMode NFC = const NormalizeMode(1);
  static const NormalizeMode ALL = const NormalizeMode(2);
  static const NormalizeMode NFKD = const NormalizeMode(2);
  static const NormalizeMode ALL_COMPOSE = const NormalizeMode(3);
  static const NormalizeMode NFKC = const NormalizeMode(3);
  String toString() {
    switch(index) {
      case 0: return 'NormalizeMode.NFD';
      case 1: return 'NormalizeMode.NFC';
      case 2: return 'NormalizeMode.NFKD';
      case 3: return 'NormalizeMode.NFKC';
      default: return 'new NormalizeMode($index)';
    }
  }
}

class Once extends GObjectBase {
  Once.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'Once');

  static bool initEnter(dynamic location /* this will fail */) => _staticInfo.callStatic('init_enter', [location]);
  static void initLeave(dynamic location /* this will fail */, int result) => _staticInfo.callStatic('init_leave', [location, result]);
  OnceStatus get status => getFieldOfObject('status', 0);
  void set status(OnceStatus value) => setFieldOfObject('status', 0, value);
  dynamic /* this will fail */ get retval => getFieldOfObject('retval', 1);
  void set retval(dynamic value /* this will fail */) => setFieldOfObject('retval', 1, value);
}

class OnceStatus extends GEnumBase {
  const OnceStatus(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'OnceStatus');

  static const OnceStatus NOTCALLED = const OnceStatus(0);
  static const OnceStatus PROGRESS = const OnceStatus(1);
  static const OnceStatus READY = const OnceStatus(2);
  String toString() {
    switch(index) {
      case 0: return 'OnceStatus.NOTCALLED';
      case 1: return 'OnceStatus.PROGRESS';
      case 2: return 'OnceStatus.READY';
      default: return 'new OnceStatus($index)';
    }
  }
}

class OptionArg extends GEnumBase {
  const OptionArg(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'OptionArg');

  static const OptionArg NONE = const OptionArg(0);
  static const OptionArg STRING = const OptionArg(1);
  static const OptionArg INT = const OptionArg(2);
  static const OptionArg CALLBACK = const OptionArg(3);
  static const OptionArg FILENAME = const OptionArg(4);
  static const OptionArg STRING_ARRAY = const OptionArg(5);
  static const OptionArg FILENAME_ARRAY = const OptionArg(6);
  static const OptionArg DOUBLE = const OptionArg(7);
  static const OptionArg INT64 = const OptionArg(8);
  String toString() {
    switch(index) {
      case 0: return 'OptionArg.NONE';
      case 1: return 'OptionArg.STRING';
      case 2: return 'OptionArg.INT';
      case 3: return 'OptionArg.CALLBACK';
      case 4: return 'OptionArg.FILENAME';
      case 5: return 'OptionArg.STRING_ARRAY';
      case 6: return 'OptionArg.FILENAME_ARRAY';
      case 7: return 'OptionArg.DOUBLE';
      case 8: return 'OptionArg.INT64';
      default: return 'new OptionArg($index)';
    }
  }
}

typedef void OptionArgFunc(String optionName, String value);
class OptionContext extends GObjectBase {
  OptionContext.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'OptionContext');

  void addGroup(OptionGroup group) => _staticInfo.callMethodOnReceiver('add_group', this, [group]);
  void addMainEntries(OptionEntry entries, String translationDomain) => _staticInfo.callMethodOnReceiver('add_main_entries', this, [entries, translationDomain]);
  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
  String get description => _staticInfo.callMethodOnReceiver('get_description', this, []);
  String getHelp(bool mainHelp, OptionGroup group) => _staticInfo.callMethodOnReceiver('get_help', this, [mainHelp, group]);
  bool get helpEnabled => _staticInfo.callMethodOnReceiver('get_help_enabled', this, []);
  bool get ignoreUnknownOptions => _staticInfo.callMethodOnReceiver('get_ignore_unknown_options', this, []);
  OptionGroup get mainGroup => _staticInfo.callMethodOnReceiver('get_main_group', this, []);
  bool get strictPosix => _staticInfo.callMethodOnReceiver('get_strict_posix', this, []);
  String get summary => _staticInfo.callMethodOnReceiver('get_summary', this, []);
  List parse(List<String> argv) => _staticInfo.callMethodOnReceiver('parse', this, [argv]);
  List<String> parseStrv(List<String> arguments) => _staticInfo.callMethodOnReceiver('parse_strv', this, [arguments]);
  void set description(String description) => _staticInfo.callMethodOnReceiver('set_description', this, [description]);
  void set helpEnabled(bool helpEnabled) => _staticInfo.callMethodOnReceiver('set_help_enabled', this, [helpEnabled]);
  void set ignoreUnknownOptions(bool ignoreUnknown) => _staticInfo.callMethodOnReceiver('set_ignore_unknown_options', this, [ignoreUnknown]);
  void set mainGroup(OptionGroup group) => _staticInfo.callMethodOnReceiver('set_main_group', this, [group]);
  void set strictPosix(bool strictPosix) => _staticInfo.callMethodOnReceiver('set_strict_posix', this, [strictPosix]);
  void set summary(String summary) => _staticInfo.callMethodOnReceiver('set_summary', this, [summary]);
  void setTranslateFunc(TranslateFunc func) => _staticInfo.callMethodOnReceiver('set_translate_func', this, [func]);
  void setTranslationDomain(String domain) => _staticInfo.callMethodOnReceiver('set_translation_domain', this, [domain]);
}

class OptionEntry extends GObjectBase {
  OptionEntry.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'OptionEntry');

  String get longName => getFieldOfObject('long_name', 0);
  void set longName(String value) => setFieldOfObject('long_name', 0, value);
  int get shortName => getFieldOfObject('short_name', 1);
  void set shortName(int value) => setFieldOfObject('short_name', 1, value);
  int get flags => getFieldOfObject('flags', 2);
  void set flags(int value) => setFieldOfObject('flags', 2, value);
  OptionArg get arg => getFieldOfObject('arg', 3);
  void set arg(OptionArg value) => setFieldOfObject('arg', 3, value);
  dynamic /* this will fail */ get argData => getFieldOfObject('arg_data', 4);
  void set argData(dynamic value /* this will fail */) => setFieldOfObject('arg_data', 4, value);
  String get description => getFieldOfObject('description', 5);
  void set description(String value) => setFieldOfObject('description', 5, value);
  String get argDescription => getFieldOfObject('arg_description', 6);
  void set argDescription(String value) => setFieldOfObject('arg_description', 6, value);
}

class OptionErrorCode extends GEnumBase {
  const OptionErrorCode(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'OptionError');

  static const OptionErrorCode UNKNOWN_OPTION = const OptionErrorCode(0);
  static const OptionErrorCode BAD_VALUE = const OptionErrorCode(1);
  static const OptionErrorCode FAILED = const OptionErrorCode(2);
  String toString() {
    switch(index) {
      case 0: return 'OptionErrorCode.UNKNOWN_OPTION';
      case 1: return 'OptionErrorCode.BAD_VALUE';
      case 2: return 'OptionErrorCode.FAILED';
      default: return 'new OptionErrorCode($index)';
    }
  }
}

class OptionError extends GErrorBase {
  static final int _quark = lookupErrorQuarkFromString('g-option-context-error-quark');
  OptionError(OptionErrorCode code, String message)
      : super.fromFields(_quark, code, message);
}

typedef void OptionErrorFunc(OptionContext context, OptionGroup group);
class OptionFlags extends GEnumBase {
  const OptionFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'OptionFlags');

  static const OptionFlags NONE = const OptionFlags(0);
  bool get none => (index & 0) == 0;
  static const OptionFlags HIDDEN = const OptionFlags(1);
  bool get hidden => (index & 1) == 1;
  static const OptionFlags IN_MAIN = const OptionFlags(2);
  bool get inMain => (index & 2) == 2;
  static const OptionFlags REVERSE = const OptionFlags(4);
  bool get reverse => (index & 4) == 4;
  static const OptionFlags NO_ARG = const OptionFlags(8);
  bool get noArg => (index & 8) == 8;
  static const OptionFlags FILENAME = const OptionFlags(16);
  bool get filename => (index & 16) == 16;
  static const OptionFlags OPTIONAL_ARG = const OptionFlags(32);
  bool get optionalArg => (index & 32) == 32;
  static const OptionFlags NOALIAS = const OptionFlags(64);
  bool get noalias => (index & 64) == 64;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'OptionFlags.HIDDEN';
      case 2: return 'OptionFlags.IN_MAIN';
      case 4: return 'OptionFlags.REVERSE';
      case 8: return 'OptionFlags.NO_ARG';
      case 16: return 'OptionFlags.FILENAME';
      case 32: return 'OptionFlags.OPTIONAL_ARG';
      case 64: return 'OptionFlags.NOALIAS';
      default: return 'new OptionFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'OptionFlags.NONE';
    }
    List codes = [];
    for (var i=1; i <= 64; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  OptionFlags operator|(OptionFlags other) =>
    new OptionFlags(index | other.index);
  OptionFlags operator&(OptionFlags other) =>
    new OptionFlags(index & other.index);
}

class OptionGroup extends GObjectBase {
  OptionGroup.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'OptionGroup');

  factory OptionGroup(String name, String description, String helpDescription, dynamic userData /* this will fail */, DestroyNotify destroy) => _staticInfo.callStatic('new', [name, description, helpDescription, userData, destroy]);
  void addEntries(OptionEntry entries) => _staticInfo.callMethodOnReceiver('add_entries', this, [entries]);
  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
  OptionGroup ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  void setTranslateFunc(TranslateFunc func) => _staticInfo.callMethodOnReceiver('set_translate_func', this, [func]);
  void setTranslationDomain(String domain) => _staticInfo.callMethodOnReceiver('set_translation_domain', this, [domain]);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
}

typedef void OptionParseFunc(OptionContext context, OptionGroup group);
class PatternSpec extends GObjectBase {
  PatternSpec.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'PatternSpec');

  bool equal(PatternSpec pspec2) => _staticInfo.callMethodOnReceiver('equal', this, [pspec2]);
  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
}

class PollFD extends GObjectBase {
  PollFD.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'PollFD');

  int get fd => getFieldOfObject('fd', 0);
  void set fd(int value) => setFieldOfObject('fd', 0, value);
  int get events => getFieldOfObject('events', 1);
  void set events(int value) => setFieldOfObject('events', 1, value);
  int get revents => getFieldOfObject('revents', 2);
  void set revents(int value) => setFieldOfObject('revents', 2, value);
}

typedef int PollFunc(PollFD ufds, int nfsd, int timeout_);
typedef void PrintFunc(String string);
class Private extends GObjectBase {
  Private.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'Private');

  void replace(dynamic value /* this will fail */) => _staticInfo.callMethodOnReceiver('replace', this, [value]);
  void set_(dynamic value /* this will fail */) => _staticInfo.callMethodOnReceiver('set', this, [value]);
  dynamic /* this will fail */ get p => getFieldOfObject('p', 0);
  DestroyNotify get notify => getFieldOfObject('notify', 1);
  List<dynamic /* this will fail */> get future => getFieldOfObject('future', 2);
}

class PtrArray extends GObjectBase {
  PtrArray.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'PtrArray');

  dynamic /* this will fail */ get pdata => getFieldOfObject('pdata', 0);
  void set pdata(dynamic value /* this will fail */) => setFieldOfObject('pdata', 0, value);
  int get len => getFieldOfObject('len', 1);
  void set len(int value) => setFieldOfObject('len', 1, value);
}

class Queue extends GObjectBase {
  Queue.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'Queue');

  void clear() => _staticInfo.callMethodOnReceiver('clear', this, []);
  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
  void freeFull(DestroyNotify freeFunc) => _staticInfo.callMethodOnReceiver('free_full', this, [freeFunc]);
  int get length => _staticInfo.callMethodOnReceiver('get_length', this, []);
  int index(dynamic data /* this will fail */) => _staticInfo.callMethodOnReceiver('index', this, [data]);
  void init() => _staticInfo.callMethodOnReceiver('init', this, []);
  bool isEmpty() => _staticInfo.callMethodOnReceiver('is_empty', this, []);
  void pushHead(dynamic data /* this will fail */) => _staticInfo.callMethodOnReceiver('push_head', this, [data]);
  void pushNth(dynamic data /* this will fail */, int n) => _staticInfo.callMethodOnReceiver('push_nth', this, [data, n]);
  void pushTail(dynamic data /* this will fail */) => _staticInfo.callMethodOnReceiver('push_tail', this, [data]);
  bool remove(dynamic data /* this will fail */) => _staticInfo.callMethodOnReceiver('remove', this, [data]);
  int removeAll(dynamic data /* this will fail */) => _staticInfo.callMethodOnReceiver('remove_all', this, [data]);
  void reverse() => _staticInfo.callMethodOnReceiver('reverse', this, []);
  GLibList /* this will fail */ get head => getFieldOfObject('head', 0);
  void set head(GLibList value /* this will fail */) => setFieldOfObject('head', 0, value);
  GLibList /* this will fail */ get tail => getFieldOfObject('tail', 1);
  void set tail(GLibList value /* this will fail */) => setFieldOfObject('tail', 1, value);
}

class RWLock extends GObjectBase {
  RWLock.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'RWLock');

  void clear() => _staticInfo.callMethodOnReceiver('clear', this, []);
  void init() => _staticInfo.callMethodOnReceiver('init', this, []);
  void readerLock() => _staticInfo.callMethodOnReceiver('reader_lock', this, []);
  bool readerTrylock() => _staticInfo.callMethodOnReceiver('reader_trylock', this, []);
  void readerUnlock() => _staticInfo.callMethodOnReceiver('reader_unlock', this, []);
  void writerLock() => _staticInfo.callMethodOnReceiver('writer_lock', this, []);
  bool writerTrylock() => _staticInfo.callMethodOnReceiver('writer_trylock', this, []);
  void writerUnlock() => _staticInfo.callMethodOnReceiver('writer_unlock', this, []);
  dynamic /* this will fail */ get p => getFieldOfObject('p', 0);
  List<int> get i => getFieldOfObject('i', 1);
}

class Rand extends GObjectBase {
  Rand.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'Rand');

  num double() => _staticInfo.callMethodOnReceiver('double', this, []);
  num doubleRange(num begin, num end) => _staticInfo.callMethodOnReceiver('double_range', this, [begin, end]);
  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
  int int_() => _staticInfo.callMethodOnReceiver('int', this, []);
  int intRange(int begin, int end) => _staticInfo.callMethodOnReceiver('int_range', this, [begin, end]);
  void setSeed(int seed) => _staticInfo.callMethodOnReceiver('set_seed', this, [seed]);
  void setSeedArray(int seed, int seedLength) => _staticInfo.callMethodOnReceiver('set_seed_array', this, [seed, seedLength]);
}

class RecMutex extends GObjectBase {
  RecMutex.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'RecMutex');

  void clear() => _staticInfo.callMethodOnReceiver('clear', this, []);
  void init() => _staticInfo.callMethodOnReceiver('init', this, []);
  void lock() => _staticInfo.callMethodOnReceiver('lock', this, []);
  bool trylock() => _staticInfo.callMethodOnReceiver('trylock', this, []);
  void unlock() => _staticInfo.callMethodOnReceiver('unlock', this, []);
  dynamic /* this will fail */ get p => getFieldOfObject('p', 0);
  List<int> get i => getFieldOfObject('i', 1);
}

class Regex extends GObjectBase {
  Regex.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'Regex');

  factory Regex(String pattern, RegexCompileFlags compileOptions, RegexMatchFlags matchOptions) => _staticInfo.callStatic('new', [pattern, compileOptions, matchOptions]);
  int get captureCount => _staticInfo.callMethodOnReceiver('get_capture_count', this, []);
  RegexCompileFlags get compileFlags => _staticInfo.callMethodOnReceiver('get_compile_flags', this, []);
  bool get hasCrOrLf => _staticInfo.callMethodOnReceiver('get_has_cr_or_lf', this, []);
  RegexMatchFlags get matchFlags => _staticInfo.callMethodOnReceiver('get_match_flags', this, []);
  int get maxBackref => _staticInfo.callMethodOnReceiver('get_max_backref', this, []);
  int get maxLookbehind => _staticInfo.callMethodOnReceiver('get_max_lookbehind', this, []);
  String get pattern => _staticInfo.callMethodOnReceiver('get_pattern', this, []);
  int getStringNumber(String name) => _staticInfo.callMethodOnReceiver('get_string_number', this, [name]);
  List match(String string, RegexMatchFlags matchOptions) => _staticInfo.callMethodOnReceiver('match', this, [string, matchOptions]);
  List matchAll(String string, RegexMatchFlags matchOptions) => _staticInfo.callMethodOnReceiver('match_all', this, [string, matchOptions]);
  MatchInfo matchAllFull(List<String> string, int startPosition, RegexMatchFlags matchOptions) => _staticInfo.callMethodOnReceiver('match_all_full', this, [string, startPosition, matchOptions]);
  MatchInfo matchFull(List<String> string, int startPosition, RegexMatchFlags matchOptions) => _staticInfo.callMethodOnReceiver('match_full', this, [string, startPosition, matchOptions]);
  Regex ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  String replace(List<String> string, int startPosition, String replacement, RegexMatchFlags matchOptions) => _staticInfo.callMethodOnReceiver('replace', this, [string, startPosition, replacement, matchOptions]);
  String replaceLiteral(List<String> string, int startPosition, String replacement, RegexMatchFlags matchOptions) => _staticInfo.callMethodOnReceiver('replace_literal', this, [string, startPosition, replacement, matchOptions]);
  List<String> split(String string, RegexMatchFlags matchOptions) => _staticInfo.callMethodOnReceiver('split', this, [string, matchOptions]);
  List<String> splitFull(List<String> string, int startPosition, RegexMatchFlags matchOptions, int maxTokens) => _staticInfo.callMethodOnReceiver('split_full', this, [string, startPosition, matchOptions, maxTokens]);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
  static bool checkReplacement(String replacement) => _staticInfo.callStatic('check_replacement', [replacement]);
  static int errorQuark() => _staticInfo.callStatic('error_quark', []);
  static String escapeNul(String string, int length) => _staticInfo.callStatic('escape_nul', [string, length]);
  static String escapeString(List<String> string) => _staticInfo.callStatic('escape_string', [string]);
  static bool matchSimple(String pattern, String string, RegexCompileFlags compileOptions, RegexMatchFlags matchOptions) => _staticInfo.callStatic('match_simple', [pattern, string, compileOptions, matchOptions]);
  static List<String> splitSimple(String pattern, String string, RegexCompileFlags compileOptions, RegexMatchFlags matchOptions) => _staticInfo.callStatic('split_simple', [pattern, string, compileOptions, matchOptions]);
}

class RegexCompileFlags extends GEnumBase {
  const RegexCompileFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'RegexCompileFlags');

  static const RegexCompileFlags NULL = const RegexCompileFlags(0);
  static const RegexCompileFlags CASELESS = const RegexCompileFlags(1);
  bool get caseless => (index & 1) == 1;
  static const RegexCompileFlags MULTILINE = const RegexCompileFlags(2);
  bool get multiline => (index & 2) == 2;
  static const RegexCompileFlags DOTALL = const RegexCompileFlags(4);
  bool get dotall => (index & 4) == 4;
  static const RegexCompileFlags EXTENDED = const RegexCompileFlags(8);
  bool get extended => (index & 8) == 8;
  static const RegexCompileFlags ANCHORED = const RegexCompileFlags(16);
  bool get anchored => (index & 16) == 16;
  static const RegexCompileFlags DOLLAR_ENDONLY = const RegexCompileFlags(32);
  bool get dollarEndonly => (index & 32) == 32;
  static const RegexCompileFlags UNGREEDY = const RegexCompileFlags(512);
  bool get ungreedy => (index & 512) == 512;
  static const RegexCompileFlags RAW = const RegexCompileFlags(2048);
  bool get raw => (index & 2048) == 2048;
  static const RegexCompileFlags NO_AUTO_CAPTURE = const RegexCompileFlags(4096);
  bool get noAutoCapture => (index & 4096) == 4096;
  static const RegexCompileFlags OPTIMIZE = const RegexCompileFlags(8192);
  bool get optimize => (index & 8192) == 8192;
  static const RegexCompileFlags FIRSTLINE = const RegexCompileFlags(262144);
  bool get firstline => (index & 262144) == 262144;
  static const RegexCompileFlags DUPNAMES = const RegexCompileFlags(524288);
  bool get dupnames => (index & 524288) == 524288;
  static const RegexCompileFlags NEWLINE_CR = const RegexCompileFlags(1048576);
  bool get newlineCr => (index & 1048576) == 1048576;
  static const RegexCompileFlags NEWLINE_LF = const RegexCompileFlags(2097152);
  bool get newlineLf => (index & 2097152) == 2097152;
  static const RegexCompileFlags NEWLINE_CRLF = const RegexCompileFlags(3145728);
  bool get newlineCrlf => (index & 3145728) == 3145728;
  static const RegexCompileFlags NEWLINE_ANYCRLF = const RegexCompileFlags(5242880);
  bool get newlineAnycrlf => (index & 5242880) == 5242880;
  static const RegexCompileFlags BSR_ANYCRLF = const RegexCompileFlags(8388608);
  bool get bsrAnycrlf => (index & 8388608) == 8388608;
  static const RegexCompileFlags JAVASCRIPT_COMPAT = const RegexCompileFlags(33554432);
  bool get javascriptCompat => (index & 33554432) == 33554432;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'RegexCompileFlags.CASELESS';
      case 2: return 'RegexCompileFlags.MULTILINE';
      case 4: return 'RegexCompileFlags.DOTALL';
      case 8: return 'RegexCompileFlags.EXTENDED';
      case 16: return 'RegexCompileFlags.ANCHORED';
      case 32: return 'RegexCompileFlags.DOLLAR_ENDONLY';
      default: return 'new RegexCompileFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'RegexCompileFlags.NULL';
    }
    List codes = [];
    for (var i=1; i <= 33554432; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  RegexCompileFlags operator|(RegexCompileFlags other) =>
    new RegexCompileFlags(index | other.index);
  RegexCompileFlags operator&(RegexCompileFlags other) =>
    new RegexCompileFlags(index & other.index);
}

class RegexErrorCode extends GEnumBase {
  const RegexErrorCode(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'RegexError');

  static const RegexErrorCode COMPILE = const RegexErrorCode(0);
  static const RegexErrorCode OPTIMIZE = const RegexErrorCode(1);
  static const RegexErrorCode REPLACE = const RegexErrorCode(2);
  static const RegexErrorCode MATCH = const RegexErrorCode(3);
  static const RegexErrorCode INTERNAL = const RegexErrorCode(4);
  static const RegexErrorCode STRAY_BACKSLASH = const RegexErrorCode(101);
  static const RegexErrorCode MISSING_CONTROL_CHAR = const RegexErrorCode(102);
  static const RegexErrorCode UNRECOGNIZED_ESCAPE = const RegexErrorCode(103);
  static const RegexErrorCode QUANTIFIERS_OUT_OF_ORDER = const RegexErrorCode(104);
  static const RegexErrorCode QUANTIFIER_TOO_BIG = const RegexErrorCode(105);
  static const RegexErrorCode UNTERMINATED_CHARACTER_CLASS = const RegexErrorCode(106);
  static const RegexErrorCode INVALID_ESCAPE_IN_CHARACTER_CLASS = const RegexErrorCode(107);
  static const RegexErrorCode RANGE_OUT_OF_ORDER = const RegexErrorCode(108);
  static const RegexErrorCode NOTHING_TO_REPEAT = const RegexErrorCode(109);
  static const RegexErrorCode UNRECOGNIZED_CHARACTER = const RegexErrorCode(112);
  static const RegexErrorCode POSIX_NAMED_CLASS_OUTSIDE_CLASS = const RegexErrorCode(113);
  static const RegexErrorCode UNMATCHED_PARENTHESIS = const RegexErrorCode(114);
  static const RegexErrorCode INEXISTENT_SUBPATTERN_REFERENCE = const RegexErrorCode(115);
  static const RegexErrorCode UNTERMINATED_COMMENT = const RegexErrorCode(118);
  static const RegexErrorCode EXPRESSION_TOO_LARGE = const RegexErrorCode(120);
  static const RegexErrorCode MEMORY_ERROR = const RegexErrorCode(121);
  static const RegexErrorCode VARIABLE_LENGTH_LOOKBEHIND = const RegexErrorCode(125);
  static const RegexErrorCode MALFORMED_CONDITION = const RegexErrorCode(126);
  static const RegexErrorCode TOO_MANY_CONDITIONAL_BRANCHES = const RegexErrorCode(127);
  static const RegexErrorCode ASSERTION_EXPECTED = const RegexErrorCode(128);
  static const RegexErrorCode UNKNOWN_POSIX_CLASS_NAME = const RegexErrorCode(130);
  static const RegexErrorCode POSIX_COLLATING_ELEMENTS_NOT_SUPPORTED = const RegexErrorCode(131);
  static const RegexErrorCode HEX_CODE_TOO_LARGE = const RegexErrorCode(134);
  static const RegexErrorCode INVALID_CONDITION = const RegexErrorCode(135);
  static const RegexErrorCode SINGLE_BYTE_MATCH_IN_LOOKBEHIND = const RegexErrorCode(136);
  static const RegexErrorCode INFINITE_LOOP = const RegexErrorCode(140);
  static const RegexErrorCode MISSING_SUBPATTERN_NAME_TERMINATOR = const RegexErrorCode(142);
  static const RegexErrorCode DUPLICATE_SUBPATTERN_NAME = const RegexErrorCode(143);
  static const RegexErrorCode MALFORMED_PROPERTY = const RegexErrorCode(146);
  static const RegexErrorCode UNKNOWN_PROPERTY = const RegexErrorCode(147);
  static const RegexErrorCode SUBPATTERN_NAME_TOO_LONG = const RegexErrorCode(148);
  static const RegexErrorCode TOO_MANY_SUBPATTERNS = const RegexErrorCode(149);
  static const RegexErrorCode INVALID_OCTAL_VALUE = const RegexErrorCode(151);
  static const RegexErrorCode TOO_MANY_BRANCHES_IN_DEFINE = const RegexErrorCode(154);
  static const RegexErrorCode DEFINE_REPETION = const RegexErrorCode(155);
  static const RegexErrorCode INCONSISTENT_NEWLINE_OPTIONS = const RegexErrorCode(156);
  static const RegexErrorCode MISSING_BACK_REFERENCE = const RegexErrorCode(157);
  static const RegexErrorCode INVALID_RELATIVE_REFERENCE = const RegexErrorCode(158);
  static const RegexErrorCode BACKTRACKING_CONTROL_VERB_ARGUMENT_FORBIDDEN = const RegexErrorCode(159);
  static const RegexErrorCode UNKNOWN_BACKTRACKING_CONTROL_VERB = const RegexErrorCode(160);
  static const RegexErrorCode NUMBER_TOO_BIG = const RegexErrorCode(161);
  static const RegexErrorCode MISSING_SUBPATTERN_NAME = const RegexErrorCode(162);
  static const RegexErrorCode MISSING_DIGIT = const RegexErrorCode(163);
  static const RegexErrorCode INVALID_DATA_CHARACTER = const RegexErrorCode(164);
  static const RegexErrorCode EXTRA_SUBPATTERN_NAME = const RegexErrorCode(165);
  static const RegexErrorCode BACKTRACKING_CONTROL_VERB_ARGUMENT_REQUIRED = const RegexErrorCode(166);
  static const RegexErrorCode INVALID_CONTROL_CHAR = const RegexErrorCode(168);
  static const RegexErrorCode MISSING_NAME = const RegexErrorCode(169);
  static const RegexErrorCode NOT_SUPPORTED_IN_CLASS = const RegexErrorCode(171);
  static const RegexErrorCode TOO_MANY_FORWARD_REFERENCES = const RegexErrorCode(172);
  static const RegexErrorCode NAME_TOO_LONG = const RegexErrorCode(175);
  static const RegexErrorCode CHARACTER_VALUE_TOO_LARGE = const RegexErrorCode(176);
  String toString() {
    switch(index) {
      case 0: return 'RegexErrorCode.COMPILE';
      case 1: return 'RegexErrorCode.OPTIMIZE';
      case 2: return 'RegexErrorCode.REPLACE';
      case 3: return 'RegexErrorCode.MATCH';
      case 4: return 'RegexErrorCode.INTERNAL';
      case 101: return 'RegexErrorCode.STRAY_BACKSLASH';
      case 102: return 'RegexErrorCode.MISSING_CONTROL_CHAR';
      case 103: return 'RegexErrorCode.UNRECOGNIZED_ESCAPE';
      case 104: return 'RegexErrorCode.QUANTIFIERS_OUT_OF_ORDER';
      case 105: return 'RegexErrorCode.QUANTIFIER_TOO_BIG';
      case 106: return 'RegexErrorCode.UNTERMINATED_CHARACTER_CLASS';
      case 107: return 'RegexErrorCode.INVALID_ESCAPE_IN_CHARACTER_CLASS';
      case 108: return 'RegexErrorCode.RANGE_OUT_OF_ORDER';
      case 109: return 'RegexErrorCode.NOTHING_TO_REPEAT';
      case 112: return 'RegexErrorCode.UNRECOGNIZED_CHARACTER';
      case 113: return 'RegexErrorCode.POSIX_NAMED_CLASS_OUTSIDE_CLASS';
      case 114: return 'RegexErrorCode.UNMATCHED_PARENTHESIS';
      case 115: return 'RegexErrorCode.INEXISTENT_SUBPATTERN_REFERENCE';
      case 118: return 'RegexErrorCode.UNTERMINATED_COMMENT';
      case 120: return 'RegexErrorCode.EXPRESSION_TOO_LARGE';
      case 121: return 'RegexErrorCode.MEMORY_ERROR';
      case 125: return 'RegexErrorCode.VARIABLE_LENGTH_LOOKBEHIND';
      case 126: return 'RegexErrorCode.MALFORMED_CONDITION';
      case 127: return 'RegexErrorCode.TOO_MANY_CONDITIONAL_BRANCHES';
      case 128: return 'RegexErrorCode.ASSERTION_EXPECTED';
      case 130: return 'RegexErrorCode.UNKNOWN_POSIX_CLASS_NAME';
      case 131: return 'RegexErrorCode.POSIX_COLLATING_ELEMENTS_NOT_SUPPORTED';
      case 134: return 'RegexErrorCode.HEX_CODE_TOO_LARGE';
      case 135: return 'RegexErrorCode.INVALID_CONDITION';
      case 136: return 'RegexErrorCode.SINGLE_BYTE_MATCH_IN_LOOKBEHIND';
      case 140: return 'RegexErrorCode.INFINITE_LOOP';
      case 142: return 'RegexErrorCode.MISSING_SUBPATTERN_NAME_TERMINATOR';
      case 143: return 'RegexErrorCode.DUPLICATE_SUBPATTERN_NAME';
      case 146: return 'RegexErrorCode.MALFORMED_PROPERTY';
      case 147: return 'RegexErrorCode.UNKNOWN_PROPERTY';
      case 148: return 'RegexErrorCode.SUBPATTERN_NAME_TOO_LONG';
      case 149: return 'RegexErrorCode.TOO_MANY_SUBPATTERNS';
      case 151: return 'RegexErrorCode.INVALID_OCTAL_VALUE';
      case 154: return 'RegexErrorCode.TOO_MANY_BRANCHES_IN_DEFINE';
      case 155: return 'RegexErrorCode.DEFINE_REPETION';
      case 156: return 'RegexErrorCode.INCONSISTENT_NEWLINE_OPTIONS';
      case 157: return 'RegexErrorCode.MISSING_BACK_REFERENCE';
      case 158: return 'RegexErrorCode.INVALID_RELATIVE_REFERENCE';
      case 159: return 'RegexErrorCode.BACKTRACKING_CONTROL_VERB_ARGUMENT_FORBIDDEN';
      case 160: return 'RegexErrorCode.UNKNOWN_BACKTRACKING_CONTROL_VERB';
      case 161: return 'RegexErrorCode.NUMBER_TOO_BIG';
      case 162: return 'RegexErrorCode.MISSING_SUBPATTERN_NAME';
      case 163: return 'RegexErrorCode.MISSING_DIGIT';
      case 164: return 'RegexErrorCode.INVALID_DATA_CHARACTER';
      case 165: return 'RegexErrorCode.EXTRA_SUBPATTERN_NAME';
      case 166: return 'RegexErrorCode.BACKTRACKING_CONTROL_VERB_ARGUMENT_REQUIRED';
      case 168: return 'RegexErrorCode.INVALID_CONTROL_CHAR';
      case 169: return 'RegexErrorCode.MISSING_NAME';
      case 171: return 'RegexErrorCode.NOT_SUPPORTED_IN_CLASS';
      case 172: return 'RegexErrorCode.TOO_MANY_FORWARD_REFERENCES';
      case 175: return 'RegexErrorCode.NAME_TOO_LONG';
      case 176: return 'RegexErrorCode.CHARACTER_VALUE_TOO_LARGE';
      default: return 'new RegexErrorCode($index)';
    }
  }
}

class RegexError extends GErrorBase {
  static final int _quark = lookupErrorQuarkFromString('g-regex-error-quark');
  RegexError(RegexErrorCode code, String message)
      : super.fromFields(_quark, code, message);
}

typedef bool RegexEvalCallback(MatchInfo matchInfo, GLibString result);
class RegexMatchFlags extends GEnumBase {
  const RegexMatchFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'RegexMatchFlags');

  static const RegexMatchFlags NULL = const RegexMatchFlags(0);
  static const RegexMatchFlags ANCHORED = const RegexMatchFlags(16);
  bool get anchored => (index & 16) == 16;
  static const RegexMatchFlags NOTBOL = const RegexMatchFlags(128);
  bool get notbol => (index & 128) == 128;
  static const RegexMatchFlags NOTEOL = const RegexMatchFlags(256);
  bool get noteol => (index & 256) == 256;
  static const RegexMatchFlags NOTEMPTY = const RegexMatchFlags(1024);
  bool get notempty => (index & 1024) == 1024;
  static const RegexMatchFlags PARTIAL = const RegexMatchFlags(32768);
  bool get partial => (index & 32768) == 32768;
  static const RegexMatchFlags NEWLINE_CR = const RegexMatchFlags(1048576);
  bool get newlineCr => (index & 1048576) == 1048576;
  static const RegexMatchFlags NEWLINE_LF = const RegexMatchFlags(2097152);
  bool get newlineLf => (index & 2097152) == 2097152;
  static const RegexMatchFlags NEWLINE_CRLF = const RegexMatchFlags(3145728);
  bool get newlineCrlf => (index & 3145728) == 3145728;
  static const RegexMatchFlags NEWLINE_ANY = const RegexMatchFlags(4194304);
  bool get newlineAny => (index & 4194304) == 4194304;
  static const RegexMatchFlags NEWLINE_ANYCRLF = const RegexMatchFlags(5242880);
  bool get newlineAnycrlf => (index & 5242880) == 5242880;
  static const RegexMatchFlags BSR_ANYCRLF = const RegexMatchFlags(8388608);
  bool get bsrAnycrlf => (index & 8388608) == 8388608;
  static const RegexMatchFlags BSR_ANY = const RegexMatchFlags(16777216);
  bool get bsrAny => (index & 16777216) == 16777216;
  static const RegexMatchFlags PARTIAL_SOFT = const RegexMatchFlags(32768);
  bool get partialSoft => (index & 32768) == 32768;
  static const RegexMatchFlags PARTIAL_HARD = const RegexMatchFlags(134217728);
  bool get partialHard => (index & 134217728) == 134217728;
  static const RegexMatchFlags NOTEMPTY_ATSTART = const RegexMatchFlags(268435456);
  bool get notemptyAtstart => (index & 268435456) == 268435456;
  static _valueToString(int value) {
    switch(value) {
      case 16: return 'RegexMatchFlags.ANCHORED';
      case 128: return 'RegexMatchFlags.NOTBOL';
      default: return 'new RegexMatchFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'RegexMatchFlags.NULL';
    }
    List codes = [];
    for (var i=1; i <= 268435456; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  RegexMatchFlags operator|(RegexMatchFlags other) =>
    new RegexMatchFlags(index | other.index);
  RegexMatchFlags operator&(RegexMatchFlags other) =>
    new RegexMatchFlags(index & other.index);
}

class SList extends GObjectBase {
  SList.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'SList');

  dynamic /* this will fail */ get data => getFieldOfObject('data', 0);
  void set data(dynamic value /* this will fail */) => setFieldOfObject('data', 0, value);
  SList /* this will fail */ get next => getFieldOfObject('next', 1);
  void set next(SList value /* this will fail */) => setFieldOfObject('next', 1, value);
}

class Scanner extends GObjectBase {
  Scanner.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'Scanner');

  int curLine() => _staticInfo.callMethodOnReceiver('cur_line', this, []);
  int curPosition() => _staticInfo.callMethodOnReceiver('cur_position', this, []);
  TokenType curToken() => _staticInfo.callMethodOnReceiver('cur_token', this, []);
  void destroy() => _staticInfo.callMethodOnReceiver('destroy', this, []);
  bool eof() => _staticInfo.callMethodOnReceiver('eof', this, []);
  TokenType get nextToken => _staticInfo.callMethodOnReceiver('get_next_token', this, []);
  void inputFile(int inputFd) => _staticInfo.callMethodOnReceiver('input_file', this, [inputFd]);
  void inputText(String text, int textLen) => _staticInfo.callMethodOnReceiver('input_text', this, [text, textLen]);
  TokenType peekNextToken() => _staticInfo.callMethodOnReceiver('peek_next_token', this, []);
  void scopeAddSymbol(int scopeId, String symbol, dynamic value /* this will fail */) => _staticInfo.callMethodOnReceiver('scope_add_symbol', this, [scopeId, symbol, value]);
  void scopeRemoveSymbol(int scopeId, String symbol) => _staticInfo.callMethodOnReceiver('scope_remove_symbol', this, [scopeId, symbol]);
  int setScope(int scopeId) => _staticInfo.callMethodOnReceiver('set_scope', this, [scopeId]);
  void syncFileOffset() => _staticInfo.callMethodOnReceiver('sync_file_offset', this, []);
  void unexpToken(TokenType expectedToken, String identifierSpec, String symbolSpec, String symbolName, String message, int isError) => _staticInfo.callMethodOnReceiver('unexp_token', this, [expectedToken, identifierSpec, symbolSpec, symbolName, message, isError]);
  dynamic /* this will fail */ get userData => getFieldOfObject('user_data', 0);
  void set userData(dynamic value /* this will fail */) => setFieldOfObject('user_data', 0, value);
  int get maxParseErrors => getFieldOfObject('max_parse_errors', 1);
  void set maxParseErrors(int value) => setFieldOfObject('max_parse_errors', 1, value);
  int get parseErrors => getFieldOfObject('parse_errors', 2);
  void set parseErrors(int value) => setFieldOfObject('parse_errors', 2, value);
  String get inputName => getFieldOfObject('input_name', 3);
  void set inputName(String value) => setFieldOfObject('input_name', 3, value);
  Data get qdata => getFieldOfObject('qdata', 4);
  void set qdata(Data value) => setFieldOfObject('qdata', 4, value);
  ScannerConfig get config => getFieldOfObject('config', 5);
  void set config(ScannerConfig value) => setFieldOfObject('config', 5, value);
  TokenType get token => getFieldOfObject('token', 6);
  void set token(TokenType value) => setFieldOfObject('token', 6, value);
  TokenValue get value => getFieldOfObject('value', 7);
  void set value(TokenValue value) => setFieldOfObject('value', 7, value);
  int get line => getFieldOfObject('line', 8);
  void set line(int value) => setFieldOfObject('line', 8, value);
  int get position => getFieldOfObject('position', 9);
  void set position(int value) => setFieldOfObject('position', 9, value);
  TokenValue get nextValue => getFieldOfObject('next_value', 11);
  void set nextValue(TokenValue value) => setFieldOfObject('next_value', 11, value);
  int get nextLine => getFieldOfObject('next_line', 12);
  void set nextLine(int value) => setFieldOfObject('next_line', 12, value);
  int get nextPosition => getFieldOfObject('next_position', 13);
  void set nextPosition(int value) => setFieldOfObject('next_position', 13, value);
  HashTable get symbolTable => getFieldOfObject('symbol_table', 14);
  int get inputFd => getFieldOfObject('input_fd', 15);
  String get text => getFieldOfObject('text', 16);
  String get textEnd => getFieldOfObject('text_end', 17);
  String get buffer => getFieldOfObject('buffer', 18);
  int get scopeId => getFieldOfObject('scope_id', 19);
  ScannerMsgFunc get msgHandler => getFieldOfObject('msg_handler', 20);
  void set msgHandler(ScannerMsgFunc value) => setFieldOfObject('msg_handler', 20, value);
}

class ScannerConfig extends GObjectBase {
  ScannerConfig.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'ScannerConfig');

  String get csetSkipCharacters => getFieldOfObject('cset_skip_characters', 0);
  void set csetSkipCharacters(String value) => setFieldOfObject('cset_skip_characters', 0, value);
  String get csetIdentifierFirst => getFieldOfObject('cset_identifier_first', 1);
  void set csetIdentifierFirst(String value) => setFieldOfObject('cset_identifier_first', 1, value);
  String get csetIdentifierNth => getFieldOfObject('cset_identifier_nth', 2);
  void set csetIdentifierNth(String value) => setFieldOfObject('cset_identifier_nth', 2, value);
  String get cpairCommentSingle => getFieldOfObject('cpair_comment_single', 3);
  void set cpairCommentSingle(String value) => setFieldOfObject('cpair_comment_single', 3, value);
  int get caseSensitive => getFieldOfObject('case_sensitive', 4);
  void set caseSensitive(int value) => setFieldOfObject('case_sensitive', 4, value);
  int get skipCommentMulti => getFieldOfObject('skip_comment_multi', 5);
  void set skipCommentMulti(int value) => setFieldOfObject('skip_comment_multi', 5, value);
  int get skipCommentSingle => getFieldOfObject('skip_comment_single', 6);
  void set skipCommentSingle(int value) => setFieldOfObject('skip_comment_single', 6, value);
  int get scanCommentMulti => getFieldOfObject('scan_comment_multi', 7);
  void set scanCommentMulti(int value) => setFieldOfObject('scan_comment_multi', 7, value);
  int get scanIdentifier => getFieldOfObject('scan_identifier', 8);
  void set scanIdentifier(int value) => setFieldOfObject('scan_identifier', 8, value);
  int get scanIdentifier_1char => getFieldOfObject('scan_identifier_1char', 9);
  void set scanIdentifier_1char(int value) => setFieldOfObject('scan_identifier_1char', 9, value);
  int get scanIdentifier_NULL => getFieldOfObject('scan_identifier_NULL', 10);
  void set scanIdentifier_NULL(int value) => setFieldOfObject('scan_identifier_NULL', 10, value);
  int get scanSymbols => getFieldOfObject('scan_symbols', 11);
  void set scanSymbols(int value) => setFieldOfObject('scan_symbols', 11, value);
  int get scanBinary => getFieldOfObject('scan_binary', 12);
  void set scanBinary(int value) => setFieldOfObject('scan_binary', 12, value);
  int get scanOctal => getFieldOfObject('scan_octal', 13);
  void set scanOctal(int value) => setFieldOfObject('scan_octal', 13, value);
  int get scanFloat => getFieldOfObject('scan_float', 14);
  void set scanFloat(int value) => setFieldOfObject('scan_float', 14, value);
  int get scanHex => getFieldOfObject('scan_hex', 15);
  void set scanHex(int value) => setFieldOfObject('scan_hex', 15, value);
  int get scanHexDollar => getFieldOfObject('scan_hex_dollar', 16);
  void set scanHexDollar(int value) => setFieldOfObject('scan_hex_dollar', 16, value);
  int get scanStringSq => getFieldOfObject('scan_string_sq', 17);
  void set scanStringSq(int value) => setFieldOfObject('scan_string_sq', 17, value);
  int get scanStringDq => getFieldOfObject('scan_string_dq', 18);
  void set scanStringDq(int value) => setFieldOfObject('scan_string_dq', 18, value);
  int get numbers_2Int => getFieldOfObject('numbers_2_int', 19);
  void set numbers_2Int(int value) => setFieldOfObject('numbers_2_int', 19, value);
  int get int_2Float => getFieldOfObject('int_2_float', 20);
  void set int_2Float(int value) => setFieldOfObject('int_2_float', 20, value);
  int get identifier_2String => getFieldOfObject('identifier_2_string', 21);
  void set identifier_2String(int value) => setFieldOfObject('identifier_2_string', 21, value);
  int get char_2Token => getFieldOfObject('char_2_token', 22);
  void set char_2Token(int value) => setFieldOfObject('char_2_token', 22, value);
  int get symbol_2Token => getFieldOfObject('symbol_2_token', 23);
  void set symbol_2Token(int value) => setFieldOfObject('symbol_2_token', 23, value);
  int get scope_0Fallback => getFieldOfObject('scope_0_fallback', 24);
  void set scope_0Fallback(int value) => setFieldOfObject('scope_0_fallback', 24, value);
  int get storeInt64 => getFieldOfObject('store_int64', 25);
  void set storeInt64(int value) => setFieldOfObject('store_int64', 25, value);
  int get paddingDummy => getFieldOfObject('padding_dummy', 26);
}

typedef void ScannerMsgFunc(Scanner scanner, String message, bool error);
class SeekType extends GEnumBase {
  const SeekType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'SeekType');

  static const SeekType CUR = const SeekType(0);
  static const SeekType SET = const SeekType(1);
  static const SeekType END = const SeekType(2);
  String toString() {
    switch(index) {
      case 0: return 'SeekType.CUR';
      case 1: return 'SeekType.SET';
      case 2: return 'SeekType.END';
      default: return 'new SeekType($index)';
    }
  }
}

class Sequence extends GObjectBase {
  Sequence.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'Sequence');

  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
  int get length => _staticInfo.callMethodOnReceiver('get_length', this, []);
  static void move(SequenceIter src, SequenceIter dest) => _staticInfo.callStatic('move', [src, dest]);
  static void moveRange(SequenceIter dest, SequenceIter begin, SequenceIter end) => _staticInfo.callStatic('move_range', [dest, begin, end]);
  static void remove(SequenceIter iter) => _staticInfo.callStatic('remove', [iter]);
  static void removeRange(SequenceIter begin, SequenceIter end) => _staticInfo.callStatic('remove_range', [begin, end]);
  static void set_(SequenceIter iter, dynamic data /* this will fail */) => _staticInfo.callStatic('set', [iter, data]);
  static void swap(SequenceIter a, SequenceIter b) => _staticInfo.callStatic('swap', [a, b]);
}

class SequenceIter extends GObjectBase {
  SequenceIter.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'SequenceIter');

  int compare(SequenceIter b) => _staticInfo.callMethodOnReceiver('compare', this, [b]);
  int get position => _staticInfo.callMethodOnReceiver('get_position', this, []);
  bool isBegin() => _staticInfo.callMethodOnReceiver('is_begin', this, []);
  bool isEnd() => _staticInfo.callMethodOnReceiver('is_end', this, []);
}

typedef int SequenceIterCompareFunc(SequenceIter a, SequenceIter b);
class ShellErrorCode extends GEnumBase {
  const ShellErrorCode(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'ShellError');

  static const ShellErrorCode BAD_QUOTING = const ShellErrorCode(0);
  static const ShellErrorCode EMPTY_STRING = const ShellErrorCode(1);
  static const ShellErrorCode FAILED = const ShellErrorCode(2);
  String toString() {
    switch(index) {
      case 0: return 'ShellErrorCode.BAD_QUOTING';
      case 1: return 'ShellErrorCode.EMPTY_STRING';
      case 2: return 'ShellErrorCode.FAILED';
      default: return 'new ShellErrorCode($index)';
    }
  }
}

class ShellError extends GErrorBase {
  static final int _quark = lookupErrorQuarkFromString('g-shell-error-quark');
  ShellError(ShellErrorCode code, String message)
      : super.fromFields(_quark, code, message);
}

class SliceConfig extends GEnumBase {
  const SliceConfig(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'SliceConfig');

  static const SliceConfig ALWAYS_MALLOC = const SliceConfig(1);
  static const SliceConfig BYPASS_MAGAZINES = const SliceConfig(2);
  static const SliceConfig WORKING_SET_MSECS = const SliceConfig(3);
  static const SliceConfig COLOR_INCREMENT = const SliceConfig(4);
  static const SliceConfig CHUNK_SIZES = const SliceConfig(5);
  static const SliceConfig CONTENTION_COUNTER = const SliceConfig(6);
  String toString() {
    switch(index) {
      case 1: return 'SliceConfig.ALWAYS_MALLOC';
      case 2: return 'SliceConfig.BYPASS_MAGAZINES';
      case 3: return 'SliceConfig.WORKING_SET_MSECS';
      case 4: return 'SliceConfig.COLOR_INCREMENT';
      case 5: return 'SliceConfig.CHUNK_SIZES';
      case 6: return 'SliceConfig.CONTENTION_COUNTER';
      default: return 'new SliceConfig($index)';
    }
  }
}

class Source extends GObjectBase {
  Source.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'Source');

  factory Source(SourceFuncs sourceFuncs, int structSize) => _staticInfo.callStatic('new', [sourceFuncs, structSize]);
  void addChildSource(Source childSource) => _staticInfo.callMethodOnReceiver('add_child_source', this, [childSource]);
  void addPoll(PollFD fd) => _staticInfo.callMethodOnReceiver('add_poll', this, [fd]);
  int attach(MainContext context) => _staticInfo.callMethodOnReceiver('attach', this, [context]);
  void destroy() => _staticInfo.callMethodOnReceiver('destroy', this, []);
  bool get canRecurse => _staticInfo.callMethodOnReceiver('get_can_recurse', this, []);
  MainContext get context => _staticInfo.callMethodOnReceiver('get_context', this, []);
  void getCurrentTime(TimeVal timeval) => _staticInfo.callMethodOnReceiver('get_current_time', this, [timeval]);
  int get id => _staticInfo.callMethodOnReceiver('get_id', this, []);
  String get name => _staticInfo.callMethodOnReceiver('get_name', this, []);
  int get priority => _staticInfo.callMethodOnReceiver('get_priority', this, []);
  int get readyTime => _staticInfo.callMethodOnReceiver('get_ready_time', this, []);
  int get time => _staticInfo.callMethodOnReceiver('get_time', this, []);
  bool isDestroyed() => _staticInfo.callMethodOnReceiver('is_destroyed', this, []);
  void modifyUnixFd(dynamic tag /* this will fail */, IOCondition newEvents) => _staticInfo.callMethodOnReceiver('modify_unix_fd', this, [tag, newEvents]);
  IOCondition queryUnixFd(dynamic tag /* this will fail */) => _staticInfo.callMethodOnReceiver('query_unix_fd', this, [tag]);
  Source ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  void removeChildSource(Source childSource) => _staticInfo.callMethodOnReceiver('remove_child_source', this, [childSource]);
  void removePoll(PollFD fd) => _staticInfo.callMethodOnReceiver('remove_poll', this, [fd]);
  void removeUnixFd(dynamic tag /* this will fail */) => _staticInfo.callMethodOnReceiver('remove_unix_fd', this, [tag]);
  void setCallback(SourceFunc func) => _staticInfo.callMethodOnReceiver('set_callback', this, [func]);
  void setCallbackIndirect(dynamic callbackData /* this will fail */, SourceCallbackFuncs callbackFuncs) => _staticInfo.callMethodOnReceiver('set_callback_indirect', this, [callbackData, callbackFuncs]);
  void set canRecurse(bool canRecurse) => _staticInfo.callMethodOnReceiver('set_can_recurse', this, [canRecurse]);
  void setFuncs(SourceFuncs funcs) => _staticInfo.callMethodOnReceiver('set_funcs', this, [funcs]);
  void set name(String name) => _staticInfo.callMethodOnReceiver('set_name', this, [name]);
  void set priority(int priority) => _staticInfo.callMethodOnReceiver('set_priority', this, [priority]);
  void set readyTime(int readyTime) => _staticInfo.callMethodOnReceiver('set_ready_time', this, [readyTime]);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
  static bool remove(int tag) => _staticInfo.callStatic('remove', [tag]);
  static bool removeByFuncsUserData(SourceFuncs funcs, dynamic userData /* this will fail */) => _staticInfo.callStatic('remove_by_funcs_user_data', [funcs, userData]);
  static bool removeByUserData(dynamic userData /* this will fail */) => _staticInfo.callStatic('remove_by_user_data', [userData]);
  static void setNameById(int tag, String name) => _staticInfo.callStatic('set_name_by_id', [tag, name]);
  dynamic /* this will fail */ get callbackData => getFieldOfObject('callback_data', 0);
  SourceCallbackFuncs get callbackFuncs => getFieldOfObject('callback_funcs', 1);
  SourceFuncs get sourceFuncs => getFieldOfObject('source_funcs', 2);
  int get refCount => getFieldOfObject('ref_count', 3);
  int get flags => getFieldOfObject('flags', 6);
  int get sourceId => getFieldOfObject('source_id', 7);
  SList /* this will fail */ get pollFds => getFieldOfObject('poll_fds', 8);
  Source get prev => getFieldOfObject('prev', 9);
  Source get next => getFieldOfObject('next', 10);
  SourcePrivate get priv => getFieldOfObject('priv', 12);
}

class SourceCallbackFuncs extends GObjectBase {
  SourceCallbackFuncs.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'SourceCallbackFuncs');

  dynamic /* this will fail */ get get_ => getFieldOfObject('get', 2);
}

typedef void SourceDummyMarshal();
typedef bool SourceFunc();
class SourceFuncs extends GObjectBase {
  SourceFuncs.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'SourceFuncs');

  dynamic /* this will fail */ get dispatch => getFieldOfObject('dispatch', 2);
  SourceFunc get closureCallback => getFieldOfObject('closure_callback', 4);
  SourceDummyMarshal get closureMarshal => getFieldOfObject('closure_marshal', 5);
}

class SourcePrivate extends GObjectBase {
  SourcePrivate.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'SourcePrivate');

}

typedef void SpawnChildSetupFunc();
class SpawnErrorCode extends GEnumBase {
  const SpawnErrorCode(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'SpawnError');

  static const SpawnErrorCode FORK = const SpawnErrorCode(0);
  static const SpawnErrorCode READ = const SpawnErrorCode(1);
  static const SpawnErrorCode CHDIR = const SpawnErrorCode(2);
  static const SpawnErrorCode ACCES = const SpawnErrorCode(3);
  static const SpawnErrorCode PERM = const SpawnErrorCode(4);
  static const SpawnErrorCode TOO_BIG = const SpawnErrorCode(5);
  static const SpawnErrorCode NOEXEC = const SpawnErrorCode(6);
  static const SpawnErrorCode NAMETOOLONG = const SpawnErrorCode(7);
  static const SpawnErrorCode NOENT = const SpawnErrorCode(8);
  static const SpawnErrorCode NOMEM = const SpawnErrorCode(9);
  static const SpawnErrorCode NOTDIR = const SpawnErrorCode(10);
  static const SpawnErrorCode LOOP = const SpawnErrorCode(11);
  static const SpawnErrorCode TXTBUSY = const SpawnErrorCode(12);
  static const SpawnErrorCode IO = const SpawnErrorCode(13);
  static const SpawnErrorCode NFILE = const SpawnErrorCode(14);
  static const SpawnErrorCode MFILE = const SpawnErrorCode(15);
  static const SpawnErrorCode INVAL = const SpawnErrorCode(16);
  static const SpawnErrorCode ISDIR = const SpawnErrorCode(17);
  static const SpawnErrorCode LIBBAD = const SpawnErrorCode(18);
  static const SpawnErrorCode FAILED = const SpawnErrorCode(19);
  String toString() {
    switch(index) {
      case 0: return 'SpawnErrorCode.FORK';
      case 1: return 'SpawnErrorCode.READ';
      case 2: return 'SpawnErrorCode.CHDIR';
      case 3: return 'SpawnErrorCode.ACCES';
      case 4: return 'SpawnErrorCode.PERM';
      case 5: return 'SpawnErrorCode.2BIG';
      case 6: return 'SpawnErrorCode.NOEXEC';
      case 7: return 'SpawnErrorCode.NAMETOOLONG';
      case 8: return 'SpawnErrorCode.NOENT';
      case 9: return 'SpawnErrorCode.NOMEM';
      case 10: return 'SpawnErrorCode.NOTDIR';
      case 11: return 'SpawnErrorCode.LOOP';
      case 12: return 'SpawnErrorCode.TXTBUSY';
      case 13: return 'SpawnErrorCode.IO';
      case 14: return 'SpawnErrorCode.NFILE';
      case 15: return 'SpawnErrorCode.MFILE';
      case 16: return 'SpawnErrorCode.INVAL';
      case 17: return 'SpawnErrorCode.ISDIR';
      case 18: return 'SpawnErrorCode.LIBBAD';
      case 19: return 'SpawnErrorCode.FAILED';
      default: return 'new SpawnErrorCode($index)';
    }
  }
}

class SpawnError extends GErrorBase {
  static final int _quark = lookupErrorQuarkFromString('g-exec-error-quark');
  SpawnError(SpawnErrorCode code, String message)
      : super.fromFields(_quark, code, message);
}

class SpawnFlags extends GEnumBase {
  const SpawnFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'SpawnFlags');

  static const SpawnFlags DEFAULT = const SpawnFlags(0);
  bool get default_ => (index & 0) == 0;
  static const SpawnFlags LEAVE_DESCRIPTORS_OPEN = const SpawnFlags(1);
  bool get leaveDescriptorsOpen => (index & 1) == 1;
  static const SpawnFlags DO_NOT_REAP_CHILD = const SpawnFlags(2);
  bool get doNotReapChild => (index & 2) == 2;
  static const SpawnFlags SEARCH_PATH = const SpawnFlags(4);
  bool get searchPath => (index & 4) == 4;
  static const SpawnFlags STDOUT_TO_DEV_NULL = const SpawnFlags(8);
  bool get stdoutToDevNull => (index & 8) == 8;
  static const SpawnFlags STDERR_TO_DEV_NULL = const SpawnFlags(16);
  bool get stderrToDevNull => (index & 16) == 16;
  static const SpawnFlags CHILD_INHERITS_STDIN = const SpawnFlags(32);
  bool get childInheritsStdin => (index & 32) == 32;
  static const SpawnFlags FILE_AND_ARGV_ZERO = const SpawnFlags(64);
  bool get fileAndArgvZero => (index & 64) == 64;
  static const SpawnFlags SEARCH_PATH_FROM_ENVP = const SpawnFlags(128);
  bool get searchPathFromEnvp => (index & 128) == 128;
  static const SpawnFlags CLOEXEC_PIPES = const SpawnFlags(256);
  bool get cloexecPipes => (index & 256) == 256;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'SpawnFlags.LEAVE_DESCRIPTORS_OPEN';
      case 2: return 'SpawnFlags.DO_NOT_REAP_CHILD';
      case 4: return 'SpawnFlags.SEARCH_PATH';
      case 8: return 'SpawnFlags.STDOUT_TO_DEV_NULL';
      case 16: return 'SpawnFlags.STDERR_TO_DEV_NULL';
      case 32: return 'SpawnFlags.CHILD_INHERITS_STDIN';
      case 64: return 'SpawnFlags.FILE_AND_ARGV_ZERO';
      case 128: return 'SpawnFlags.SEARCH_PATH_FROM_ENVP';
      default: return 'new SpawnFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'SpawnFlags.DEFAULT';
    }
    List codes = [];
    for (var i=1; i <= 256; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  SpawnFlags operator|(SpawnFlags other) =>
    new SpawnFlags(index | other.index);
  SpawnFlags operator&(SpawnFlags other) =>
    new SpawnFlags(index & other.index);
}

class StatBuf extends GObjectBase {
  StatBuf.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'StatBuf');

}

class GLibString extends GObjectBase {
  GLibString.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'String');

  GLibString append(String val) => _staticInfo.callMethodOnReceiver('append', this, [val]);
  GLibString appendC(int c) => _staticInfo.callMethodOnReceiver('append_c', this, [c]);
  GLibString appendLen(String val, int len) => _staticInfo.callMethodOnReceiver('append_len', this, [val, len]);
  GLibString appendUnichar(int wc) => _staticInfo.callMethodOnReceiver('append_unichar', this, [wc]);
  GLibString appendUriEscaped(String unescaped, String reservedCharsAllowed, bool allowUtf8) => _staticInfo.callMethodOnReceiver('append_uri_escaped', this, [unescaped, reservedCharsAllowed, allowUtf8]);
  GLibString asciiDown() => _staticInfo.callMethodOnReceiver('ascii_down', this, []);
  GLibString asciiUp() => _staticInfo.callMethodOnReceiver('ascii_up', this, []);
  GLibString assign(String rval) => _staticInfo.callMethodOnReceiver('assign', this, [rval]);
  GLibString down() => _staticInfo.callMethodOnReceiver('down', this, []);
  bool equal(GLibString v2) => _staticInfo.callMethodOnReceiver('equal', this, [v2]);
  GLibString erase(int pos, int len) => _staticInfo.callMethodOnReceiver('erase', this, [pos, len]);
  String free(bool freeSegment) => _staticInfo.callMethodOnReceiver('free', this, [freeSegment]);
  Bytes freeToBytes() => _staticInfo.callMethodOnReceiver('free_to_bytes', this, []);
  int hash() => _staticInfo.callMethodOnReceiver('hash', this, []);
  GLibString insert(int pos, String val) => _staticInfo.callMethodOnReceiver('insert', this, [pos, val]);
  GLibString insertC(int pos, int c) => _staticInfo.callMethodOnReceiver('insert_c', this, [pos, c]);
  GLibString insertLen(int pos, String val, int len) => _staticInfo.callMethodOnReceiver('insert_len', this, [pos, val, len]);
  GLibString insertUnichar(int pos, int wc) => _staticInfo.callMethodOnReceiver('insert_unichar', this, [pos, wc]);
  GLibString overwrite(int pos, String val) => _staticInfo.callMethodOnReceiver('overwrite', this, [pos, val]);
  GLibString overwriteLen(int pos, String val, int len) => _staticInfo.callMethodOnReceiver('overwrite_len', this, [pos, val, len]);
  GLibString prepend(String val) => _staticInfo.callMethodOnReceiver('prepend', this, [val]);
  GLibString prependC(int c) => _staticInfo.callMethodOnReceiver('prepend_c', this, [c]);
  GLibString prependLen(String val, int len) => _staticInfo.callMethodOnReceiver('prepend_len', this, [val, len]);
  GLibString prependUnichar(int wc) => _staticInfo.callMethodOnReceiver('prepend_unichar', this, [wc]);
  GLibString setSize(int len) => _staticInfo.callMethodOnReceiver('set_size', this, [len]);
  GLibString truncate(int len) => _staticInfo.callMethodOnReceiver('truncate', this, [len]);
  GLibString up() => _staticInfo.callMethodOnReceiver('up', this, []);
  String get str => getFieldOfObject('str', 0);
  void set str(String value) => setFieldOfObject('str', 0, value);
  int get len => getFieldOfObject('len', 1);
  void set len(int value) => setFieldOfObject('len', 1, value);
  int get allocatedLen => getFieldOfObject('allocated_len', 2);
  void set allocatedLen(int value) => setFieldOfObject('allocated_len', 2, value);
}

class StringChunk extends GObjectBase {
  StringChunk.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'StringChunk');

  void clear() => _staticInfo.callMethodOnReceiver('clear', this, []);
  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
  String insert(String string) => _staticInfo.callMethodOnReceiver('insert', this, [string]);
  String insertConst(String string) => _staticInfo.callMethodOnReceiver('insert_const', this, [string]);
  String insertLen(String string, int len) => _staticInfo.callMethodOnReceiver('insert_len', this, [string, len]);
}

class TestCase extends GObjectBase {
  TestCase.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'TestCase');

}

class TestConfig extends GObjectBase {
  TestConfig.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'TestConfig');

  bool get testInitialized => getFieldOfObject('test_initialized', 0);
  void set testInitialized(bool value) => setFieldOfObject('test_initialized', 0, value);
  bool get testQuick => getFieldOfObject('test_quick', 1);
  void set testQuick(bool value) => setFieldOfObject('test_quick', 1, value);
  bool get testPerf => getFieldOfObject('test_perf', 2);
  void set testPerf(bool value) => setFieldOfObject('test_perf', 2, value);
  bool get testVerbose => getFieldOfObject('test_verbose', 3);
  void set testVerbose(bool value) => setFieldOfObject('test_verbose', 3, value);
  bool get testQuiet => getFieldOfObject('test_quiet', 4);
  void set testQuiet(bool value) => setFieldOfObject('test_quiet', 4, value);
  bool get testUndefined => getFieldOfObject('test_undefined', 5);
  void set testUndefined(bool value) => setFieldOfObject('test_undefined', 5, value);
}

typedef void TestDataFunc();
class TestFileType extends GEnumBase {
  const TestFileType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'TestFileType');

  static const TestFileType DIST = const TestFileType(0);
  static const TestFileType BUILT = const TestFileType(1);
  String toString() {
    switch(index) {
      case 0: return 'TestFileType.DIST';
      case 1: return 'TestFileType.BUILT';
      default: return 'new TestFileType($index)';
    }
  }
}

typedef void TestFixtureFunc(dynamic fixture /* this will fail */);
typedef void TestFunc();
class TestLogBuffer extends GObjectBase {
  TestLogBuffer.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'TestLogBuffer');

  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
  void push(int nBytes, int bytes) => _staticInfo.callMethodOnReceiver('push', this, [nBytes, bytes]);
  GLibString get data => getFieldOfObject('data', 0);
  SList /* this will fail */ get msgs => getFieldOfObject('msgs', 1);
}

typedef bool TestLogFatalFunc(String logDomain, LogLevelFlags logLevel, String message);
class TestLogMsg extends GObjectBase {
  TestLogMsg.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'TestLogMsg');

  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
  TestLogType get logType => getFieldOfObject('log_type', 0);
  void set logType(TestLogType value) => setFieldOfObject('log_type', 0, value);
  int get nStrings => getFieldOfObject('n_strings', 1);
  void set nStrings(int value) => setFieldOfObject('n_strings', 1, value);
  String get strings => getFieldOfObject('strings', 2);
  void set strings(String value) => setFieldOfObject('strings', 2, value);
  int get nNums => getFieldOfObject('n_nums', 3);
  void set nNums(int value) => setFieldOfObject('n_nums', 3, value);
  int get nums => getFieldOfObject('nums', 4);
  void set nums(int value) => setFieldOfObject('nums', 4, value);
}

class TestLogType extends GEnumBase {
  const TestLogType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'TestLogType');

  static const TestLogType NONE = const TestLogType(0);
  static const TestLogType ERROR = const TestLogType(1);
  static const TestLogType START_BINARY = const TestLogType(2);
  static const TestLogType LIST_CASE = const TestLogType(3);
  static const TestLogType SKIP_CASE = const TestLogType(4);
  static const TestLogType START_CASE = const TestLogType(5);
  static const TestLogType STOP_CASE = const TestLogType(6);
  static const TestLogType MIN_RESULT = const TestLogType(7);
  static const TestLogType MAX_RESULT = const TestLogType(8);
  static const TestLogType MESSAGE = const TestLogType(9);
  static const TestLogType START_SUITE = const TestLogType(10);
  static const TestLogType STOP_SUITE = const TestLogType(11);
  String toString() {
    switch(index) {
      case 0: return 'TestLogType.NONE';
      case 1: return 'TestLogType.ERROR';
      case 2: return 'TestLogType.START_BINARY';
      case 3: return 'TestLogType.LIST_CASE';
      case 4: return 'TestLogType.SKIP_CASE';
      case 5: return 'TestLogType.START_CASE';
      case 6: return 'TestLogType.STOP_CASE';
      case 7: return 'TestLogType.MIN_RESULT';
      case 8: return 'TestLogType.MAX_RESULT';
      case 9: return 'TestLogType.MESSAGE';
      case 10: return 'TestLogType.START_SUITE';
      case 11: return 'TestLogType.STOP_SUITE';
      default: return 'new TestLogType($index)';
    }
  }
}

class TestSubprocessFlags extends GEnumBase {
  const TestSubprocessFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'TestSubprocessFlags');

  static const TestSubprocessFlags NULL = const TestSubprocessFlags(0);
  static const TestSubprocessFlags STDIN = const TestSubprocessFlags(1);
  bool get stdin => (index & 1) == 1;
  static const TestSubprocessFlags STDOUT = const TestSubprocessFlags(2);
  bool get stdout => (index & 2) == 2;
  static const TestSubprocessFlags STDERR = const TestSubprocessFlags(4);
  bool get stderr => (index & 4) == 4;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'TestSubprocessFlags.STDIN';
      case 2: return 'TestSubprocessFlags.STDOUT';
      case 4: return 'TestSubprocessFlags.STDERR';
      default: return 'new TestSubprocessFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'TestSubprocessFlags.NULL';
    }
    List codes = [];
    for (var i=1; i <= 4; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  TestSubprocessFlags operator|(TestSubprocessFlags other) =>
    new TestSubprocessFlags(index | other.index);
  TestSubprocessFlags operator&(TestSubprocessFlags other) =>
    new TestSubprocessFlags(index & other.index);
}

class TestSuite extends GObjectBase {
  TestSuite.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'TestSuite');

  void add(TestCase testCase) => _staticInfo.callMethodOnReceiver('add', this, [testCase]);
  void addSuite(TestSuite nestedsuite) => _staticInfo.callMethodOnReceiver('add_suite', this, [nestedsuite]);
}

class TestTrapFlags extends GEnumBase {
  const TestTrapFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'TestTrapFlags');

  static const TestTrapFlags NULL = const TestTrapFlags(0);
  static const TestTrapFlags SILENCE_STDOUT = const TestTrapFlags(128);
  bool get silenceStdout => (index & 128) == 128;
  static const TestTrapFlags SILENCE_STDERR = const TestTrapFlags(256);
  bool get silenceStderr => (index & 256) == 256;
  static const TestTrapFlags INHERIT_STDIN = const TestTrapFlags(512);
  bool get inheritStdin => (index & 512) == 512;
  static _valueToString(int value) {
    switch(value) {
      case 128: return 'TestTrapFlags.SILENCE_STDOUT';
      default: return 'new TestTrapFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'TestTrapFlags.NULL';
    }
    List codes = [];
    for (var i=1; i <= 512; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  TestTrapFlags operator|(TestTrapFlags other) =>
    new TestTrapFlags(index | other.index);
  TestTrapFlags operator&(TestTrapFlags other) =>
    new TestTrapFlags(index & other.index);
}

class Thread extends GObjectBase {
  Thread.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'Thread');

  Thread ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
  static int errorQuark() => _staticInfo.callStatic('error_quark', []);
  static void exit(dynamic retval /* this will fail */) => _staticInfo.callStatic('exit', [retval]);
  static Thread self() => _staticInfo.callStatic('self', []);
  static void yield_() => _staticInfo.callStatic('yield', []);
}

class ThreadErrorCode extends GEnumBase {
  const ThreadErrorCode(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'ThreadError');

  static const ThreadErrorCode THREAD_ERROR_AGAIN = const ThreadErrorCode(0);
  String toString() {
    switch(index) {
      case 0: return 'ThreadErrorCode.THREAD_ERROR_AGAIN';
      default: return 'new ThreadErrorCode($index)';
    }
  }
}

class ThreadError extends GErrorBase {
  static final int _quark = lookupErrorQuarkFromString('g_thread_error');
  ThreadError(ThreadErrorCode code, String message)
      : super.fromFields(_quark, code, message);
}

class ThreadPool extends GObjectBase {
  ThreadPool.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'ThreadPool');

  void free(bool immediate, bool wait_) => _staticInfo.callMethodOnReceiver('free', this, [immediate, wait_]);
  int get maxThreads => _staticInfo.callMethodOnReceiver('get_max_threads', this, []);
  int get numThreads => _staticInfo.callMethodOnReceiver('get_num_threads', this, []);
  bool moveToFront(dynamic data /* this will fail */) => _staticInfo.callMethodOnReceiver('move_to_front', this, [data]);
  void push(dynamic data /* this will fail */) => _staticInfo.callMethodOnReceiver('push', this, [data]);
  void set maxThreads(int maxThreads) => _staticInfo.callMethodOnReceiver('set_max_threads', this, [maxThreads]);
  int unprocessed() => _staticInfo.callMethodOnReceiver('unprocessed', this, []);
  static int getMaxIdleTime() => _staticInfo.callStatic('get_max_idle_time', []);
  static int getMaxUnusedThreads() => _staticInfo.callStatic('get_max_unused_threads', []);
  static int getNumUnusedThreads() => _staticInfo.callStatic('get_num_unused_threads', []);
  static void setMaxIdleTime(int interval) => _staticInfo.callStatic('set_max_idle_time', [interval]);
  static void setMaxUnusedThreads(int maxThreads) => _staticInfo.callStatic('set_max_unused_threads', [maxThreads]);
  static void stopUnusedThreads() => _staticInfo.callStatic('stop_unused_threads', []);
  Func get func => getFieldOfObject('func', 0);
  void set func(Func value) => setFieldOfObject('func', 0, value);
  dynamic /* this will fail */ get userData => getFieldOfObject('user_data', 1);
  void set userData(dynamic value /* this will fail */) => setFieldOfObject('user_data', 1, value);
  bool get exclusive => getFieldOfObject('exclusive', 2);
  void set exclusive(bool value) => setFieldOfObject('exclusive', 2, value);
}

class TimeType extends GEnumBase {
  const TimeType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'TimeType');

  static const TimeType STANDARD = const TimeType(0);
  static const TimeType DAYLIGHT = const TimeType(1);
  static const TimeType UNIVERSAL = const TimeType(2);
  String toString() {
    switch(index) {
      case 0: return 'TimeType.STANDARD';
      case 1: return 'TimeType.DAYLIGHT';
      case 2: return 'TimeType.UNIVERSAL';
      default: return 'new TimeType($index)';
    }
  }
}

class TimeVal extends GObjectBase {
  TimeVal.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'TimeVal');

  void add(int microseconds) => _staticInfo.callMethodOnReceiver('add', this, [microseconds]);
  String toIso8601() => _staticInfo.callMethodOnReceiver('to_iso8601', this, []);
  static List fromIso8601(String isoDate) => _staticInfo.callStatic('from_iso8601', [isoDate]);
  int get tvSec => getFieldOfObject('tv_sec', 0);
  void set tvSec(int value) => setFieldOfObject('tv_sec', 0, value);
  int get tvUsec => getFieldOfObject('tv_usec', 1);
  void set tvUsec(int value) => setFieldOfObject('tv_usec', 1, value);
}

class TimeZone extends GObjectBase {
  TimeZone.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'TimeZone');

  factory TimeZone(String identifier) => _staticInfo.callStatic('new', [identifier]);
  factory TimeZone.local() => _staticInfo.callStatic('new_local', []);
  factory TimeZone.utc() => _staticInfo.callStatic('new_utc', []);
  int adjustTime(TimeType type, int time_) => _staticInfo.callMethodOnReceiver('adjust_time', this, [type, time_]);
  int findInterval(TimeType type, int time_) => _staticInfo.callMethodOnReceiver('find_interval', this, [type, time_]);
  String getAbbreviation(int interval) => _staticInfo.callMethodOnReceiver('get_abbreviation', this, [interval]);
  int getOffset(int interval) => _staticInfo.callMethodOnReceiver('get_offset', this, [interval]);
  bool isDst(int interval) => _staticInfo.callMethodOnReceiver('is_dst', this, [interval]);
  TimeZone ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
}

class GlibTimer extends GObjectBase {
  GlibTimer.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'Timer');

  void continue_() => _staticInfo.callMethodOnReceiver('continue', this, []);
  void destroy() => _staticInfo.callMethodOnReceiver('destroy', this, []);
  num elapsed(int microseconds) => _staticInfo.callMethodOnReceiver('elapsed', this, [microseconds]);
  void reset() => _staticInfo.callMethodOnReceiver('reset', this, []);
  void start() => _staticInfo.callMethodOnReceiver('start', this, []);
  void stop() => _staticInfo.callMethodOnReceiver('stop', this, []);
}

class TokenType extends GEnumBase {
  const TokenType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'TokenType');

  static const TokenType EOF = const TokenType(0);
  static const TokenType LEFT_PAREN = const TokenType(40);
  static const TokenType RIGHT_PAREN = const TokenType(41);
  static const TokenType LEFT_CURLY = const TokenType(123);
  static const TokenType RIGHT_CURLY = const TokenType(125);
  static const TokenType LEFT_BRACE = const TokenType(91);
  static const TokenType RIGHT_BRACE = const TokenType(93);
  static const TokenType EQUAL_SIGN = const TokenType(61);
  static const TokenType COMMA = const TokenType(44);
  static const TokenType NONE = const TokenType(256);
  static const TokenType ERROR = const TokenType(257);
  static const TokenType CHAR = const TokenType(258);
  static const TokenType BINARY = const TokenType(259);
  static const TokenType OCTAL = const TokenType(260);
  static const TokenType INT = const TokenType(261);
  static const TokenType HEX = const TokenType(262);
  static const TokenType FLOAT = const TokenType(263);
  static const TokenType STRING = const TokenType(264);
  static const TokenType SYMBOL = const TokenType(265);
  static const TokenType IDENTIFIER = const TokenType(266);
  static const TokenType IDENTIFIER_NULL = const TokenType(267);
  static const TokenType COMMENT_SINGLE = const TokenType(268);
  static const TokenType COMMENT_MULTI = const TokenType(269);
  String toString() {
    switch(index) {
      case 0: return 'TokenType.EOF';
      case 40: return 'TokenType.LEFT_PAREN';
      case 41: return 'TokenType.RIGHT_PAREN';
      case 123: return 'TokenType.LEFT_CURLY';
      case 125: return 'TokenType.RIGHT_CURLY';
      case 91: return 'TokenType.LEFT_BRACE';
      case 93: return 'TokenType.RIGHT_BRACE';
      case 61: return 'TokenType.EQUAL_SIGN';
      case 44: return 'TokenType.COMMA';
      case 256: return 'TokenType.NONE';
      case 257: return 'TokenType.ERROR';
      case 258: return 'TokenType.CHAR';
      case 259: return 'TokenType.BINARY';
      case 260: return 'TokenType.OCTAL';
      case 261: return 'TokenType.INT';
      case 262: return 'TokenType.HEX';
      case 263: return 'TokenType.FLOAT';
      case 264: return 'TokenType.STRING';
      case 265: return 'TokenType.SYMBOL';
      case 266: return 'TokenType.IDENTIFIER';
      case 267: return 'TokenType.IDENTIFIER_NULL';
      case 268: return 'TokenType.COMMENT_SINGLE';
      case 269: return 'TokenType.COMMENT_MULTI';
      default: return 'new TokenType($index)';
    }
  }
}

class TokenValue extends GObjectBase {
  TokenValue.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'TokenValue');

  dynamic /* this will fail */ get vSymbol => getFieldOfObject('v_symbol', 0);
  void set vSymbol(dynamic value /* this will fail */) => setFieldOfObject('v_symbol', 0, value);
  String get vIdentifier => getFieldOfObject('v_identifier', 1);
  void set vIdentifier(String value) => setFieldOfObject('v_identifier', 1, value);
  int get vBinary => getFieldOfObject('v_binary', 2);
  void set vBinary(int value) => setFieldOfObject('v_binary', 2, value);
  int get vOctal => getFieldOfObject('v_octal', 3);
  void set vOctal(int value) => setFieldOfObject('v_octal', 3, value);
  int get vInt => getFieldOfObject('v_int', 4);
  void set vInt(int value) => setFieldOfObject('v_int', 4, value);
  int get vInt64 => getFieldOfObject('v_int64', 5);
  void set vInt64(int value) => setFieldOfObject('v_int64', 5, value);
  num get vFloat => getFieldOfObject('v_float', 6);
  void set vFloat(num value) => setFieldOfObject('v_float', 6, value);
  int get vHex => getFieldOfObject('v_hex', 7);
  void set vHex(int value) => setFieldOfObject('v_hex', 7, value);
  String get vString => getFieldOfObject('v_string', 8);
  void set vString(String value) => setFieldOfObject('v_string', 8, value);
  String get vComment => getFieldOfObject('v_comment', 9);
  void set vComment(String value) => setFieldOfObject('v_comment', 9, value);
  int get vChar => getFieldOfObject('v_char', 10);
  void set vChar(int value) => setFieldOfObject('v_char', 10, value);
  int get vError => getFieldOfObject('v_error', 11);
  void set vError(int value) => setFieldOfObject('v_error', 11, value);
}

typedef String TranslateFunc(String str);
class TrashStack extends GObjectBase {
  TrashStack.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'TrashStack');

  static int height(TrashStack stackP) => _staticInfo.callStatic('height', [stackP]);
  static void push(TrashStack stackP, dynamic dataP /* this will fail */) => _staticInfo.callStatic('push', [stackP, dataP]);
  TrashStack get next => getFieldOfObject('next', 0);
  void set next(TrashStack value) => setFieldOfObject('next', 0, value);
}

class TraverseFlags extends GEnumBase {
  const TraverseFlags(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'TraverseFlags');

  static const TraverseFlags NULL = const TraverseFlags(0);
  static const TraverseFlags LEAVES = const TraverseFlags(1);
  bool get leaves => (index & 1) == 1;
  static const TraverseFlags NON_LEAVES = const TraverseFlags(2);
  bool get nonLeaves => (index & 2) == 2;
  static const TraverseFlags ALL = const TraverseFlags(3);
  bool get all => (index & 3) == 3;
  static const TraverseFlags MASK = const TraverseFlags(3);
  bool get mask => (index & 3) == 3;
  static const TraverseFlags LEAFS = const TraverseFlags(1);
  bool get leafs => (index & 1) == 1;
  static const TraverseFlags NON_LEAFS = const TraverseFlags(2);
  bool get nonLeafs => (index & 2) == 2;
  static _valueToString(int value) {
    switch(value) {
      case 1: return 'TraverseFlags.LEAVES';
      case 2: return 'TraverseFlags.NON_LEAVES';
      default: return 'new TraverseFlags($value)';
    }
  }
  String toString() {
    if (index == 0) {
      return 'TraverseFlags.NULL';
    }
    List codes = [];
    for (var i=1; i <= 2; i <<= 1) {
      if (index & i != 0) codes.add(_valueToString(i));
    }
    return codes.join(' | ');
  }
  TraverseFlags operator|(TraverseFlags other) =>
    new TraverseFlags(index | other.index);
  TraverseFlags operator&(TraverseFlags other) =>
    new TraverseFlags(index & other.index);
}

typedef bool TraverseFunc(dynamic key /* this will fail */, dynamic value /* this will fail */);
class TraverseType extends GEnumBase {
  const TraverseType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'TraverseType');

  static const TraverseType IN_ORDER = const TraverseType(0);
  static const TraverseType PRE_ORDER = const TraverseType(1);
  static const TraverseType POST_ORDER = const TraverseType(2);
  static const TraverseType LEVEL_ORDER = const TraverseType(3);
  String toString() {
    switch(index) {
      case 0: return 'TraverseType.IN_ORDER';
      case 1: return 'TraverseType.PRE_ORDER';
      case 2: return 'TraverseType.POST_ORDER';
      case 3: return 'TraverseType.LEVEL_ORDER';
      default: return 'new TraverseType($index)';
    }
  }
}

class Tree extends GObjectBase {
  Tree.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'Tree');

  void destroy() => _staticInfo.callMethodOnReceiver('destroy', this, []);
  int height() => _staticInfo.callMethodOnReceiver('height', this, []);
  void insert(dynamic key /* this will fail */, dynamic value /* this will fail */) => _staticInfo.callMethodOnReceiver('insert', this, [key, value]);
  bool lookupExtended(dynamic lookupKey /* this will fail */, dynamic origKey /* this will fail */, dynamic value /* this will fail */) => _staticInfo.callMethodOnReceiver('lookup_extended', this, [lookupKey, origKey, value]);
  int nnodes() => _staticInfo.callMethodOnReceiver('nnodes', this, []);
  bool remove(dynamic key /* this will fail */) => _staticInfo.callMethodOnReceiver('remove', this, [key]);
  void replace(dynamic key /* this will fail */, dynamic value /* this will fail */) => _staticInfo.callMethodOnReceiver('replace', this, [key, value]);
  bool steal(dynamic key /* this will fail */) => _staticInfo.callMethodOnReceiver('steal', this, [key]);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
}

class UnicodeBreakType extends GEnumBase {
  const UnicodeBreakType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'UnicodeBreakType');

  static const UnicodeBreakType MANDATORY = const UnicodeBreakType(0);
  static const UnicodeBreakType CARRIAGE_RETURN = const UnicodeBreakType(1);
  static const UnicodeBreakType LINE_FEED = const UnicodeBreakType(2);
  static const UnicodeBreakType COMBINING_MARK = const UnicodeBreakType(3);
  static const UnicodeBreakType SURROGATE = const UnicodeBreakType(4);
  static const UnicodeBreakType ZERO_WIDTH_SPACE = const UnicodeBreakType(5);
  static const UnicodeBreakType INSEPARABLE = const UnicodeBreakType(6);
  static const UnicodeBreakType NON_BREAKING_GLUE = const UnicodeBreakType(7);
  static const UnicodeBreakType CONTINGENT = const UnicodeBreakType(8);
  static const UnicodeBreakType SPACE = const UnicodeBreakType(9);
  static const UnicodeBreakType AFTER = const UnicodeBreakType(10);
  static const UnicodeBreakType BEFORE = const UnicodeBreakType(11);
  static const UnicodeBreakType BEFORE_AND_AFTER = const UnicodeBreakType(12);
  static const UnicodeBreakType HYPHEN = const UnicodeBreakType(13);
  static const UnicodeBreakType NON_STARTER = const UnicodeBreakType(14);
  static const UnicodeBreakType OPEN_PUNCTUATION = const UnicodeBreakType(15);
  static const UnicodeBreakType CLOSE_PUNCTUATION = const UnicodeBreakType(16);
  static const UnicodeBreakType QUOTATION = const UnicodeBreakType(17);
  static const UnicodeBreakType EXCLAMATION = const UnicodeBreakType(18);
  static const UnicodeBreakType IDEOGRAPHIC = const UnicodeBreakType(19);
  static const UnicodeBreakType NUMERIC = const UnicodeBreakType(20);
  static const UnicodeBreakType INFIX_SEPARATOR = const UnicodeBreakType(21);
  static const UnicodeBreakType SYMBOL = const UnicodeBreakType(22);
  static const UnicodeBreakType ALPHABETIC = const UnicodeBreakType(23);
  static const UnicodeBreakType PREFIX = const UnicodeBreakType(24);
  static const UnicodeBreakType POSTFIX = const UnicodeBreakType(25);
  static const UnicodeBreakType COMPLEX_CONTEXT = const UnicodeBreakType(26);
  static const UnicodeBreakType AMBIGUOUS = const UnicodeBreakType(27);
  static const UnicodeBreakType UNKNOWN = const UnicodeBreakType(28);
  static const UnicodeBreakType NEXT_LINE = const UnicodeBreakType(29);
  static const UnicodeBreakType WORD_JOINER = const UnicodeBreakType(30);
  static const UnicodeBreakType HANGUL_L_JAMO = const UnicodeBreakType(31);
  static const UnicodeBreakType HANGUL_V_JAMO = const UnicodeBreakType(32);
  static const UnicodeBreakType HANGUL_T_JAMO = const UnicodeBreakType(33);
  static const UnicodeBreakType HANGUL_LV_SYLLABLE = const UnicodeBreakType(34);
  static const UnicodeBreakType HANGUL_LVT_SYLLABLE = const UnicodeBreakType(35);
  static const UnicodeBreakType CLOSE_PARANTHESIS = const UnicodeBreakType(36);
  static const UnicodeBreakType CONDITIONAL_JAPANESE_STARTER = const UnicodeBreakType(37);
  static const UnicodeBreakType HEBREW_LETTER = const UnicodeBreakType(38);
  static const UnicodeBreakType REGIONAL_INDICATOR = const UnicodeBreakType(39);
  String toString() {
    switch(index) {
      case 0: return 'UnicodeBreakType.MANDATORY';
      case 1: return 'UnicodeBreakType.CARRIAGE_RETURN';
      case 2: return 'UnicodeBreakType.LINE_FEED';
      case 3: return 'UnicodeBreakType.COMBINING_MARK';
      case 4: return 'UnicodeBreakType.SURROGATE';
      case 5: return 'UnicodeBreakType.ZERO_WIDTH_SPACE';
      case 6: return 'UnicodeBreakType.INSEPARABLE';
      case 7: return 'UnicodeBreakType.NON_BREAKING_GLUE';
      case 8: return 'UnicodeBreakType.CONTINGENT';
      case 9: return 'UnicodeBreakType.SPACE';
      case 10: return 'UnicodeBreakType.AFTER';
      case 11: return 'UnicodeBreakType.BEFORE';
      case 12: return 'UnicodeBreakType.BEFORE_AND_AFTER';
      case 13: return 'UnicodeBreakType.HYPHEN';
      case 14: return 'UnicodeBreakType.NON_STARTER';
      case 15: return 'UnicodeBreakType.OPEN_PUNCTUATION';
      case 16: return 'UnicodeBreakType.CLOSE_PUNCTUATION';
      case 17: return 'UnicodeBreakType.QUOTATION';
      case 18: return 'UnicodeBreakType.EXCLAMATION';
      case 19: return 'UnicodeBreakType.IDEOGRAPHIC';
      case 20: return 'UnicodeBreakType.NUMERIC';
      case 21: return 'UnicodeBreakType.INFIX_SEPARATOR';
      case 22: return 'UnicodeBreakType.SYMBOL';
      case 23: return 'UnicodeBreakType.ALPHABETIC';
      case 24: return 'UnicodeBreakType.PREFIX';
      case 25: return 'UnicodeBreakType.POSTFIX';
      case 26: return 'UnicodeBreakType.COMPLEX_CONTEXT';
      case 27: return 'UnicodeBreakType.AMBIGUOUS';
      case 28: return 'UnicodeBreakType.UNKNOWN';
      case 29: return 'UnicodeBreakType.NEXT_LINE';
      case 30: return 'UnicodeBreakType.WORD_JOINER';
      case 31: return 'UnicodeBreakType.HANGUL_L_JAMO';
      case 32: return 'UnicodeBreakType.HANGUL_V_JAMO';
      case 33: return 'UnicodeBreakType.HANGUL_T_JAMO';
      case 34: return 'UnicodeBreakType.HANGUL_LV_SYLLABLE';
      case 35: return 'UnicodeBreakType.HANGUL_LVT_SYLLABLE';
      case 36: return 'UnicodeBreakType.CLOSE_PARANTHESIS';
      case 37: return 'UnicodeBreakType.CONDITIONAL_JAPANESE_STARTER';
      case 38: return 'UnicodeBreakType.HEBREW_LETTER';
      case 39: return 'UnicodeBreakType.REGIONAL_INDICATOR';
      default: return 'new UnicodeBreakType($index)';
    }
  }
}

class UnicodeScript extends GEnumBase {
  const UnicodeScript(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'UnicodeScript');

  static const UnicodeScript INVALID_CODE = const UnicodeScript(-1);
  static const UnicodeScript COMMON = const UnicodeScript(0);
  static const UnicodeScript INHERITED = const UnicodeScript(1);
  static const UnicodeScript ARABIC = const UnicodeScript(2);
  static const UnicodeScript ARMENIAN = const UnicodeScript(3);
  static const UnicodeScript BENGALI = const UnicodeScript(4);
  static const UnicodeScript BOPOMOFO = const UnicodeScript(5);
  static const UnicodeScript CHEROKEE = const UnicodeScript(6);
  static const UnicodeScript COPTIC = const UnicodeScript(7);
  static const UnicodeScript CYRILLIC = const UnicodeScript(8);
  static const UnicodeScript DESERET = const UnicodeScript(9);
  static const UnicodeScript DEVANAGARI = const UnicodeScript(10);
  static const UnicodeScript ETHIOPIC = const UnicodeScript(11);
  static const UnicodeScript GEORGIAN = const UnicodeScript(12);
  static const UnicodeScript GOTHIC = const UnicodeScript(13);
  static const UnicodeScript GREEK = const UnicodeScript(14);
  static const UnicodeScript GUJARATI = const UnicodeScript(15);
  static const UnicodeScript GURMUKHI = const UnicodeScript(16);
  static const UnicodeScript HAN = const UnicodeScript(17);
  static const UnicodeScript HANGUL = const UnicodeScript(18);
  static const UnicodeScript HEBREW = const UnicodeScript(19);
  static const UnicodeScript HIRAGANA = const UnicodeScript(20);
  static const UnicodeScript KANNADA = const UnicodeScript(21);
  static const UnicodeScript KATAKANA = const UnicodeScript(22);
  static const UnicodeScript KHMER = const UnicodeScript(23);
  static const UnicodeScript LAO = const UnicodeScript(24);
  static const UnicodeScript LATIN = const UnicodeScript(25);
  static const UnicodeScript MALAYALAM = const UnicodeScript(26);
  static const UnicodeScript MONGOLIAN = const UnicodeScript(27);
  static const UnicodeScript MYANMAR = const UnicodeScript(28);
  static const UnicodeScript OGHAM = const UnicodeScript(29);
  static const UnicodeScript OLD_ITALIC = const UnicodeScript(30);
  static const UnicodeScript ORIYA = const UnicodeScript(31);
  static const UnicodeScript RUNIC = const UnicodeScript(32);
  static const UnicodeScript SINHALA = const UnicodeScript(33);
  static const UnicodeScript SYRIAC = const UnicodeScript(34);
  static const UnicodeScript TAMIL = const UnicodeScript(35);
  static const UnicodeScript TELUGU = const UnicodeScript(36);
  static const UnicodeScript THAANA = const UnicodeScript(37);
  static const UnicodeScript THAI = const UnicodeScript(38);
  static const UnicodeScript TIBETAN = const UnicodeScript(39);
  static const UnicodeScript CANADIAN_ABORIGINAL = const UnicodeScript(40);
  static const UnicodeScript YI = const UnicodeScript(41);
  static const UnicodeScript TAGALOG = const UnicodeScript(42);
  static const UnicodeScript HANUNOO = const UnicodeScript(43);
  static const UnicodeScript BUHID = const UnicodeScript(44);
  static const UnicodeScript TAGBANWA = const UnicodeScript(45);
  static const UnicodeScript BRAILLE = const UnicodeScript(46);
  static const UnicodeScript CYPRIOT = const UnicodeScript(47);
  static const UnicodeScript LIMBU = const UnicodeScript(48);
  static const UnicodeScript OSMANYA = const UnicodeScript(49);
  static const UnicodeScript SHAVIAN = const UnicodeScript(50);
  static const UnicodeScript LINEAR_B = const UnicodeScript(51);
  static const UnicodeScript TAI_LE = const UnicodeScript(52);
  static const UnicodeScript UGARITIC = const UnicodeScript(53);
  static const UnicodeScript NEW_TAI_LUE = const UnicodeScript(54);
  static const UnicodeScript BUGINESE = const UnicodeScript(55);
  static const UnicodeScript GLAGOLITIC = const UnicodeScript(56);
  static const UnicodeScript TIFINAGH = const UnicodeScript(57);
  static const UnicodeScript SYLOTI_NAGRI = const UnicodeScript(58);
  static const UnicodeScript OLD_PERSIAN = const UnicodeScript(59);
  static const UnicodeScript KHAROSHTHI = const UnicodeScript(60);
  static const UnicodeScript UNKNOWN = const UnicodeScript(61);
  static const UnicodeScript BALINESE = const UnicodeScript(62);
  static const UnicodeScript CUNEIFORM = const UnicodeScript(63);
  static const UnicodeScript PHOENICIAN = const UnicodeScript(64);
  static const UnicodeScript PHAGS_PA = const UnicodeScript(65);
  static const UnicodeScript NKO = const UnicodeScript(66);
  static const UnicodeScript KAYAH_LI = const UnicodeScript(67);
  static const UnicodeScript LEPCHA = const UnicodeScript(68);
  static const UnicodeScript REJANG = const UnicodeScript(69);
  static const UnicodeScript SUNDANESE = const UnicodeScript(70);
  static const UnicodeScript SAURASHTRA = const UnicodeScript(71);
  static const UnicodeScript CHAM = const UnicodeScript(72);
  static const UnicodeScript OL_CHIKI = const UnicodeScript(73);
  static const UnicodeScript VAI = const UnicodeScript(74);
  static const UnicodeScript CARIAN = const UnicodeScript(75);
  static const UnicodeScript LYCIAN = const UnicodeScript(76);
  static const UnicodeScript LYDIAN = const UnicodeScript(77);
  static const UnicodeScript AVESTAN = const UnicodeScript(78);
  static const UnicodeScript BAMUM = const UnicodeScript(79);
  static const UnicodeScript EGYPTIAN_HIEROGLYPHS = const UnicodeScript(80);
  static const UnicodeScript IMPERIAL_ARAMAIC = const UnicodeScript(81);
  static const UnicodeScript INSCRIPTIONAL_PAHLAVI = const UnicodeScript(82);
  static const UnicodeScript INSCRIPTIONAL_PARTHIAN = const UnicodeScript(83);
  static const UnicodeScript JAVANESE = const UnicodeScript(84);
  static const UnicodeScript KAITHI = const UnicodeScript(85);
  static const UnicodeScript LISU = const UnicodeScript(86);
  static const UnicodeScript MEETEI_MAYEK = const UnicodeScript(87);
  static const UnicodeScript OLD_SOUTH_ARABIAN = const UnicodeScript(88);
  static const UnicodeScript OLD_TURKIC = const UnicodeScript(89);
  static const UnicodeScript SAMARITAN = const UnicodeScript(90);
  static const UnicodeScript TAI_THAM = const UnicodeScript(91);
  static const UnicodeScript TAI_VIET = const UnicodeScript(92);
  static const UnicodeScript BATAK = const UnicodeScript(93);
  static const UnicodeScript BRAHMI = const UnicodeScript(94);
  static const UnicodeScript MANDAIC = const UnicodeScript(95);
  static const UnicodeScript CHAKMA = const UnicodeScript(96);
  static const UnicodeScript MEROITIC_CURSIVE = const UnicodeScript(97);
  static const UnicodeScript MEROITIC_HIEROGLYPHS = const UnicodeScript(98);
  static const UnicodeScript MIAO = const UnicodeScript(99);
  static const UnicodeScript SHARADA = const UnicodeScript(100);
  static const UnicodeScript SORA_SOMPENG = const UnicodeScript(101);
  static const UnicodeScript TAKRI = const UnicodeScript(102);
  static const UnicodeScript BASSA_VAH = const UnicodeScript(103);
  static const UnicodeScript CAUCASIAN_ALBANIAN = const UnicodeScript(104);
  static const UnicodeScript DUPLOYAN = const UnicodeScript(105);
  static const UnicodeScript ELBASAN = const UnicodeScript(106);
  static const UnicodeScript GRANTHA = const UnicodeScript(107);
  static const UnicodeScript KHOJKI = const UnicodeScript(108);
  static const UnicodeScript KHUDAWADI = const UnicodeScript(109);
  static const UnicodeScript LINEAR_A = const UnicodeScript(110);
  static const UnicodeScript MAHAJANI = const UnicodeScript(111);
  static const UnicodeScript MANICHAEAN = const UnicodeScript(112);
  static const UnicodeScript MENDE_KIKAKUI = const UnicodeScript(113);
  static const UnicodeScript MODI = const UnicodeScript(114);
  static const UnicodeScript MRO = const UnicodeScript(115);
  static const UnicodeScript NABATAEAN = const UnicodeScript(116);
  static const UnicodeScript OLD_NORTH_ARABIAN = const UnicodeScript(117);
  static const UnicodeScript OLD_PERMIC = const UnicodeScript(118);
  static const UnicodeScript PAHAWH_HMONG = const UnicodeScript(119);
  static const UnicodeScript PALMYRENE = const UnicodeScript(120);
  static const UnicodeScript PAU_CIN_HAU = const UnicodeScript(121);
  static const UnicodeScript PSALTER_PAHLAVI = const UnicodeScript(122);
  static const UnicodeScript SIDDHAM = const UnicodeScript(123);
  static const UnicodeScript TIRHUTA = const UnicodeScript(124);
  static const UnicodeScript WARANG_CITI = const UnicodeScript(125);
  String toString() {
    switch(index) {
      case -1: return 'UnicodeScript.INVALID_CODE';
      case 0: return 'UnicodeScript.COMMON';
      case 1: return 'UnicodeScript.INHERITED';
      case 2: return 'UnicodeScript.ARABIC';
      case 3: return 'UnicodeScript.ARMENIAN';
      case 4: return 'UnicodeScript.BENGALI';
      case 5: return 'UnicodeScript.BOPOMOFO';
      case 6: return 'UnicodeScript.CHEROKEE';
      case 7: return 'UnicodeScript.COPTIC';
      case 8: return 'UnicodeScript.CYRILLIC';
      case 9: return 'UnicodeScript.DESERET';
      case 10: return 'UnicodeScript.DEVANAGARI';
      case 11: return 'UnicodeScript.ETHIOPIC';
      case 12: return 'UnicodeScript.GEORGIAN';
      case 13: return 'UnicodeScript.GOTHIC';
      case 14: return 'UnicodeScript.GREEK';
      case 15: return 'UnicodeScript.GUJARATI';
      case 16: return 'UnicodeScript.GURMUKHI';
      case 17: return 'UnicodeScript.HAN';
      case 18: return 'UnicodeScript.HANGUL';
      case 19: return 'UnicodeScript.HEBREW';
      case 20: return 'UnicodeScript.HIRAGANA';
      case 21: return 'UnicodeScript.KANNADA';
      case 22: return 'UnicodeScript.KATAKANA';
      case 23: return 'UnicodeScript.KHMER';
      case 24: return 'UnicodeScript.LAO';
      case 25: return 'UnicodeScript.LATIN';
      case 26: return 'UnicodeScript.MALAYALAM';
      case 27: return 'UnicodeScript.MONGOLIAN';
      case 28: return 'UnicodeScript.MYANMAR';
      case 29: return 'UnicodeScript.OGHAM';
      case 30: return 'UnicodeScript.OLD_ITALIC';
      case 31: return 'UnicodeScript.ORIYA';
      case 32: return 'UnicodeScript.RUNIC';
      case 33: return 'UnicodeScript.SINHALA';
      case 34: return 'UnicodeScript.SYRIAC';
      case 35: return 'UnicodeScript.TAMIL';
      case 36: return 'UnicodeScript.TELUGU';
      case 37: return 'UnicodeScript.THAANA';
      case 38: return 'UnicodeScript.THAI';
      case 39: return 'UnicodeScript.TIBETAN';
      case 40: return 'UnicodeScript.CANADIAN_ABORIGINAL';
      case 41: return 'UnicodeScript.YI';
      case 42: return 'UnicodeScript.TAGALOG';
      case 43: return 'UnicodeScript.HANUNOO';
      case 44: return 'UnicodeScript.BUHID';
      case 45: return 'UnicodeScript.TAGBANWA';
      case 46: return 'UnicodeScript.BRAILLE';
      case 47: return 'UnicodeScript.CYPRIOT';
      case 48: return 'UnicodeScript.LIMBU';
      case 49: return 'UnicodeScript.OSMANYA';
      case 50: return 'UnicodeScript.SHAVIAN';
      case 51: return 'UnicodeScript.LINEAR_B';
      case 52: return 'UnicodeScript.TAI_LE';
      case 53: return 'UnicodeScript.UGARITIC';
      case 54: return 'UnicodeScript.NEW_TAI_LUE';
      case 55: return 'UnicodeScript.BUGINESE';
      case 56: return 'UnicodeScript.GLAGOLITIC';
      case 57: return 'UnicodeScript.TIFINAGH';
      case 58: return 'UnicodeScript.SYLOTI_NAGRI';
      case 59: return 'UnicodeScript.OLD_PERSIAN';
      case 60: return 'UnicodeScript.KHAROSHTHI';
      case 61: return 'UnicodeScript.UNKNOWN';
      case 62: return 'UnicodeScript.BALINESE';
      case 63: return 'UnicodeScript.CUNEIFORM';
      case 64: return 'UnicodeScript.PHOENICIAN';
      case 65: return 'UnicodeScript.PHAGS_PA';
      case 66: return 'UnicodeScript.NKO';
      case 67: return 'UnicodeScript.KAYAH_LI';
      case 68: return 'UnicodeScript.LEPCHA';
      case 69: return 'UnicodeScript.REJANG';
      case 70: return 'UnicodeScript.SUNDANESE';
      case 71: return 'UnicodeScript.SAURASHTRA';
      case 72: return 'UnicodeScript.CHAM';
      case 73: return 'UnicodeScript.OL_CHIKI';
      case 74: return 'UnicodeScript.VAI';
      case 75: return 'UnicodeScript.CARIAN';
      case 76: return 'UnicodeScript.LYCIAN';
      case 77: return 'UnicodeScript.LYDIAN';
      case 78: return 'UnicodeScript.AVESTAN';
      case 79: return 'UnicodeScript.BAMUM';
      case 80: return 'UnicodeScript.EGYPTIAN_HIEROGLYPHS';
      case 81: return 'UnicodeScript.IMPERIAL_ARAMAIC';
      case 82: return 'UnicodeScript.INSCRIPTIONAL_PAHLAVI';
      case 83: return 'UnicodeScript.INSCRIPTIONAL_PARTHIAN';
      case 84: return 'UnicodeScript.JAVANESE';
      case 85: return 'UnicodeScript.KAITHI';
      case 86: return 'UnicodeScript.LISU';
      case 87: return 'UnicodeScript.MEETEI_MAYEK';
      case 88: return 'UnicodeScript.OLD_SOUTH_ARABIAN';
      case 89: return 'UnicodeScript.OLD_TURKIC';
      case 90: return 'UnicodeScript.SAMARITAN';
      case 91: return 'UnicodeScript.TAI_THAM';
      case 92: return 'UnicodeScript.TAI_VIET';
      case 93: return 'UnicodeScript.BATAK';
      case 94: return 'UnicodeScript.BRAHMI';
      case 95: return 'UnicodeScript.MANDAIC';
      case 96: return 'UnicodeScript.CHAKMA';
      case 97: return 'UnicodeScript.MEROITIC_CURSIVE';
      case 98: return 'UnicodeScript.MEROITIC_HIEROGLYPHS';
      case 99: return 'UnicodeScript.MIAO';
      case 100: return 'UnicodeScript.SHARADA';
      case 101: return 'UnicodeScript.SORA_SOMPENG';
      case 102: return 'UnicodeScript.TAKRI';
      case 103: return 'UnicodeScript.BASSA_VAH';
      case 104: return 'UnicodeScript.CAUCASIAN_ALBANIAN';
      case 105: return 'UnicodeScript.DUPLOYAN';
      case 106: return 'UnicodeScript.ELBASAN';
      case 107: return 'UnicodeScript.GRANTHA';
      case 108: return 'UnicodeScript.KHOJKI';
      case 109: return 'UnicodeScript.KHUDAWADI';
      case 110: return 'UnicodeScript.LINEAR_A';
      case 111: return 'UnicodeScript.MAHAJANI';
      case 112: return 'UnicodeScript.MANICHAEAN';
      case 113: return 'UnicodeScript.MENDE_KIKAKUI';
      case 114: return 'UnicodeScript.MODI';
      case 115: return 'UnicodeScript.MRO';
      case 116: return 'UnicodeScript.NABATAEAN';
      case 117: return 'UnicodeScript.OLD_NORTH_ARABIAN';
      case 118: return 'UnicodeScript.OLD_PERMIC';
      case 119: return 'UnicodeScript.PAHAWH_HMONG';
      case 120: return 'UnicodeScript.PALMYRENE';
      case 121: return 'UnicodeScript.PAU_CIN_HAU';
      case 122: return 'UnicodeScript.PSALTER_PAHLAVI';
      case 123: return 'UnicodeScript.SIDDHAM';
      case 124: return 'UnicodeScript.TIRHUTA';
      case 125: return 'UnicodeScript.WARANG_CITI';
      default: return 'new UnicodeScript($index)';
    }
  }
}

class UnicodeType extends GEnumBase {
  const UnicodeType(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'UnicodeType');

  static const UnicodeType CONTROL = const UnicodeType(0);
  static const UnicodeType FORMAT = const UnicodeType(1);
  static const UnicodeType UNASSIGNED = const UnicodeType(2);
  static const UnicodeType PRIVATE_USE = const UnicodeType(3);
  static const UnicodeType SURROGATE = const UnicodeType(4);
  static const UnicodeType LOWERCASE_LETTER = const UnicodeType(5);
  static const UnicodeType MODIFIER_LETTER = const UnicodeType(6);
  static const UnicodeType OTHER_LETTER = const UnicodeType(7);
  static const UnicodeType TITLECASE_LETTER = const UnicodeType(8);
  static const UnicodeType UPPERCASE_LETTER = const UnicodeType(9);
  static const UnicodeType SPACING_MARK = const UnicodeType(10);
  static const UnicodeType ENCLOSING_MARK = const UnicodeType(11);
  static const UnicodeType NON_SPACING_MARK = const UnicodeType(12);
  static const UnicodeType DECIMAL_NUMBER = const UnicodeType(13);
  static const UnicodeType LETTER_NUMBER = const UnicodeType(14);
  static const UnicodeType OTHER_NUMBER = const UnicodeType(15);
  static const UnicodeType CONNECT_PUNCTUATION = const UnicodeType(16);
  static const UnicodeType DASH_PUNCTUATION = const UnicodeType(17);
  static const UnicodeType CLOSE_PUNCTUATION = const UnicodeType(18);
  static const UnicodeType FINAL_PUNCTUATION = const UnicodeType(19);
  static const UnicodeType INITIAL_PUNCTUATION = const UnicodeType(20);
  static const UnicodeType OTHER_PUNCTUATION = const UnicodeType(21);
  static const UnicodeType OPEN_PUNCTUATION = const UnicodeType(22);
  static const UnicodeType CURRENCY_SYMBOL = const UnicodeType(23);
  static const UnicodeType MODIFIER_SYMBOL = const UnicodeType(24);
  static const UnicodeType MATH_SYMBOL = const UnicodeType(25);
  static const UnicodeType OTHER_SYMBOL = const UnicodeType(26);
  static const UnicodeType LINE_SEPARATOR = const UnicodeType(27);
  static const UnicodeType PARAGRAPH_SEPARATOR = const UnicodeType(28);
  static const UnicodeType SPACE_SEPARATOR = const UnicodeType(29);
  String toString() {
    switch(index) {
      case 0: return 'UnicodeType.CONTROL';
      case 1: return 'UnicodeType.FORMAT';
      case 2: return 'UnicodeType.UNASSIGNED';
      case 3: return 'UnicodeType.PRIVATE_USE';
      case 4: return 'UnicodeType.SURROGATE';
      case 5: return 'UnicodeType.LOWERCASE_LETTER';
      case 6: return 'UnicodeType.MODIFIER_LETTER';
      case 7: return 'UnicodeType.OTHER_LETTER';
      case 8: return 'UnicodeType.TITLECASE_LETTER';
      case 9: return 'UnicodeType.UPPERCASE_LETTER';
      case 10: return 'UnicodeType.SPACING_MARK';
      case 11: return 'UnicodeType.ENCLOSING_MARK';
      case 12: return 'UnicodeType.NON_SPACING_MARK';
      case 13: return 'UnicodeType.DECIMAL_NUMBER';
      case 14: return 'UnicodeType.LETTER_NUMBER';
      case 15: return 'UnicodeType.OTHER_NUMBER';
      case 16: return 'UnicodeType.CONNECT_PUNCTUATION';
      case 17: return 'UnicodeType.DASH_PUNCTUATION';
      case 18: return 'UnicodeType.CLOSE_PUNCTUATION';
      case 19: return 'UnicodeType.FINAL_PUNCTUATION';
      case 20: return 'UnicodeType.INITIAL_PUNCTUATION';
      case 21: return 'UnicodeType.OTHER_PUNCTUATION';
      case 22: return 'UnicodeType.OPEN_PUNCTUATION';
      case 23: return 'UnicodeType.CURRENCY_SYMBOL';
      case 24: return 'UnicodeType.MODIFIER_SYMBOL';
      case 25: return 'UnicodeType.MATH_SYMBOL';
      case 26: return 'UnicodeType.OTHER_SYMBOL';
      case 27: return 'UnicodeType.LINE_SEPARATOR';
      case 28: return 'UnicodeType.PARAGRAPH_SEPARATOR';
      case 29: return 'UnicodeType.SPACE_SEPARATOR';
      default: return 'new UnicodeType($index)';
    }
  }
}

typedef bool UnixFDSourceFunc(int fd, IOCondition condition);
class UserDirectory extends GEnumBase {
  const UserDirectory(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'UserDirectory');

  static const UserDirectory DIRECTORY_DESKTOP = const UserDirectory(0);
  static const UserDirectory DIRECTORY_DOCUMENTS = const UserDirectory(1);
  static const UserDirectory DIRECTORY_DOWNLOAD = const UserDirectory(2);
  static const UserDirectory DIRECTORY_MUSIC = const UserDirectory(3);
  static const UserDirectory DIRECTORY_PICTURES = const UserDirectory(4);
  static const UserDirectory DIRECTORY_PUBLIC_SHARE = const UserDirectory(5);
  static const UserDirectory DIRECTORY_TEMPLATES = const UserDirectory(6);
  static const UserDirectory DIRECTORY_VIDEOS = const UserDirectory(7);
  static const UserDirectory N_DIRECTORIES = const UserDirectory(8);
  String toString() {
    switch(index) {
      case 0: return 'UserDirectory.DIRECTORY_DESKTOP';
      case 1: return 'UserDirectory.DIRECTORY_DOCUMENTS';
      case 2: return 'UserDirectory.DIRECTORY_DOWNLOAD';
      case 3: return 'UserDirectory.DIRECTORY_MUSIC';
      case 4: return 'UserDirectory.DIRECTORY_PICTURES';
      case 5: return 'UserDirectory.DIRECTORY_PUBLIC_SHARE';
      case 6: return 'UserDirectory.DIRECTORY_TEMPLATES';
      case 7: return 'UserDirectory.DIRECTORY_VIDEOS';
      case 8: return 'UserDirectory.N_DIRECTORIES';
      default: return 'new UserDirectory($index)';
    }
  }
}

class Variant extends GObjectBase {
  Variant.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'Variant');

  factory Variant.array(VariantType childType, List<Variant> children) => _staticInfo.callStatic('new_array', [childType, children]);
  factory Variant.boolean(bool value) => _staticInfo.callStatic('new_boolean', [value]);
  factory Variant.byte(int value) => _staticInfo.callStatic('new_byte', [value]);
  factory Variant.bytestring(List<int> string) => _staticInfo.callStatic('new_bytestring', [string]);
  factory Variant.bytestringArray(List<String> strv) => _staticInfo.callStatic('new_bytestring_array', [strv]);
  factory Variant.dictEntry(Variant key, Variant value) => _staticInfo.callStatic('new_dict_entry', [key, value]);
  factory Variant.double(num value) => _staticInfo.callStatic('new_double', [value]);
  factory Variant.fixedArray(VariantType elementType, dynamic elements /* this will fail */, int nElements, int elementSize) => _staticInfo.callStatic('new_fixed_array', [elementType, elements, nElements, elementSize]);
  factory Variant.fromBytes(VariantType type, Bytes bytes, bool trusted) => _staticInfo.callStatic('new_from_bytes', [type, bytes, trusted]);
  factory Variant.fromData(VariantType type, List<int> data, bool trusted, DestroyNotify notify, dynamic userData /* this will fail */) => _staticInfo.callStatic('new_from_data', [type, data, trusted, notify, userData]);
  factory Variant.handle(int value) => _staticInfo.callStatic('new_handle', [value]);
  factory Variant.int16(int value) => _staticInfo.callStatic('new_int16', [value]);
  factory Variant.int32(int value) => _staticInfo.callStatic('new_int32', [value]);
  factory Variant.int64(int value) => _staticInfo.callStatic('new_int64', [value]);
  factory Variant.maybe(VariantType childType, Variant child) => _staticInfo.callStatic('new_maybe', [childType, child]);
  factory Variant.objectPath(String objectPath) => _staticInfo.callStatic('new_object_path', [objectPath]);
  factory Variant.objv(List<String> strv) => _staticInfo.callStatic('new_objv', [strv]);
  factory Variant.signature(String signature) => _staticInfo.callStatic('new_signature', [signature]);
  factory Variant.string(String string) => _staticInfo.callStatic('new_string', [string]);
  factory Variant.strv(List<String> strv) => _staticInfo.callStatic('new_strv', [strv]);
  factory Variant.tuple(List<Variant> children) => _staticInfo.callStatic('new_tuple', [children]);
  factory Variant.uint16(int value) => _staticInfo.callStatic('new_uint16', [value]);
  factory Variant.uint32(int value) => _staticInfo.callStatic('new_uint32', [value]);
  factory Variant.uint64(int value) => _staticInfo.callStatic('new_uint64', [value]);
  factory Variant.variant(Variant value) => _staticInfo.callStatic('new_variant', [value]);
  Variant byteswap() => _staticInfo.callMethodOnReceiver('byteswap', this, []);
  bool checkFormatString(String formatString, bool copyOnly) => _staticInfo.callMethodOnReceiver('check_format_string', this, [formatString, copyOnly]);
  VariantClass classify() => _staticInfo.callMethodOnReceiver('classify', this, []);
  int compare(Variant two) => _staticInfo.callMethodOnReceiver('compare', this, [two]);
  List dupBytestring() => _staticInfo.callMethodOnReceiver('dup_bytestring', this, []);
  List dupBytestringArray() => _staticInfo.callMethodOnReceiver('dup_bytestring_array', this, []);
  List dupObjv() => _staticInfo.callMethodOnReceiver('dup_objv', this, []);
  List dupString() => _staticInfo.callMethodOnReceiver('dup_string', this, []);
  List dupStrv() => _staticInfo.callMethodOnReceiver('dup_strv', this, []);
  bool equal(Variant two) => _staticInfo.callMethodOnReceiver('equal', this, [two]);
  bool get boolean_ => _staticInfo.callMethodOnReceiver('get_boolean', this, []);
  int get byte_ => _staticInfo.callMethodOnReceiver('get_byte', this, []);
  List<int> get bytestring_ => _staticInfo.callMethodOnReceiver('get_bytestring', this, []);
  List getBytestringArray() => _staticInfo.callMethodOnReceiver('get_bytestring_array', this, []);
  Variant getChildValue(int index_) => _staticInfo.callMethodOnReceiver('get_child_value', this, [index_]);
  void getData() => _staticInfo.callMethodOnReceiver('get_data', this, []);
  Bytes get dataAsBytes => _staticInfo.callMethodOnReceiver('get_data_as_bytes', this, []);
  num get double_ => _staticInfo.callMethodOnReceiver('get_double', this, []);
  int get handle_ => _staticInfo.callMethodOnReceiver('get_handle', this, []);
  int get int16_ => _staticInfo.callMethodOnReceiver('get_int16', this, []);
  int get int32_ => _staticInfo.callMethodOnReceiver('get_int32', this, []);
  int get int64_ => _staticInfo.callMethodOnReceiver('get_int64', this, []);
  Variant get maybe_ => _staticInfo.callMethodOnReceiver('get_maybe', this, []);
  Variant get normalForm => _staticInfo.callMethodOnReceiver('get_normal_form', this, []);
  List getObjv() => _staticInfo.callMethodOnReceiver('get_objv', this, []);
  int get size => _staticInfo.callMethodOnReceiver('get_size', this, []);
  List getString() => _staticInfo.callMethodOnReceiver('get_string', this, []);
  List getStrv() => _staticInfo.callMethodOnReceiver('get_strv', this, []);
  VariantType get type => _staticInfo.callMethodOnReceiver('get_type', this, []);
  String get typeString => _staticInfo.callMethodOnReceiver('get_type_string', this, []);
  int get uint16_ => _staticInfo.callMethodOnReceiver('get_uint16', this, []);
  int get uint32_ => _staticInfo.callMethodOnReceiver('get_uint32', this, []);
  int get uint64_ => _staticInfo.callMethodOnReceiver('get_uint64', this, []);
  Variant get variant_ => _staticInfo.callMethodOnReceiver('get_variant', this, []);
  int hash() => _staticInfo.callMethodOnReceiver('hash', this, []);
  bool isContainer() => _staticInfo.callMethodOnReceiver('is_container', this, []);
  bool isFloating() => _staticInfo.callMethodOnReceiver('is_floating', this, []);
  bool isNormalForm() => _staticInfo.callMethodOnReceiver('is_normal_form', this, []);
  bool isOfType(VariantType type) => _staticInfo.callMethodOnReceiver('is_of_type', this, [type]);
  Variant lookupValue(String key, VariantType expectedType) => _staticInfo.callMethodOnReceiver('lookup_value', this, [key, expectedType]);
  int nChildren() => _staticInfo.callMethodOnReceiver('n_children', this, []);
  String print(bool typeAnnotate) => _staticInfo.callMethodOnReceiver('print', this, [typeAnnotate]);
  Variant ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  Variant refSink() => _staticInfo.callMethodOnReceiver('ref_sink', this, []);
  void store(dynamic data /* this will fail */) => _staticInfo.callMethodOnReceiver('store', this, [data]);
  Variant takeRef() => _staticInfo.callMethodOnReceiver('take_ref', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
  static bool isObjectPath(String string) => _staticInfo.callStatic('is_object_path', [string]);
  static bool isSignature(String string) => _staticInfo.callStatic('is_signature', [string]);
  static Variant parse(VariantType type, String text, String limit, String endptr) => _staticInfo.callStatic('parse', [type, text, limit, endptr]);
  static String parseErrorPrintContext(GErrorBase error, String sourceStr) => _staticInfo.callStatic('parse_error_print_context', [error, sourceStr]);
  static int parseErrorQuark() => _staticInfo.callStatic('parse_error_quark', []);
  static int parserGetErrorQuark() => _staticInfo.callStatic('parser_get_error_quark', []);
}

class VariantBuilder extends GObjectBase {
  VariantBuilder.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'VariantBuilder');

  factory VariantBuilder(VariantType type) => _staticInfo.callStatic('new', [type]);
  void addValue(Variant value) => _staticInfo.callMethodOnReceiver('add_value', this, [value]);
  void close() => _staticInfo.callMethodOnReceiver('close', this, []);
  Variant end() => _staticInfo.callMethodOnReceiver('end', this, []);
  void open(VariantType type) => _staticInfo.callMethodOnReceiver('open', this, [type]);
  VariantBuilder ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
  List<int> get x => getFieldOfObject('x', 0);
}

class VariantClass extends GEnumBase {
  const VariantClass(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'VariantClass');

  static const VariantClass BOOLEAN = const VariantClass(98);
  static const VariantClass BYTE = const VariantClass(121);
  static const VariantClass INT16 = const VariantClass(110);
  static const VariantClass UINT16 = const VariantClass(113);
  static const VariantClass INT32 = const VariantClass(105);
  static const VariantClass UINT32 = const VariantClass(117);
  static const VariantClass INT64 = const VariantClass(120);
  static const VariantClass UINT64 = const VariantClass(116);
  static const VariantClass HANDLE = const VariantClass(104);
  static const VariantClass DOUBLE = const VariantClass(100);
  static const VariantClass STRING = const VariantClass(115);
  static const VariantClass OBJECT_PATH = const VariantClass(111);
  static const VariantClass SIGNATURE = const VariantClass(103);
  static const VariantClass VARIANT = const VariantClass(118);
  static const VariantClass MAYBE = const VariantClass(109);
  static const VariantClass ARRAY = const VariantClass(97);
  static const VariantClass TUPLE = const VariantClass(40);
  static const VariantClass DICT_ENTRY = const VariantClass(123);
  String toString() {
    switch(index) {
      case 98: return 'VariantClass.BOOLEAN';
      case 121: return 'VariantClass.BYTE';
      case 110: return 'VariantClass.INT16';
      case 113: return 'VariantClass.UINT16';
      case 105: return 'VariantClass.INT32';
      case 117: return 'VariantClass.UINT32';
      case 120: return 'VariantClass.INT64';
      case 116: return 'VariantClass.UINT64';
      case 104: return 'VariantClass.HANDLE';
      case 100: return 'VariantClass.DOUBLE';
      case 115: return 'VariantClass.STRING';
      case 111: return 'VariantClass.OBJECT_PATH';
      case 103: return 'VariantClass.SIGNATURE';
      case 118: return 'VariantClass.VARIANT';
      case 109: return 'VariantClass.MAYBE';
      case 97: return 'VariantClass.ARRAY';
      case 40: return 'VariantClass.TUPLE';
      case 123: return 'VariantClass.DICT_ENTRY';
      default: return 'new VariantClass($index)';
    }
  }
}

class VariantDict extends GObjectBase {
  VariantDict.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'VariantDict');

  factory VariantDict(Variant fromAsv) => _staticInfo.callStatic('new', [fromAsv]);
  void clear() => _staticInfo.callMethodOnReceiver('clear', this, []);
  bool contains(String key) => _staticInfo.callMethodOnReceiver('contains', this, [key]);
  Variant end() => _staticInfo.callMethodOnReceiver('end', this, []);
  void insertValue(String key, Variant value) => _staticInfo.callMethodOnReceiver('insert_value', this, [key, value]);
  Variant lookupValue(String key, VariantType expectedType) => _staticInfo.callMethodOnReceiver('lookup_value', this, [key, expectedType]);
  VariantDict ref() => _staticInfo.callMethodOnReceiver('ref', this, []);
  bool remove(String key) => _staticInfo.callMethodOnReceiver('remove', this, [key]);
  void unref() => _staticInfo.callMethodOnReceiver('unref', this, []);
  List<int> get x => getFieldOfObject('x', 0);
}

class VariantParseErrorCode extends GEnumBase {
  const VariantParseErrorCode(int value) : super(value);
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'VariantParseError');

  static const VariantParseErrorCode FAILED = const VariantParseErrorCode(0);
  static const VariantParseErrorCode BASIC_TYPE_EXPECTED = const VariantParseErrorCode(1);
  static const VariantParseErrorCode CANNOT_INFER_TYPE = const VariantParseErrorCode(2);
  static const VariantParseErrorCode DEFINITE_TYPE_EXPECTED = const VariantParseErrorCode(3);
  static const VariantParseErrorCode INPUT_NOT_AT_END = const VariantParseErrorCode(4);
  static const VariantParseErrorCode INVALID_CHARACTER = const VariantParseErrorCode(5);
  static const VariantParseErrorCode INVALID_FORMAT_STRING = const VariantParseErrorCode(6);
  static const VariantParseErrorCode INVALID_OBJECT_PATH = const VariantParseErrorCode(7);
  static const VariantParseErrorCode INVALID_SIGNATURE = const VariantParseErrorCode(8);
  static const VariantParseErrorCode INVALID_TYPE_STRING = const VariantParseErrorCode(9);
  static const VariantParseErrorCode NO_COMMON_TYPE = const VariantParseErrorCode(10);
  static const VariantParseErrorCode NUMBER_OUT_OF_RANGE = const VariantParseErrorCode(11);
  static const VariantParseErrorCode NUMBER_TOO_BIG = const VariantParseErrorCode(12);
  static const VariantParseErrorCode TYPE_ERROR = const VariantParseErrorCode(13);
  static const VariantParseErrorCode UNEXPECTED_TOKEN = const VariantParseErrorCode(14);
  static const VariantParseErrorCode UNKNOWN_KEYWORD = const VariantParseErrorCode(15);
  static const VariantParseErrorCode UNTERMINATED_STRING_CONSTANT = const VariantParseErrorCode(16);
  static const VariantParseErrorCode VALUE_EXPECTED = const VariantParseErrorCode(17);
  String toString() {
    switch(index) {
      case 0: return 'VariantParseErrorCode.FAILED';
      case 1: return 'VariantParseErrorCode.BASIC_TYPE_EXPECTED';
      case 2: return 'VariantParseErrorCode.CANNOT_INFER_TYPE';
      case 3: return 'VariantParseErrorCode.DEFINITE_TYPE_EXPECTED';
      case 4: return 'VariantParseErrorCode.INPUT_NOT_AT_END';
      case 5: return 'VariantParseErrorCode.INVALID_CHARACTER';
      case 6: return 'VariantParseErrorCode.INVALID_FORMAT_STRING';
      case 7: return 'VariantParseErrorCode.INVALID_OBJECT_PATH';
      case 8: return 'VariantParseErrorCode.INVALID_SIGNATURE';
      case 9: return 'VariantParseErrorCode.INVALID_TYPE_STRING';
      case 10: return 'VariantParseErrorCode.NO_COMMON_TYPE';
      case 11: return 'VariantParseErrorCode.NUMBER_OUT_OF_RANGE';
      case 12: return 'VariantParseErrorCode.NUMBER_TOO_BIG';
      case 13: return 'VariantParseErrorCode.TYPE_ERROR';
      case 14: return 'VariantParseErrorCode.UNEXPECTED_TOKEN';
      case 15: return 'VariantParseErrorCode.UNKNOWN_KEYWORD';
      case 16: return 'VariantParseErrorCode.UNTERMINATED_STRING_CONSTANT';
      case 17: return 'VariantParseErrorCode.VALUE_EXPECTED';
      default: return 'new VariantParseErrorCode($index)';
    }
  }
}

class VariantParseError extends GErrorBase {
  static final int _quark = lookupErrorQuarkFromString('g-variant-parse-error-quark');
  VariantParseError(VariantParseErrorCode code, String message)
      : super.fromFields(_quark, code, message);
}

class VariantType extends GObjectBase {
  VariantType.fromNative();
  static final GIObjectInfo _staticInfo = new GIObjectInfo('GLib', 'VariantType');

  factory VariantType(String typeString) => _staticInfo.callStatic('new', [typeString]);
  factory VariantType.array(VariantType element) => _staticInfo.callStatic('new_array', [element]);
  factory VariantType.dictEntry(VariantType key, VariantType value) => _staticInfo.callStatic('new_dict_entry', [key, value]);
  factory VariantType.maybe(VariantType element) => _staticInfo.callStatic('new_maybe', [element]);
  factory VariantType.tuple(List<VariantType> items) => _staticInfo.callStatic('new_tuple', [items]);
  VariantType copy() => _staticInfo.callMethodOnReceiver('copy', this, []);
  String dupString() => _staticInfo.callMethodOnReceiver('dup_string', this, []);
  VariantType element() => _staticInfo.callMethodOnReceiver('element', this, []);
  bool equal(VariantType type2) => _staticInfo.callMethodOnReceiver('equal', this, [type2]);
  VariantType first() => _staticInfo.callMethodOnReceiver('first', this, []);
  void free() => _staticInfo.callMethodOnReceiver('free', this, []);
  int get stringLength => _staticInfo.callMethodOnReceiver('get_string_length', this, []);
  int hash() => _staticInfo.callMethodOnReceiver('hash', this, []);
  bool isArray() => _staticInfo.callMethodOnReceiver('is_array', this, []);
  bool isBasic() => _staticInfo.callMethodOnReceiver('is_basic', this, []);
  bool isContainer() => _staticInfo.callMethodOnReceiver('is_container', this, []);
  bool isDefinite() => _staticInfo.callMethodOnReceiver('is_definite', this, []);
  bool isDictEntry() => _staticInfo.callMethodOnReceiver('is_dict_entry', this, []);
  bool isMaybe() => _staticInfo.callMethodOnReceiver('is_maybe', this, []);
  bool isSubtypeOf(VariantType supertype) => _staticInfo.callMethodOnReceiver('is_subtype_of', this, [supertype]);
  bool isTuple() => _staticInfo.callMethodOnReceiver('is_tuple', this, []);
  bool isVariant() => _staticInfo.callMethodOnReceiver('is_variant', this, []);
  VariantType key() => _staticInfo.callMethodOnReceiver('key', this, []);
  int nItems() => _staticInfo.callMethodOnReceiver('n_items', this, []);
  VariantType next() => _staticInfo.callMethodOnReceiver('next', this, []);
  VariantType value() => _staticInfo.callMethodOnReceiver('value', this, []);
  static VariantType checked_(String arg0) => _staticInfo.callStatic('checked_', [arg0]);
  static bool stringIsValid(String typeString) => _staticInfo.callStatic('string_is_valid', [typeString]);
  static List stringScan(String string, String limit) => _staticInfo.callStatic('string_scan', [string, limit]);
}

typedef void VoidFunc();
int access(String filename, int mode) => callStaticGlobal('GLib', 'access', [filename, mode]);

int asciiDigitValue(int c) => callStaticGlobal('GLib', 'ascii_digit_value', [c]);

String asciiDtostr(String buffer, int bufLen, num d) => callStaticGlobal('GLib', 'ascii_dtostr', [buffer, bufLen, d]);

String asciiFormatd(String buffer, int bufLen, String format, num d) => callStaticGlobal('GLib', 'ascii_formatd', [buffer, bufLen, format, d]);

int asciiStrcasecmp(String s1, String s2) => callStaticGlobal('GLib', 'ascii_strcasecmp', [s1, s2]);

String asciiStrdown(String str, int len) => callStaticGlobal('GLib', 'ascii_strdown', [str, len]);

int asciiStrncasecmp(String s1, String s2, int n) => callStaticGlobal('GLib', 'ascii_strncasecmp', [s1, s2, n]);

num asciiStrtod(String nptr, String endptr) => callStaticGlobal('GLib', 'ascii_strtod', [nptr, endptr]);

int asciiStrtoll(String nptr, String endptr, int base) => callStaticGlobal('GLib', 'ascii_strtoll', [nptr, endptr, base]);

int asciiStrtoull(String nptr, String endptr, int base) => callStaticGlobal('GLib', 'ascii_strtoull', [nptr, endptr, base]);

String asciiStrup(String str, int len) => callStaticGlobal('GLib', 'ascii_strup', [str, len]);

int asciiTolower(int c) => callStaticGlobal('GLib', 'ascii_tolower', [c]);

int asciiToupper(int c) => callStaticGlobal('GLib', 'ascii_toupper', [c]);

int asciiXdigitValue(int c) => callStaticGlobal('GLib', 'ascii_xdigit_value', [c]);

void assertWarning(String logDomain, String file, int line, String prettyFunction, String expression) => callStaticGlobal('GLib', 'assert_warning', [logDomain, file, line, prettyFunction, expression]);

void assertionMessage(String domain, String file, int line, String func, String message) => callStaticGlobal('GLib', 'assertion_message', [domain, file, line, func, message]);

void assertionMessageCmpstr(String domain, String file, int line, String func, String expr, String arg1, String cmp, String arg2) => callStaticGlobal('GLib', 'assertion_message_cmpstr', [domain, file, line, func, expr, arg1, cmp, arg2]);

void assertionMessageError(String domain, String file, int line, String func, String expr, GErrorBase error, int errorDomain, int errorCode) => callStaticGlobal('GLib', 'assertion_message_error', [domain, file, line, func, expr, error, errorDomain, errorCode]);

void assertionMessageExpr(String domain, String file, int line, String func, String expr) => callStaticGlobal('GLib', 'assertion_message_expr', [domain, file, line, func, expr]);

void atexit(VoidFunc func) => callStaticGlobal('GLib', 'atexit', [func]);

int atomicIntAdd(int atomic, int val) => callStaticGlobal('GLib', 'atomic_int_add', [atomic, val]);

int atomicIntAnd(int atomic, int val) => callStaticGlobal('GLib', 'atomic_int_and', [atomic, val]);

bool atomicIntCompareAndExchange(int atomic, int oldval, int newval) => callStaticGlobal('GLib', 'atomic_int_compare_and_exchange', [atomic, oldval, newval]);

bool atomicIntDecAndTest(int atomic) => callStaticGlobal('GLib', 'atomic_int_dec_and_test', [atomic]);

int atomicIntExchangeAndAdd(int atomic, int val) => callStaticGlobal('GLib', 'atomic_int_exchange_and_add', [atomic, val]);

int atomicIntGet(int atomic) => callStaticGlobal('GLib', 'atomic_int_get', [atomic]);

void atomicIntInc(int atomic) => callStaticGlobal('GLib', 'atomic_int_inc', [atomic]);

int atomicIntOr(int atomic, int val) => callStaticGlobal('GLib', 'atomic_int_or', [atomic, val]);

void atomicIntSet(int atomic, int newval) => callStaticGlobal('GLib', 'atomic_int_set', [atomic, newval]);

int atomicIntXor(int atomic, int val) => callStaticGlobal('GLib', 'atomic_int_xor', [atomic, val]);

int atomicPointerAdd(dynamic atomic /* this will fail */, int val) => callStaticGlobal('GLib', 'atomic_pointer_add', [atomic, val]);

int atomicPointerAnd(dynamic atomic /* this will fail */, int val) => callStaticGlobal('GLib', 'atomic_pointer_and', [atomic, val]);

bool atomicPointerCompareAndExchange(dynamic atomic /* this will fail */, dynamic oldval /* this will fail */, dynamic newval /* this will fail */) => callStaticGlobal('GLib', 'atomic_pointer_compare_and_exchange', [atomic, oldval, newval]);

int atomicPointerOr(dynamic atomic /* this will fail */, int val) => callStaticGlobal('GLib', 'atomic_pointer_or', [atomic, val]);

void atomicPointerSet(dynamic atomic /* this will fail */, dynamic newval /* this will fail */) => callStaticGlobal('GLib', 'atomic_pointer_set', [atomic, newval]);

int atomicPointerXor(dynamic atomic /* this will fail */, int val) => callStaticGlobal('GLib', 'atomic_pointer_xor', [atomic, val]);

List base64Decode(String text) => callStaticGlobal('GLib', 'base64_decode', [text]);

List base64DecodeInplace(List<int> text) => callStaticGlobal('GLib', 'base64_decode_inplace', [text]);

List base64DecodeStep(List<int> in_, int state, int save) => callStaticGlobal('GLib', 'base64_decode_step', [in_, state, save]);

String base64Encode(List<int> data) => callStaticGlobal('GLib', 'base64_encode', [data]);

List base64EncodeClose(bool breakLines, int state, int save) => callStaticGlobal('GLib', 'base64_encode_close', [breakLines, state, save]);

List base64EncodeStep(List<int> in_, bool breakLines, int state, int save) => callStaticGlobal('GLib', 'base64_encode_step', [in_, breakLines, state, save]);

String basename(String fileName) => callStaticGlobal('GLib', 'basename', [fileName]);

void bitLock(int address, int lockBit) => callStaticGlobal('GLib', 'bit_lock', [address, lockBit]);

int bitNthLsf(int mask, int nthBit) => callStaticGlobal('GLib', 'bit_nth_lsf', [mask, nthBit]);

int bitNthMsf(int mask, int nthBit) => callStaticGlobal('GLib', 'bit_nth_msf', [mask, nthBit]);

int bitStorage(int number) => callStaticGlobal('GLib', 'bit_storage', [number]);

bool bitTrylock(int address, int lockBit) => callStaticGlobal('GLib', 'bit_trylock', [address, lockBit]);

void bitUnlock(int address, int lockBit) => callStaticGlobal('GLib', 'bit_unlock', [address, lockBit]);

int bookmarkFileErrorQuark() => callStaticGlobal('GLib', 'bookmark_file_error_quark', []);

String buildFilenamev(List<String> args) => callStaticGlobal('GLib', 'build_filenamev', [args]);

String buildPathv(String separator, List<String> args) => callStaticGlobal('GLib', 'build_pathv', [separator, args]);

int byteArrayFree(List<int> array, bool freeSegment) => callStaticGlobal('GLib', 'byte_array_free', [array, freeSegment]);

Bytes byteArrayFreeToBytes(List<int> array) => callStaticGlobal('GLib', 'byte_array_free_to_bytes', [array]);

List<int> byteArrayNew() => callStaticGlobal('GLib', 'byte_array_new', []);

List<int> byteArrayNewTake(List<int> data) => callStaticGlobal('GLib', 'byte_array_new_take', [data]);

void byteArrayUnref(List<int> array) => callStaticGlobal('GLib', 'byte_array_unref', [array]);

int chdir(String path) => callStaticGlobal('GLib', 'chdir', [path]);

String checkVersion(int requiredMajor, int requiredMinor, int requiredMicro) => callStaticGlobal('GLib', 'check_version', [requiredMajor, requiredMinor, requiredMicro]);

int checksumTypeGetLength(ChecksumType checksumType) => callStaticGlobal('GLib', 'checksum_type_get_length', [checksumType]);

int childWatchAdd(int priority, int pid, ChildWatchFunc function) => callStaticGlobal('GLib', 'child_watch_add', [priority, pid, function]);

Source childWatchSourceNew(int pid) => callStaticGlobal('GLib', 'child_watch_source_new', [pid]);

void clearError() => callStaticGlobal('GLib', 'clear_error', []);

void close(int fd) => callStaticGlobal('GLib', 'close', [fd]);

String computeChecksumForBytes(ChecksumType checksumType, Bytes data) => callStaticGlobal('GLib', 'compute_checksum_for_bytes', [checksumType, data]);

String computeChecksumForData(ChecksumType checksumType, List<int> data) => callStaticGlobal('GLib', 'compute_checksum_for_data', [checksumType, data]);

String computeChecksumForString(ChecksumType checksumType, String str, int length) => callStaticGlobal('GLib', 'compute_checksum_for_string', [checksumType, str, length]);

String computeHmacForData(ChecksumType digestType, List<int> key, int data, int length) => callStaticGlobal('GLib', 'compute_hmac_for_data', [digestType, key, data, length]);

String computeHmacForString(ChecksumType digestType, List<int> key, String str, int length) => callStaticGlobal('GLib', 'compute_hmac_for_string', [digestType, key, str, length]);

List convert(String str, int len, String toCodeset, String fromCodeset) => callStaticGlobal('GLib', 'convert', [str, len, toCodeset, fromCodeset]);

int convertErrorQuark() => callStaticGlobal('GLib', 'convert_error_quark', []);

String convertWithFallback(String str, int len, String toCodeset, String fromCodeset, String fallback, int bytesRead, int bytesWritten) => callStaticGlobal('GLib', 'convert_with_fallback', [str, len, toCodeset, fromCodeset, fallback, bytesRead, bytesWritten]);

String convertWithIconv(String str, int len, IConv converter, int bytesRead, int bytesWritten) => callStaticGlobal('GLib', 'convert_with_iconv', [str, len, converter, bytesRead, bytesWritten]);

void datalistClear(Data datalist) => callStaticGlobal('GLib', 'datalist_clear', [datalist]);

int datalistGetFlags(Data datalist) => callStaticGlobal('GLib', 'datalist_get_flags', [datalist]);

bool datalistIdReplaceData(Data datalist, int keyId, dynamic oldval /* this will fail */, dynamic newval /* this will fail */, DestroyNotify destroy, DestroyNotify oldDestroy) => callStaticGlobal('GLib', 'datalist_id_replace_data', [datalist, keyId, oldval, newval, destroy, oldDestroy]);

void datalistIdSetDataFull(Data datalist, int keyId, dynamic data /* this will fail */, DestroyNotify destroyFunc) => callStaticGlobal('GLib', 'datalist_id_set_data_full', [datalist, keyId, data, destroyFunc]);

void datalistInit(Data datalist) => callStaticGlobal('GLib', 'datalist_init', [datalist]);

void datalistSetFlags(Data datalist, int flags) => callStaticGlobal('GLib', 'datalist_set_flags', [datalist, flags]);

void datalistUnsetFlags(Data datalist, int flags) => callStaticGlobal('GLib', 'datalist_unset_flags', [datalist, flags]);

void datasetDestroy(dynamic datasetLocation /* this will fail */) => callStaticGlobal('GLib', 'dataset_destroy', [datasetLocation]);

void datasetIdSetDataFull(dynamic datasetLocation /* this will fail */, int keyId, dynamic data /* this will fail */, DestroyNotify destroyFunc) => callStaticGlobal('GLib', 'dataset_id_set_data_full', [datasetLocation, keyId, data, destroyFunc]);

int dateGetDaysInMonth(DateMonth month, int year) => callStaticGlobal('GLib', 'date_get_days_in_month', [month, year]);

int dateGetMondayWeeksInYear(int year) => callStaticGlobal('GLib', 'date_get_monday_weeks_in_year', [year]);

int dateGetSundayWeeksInYear(int year) => callStaticGlobal('GLib', 'date_get_sunday_weeks_in_year', [year]);

bool dateIsLeapYear(int year) => callStaticGlobal('GLib', 'date_is_leap_year', [year]);

int dateStrftime(String s, int slen, String format, Date date) => callStaticGlobal('GLib', 'date_strftime', [s, slen, format, date]);

int dateTimeCompare(dynamic dt1 /* this will fail */, dynamic dt2 /* this will fail */) => callStaticGlobal('GLib', 'date_time_compare', [dt1, dt2]);

bool dateTimeEqual(dynamic dt1 /* this will fail */, dynamic dt2 /* this will fail */) => callStaticGlobal('GLib', 'date_time_equal', [dt1, dt2]);

int dateTimeHash(dynamic datetime /* this will fail */) => callStaticGlobal('GLib', 'date_time_hash', [datetime]);

bool dateValidDay(int day) => callStaticGlobal('GLib', 'date_valid_day', [day]);

bool dateValidDmy(int day, DateMonth month, int year) => callStaticGlobal('GLib', 'date_valid_dmy', [day, month, year]);

bool dateValidJulian(int julianDate) => callStaticGlobal('GLib', 'date_valid_julian', [julianDate]);

bool dateValidMonth(DateMonth month) => callStaticGlobal('GLib', 'date_valid_month', [month]);

bool dateValidWeekday(DateWeekday weekday) => callStaticGlobal('GLib', 'date_valid_weekday', [weekday]);

bool dateValidYear(int year) => callStaticGlobal('GLib', 'date_valid_year', [year]);

String dcgettext(String domain, String msgid, int category) => callStaticGlobal('GLib', 'dcgettext', [domain, msgid, category]);

String dgettext(String domain, String msgid) => callStaticGlobal('GLib', 'dgettext', [domain, msgid]);

String dirMakeTmp(String tmpl) => callStaticGlobal('GLib', 'dir_make_tmp', [tmpl]);

bool directEqual(dynamic v1 /* this will fail */, dynamic v2 /* this will fail */) => callStaticGlobal('GLib', 'direct_equal', [v1, v2]);

int directHash(dynamic v /* this will fail */) => callStaticGlobal('GLib', 'direct_hash', [v]);

String dngettext(String domain, String msgid, String msgidPlural, int n) => callStaticGlobal('GLib', 'dngettext', [domain, msgid, msgidPlural, n]);

bool doubleEqual(dynamic v1 /* this will fail */, dynamic v2 /* this will fail */) => callStaticGlobal('GLib', 'double_equal', [v1, v2]);

int doubleHash(dynamic v /* this will fail */) => callStaticGlobal('GLib', 'double_hash', [v]);

String dpgettext(String domain, String msgctxtid, int msgidoffset) => callStaticGlobal('GLib', 'dpgettext', [domain, msgctxtid, msgidoffset]);

String dpgettext2(String domain, String context, String msgid) => callStaticGlobal('GLib', 'dpgettext2', [domain, context, msgid]);

String environGetenv(List<String> envp, String variable) => callStaticGlobal('GLib', 'environ_getenv', [envp, variable]);

List<String> environSetenv(List<String> envp, String variable, String value, bool overwrite) => callStaticGlobal('GLib', 'environ_setenv', [envp, variable, value, overwrite]);

List<String> environUnsetenv(List<String> envp, String variable) => callStaticGlobal('GLib', 'environ_unsetenv', [envp, variable]);

FileError fileErrorFromErrno(int errNo) => callStaticGlobal('GLib', 'file_error_from_errno', [errNo]);

int fileErrorQuark() => callStaticGlobal('GLib', 'file_error_quark', []);

List fileGetContents(String filename) => callStaticGlobal('GLib', 'file_get_contents', [filename]);

List fileOpenTmp(String tmpl) => callStaticGlobal('GLib', 'file_open_tmp', [tmpl]);

String fileReadLink(String filename) => callStaticGlobal('GLib', 'file_read_link', [filename]);

void fileSetContents(String filename, List<int> contents) => callStaticGlobal('GLib', 'file_set_contents', [filename, contents]);

bool fileTest(String filename, FileTest test) => callStaticGlobal('GLib', 'file_test', [filename, test]);

String filenameDisplayBasename(String filename) => callStaticGlobal('GLib', 'filename_display_basename', [filename]);

String filenameDisplayName(String filename) => callStaticGlobal('GLib', 'filename_display_name', [filename]);

List filenameFromUri(String uri) => callStaticGlobal('GLib', 'filename_from_uri', [uri]);

List filenameFromUtf8(String utf8string, int len) => callStaticGlobal('GLib', 'filename_from_utf8', [utf8string, len]);

String filenameToUri(String filename, String hostname) => callStaticGlobal('GLib', 'filename_to_uri', [filename, hostname]);

String filenameToUtf8(String opsysstring, int len, int bytesRead, int bytesWritten) => callStaticGlobal('GLib', 'filename_to_utf8', [opsysstring, len, bytesRead, bytesWritten]);

String findProgramInPath(String program) => callStaticGlobal('GLib', 'find_program_in_path', [program]);

String formatSize(int size) => callStaticGlobal('GLib', 'format_size', [size]);

String formatSizeForDisplay(int size) => callStaticGlobal('GLib', 'format_size_for_display', [size]);

String formatSizeFull(int size, FormatSizeFlags flags) => callStaticGlobal('GLib', 'format_size_full', [size, flags]);

void free(dynamic mem /* this will fail */) => callStaticGlobal('GLib', 'free', [mem]);

String getApplicationName() => callStaticGlobal('GLib', 'get_application_name', []);

List getCharset() => callStaticGlobal('GLib', 'get_charset', []);

String getCodeset() => callStaticGlobal('GLib', 'get_codeset', []);

String getCurrentDir() => callStaticGlobal('GLib', 'get_current_dir', []);

void getCurrentTime(TimeVal result) => callStaticGlobal('GLib', 'get_current_time', [result]);

List<String> getEnviron() => callStaticGlobal('GLib', 'get_environ', []);

bool getFilenameCharsets(String charsets) => callStaticGlobal('GLib', 'get_filename_charsets', [charsets]);

String getHomeDir() => callStaticGlobal('GLib', 'get_home_dir', []);

String getHostName() => callStaticGlobal('GLib', 'get_host_name', []);

List<String> getLanguageNames() => callStaticGlobal('GLib', 'get_language_names', []);

List<String> getLocaleVariants(String locale) => callStaticGlobal('GLib', 'get_locale_variants', [locale]);

int getMonotonicTime() => callStaticGlobal('GLib', 'get_monotonic_time', []);

int getNumProcessors() => callStaticGlobal('GLib', 'get_num_processors', []);

String getPrgname() => callStaticGlobal('GLib', 'get_prgname', []);

String getRealName() => callStaticGlobal('GLib', 'get_real_name', []);

int getRealTime() => callStaticGlobal('GLib', 'get_real_time', []);

List<String> getSystemConfigDirs() => callStaticGlobal('GLib', 'get_system_config_dirs', []);

List<String> getSystemDataDirs() => callStaticGlobal('GLib', 'get_system_data_dirs', []);

String getTmpDir() => callStaticGlobal('GLib', 'get_tmp_dir', []);

String getUserCacheDir() => callStaticGlobal('GLib', 'get_user_cache_dir', []);

String getUserConfigDir() => callStaticGlobal('GLib', 'get_user_config_dir', []);

String getUserDataDir() => callStaticGlobal('GLib', 'get_user_data_dir', []);

String getUserName() => callStaticGlobal('GLib', 'get_user_name', []);

String getUserRuntimeDir() => callStaticGlobal('GLib', 'get_user_runtime_dir', []);

String getUserSpecialDir(UserDirectory directory) => callStaticGlobal('GLib', 'get_user_special_dir', [directory]);

String getenv(String variable) => callStaticGlobal('GLib', 'getenv', [variable]);

bool hashTableAdd(HashTable hashTable, dynamic key /* this will fail */) => callStaticGlobal('GLib', 'hash_table_add', [hashTable, key]);

bool hashTableContains(HashTable hashTable, dynamic key /* this will fail */) => callStaticGlobal('GLib', 'hash_table_contains', [hashTable, key]);

void hashTableDestroy(HashTable hashTable) => callStaticGlobal('GLib', 'hash_table_destroy', [hashTable]);

bool hashTableInsert(HashTable hashTable, dynamic key /* this will fail */, dynamic value /* this will fail */) => callStaticGlobal('GLib', 'hash_table_insert', [hashTable, key, value]);

bool hashTableLookupExtended(HashTable hashTable, dynamic lookupKey /* this will fail */, dynamic origKey /* this will fail */, dynamic value /* this will fail */) => callStaticGlobal('GLib', 'hash_table_lookup_extended', [hashTable, lookupKey, origKey, value]);

bool hashTableRemove(HashTable hashTable, dynamic key /* this will fail */) => callStaticGlobal('GLib', 'hash_table_remove', [hashTable, key]);

void hashTableRemoveAll(HashTable hashTable) => callStaticGlobal('GLib', 'hash_table_remove_all', [hashTable]);

bool hashTableReplace(HashTable hashTable, dynamic key /* this will fail */, dynamic value /* this will fail */) => callStaticGlobal('GLib', 'hash_table_replace', [hashTable, key, value]);

int hashTableSize(HashTable hashTable) => callStaticGlobal('GLib', 'hash_table_size', [hashTable]);

bool hashTableSteal(HashTable hashTable, dynamic key /* this will fail */) => callStaticGlobal('GLib', 'hash_table_steal', [hashTable, key]);

void hashTableStealAll(HashTable hashTable) => callStaticGlobal('GLib', 'hash_table_steal_all', [hashTable]);

void hashTableUnref(HashTable hashTable) => callStaticGlobal('GLib', 'hash_table_unref', [hashTable]);

bool hookDestroy(HookList hookList, int hookId) => callStaticGlobal('GLib', 'hook_destroy', [hookList, hookId]);

void hookDestroyLink(HookList hookList, Hook hook) => callStaticGlobal('GLib', 'hook_destroy_link', [hookList, hook]);

void hookFree(HookList hookList, Hook hook) => callStaticGlobal('GLib', 'hook_free', [hookList, hook]);

void hookInsertBefore(HookList hookList, Hook sibling, Hook hook) => callStaticGlobal('GLib', 'hook_insert_before', [hookList, sibling, hook]);

void hookPrepend(HookList hookList, Hook hook) => callStaticGlobal('GLib', 'hook_prepend', [hookList, hook]);

void hookUnref(HookList hookList, Hook hook) => callStaticGlobal('GLib', 'hook_unref', [hookList, hook]);

bool hostnameIsAsciiEncoded(String hostname) => callStaticGlobal('GLib', 'hostname_is_ascii_encoded', [hostname]);

bool hostnameIsIpAddress(String hostname) => callStaticGlobal('GLib', 'hostname_is_ip_address', [hostname]);

bool hostnameIsNonAscii(String hostname) => callStaticGlobal('GLib', 'hostname_is_non_ascii', [hostname]);

String hostnameToAscii(String hostname) => callStaticGlobal('GLib', 'hostname_to_ascii', [hostname]);

String hostnameToUnicode(String hostname) => callStaticGlobal('GLib', 'hostname_to_unicode', [hostname]);

int iconv(IConv converter, String inbuf, int inbytesLeft, String outbuf, int outbytesLeft) => callStaticGlobal('GLib', 'iconv', [converter, inbuf, inbytesLeft, outbuf, outbytesLeft]);

int idleAdd(int priority, SourceFunc function) => callStaticGlobal('GLib', 'idle_add', [priority, function]);

bool idleRemoveByData(dynamic data /* this will fail */) => callStaticGlobal('GLib', 'idle_remove_by_data', [data]);

Source idleSourceNew() => callStaticGlobal('GLib', 'idle_source_new', []);

bool int64Equal(dynamic v1 /* this will fail */, dynamic v2 /* this will fail */) => callStaticGlobal('GLib', 'int64_equal', [v1, v2]);

int int64Hash(dynamic v /* this will fail */) => callStaticGlobal('GLib', 'int64_hash', [v]);

bool intEqual(dynamic v1 /* this will fail */, dynamic v2 /* this will fail */) => callStaticGlobal('GLib', 'int_equal', [v1, v2]);

int intHash(dynamic v /* this will fail */) => callStaticGlobal('GLib', 'int_hash', [v]);

String internStaticString(String string) => callStaticGlobal('GLib', 'intern_static_string', [string]);

String internString(String string) => callStaticGlobal('GLib', 'intern_string', [string]);

int ioAddWatch(IOChannel channel, int priority, IOCondition condition, IOFunc func) => callStaticGlobal('GLib', 'io_add_watch', [channel, priority, condition, func]);

IOChannelError ioChannelErrorFromErrno(int en) => callStaticGlobal('GLib', 'io_channel_error_from_errno', [en]);

int ioChannelErrorQuark() => callStaticGlobal('GLib', 'io_channel_error_quark', []);

Source ioCreateWatch(IOChannel channel, IOCondition condition) => callStaticGlobal('GLib', 'io_create_watch', [channel, condition]);

int keyFileErrorQuark() => callStaticGlobal('GLib', 'key_file_error_quark', []);

List<String> listenv() => callStaticGlobal('GLib', 'listenv', []);

String localeFromUtf8(String utf8string, int len, int bytesRead, int bytesWritten) => callStaticGlobal('GLib', 'locale_from_utf8', [utf8string, len, bytesRead, bytesWritten]);

String localeToUtf8(String opsysstring, int len, int bytesRead, int bytesWritten) => callStaticGlobal('GLib', 'locale_to_utf8', [opsysstring, len, bytesRead, bytesWritten]);

void logDefaultHandler(String logDomain, LogLevelFlags logLevel, String message, dynamic unusedData /* this will fail */) => callStaticGlobal('GLib', 'log_default_handler', [logDomain, logLevel, message, unusedData]);

void logRemoveHandler(String logDomain, int handlerId) => callStaticGlobal('GLib', 'log_remove_handler', [logDomain, handlerId]);

LogLevelFlags logSetAlwaysFatal(LogLevelFlags fatalMask) => callStaticGlobal('GLib', 'log_set_always_fatal', [fatalMask]);

LogLevelFlags logSetFatalMask(String logDomain, LogLevelFlags fatalMask) => callStaticGlobal('GLib', 'log_set_fatal_mask', [logDomain, fatalMask]);

int logSetHandler(String logDomain, LogLevelFlags logLevels, LogFunc logFunc) => callStaticGlobal('GLib', 'log_set_handler', [logDomain, logLevels, logFunc]);

MainContext mainContextDefault() => callStaticGlobal('GLib', 'main_context_default', []);

MainContext mainContextGetThreadDefault() => callStaticGlobal('GLib', 'main_context_get_thread_default', []);

MainContext mainContextRefThreadDefault() => callStaticGlobal('GLib', 'main_context_ref_thread_default', []);

Source mainCurrentSource() => callStaticGlobal('GLib', 'main_current_source', []);

int mainDepth() => callStaticGlobal('GLib', 'main_depth', []);

int markupErrorQuark() => callStaticGlobal('GLib', 'markup_error_quark', []);

String markupEscapeText(String text, int length) => callStaticGlobal('GLib', 'markup_escape_text', [text, length]);

bool memIsSystemMalloc() => callStaticGlobal('GLib', 'mem_is_system_malloc', []);

void memProfile() => callStaticGlobal('GLib', 'mem_profile', []);

void memSetVtable(MemVTable vtable) => callStaticGlobal('GLib', 'mem_set_vtable', [vtable]);

int mkdirWithParents(String pathname, int mode) => callStaticGlobal('GLib', 'mkdir_with_parents', [pathname, mode]);

String mkdtemp(String tmpl) => callStaticGlobal('GLib', 'mkdtemp', [tmpl]);

String mkdtempFull(String tmpl, int mode) => callStaticGlobal('GLib', 'mkdtemp_full', [tmpl, mode]);

int mkstemp(String tmpl) => callStaticGlobal('GLib', 'mkstemp', [tmpl]);

int mkstempFull(String tmpl, int flags, int mode) => callStaticGlobal('GLib', 'mkstemp_full', [tmpl, flags, mode]);

void nullifyPointer(dynamic nullifyLocation /* this will fail */) => callStaticGlobal('GLib', 'nullify_pointer', [nullifyLocation]);

void onErrorQuery(String prgName) => callStaticGlobal('GLib', 'on_error_query', [prgName]);

void onErrorStackTrace(String prgName) => callStaticGlobal('GLib', 'on_error_stack_trace', [prgName]);

bool onceInitEnter(dynamic location /* this will fail */) => callStaticGlobal('GLib', 'once_init_enter', [location]);

void onceInitLeave(dynamic location /* this will fail */, int result) => callStaticGlobal('GLib', 'once_init_leave', [location, result]);

int optionErrorQuark() => callStaticGlobal('GLib', 'option_error_quark', []);

int parseDebugString(String string, List<DebugKey> keys) => callStaticGlobal('GLib', 'parse_debug_string', [string, keys]);

String pathGetBasename(String fileName) => callStaticGlobal('GLib', 'path_get_basename', [fileName]);

String pathGetDirname(String fileName) => callStaticGlobal('GLib', 'path_get_dirname', [fileName]);

bool pathIsAbsolute(String fileName) => callStaticGlobal('GLib', 'path_is_absolute', [fileName]);

String pathSkipRoot(String fileName) => callStaticGlobal('GLib', 'path_skip_root', [fileName]);

bool patternMatch(PatternSpec pspec, int stringLength, String string, String stringReversed) => callStaticGlobal('GLib', 'pattern_match', [pspec, stringLength, string, stringReversed]);

bool patternMatchSimple(String pattern, String string) => callStaticGlobal('GLib', 'pattern_match_simple', [pattern, string]);

bool patternMatchString(PatternSpec pspec, String string) => callStaticGlobal('GLib', 'pattern_match_string', [pspec, string]);

void pointerBitLock(dynamic address /* this will fail */, int lockBit) => callStaticGlobal('GLib', 'pointer_bit_lock', [address, lockBit]);

bool pointerBitTrylock(dynamic address /* this will fail */, int lockBit) => callStaticGlobal('GLib', 'pointer_bit_trylock', [address, lockBit]);

void pointerBitUnlock(dynamic address /* this will fail */, int lockBit) => callStaticGlobal('GLib', 'pointer_bit_unlock', [address, lockBit]);

int poll(PollFD fds, int nfds, int timeout) => callStaticGlobal('GLib', 'poll', [fds, nfds, timeout]);

void propagateError(GErrorBase dest, GErrorBase src) => callStaticGlobal('GLib', 'propagate_error', [dest, src]);

int quarkFromStaticString(String string) => callStaticGlobal('GLib', 'quark_from_static_string', [string]);

int quarkFromString(String string) => callStaticGlobal('GLib', 'quark_from_string', [string]);

String quarkToString(int quark) => callStaticGlobal('GLib', 'quark_to_string', [quark]);

int quarkTryString(String string) => callStaticGlobal('GLib', 'quark_try_string', [string]);

num randomDouble() => callStaticGlobal('GLib', 'random_double', []);

num randomDoubleRange(num begin, num end) => callStaticGlobal('GLib', 'random_double_range', [begin, end]);

int randomInt() => callStaticGlobal('GLib', 'random_int', []);

int randomIntRange(int begin, int end) => callStaticGlobal('GLib', 'random_int_range', [begin, end]);

void randomSetSeed(int seed) => callStaticGlobal('GLib', 'random_set_seed', [seed]);

bool regexCheckReplacement(String replacement) => callStaticGlobal('GLib', 'regex_check_replacement', [replacement]);

int regexErrorQuark() => callStaticGlobal('GLib', 'regex_error_quark', []);

String regexEscapeNul(String string, int length) => callStaticGlobal('GLib', 'regex_escape_nul', [string, length]);

String regexEscapeString(List<String> string) => callStaticGlobal('GLib', 'regex_escape_string', [string]);

bool regexMatchSimple(String pattern, String string, RegexCompileFlags compileOptions, RegexMatchFlags matchOptions) => callStaticGlobal('GLib', 'regex_match_simple', [pattern, string, compileOptions, matchOptions]);

List<String> regexSplitSimple(String pattern, String string, RegexCompileFlags compileOptions, RegexMatchFlags matchOptions) => callStaticGlobal('GLib', 'regex_split_simple', [pattern, string, compileOptions, matchOptions]);

void reloadUserSpecialDirsCache() => callStaticGlobal('GLib', 'reload_user_special_dirs_cache', []);

void returnIfFailWarning(String logDomain, String prettyFunction, String expression) => callStaticGlobal('GLib', 'return_if_fail_warning', [logDomain, prettyFunction, expression]);

int rmdir(String filename) => callStaticGlobal('GLib', 'rmdir', [filename]);

void sequenceMove(SequenceIter src, SequenceIter dest) => callStaticGlobal('GLib', 'sequence_move', [src, dest]);

void sequenceMoveRange(SequenceIter dest, SequenceIter begin, SequenceIter end) => callStaticGlobal('GLib', 'sequence_move_range', [dest, begin, end]);

void sequenceRemove(SequenceIter iter) => callStaticGlobal('GLib', 'sequence_remove', [iter]);

void sequenceRemoveRange(SequenceIter begin, SequenceIter end) => callStaticGlobal('GLib', 'sequence_remove_range', [begin, end]);

void sequenceSet(SequenceIter iter, dynamic data /* this will fail */) => callStaticGlobal('GLib', 'sequence_set', [iter, data]);

void sequenceSwap(SequenceIter a, SequenceIter b) => callStaticGlobal('GLib', 'sequence_swap', [a, b]);

void setApplicationName(String applicationName) => callStaticGlobal('GLib', 'set_application_name', [applicationName]);

void setErrorLiteral(GErrorBase err, int domain, int code, String message) => callStaticGlobal('GLib', 'set_error_literal', [err, domain, code, message]);

void setPrgname(String prgname) => callStaticGlobal('GLib', 'set_prgname', [prgname]);

bool setenv(String variable, String value, bool overwrite) => callStaticGlobal('GLib', 'setenv', [variable, value, overwrite]);

int shellErrorQuark() => callStaticGlobal('GLib', 'shell_error_quark', []);

List shellParseArgv(String commandLine) => callStaticGlobal('GLib', 'shell_parse_argv', [commandLine]);

String shellQuote(String unquotedString) => callStaticGlobal('GLib', 'shell_quote', [unquotedString]);

String shellUnquote(String quotedString) => callStaticGlobal('GLib', 'shell_unquote', [quotedString]);

void sliceFree1(int blockSize, dynamic memBlock /* this will fail */) => callStaticGlobal('GLib', 'slice_free1', [blockSize, memBlock]);

void sliceFreeChainWithOffset(int blockSize, dynamic memChain /* this will fail */, int nextOffset) => callStaticGlobal('GLib', 'slice_free_chain_with_offset', [blockSize, memChain, nextOffset]);

int sliceGetConfig(SliceConfig ckey) => callStaticGlobal('GLib', 'slice_get_config', [ckey]);

int sliceGetConfigState(SliceConfig ckey, int address, int nValues) => callStaticGlobal('GLib', 'slice_get_config_state', [ckey, address, nValues]);

void sliceSetConfig(SliceConfig ckey, int value) => callStaticGlobal('GLib', 'slice_set_config', [ckey, value]);

bool sourceRemove(int tag) => callStaticGlobal('GLib', 'source_remove', [tag]);

bool sourceRemoveByFuncsUserData(SourceFuncs funcs, dynamic userData /* this will fail */) => callStaticGlobal('GLib', 'source_remove_by_funcs_user_data', [funcs, userData]);

bool sourceRemoveByUserData(dynamic userData /* this will fail */) => callStaticGlobal('GLib', 'source_remove_by_user_data', [userData]);

void sourceSetNameById(int tag, String name) => callStaticGlobal('GLib', 'source_set_name_by_id', [tag, name]);

int spacedPrimesClosest(int num_) => callStaticGlobal('GLib', 'spaced_primes_closest', [num_]);

int spawnAsync(String workingDirectory, List<String> argv, List<String> envp, SpawnFlags flags, SpawnChildSetupFunc childSetup) => callStaticGlobal('GLib', 'spawn_async', [workingDirectory, argv, envp, flags, childSetup]);

List spawnAsyncWithPipes(String workingDirectory, List<String> argv, List<String> envp, SpawnFlags flags, SpawnChildSetupFunc childSetup) => callStaticGlobal('GLib', 'spawn_async_with_pipes', [workingDirectory, argv, envp, flags, childSetup]);

void spawnCheckExitStatus(int exitStatus) => callStaticGlobal('GLib', 'spawn_check_exit_status', [exitStatus]);

void spawnClosePid(int pid) => callStaticGlobal('GLib', 'spawn_close_pid', [pid]);

void spawnCommandLineAsync(String commandLine) => callStaticGlobal('GLib', 'spawn_command_line_async', [commandLine]);

List spawnCommandLineSync(String commandLine) => callStaticGlobal('GLib', 'spawn_command_line_sync', [commandLine]);

int spawnErrorQuark() => callStaticGlobal('GLib', 'spawn_error_quark', []);

int spawnExitErrorQuark() => callStaticGlobal('GLib', 'spawn_exit_error_quark', []);

List spawnSync(String workingDirectory, List<String> argv, List<String> envp, SpawnFlags flags, SpawnChildSetupFunc childSetup) => callStaticGlobal('GLib', 'spawn_sync', [workingDirectory, argv, envp, flags, childSetup]);

String stpcpy(String dest, String src) => callStaticGlobal('GLib', 'stpcpy', [dest, src]);

bool strEqual(dynamic v1 /* this will fail */, dynamic v2 /* this will fail */) => callStaticGlobal('GLib', 'str_equal', [v1, v2]);

bool strHasPrefix(String str, String prefix) => callStaticGlobal('GLib', 'str_has_prefix', [str, prefix]);

bool strHasSuffix(String str, String suffix) => callStaticGlobal('GLib', 'str_has_suffix', [str, suffix]);

int strHash(dynamic v /* this will fail */) => callStaticGlobal('GLib', 'str_hash', [v]);

bool strIsAscii(String str) => callStaticGlobal('GLib', 'str_is_ascii', [str]);

bool strMatchString(String searchTerm, String potentialHit, bool acceptAlternates) => callStaticGlobal('GLib', 'str_match_string', [searchTerm, potentialHit, acceptAlternates]);

String strToAscii(String str, String fromLocale) => callStaticGlobal('GLib', 'str_to_ascii', [str, fromLocale]);

List strTokenizeAndFold(String string, String translitLocale) => callStaticGlobal('GLib', 'str_tokenize_and_fold', [string, translitLocale]);

String strcanon(String string, String validChars, int substitutor) => callStaticGlobal('GLib', 'strcanon', [string, validChars, substitutor]);

int strcasecmp(String s1, String s2) => callStaticGlobal('GLib', 'strcasecmp', [s1, s2]);

String strchomp(String string) => callStaticGlobal('GLib', 'strchomp', [string]);

String strchug(String string) => callStaticGlobal('GLib', 'strchug', [string]);

int strcmp0(String str1, String str2) => callStaticGlobal('GLib', 'strcmp0', [str1, str2]);

String strcompress(String source) => callStaticGlobal('GLib', 'strcompress', [source]);

String strdelimit(String string, String delimiters, int newDelimiter) => callStaticGlobal('GLib', 'strdelimit', [string, delimiters, newDelimiter]);

String strdown(String string) => callStaticGlobal('GLib', 'strdown', [string]);

String strdup(String str) => callStaticGlobal('GLib', 'strdup', [str]);

String strerror(int errnum) => callStaticGlobal('GLib', 'strerror', [errnum]);

String strescape(String source, String exceptions) => callStaticGlobal('GLib', 'strescape', [source, exceptions]);

void strfreev(String strArray) => callStaticGlobal('GLib', 'strfreev', [strArray]);

GLibString stringNew(String init) => callStaticGlobal('GLib', 'string_new', [init]);

GLibString stringNewLen(String init, int len) => callStaticGlobal('GLib', 'string_new_len', [init, len]);

GLibString stringSizedNew(int dflSize) => callStaticGlobal('GLib', 'string_sized_new', [dflSize]);

String stripContext(String msgid, String msgval) => callStaticGlobal('GLib', 'strip_context', [msgid, msgval]);

String strjoinv(String separator, String strArray) => callStaticGlobal('GLib', 'strjoinv', [separator, strArray]);

int strlcat(String dest, String src, int destSize) => callStaticGlobal('GLib', 'strlcat', [dest, src, destSize]);

int strlcpy(String dest, String src, int destSize) => callStaticGlobal('GLib', 'strlcpy', [dest, src, destSize]);

int strncasecmp(String s1, String s2, int n) => callStaticGlobal('GLib', 'strncasecmp', [s1, s2, n]);

String strndup(String str, int n) => callStaticGlobal('GLib', 'strndup', [str, n]);

String strnfill(int length, int fillChar) => callStaticGlobal('GLib', 'strnfill', [length, fillChar]);

String strreverse(String string) => callStaticGlobal('GLib', 'strreverse', [string]);

String strrstr(String haystack, String needle) => callStaticGlobal('GLib', 'strrstr', [haystack, needle]);

String strrstrLen(String haystack, int haystackLen, String needle) => callStaticGlobal('GLib', 'strrstr_len', [haystack, haystackLen, needle]);

String strsignal(int signum) => callStaticGlobal('GLib', 'strsignal', [signum]);

String strstrLen(String haystack, int haystackLen, String needle) => callStaticGlobal('GLib', 'strstr_len', [haystack, haystackLen, needle]);

num strtod(String nptr, String endptr) => callStaticGlobal('GLib', 'strtod', [nptr, endptr]);

String strup(String string) => callStaticGlobal('GLib', 'strup', [string]);

bool strvContains(String strv, String str) => callStaticGlobal('GLib', 'strv_contains', [strv, str]);

int strvGetType() => callStaticGlobal('GLib', 'strv_get_type', []);

int strvLength(String strArray) => callStaticGlobal('GLib', 'strv_length', [strArray]);

void testAddDataFunc(String testpath, dynamic testData /* this will fail */, TestDataFunc testFunc) => callStaticGlobal('GLib', 'test_add_data_func', [testpath, testData, testFunc]);

void testAddDataFuncFull(String testpath, dynamic testData /* this will fail */, TestDataFunc testFunc, DestroyNotify dataFreeFunc) => callStaticGlobal('GLib', 'test_add_data_func_full', [testpath, testData, testFunc, dataFreeFunc]);

void testAddFunc(String testpath, TestFunc testFunc) => callStaticGlobal('GLib', 'test_add_func', [testpath, testFunc]);

void testAssertExpectedMessagesInternal(String domain, String file, int line, String func) => callStaticGlobal('GLib', 'test_assert_expected_messages_internal', [domain, file, line, func]);

void testBug(String bugUriSnippet) => callStaticGlobal('GLib', 'test_bug', [bugUriSnippet]);

void testBugBase(String uriPattern) => callStaticGlobal('GLib', 'test_bug_base', [uriPattern]);

void testExpectMessage(String logDomain, LogLevelFlags logLevel, String pattern) => callStaticGlobal('GLib', 'test_expect_message', [logDomain, logLevel, pattern]);

void testFail() => callStaticGlobal('GLib', 'test_fail', []);

bool testFailed() => callStaticGlobal('GLib', 'test_failed', []);

String testGetDir(TestFileType fileType) => callStaticGlobal('GLib', 'test_get_dir', [fileType]);

void testIncomplete(String msg) => callStaticGlobal('GLib', 'test_incomplete', [msg]);

String testLogTypeName(TestLogType logType) => callStaticGlobal('GLib', 'test_log_type_name', [logType]);

void testQueueDestroy(DestroyNotify destroyFunc, dynamic destroyData /* this will fail */) => callStaticGlobal('GLib', 'test_queue_destroy', [destroyFunc, destroyData]);

void testQueueFree(dynamic gfreePointer /* this will fail */) => callStaticGlobal('GLib', 'test_queue_free', [gfreePointer]);

num testRandDouble() => callStaticGlobal('GLib', 'test_rand_double', []);

num testRandDoubleRange(num rangeStart, num rangeEnd) => callStaticGlobal('GLib', 'test_rand_double_range', [rangeStart, rangeEnd]);

int testRandInt() => callStaticGlobal('GLib', 'test_rand_int', []);

int testRandIntRange(int begin, int end) => callStaticGlobal('GLib', 'test_rand_int_range', [begin, end]);

int testRun() => callStaticGlobal('GLib', 'test_run', []);

int testRunSuite(TestSuite suite) => callStaticGlobal('GLib', 'test_run_suite', [suite]);

void testSetNonfatalAssertions() => callStaticGlobal('GLib', 'test_set_nonfatal_assertions', []);

void testSkip(String msg) => callStaticGlobal('GLib', 'test_skip', [msg]);

bool testSubprocess() => callStaticGlobal('GLib', 'test_subprocess', []);

num testTimerElapsed() => callStaticGlobal('GLib', 'test_timer_elapsed', []);

num testTimerLast() => callStaticGlobal('GLib', 'test_timer_last', []);

void testTimerStart() => callStaticGlobal('GLib', 'test_timer_start', []);

void testTrapAssertions(String domain, String file, int line, String func, int assertionFlags, String pattern) => callStaticGlobal('GLib', 'test_trap_assertions', [domain, file, line, func, assertionFlags, pattern]);

bool testTrapFork(int usecTimeout, TestTrapFlags testTrapFlags) => callStaticGlobal('GLib', 'test_trap_fork', [usecTimeout, testTrapFlags]);

bool testTrapHasPassed() => callStaticGlobal('GLib', 'test_trap_has_passed', []);

bool testTrapReachedTimeout() => callStaticGlobal('GLib', 'test_trap_reached_timeout', []);

void testTrapSubprocess(String testPath, int usecTimeout, TestSubprocessFlags testFlags) => callStaticGlobal('GLib', 'test_trap_subprocess', [testPath, usecTimeout, testFlags]);

int threadErrorQuark() => callStaticGlobal('GLib', 'thread_error_quark', []);

void threadExit(dynamic retval /* this will fail */) => callStaticGlobal('GLib', 'thread_exit', [retval]);

int threadPoolGetMaxIdleTime() => callStaticGlobal('GLib', 'thread_pool_get_max_idle_time', []);

int threadPoolGetMaxUnusedThreads() => callStaticGlobal('GLib', 'thread_pool_get_max_unused_threads', []);

int threadPoolGetNumUnusedThreads() => callStaticGlobal('GLib', 'thread_pool_get_num_unused_threads', []);

void threadPoolSetMaxIdleTime(int interval) => callStaticGlobal('GLib', 'thread_pool_set_max_idle_time', [interval]);

void threadPoolSetMaxUnusedThreads(int maxThreads) => callStaticGlobal('GLib', 'thread_pool_set_max_unused_threads', [maxThreads]);

void threadPoolStopUnusedThreads() => callStaticGlobal('GLib', 'thread_pool_stop_unused_threads', []);

Thread threadSelf() => callStaticGlobal('GLib', 'thread_self', []);

void threadYield() => callStaticGlobal('GLib', 'thread_yield', []);

List timeValFromIso8601(String isoDate) => callStaticGlobal('GLib', 'time_val_from_iso8601', [isoDate]);

int timeoutAdd(int priority, int interval, SourceFunc function) => callStaticGlobal('GLib', 'timeout_add', [priority, interval, function]);

int timeoutAddSeconds(int priority, int interval, SourceFunc function) => callStaticGlobal('GLib', 'timeout_add_seconds', [priority, interval, function]);

Source timeoutSourceNew(int interval) => callStaticGlobal('GLib', 'timeout_source_new', [interval]);

Source timeoutSourceNewSeconds(int interval) => callStaticGlobal('GLib', 'timeout_source_new_seconds', [interval]);

int trashStackHeight(TrashStack stackP) => callStaticGlobal('GLib', 'trash_stack_height', [stackP]);

void trashStackPush(TrashStack stackP, dynamic dataP /* this will fail */) => callStaticGlobal('GLib', 'trash_stack_push', [stackP, dataP]);

int ucs4ToUtf16(int str, int len, int itemsRead, int itemsWritten) => callStaticGlobal('GLib', 'ucs4_to_utf16', [str, len, itemsRead, itemsWritten]);

String ucs4ToUtf8(int str, int len, int itemsRead, int itemsWritten) => callStaticGlobal('GLib', 'ucs4_to_utf8', [str, len, itemsRead, itemsWritten]);

UnicodeBreakType unicharBreakType(int c) => callStaticGlobal('GLib', 'unichar_break_type', [c]);

int unicharCombiningClass(int uc) => callStaticGlobal('GLib', 'unichar_combining_class', [uc]);

bool unicharCompose(int a, int b, int ch) => callStaticGlobal('GLib', 'unichar_compose', [a, b, ch]);

bool unicharDecompose(int ch, int a, int b) => callStaticGlobal('GLib', 'unichar_decompose', [ch, a, b]);

int unicharDigitValue(int c) => callStaticGlobal('GLib', 'unichar_digit_value', [c]);

int unicharFullyDecompose(int ch, bool compat, int result, int resultLen) => callStaticGlobal('GLib', 'unichar_fully_decompose', [ch, compat, result, resultLen]);

bool unicharGetMirrorChar(int ch, int mirroredCh) => callStaticGlobal('GLib', 'unichar_get_mirror_char', [ch, mirroredCh]);

UnicodeScript unicharGetScript(int ch) => callStaticGlobal('GLib', 'unichar_get_script', [ch]);

bool unicharIsalnum(int c) => callStaticGlobal('GLib', 'unichar_isalnum', [c]);

bool unicharIsalpha(int c) => callStaticGlobal('GLib', 'unichar_isalpha', [c]);

bool unicharIscntrl(int c) => callStaticGlobal('GLib', 'unichar_iscntrl', [c]);

bool unicharIsdefined(int c) => callStaticGlobal('GLib', 'unichar_isdefined', [c]);

bool unicharIsdigit(int c) => callStaticGlobal('GLib', 'unichar_isdigit', [c]);

bool unicharIsgraph(int c) => callStaticGlobal('GLib', 'unichar_isgraph', [c]);

bool unicharIslower(int c) => callStaticGlobal('GLib', 'unichar_islower', [c]);

bool unicharIsmark(int c) => callStaticGlobal('GLib', 'unichar_ismark', [c]);

bool unicharIsprint(int c) => callStaticGlobal('GLib', 'unichar_isprint', [c]);

bool unicharIspunct(int c) => callStaticGlobal('GLib', 'unichar_ispunct', [c]);

bool unicharIsspace(int c) => callStaticGlobal('GLib', 'unichar_isspace', [c]);

bool unicharIstitle(int c) => callStaticGlobal('GLib', 'unichar_istitle', [c]);

bool unicharIsupper(int c) => callStaticGlobal('GLib', 'unichar_isupper', [c]);

bool unicharIswide(int c) => callStaticGlobal('GLib', 'unichar_iswide', [c]);

bool unicharIswideCjk(int c) => callStaticGlobal('GLib', 'unichar_iswide_cjk', [c]);

bool unicharIsxdigit(int c) => callStaticGlobal('GLib', 'unichar_isxdigit', [c]);

bool unicharIszerowidth(int c) => callStaticGlobal('GLib', 'unichar_iszerowidth', [c]);

int unicharToUtf8(int c, String outbuf) => callStaticGlobal('GLib', 'unichar_to_utf8', [c, outbuf]);

int unicharTolower(int c) => callStaticGlobal('GLib', 'unichar_tolower', [c]);

int unicharTotitle(int c) => callStaticGlobal('GLib', 'unichar_totitle', [c]);

int unicharToupper(int c) => callStaticGlobal('GLib', 'unichar_toupper', [c]);

UnicodeType unicharType(int c) => callStaticGlobal('GLib', 'unichar_type', [c]);

bool unicharValidate(int ch) => callStaticGlobal('GLib', 'unichar_validate', [ch]);

int unicharXdigitValue(int c) => callStaticGlobal('GLib', 'unichar_xdigit_value', [c]);

int unicodeCanonicalDecomposition(int ch, int resultLen) => callStaticGlobal('GLib', 'unicode_canonical_decomposition', [ch, resultLen]);

void unicodeCanonicalOrdering(int string, int len) => callStaticGlobal('GLib', 'unicode_canonical_ordering', [string, len]);

UnicodeScript unicodeScriptFromIso15924(int iso15924) => callStaticGlobal('GLib', 'unicode_script_from_iso15924', [iso15924]);

int unicodeScriptToIso15924(UnicodeScript script) => callStaticGlobal('GLib', 'unicode_script_to_iso15924', [script]);

int unixErrorQuark() => callStaticGlobal('GLib', 'unix_error_quark', []);

int unixFdAddFull(int priority, int fd, IOCondition condition, UnixFDSourceFunc function) => callStaticGlobal('GLib', 'unix_fd_add_full', [priority, fd, condition, function]);

Source unixFdSourceNew(int fd, IOCondition condition) => callStaticGlobal('GLib', 'unix_fd_source_new', [fd, condition]);

void unixOpenPipe(int fds, int flags) => callStaticGlobal('GLib', 'unix_open_pipe', [fds, flags]);

void unixSetFdNonblocking(int fd, bool nonblock) => callStaticGlobal('GLib', 'unix_set_fd_nonblocking', [fd, nonblock]);

int unixSignalAdd(int priority, int signum, SourceFunc handler) => callStaticGlobal('GLib', 'unix_signal_add', [priority, signum, handler]);

Source unixSignalSourceNew(int signum) => callStaticGlobal('GLib', 'unix_signal_source_new', [signum]);

int unlink(String filename) => callStaticGlobal('GLib', 'unlink', [filename]);

void unsetenv(String variable) => callStaticGlobal('GLib', 'unsetenv', [variable]);

String uriEscapeString(String unescaped, String reservedCharsAllowed, bool allowUtf8) => callStaticGlobal('GLib', 'uri_escape_string', [unescaped, reservedCharsAllowed, allowUtf8]);

List<String> uriListExtractUris(String uriList) => callStaticGlobal('GLib', 'uri_list_extract_uris', [uriList]);

String uriParseScheme(String uri) => callStaticGlobal('GLib', 'uri_parse_scheme', [uri]);

String uriUnescapeSegment(String escapedString, String escapedStringEnd, String illegalCharacters) => callStaticGlobal('GLib', 'uri_unescape_segment', [escapedString, escapedStringEnd, illegalCharacters]);

String uriUnescapeString(String escapedString, String illegalCharacters) => callStaticGlobal('GLib', 'uri_unescape_string', [escapedString, illegalCharacters]);

void usleep(int microseconds) => callStaticGlobal('GLib', 'usleep', [microseconds]);

int utf16ToUcs4(int str, int len, int itemsRead, int itemsWritten) => callStaticGlobal('GLib', 'utf16_to_ucs4', [str, len, itemsRead, itemsWritten]);

String utf16ToUtf8(int str, int len, int itemsRead, int itemsWritten) => callStaticGlobal('GLib', 'utf16_to_utf8', [str, len, itemsRead, itemsWritten]);

String utf8Casefold(String str, int len) => callStaticGlobal('GLib', 'utf8_casefold', [str, len]);

int utf8Collate(String str1, String str2) => callStaticGlobal('GLib', 'utf8_collate', [str1, str2]);

String utf8CollateKey(String str, int len) => callStaticGlobal('GLib', 'utf8_collate_key', [str, len]);

String utf8CollateKeyForFilename(String str, int len) => callStaticGlobal('GLib', 'utf8_collate_key_for_filename', [str, len]);

String utf8FindNextChar(String p, String end) => callStaticGlobal('GLib', 'utf8_find_next_char', [p, end]);

String utf8FindPrevChar(String str, String p) => callStaticGlobal('GLib', 'utf8_find_prev_char', [str, p]);

int utf8GetChar(String p) => callStaticGlobal('GLib', 'utf8_get_char', [p]);

int utf8GetCharValidated(String p, int maxLen) => callStaticGlobal('GLib', 'utf8_get_char_validated', [p, maxLen]);

String utf8Normalize(String str, int len, NormalizeMode mode) => callStaticGlobal('GLib', 'utf8_normalize', [str, len, mode]);

String utf8OffsetToPointer(String str, int offset) => callStaticGlobal('GLib', 'utf8_offset_to_pointer', [str, offset]);

int utf8PointerToOffset(String str, String pos) => callStaticGlobal('GLib', 'utf8_pointer_to_offset', [str, pos]);

String utf8PrevChar(String p) => callStaticGlobal('GLib', 'utf8_prev_char', [p]);

String utf8Strchr(String p, int len, int c) => callStaticGlobal('GLib', 'utf8_strchr', [p, len, c]);

String utf8Strdown(String str, int len) => callStaticGlobal('GLib', 'utf8_strdown', [str, len]);

int utf8Strlen(String p, int max) => callStaticGlobal('GLib', 'utf8_strlen', [p, max]);

String utf8Strncpy(String dest, String src, int n) => callStaticGlobal('GLib', 'utf8_strncpy', [dest, src, n]);

String utf8Strrchr(String p, int len, int c) => callStaticGlobal('GLib', 'utf8_strrchr', [p, len, c]);

String utf8Strreverse(String str, int len) => callStaticGlobal('GLib', 'utf8_strreverse', [str, len]);

String utf8Strup(String str, int len) => callStaticGlobal('GLib', 'utf8_strup', [str, len]);

String utf8Substring(String str, int startPos, int endPos) => callStaticGlobal('GLib', 'utf8_substring', [str, startPos, endPos]);

int utf8ToUcs4(String str, int len, int itemsRead, int itemsWritten) => callStaticGlobal('GLib', 'utf8_to_ucs4', [str, len, itemsRead, itemsWritten]);

int utf8ToUcs4Fast(String str, int len, int itemsWritten) => callStaticGlobal('GLib', 'utf8_to_ucs4_fast', [str, len, itemsWritten]);

int utf8ToUtf16(String str, int len, int itemsRead, int itemsWritten) => callStaticGlobal('GLib', 'utf8_to_utf16', [str, len, itemsRead, itemsWritten]);

List utf8Validate(List<int> str) => callStaticGlobal('GLib', 'utf8_validate', [str]);

int variantGetGtype() => callStaticGlobal('GLib', 'variant_get_gtype', []);

bool variantIsObjectPath(String string) => callStaticGlobal('GLib', 'variant_is_object_path', [string]);

bool variantIsSignature(String string) => callStaticGlobal('GLib', 'variant_is_signature', [string]);

Variant variantParse(VariantType type, String text, String limit, String endptr) => callStaticGlobal('GLib', 'variant_parse', [type, text, limit, endptr]);

String variantParseErrorPrintContext(GErrorBase error, String sourceStr) => callStaticGlobal('GLib', 'variant_parse_error_print_context', [error, sourceStr]);

int variantParseErrorQuark() => callStaticGlobal('GLib', 'variant_parse_error_quark', []);

int variantParserGetErrorQuark() => callStaticGlobal('GLib', 'variant_parser_get_error_quark', []);

VariantType variantTypeChecked_(String arg0) => callStaticGlobal('GLib', 'variant_type_checked_', [arg0]);

bool variantTypeStringIsValid(String typeString) => callStaticGlobal('GLib', 'variant_type_string_is_valid', [typeString]);

List variantTypeStringScan(String string, String limit) => callStaticGlobal('GLib', 'variant_type_string_scan', [string, limit]);

void warnMessage(String domain, String file, int line, String func, String warnexpr) => callStaticGlobal('GLib', 'warn_message', [domain, file, line, func, warnexpr]);

bool _initLibraryStarted = false;

void initLibrary() {
  if (_initLibraryStarted) return;
  _initLibraryStarted = true;
  girepository.initLibrary();
  registerInterceptorTypeForNamedType("GLib", "Array",Array);
  registerInterceptorTypeForNamedType("GLib", "AsciiType",AsciiType);
  registerInterceptorTypeForNamedType("GLib", "AsyncQueue",AsyncQueue);
  registerInterceptorTypeForNamedType("GLib", "BookmarkFile",BookmarkFile);
  registerInterceptorTypeForNamedType("GLib", "BookmarkFileError",BookmarkFileErrorCode);
  registerInterceptorTypeForNamedType("GLib", "ByteArray",ByteArray);
  registerInterceptorTypeForNamedType("GLib", "Bytes",Bytes);
  registerInterceptorTypeForNamedType("GLib", "Checksum",Checksum);
  registerInterceptorTypeForNamedType("GLib", "ChecksumType",ChecksumType);
  registerInterceptorTypeForNamedType("GLib", "Cond",Cond);
  registerInterceptorTypeForNamedType("GLib", "ConvertError",ConvertErrorCode);
  registerInterceptorTypeForNamedType("GLib", "Data",Data);
  registerInterceptorTypeForNamedType("GLib", "Date",Date);
  registerInterceptorTypeForNamedType("GLib", "DateDMY",DateDMY);
  registerInterceptorTypeForNamedType("GLib", "DateMonth",DateMonth);
  registerInterceptorTypeForNamedType("GLib", "DateTime",GLibDateTime);
  registerInterceptorTypeForNamedType("GLib", "DateWeekday",DateWeekday);
  registerInterceptorTypeForNamedType("GLib", "DebugKey",DebugKey);
  registerInterceptorTypeForNamedType("GLib", "Dir",Dir);
  registerInterceptorTypeForNamedType("GLib", "DoubleIEEE754",DoubleIEEE754);
  registerInterceptorTypeForNamedType("GLib", "Error",Error);
  registerInterceptorTypeForNamedType("GLib", "ErrorType",ErrorType);
  registerInterceptorTypeForNamedType("GLib", "FileError",FileErrorCode);
  registerInterceptorTypeForNamedType("GLib", "FileTest",FileTest);
  registerInterceptorTypeForNamedType("GLib", "FloatIEEE754",FloatIEEE754);
  registerInterceptorTypeForNamedType("GLib", "FormatSizeFlags",FormatSizeFlags);
  registerInterceptorTypeForNamedType("GLib", "HashTable",HashTable);
  registerInterceptorTypeForNamedType("GLib", "HashTableIter",HashTableIter);
  registerInterceptorTypeForNamedType("GLib", "Hmac",Hmac);
  registerInterceptorTypeForNamedType("GLib", "Hook",Hook);
  registerInterceptorTypeForNamedType("GLib", "HookFlagMask",HookFlagMask);
  registerInterceptorTypeForNamedType("GLib", "HookList",HookList);
  registerInterceptorTypeForNamedType("GLib", "IConv",IConv);
  registerInterceptorTypeForNamedType("GLib", "IOChannel",IOChannel);
  registerInterceptorTypeForNamedType("GLib", "IOChannelError",IOChannelErrorCode);
  registerInterceptorTypeForNamedType("GLib", "IOCondition",IOCondition);
  registerInterceptorTypeForNamedType("GLib", "IOError",IOError);
  registerInterceptorTypeForNamedType("GLib", "IOFlags",IOFlags);
  registerInterceptorTypeForNamedType("GLib", "IOFuncs",IOFuncs);
  registerInterceptorTypeForNamedType("GLib", "IOStatus",IOStatus);
  registerInterceptorTypeForNamedType("GLib", "KeyFile",KeyFile);
  registerInterceptorTypeForNamedType("GLib", "KeyFileError",KeyFileErrorCode);
  registerInterceptorTypeForNamedType("GLib", "KeyFileFlags",KeyFileFlags);
  registerInterceptorTypeForNamedType("GLib", "List",GLibList);
  registerInterceptorTypeForNamedType("GLib", "LogLevelFlags",LogLevelFlags);
  registerInterceptorTypeForNamedType("GLib", "MainContext",MainContext);
  registerInterceptorTypeForNamedType("GLib", "MainLoop",MainLoop);
  registerInterceptorTypeForNamedType("GLib", "MappedFile",MappedFile);
  registerInterceptorTypeForNamedType("GLib", "MarkupCollectType",MarkupCollectType);
  registerInterceptorTypeForNamedType("GLib", "MarkupError",MarkupErrorCode);
  registerInterceptorTypeForNamedType("GLib", "MarkupParseContext",MarkupParseContext);
  registerInterceptorTypeForNamedType("GLib", "MarkupParseFlags",MarkupParseFlags);
  registerInterceptorTypeForNamedType("GLib", "MarkupParser",MarkupParser);
  registerInterceptorTypeForNamedType("GLib", "MatchInfo",MatchInfo);
  registerInterceptorTypeForNamedType("GLib", "MemVTable",MemVTable);
  registerInterceptorTypeForNamedType("GLib", "Mutex",Mutex);
  registerInterceptorTypeForNamedType("GLib", "Node",Node);
  registerInterceptorTypeForNamedType("GLib", "NormalizeMode",NormalizeMode);
  registerInterceptorTypeForNamedType("GLib", "Once",Once);
  registerInterceptorTypeForNamedType("GLib", "OnceStatus",OnceStatus);
  registerInterceptorTypeForNamedType("GLib", "OptionArg",OptionArg);
  registerInterceptorTypeForNamedType("GLib", "OptionContext",OptionContext);
  registerInterceptorTypeForNamedType("GLib", "OptionEntry",OptionEntry);
  registerInterceptorTypeForNamedType("GLib", "OptionError",OptionErrorCode);
  registerInterceptorTypeForNamedType("GLib", "OptionFlags",OptionFlags);
  registerInterceptorTypeForNamedType("GLib", "OptionGroup",OptionGroup);
  registerInterceptorTypeForNamedType("GLib", "PatternSpec",PatternSpec);
  registerInterceptorTypeForNamedType("GLib", "PollFD",PollFD);
  registerInterceptorTypeForNamedType("GLib", "Private",Private);
  registerInterceptorTypeForNamedType("GLib", "PtrArray",PtrArray);
  registerInterceptorTypeForNamedType("GLib", "Queue",Queue);
  registerInterceptorTypeForNamedType("GLib", "RWLock",RWLock);
  registerInterceptorTypeForNamedType("GLib", "Rand",Rand);
  registerInterceptorTypeForNamedType("GLib", "RecMutex",RecMutex);
  registerInterceptorTypeForNamedType("GLib", "Regex",Regex);
  registerInterceptorTypeForNamedType("GLib", "RegexCompileFlags",RegexCompileFlags);
  registerInterceptorTypeForNamedType("GLib", "RegexError",RegexErrorCode);
  registerInterceptorTypeForNamedType("GLib", "RegexMatchFlags",RegexMatchFlags);
  registerInterceptorTypeForNamedType("GLib", "SList",SList);
  registerInterceptorTypeForNamedType("GLib", "Scanner",Scanner);
  registerInterceptorTypeForNamedType("GLib", "ScannerConfig",ScannerConfig);
  registerInterceptorTypeForNamedType("GLib", "SeekType",SeekType);
  registerInterceptorTypeForNamedType("GLib", "Sequence",Sequence);
  registerInterceptorTypeForNamedType("GLib", "SequenceIter",SequenceIter);
  registerInterceptorTypeForNamedType("GLib", "ShellError",ShellErrorCode);
  registerInterceptorTypeForNamedType("GLib", "SliceConfig",SliceConfig);
  registerInterceptorTypeForNamedType("GLib", "Source",Source);
  registerInterceptorTypeForNamedType("GLib", "SourceCallbackFuncs",SourceCallbackFuncs);
  registerInterceptorTypeForNamedType("GLib", "SourceFuncs",SourceFuncs);
  registerInterceptorTypeForNamedType("GLib", "SourcePrivate",SourcePrivate);
  registerInterceptorTypeForNamedType("GLib", "SpawnError",SpawnErrorCode);
  registerInterceptorTypeForNamedType("GLib", "SpawnFlags",SpawnFlags);
  registerInterceptorTypeForNamedType("GLib", "StatBuf",StatBuf);
  registerInterceptorTypeForNamedType("GLib", "String",GLibString);
  registerInterceptorTypeForNamedType("GLib", "StringChunk",StringChunk);
  registerInterceptorTypeForNamedType("GLib", "TestCase",TestCase);
  registerInterceptorTypeForNamedType("GLib", "TestConfig",TestConfig);
  registerInterceptorTypeForNamedType("GLib", "TestFileType",TestFileType);
  registerInterceptorTypeForNamedType("GLib", "TestLogBuffer",TestLogBuffer);
  registerInterceptorTypeForNamedType("GLib", "TestLogMsg",TestLogMsg);
  registerInterceptorTypeForNamedType("GLib", "TestLogType",TestLogType);
  registerInterceptorTypeForNamedType("GLib", "TestSubprocessFlags",TestSubprocessFlags);
  registerInterceptorTypeForNamedType("GLib", "TestSuite",TestSuite);
  registerInterceptorTypeForNamedType("GLib", "TestTrapFlags",TestTrapFlags);
  registerInterceptorTypeForNamedType("GLib", "Thread",Thread);
  registerInterceptorTypeForNamedType("GLib", "ThreadError",ThreadErrorCode);
  registerInterceptorTypeForNamedType("GLib", "ThreadPool",ThreadPool);
  registerInterceptorTypeForNamedType("GLib", "TimeType",TimeType);
  registerInterceptorTypeForNamedType("GLib", "TimeVal",TimeVal);
  registerInterceptorTypeForNamedType("GLib", "TimeZone",TimeZone);
  registerInterceptorTypeForNamedType("GLib", "Timer",GlibTimer);
  registerInterceptorTypeForNamedType("GLib", "TokenType",TokenType);
  registerInterceptorTypeForNamedType("GLib", "TokenValue",TokenValue);
  registerInterceptorTypeForNamedType("GLib", "TrashStack",TrashStack);
  registerInterceptorTypeForNamedType("GLib", "TraverseFlags",TraverseFlags);
  registerInterceptorTypeForNamedType("GLib", "TraverseType",TraverseType);
  registerInterceptorTypeForNamedType("GLib", "Tree",Tree);
  registerInterceptorTypeForNamedType("GLib", "UnicodeBreakType",UnicodeBreakType);
  registerInterceptorTypeForNamedType("GLib", "UnicodeScript",UnicodeScript);
  registerInterceptorTypeForNamedType("GLib", "UnicodeType",UnicodeType);
  registerInterceptorTypeForNamedType("GLib", "UserDirectory",UserDirectory);
  registerInterceptorTypeForNamedType("GLib", "Variant",Variant);
  registerInterceptorTypeForNamedType("GLib", "VariantBuilder",VariantBuilder);
  registerInterceptorTypeForNamedType("GLib", "VariantClass",VariantClass);
  registerInterceptorTypeForNamedType("GLib", "VariantDict",VariantDict);
  registerInterceptorTypeForNamedType("GLib", "VariantParseError",VariantParseErrorCode);
  registerInterceptorTypeForNamedType("GLib", "VariantType",VariantType);
  registerInterceptorTypeForErrorDomain("g-bookmark-file-error-quark", BookmarkFileError);
  registerInterceptorTypeForErrorDomain("g_convert_error", ConvertError);
  registerInterceptorTypeForErrorDomain("g-file-error-quark", FileError);
  registerInterceptorTypeForErrorDomain("g-io-channel-error-quark", IOChannelError);
  registerInterceptorTypeForErrorDomain("g-key-file-error-quark", KeyFileError);
  registerInterceptorTypeForErrorDomain("g-markup-error-quark", MarkupError);
  registerInterceptorTypeForErrorDomain("g-option-context-error-quark", OptionError);
  registerInterceptorTypeForErrorDomain("g-regex-error-quark", RegexError);
  registerInterceptorTypeForErrorDomain("g-shell-error-quark", ShellError);
  registerInterceptorTypeForErrorDomain("g-exec-error-quark", SpawnError);
  registerInterceptorTypeForErrorDomain("g_thread_error", ThreadError);
  registerInterceptorTypeForErrorDomain("g-variant-parse-error-quark", VariantParseError);
}
