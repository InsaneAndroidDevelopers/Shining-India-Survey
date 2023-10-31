class TeamModel {
  String? id;
  String? teamName;
  String? captain;
  List<Members>? members;

  TeamModel({this.id, this.teamName, this.captain, this.members});

  TeamModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamName = json['teamName'];
    captain = json['captain'];
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(new Members.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['teamName'] = this.teamName;
    data['captain'] = this.captain;
    if (this.members != null) {
      data['members'] = this.members!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Members {
  String? surveyorId;
  String? name;
  String? email;
  bool? active;

  Members({this.surveyorId, this.name, this.email, this.active});

  Members.fromJson(Map<String, dynamic> json) {
    surveyorId = json['surveyorId'];
    name = json['name'];
    email = json['email'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['surveyorId'] = this.surveyorId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['active'] = this.active;
    return data;
  }
}