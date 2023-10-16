import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/modules/survey/core/bloc/survey_bloc.dart';
import 'package:shining_india_survey/routes/routes.dart';
import 'package:shining_india_survey/modules/survey/ui/survey_screen.dart';
import 'package:shining_india_survey/utils/app_colors.dart';
import 'package:shining_india_survey/utils/array_res.dart';
import 'package:shining_india_survey/utils/back_button.dart';
import 'package:shining_india_survey/utils/custom_button.dart';
import 'package:shining_india_survey/utils/loading_indicator.dart';

import '../core/models/location_model.dart';

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
  String _dropDownGenderValue = ArrayResources.genders[0];
  String _dropDownStateValue = ArrayResources.states[0];
  bool _checkBoxValue = false;

  final _formKey = GlobalKey<FormState>();

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
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

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    context.read<SurveyBloc>().add(FetchLocationFromLatLngEvent(latitude: position.latitude, longitude: position.longitude));

  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    villageController.dispose();
    districtController.dispose();
    pinController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final outlineBorder = OutlineInputBorder(
        borderSide: const BorderSide(
            color: AppColors.lightBlack
        ),
        borderRadius: BorderRadius.circular(16)
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: BlocConsumer<SurveyBloc, SurveyState>(
          listener: (context, state) {
            if (state is SurveyErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Error occurred')));
            } else if (state is SurveyDataFetchedState) {
              context.go(RouteNames.surveyScreen);
            } else if (state is SurveyLocationFetchedState) {
              pinController.text = state.pinCode;
              districtController.text = state.district;
              villageController.text = state.village;
              _dropDownStateValue = state.state ?? '';
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomBackButton(
                          onTap: (){
                            context.pop();
                          },
                        ),
                        SizedBox(width: 16,),
                        Expanded(
                          child: Text(
                            'Add details',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 28,
                                color: AppColors.black,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Basic',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            ValueListenableBuilder(
                              valueListenable: nameController,
                              builder: (context, value, child) {
                                return TextFormField(
                                    controller: nameController,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      color: AppColors.textBlack
                                    ),
                                    keyboardType: TextInputType.text,
                                    cursorColor: AppColors.lightBlack,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      labelText: 'Name',
                                      prefixIcon: const Icon(Icons.person_2_rounded, color: AppColors.textBlack,),
                                      labelStyle: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          color: AppColors.lightBlack
                                      ),
                                      border: outlineBorder,
                                      disabledBorder: outlineBorder,
                                      errorBorder: outlineBorder,
                                      focusedBorder: outlineBorder,
                                      focusedErrorBorder: outlineBorder,
                                      enabledBorder: outlineBorder,
                                    ),
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (name) {
                                      if (name == null || name.isEmpty) {
                                        return 'Please enter name';
                                      }
                                      return null;
                                    },
                                );
                              },
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: _checkBoxValue,
                                  onChanged: (value) {
                                    if(value != null) {
                                      setState(() {
                                        _checkBoxValue = value;
                                      });
                                      if(value) {
                                        nameController.text = 'Anonymous';
                                      } else if(!value){
                                        nameController.text = '';
                                      }
                                    }
                                  }
                                ),
                                const Text(
                                  'Filled as anonymous',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: AppColors.textBlack
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: DropdownButtonFormField(
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        labelText: 'Gender',
                                        prefixIcon: const Icon(Icons.person_2_rounded, color: AppColors.textBlack,),
                                        labelStyle: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                            color: AppColors.lightBlack
                                        ),
                                        border: outlineBorder,
                                        disabledBorder: outlineBorder,
                                        errorBorder: outlineBorder,
                                        focusedBorder: outlineBorder,
                                        focusedErrorBorder: outlineBorder,
                                        enabledBorder: outlineBorder,
                                      ),
                                  value: _dropDownGenderValue,
                                  items: ArrayResources.genders
                                      .map<DropdownMenuItem<String>>((String item) {
                                    return DropdownMenuItem<String>(
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 14,
                                              color: AppColors.textBlack
                                          ),
                                        ),
                                        value: item
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _dropDownGenderValue = value ?? '';
                                      print(value);
                                    });
                                  },
                                )),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: DropdownButtonFormField(
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        labelText: 'Age',
                                        prefixIcon: const Icon(Icons.person_2_rounded, color: AppColors.textBlack,),
                                        labelStyle: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                            color: AppColors.lightBlack
                                        ),
                                        border: outlineBorder,
                                        disabledBorder: outlineBorder,
                                        errorBorder: outlineBorder,
                                        focusedBorder: outlineBorder,
                                        focusedErrorBorder: outlineBorder,
                                        enabledBorder: outlineBorder,
                                      ),
                                  value: _dropDownAgeValue,
                                  items: List.generate(120, (i) => i + 1)
                                      .map<DropdownMenuItem<int>>((int val) {
                                    return DropdownMenuItem<int>(
                                      value: val,
                                      child: Text(
                                        val.toString(),
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          color: AppColors.textBlack
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _dropDownAgeValue = value ?? 0;
                                      print(value);
                                    });
                                  },
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Address',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    if(state is SurveyLoadingState) {
                                      null;
                                    } else {
                                      _getCurrentPosition();
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          AppColors.primaryBlue,
                                          AppColors.primaryBlueLight,
                                        ]
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.location_searching_rounded,
                                          size: 18,
                                          color: AppColors.primary,
                                        ),
                                        SizedBox(width: 4,),
                                        Text(
                                          'Locate',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Poppins',
                                            color: AppColors.primary
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ValueListenableBuilder(
                              valueListenable: villageController,
                              builder: (context, value, child) {
                                return TextFormField(
                                  controller: villageController,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      color: AppColors.textBlack
                                  ),
                                  keyboardType: TextInputType.text,
                                  cursorColor: AppColors.lightBlack,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelText: 'City / Village',
                                    prefixIcon: const Icon(Icons.holiday_village_rounded, color: AppColors.textBlack,),
                                    labelStyle: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: AppColors.lightBlack
                                    ),
                                    border: outlineBorder,
                                    disabledBorder: outlineBorder,
                                    errorBorder: outlineBorder,
                                    focusedBorder: outlineBorder,
                                    focusedErrorBorder: outlineBorder,
                                    enabledBorder: outlineBorder,
                                  ),
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: (village) {
                                    if (village == null || village.isEmpty) {
                                      return 'Please enter village';
                                    }
                                    return null;
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ValueListenableBuilder(
                              valueListenable: districtController,
                              builder: (context, value, child) {
                                return TextFormField(
                                  controller: districtController,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      color: AppColors.textBlack
                                  ),
                                  keyboardType: TextInputType.text,
                                  cursorColor: AppColors.lightBlack,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelText: 'District',
                                    prefixIcon: const Icon(Icons.share_location_rounded, color: AppColors.textBlack,),
                                    labelStyle: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: AppColors.lightBlack
                                    ),
                                    border: outlineBorder,
                                    disabledBorder: outlineBorder,
                                    errorBorder: outlineBorder,
                                    focusedBorder: outlineBorder,
                                    focusedErrorBorder: outlineBorder,
                                    enabledBorder: outlineBorder,
                                  ),
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: (district) {
                                    if (district == null || district.isEmpty) {
                                      return 'Please enter district';
                                    }
                                    return null;
                                  },
                                );
                              }
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DropdownButtonFormField(
                              isExpanded: true,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelText: 'State',
                                prefixIcon: const Icon(Icons.location_city_rounded, color: AppColors.textBlack,),
                                labelStyle: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    color: AppColors.lightBlack
                                ),
                                border: outlineBorder,
                                disabledBorder: outlineBorder,
                                errorBorder: outlineBorder,
                                focusedBorder: outlineBorder,
                                focusedErrorBorder: outlineBorder,
                                enabledBorder: outlineBorder,
                              ),
                              value: _dropDownStateValue,
                              items: ArrayResources.states
                                  .map<DropdownMenuItem<String>>((String item) {
                                return DropdownMenuItem<String>(
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: AppColors.textBlack
                                      ),
                                    ),
                                    value: item);
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _dropDownStateValue = value ?? '';
                                  print(value);
                                });
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ValueListenableBuilder(
                              valueListenable: pinController,
                              builder: (context, value, child) {
                                return TextFormField(
                                  controller: pinController,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      color: AppColors.textBlack
                                  ),
                                  keyboardType: TextInputType.number,
                                  cursorColor: AppColors.lightBlack,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelText: 'PIN Code',
                                    prefixIcon: const Icon(Icons.power_input_rounded, color: AppColors.textBlack,),
                                    labelStyle: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: AppColors.lightBlack
                                    ),
                                    border: outlineBorder,
                                    disabledBorder: outlineBorder,
                                    errorBorder: outlineBorder,
                                    focusedBorder: outlineBorder,
                                    focusedErrorBorder: outlineBorder,
                                    enabledBorder: outlineBorder,
                                  ),
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: (pinCode) {
                                    if (pinCode == null || pinCode.isEmpty) {
                                      return 'Please enter PIN code';
                                    }
                                    return null;
                                  },
                                );
                              }
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomButton(
                              onTap: (){
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                context.read<SurveyBloc>().add(SubmitDetailsAndStartSurveyEvent(
                                  locationModel: LocationModel(
                                    village: villageController.text.trim(),
                                    stateDistrict: districtController.text.trim(),
                                    state: _dropDownStateValue.trim(),
                                    postcode: pinController.text.trim()
                                  ),
                                  name: nameController.text.trim(),
                                  age: _dropDownAgeValue,
                                  gender: _dropDownGenderValue.trim(),
                                  latitude: 0.0000,
                                  longitude: 0.0000
                                ));
                              },
                              text: 'Start Survey',
                            ),
                            SizedBox(height: 10,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
