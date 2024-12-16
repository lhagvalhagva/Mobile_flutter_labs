import 'dart:io';

import 'package:path/path.dart';

import '../models/place.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class Provider_Place extends ChangeNotifier{
  List<Place> userPlaces = [];

  Future<Database> _getDatabase() async{
    final db = await openDatabase(
      join(await getDatabasesPath(), 'user_places.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lon REAL)',
        );
      },
      version: 1,
    );
    return db;
  }

  Future<void> loadPlaces() async{
    final db = await _getDatabase();
    final data = await db.query('places');
    final places = data.map((row) => Place(
      title: row['title'] as String,
      image: File(row['image'] as String),
      location: PlaceLocation(
        latitude: row['lat'] as double,
        longitude: row['lon'] as double,
      ),
    )).toList();
    
    userPlaces = places;
    notifyListeners();
  }

  void addPlace(Place place) async{
    final addDir = await syspath.getApplicationDocumentsDirectory();
    final filename = path.basename(place.image.path);
    final copiedimg = await place.image.copy('${addDir.path}/$filename');

    final db = await _getDatabase();

    await db.insert('places', {
      'id': place.id,
      'title': place.title,
      'image': copiedimg.path,
      'lat': place.location.latitude,
      'lon': place.location.longitude,
    });

    userPlaces.add(place);
    notifyListeners();
  }
}