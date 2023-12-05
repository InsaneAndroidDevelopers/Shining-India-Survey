class RecentSurveyModel {
  String? id;
  String? name;
  String? district;
  String? state;
  String? time;
  String? latitude;
  String? longitude;

  RecentSurveyModel({this.id, this.name, this.district, this.state, this.time, this.latitude, this.longitude});

  RecentSurveyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    district = json['district'];
    state = json['state'];
    time = json['time'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['district'] = this.district;
    data['state'] = this.state;
    data['time'] = this.time;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}