import 'package:package_info_plus/package_info_plus.dart';

class AppConstants {
  int? _lastRefreshTime;
  int? _queuedTime;
  int _lastRefreshOnTabSwitch = DateTime.now().millisecondsSinceEpoch;

  String? _version;
  String? _buildNumber;
  String? _versionInfo;

  AppConstants() {
    PackageInfo.fromPlatform().then((value) {
      _version = value.version;
      _buildNumber = value.buildNumber;
      _versionInfo = "Version - $_version ($_buildNumber)";
    });
  }

  clear() {}

  get lastRefreshTime => _lastRefreshTime;
  set lastRefreshTime(value) => _lastRefreshTime = value;

  get queuedTime => _queuedTime;
  set queuedTime(value) => _queuedTime = value;

  get lastRefreshOnTabSwitch => _lastRefreshOnTabSwitch;
  set lastRefreshOnTabSwitch(value) => _lastRefreshOnTabSwitch = value;

  get versionInfo => _versionInfo;
}
