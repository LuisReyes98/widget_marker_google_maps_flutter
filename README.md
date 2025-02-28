# widget_marker_google_maps_flutter
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-3-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

[![pub package](https://img.shields.io/pub/v/widget_marker_google_maps_flutter.svg)](https://pub.dev/packages/widget_marker_google_maps_flutter) <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-purple.svg" alt="License: MIT"></a>


This package is a fork of [widget_marker_google_map](https://pub.dev/packages/widget_marker_google_map) that was created to add support for the new `google_maps_flutter_platform_interface: ^2.8.0` changes. And also add new functionality to the `WidgetMarkerGoogleMap` widget.

Google map with widget markers.

<img src="https://user-images.githubusercontent.com/43510799/142984717-853a7686-503e-4e2c-b090-9767e25fb8d3.png" width=330>

## Set up
Follow the steps on [google_maps_flutter document.](https://pub.dev/packages/google_maps_flutter#getting-started)


## Migrating to 1.0

The update to the `google_maps_flutter_platform_interface: ^2.8.0` changes that Deprecate`BitmapDescriptor.fromBytes` in favor of `BitmapDescriptor.bytes` that handles it in a `BytesMapBitmap`.

Declaring a multiplatform marker

```dart
WidgetMarker(
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
)
```

### 1.0 Usage and Breaking changes

```dart
import 'package:widget_marker_google_maps_flutter/widget_marker_google_map.dart';
```

Changed `markers` and `widgetMarkers` from a `Set` to a `Map`
This code can be seen in the example below.

```dart
WidgetMarkerGoogleMap(
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
)
```

### WidgetMarker

You need to insert the list of `WidgetMarker` to use widget markers.
Make sure that you still need to use `onTap` method when you use gestures.

```dart
class WidgetMarker {
  WidgetMarker({
    required this.position,
    required this.markerId,
    required this.widget,
    this.onTap,
  }) : assert(markerId.isNotEmpty);

  final LatLng position;

  /// Keep this unique, otherwise it will not appear.
  final String markerId;

  /// Gestures of widget is disabled.
  /// Use this callback instead.
  final VoidCallback? onTap;

  final Widget widget;
}
```

If you have any requests or questions, feel free to ask on [github](https://github.com/santa112358/widget_marker_google_maps_flutter/issues).



## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/davey06"><img src="https://avatars.githubusercontent.com/u/32833275?v=4?s=100" width="100px;" alt="Devin"/><br /><sub><b>Devin</b></sub></a><br /><a href="https://github.com/LuisReyes98/widget_marker_google_maps_flutter/commits?author=davey06" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://pub.dev/publishers/3tadev.work/packages"><img src="https://avatars.githubusercontent.com/u/43510799?v=4?s=100" width="100px;" alt="Santa Takahashi"/><br /><sub><b>Santa Takahashi</b></sub></a><br /><a href="https://github.com/LuisReyes98/widget_marker_google_maps_flutter/commits?author=santa112358" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/LuisReyes98"><img src="https://avatars.githubusercontent.com/u/26679961?v=4?s=100" width="100px;" alt="Devin"/><br /><sub><b>Luis Rogelio</b></sub></a><br /><a href="https://github.com/LuisReyes98/widget_marker_google_maps_flutter/commits?author=LuisReyes98" title="Code">💻</a></td>
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!