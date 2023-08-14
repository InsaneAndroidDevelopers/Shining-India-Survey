class Question {
  final String id;
  final String questionText;
  final List<String> options;
  final bool isMultiCorrect;
  final bool isFixed;
  final bool isSlider;

  Question({
    required this.id,
    required this.questionText,
    required this.options,
    required this.isMultiCorrect,
    required this.isFixed,
    required this.isSlider
  });
}

List<Question> ques = [
  Question(
    id: '100',
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
    id: '101',
    questionText: 'Are you getting benefits of Government Welfare Scheme facilities?',
    options: ["Yes", "No", "Can't say"],
    isMultiCorrect: false,
    isFixed: true,
    isSlider: false,
  ),
  Question(
    id: '102',
    questionText: 'Does your MLA come to visit the area, does he meet the common people easily?',
    options: ["Yes", "No", "Can't say"],
    isMultiCorrect: false,
    isFixed: true,
    isSlider: false,
  ),
  Question(
    id: '103',
    questionText: 'How is the performance of your area MLA?',
    options: ["Excellent", "Good", "Average", "Bad", "Worst"],
    isMultiCorrect: false,
    isFixed: true,
    isSlider: true,
  ),
  Question(
    id: '104',
    questionText: 'How is the performance of your area MLA?',
    options: ["Excellent", "Good", "Average", "Bad", "Worst"],
    isMultiCorrect: false,
    isFixed: true,
    isSlider: true,
  )
];