import 'package:flutter/cupertino.dart';

@immutable
abstract class UserLocationEvent{}

class GetUserLocation extends UserLocationEvent{
  @override
  String toString() => 'Get User Location';
}