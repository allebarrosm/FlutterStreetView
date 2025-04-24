import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_street_view/flutter_street_view_platform_interface.dart';
import 'package:flutter_street_view/flutter_street_view_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterStreetViewPlatform
    with MockPlatformInterfaceMixin
    implements FlutterStreetViewPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterStreetViewPlatform initialPlatform =
      FlutterStreetViewPlatform.instance;

  test('$MethodChannelFlutterStreetView is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterStreetView>());
  });

  test('getPlatformVersion', () async {
    MockFlutterStreetViewPlatform fakePlatform =
        MockFlutterStreetViewPlatform();
    FlutterStreetViewPlatform.instance = fakePlatform;
  });
}
