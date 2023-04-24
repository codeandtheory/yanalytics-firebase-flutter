import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yanalytics_firebase/src/firebase_analytics_configuration.dart';

class MockFirebaseOptions extends Mock implements FirebaseOptions {}

void main() {
  group('can init default FirebaseAnalyticsConfiguration', () {
    test('default configuration', () {
      final config = FirebaseAnalyticsConfiguration.defaultConfiguration;

      expect(config.name, isNull);
      expect(config.options, isNull);
      expect(config.mappings, isEmpty);
    });

    test('can init configuration with mappings', () {
      final mappings = {
        'test_event': FirebaseEventMapping(/*...*/),
      };
      final config = FirebaseAnalyticsConfiguration(mappings: mappings);

      expect(config.name, isNull);
      expect(config.options, isNull);
      expect(config.mappings, equals(mappings));
    });

    test('can init configuration with options', () {
      final options = MockFirebaseOptions();
      final config = FirebaseAnalyticsConfiguration.withOptions(options: options);

      expect(config.name, isNull);
      expect(config.options, equals(options));
      expect(config.mappings, isEmpty);
    });

    test('can init configuration with name and options', () {
      final name = 'custom_name';
      final options = MockFirebaseOptions();
      final config = FirebaseAnalyticsConfiguration.withNameAndOptions(
        name: name,
        options: options,
      );

      expect(config.name, equals(name));
      expect(config.options, equals(options));
      expect(config.mappings, isEmpty);
    });
  });
}