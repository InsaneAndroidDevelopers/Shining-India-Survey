class Question {
  final String id;
  final String questionText;
  final List<String> options;
  final bool isMultiCorrect;
  final bool isFixed;
  final bool isSlider;

  String answer = "";
  List<int> selectedOptions = [];
  int selectedIndex = -1;

  Question({
    required this.id,
    required this.questionText,
    required this.options,
    required this.isMultiCorrect,
    required this.isFixed,
    required this.isSlider,
  });
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
    isMultiCorrect: true,
    isFixed: false,
    isSlider: false,
  ),
  Question(
    id: '002',
    questionText: 'Are you getting benefits of Government Welfare Scheme facilities?',
    options: ["Yes", "No", "Can't say"],
    isMultiCorrect: false,
    isFixed: true,
    isSlider: false,
  ),
  Question(
    id: '003',
    questionText: 'Does your MLA come to visit the area, does he meet the common people easily?',
    options: ["Yes", "No", "Can't say"],
    isMultiCorrect: false,
    isFixed: true,
    isSlider: false,
  ),
  Question(
    id: '004',
    questionText: 'How is the performance of your area MLA?',
    options: ["Excellent", "Good", "Average", "Bad", "Worst"],
    isMultiCorrect: false,
    isFixed: true,
    isSlider: true,
  ),
  Question(
    id: '005',
    questionText: 'How is the performance of your ward area Corporator?',
    options: ["Excellent", "Good", "Average", "Bad", "Worst"],
    isMultiCorrect: false,
    isFixed: true,
    isSlider: true,
  ),
  Question(
    id: '006',
    questionText: 'Are you satisfied with the overall performance of your Lok Sabha MP?',
    options: ["Excellent", "Good", "Average", "Bad", "Worst"],
    isMultiCorrect: false,
    isFixed: true,
    isSlider: true,
  ),
  Question(
    id: '006',
    questionText: 'Are you satisfied with the overall performance of your Lok Sabha MP?',
    options: ["Excellent", "Good", "Average", "Bad", "Worst"],
    isMultiCorrect: false,
    isFixed: true,
    isSlider: true,
  ),
  Question(
    id: '007',
    questionText: 'Which candidate would you like to support in your area from your Assembly Constituency?',
    options: ["Mr X", "Mr Y", "Mrs Z", "OTH"],
    isMultiCorrect: false,
    isFixed: true,
    isSlider: false
  ),
  Question(
      id: '008',
      questionText: 'Which candidate would you like to support in your area from your Assembly Constituency?',
      options: ["Mr X", "Mr Y", "Mrs Z", "OTH"],
      isMultiCorrect: false,
      isFixed: true,
      isSlider: false
  ),
  Question(
      id: '009',
      questionText: 'Which leader do you want to see as the next Chief Minister of the state?',
      options: ["Mr X", "Mr Y", "Mrs Z", "OTH"],
      isMultiCorrect: false,
      isFixed: true,
      isSlider: false
  ),
  Question(
      id: '010',
      questionText: "Which party do you want to see the next government in the state?",
      options: ["BJP", "INC", "BRS", "AAP", "OTH", "ND"],
      isMultiCorrect: false,
      isFixed: true,
      isSlider: false
  ),
  Question(
      id: '011',
      questionText: "Which party would you like to support in the upcoming assembly elections?",
      options: ["BJP", "INC", "BRS", "AAP", "OTH", "ND"],
      isMultiCorrect: false,
      isFixed: true,
      isSlider: false
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
      isMultiCorrect: true,
      isFixed: false,
      isSlider: false
  ),
  Question(
      id: '013',
      questionText: "Which Party do you want to see next Government of India?",
      options:  ["BJP", "INC", "BRS", "AAP", "OTH", "ND"],
      isMultiCorrect: false,
      isFixed: true,
      isSlider: false
  ),
];