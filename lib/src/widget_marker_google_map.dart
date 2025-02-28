import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:widget_marker_google_map/src/components/widget_marker.dart';

import 'components/marker_generator.dart';

class WidgetMarkerGoogleMap extends StatefulWidget {
  /// True if 45 degree imagery should be enabled. Web only.
  final bool fortyFiveDegreeImageryEnabled;

  /// Identifier that's associated with a specific cloud-based map style.
  ///
  /// See https://developers.google.com/maps/documentation/get-map-id
  /// for more details.
  final String? cloudMapId;

  /// Callback method for when the map is ready to be used.
  ///
  /// Used to receive a [GoogleMapController] for this [GoogleMap].
  final MapCreatedCallback? onMapCreated;

  /// The initial position of the map's camera.
  final CameraPosition initialCameraPosition;

  /// True if the map should show a compass when rotated.
  final bool compassEnabled;

  /// True if the map should show a toolbar when you interact with the map. Android only.
  final bool mapToolbarEnabled;

  /// Geographical bounding box for the camera target.
  final CameraTargetBounds cameraTargetBounds;

  /// Type of map tiles to be rendered.
  final MapType mapType;

  /// The layout direction to use for the embedded view.
  ///
  /// If this is null, the ambient [Directionality] is used instead. If there is
  /// no ambient [Directionality], [TextDirection.ltr] is used.
  final TextDirection? layoutDirection;

  /// Preferred bounds for the camera zoom level.
  ///
  /// Actual bounds depend on map data and device.
  final MinMaxZoomPreference minMaxZoomPreference;

  /// True if the map view should respond to rotate gestures.
  final bool rotateGesturesEnabled;

  /// True if the map view should respond to scroll gestures.
  final bool scrollGesturesEnabled;

  /// True if the map view should show zoom controls. This includes two buttons
  /// to zoom in and zoom out. The default value is to show zoom controls.
  ///
  /// This is only supported on Android. And this field is silently ignored on iOS.
  final bool zoomControlsEnabled;

  /// True if the map view should respond to zoom gestures.
  final bool zoomGesturesEnabled;

  /// True if the map view should be in lite mode. Android only.
  ///
  /// See https://developers.google.com/maps/documentation/android-sdk/lite#overview_of_lite_mode for more details.
  final bool liteModeEnabled;

  /// True if the map view should respond to tilt gestures.
  final bool tiltGesturesEnabled;

  /// Padding to be set on map. See https://developers.google.com/maps/documentation/android-sdk/map#map_padding for more details.
  final EdgeInsets padding;

  /// Markers to be placed on the map.
  final Map<MarkerId, Marker> markers;

  /// Polygons to be placed on the map.
  final Set<Polygon> polygons;

  /// Polylines to be placed on the map.
  final Set<Polyline> polylines;

  /// Circles to be placed on the map.
  final Set<Circle> circles;

  /// Tile overlays to be placed on the map.
  final Set<TileOverlay> tileOverlays;

  /// Called when the camera starts moving.
  ///
  /// This can be initiated by the following:
  /// 1. Non-gesture animation initiated in response to user actions.
  ///    For example: zoom buttons, my location button, or marker clicks.
  /// 2. Programmatically initiated animation.
  /// 3. Camera motion initiated in response to user gestures on the map.
  ///    For example: pan, tilt, pinch to zoom, or rotate.
  final VoidCallback? onCameraMoveStarted;

  /// Called repeatedly as the camera continues to move after an
  /// onCameraMoveStarted call.
  ///
  /// This may be called as often as once every frame and should
  /// not perform expensive operations.
  final CameraPositionCallback? onCameraMove;

  /// Called when camera movement has ended, there are no pending
  /// animations and the user has stopped interacting with the map.
  final VoidCallback? onCameraIdle;

  /// Called every time a [GoogleMap] is tapped.
  final ArgumentCallback<LatLng>? onTap;

  /// Called every time a [GoogleMap] is long pressed.
  final ArgumentCallback<LatLng>? onLongPress;

