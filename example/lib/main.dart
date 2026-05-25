import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  static const shibuya = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(35.6598003, 139.7023894),
    zoom: 15.151926040649414,
  );

  static const cafePosition = LatLng(35.659172, 139.7023894);
  static const clothesShopPosition = LatLng(35.659528, 139.698723);
  static const flutterLogoPosition = LatLng(35.6614027, 139.6983333);

  /// create a new configuration at https://mapstyle.withgoogle.com/

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MapColorScheme currentColorScheme = MapColorScheme.light;
  Key lightKey = const Key('light_map');
  Key darkKey = const Key('dark_map');
  Key lightKeyPoi = const Key('lightKeyPoi');
  Key darkKeyPoi = const Key('darkKeyPoi');

  Key currentKey = const Key('light_map');
  String mapIdHidePoi = '61e50871c15e139b9779dedd';
  String showPoiMapId = '61e50871c15e139bc69bfab1';
  String currentMapId = '61e50871c15e139b9779dedd';

  String currentMapStyle = mapStyleDefault;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  currentColorScheme = MapColorScheme.dark;
                  currentKey = darkKey;
                  currentMapStyle = mapStyleDefaultDarkMode;
                  setState(() {});
                },
                child: const Text('Set Dark Mode'),
              ),
              ElevatedButton(
                onPressed: () {
                  currentColorScheme = MapColorScheme.light;
                  currentKey = lightKey;
                  currentMapStyle = mapStyleDefault;
                  setState(() {});
                },
                child: const Text('Set Light Mode'),
              ),
              ElevatedButton(
                onPressed: () {
                  currentMapId = mapIdHidePoi;
                  currentKey = darkKeyPoi;
                  setState(() {});
                },
                child: const Text('Hide POI'),
              ),
              ElevatedButton(
                onPressed: () {
                  currentMapId = showPoiMapId;
                  currentKey = lightKeyPoi;

                  setState(() {});
                },
                child: const Text('Show POI'),
              ),
            ],
          ),
          Expanded(
            child: WidgetMarkerGoogleMap(
              mapId: currentMapId,
              key: currentKey,
              initialCameraPosition: MyHomePage.shibuya,
              mapType: MapType.none,
              markers: {
                MarkerId('default_marker'): AdvancedMarker(
                  position: MyHomePage.shibuya.target,
                  markerId: const MarkerId('default_marker'),
                  icon: BitmapDescriptor.defaultMarker,
                ),
              },
              style: currentMapStyle,
              colorScheme: currentColorScheme,
              markerType: GoogleMapMarkerType.advancedMarker,
              widgetMarkers: <MarkerId, WidgetMarker>{
                const MarkerId(
                  'cafe',
                ): WidgetMarker(
                  position: MyHomePage.cafePosition,
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
                  position: MyHomePage.clothesShopPosition,
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
                  position: MyHomePage.flutterLogoPosition,
                  markerId: 'network_flutterlogo',
                  widget: SizedBox(
                    width: 18 * MarkerGenerator.getDevicePixelRatio(context),
                    height: 18 * MarkerGenerator.getDevicePixelRatio(context),
                    child: Image.network(
                      'https://flutter.dev/assets/icon_flutter.4262c71228b7aa391e995fe5f1d57795.png',
                    ),
                  ),
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}

const String mapStyleDefault = """
[
  {
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [
      {
        "visibility": "on"
      }
    ]
  },
  {
    "featureType": "poi",
    "stylers": [
      {
        "visibility": "on"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "on"
      }
    ]
  },
  {
    "featureType": "transit",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  }
]
""";

const String mapStyleDefaultDarkMode = """[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#242f3e"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#746855"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#242f3e"
      }
    ]
  },
  {
    "featureType": "administrative.locality",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#263c3f"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#6b9a76"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#38414e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#212a37"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9ca5b3"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#746855"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#1f2835"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#f3d19c"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#2f3948"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#17263c"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#515c6d"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#17263c"
      }
    ]
  }
]""";
