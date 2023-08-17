import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/routes/routes.dart';
import 'package:shining_india_survey/surveyor/survey_screen.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  final nameController = TextEditingController();
  final villageController = TextEditingController();
  final districtController = TextEditingController();
  final pinController = TextEditingController();

  int _dropDownAgeValue = 50;

  String _dropDownGenderValue = 'Male';
  List<String> items = ['Male', 'Female', 'Others'];

  String _dropDownStateValue = 'Delhi';
  List<String> states = [
    'Andaman and Nicobar Islands',
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Dadra and Nagar Haveli and Daman and Diu',
    'Delhi',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Ladakh',
    'Lakshadweep',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Puducherry',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal'
  ];

  final _formKey = GlobalKey<FormState>();

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
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        28.503451,77.417321, localeIdentifier: 'en_IN')
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Details',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 10,),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Basic',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: 10,),
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
                              items: items.map<DropdownMenuItem<String>>((String item) {
                                return DropdownMenuItem<String>(
                                  child: Text(item),
                                  value: item
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _dropDownGenderValue = value ?? '';
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Address',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _getCurrentPosition,
                      child: const Text("Get Current Location"),
                    )
                  ],
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: villageController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Village',
                      prefixIcon: Icon(Icons.holiday_village_rounded)
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: districtController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'District',
                      prefixIcon: Icon(Icons.share_location_rounded)
                  ),
                ),
                SizedBox(height: 10,),
                DropdownButtonFormField(
                  isExpanded: true,
                  decoration: InputDecoration(
                      labelText: 'State',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_city)
                  ),
                  value: _dropDownStateValue,
                  items: states.map<DropdownMenuItem<String>>((String item) {
                    return DropdownMenuItem<String>(
                        child: Text(item),
                        value: item
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _dropDownStateValue = value ?? '';
                      print(value);
                    });
                  },
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: pinController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'PIN Code',
                      prefixIcon: Icon(Icons.power_input_outlined)
                  ),
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50)
                  ),
                  onPressed: (){
                    context.push(RouteNames.surveyScreen);
                  },
                  child: Text(
                      'Start Survey'
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
