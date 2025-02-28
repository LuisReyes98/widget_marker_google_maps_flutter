import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widget_marker_google_maps_flutter/widget_marker_google_maps_flutter.dart';

void main() {
  test('Test Widget Creation', () {
    const shibuya = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(35.6598003, 139.7023894),
      zoom: 15.151926040649414,
    );

    const cafePosition = LatLng(35.659172, 139.7023894);
    const clothesShopPosition = LatLng(35.659528, 139.698723);
    const flutterLogoPosition = LatLng(35.6614027, 139.6983333);
    final mainWidget = WidgetMarkerGoogleMap(
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
              size: 14,
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
                fontSize: 10,
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
            width: 18,
            height: 18,
            child: Image.network(
              'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
            ),
          ),
        ),
      },
    );

    expect(mainWidget, isA<WidgetMarkerGoogleMap>());
  });
}
