import 'package:fluster/fluster.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gisangdo/src/models/map_marker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const DEFAULT_CENTER = LatLng(-6.117664, 106.906349);

class ClusterGoogleMap extends StatefulWidget {
  final ClusterGoogleMapController controller;
  final LatLng center;
  final List<Marker> markerList;

  ClusterGoogleMap({
    this.controller,
    this.markerList,
    this.center = DEFAULT_CENTER,
    Key key,
  }) : super(key: key);

  @override
  _ClusterGoogleMapState createState() => _ClusterGoogleMapState();
}

class _ClusterGoogleMapState extends State<ClusterGoogleMap> {
  Fluster<MapMarker> _fluster;
  List<Marker> _markerList = [];

  // ignore: unused_field
  GoogleMapController _mapController;
  double _currentZoom = 12.0;

  _ClusterGoogleMapState();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      _initFluster(widget.controller.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        myLocationEnabled: true,
        onMapCreated: _onMapCreated,
        onCameraMove: _onCameraMove,
        onCameraIdle: _onCameraIdle,
        markers: Set<Marker>.of(widget.markerList),
        initialCameraPosition: CameraPosition(
          target: widget.center,
          zoom: _currentZoom,
        ),
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
          new Factory<OneSequenceGestureRecognizer>(
                () => new EagerGestureRecognizer(),
          ),
        ].toSet());
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _initFluster(widget.controller.value);
  }

  void _onCameraMove(CameraPosition cameraPosition) {
    _currentZoom = cameraPosition.zoom;
  }

  void _onCameraIdle() async {
    await _doCluster();
  }

  void _initFluster(List<MapMarker> mapMarkerList) {
    _fluster = Fluster<MapMarker>(
      minZoom: 0,
      maxZoom: 21,
      radius: 256,
      extent: 2048,
      nodeSize: 64,
      points: mapMarkerList,
      createCluster: (BaseCluster cluster,
          double lng,
          double lat,) =>
          mapMarkerList
              .firstWhere((marker) => marker.id == cluster.childMarkerId)
              .toCluster(cluster),
    );
    _doCluster();
  }

  Future<void> _doCluster() async {
    final List<Marker> markerList = [];
    await Future.forEach(
        _fluster.clusters([-180, -85, 180, 85], _currentZoom.round()),
            (MapMarker mapMarker) async {
          final marker = await mapMarker.toMarker(
              mapMarker.pointsSize, Theme
              .of(context)
              .accentColor);
          markerList.add(marker);
        });
    setState(() {
      _markerList = markerList;
    });
  }
}

class ClusterGoogleMapController extends ValueNotifier<List<MapMarker>> {
  ClusterGoogleMapController({List<MapMarker> initialValue = const []})
      : super(initialValue);
}
