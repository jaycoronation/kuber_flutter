/// profile : {"id":"9","first_name":"zalak","last_name":"patel","email":"zalak@coronation.in","mobile":"9737388804","birthdate":"1997-06-24","gender":"0","gender_label":"Female","address":"506,pinaccle business  park,Prahlad Nagar, Ahmedabad, Gujarat 380015, India","timestamp":"","country":"101","city":"783","state":"12","country_id":"101","city_id":"783","state_id":"12","country_name":"INDIA","city_name":"Ahmedabad","state_name":"Gujarat","profile_pic":"https://php1.coronation.in/kuber/api/assets/images/default-user.png","profile_pic_name":""}
/// success : 1
/// message : ""

class VerifyOtpResponseModel {
  VerifyOtpResponseModel({
      Profile? profile, 
      int? success, 
      String? message,}){
    _profile = profile;
    _success = success;
    _message = message;
}

  VerifyOtpResponseModel.fromJson(dynamic json) {
    _profile = json['profile'] != null ? Profile.fromJson(json['profile']) : null;
    _success = json['success'];
    _message = json['message'];
  }
  Profile? _profile;
  int? _success;
  String? _message;
VerifyOtpResponseModel copyWith({  Profile? profile,
  int? success,
  String? message,
}) => VerifyOtpResponseModel(  profile: profile ?? _profile,
  success: success ?? _success,
  message: message ?? _message,
);
  Profile? get profile => _profile;
  int? get success => _success;
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

/// id : "9"
/// first_name : "zalak"
/// last_name : "patel"
/// email : "zalak@coronation.in"
/// mobile : "9737388804"
/// birthdate : "1997-06-24"
/// gender : "0"
/// gender_label : "Female"
/// address : "506,pinaccle business  park,Prahlad Nagar, Ahmedabad, Gujarat 380015, India"
/// timestamp : ""
/// country : "101"
/// city : "783"
/// state : "12"
/// country_id : "101"
/// city_id : "783"
/// state_id : "12"
/// country_name : "INDIA"
/// city_name : "Ahmedabad"
/// state_name : "Gujarat"
/// profile_pic : "https://php1.coronation.in/kuber/api/assets/images/default-user.png"
/// profile_pic_name : ""

class Profile {
  Profile({
      dynamic  id,
      String? firstName, 
      String? lastName, 
      String? email, 
      String? mobile, 
      String? birthdate, 
      String? gender, 
      String? genderLabel, 
      String? address, 
      String? timestamp, 
      String? country, 
      String? city, 
      String? state, 
      String? countryId, 
      String? cityId, 
      String? stateId, 
      String? countryName, 
      String? cityName, 
      String? stateName, 
      String? profilePic, 
      String? profilePicName,
      String? profileType,
  }){
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _mobile = mobile;
    _birthdate = birthdate;
    _gender = gender;
    _genderLabel = genderLabel;
    _address = address;
    _timestamp = timestamp;
    _country = country;
    _city = city;
    _state = state;
    _countryId = countryId;
    _cityId = cityId;
    _stateId = stateId;
    _countryName = countryName;
    _cityName = cityName;
    _stateName = stateName;
    _profilePic = profilePic;
    _profilePicName = profilePicName;
    _profileType = profileType;
}

  Profile.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _mobile = json['mobile'];
    _birthdate = json['birthdate'];
    _gender = json['gender'];
    _genderLabel = json['gender_label'];
    _address = json['address'];
    _timestamp = json['timestamp'];
    _country = json['country'];
    _city = json['city'];
    _state = json['state'];
    _countryId = json['country_id'];
    _cityId = json['city_id'];
    _stateId = json['state_id'];
    _countryName = json['country_name'];
    _cityName = json['city_name'];
    _stateName = json['state_name'];
    _profilePic = json['profile_pic'];
    _profilePicName = json['profile_pic_name'];
    _profileType = json['type'];
  }
  dynamic _id;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _mobile;
  String? _birthdate;
  String? _gender;
  String? _genderLabel;
  String? _address;
  String? _timestamp;
  String? _country;
  String? _city;
  String? _state;
  String? _countryId;
  String? _cityId;
  String? _stateId;
  String? _countryName;
  String? _cityName;
  String? _stateName;
  String? _profilePic;
  String? _profilePicName;
  String? _profileType;
Profile copyWith({  dynamic id,
  String? firstName,
  String? lastName,
  String? email,
  String? mobile,
  String? birthdate,
  String? gender,
  String? genderLabel,
  String? address,
  String? timestamp,
  String? country,
  String? city,
  String? state,
  String? countryId,
  String? cityId,
  String? stateId,
  String? countryName,
  String? cityName,
  String? stateName,
  String? profilePic,
  String? profilePicName,
  String? profileType,
}) => Profile(  id: id ?? _id,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  mobile: mobile ?? _mobile,
  birthdate: birthdate ?? _birthdate,
  gender: gender ?? _gender,
  genderLabel: genderLabel ?? _genderLabel,
  address: address ?? _address,
  timestamp: timestamp ?? _timestamp,
  country: country ?? _country,
  city: city ?? _city,
  state: state ?? _state,
  countryId: countryId ?? _countryId,
  cityId: cityId ?? _cityId,
  stateId: stateId ?? _stateId,
  countryName: countryName ?? _countryName,
  cityName: cityName ?? _cityName,
  stateName: stateName ?? _stateName,
  profilePic: profilePic ?? _profilePic,
  profilePicName: profilePicName ?? _profilePicName,
  profileType: profileType ?? _profileType,
);

  set id(dynamic value) {
    _id = value;
  }

  dynamic get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get birthdate => _birthdate;
  String? get gender => _gender;
  String? get genderLabel => _genderLabel;
  String? get address => _address;
  String? get timestamp => _timestamp;
  String? get country => _country;
  String? get city => _city;
  String? get state => _state;
  String? get countryId => _countryId;
  String? get cityId => _cityId;
  String? get stateId => _stateId;
  String? get countryName => _countryName;
  String? get cityName => _cityName;
  String? get stateName => _stateName;
  String? get profilePic => _profilePic;
  String? get profilePicName => _profilePicName;
  String? get profileType => _profileType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['birthdate'] = _birthdate;
    map['gender'] = _gender;
    map['gender_label'] = _genderLabel;
    map['address'] = _address;
    map['timestamp'] = _timestamp;
    map['country'] = _country;
    map['city'] = _city;
    map['state'] = _state;
    map['country_id'] = _countryId;
    map['city_id'] = _cityId;
    map['state_id'] = _stateId;
    map['country_name'] = _countryName;
    map['city_name'] = _cityName;
    map['state_name'] = _stateName;
    map['profile_pic'] = _profilePic;
    map['profile_pic_name'] = _profilePicName;
    map['type'] = _profileType;
    return map;
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

  set birthdate(String? value) {
    _birthdate = value;
  }

  set gender(String? value) {
    _gender = value;
  }

  set genderLabel(String? value) {
    _genderLabel = value;
  }

  set address(String? value) {
    _address = value;
  }

  set timestamp(String? value) {
    _timestamp = value;
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

  set profilePic(String? value) {
    _profilePic = value;
  }

  set profilePicName(String? value) {
    _profilePicName = value;
  }

  set profileType(String? value) {
    _profileType = value;
  }
}