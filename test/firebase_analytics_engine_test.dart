import 'package:flutter_test/flutter_test.dart';
import 'package:yanalytics_firebase/src/firebase_analytics_engine.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yanalytics/yanalytics.dart';

class MockFirebaseEventsTrigger extends Mock implements FirebaseEventsTrigger {}

void main() {
  group('FirebaseAnalyticsEngine', () {
    late FirebaseAnalyticsEngine sut; 
    late MockFirebaseEventsTrigger mockFirebaseEventsTrigger;

    setUp(() {
      mockFirebaseEventsTrigger = MockFirebaseEventsTrigger();
      sut = FirebaseAnalyticsEngine(configuration: null, firebaseAnalytics: mockFirebaseEventsTrigger);
    });

    test('trackEvent() logs screen name event', () {
      final event = AnalyticsEvent.screenView(screenName: "ScreenViewed");
      sut.trackEvent(event);
      verify(() => mockFirebaseEventsTrigger.logEvent('screenView', {'screenName': 'ScreenViewed'}));
    });

    test('trackEvent() logs event with parameters', () {
      final event = AnalyticsEvent.event(eventName: "name", eventParemeters: {"key": "value"});
      sut.trackEvent(event);
      verify(() => mockFirebaseEventsTrigger.logEvent("name", {"key": "value"})).called(1);
    });

    test('trackEvent() logs event user property', () {
      final event = AnalyticsEvent.userProperty(userPropertyName: "user property", userPropertyValue: "value");
      sut.trackEvent(event);
      verify(() => mockFirebaseEventsTrigger.setUserProperty("user property", "value")).called(1);
    });
  });
}