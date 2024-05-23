import 'dart:convert';
/// profile : {"id":"88","is_password_set":1,"first_name":"Jay","last_name":"Mistry","email":"jmistry383@coronation.in","mobile":"9879144508","country_code":"+27","birthdate":"2024-02-12","birthdate_old":"2024-02-12","birthplace":"","pathshala":"Pataskala test","gender":"1","gender_label":"Male","country":"101","city":"811","state":"12","middle_name":"Rajeshbhai","gotra":"Vaisnav","work_country":"101","work_city":"1041","work_suburb":"Prahlad Nagar","country_name":"INDIA","city_name":"Bardoli","state_name":"Gujarat","gurukul":"gurujul test","qualification":"Others","qualification_other":"Palm reader, Face reader, Tarot card reader","experience":"Experienced","experience_other":"Experienced","address":"506 Pinnacle Avenue, Ambergate Busselton, WA, Australia","certificate":"","certificate_name":"","timestamp":"1708336136","document":"","profile_pic":"https://www.panditbookings.com/api/assets/uploads/profile_pic/1708435810_image_picker_E46D2978-2046-44A1-BEB5-5E95DA37B9D0-8703-000000AB5D787DEB.jpg","profile_pic_name":"1708435810_image_picker_E46D2978-2046-44A1-BEB5-5E95DA37B9D0-8703-000000AB5D787DEB.jpg"}
/// success : 1
/// message : ""

PujariResponseModel pujariResponseModelFromJson(String str) => PujariResponseModel.fromJson(json.decode(str));
String pujariResponseModelToJson(PujariResponseModel data) => json.encode(data.toJson());
class PujariResponseModel {
  PujariResponseModel({
      PujariGetSet? profile,
      num? success, 
      String? message,}){
    _profile = profile;
    _success = success;
    _message = message;
}

  PujariResponseModel.fromJson(dynamic json) {
    _profile = json['profile'] != null ? PujariGetSet.fromJson(json['profile']) : null;
    _success = json['success'];
    _message = json['message'];
  }
  PujariGetSet? _profile;
  num? _success;
  String? _message;
PujariResponseModel copyWith({  PujariGetSet? profile,
  num? success,
  String? message,
}) => PujariResponseModel(  profile: profile ?? _profile,
  success: success ?? _success,
  message: message ?? _message,
);
  PujariGetSet? get profile => _profile;
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

/// id : "88"
/// is_password_set : 1
/// first_name : "Jay"
/// last_name : "Mistry"
/// email : "jmistry383@coronation.in"
/// mobile : "9879144508"
/// country_code : "+27"
/// birthdate : "2024-02-12"
/// birthdate_old : "2024-02-12"
/// birthplace : ""
/// pathshala : "Pataskala test"
/// gender : "1"
/// gender_label : "Male"
/// country : "101"
/// city : "811"
/// state : "12"
/// middle_name : "Rajeshbhai"
/// gotra : "Vaisnav"
/// work_country : "101"
/// work_city : "1041"
/// work_suburb : "Prahlad Nagar"
/// country_name : "INDIA"
/// city_name : "Bardoli"
/// state_name : "Gujarat"
/// gurukul : "gurujul test"
/// qualification : "Others"
/// qualification_other : "Palm reader, Face reader, Tarot card reader"
/// experience : "Experienced"
/// experience_other : "Experienced"
/// address : "506 Pinnacle Avenue, Ambergate Busselton, WA, Australia"
/// certificate : ""
/// certificate_name : ""
/// timestamp : "1708336136"
/// document : ""
/// profile_pic : "https://www.panditbookings.com/api/assets/uploads/profile_pic/1708435810_image_picker_E46D2978-2046-44A1-BEB5-5E95DA37B9D0-8703-000000AB5D787DEB.jpg"
/// profile_pic_name : "1708435810_image_picker_E46D2978-2046-44A1-BEB5-5E95DA37B9D0-8703-000000AB5D787DEB.jpg"

PujariGetSet profileFromJson(String str) => PujariGetSet.fromJson(json.decode(str));
String profileToJson(PujariGetSet data) => json.encode(data.toJson());
class PujariGetSet {
  PujariGetSet({
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
      String? middleName, 
      String? gotra, 
      String? workCountry, 
      String? workCountryName,
      String? workCity,
      String? workCityName,
      String? workSuburb,
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
      String? document, 
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
    _middleName = middleName;
    _gotra = gotra;
    _workCountry = workCountry;
    _workCountryName = workCountryName;
    _workCity = workCity;
    _workSuburb = workSuburb;
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
    _document = document;
    _profilePic = profilePic;
    _profilePicName = profilePicName;
}

  PujariGetSet.fromJson(dynamic json) {
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
    _middleName = json['middle_name'];
    _gotra = json['gotra'];
    _workCountry = json['work_country'];
    _workCountryName = json['work_country_name'];
    _workCity = json['work_city'];
    _workCityName = json['work_city_name'];
    _workSuburb = json['work_suburb'];
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
    _document = json['document'];
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
  String? _middleName;
  String? _gotra;
  String? _workCountry;
  String? _workCountryName;
  String? _workCity;
  String? _workCityName;
  String? _workSuburb;
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
  String? _document;
  String? _profilePic;
  String? _profilePicName;
PujariGetSet copyWith({  String? id,
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
  String? middleName,
  String? gotra,
  String? workCountry,
  String? workCountryName,
  String? workCity,
  String? workCityName,
  String? workSuburb,
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
  String? document,
  String? profilePic,
  String? profilePicName,
}) => PujariGetSet(  id: id ?? _id,
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
  middleName: middleName ?? _middleName,
  gotra: gotra ?? _gotra,
  workCountry: workCountry ?? _workCountry,
  workCountryName: workCountryName ?? _workCountryName,
  workCity: workCity ?? _workCity,
  workCityName: workCityName ?? _workCityName,
  workSuburb: workSuburb ?? _workSuburb,
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
  document: document ?? _document,
  profilePic: profilePic ?? _profilePic,
  profilePicName: profilePicName ?? _profilePicName,
);
  String? get id => _id;
  num? get isPasswordSet => _isPasswordSet;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get mobile => _mobile;
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
  String? get middleName => _middleName;
  String? get gotra => _gotra;
  String? get workCountry => _workCountry;
  String? get workCountryName => _workCountryName;
  String? get workCity => _workCity;
  String? get workCityName => _workCityName;
  String? get workSuburb => _workSuburb;
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
  String? get document => _document;
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
    map['middle_name'] = _middleName;
    map['gotra'] = _gotra;
    map['work_country'] = _workCountry;
    map['work_country_name'] = _workCountryName;
    map['work_city'] = _workCity;
    map['work_city_name'] = _workCityName;
    map['work_suburb'] = _workSuburb;
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
    map['document'] = _document;
    map['profile_pic'] = _profilePic;
    map['profile_pic_name'] = _profilePicName;
    return map;
  }

}