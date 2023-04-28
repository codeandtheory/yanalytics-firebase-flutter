import 'package:yanalytics_firebase/src/firebase_analytics_configuration.dart';
import 'package:yanalytics_firebase/src/firebase_event_mapping.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:yanalytics/yanalytics.dart';

/// A class that extends AnalyticsEngine that allows to log messages to Firebase Analytics
class FirebaseAnalyticsEngine extends AnalyticsEngine {
  /// Info for mapping `AnalyticsEvent` events to Firebase events
  late Map<String, FirebaseEventMapping> mappings;
  /// Firebase analytics instance 
  late FirebaseEventsTrigger analytics;

  /// Initialize Firebase Engine.
  /// 
  /// [configuration] to configure the engine, [firebaseAnalytics] to configure firebase and trigger events to firebase console. 
  FirebaseAnalyticsEngine({FirebaseAnalyticsConfiguration? configuration, FirebaseEventsTrigger? firebaseAnalytics})
  {
    mappings = configuration?.mappings ?? FirebaseEventMapping.defaultMappings;
    analytics = firebaseAnalytics ?? FirebaseEventsTrigger();
    if (configuration?.name != null && configuration?.options != null)
    {
      analytics.configureFirebase(configuration?.options, configuration?.name);
    }
    else
    if (configuration?.options != null)
    {
      analytics.configureFirebase(configuration?.options, null);
    }
    else 
    {
      analytics.configureFirebase(null, null);
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
      analytics.logEvent(name, data);
    }
    else 
    if (event.userPropertyName != null)
    {
      String userPropertyName = event.userPropertyName ?? "";
      String? userPropertyValue = event.userPropertyValue;
      analytics.setUserProperty(userPropertyName, userPropertyValue);
    }
    else 
    if (event.eventName != null)
    {
      String eventName = event.eventName ?? "";
      Map<String, dynamic>? eventParameters = event.eventParemeters;
      if (event.eventParemeters != null)
      {
        analytics.logEvent(eventName, eventParameters);
      }
      else
      {
        analytics.logEvent(eventName, null);
      }
    }
  }
}

/// A class that allows to configure firebase and trigger events to firebase console. 
class FirebaseEventsTrigger
{
  /// Firebase analytics instance. 
  late FirebaseAnalytics analytics;  

  /// Configure firebase instance
  /// 
  /// [options] and [name] to initialize firebase.  
  void configureFirebase(FirebaseOptions? options, String? name)
  {
    Firebase.initializeApp(options: options, name: name);
    analytics = FirebaseAnalytics.instance;
  }

  /// Log event to firebase console 
  /// 
  /// [name] and [parameters] to log. 
  void logEvent(String name, Map<String, Object?>? parameters)
  {
    analytics.logEvent(name: name, parameters: parameters);
  }

  /// Set user property
  /// 
  /// [name] and [value] to log. 
  void setUserProperty(String name, String? value)
  {
    analytics.setUserProperty(name: name, value: value);
  }
}