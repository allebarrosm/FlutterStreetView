import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlutterStreetView extends StatefulWidget {
  final double latitude;
  final double longitude;
  final double? bearing;
  final double? tilt;
  final double? zoom;
  final void Function(LatLng)? onPositionChanged;

  const FlutterStreetView({
    super.key,
    required this.latitude,
    required this.longitude,
    this.bearing,
    this.tilt,
    this.zoom,
    this.onPositionChanged,
  });

  @override
  State<FlutterStreetView> createState() => _FlutterStreetViewState();
}

class _FlutterStreetViewState extends State<FlutterStreetView> {
  static const MethodChannel _channel = MethodChannel('flutter_street_view');

  @override
  void initState() {
    super.initState();
    _setupPositionUpdates();
  }

  void _setupPositionUpdates() {
    if (widget.onPositionChanged != null) {
      _channel.setMethodCallHandler((call) async {
        if (call.method == 'positionChanged') {
          final lat = call.arguments['latitude'] as double;
          final lng = call.arguments['longitude'] as double;
          widget.onPositionChanged!(LatLng(lat, lng));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const Text("Street View Web ainda não implementado.");
    }

    if (Platform.isAndroid) {
      return AndroidView(
        viewType: 'flutter_street_view/native',
        creationParams: {
          'latitude': widget.latitude,
          'longitude': widget.longitude,
          if (widget.bearing != null) 'bearing': widget.bearing,
          if (widget.tilt != null) 'tilt': widget.tilt,
          if (widget.zoom != null) 'zoom': widget.zoom,
        },
        creationParamsCodec: const StandardMessageCodec(),
      );
    }

    return const Text("Street View não suportado nesta plataforma.");
  }
}

class LatLng {
  final double latitude;
  final double longitude;

  const LatLng(this.latitude, this.longitude);

  @override
  String toString() => 'LatLng(lat: $latitude, lng: $longitude)';
}
