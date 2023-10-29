import 'package:shining_india_survey/utils/string_constants.dart';

class QuestionModel {
  String? id;
  String? question;
  List<String>? options;
  String? type;
  bool? other;

  List<int> selectedOptions = [];
  int selectedIndex = -1;
  String otherText = "";

  QuestionModel({this.id, this.question, this.options, this.type, this.other}) {
    if(type == StringsConstants.QUES_TYPE_MULTI) {
      selectedOptions = List.generate(options?.length ?? 0, (index) => 0);
    } if(type == StringsConstants.QUES_TYPE_SLIDER) {
      selectedIndex = 0;
    }
  }

  QuestionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    options = json['options'].cast<String>();
    type = json['type'];
    other = json['other'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['question'] = question;
    data['options'] = options;
    data['type'] = type;
    data['other'] = other;
    return data;
  }
}