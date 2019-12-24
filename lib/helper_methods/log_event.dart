import '../main.dart';

Future<void> logEvent(String eventName,
    {Map<String, dynamic> eventParameters}) async {
  await MyApp.analytics.logEvent(name: eventName, parameters: eventParameters);
  print('event $eventName succeeded');
}
