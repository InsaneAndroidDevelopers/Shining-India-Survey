class UnassignedSurveyorModel {
  String? id;
  String? name;
  String? email;
  String? password;
  int? age;
  String? gender;
  String? role;
  String? locationHistory;
  String? admin;
  String? teamId;
  String? teamName;
  bool? active;
  bool? enabled;
  bool? accountNonExpired;
  bool? credentialsNonExpired;
  String? authorities;
  String? username;
  bool? accountNonLocked;

  UnassignedSurveyorModel(
      {this.id,
        this.name,
        this.email,
        this.password,
        this.age,
        this.gender,
        this.role,
        this.locationHistory,
        this.admin,
        this.teamId,
        this.teamName,
        this.active,
        this.enabled,
        this.accountNonExpired,
        this.credentialsNonExpired,
        this.authorities,
        this.username,
        this.accountNonLocked});

  UnassignedSurveyorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    age = json['age'];
    gender = json['gender'];
    role = json['role'];
    locationHistory = json['locationHistory'];
    admin = json['admin'];
    teamId = json['teamId'];
    teamName = json['teamName'];
    active = json['active'];
    enabled = json['enabled'];
    accountNonExpired = json['accountNonExpired'];
    credentialsNonExpired = json['credentialsNonExpired'];
    authorities = json['authorities'];
    username = json['username'];
    accountNonLocked = json['accountNonLocked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['role'] = this.role;
    data['locationHistory'] = this.locationHistory;
    data['admin'] = this.admin;
    data['teamId'] = this.teamId;
    data['teamName'] = this.teamName;
    data['active'] = this.active;
    data['enabled'] = this.enabled;
    data['accountNonExpired'] = this.accountNonExpired;
    data['credentialsNonExpired'] = this.credentialsNonExpired;
    data['authorities'] = this.authorities;
    data['username'] = this.username;
    data['accountNonLocked'] = this.accountNonLocked;
    return data;
  }
}