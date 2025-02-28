import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

import '../../widget_marker_google_maps_flutter.dart';

class MarkerGenerator extends StatefulWidget {
  const MarkerGenerator({
    super.key,
    required this.widgetMarkers,
    required this.onMarkerGenerated,
  });
  final List<WidgetMarker> widgetMarkers;
  final ValueChanged<List<Marker>> onMarkerGenerated;

  @override
  State<MarkerGenerator> createState() => _MarkerGeneratorState();

  static double getDevicePixelRatio(BuildContext context) {
    final double rawRatio = MediaQuery.devicePixelRatioOf(context);

    /// If it is web on desktop or Phone
    /// The device pixelRatio to use is 1
    /// else it will return the device pixel ratio
    return kIsWeb ? 1 : rawRatio;
  }
}

class _MarkerGeneratorState extends State<MarkerGenerator> {
  List<GlobalKey> globalKeys = [];
  List<WidgetMarker> lastMarkers = [];

  Future<Marker> _convertToMarker(GlobalKey key) async {
    final pixelRatio = MediaQuery.devicePixelRatioOf(context);

    /// Forced delay to give time for images to render on [Image] widgets.
    await Future.delayed(const Duration(milliseconds: 500));
    RenderRepaintBoundary boundary =
        key.currentContext!.findRenderObject()! as RenderRepaintBoundary;

    final image = await boundary.toImage(pixelRatio: 2);
    final byteData =
        await image.toByteData(format: ImageByteFormat.png) ?? ByteData(0);
    final uint8List = byteData.buffer.asUint8List();
    final widgetMarker = widget.widgetMarkers[globalKeys.indexOf(key)];

    /// Dont do bitmapScaling if is web integration, in the case that it is Safari using bitmapScaling will cause Safari to run out of memory and crash, and on other web integrations it is made work by using the imagePixelRatio
    MapBitmapScaling bitmapScaling =
        kIsWeb ? MapBitmapScaling.none : MapBitmapScaling.auto;
    double? imagePixelRatio = kIsWeb ? null : pixelRatio;

    return Marker(
      onTap: widgetMarker.onTap,
      markerId: MarkerId(widgetMarker.markerId),
      position: widgetMarker.position,
      alpha: widgetMarker.alpha,
      anchor: widgetMarker.anchor,
      flat: widgetMarker.flat,
      clusterManagerId: widgetMarker.clusterManagerId,
      consumeTapEvents: widgetMarker.consumeTapEvents,
      icon: BitmapDescriptor.bytes(
        uint8List,
        bitmapScaling: bitmapScaling,
        imagePixelRatio: imagePixelRatio,
      ),
      draggable: widgetMarker.draggable,
      infoWindow: widgetMarker.infoWindow,
      rotation: widgetMarker.rotation,
      visible: widgetMarker.visible,
      zIndex: widgetMarker.zIndex,
      onDragStart: widgetMarker.onDragStart,
      onDragEnd: widgetMarker.onDragEnd,
      onDrag: widgetMarker.onDrag,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => onBuildCompleted());
  }

  @override
  void didUpdateWidget(MarkerGenerator oldWidget) {
    if (oldWidget.widgetMarkers != widget.widgetMarkers &&
        widget.widgetMarkers.isNotEmpty) {
      /// To force that changes on state are reflected on the map immediately
      WidgetsBinding.instance.addPostFrameCallback((_) => onBuildCompleted());
    }

    super.didUpdateWidget(oldWidget);
  }

  Future<void> onBuildCompleted() async {
    /// Skip when there's no change in widgetMarkers.
    if (lastMarkers == widget.widgetMarkers) {
      return;
    }
    lastMarkers = widget.widgetMarkers;
    final markers =
        await Future.wait(globalKeys.map((key) => _convertToMarker(key)));
    widget.onMarkerGenerated.call(markers);
  }

  @override
  Widget build(BuildContext context) {
    globalKeys = [];
    return Transform.translate(
      /// Place markers outside of screens
      /// To hide them in case the map becomes transparent.
      offset: Offset(
        -MediaQuery.of(context).size.width,
        -MediaQuery.of(context).size.height,
      ),
      child: Stack(
        children: widget.widgetMarkers.map(
          (widgetMarker) {
            final key = GlobalKey();
            globalKeys.add(key);
            return RepaintBoundary(
              key: key,
              child: widgetMarker.widget,
            );
          },
        ).toList(),
      ),
    );
  }
}
