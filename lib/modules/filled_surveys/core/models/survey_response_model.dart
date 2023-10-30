class SurveyResponseModel {
  String? username;
  String? teamID;
  String? country;
  String? assemblyName;
  String? surveyDateTime;
  String? personName;
  String? gender;
  int? age;
  String? latitude;
  String? longitude;
  String? ward;
  String? district;
  String? pincode;
  String? city;
  String? state;
  String? religion;
  String? caste;
  String? mobileNum;
  String? address;
  List<QuestionResponseModel>? response;

  SurveyResponseModel({this.username,
    this.teamID,
    this.country,
    this.assemblyName,
    this.surveyDateTime,
    this.personName,
    this.gender,
    this.latitude,
    this.longitude,
    this.ward,
    this.district,
    this.pincode,
    this.city,
    this.state,
    this.age,
    this.address,
    this.caste,
    this.religion,
    this.mobileNum,
    this.response
  });

  SurveyResponseModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    teamID = json['teamID'];
    country = json['country'];
    assemblyName = json['assemblyName'];
    surveyDateTime = json['surveyDateTime'];
    personName = json['personName'];
    gender = json['gender'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    ward = json['ward'];
    district = json['district'];
    pincode = json['pincode'];
    city = json['city'];
    state = json['state'];
    age = json['age'];
    address = json['address'];
    religion = json['religion'];
    caste = json['caste'];
    mobileNum = json['mobile_num'];
    if (json['response'] != null) {
      response = <QuestionResponseModel>[];
      json['response'].forEach((v) {
        response!.add(QuestionResponseModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['teamID'] = teamID;
    data['country'] = country;
    data['assemblyName'] = assemblyName;
    data['surveyDateTime'] = surveyDateTime;
    data['personName'] = personName;
    data['gender'] = gender;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['ward'] = ward;
    data['district'] = district;
    data['pincode'] = pincode;
    data['city'] = city;
    data['state'] = state;
    data['age'] = age;
    data['address'] = address;
    data['religion'] = religion;
    data['caste'] = caste;
    data['mobile_num'] = mobileNum;
    if (response != null) {
      data['response'] = response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuestionResponseModel {
  String? questionId;
  List<String>? answer;

  QuestionResponseModel({this.questionId, this.answer});

  QuestionResponseModel.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    answer = json['answer'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['questionId'] = questionId;
    data['answer'] = answer;
    return data;
  }
}