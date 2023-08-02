class EmalLoginResponseModel {
  EmalLoginResponseModel({
      required this.success,
    required this.message,
    required this.userId,
    required this.firstName,
    required this.countryCode,
    required this.lastName,
    required this.mobile,
    required this.birthdate,
    required this.birthplace,
    required this.pathshala,
    required this.gurukul,
    required this.qualification,
    required  this.experiance,
    required this.address,
    required this.certificate,
    required  this.profilePic,
    required this.timestamp,
    required this.lat,
    required this.lng,
    required this.location,
    required this.countryId,
    required this.cityId,
    required this.stateId,
      this.countryName, 
      this.cityName, 
      this.stateName,
    required this.email,
    required this.type,});

  EmalLoginResponseModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    userId = json['user_id'] ?? "" ;
    firstName = json['first_name'] ?? "";
    countryCode = json['country_code'] ?? "";
    lastName = json['last_name'] ?? "";
    mobile = json['mobile'] ?? "";
    birthdate = json['birthdate'] ?? "";
    birthplace = json['birthplace'] ?? "";
    pathshala = json['pathshala'] ?? "";
    gurukul = json['gurukul'] ?? "";
    qualification = json['qualification'] ?? "";
    experiance = json['experiance'] ?? "";
    address = json['address'] ?? "";
    certificate = json['certificate'] ?? "";
    profilePic = json['profile_pic'] ?? "";
    timestamp = json['timestamp'] ?? "";
    lat = json['lat'] ?? "";
    lng = json['lng'] ?? "";
    location = json['location'] ?? "";
    countryId = json['country_id'] ?? "";
    cityId = json['city_id'] ?? "";
    stateId = json['state_id'] ?? "";
    countryName = json['country_name'] ?? "";
    cityName = json['city_name'] ?? "";
    stateName = json['state_name'] ?? "";
    email = json['email'] ?? "";
    type = json['type'] ?? "";
  }
  int success = 0;
  String message = "";
  String userId = "";
  String firstName = "";
  String countryCode = "";
  String lastName = "";
  String mobile = "";
  String birthdate = "";
  String birthplace = "";
  String pathshala = "";
  String gurukul = "";
  String qualification = "";
  String experiance = "";
  String address = "";
  String certificate = "";
  String profilePic = "";
  String timestamp = "";
  String lat = "";
  String lng = "";
  String location = "";
  String countryId = "";
  String cityId = "";
  String stateId = "";
  dynamic countryName;
  dynamic cityName;
  dynamic stateName;
  String email = "";
  String type = "";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    map['user_id'] = userId;
    map['first_name'] = firstName;
    map['country_code'] = countryCode;
    map['last_name'] = lastName;
    map['mobile'] = mobile;
    map['birthdate'] = birthdate;
    map['birthplace'] = birthplace;
    map['pathshala'] = pathshala;
    map['gurukul'] = gurukul;
    map['qualification'] = qualification;
    map['experiance'] = experiance;
    map['address'] = address;
    map['certificate'] = certificate;
    map['profile_pic'] = profilePic;
    map['timestamp'] = timestamp;
    map['lat'] = lat;
    map['lng'] = lng;
    map['location'] = location;
    map['country_id'] = countryId;
    map['city_id'] = cityId;
    map['state_id'] = stateId;
    map['country_name'] = countryName;
    map['city_name'] = cityName;
    map['state_name'] = stateName;
    map['email'] = email;
    map['type'] = type;
    return map;
  }

}