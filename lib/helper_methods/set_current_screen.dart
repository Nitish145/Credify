import '../main.dart';

Future<void> setCurrentScreen(String screenName) async {
  await MyApp.analytics.setCurrentScreen(
    screenName: screenName,
  );
  print('setScreen $screenName succeeded');
}
