## 1.0.0
- Upgraded for flutter 3 linting rules
- Updated to `google_maps_flutter_platform_interface: ^2.8.0` changes that, Deprecate `BitmapDescriptor.fromBytes` in favor of `BitmapDescriptor.bytes` and `BytesMapBitmap`
- Removes invalid tags in pubspec.
- Updates minimum flutter version to 3.16.0
- Updates minimun dart version to 3.0.0
- Breaking change use of new method `BitmapDescriptor.bytes` unifies marker size accross platforms web,android and ios, and previous work arounds that used the `devicePixelRatio` are no longer needed and in turn will make the markers too big.

## 0.0.2
- Added missing arguments
- Upgrade flutter version to 2.10.3

## 0.0.1
- Release
