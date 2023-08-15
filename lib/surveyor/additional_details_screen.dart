import 'package:flutter/material.dart';
import 'package:shining_india_survey/surveyor/survey_result_screen.dart';

class AdditionalDetailsScreen extends StatefulWidget {
  const AdditionalDetailsScreen({super.key});

  @override
  State<AdditionalDetailsScreen> createState() => _AdditionalDetailsScreenState();
}

class _AdditionalDetailsScreenState extends State<AdditionalDetailsScreen> {

  final _formKey = GlobalKey<FormState>();

  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  String _dropDownReligionValue = 'Hindu';
  List<String> religions = [
    'Hindu',
    'Muslim',
    'Sikh',
    'Christian',
    'Jain',
    'Buddhist'
  ];

  String _dropDownCasteValue = 'General';
  List<String> castes = [
    'General',
    'OBC',
    'EWS',
    'SC',
    'ST',
  ];

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
                  'Additonal Details',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 10,),
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
                            prefixIcon: Icon(Icons.phone)
                        ),
                      ),
                      SizedBox(height: 10,),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                            labelText: 'Religion',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person)
                        ),
                        value: _dropDownReligionValue,
                        items: religions.map<DropdownMenuItem<String>>((String item) {
                          return DropdownMenuItem<String>(
                              child: Text(item),
                              value: item
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _dropDownReligionValue = value ?? '';
                            print(value);
                          });
                        },
                      ),
                      SizedBox(height: 10,),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                            labelText: 'Caste',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person)
                        ),
                        value: _dropDownCasteValue,
                        items: castes.map<DropdownMenuItem<String>>((String item) {
                          return DropdownMenuItem<String>(
                              child: Text(item),
                              value: item
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _dropDownCasteValue = value ?? '';
                            print(value);
                          });
                        },
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        maxLines: 3,
                        controller: addressController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Address',
                            prefixIcon: Icon(Icons.maps_home_work_rounded)
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16,),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Theme.of(context).primaryColor),
                          minimumSize: Size.fromHeight(50)
                        ),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SurveyResultScreen()));
                        },
                        child: Text(
                          'Skip'
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(50)
                        ),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SurveyResultScreen()));
                        },
                        child: Text(
                            'Submit'
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
