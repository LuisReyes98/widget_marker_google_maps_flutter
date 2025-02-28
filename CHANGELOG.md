## 1.0.0
- Forked from `https://pub.dev/packages/widget_marker_google_map`
- Upgraded for flutter 3 linting rules
- Updated to `google_maps_flutter_platform_interface: ^2.8.0` changes that, Deprecate `BitmapDescriptor.fromBytes` in favor of `BitmapDescriptor.bytes` and `BytesMapBitmap`
- Removes invalid tags in pubspec.
- Upgrade minimum flutter version to 3.16.0
- Upgrade minimum dart version to 3.0.0
- Breaking change use of new method `BitmapDescriptor.bytes` unifies marker size across platforms web, android and ios, and previous work arounds that used the `devicePixelRatio` are no longer needed and in turn will make the markers too big.
- Added new `GoogleMap` props to be available from the `WidgetMarkerGoogleMap` widget.
- Changed `markers` and `widgetMarkers` from a `Set` to a `Map`
- Added a 500ms delay to the `MarkerGenerator` to allow the widgets to use loaded images of any kind.


## 0.0.2
- Added missing arguments
- Upgrade flutter version to 2.10.3

## 0.0.1
- Release
