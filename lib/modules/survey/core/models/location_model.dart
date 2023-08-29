class LocationModel {
  String? village;
  String? county;
  String? stateDistrict;
  String? state;
  String? postcode;
  String? country;
  String? countryCode;

  LocationModel(
      {this.village,
        this.county,
        this.stateDistrict,
        this.state,
        this.postcode,
        this.country,
        this.countryCode});

  LocationModel.fromJson(Map<String, dynamic> json) {
    village = json['village'];
    county = json['county'];
    stateDistrict = json['state_district'];
    state = json['state'];
    postcode = json['postcode'];
    country = json['country'];
    countryCode = json['country_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['village'] = this.village;
    data['county'] = this.county;
    data['state_district'] = this.stateDistrict;
    data['state'] = this.state;
    data['postcode'] = this.postcode;
    data['country'] = this.country;
    data['country_code'] = this.countryCode;
    return data;
  }
}