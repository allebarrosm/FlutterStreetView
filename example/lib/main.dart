import 'package:flutter/material.dart';
import 'package:flutter_street_view/flutter_street_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<LatLng> locations = [
    const LatLng(-7.112137, -34.839661), // João Pessoa
    const LatLng(-22.9068, -43.1729), // Rio de Janeiro
    const LatLng(-23.5505, -46.6333), // São Paulo
    const LatLng(-15.7975, -47.8919), // Brasília
  ];

  int currentIndex = 0;
  LatLng? currentPosition;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Street View Navigator'),
          actions: [
            IconButton(
              icon: const Icon(Icons.my_location),
              onPressed: () {
                if (currentPosition != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Posição atual: ${currentPosition!.latitude.toStringAsFixed(6)}, ${currentPosition!.longitude.toStringAsFixed(6)}',
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: FlutterStreetView(
                latitude: locations[currentIndex].latitude,
                longitude: locations[currentIndex].longitude,
                onPositionChanged: (newPosition) {
                  setState(() {
                    currentPosition = LatLng(
                      newPosition.latitude,
                      newPosition.longitude,
                    );
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed:
                        currentIndex > 0
                            ? () {
                              setState(() {
                                currentIndex--;
                              });
                            }
                            : null,
                    child: const Text('Anterior'),
                  ),
                  Text('Local ${currentIndex + 1} de ${locations.length}'),
                  ElevatedButton(
                    onPressed:
                        currentIndex < locations.length - 1
                            ? () {
                              setState(() {
                                currentIndex++;
                              });
                            }
                            : null,
                    child: const Text('Próximo'),
                  ),
                ],
              ),
            ),
            if (currentPosition != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Posição atual: ${currentPosition!.latitude.toStringAsFixed(6)}, ${currentPosition!.longitude.toStringAsFixed(6)}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class LatLng {
  final double latitude;
  final double longitude;

  const LatLng(this.latitude, this.longitude);
}
