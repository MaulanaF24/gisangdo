import 'dart:ui';
import 'dart:ui' as ui;

import 'package:fluster/fluster.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapMarker extends Clusterable {
  final String id;
  final LatLng position;
  final String imageUrl;

  MapMarker({
    @required this.id,
    @required this.position,
    @required this.imageUrl,
    isCluster = false,
    clusterId,
    pointsSize = 0,
    childMarkerId,
  }) : super(
          markerId: id,
          latitude: position.latitude,
          longitude: position.longitude,
          isCluster: isCluster,
          clusterId: clusterId,
          pointsSize: pointsSize,
          childMarkerId: childMarkerId,
        );

  MapMarker toCluster(BaseCluster cluster) => MapMarker(
        id: id,
        position: position,
        imageUrl: imageUrl,
        isCluster: cluster.isCluster,
        clusterId: cluster.id,
        pointsSize: cluster.pointsSize,
        childMarkerId: cluster.childMarkerId,
      );

  Future<Marker> toMarker(int clusterSize, Color color) async => Marker(
        markerId: MarkerId(id),
        position: LatLng(
          position.latitude,
          position.longitude,
        ),
        icon: await _createMarkerIcon(clusterSize, color),
      );

  Future<BitmapDescriptor> _createMarkerIcon(
      int clusterSize, Color color) async {
    final size = Size(128, 128);

    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final Radius radius = Radius.circular(size.width / 2);

    final Paint tagPaint = Paint()..color = color;
    final double tagWidth = 40.0;

    final Paint shadowPaint = Paint()..color = color.withAlpha(100);
    final double shadowWidth = 15.0;

    final Paint borderPaint = Paint()..color = Colors.white;
    final double borderWidth = 3.0;

    final double imageOffset = shadowWidth + borderWidth;

    // Add shadow circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0.0, 0.0, size.width, size.height),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        shadowPaint);

    // Add border circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(shadowWidth, shadowWidth,
              size.width - (shadowWidth * 2), size.height - (shadowWidth * 2)),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        borderPaint);

    if (clusterSize > 1) {
      // Add tag circle
      canvas.drawRRect(
          RRect.fromRectAndCorners(
            Rect.fromLTWH(size.width - tagWidth, 0.0, tagWidth, tagWidth),
            topLeft: radius,
            topRight: radius,
            bottomLeft: radius,
            bottomRight: radius,
          ),
          tagPaint);

      // Add tag text
      TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
      textPainter.text = TextSpan(
        text: clusterSize.toString(),
        style: TextStyle(fontSize: 20.0, color: Colors.white),
      );

      textPainter.layout();
      textPainter.paint(
          canvas,
          Offset(size.width - tagWidth / 2 - textPainter.width / 2,
              tagWidth / 2 - textPainter.height / 2));
    }

    // Oval for the image
    Rect oval = Rect.fromLTWH(imageOffset, imageOffset,
        size.width - (imageOffset * 2), size.height - (imageOffset * 2));

    // Add path for oval image
    canvas.clipPath(Path()..addOval(oval));

    // Add image
//    ui.Image image =
//        frameInfo.image; // Alternatively use your own method to get the image
//    paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.fitWidth);

    // Convert canvas to image
    final ui.Image markerAsImage = await pictureRecorder
        .endRecording()
        .toImage(size.width.toInt(), size.height.toInt());

    final byteData =
        await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
    final uint8List = byteData.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(uint8List);
  }
}
