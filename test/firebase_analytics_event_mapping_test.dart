import 'package:flutter_test/flutter_test.dart';
import 'package:yanalytics_firebase/src/firebase_event_mapping.dart';

void main() {
  group('FirebaseEventMapping', () {
    test('default constructor', () {
      final mapping = FirebaseEventMapping(name: 'testEvent', topLevelKey: 'testKey');

      expect(mapping.name, 'testEvent');
      expect(mapping.topLevelKey, 'testKey');
    });

    test('defaultScreenView', () {
      final mapping = FirebaseEventMapping.defaultScreenView;

      expect(mapping.name, screenViewKey);
      expect(mapping.topLevelKey, screenName);
    });
  });
}