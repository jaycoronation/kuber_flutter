import 'dart:convert';
/// profile : {"id":"45","is_password_set":1,"first_name":"Jayy","last_name":"Mistry","email":"zalak@coronation.in","mobile":"9737388804","country_code":"null","birthdate":"2022-08-02","birthdate_old":"2022-08-02","birthplace":"","pathshala":"p1","gender":"1","gender_label":"Male","country":"","city":"","state":"","country_id":"","city_id":"","state_id":"","country_name":"","city_name":"","state_name":"","gurukul":"gq","qualification":"Others","qualification_other":"Tarot card reader","experience":"Completed","experience_other":"","address":"Ahmedabad, Gujarat, India","certificate":"","certificate_name":"","timestamp":"1659422590","profile_pic":"https://www.panditbookings.com/api/assets/images/default-user.png","profile_pic_name":""}
/// success : 1
/// message : ""

PujariUserReponseModel pujariUserReponseModelFromJson(String str) => PujariUserReponseModel.fromJson(json.decode(str));
String pujariUserReponseModelToJson(PujariUserReponseModel data) => json.encode(data.toJson());
class PujariUserReponseModel {
  PujariUserReponseModel({
      Profile? profile, 
      num? success, 
      String? message,}){
    _profile = profile;
    _success = success;
    _message = message;
}

  PujariUserReponseModel.fromJson(dynamic json) {
    _profile = json['profile'] != null ? Profile.fromJson(json['profile']) : null;
    _success = json['success'];
    _message = json['message'];
  }
  Profile? _profile;
  num? _success;
  String? _message;
PujariUserReponseModel copyWith({  Profile? profile,
  num? success,
  String? message,
}) => PujariUserReponseModel(  profile: profile ?? _profile,
  success: success ?? _success,
  message: message ?? _message,
);
  Profile? get profile => _profile;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_profile != null) {
      map['profile'] = _profile?.toJson();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// id : "45"
/// is_password_set : 1
/// first_name : "Jayy"
/// last_name : "Mistry"
/// email : "zalak@coronation.in"
/// mobile : "9737388804"
/// country_code : "null"
/// birthdate : "2022-08-02"
/// birthdate_old : "2022-08-02"
/// birthplace : ""
/// pathshala : "p1"
/// gender : "1"
/// gender_label : "Male"
/// country : ""
/// city : ""
/// state : ""
/// country_id : ""
/// city_id : ""
/// state_id : ""
/// country_name : ""
/// city_name : ""
/// state_name : ""
/// gurukul : "gq"
/// qualification : "Others"
/// qualification_other : "Tarot card reader"
/// experience : "Completed"
/// experience_other : ""
/// address : "Ahmedabad, Gujarat, India"
/// certificate : ""
/// certificate_name : ""
/// timestamp : "1659422590"
/// profile_pic : "https://www.panditbookings.com/api/assets/images/default-user.png"
/// profile_pic_name : ""

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));
String profileToJson(Profile data) => json.encode(data.toJson());
class Profile {
  Profile({
      String? id, 
      num? isPasswordSet, 
      String? firstName, 
      String? lastName, 
      String? email, 
      String? mobile, 
      String? countryCode, 
      String? birthdate, 
      String? birthdateOld, 
      String? birthplace, 
      String? pathshala, 
      String? gender, 
      String? genderLabel, 
      String? country, 
      String? city, 
      String? state, 
      String? countryId, 
      String? cityId, 
      String? stateId, 
      String? countryName, 
      String? cityName, 
      String? stateName, 
      String? gurukul, 
      String? qualification, 
      String? qualificationOther, 
      String? experience, 
      String? experienceOther, 
      String? address, 
      String? certificate, 
      String? certificateName, 
      String? timestamp, 
      String? profilePic, 
      String? profilePicName,}){
    _id = id;
    _isPasswordSet = isPasswordSet;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _mobile = mobile;
    _countryCode = countryCode;
    _birthdate = birthdate;
    _birthdateOld = birthdateOld;
    _birthplace = birthplace;
    _pathshala = pathshala;
    _gender = gender;
    _genderLabel = genderLabel;
    _country = country;
    _city = city;
    _state = state;
    _countryId = countryId;
    _cityId = cityId;
    _stateId = stateId;
    _countryName = countryName;
    _cityName = cityName;
    _stateName = stateName;
    _gurukul = gurukul;
    _qualification = qualification;
    _qualificationOther = qualificationOther;
    _experience = experience;
    _experienceOther = experienceOther;
    _address = address;
    _certificate = certificate;
    _certificateName = certificateName;
    _timestamp = timestamp;
    _profilePic = profilePic;
    _profilePicName = profilePicName;
}

