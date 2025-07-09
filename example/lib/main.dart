import 'package:flutter/material.dart';
import 'package:widget_marker_google_maps_flutter/widget_marker_google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  static const shibuya = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(35.6598003, 139.7023894),
    zoom: 15.151926040649414,
  );

  static const cafePosition = LatLng(35.659172, 139.7023894);
  static const clothesShopPosition = LatLng(35.659528, 139.698723);
  static const flutterLogoPosition = LatLng(35.6614027, 139.6983333);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WidgetMarkerGoogleMap(
        initialCameraPosition: shibuya,
        mapType: MapType.normal,
        markers: {
          const MarkerId('default_marker'): Marker(
            position: shibuya.target,
            markerId: const MarkerId('default_marker'),
          ),
        },
        widgetMarkers: <MarkerId, WidgetMarker>{
          const MarkerId(
            'cafe',
          ): WidgetMarker(
            position: cafePosition,
            markerId: 'cafe',
            widget: Container(
              color: Colors.brown,
              padding: const EdgeInsets.all(2),
              child: Icon(
                Icons.coffee,
                color: Colors.white,
                size: 14 * MarkerGenerator.getDevicePixelRatio(context),
              ),
            ),
          ),
          const MarkerId(
            'clothes',
          ): WidgetMarker(
            position: clothesShopPosition,
            markerId: 'clothes',
            widget: Container(
              color: Colors.green,
              padding: const EdgeInsets.all(4),
              child: Text(
                'shop',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 10 * MarkerGenerator.getDevicePixelRatio(context),
                ),
              ),
            ),
          ),
          const MarkerId(
            'network_flutterlogo',
          ): WidgetMarker(
            position: flutterLogoPosition,
            markerId: 'network_flutterlogo',
            widget: SizedBox(
              width: 18 * MarkerGenerator.getDevicePixelRatio(context),
              height: 18 * MarkerGenerator.getDevicePixelRatio(context),
              child: Image.network(
                'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
              ),
            ),
          ),
        },
      ),
    );
  }
}
