import 'package:intl/intl.dart';

class AppString {
  static const appName = "HELLO";
}

class WelcomePageString {
  static const appName = "HELLO";
  static const nowYouAre = "Now You Are";
  static const connected = "Connected";
  static const discription = "Perfect solution of connexct with anyone easly and more secure";
  static const slideToStart = "Slide to start now";
}

class ZegoCloudConfig {
  static const appId = 2039631132;
  static const appSign = "37daf3e930c4248d561c767f963594016ecae6bbbeb2e06e4e3697bb3ad0b0c6";
}

String toLongDate(int dateTime) => DateFormat('dd MMMM y, hh:mm a').format(DateTime.fromMicrosecondsSinceEpoch(dateTime));
