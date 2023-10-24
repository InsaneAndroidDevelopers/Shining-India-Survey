class SurveyorHomeResponseModel {
  String? id;
  String? username;
  String? teamID;
  String? latitude;
  String? longitude;
  String? ward;
  String? village;
  String? pincode;
  String? city;
  String? state;
  String? country;
  Null? assemblyName;
  String? surveyDateTime;
  String? personName;
  String? gender;
  int? age;
  String? religion;
  String? caste;
  String? address;

  SurveyorHomeResponseModel(
      {this.id,
        this.username,
        this.teamID,
        this.latitude,
        this.longitude,
        this.ward,
        this.village,
        this.pincode,
        this.city,
        this.state,
        this.country,
        this.assemblyName,
        this.surveyDateTime,
        this.personName,
        this.gender,
        this.age,
        this.religion,
        this.caste,
        this.address});

  SurveyorHomeResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    teamID = json['teamID'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    ward = json['ward'];
    village = json['village'];
    pincode = json['pincode'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    assemblyName = json['assemblyName'];
    surveyDateTime = json['surveyDateTime'];
    personName = json['personName'];
    gender = json['gender'];
    age = json['age'];
    religion = json['religion'];
    caste = json['caste'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['teamID'] = teamID;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['ward'] = ward;
    data['village'] = village;
    data['pincode'] = pincode;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['assemblyName'] = assemblyName;
    data['surveyDateTime'] = surveyDateTime;
    data['personName'] = personName;
    data['gender'] = gender;
    data['age'] = age;
    data['religion'] = religion;
    data['caste'] = caste;
    data['address'] = address;
    return data;
  }
}