  Profile.fromJson(dynamic json) {
    _id = json['id'];
    _isPasswordSet = json['is_password_set'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _mobile = json['mobile'];
    _countryCode = json['country_code'];
    _birthdate = json['birthdate'];
    _birthdateOld = json['birthdate_old'];
    _birthplace = json['birthplace'];
    _pathshala = json['pathshala'];
    _gender = json['gender'];
    _genderLabel = json['gender_label'];
    _country = json['country'];
    _city = json['city'];
    _state = json['state'];
    _countryId = json['country_id'];
    _cityId = json['city_id'];
    _stateId = json['state_id'];
    _countryName = json['country_name'];
    _cityName = json['city_name'];
    _stateName = json['state_name'];
    _gurukul = json['gurukul'];
    _qualification = json['qualification'];
    _qualificationOther = json['qualification_other'];
    _experience = json['experience'];
    _experienceOther = json['experience_other'];
    _address = json['address'];
    _certificate = json['certificate'];
    _certificateName = json['certificate_name'];
    _timestamp = json['timestamp'];
    _profilePic = json['profile_pic'];
    _profilePicName = json['profile_pic_name'];
  }
  String? _id;
  num? _isPasswordSet;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _mobile;
  String? _countryCode;
  String? _birthdate;
  String? _birthdateOld;
  String? _birthplace;
  String? _pathshala;
  String? _gender;
  String? _genderLabel;
  String? _country;
  String? _city;
  String? _state;
  String? _countryId;
  String? _cityId;
  String? _stateId;
  String? _countryName;
  String? _cityName;
  String? _stateName;
  String? _gurukul;
  String? _qualification;
  String? _qualificationOther;
  String? _experience;
  String? _experienceOther;
  String? _address;
  String? _certificate;
  String? _certificateName;
  String? _timestamp;
  String? _profilePic;
  String? _profilePicName;
Profile copyWith({  String? id,
  num? isPasswordSet,
  String? firstName,
  String? lastName,
  String? email,
  String? mobile,
  String? countryCode,
  String? birthdate,
  String? birthdateOld,
  String? birthplace,
  String? pathshala,
  String? gender,
  String? genderLabel,
  String? country,
  String? city,
  String? state,
  String? countryId,
  String? cityId,
  String? stateId,
  String? countryName,
  String? cityName,
  String? stateName,
  String? gurukul,
  String? qualification,
  String? qualificationOther,
  String? experience,
  String? experienceOther,
  String? address,
  String? certificate,
  String? certificateName,
  String? timestamp,
  String? profilePic,
  String? profilePicName,
}) => Profile(  id: id ?? _id,
  isPasswordSet: isPasswordSet ?? _isPasswordSet,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  mobile: mobile ?? _mobile,
  countryCode: countryCode ?? _countryCode,
  birthdate: birthdate ?? _birthdate,
  birthdateOld: birthdateOld ?? _birthdateOld,
  birthplace: birthplace ?? _birthplace,
  pathshala: pathshala ?? _pathshala,
  gender: gender ?? _gender,
  genderLabel: genderLabel ?? _genderLabel,
  country: country ?? _country,
  city: city ?? _city,
  state: state ?? _state,
  countryId: countryId ?? _countryId,
  cityId: cityId ?? _cityId,
  stateId: stateId ?? _stateId,
  countryName: countryName ?? _countryName,
  cityName: cityName ?? _cityName,
  stateName: stateName ?? _stateName,
  gurukul: gurukul ?? _gurukul,
  qualification: qualification ?? _qualification,
  qualificationOther: qualificationOther ?? _qualificationOther,
  experience: experience ?? _experience,
  experienceOther: experienceOther ?? _experienceOther,
  address: address ?? _address,
  certificate: certificate ?? _certificate,
  certificateName: certificateName ?? _certificateName,
  timestamp: timestamp ?? _timestamp,
  profilePic: profilePic ?? _profilePic,
  profilePicName: profilePicName ?? _profilePicName,
);
  String? get id => _id;
  num? get isPasswordSet => _isPasswordSet;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get mobile => _mobile;

  set id(String? value) {
    _id = value;
  }

  String? get countryCode => _countryCode;
  String? get birthdate => _birthdate;
  String? get birthdateOld => _birthdateOld;
  String? get birthplace => _birthplace;
  String? get pathshala => _pathshala;
  String? get gender => _gender;
  String? get genderLabel => _genderLabel;
  String? get country => _country;
  String? get city => _city;
  String? get state => _state;
  String? get countryId => _countryId;
  String? get cityId => _cityId;
  String? get stateId => _stateId;
  String? get countryName => _countryName;
  String? get cityName => _cityName;
  String? get stateName => _stateName;
  String? get gurukul => _gurukul;
  String? get qualification => _qualification;
  String? get qualificationOther => _qualificationOther;
  String? get experience => _experience;
  String? get experienceOther => _experienceOther;
  String? get address => _address;
  String? get certificate => _certificate;
  String? get certificateName => _certificateName;
  String? get timestamp => _timestamp;
  String? get profilePic => _profilePic;
  String? get profilePicName => _profilePicName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['is_password_set'] = _isPasswordSet;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['country_code'] = _countryCode;
    map['birthdate'] = _birthdate;
    map['birthdate_old'] = _birthdateOld;
    map['birthplace'] = _birthplace;
    map['pathshala'] = _pathshala;
    map['gender'] = _gender;
    map['gender_label'] = _genderLabel;
    map['country'] = _country;
    map['city'] = _city;
    map['state'] = _state;
    map['country_id'] = _countryId;
    map['city_id'] = _cityId;
    map['state_id'] = _stateId;
    map['country_name'] = _countryName;
    map['city_name'] = _cityName;
    map['state_name'] = _stateName;
    map['gurukul'] = _gurukul;
    map['qualification'] = _qualification;
    map['qualification_other'] = _qualificationOther;
    map['experience'] = _experience;
    map['experience_other'] = _experienceOther;
    map['address'] = _address;
    map['certificate'] = _certificate;
    map['certificate_name'] = _certificateName;
    map['timestamp'] = _timestamp;
    map['profile_pic'] = _profilePic;
    map['profile_pic_name'] = _profilePicName;
    return map;
  }

