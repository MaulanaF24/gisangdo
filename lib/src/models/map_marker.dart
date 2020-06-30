import 'dart:ui';

import 'package:fluster/fluster.dart';
import 'package:flutter/material.dart';
import 'package:gisangdo/src/utilities/icon_generator.dart';
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
        icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(16, 16)), imageUrl.toWeatherIcon()),
      );
}
