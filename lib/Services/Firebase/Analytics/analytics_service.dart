import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  Future<void> setUserId(userId) async {
    await _analytics.setUserId(id: userId);
    // await _analytics.setUserProperty(name: 'user_role', value: userRole);

    ///MORE PROPERTIES I CAN ADD
    //property to indicate if it's a pro paying member
    //property that might tell us it's regular poster, etc

    // await _analytics.setUserId(id: '+91$mobileNo');
    // await _analytics.setUserProperty(name: 'Username', value: name);
  }

  Future<void> currentScreenEvent(screenName) async {
    await _analytics.logScreenView(
        screenName: screenName, screenClass: screenName);
    await _analytics.setCurrentScreen(screenName: screenName);
    await _analytics.logEvent(name: screenName, parameters: {
      'ScreenName': screenName,
      'ScreenClass': screenName,
    });
  }
}
