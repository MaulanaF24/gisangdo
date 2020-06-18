import 'package:flutter/cupertino.dart';
import 'package:gisangdo/src/utilities/cluster_google_map.dart';

class Maps extends StatefulWidget {

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> with AutomaticKeepAliveClientMixin {
  ClusterGoogleMapController _clusterGoogleMapController =
      ClusterGoogleMapController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: <Widget>[
        Expanded(
            child: ClusterGoogleMap(
            controller: _clusterGoogleMapController,
        )),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
