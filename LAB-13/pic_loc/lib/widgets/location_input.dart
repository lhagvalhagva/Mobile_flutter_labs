import 'package:file_access/models/place.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onSelectLocation});

  final void Function(PlaceLocation location) onSelectLocation;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String data = '';
  PlaceLocation? _pickedLocation;

  void _getLocation() async {
    try {
      Location locationService = Location();

      bool _serviceEnabled;
      PermissionStatus _permissionGranted;
      LocationData _locationData;

      _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          setState(() {
            data = 'Location service is disabled';
          });
          return;
        }
      }

      _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          setState(() {
            data = 'Location permission denied';
          });
          return;
        }
      }

      setState(() {
        data = 'Getting location...';
      });

      _locationData = await locationService.getLocation();
      
      if (_locationData.latitude == null || _locationData.longitude == null) {
        setState(() {
          data = 'Failed to get location data';
        });
        return;
      }

      final pickedLocation = PlaceLocation(
        latitude: _locationData.latitude!,
        longitude: _locationData.longitude!,
      );
      
      setState(() {
        data = 'Lat: ${_locationData.latitude}, Long: ${_locationData.longitude}';
        _pickedLocation = pickedLocation;
      });

      widget.onSelectLocation(pickedLocation);
    } catch (e) {
      setState(() {
        data = 'Error getting location: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton.icon(
            onPressed: _getLocation,
            icon: const Icon(Icons.location_on),
            label: const Text('Get Location'),
          ),
          const SizedBox(height: 10),
          if (data.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                data,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
