class QuestionResponseModel {
  String? id;
  String? othersText;
  int? selectedIndex;
  List<int>? selectedOptionsIndex = [];

  QuestionResponseModel({
    this.id,
    this.othersText = '',
    this.selectedIndex = -1,
    this.selectedOptionsIndex
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['othersText'] = othersText;
    data['selectedIndex'] = selectedIndex;
    data['selectedOptionsIndex'] = selectedOptionsIndex;
    return data;
  }
}