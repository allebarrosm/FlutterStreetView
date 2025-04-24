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

  const FlutterStreetView({
    super.key,
    required this.latitude,
    required this.longitude,
    this.bearing,
    this.tilt,
    this.zoom,
  });

  @override
  State<FlutterStreetView> createState() => _FlutterStreetViewState();
}

class _FlutterStreetViewState extends State<FlutterStreetView> {
  static const MethodChannel _channel = MethodChannel('flutter_street_view');

  @override
  void initState() {
    super.initState();
  }

  Future<void> _setupPositionUpdates() async {
    try {
      await _channel.invokeMethod<bool>('updatePosition', {
        'latitude': widget.latitude,
        'longitude': widget.longitude,
      });
    } on PlatformException catch (e) {
      print('Erro: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    _setupPositionUpdates();
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
