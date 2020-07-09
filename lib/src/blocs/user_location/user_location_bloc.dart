import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gisangdo/src/blocs/user_location/user_location_event.dart';
import 'package:gisangdo/src/blocs/user_location/user_location_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

export 'package:gisangdo/src/blocs/user_location/user_location_event.dart';
export 'package:gisangdo/src/blocs/user_location/user_location_state.dart';

class UserLocationBloc extends Bloc<UserLocationEvent, UserLocationState> {
  Geolocator _geolocation = Geolocator();
  Position position;
  GeolocationStatus geolocationStatus;

  @override
  UserLocationState get initialState => InitialUserLocationState();

  @override
  Stream<UserLocationState> mapEventToState(UserLocationEvent event) async* {
    if (event is GetUserLocation) {
      yield* mapGetUserLocationToState(event);
    }
  }

  Stream<UserLocationState> mapGetUserLocationToState(
      GetUserLocation event) async* {
    try {
      PermissionStatus permission = await Permission.location.request();
      if (permission == PermissionStatus.granted) {
        position = await _geolocation.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        geolocationStatus = await _geolocation.checkGeolocationPermissionStatus();
        if(geolocationStatus.value == 2){
          print("user location : ${position.latitude} , ${position.longitude}");
          yield ShowUserLocation(LatLng(position.latitude,position.longitude));
        }
      }
    } catch (e) {
      yield FailedUserLocation(e);
    }
  }
}