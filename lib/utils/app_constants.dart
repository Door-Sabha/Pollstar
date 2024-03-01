import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppConstants {
  late PackageInfo _packageInfo;
  late DeviceInfoPlugin _deviceInfo;

  late String _session;
  late String _userId;
  late String _stateId;

  late String _appName;
  late String _packageName;
  late String _version;
  late String _buildNumber;
  late String _versionInfo;

  late String _deviceData;

  init(BuildContext context) async {
    _packageInfo = await PackageInfo.fromPlatform();
    _appName = _packageInfo.appName;
    _packageName = _packageInfo.packageName;
    _version = _packageInfo.version;
    _buildNumber = _packageInfo.buildNumber;
    _versionInfo = "Version - $_version ($_buildNumber)";

    _deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo info = await _deviceInfo.iosInfo;
      String name = info.name;
      String model = info.model;
      String systemVersion = info.systemVersion;
      _deviceData = "$name / $model / $systemVersion";
    } else {
      AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
      String brand = androidInfo.brand;
      String model = androidInfo.model;
      String systemVersion = androidInfo.version.release;
      _deviceData = "$brand / $model / $systemVersion";
    }
  }

  clear() {
    _session = "";
    _userId = "";
    _stateId = "";
  }

  get session => _session;
  set session(value) => _session = value;

  get userId => _userId;
  set userId(value) => _userId = value;

  get stateId => _stateId;
  set stateId(value) => _stateId = value;

  get appName => _appName;
  get packageName => _packageName;
  get version => _version;
  get buildNumber => _buildNumber;
  get deviceData => _deviceData;
  get versionInfo => _versionInfo;
}
