import 'package:test/test.dart';
import 'package:yanalytics_firebase/src/firebase_analytics_engine.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yanalytics/yanalytics.dart';

class MockFirebaseAnalyticsEngine extends Mock implements FirebaseAnalyticsEngine{}

void main() {
  late CompoundAnalyticsEngine sut;
  late MockFirebaseAnalyticsEngine mockFirebaseAnalyticsEngineOne;
  late MockFirebaseAnalyticsEngine mockFirebaseAnalyticsEngineTwo;

  setUp(() {
    sut = CompoundAnalyticsEngine();
    mockFirebaseAnalyticsEngineOne = MockFirebaseAnalyticsEngine();
    mockFirebaseAnalyticsEngineTwo = MockFirebaseAnalyticsEngine();
  });

  setUpAll(() {
    registerFallbackValue(AnalyticsEvent.screenView(screenName: 'test screen'));
  });

  test('forwards log event to all registered engines for an event', () {
    // Arrange
    sut.add(engine: mockFirebaseAnalyticsEngineOne);
    sut.add(engine: mockFirebaseAnalyticsEngineTwo);
    final someEvent = AnalyticsEvent.event(eventName: "eventName");

    // Act
    sut.trackEvent(someEvent);

    // Assert
    verify(
            () => mockFirebaseAnalyticsEngineOne.trackEvent(any(that: equals(someEvent))));
    verify(
            () => mockFirebaseAnalyticsEngineTwo.trackEvent(any(that: equals(someEvent))));
  });

  test('forwards log event to all registered engines for screenView event', () {
    // Arrange
    sut.add(engine: mockFirebaseAnalyticsEngineOne);
    sut.add(engine: mockFirebaseAnalyticsEngineTwo);

    // Act
    sut.trackEvent(AnalyticsEvent.screenView(screenName: 'dashboard'));

    // Assert
    verify(() => mockFirebaseAnalyticsEngineOne.trackEvent(any())).called(1);
    verify(() => mockFirebaseAnalyticsEngineTwo.trackEvent(any())).called(1);
  });

  test('forwards log event to all registered engines for user property event', () {
    // Arrange
    sut.add(engine: mockFirebaseAnalyticsEngineOne);
    sut.add(engine: mockFirebaseAnalyticsEngineTwo);
    final someEvent = AnalyticsEvent.userProperty(
        userPropertyName: 'name', userPropertyValue: 'value');

    // Act
    sut.trackEvent(someEvent);

    // Assert
    verify(
            () => mockFirebaseAnalyticsEngineOne.trackEvent(any(that: equals(someEvent))));
    verify(
            () => mockFirebaseAnalyticsEngineTwo.trackEvent(any(that: equals(someEvent))));
  });
}
