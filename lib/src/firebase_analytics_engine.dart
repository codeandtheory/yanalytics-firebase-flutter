import 'package:yanalytics_firebase/src/firebase_analytics_configuration.dart';
import 'package:yanalytics_firebase/src/firebase_event_mapping.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:yanalytics/src/analytics_engine.dart';
import 'package:yanalytics/src/compound_analytics_engine.dart';

/// A class that extends AnalyticsEngine that allows to log messages to Firebase Analytics
class FirebaseAnalyticsEngine extends AnalyticsEngine {
  /// Info for mapping `AnalyticsEvent` events to Firebase events
  final Map<String, FirebaseEventMapping> mappings;
  /// Firebase analytics instance 
  late FirebaseAnalytics analytics;

  /// Initialize Firebase Engine.
  /// 
  /// [configuration] to configure the engine. 
  FirebaseAnalyticsEngine({FirebaseAnalyticsConfiguration? configuration})
      : mappings = configuration?.mappings ?? FirebaseEventMapping.defaultMappings {
    analytics = FirebaseAnalytics.instance;
    if (configuration?.name != null && configuration?.options != null)
    {
      Firebase.initializeApp(options: configuration?.options, name: configuration?.name);
    }
    else
    if (configuration?.options != null)
    {
      Firebase.initializeApp(options: configuration?.options);
    }
    else 
    {
      Firebase.initializeApp();
    }
  }
  
  /// Log an analytics event to firebase 
  ///
  /// [event] the event to log
  @override
  void trackEvent(AnalyticsEvent event) 
  {
    if (event.screenName != null)
    {
      String? screenName = event.screenName;
      var mapping = mappings[screenViewKey] ?? FirebaseEventMapping.defaultScreenView;
      var name = mapping.name;
      var data = {mapping.topLevelKey: screenName};
      analytics.logEvent(name: name, parameters: data);
    }
    else 
    if (event.userPropertyName != null)
    {
      String userPropertyName = event.userPropertyName ?? "";
      String? userPropertyValue = event.userPropertyValue;
      analytics.setUserProperty(name: userPropertyName
      , value: userPropertyValue);
    }
    else 
    if (event.eventName != null)
    {
      String eventName = event.eventName ?? "";
      Map<String, dynamic>? eventParameters = event.eventParemeters;
      if (event.eventParemeters != null)
      {
        analytics.logEvent(name: eventName, parameters: eventParameters);
      }
      else
      {
        analytics.logEvent(name: eventName);
      }
    }
  }
}