  /// True if a "My Location" layer should be shown on the map.
  ///
  /// This layer includes a location indicator at the current device location,
  /// as well as a My Location button.
  /// * The indicator is a small blue dot if the device is stationary, or a
  /// chevron if the device is moving.
  /// * The My Location button animates to focus on the user's current location
  /// if the user's location is currently known.
  ///
  /// Enabling this feature requires adding location permissions to both native
  /// platforms of your app.
  /// * On Android add either
  /// `<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />`
  /// or `<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />`
  /// to your `AndroidManifest.xml` file. `ACCESS_COARSE_LOCATION` returns a
  /// location with an accuracy approximately equivalent to a city block, while
  /// `ACCESS_FINE_LOCATION` returns as precise a location as possible, although
  /// it consumes more battery power. You will also need to request these
  /// permissions during run-time. If they are not granted, the My Location
  /// feature will fail silently.
  /// * On iOS add a `NSLocationWhenInUseUsageDescription` key to your
  /// `Info.plist` file. This will automatically prompt the user for permissions
  /// when the map tries to turn on the My Location layer.
  final bool myLocationEnabled;

  /// Enables or disables the my-location button.
  ///
  /// The my-location button causes the camera to move such that the user's
  /// location is in the center of the map. If the button is enabled, it is
  /// only shown when the my-location layer is enabled.
  ///
  /// By default, the my-location button is enabled (and hence shown when the
  /// my-location layer is enabled).
  ///
  /// See also:
  ///   * [myLocationEnabled] parameter.
  final bool myLocationButtonEnabled;

  /// Enables or disables the indoor view from the map
  final bool indoorViewEnabled;

  /// Enables or disables the traffic layer of the map
  final bool trafficEnabled;

  /// Enables or disables showing 3D buildings where available
  final bool buildingsEnabled;

  final WebGestureHandling? webGestureHandling;

  /// Which gestures should be consumed by the map.
  ///
  /// It is possible for other gesture recognizers to be competing with the map on pointer
  /// events, e.g if the map is inside a [ListView] the [ListView] will want to handle
  /// vertical drags. The map will claim gestures that are recognized by any of the
  /// recognizers on this list.
  ///
  /// When this set is empty, the map will only handle pointer events for gestures that
  /// were not claimed by any other gesture recognizer.
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;

  // final List<WidgetMarker> widgetMarkers;
  final Map<MarkerId, WidgetMarker> widgetMarkers;

  /// Heatmaps to show on the map.
  final Set<Heatmap> heatmaps;

  /// The style for the map.
  ///
  /// Set to null to clear any previous custom styling.
  ///
  /// If problems were detected with the [mapStyle], including un-parsable
  /// styling JSON, unrecognized feature type, unrecognized element type, or
  /// invalid styler keys, the style is left unchanged, and the error can be
  /// retrieved with [GoogleMapController.getStyleError].
  ///
  /// The style string can be generated using the
  /// [map style tool](https://mapstyle.withgoogle.com/).
  final String? style;

  /// Cluster Managers to be initialized for the map.
  ///
  /// On the web, an extra step is required to enable clusters.
  /// See https://pub.dev/packages/google_maps_flutter_web.
  final Set<ClusterManager> clusterManagers;

  /// if true will use [WidgetMarkerCache] to repaint the marker in a new location
  /// it is useful when the marker is moved to a new location but its visual state did not change, Note that the [WidgetMarkerCache] is managed in a global scope so it may cause problems if multiples maps are handled at once.
  /// It is managed in a global scope to allow clearing of its cache at any moment
  final bool useCache;

