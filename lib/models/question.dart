import 'package:shining_india_survey/utils/string_constants.dart';

class Question {
  final String id;
  final String questionText;
  final List<String> options;
  final String type;

  List<int> selectedOptions = [];
  int selectedIndex = -1;
  String otherText = "";

  Question({
    required this.id,
    required this.questionText,
    required this.options,
    required this.type,
  }) {
    if(type == StringsConstants.QUES_TYPE_MULTI) {
      selectedOptions = List.generate(options.length, (index) => 0);
    }
  }
}

List<Question> ques = [
  Question(
    id: '001',
    questionText: 'What are the main problems of your area?',
    options: [
      "Education",
      "Road",
      "Inflation",
      "Electricity",
      "Law and order",
    ],
    type: StringsConstants.QUES_TYPE_MULTI,
  ),
  Question(
    id: '002',
    questionText: 'Are you getting benefits of Government Welfare Scheme facilities?',
    options: ["Yes", "No", "Can't say"],
    type: StringsConstants.QUES_TYPE_SINGLE,
  ),
  Question(
    id: '003',
    questionText: 'Does your MLA come to visit the area, does he meet the common people easily?',
    options: ["Yes", "No", "Can't say"],
    type: StringsConstants.QUES_TYPE_SINGLE,
  ),
  Question(
    id: '004',
    questionText: 'How is the performance of your area MLA?',
    options: ["Worst", "Bad", "Average", "Good", "Excellent"],
    type: StringsConstants.QUES_TYPE_SLIDER,
  ),
  Question(
    id: '005',
    questionText: 'How is the performance of your ward area Corporator?',
    options: ["Worst", "Bad", "Average", "Good", "Excellent"],
    type: StringsConstants.QUES_TYPE_SLIDER,
  ),
  Question(
    id: '006',
    questionText: 'Are you satisfied with the overall performance of your Lok Sabha MP?',
    options: ["Worst", "Bad", "Average", "Good", "Excellent"],
    type: StringsConstants.QUES_TYPE_SLIDER,
  ),
  Question(
    id: '006',
    questionText: 'Are you satisfied with the overall performance of your Lok Sabha MP?',
    options: ["Worst", "Bad", "Average", "Good", "Excellent"],
    type: StringsConstants.QUES_TYPE_SLIDER,
  ),
  Question(
    id: '007',
    questionText: 'Which candidate would you like to support in your area from your Assembly Constituency?',
    options: ["Mr X", "Mr Y", "Mrs Z", "OTH"],
    type: StringsConstants.QUES_TYPE_SINGLE,
  ),
  Question(
      id: '008',
      questionText: 'Which candidate would you like to support in your area from your Assembly Constituency?',
      options: ["Mr X", "Mr Y", "Mrs Z", "OTH"],
    type: StringsConstants.QUES_TYPE_SINGLE,
  ),
  Question(
      id: '009',
      questionText: 'Which leader do you want to see as the next Chief Minister of the state?',
      options: ["Mr X", "Mr Y", "Mrs Z", "OTH"],
    type: StringsConstants.QUES_TYPE_SINGLE,
  ),
  Question(
      id: '010',
      questionText: "Which party do you want to see the next government in the state?",
      options: ["BJP", "INC", "BRS", "AAP", "OTH", "ND"],
    type: StringsConstants.QUES_TYPE_SINGLE,
  ),
  Question(
      id: '011',
      questionText: "Which party would you like to support in the upcoming assembly elections?",
      options: ["BJP", "INC", "BRS", "AAP", "OTH", "ND"],
    type: StringsConstants.QUES_TYPE_SINGLE,
  ),
  Question(
      id: '012',
      questionText: "According to you, in the current situation, what are the issues on which the government should pay attention?",
      options:  [
        "Inflation", "Petrol Diesel Price", "Health Care Facilities",
        "Education Facilities", "Employment", "Drinking Water",
        "Irrigation Watering", "Fertilizer Seeds", "Cooking Gas Price",
        "Road", "Drainage", "Transportation", "Courruption",
        "Low and older", "Car Parking", "Garbage", "Others"
      ],
    type: StringsConstants.QUES_TYPE_MULTI,
  ),
  Question(
      id: '013',
      questionText: "Which Party do you want to see next Government of India?",
      options:  ["BJP", "INC", "BRS", "AAP", "OTH", "ND"],
      type: StringsConstants.QUES_TYPE_SINGLE,
  ),
];