import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_street_view_method_channel.dart';

abstract class FlutterStreetViewPlatform extends PlatformInterface {
  /// Constructs a FlutterStreetViewPlatform.
  FlutterStreetViewPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterStreetViewPlatform _instance = MethodChannelFlutterStreetView();

  /// The default instance of [FlutterStreetViewPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterStreetView].
  static FlutterStreetViewPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterStreetViewPlatform] when
  /// they register themselves.
  static set instance(FlutterStreetViewPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }
}
