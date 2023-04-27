import 'package:test/test.dart';
import 'package:yanalytics_firebase/src/firebase_analytics_engine.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yanalytics/yanalytics.dart';

class MockFirebaseAnalytics extends Mock implements FirebaseAnalyticsEngine{}

void main() {
  group('FirebaseAnalyticsEngine', () {
    late MockFirebaseAnalytics mockAnalytics;

    setUp(() {
      mockAnalytics = MockFirebaseAnalytics();
    });

    setUpAll(() {
    registerFallbackValue(AnalyticsEvent.screenView(screenName: 'test screen'));
    });

    test('trackEvent() logs screen view', () {
      final event = AnalyticsEvent.screenView(screenName: "Home");
      mockAnalytics.trackEvent(event);
      verify(() => mockAnalytics.trackEvent(any())).called(1); 
    });

    test('trackEvent() logs user property', () {
      final event = AnalyticsEvent.userProperty(userPropertyName: "PropName", userPropertyValue: "PropValue");
      mockAnalytics.trackEvent(event);
      verify(() => mockAnalytics.trackEvent(any())).called(1);
    });

    test('trackEvent() logs event with parameters', () {
      final event = AnalyticsEvent.event(eventName: "EventName", eventParemeters: {"key": "value"});
      mockAnalytics.trackEvent(event);
      verify(() => mockAnalytics.trackEvent(any())).called(1);
    });
  });
}
