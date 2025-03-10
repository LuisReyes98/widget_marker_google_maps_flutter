import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WidgetMarker {
  const WidgetMarker({
    required this.position,
    required this.markerId,
    this.onTap,
    required this.widget,
    this.draggable = false,
    this.infoWindow = InfoWindow.noText,
    this.rotation = 0.0,
    this.visible = true,
    this.zIndex = 0.0,
    this.onDrag,
    this.onDragStart,
    this.onDragEnd,
    this.clusterManagerId,
    this.alpha = 1.0,
    this.anchor = const Offset(0.5, 1.0),
    this.flat = false,
    this.consumeTapEvents = false,
  }) : assert(markerId != '');

  final LatLng position;

  /// This has to be unique,otherwise it will not be shown.
  final String markerId;

  /// Gestures of widget is disabled.
  /// Use this callback instead.
  final VoidCallback? onTap;

  final Widget widget;

  /// True if the marker is draggable by user touch events.
  final bool draggable;

  /// True if the marker is rendered flatly against the surface of the Earth, so
  /// A Google Maps InfoWindow.
  ///
  /// The window is displayed when the marker is tapped.
  final InfoWindow infoWindow;

  /// Rotation of the marker image in degrees clockwise from the [anchor] point.
  final double rotation;

  /// True if the marker is visible.
  final bool visible;

  /// The z-index of the marker, used to determine relative drawing order of
  /// map overlays.
  ///
  /// Overlays are drawn in order of z-index, so that lower values means drawn
  /// earlier, and thus appearing to be closer to the surface of the Earth.
  final double zIndex;

  /// Signature reporting the new [LatLng] at the start of a drag event.
  final ValueChanged<LatLng>? onDragStart;

  /// Signature reporting the new [LatLng] at the end of a drag event.
  final ValueChanged<LatLng>? onDragEnd;

  /// Signature reporting the new [LatLng] during the drag event.
  final ValueChanged<LatLng>? onDrag;

  /// Marker clustering is managed by [ClusterManager] with [clusterManagerId].
  final ClusterManagerId? clusterManagerId;

  /// The opacity of the marker, between 0.0 and 1.0 inclusive.
  ///
  /// 0.0 means fully transparent, 1.0 means fully opaque.
  final double alpha;

  /// The icon image point that will be placed at the [position] of the marker.
  ///
  /// The image point is specified in normalized coordinates: An anchor of
  /// (0.0, 0.0) means the top left corner of the image. An anchor
  /// of (1.0, 1.0) means the bottom right corner of the image.
  final Offset anchor;

  /// True if the marker is rendered flatly against the surface of the Earth, so
  /// that it will rotate and tilt along with map camera movements.
  final bool flat;

  /// True if the marker icon consumes tap events. If not, the map will perform
  /// default tap handling by centering the map on the marker and displaying its
  /// info window.
  final bool consumeTapEvents;

  WidgetMarker copyWith({
    LatLng? position,
    String? markerId,
    VoidCallback? onTap,
    Widget? widget,
    bool? draggable,
    InfoWindow? infoWindow,
    double? rotation,
    bool? visible,
    double? zIndex,
    ValueChanged<LatLng>? onDragStart,
    ValueChanged<LatLng>? onDragEnd,
    ValueChanged<LatLng>? onDrag,
    ClusterManagerId? clusterManagerId,
    double? alpha,
    Offset? anchor,
    bool? flat,
    bool? consumeTapEvents,
  }) {
    return WidgetMarker(
      position: position ?? this.position,
      markerId: markerId ?? this.markerId,
      onTap: onTap ?? this.onTap,
      widget: widget ?? this.widget,
      draggable: draggable ?? this.draggable,
      infoWindow: infoWindow ?? this.infoWindow,
      rotation: rotation ?? this.rotation,
      visible: visible ?? this.visible,
      zIndex: zIndex ?? this.zIndex,
      onDragStart: onDragStart ?? this.onDragStart,
      onDragEnd: onDragEnd ?? this.onDragEnd,
      onDrag: onDrag ?? this.onDrag,
      clusterManagerId: clusterManagerId ?? this.clusterManagerId,
      alpha: alpha ?? this.alpha,
      anchor: anchor ?? this.anchor,
      flat: flat ?? this.flat,
      consumeTapEvents: consumeTapEvents ?? this.consumeTapEvents,
    );
  }

  @override
  String toString() {
    return 'WidgetMarker(position: $position, markerId: $markerId, onTap: $onTap, widget: $widget, draggable: $draggable, infoWindow: $infoWindow, rotation: $rotation, visible: $visible, zIndex: $zIndex, onDragStart: $onDragStart, onDragEnd: $onDragEnd, onDrag: $onDrag)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is WidgetMarker &&
            other.position == position &&
            other.markerId == markerId &&
            other.onTap == onTap &&
            other.widget == widget &&
            other.draggable == draggable &&
            other.infoWindow == infoWindow &&
            other.rotation == rotation &&
            other.visible == visible &&
            other.zIndex == zIndex &&
            other.onDragStart == onDragStart &&
            other.onDragEnd == onDragEnd &&
            other.onDrag == onDrag &&
            other.clusterManagerId == clusterManagerId &&
            other.alpha == alpha &&
            other.anchor == anchor &&
            other.flat == flat &&
            other.consumeTapEvents == consumeTapEvents;
  }

  @override
  int get hashCode {
    return position.hashCode ^
        markerId.hashCode ^
        onTap.hashCode ^
        widget.hashCode ^
        draggable.hashCode ^
        infoWindow.hashCode ^
        rotation.hashCode ^
        visible.hashCode ^
        zIndex.hashCode ^
        onDragStart.hashCode ^
        onDragEnd.hashCode ^
        onDrag.hashCode ^
        clusterManagerId.hashCode ^
        alpha.hashCode ^
        anchor.hashCode ^
        flat.hashCode ^
        consumeTapEvents.hashCode;
  }
}