  const WidgetMarkerGoogleMap({
    super.key,
    required this.initialCameraPosition,
    this.onMapCreated,
    this.gestureRecognizers = const <Factory<OneSequenceGestureRecognizer>>{},
    this.compassEnabled = true,
    this.mapToolbarEnabled = true,
    this.cameraTargetBounds = CameraTargetBounds.unbounded,
    this.mapType = MapType.normal,
    this.minMaxZoomPreference = MinMaxZoomPreference.unbounded,
    this.rotateGesturesEnabled = true,
    this.scrollGesturesEnabled = true,
    this.zoomControlsEnabled = true,
    this.zoomGesturesEnabled = true,
    this.liteModeEnabled = false,
    this.tiltGesturesEnabled = true,
    this.myLocationEnabled = false,
    this.myLocationButtonEnabled = true,
    this.layoutDirection,

    /// If no padding is specified default padding will be 0.
    this.padding = const EdgeInsets.all(0),
    this.indoorViewEnabled = false,
    this.trafficEnabled = false,
    this.buildingsEnabled = true,
    this.markers = const <MarkerId, Marker>{},
    this.widgetMarkers = const <MarkerId, WidgetMarker>{},
    this.polygons = const <Polygon>{},
    this.polylines = const <Polyline>{},
    this.circles = const <Circle>{},
    this.onCameraMoveStarted,
    this.tileOverlays = const <TileOverlay>{},
    this.onCameraMove,
    this.onCameraIdle,
    this.onTap,
    this.onLongPress,
    this.cloudMapId,
    this.webGestureHandling,
    this.style,
    this.clusterManagers = const <ClusterManager>{},
    this.fortyFiveDegreeImageryEnabled = false,
    this.heatmaps = const <Heatmap>{},
    this.useCache = false,
  });

  @override
  State<WidgetMarkerGoogleMap> createState() => _WidgetMarkerGoogleMapState();
}

/// Helper class to keep cache of the generated markers images
class WidgetMarkerCache {
  /// Variable to maintain cache of the generated marker images
  static Map<MarkerId, BitmapDescriptor> _allGeneratedMarkersIcons =
      <MarkerId, BitmapDescriptor>{};

  /// Remove a marker by its markerId
  static void removeMarker(MarkerId markerId) {
    _allGeneratedMarkersIcons.remove(markerId);
  }

  /// Clear all markers
  static void clearAllMarkers() {
    _allGeneratedMarkersIcons = {};
  }

  static BitmapDescriptor? getMarkerBitmap(MarkerId markerId) {
    return _allGeneratedMarkersIcons[markerId];
  }

  static void setMarkerBitmap({
    required MarkerId markerId,
    required BitmapDescriptor bitmap,
  }) {
    _allGeneratedMarkersIcons[markerId] = bitmap;
  }
}

class _WidgetMarkerGoogleMapState extends State<WidgetMarkerGoogleMap> {
  /// widget markers props
  Map<MarkerId, WidgetMarker> get parentWidgetMarkers => widget.widgetMarkers;

  /// compiled markers
  Map<MarkerId, Marker> _markers = {};

  /// plain markers
  Map<MarkerId, Marker> get rawMarkers => widget.markers;

  List<WidgetMarker> widgetMarkersToGenerate = [];

  /// value notifier for updates on the widget markers
  final ValueNotifier<Map<MarkerId, WidgetMarker>> notifier = ValueNotifier({});

  /// value notifier for plain markers
  final ValueNotifier<Map<MarkerId, Marker>> plainNotifier = ValueNotifier({});

  @override
  void initState() {
    notifier.addListener(() {
      _updateMarkers();
    });
    plainNotifier.addListener(() {
      _updateMarkers();
    });

    super.initState();
  }

  /// to force update markers
  void emptyGeneratedMarkers() {
    WidgetMarkerCache.clearAllMarkers();
    _updateMarkers();
  }

