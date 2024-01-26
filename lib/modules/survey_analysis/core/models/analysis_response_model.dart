import 'dart:typed_data';

class AnalysisResponseModel {
  String? sId;
  List<Answers>? answers;
  int? totalCount;
  Uint8List? unit8Image;

  AnalysisResponseModel({this.sId, this.answers, this.totalCount, this.unit8Image});

  AnalysisResponseModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(new Answers.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.answers != null) {
      data['answers'] = this.answers!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = this.totalCount;
    return data;
  }
}

class Answers {
  String? answer;
  int? count;

  Answers({this.answer, this.count});

  Answers.fromJson(Map<String, dynamic> json) {
    answer = json['answer'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answer'] = this.answer;
    data['count'] = this.count;
    return data;
  }
}