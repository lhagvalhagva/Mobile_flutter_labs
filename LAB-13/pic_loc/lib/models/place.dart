import 'dart:io';

import 'package:uuid/uuid.dart';
class PlaceLocation{
  PlaceLocation({required this.latitude , required this.longitude});
  final double latitude;
  final double longitude;
}
const puid = Uuid();
class Place {

  Place({required this.title , required this.image ,required this.location}):id=puid.v4();
  final String id;
  final String title;
  File image;
  PlaceLocation location;
}
