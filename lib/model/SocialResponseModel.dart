import 'dart:convert';
/// success : 1
/// message : ""
/// user : {"user_id":"155","first_name":"Jay","last_name":"Mistry","mobile":" ","country_code":"+27","birthdate":"","birthplace":"","pathshala":"","gurukul":"","qualification":"","experiance":"","address":"","certificate":"","profile_pic":"","timestamp":"","country_id":"","city_id":"","state_id":"","country_name":"","city_name":"","state_name":"","email":"jay.m@coronation.in","type":"User"}

SocialResponseModel socialResponseModelFromJson(String str) => SocialResponseModel.fromJson(json.decode(str));
String socialResponseModelToJson(SocialResponseModel data) => json.encode(data.toJson());
class SocialResponseModel {
  SocialResponseModel({
      num? success, 
      String? message, 
      SocialUser? user,}){
    _success = success;
    _message = message;
    _user = user;
}

  SocialResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _user = json['user'] != null ? SocialUser.fromJson(json['user']) : null;
  }
  num? _success;
  String? _message;
  SocialUser? _user;
SocialResponseModel copyWith({  num? success,
  String? message,
  SocialUser? user,
}) => SocialResponseModel(  success: success ?? _success,
  message: message ?? _message,
  user: user ?? _user,
);
  num? get success => _success;
  String? get message => _message;
  SocialUser? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }

}

/// user_id : "155"
/// first_name : "Jay"
/// last_name : "Mistry"
/// mobile : " "
/// country_code : "+27"
/// birthdate : ""
/// birthplace : ""
/// pathshala : ""
/// gurukul : ""
/// qualification : ""
/// experiance : ""
/// address : ""
/// certificate : ""
/// profile_pic : ""
/// timestamp : ""
/// country_id : ""
/// city_id : ""
/// state_id : ""
/// country_name : ""
/// city_name : ""
/// state_name : ""
/// email : "jay.m@coronation.in"
/// type : "User"

SocialUser userFromJson(String str) => SocialUser.fromJson(json.decode(str));
String userToJson(SocialUser data) => json.encode(data.toJson());
class SocialUser {
  SocialUser({
      String? userId, 
      String? firstName, 
      String? lastName, 
      String? mobile, 
      String? countryCode, 
      String? birthdate, 
      String? birthplace, 
      String? pathshala, 
      String? gurukul, 
      String? qualification, 
      String? experiance, 
      String? address, 
      String? certificate, 
      String? profilePic, 
      String? timestamp, 
      String? countryId, 
      String? cityId, 
      String? stateId, 
      String? countryName, 
      String? cityName, 
      String? stateName, 
      String? email, 
      String? type,}){
    _userId = userId;
    _firstName = firstName;
    _lastName = lastName;
    _mobile = mobile;
    _countryCode = countryCode;
    _birthdate = birthdate;
    _birthplace = birthplace;
    _pathshala = pathshala;
    _gurukul = gurukul;
    _qualification = qualification;
    _experiance = experiance;
    _address = address;
    _certificate = certificate;
    _profilePic = profilePic;
    _timestamp = timestamp;
    _countryId = countryId;
    _cityId = cityId;
    _stateId = stateId;
    _countryName = countryName;
    _cityName = cityName;
    _stateName = stateName;
    _email = email;
    _type = type;
}

  SocialUser.fromJson(dynamic json) {
    _userId = json['user_id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _mobile = json['mobile'];
    _countryCode = json['country_code'];
    _birthdate = json['birthdate'];
    _birthplace = json['birthplace'];
    _pathshala = json['pathshala'];
    _gurukul = json['gurukul'];
    _qualification = json['qualification'];
    _experiance = json['experiance'];
    _address = json['address'];
    _certificate = json['certificate'];
    _profilePic = json['profile_pic'];
    _timestamp = json['timestamp'];
    _countryId = json['country_id'];
    _cityId = json['city_id'];
    _stateId = json['state_id'];
    _countryName = json['country_name'];
    _cityName = json['city_name'];
    _stateName = json['state_name'];
    _email = json['email'];
    _type = json['type'];
  }
  String? _userId;
  String? _firstName;
  String? _lastName;
  String? _mobile;
  String? _countryCode;
  String? _birthdate;
  String? _birthplace;
  String? _pathshala;
  String? _gurukul;
  String? _qualification;
  String? _experiance;
  String? _address;
  String? _certificate;
  String? _profilePic;
  String? _timestamp;
  String? _countryId;
  String? _cityId;
  String? _stateId;
  String? _countryName;
  String? _cityName;
  String? _stateName;
  String? _email;
  String? _type;
SocialUser copyWith({  String? userId,
  String? firstName,
  String? lastName,
  String? mobile,
  String? countryCode,
  String? birthdate,
  String? birthplace,
  String? pathshala,
  String? gurukul,
  String? qualification,
  String? experiance,
  String? address,
  String? certificate,
  String? profilePic,
  String? timestamp,
  String? countryId,
  String? cityId,
  String? stateId,
  String? countryName,
  String? cityName,
  String? stateName,
  String? email,
  String? type,
}) => SocialUser(  userId: userId ?? _userId,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  mobile: mobile ?? _mobile,
  countryCode: countryCode ?? _countryCode,
  birthdate: birthdate ?? _birthdate,
  birthplace: birthplace ?? _birthplace,
  pathshala: pathshala ?? _pathshala,
  gurukul: gurukul ?? _gurukul,
  qualification: qualification ?? _qualification,
  experiance: experiance ?? _experiance,
  address: address ?? _address,
  certificate: certificate ?? _certificate,
  profilePic: profilePic ?? _profilePic,
  timestamp: timestamp ?? _timestamp,
  countryId: countryId ?? _countryId,
  cityId: cityId ?? _cityId,
  stateId: stateId ?? _stateId,
  countryName: countryName ?? _countryName,
  cityName: cityName ?? _cityName,
  stateName: stateName ?? _stateName,
  email: email ?? _email,
  type: type ?? _type,
);
  String? get userId => _userId;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get mobile => _mobile;
  String? get countryCode => _countryCode;
  String? get birthdate => _birthdate;
  String? get birthplace => _birthplace;
  String? get pathshala => _pathshala;
  String? get gurukul => _gurukul;
  String? get qualification => _qualification;
  String? get experiance => _experiance;
  String? get address => _address;
  String? get certificate => _certificate;
  String? get profilePic => _profilePic;
  String? get timestamp => _timestamp;
  String? get countryId => _countryId;
  String? get cityId => _cityId;
  String? get stateId => _stateId;
  String? get countryName => _countryName;
  String? get cityName => _cityName;
  String? get stateName => _stateName;
  String? get email => _email;
  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['mobile'] = _mobile;
    map['country_code'] = _countryCode;
    map['birthdate'] = _birthdate;
    map['birthplace'] = _birthplace;
    map['pathshala'] = _pathshala;
    map['gurukul'] = _gurukul;
    map['qualification'] = _qualification;
    map['experiance'] = _experiance;
    map['address'] = _address;
    map['certificate'] = _certificate;
    map['profile_pic'] = _profilePic;
    map['timestamp'] = _timestamp;
    map['country_id'] = _countryId;
    map['city_id'] = _cityId;
    map['state_id'] = _stateId;
    map['country_name'] = _countryName;
    map['city_name'] = _cityName;
    map['state_name'] = _stateName;
    map['email'] = _email;
    map['type'] = _type;
    return map;
  }

}