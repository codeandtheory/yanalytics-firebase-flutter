import 'package:flutter_test/flutter_test.dart';
import 'package:yanalytics_firebase/src/firebase_analytics_engine.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yanalytics/yanalytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class MockFirebaseAnalytics extends Mock implements FirebaseAnalytics
{
  late bool logCalled;
  @override
  Future<void> logEvent({required String name, Map<String, Object?>? parameters, AnalyticsCallOptions? callOptions}) 
  {
    logCalled = true;
    return Future.value();
  }

  @override
  Future<void> setUserProperty({required String name, required String? value, AnalyticsCallOptions? callOptions}) {
    logCalled = true;
    return Future.value();
  }
}

void main() {
  group('FirebaseAnalyticsEngine', () {
    late FirebaseAnalyticsEngine sut; 
    late MockFirebaseAnalytics mockFirebaseAnalytics;

    setUp(() {
      mockFirebaseAnalytics = MockFirebaseAnalytics();
      sut = FirebaseAnalyticsEngine(configuration: null, firebaseAnalytics: mockFirebaseAnalytics);
    });

    setUpAll(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      registerFallbackValue(AnalyticsEvent.screenView(screenName: 'test screen'));
    });

    test('trackEvent() logs screen name event', () async {
      final event = AnalyticsEvent.screenView(screenName: "ScreenView");
      sut.trackEvent(event);
      expect(mockFirebaseAnalytics.logCalled, isTrue);
    });

    test('trackEvent() logs event with parameters', () async {
      final event = AnalyticsEvent.event(eventName: "name", eventParemeters: {"key": "value"});
      sut.trackEvent(event);
      expect(mockFirebaseAnalytics.logCalled, isTrue);
    });

    test('trackEvent() logs event user property', () {
      final event = AnalyticsEvent.userProperty(userPropertyName: "user property", userPropertyValue: "value");
      sut.trackEvent(event);
      expect(mockFirebaseAnalytics.logCalled, isTrue);
    });
  });
}