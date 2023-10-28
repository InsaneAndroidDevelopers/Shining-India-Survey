class RecentSurveyModel {
  String? id;
  String? name;
  String? district;
  String? state;
  String? time;

  RecentSurveyModel({this.id, this.name, this.district, this.state, this.time});

  RecentSurveyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    district = json['district'];
    state = json['state'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['district'] = this.district;
    data['state'] = this.state;
    data['time'] = this.time;
    return data;
  }
}