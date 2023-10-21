class AdminResponseModel {
  String? id;
  String? name;
  String? email;
  int? age;
  String? gender;
  String? role;
  String? admin;
  bool? active;

  AdminResponseModel(
      {this.id,
        this.name,
        this.email,
        this.age,
        this.gender,
        this.role,
        this.admin,
        this.active});

  AdminResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    age = json['age'];
    gender = json['gender'];
    role = json['role'];
    admin = json['admin'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['age'] = age;
    data['gender'] = gender;
    data['role'] = role;
    data['admin'] = admin;
    data['active'] = active;
    return data;
  }
}