import 'dart:convert';
/// success : 1
/// message : "You have logged in successfully."
/// profile : {"user_id":"79","first_name":"pratiksha","last_name":"panchal","mobile":"9510831651","country_code":"","birthdate":"17-04-2000","birthplace":"","pathshala":"","gurukul":"","qualification":"","experiance":"","address":"New Maninagar, Ahmedabad, Gujarat, India","certificate":"","profile_pic":"https://www.panditbookings.com/api/assets/uploads/profile_pic/1690455911_Astrology.jpg","timestamp":"","country_id":"1","city_id":"5910","state_id":"42","country_name":"AFGHANISTAN","city_name":"Fayzabad","state_name":"Badakhshan","email":"panchalpratiksha99@gmail.com","type":"User"}

VerifyOtpResponseModel verifyOtpResponseModelFromJson(String str) => VerifyOtpResponseModel.fromJson(json.decode(str));
String verifyOtpResponseModelToJson(VerifyOtpResponseModel data) => json.encode(data.toJson());
class VerifyOtpResponseModel {
  VerifyOtpResponseModel({
      num? success, 
      String? message, 
      Profile? profile,}){
    _success = success;
    _message = message;
    _profile = profile;
}

  VerifyOtpResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _profile = json['profile'] != null ? Profile.fromJson(json['profile']) : null;
  }
  num? _success;
  String? _message;
  Profile? _profile;
VerifyOtpResponseModel copyWith({  num? success,
  String? message,
  Profile? profile,
}) => VerifyOtpResponseModel(  success: success ?? _success,
  message: message ?? _message,
  profile: profile ?? _profile,
);
  num? get success => _success;
  String? get message => _message;
  Profile? get profile => _profile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_profile != null) {
      map['profile'] = _profile?.toJson();
    }
    return map;
  }

}

/// user_id : "79"
/// first_name : "pratiksha"
/// last_name : "panchal"
/// mobile : "9510831651"
/// country_code : ""
/// birthdate : "17-04-2000"
/// birthplace : ""
/// pathshala : ""
/// gurukul : ""
/// qualification : ""
/// experiance : ""
/// address : "New Maninagar, Ahmedabad, Gujarat, India"
/// certificate : ""
/// profile_pic : "https://www.panditbookings.com/api/assets/uploads/profile_pic/1690455911_Astrology.jpg"
/// timestamp : ""
/// country_id : "1"
/// city_id : "5910"
/// state_id : "42"
/// country_name : "AFGHANISTAN"
/// city_name : "Fayzabad"
/// state_name : "Badakhshan"
/// email : "panchalpratiksha99@gmail.com"
/// type : "User"

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));
String profileToJson(Profile data) => json.encode(data.toJson());
class Profile {
  Profile({
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

  Profile.fromJson(dynamic json) {
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
Profile copyWith({  String? userId,
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
}) => Profile(  userId: userId ?? _userId,
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

  set userId(String? value) {
    _userId = value;
  }

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



  set firstName(String? value) {
    _firstName = value;
  }

  set lastName(String? value) {
    _lastName = value;
  }

  set mobile(String? value) {
    _mobile = value;
  }

  set countryCode(String? value) {
    _countryCode = value;
  }

  set birthdate(String? value) {
    _birthdate = value;
  }

  set birthplace(String? value) {
    _birthplace = value;
  }

  set pathshala(String? value) {
    _pathshala = value;
  }

  set gurukul(String? value) {
    _gurukul = value;
  }

  set qualification(String? value) {
    _qualification = value;
  }

  set experiance(String? value) {
    _experiance = value;
  }

  set address(String? value) {
    _address = value;
  }

  set certificate(String? value) {
    _certificate = value;
  }

  set profilePic(String? value) {
    _profilePic = value;
  }

  set timestamp(String? value) {
    _timestamp = value;
  }

  set countryId(String? value) {
    _countryId = value;
  }

  set cityId(String? value) {
    _cityId = value;
  }

  set stateId(String? value) {
    _stateId = value;
  }

  set countryName(String? value) {
    _countryName = value;
  }

  set cityName(String? value) {
    _cityName = value;
  }

  set stateName(String? value) {
    _stateName = value;
  }

  set email(String? value) {
    _email = value;
  }

  set type(String? value) {
    _type = value;
  }
}