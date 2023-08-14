import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  final nameController = TextEditingController();

  int _dropDownGenderValue = 0;
  int _dropDownAgeValue = 50;
  List<String> items = ['Male', 'Female', 'Others'];

  String? _currentAddress;
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services'
          )
        )
      );
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      print(placemarks.length);
      setState(() {
        _currentAddress =
          'Name = ${place.name}\n'
          'Sublocality = ${place.subLocality}\n'
          'subAdministrative Area = ${place.subAdministrativeArea}\n'
          'Postal Code = ${place.postalCode}\n'
          'Administrative Area = ${place.administrativeArea}\n'
          'Street = ${place.street}\n'
          'isoCountryCode = ${place.isoCountryCode}\n'
          'Locality = ${place.locality}\n'
          'subThroughfare = ${place.subThoroughfare}\n'
          'throughfare = ${place.thoroughfare}\n';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                child: Text(
                  'Details Screen',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                          prefixIcon: Icon(Icons.person)
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              labelText: 'Gender',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.person)
                            ),
                            value: _dropDownGenderValue,
                            items: [
                              DropdownMenuItem(
                                child: Text('Male'),
                                value: 0,
                              ),
                              DropdownMenuItem(
                                child: Text('Female'),
                                value: 1,
                              ),
                              DropdownMenuItem(
                                child: Text('Others'),
                                value: 2,
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _dropDownGenderValue = value ?? 0;
                                print(value);
                              });
                            },
                          )
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                                labelText: 'Age',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person)
                            ),
                            value: _dropDownAgeValue,
                            items: List.generate(120, (i) => i+1)
                              .map<DropdownMenuItem<int>>((int val) {
                                return DropdownMenuItem<int>(
                                  value: val,
                                  child: Text(val.toString()),
                                );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _dropDownAgeValue = value ?? 0;
                                print(value);
                              });
                            },
                          )
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Text('LAT: ${_currentPosition?.latitude ?? ""}'),
              Text('LNG: ${_currentPosition?.longitude ?? ""}'),
              Text(_currentAddress ?? "", textAlign: TextAlign.center,),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _getCurrentPosition,
                child: const Text("Get Current Location"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
