/// success : 1
/// message : ""
/// user : {"id":"41","first_name":"","last_name":"Raj","email":" raj.t@coronation.in","mobile":"  ","birthdate":"","gender":"","gender_label":"Female","address":"","timestamp":"","user_type":0,"country":"","city":"","state":"","country_id":"","city_id":"","state_id":"","country_name":"","city_name":"","state_name":"","profile_pic":"https://php1.coronation.in/kuber/api/assets/images/default-user.png","profile_pic_name":""}

class SocialResponseModel {
  SocialResponseModel({
      int? success, 
      String? message, 
      User? user,}){
    _success = success;
    _message = message;
    _user = user;
}

  SocialResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  int? _success;
  String? _message;
  User? _user;
SocialResponseModel copyWith({  int? success,
  String? message,
  User? user,
}) => SocialResponseModel(  success: success ?? _success,
  message: message ?? _message,
  user: user ?? _user,
);
  int? get success => _success;
  String? get message => _message;
  User? get user => _user;

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

/// id : "41"
/// first_name : ""
/// last_name : "Raj"
/// email : " raj.t@coronation.in"
/// mobile : "  "
/// birthdate : ""
/// gender : ""
/// gender_label : "Female"
/// address : ""
/// timestamp : ""
/// user_type : 0
/// country : ""
/// city : ""
/// state : ""
/// country_id : ""
/// city_id : ""
/// state_id : ""
/// country_name : ""
/// city_name : ""
/// state_name : ""
/// profile_pic : "https://php1.coronation.in/kuber/api/assets/images/default-user.png"
/// profile_pic_name : ""

class User {
  User({
      String? id, 
      String? firstName, 
      String? lastName, 
      String? email, 
      String? mobile, 
      String? birthdate, 
      String? gender, 
      String? genderLabel, 
      String? address, 
      String? timestamp, 
      int? userType, 
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
      String? profilePicName,}){
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
    _userType = userType;
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
}

  User.fromJson(dynamic json) {
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
    _userType = json['user_type'];
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
    _userType = userType;
  }
  String? _id;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _mobile;
  String? _birthdate;
  String? _gender;
  String? _genderLabel;
  String? _address;
  String? _timestamp;
  int? _userType;
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
User copyWith({  String? id,
  String? firstName,
  String? lastName,
  String? email,
  String? mobile,
  String? birthdate,
  String? gender,
  String? genderLabel,
  String? address,
  String? timestamp,
  int? userType,
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
}) => User(  id: id ?? _id,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  mobile: mobile ?? _mobile,
  birthdate: birthdate ?? _birthdate,
  gender: gender ?? _gender,
  genderLabel: genderLabel ?? _genderLabel,
  address: address ?? _address,
  timestamp: timestamp ?? _timestamp,
  userType: userType ?? _userType,
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
);
  String? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get birthdate => _birthdate;
  String? get gender => _gender;
  String? get genderLabel => _genderLabel;
  String? get address => _address;
  String? get timestamp => _timestamp;
  int? get userType => _userType;
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
    map['user_type'] = _userType;
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
    return map;
  }

}