import 'dart:io';

final LibraryFinder libraryFinder = _LibraryFinder();

sealed class LibraryFinder {
  String findLibrary(String libraryName);

  void setDiscovery(LibraryDiscovery discovery);
}

class _LibraryFinder implements LibraryFinder {
  bool _isDiscoverySet = false;
  LibraryDiscovery? _discovery;

  @override
  String findLibrary(String libraryName) {
    if (!_isDiscoverySet) {
      _discovery ??= LibraryDiscovery.defaultDiscovery();
      _isDiscoverySet = true;
    }
    return _discovery!.resolveLibraryName(libraryName);
  }

  @override
  void setDiscovery(LibraryDiscovery discovery) {
    if (_isDiscoverySet) {
      throw StateError("You can't change the library discovery method after it was set");
    }
    _discovery = discovery;
  }
}

abstract interface class LibraryDiscovery {
  String resolveLibraryName(String libraryName);

  factory LibraryDiscovery.defaultDiscovery() {
    if (Platform.isLinux) {
      return _LinuxLibraryDiscovery();
    }
    if (Platform.isMacOS) {
      return _MacLibraryDiscovery();
    }
    if (Platform.isWindows) {
      return _WindowsLibraryDiscovery();
    }

    throw UnsupportedError('Unsupported platform');
  }

  factory LibraryDiscovery.linux() = _LinuxLibraryDiscovery;

  factory LibraryDiscovery.mac() = _MacLibraryDiscovery;

  factory LibraryDiscovery.windows() = _WindowsLibraryDiscovery;
}

class _LinuxLibraryDiscovery implements LibraryDiscovery {
  @override
  String resolveLibraryName(String libraryName) {
    return 'lib$libraryName.so';
  }
}

class _MacLibraryDiscovery implements LibraryDiscovery {
  @override
  String resolveLibraryName(String libraryName) {
    return 'lib$libraryName.dylib';
  }
}

class _WindowsLibraryDiscovery implements LibraryDiscovery {
  @override
  String resolveLibraryName(String libraryName) {
    return '$libraryName.dll';
  }
}

