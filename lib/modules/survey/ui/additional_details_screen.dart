import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shining_india_survey/modules/survey/core/bloc/survey_bloc.dart';
import 'package:shining_india_survey/modules/survey/ui/survey_result_screen.dart';
import 'package:shining_india_survey/routes/routes.dart';
import 'package:shining_india_survey/utils/array_res.dart';

class AdditionalDetailsScreen extends StatefulWidget {
  const AdditionalDetailsScreen({super.key});

  @override
  State<AdditionalDetailsScreen> createState() =>
      _AdditionalDetailsScreenState();
}

class _AdditionalDetailsScreenState extends State<AdditionalDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  String _dropDownReligionValue = ArrayResources.religions[0];
  String _dropDownCasteValue = ArrayResources.castes[0];

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SurveyBloc, SurveyState>(
      listener: (context, state) {
        if (state is SurveySuccessState) {
          context.go(RouteNames.surveyResultScreen);
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          return await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Are you sure?'),
                  content: Text('Do you want to exit the survey'),
                  actions: [
                    TextButton(
                      onPressed: () => context.pop(false),
                      child: Text('No'),
                    ),
                    TextButton(
                      onPressed: () =>
                          context.go(RouteNames.surveyorHomeScreen),
                      child: Text('Yes'),
                    ),
                  ],
                ),
              ) ??
              false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Additonal Details',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Phone',
                                prefixIcon: Icon(Icons.phone)),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (phone) {
                              if (phone != null &&
                                  phone.isNotEmpty &&
                                  phone.length != 10) {
                                return 'Please enter correct phone number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                                labelText: 'Religion',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person)),
                            value: _dropDownReligionValue,
                            items: ArrayResources.religions
                                .map<DropdownMenuItem<String>>((String item) {
                              return DropdownMenuItem<String>(
                                  child: Text(item), value: item);
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _dropDownReligionValue = value ?? '';
                                print(value);
                              });
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                                labelText: 'Caste',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person)),
                            value: _dropDownCasteValue,
                            items: ArrayResources.castes
                                .map<DropdownMenuItem<String>>((String item) {
                              return DropdownMenuItem<String>(
                                  child: Text(item), value: item);
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _dropDownCasteValue = value ?? '';
                                print(value);
                              });
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            maxLines: 3,
                            controller: addressController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Address',
                                prefixIcon: Icon(Icons.maps_home_work_rounded)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                    color: Theme.of(context).primaryColor),
                                minimumSize: Size.fromHeight(50)),
                            onPressed: () {
                              context.read<SurveyBloc>().add(SkipAndFinishSurveyEvent());
                            },
                            child: Text('Skip'),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size.fromHeight(50)),
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              context.read<SurveyBloc>().add(SubmitAdditionalDetailsAndFinishEvent(
                                phone: phoneController.text.trim(),
                                address: addressController.text.trim(),
                                religion: _dropDownReligionValue.trim(),
                                caste: _dropDownCasteValue.trim()
                              ));
                            },
                            child: Text('Submit'),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
