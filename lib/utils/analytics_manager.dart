import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class AnalyticsManager {
  late final FirebaseAnalytics _analytics;
  late final FirebaseAnalyticsObserver _observer;

  AnalyticsManager() {
    _analytics = FirebaseAnalytics.instance;
    _observer = FirebaseAnalyticsObserver(analytics: _analytics);
    _analytics.setAnalyticsCollectionEnabled(kReleaseMode);
  }

  FirebaseAnalyticsObserver getFirebaseAnalyticsObserver() {
    return _observer;
  }

  void setuserId({required String userId}) {
    _analytics.setUserId(id: userId);
  }

  void logScreenView({required String name}) {
    _analytics.logScreenView(screenName: name);
  }

  void logSignin() {
    logEvent(name: "");
  }

  void logSignOut() {
    logEvent(name: "");
  }

  void logEvent({required String name, Map<String, Object>? parameters}) {
    if (parameters != null) {
      _analytics.logEvent(name: name, parameters: parameters);
    } else {
      _analytics.logEvent(name: name);
    }
  }
}