  void _updateMarkers() {
    widgetMarkersToGenerate = [];
    _markers = {};
    _markers.addAll(rawMarkers);

    if (!widget.useCache) {
      // if no cache is used, we need to generate all markers
      widgetMarkersToGenerate = List.from(parentWidgetMarkers.values);
      setState(() {});
      return;
    }

    for (final entry in parentWidgetMarkers.entries) {
      if (WidgetMarkerCache.getMarkerBitmap(entry.key) == null) {
        widgetMarkersToGenerate.add(entry.value);
      } else {
        _markers[entry.key] = markerFromWidgetMarkerWithIcon(
          widgetMarker: entry.value,
          icon: WidgetMarkerCache.getMarkerBitmap(entry.key)!,
        );
      }
    }
    widgetMarkersToGenerate = List.from(widgetMarkersToGenerate);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    notifier.value = parentWidgetMarkers;
    plainNotifier.value = rawMarkers;

    return Stack(
      children: [
        if (widget.widgetMarkers.isNotEmpty)
          MarkerGenerator(
            widgetMarkers: widgetMarkersToGenerate,
            onMarkerGenerated: (generatedMarkers) {
              for (final generatedMarker in generatedMarkers) {
                WidgetMarkerCache.setMarkerBitmap(
                  markerId: generatedMarker.markerId,
                  bitmap: generatedMarker.icon,
                );
                _markers[generatedMarker.markerId] = generatedMarker;
              }
              Future.delayed(Duration.zero, () {
                // delay set state to make sure it is called last in the frame
                setState(() {});
              });
            },
          ),
        GoogleMap(
          key: widget.key,
          markers: parentWidgetMarkers.isNotEmpty
              ? _markers.values.toSet()
              : widget.markers.values.toSet(),
          webGestureHandling: widget.webGestureHandling,
          initialCameraPosition: widget.initialCameraPosition,
          onMapCreated: widget.onMapCreated,
          gestureRecognizers: widget.gestureRecognizers,
          compassEnabled: widget.compassEnabled,
          mapToolbarEnabled: widget.mapToolbarEnabled,
          cameraTargetBounds: widget.cameraTargetBounds,
          mapType: widget.mapType,
          minMaxZoomPreference: widget.minMaxZoomPreference,
          rotateGesturesEnabled: widget.rotateGesturesEnabled,
          scrollGesturesEnabled: widget.scrollGesturesEnabled,
          zoomControlsEnabled: widget.zoomControlsEnabled,
          zoomGesturesEnabled: widget.zoomGesturesEnabled,
          liteModeEnabled: widget.liteModeEnabled,
          tiltGesturesEnabled: widget.tiltGesturesEnabled,
          myLocationEnabled: widget.myLocationEnabled,
          myLocationButtonEnabled: widget.myLocationButtonEnabled,
          layoutDirection: widget.layoutDirection,
          padding: widget.padding,
          indoorViewEnabled: widget.indoorViewEnabled,
          trafficEnabled: widget.trafficEnabled,
          buildingsEnabled: widget.buildingsEnabled,
          polygons: widget.polygons,
          polylines: widget.polylines,
          circles: widget.circles,
          onCameraMoveStarted: widget.onCameraMoveStarted,
          tileOverlays: widget.tileOverlays,
          onCameraMove: widget.onCameraMove,
          onCameraIdle: widget.onCameraIdle,
          onTap: widget.onTap,
          onLongPress: widget.onLongPress,
          cloudMapId: widget.cloudMapId,
          fortyFiveDegreeImageryEnabled: widget.fortyFiveDegreeImageryEnabled,
          heatmaps: widget.heatmaps,
          style: widget.style,
          clusterManagers: widget.clusterManagers,
        ),
      ],
    );
  }

  Marker markerFromWidgetMarkerWithIcon({
    required WidgetMarker widgetMarker,
    required BitmapDescriptor icon,
  }) {
    return Marker(
      onTap: widgetMarker.onTap,
      markerId: MarkerId(widgetMarker.markerId),
      position: widgetMarker.position,
      icon: icon,
      draggable: widgetMarker.draggable,
      infoWindow: widgetMarker.infoWindow,
      rotation: widgetMarker.rotation,
      visible: widgetMarker.visible,
      zIndex: widgetMarker.zIndex,
      onDragStart: widgetMarker.onDragStart,
      onDragEnd: widgetMarker.onDragEnd,
      onDrag: widgetMarker.onDrag,
      flat: widgetMarker.flat,
      anchor: widgetMarker.anchor,
      alpha: widgetMarker.alpha,
      consumeTapEvents: widgetMarker.consumeTapEvents,
      clusterManagerId: widgetMarker.clusterManagerId,
    );
  }

  Map<MarkerId, Marker> getMarkers() {
    return _markers;
  }
}
