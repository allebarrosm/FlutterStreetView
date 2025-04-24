import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_street_view_platform_interface.dart';

/// An implementation of [FlutterStreetViewPlatform] that uses method channels.
class MethodChannelFlutterStreetView extends FlutterStreetViewPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_street_view');
}
