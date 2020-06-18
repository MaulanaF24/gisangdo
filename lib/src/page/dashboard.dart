import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gisangdo/src/blocs/user_location/user_location_bloc.dart';
import 'package:gisangdo/src/page/forecast.dart';
import 'package:gisangdo/src/page/maps.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserLocationBloc>(context).add(GetUserLocation());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Gisangdo"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              )
            ],
          ),
          body: BlocBuilder<UserLocationBloc, UserLocationState>(
            builder: (context, state) {
              if (state is ShowUserLocation) {
                return Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                      child: TabBar(
                        indicatorColor: Theme.of(context).primaryColor,
                        indicatorSize: TabBarIndicatorSize.label,
                        unselectedLabelColor: Colors.grey,
                        isScrollable: true,
                        labelColor: Theme.of(context).accentColor,
                        labelPadding: EdgeInsets.fromLTRB(60, 0, 60, 0),
                        tabs: <Widget>[
                          Tab(text: "Maps"),
                          Tab(text: "Forecast"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: <Widget>[Maps(), Forecast()],
                      ),
                    ),
                  ],
                );
              }
              return Container(
                child: Text("GOBLOK"),
              );
            },
          )),
    );
  }
}
