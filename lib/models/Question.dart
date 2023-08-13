class Question {
  final String id;
  final String questionText;
  final List<String> options;
  final bool isMultiCorrect;

  Question({required this.id, required this.questionText, required this.options, required this.isMultiCorrect});
}

List<Question> ques = [
  Question(
    id: '100',
    questionText: 'What are the main problems of your area?',
    options: [
      "Education", "Road", "Inflation", "Electricity", "Drinking Water",
      "Health facilities", "Ration", "Transporation", "Law and order", "Other"
    ],
    isMultiCorrect: true,
  ),
  Question(
    id: '101',
    questionText: 'Are you getting benefits of Government Welfare Scheme facilities?',
    options: ["Yes", "No", "Can't say"],
    isMultiCorrect: false
  ),
  Question(
    id: '102',
    questionText: 'Does your MLA come to visit the area, does he meet the common people easily?',
    options: ["Yes", "No", "Can't say"],
    isMultiCorrect: false
  ),
  Question(
    id: '103',
    questionText: 'How is the performance of your area MLA?',
    options: ["Excellent", "Good", "Average", "Bad", "Worst"],
    isMultiCorrect: false
  )
];