  set isPasswordSet(num? value) {
    _isPasswordSet = value;
  }

  set firstName(String? value) {
    _firstName = value;
  }

  set lastName(String? value) {
    _lastName = value;
  }

  set email(String? value) {
    _email = value;
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

  set birthdateOld(String? value) {
    _birthdateOld = value;
  }

  set birthplace(String? value) {
    _birthplace = value;
  }

  set pathshala(String? value) {
    _pathshala = value;
  }

  set gender(String? value) {
    _gender = value;
  }

  set genderLabel(String? value) {
    _genderLabel = value;
  }

  set country(String? value) {
    _country = value;
  }

  set city(String? value) {
    _city = value;
  }

  set state(String? value) {
    _state = value;
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

  set gurukul(String? value) {
    _gurukul = value;
  }

  set qualification(String? value) {
    _qualification = value;
  }

  set qualificationOther(String? value) {
    _qualificationOther = value;
  }

  set experience(String? value) {
    _experience = value;
  }

  set experienceOther(String? value) {
    _experienceOther = value;
  }

  set address(String? value) {
    _address = value;
  }

  set certificate(String? value) {
    _certificate = value;
  }

  set certificateName(String? value) {
    _certificateName = value;
  }

  set timestamp(String? value) {
    _timestamp = value;
  }

  set profilePic(String? value) {
    _profilePic = value;
  }

  set profilePicName(String? value) {
    _profilePicName = value;
  }
}