import 'dart:convert';
/// astrology : {"astrology_id":"98","first_name":"Umang","last_name":"Tank","email":"Umang@coronation.in","mobile":"9727727816","birth_date":"11 Oct,2023","birth_time":"5:48 PM","country_id":null,"state_id":null,"city_id":null,"address":"Surendranagar, Gujarat, India","timestamp":"1697458761","date":"16 October, 2023 05:49 PM","comments":"umang test jay","country":"","state":"","city":""}

AstroDetailResponseModel astroDetailResponseModelFromJson(String str) => AstroDetailResponseModel.fromJson(json.decode(str));
String astroDetailResponseModelToJson(AstroDetailResponseModel data) => json.encode(data.toJson());
class AstroDetailResponseModel {
  AstroDetailResponseModel({
      Astrology? astrology,}){
    _astrology = astrology;
}

  AstroDetailResponseModel.fromJson(dynamic json) {
    _astrology = json['astrology'] != null ? Astrology.fromJson(json['astrology']) : null;
  }
  Astrology? _astrology;
AstroDetailResponseModel copyWith({  Astrology? astrology,
}) => AstroDetailResponseModel(  astrology: astrology ?? _astrology,
);
  Astrology? get astrology => _astrology;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_astrology != null) {
      map['astrology'] = _astrology?.toJson();
    }
    return map;
  }

}

/// astrology_id : "98"
/// first_name : "Umang"
/// last_name : "Tank"
/// email : "Umang@coronation.in"
/// mobile : "9727727816"
/// birth_date : "11 Oct,2023"
/// birth_time : "5:48 PM"
/// country_id : null
/// state_id : null
/// city_id : null
/// address : "Surendranagar, Gujarat, India"
/// timestamp : "1697458761"
/// date : "16 October, 2023 05:49 PM"
/// comments : "umang test jay"
/// country : ""
/// state : ""
/// city : ""

Astrology astrologyFromJson(String str) => Astrology.fromJson(json.decode(str));
String astrologyToJson(Astrology data) => json.encode(data.toJson());
class Astrology {
  Astrology({
      String? astrologyId, 
      String? firstName, 
      String? lastName, 
      String? email, 
      String? mobile, 
      String? birthDate, 
      String? birthTime, 
      dynamic countryId, 
      dynamic stateId, 
      dynamic cityId, 
      String? address, 
      String? timestamp, 
      String? date, 
      String? comments, 
      String? country, 
      String? state, 
      String? city,}){
    _astrologyId = astrologyId;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _mobile = mobile;
    _birthDate = birthDate;
    _birthTime = birthTime;
    _countryId = countryId;
    _stateId = stateId;
    _cityId = cityId;
    _address = address;
    _timestamp = timestamp;
    _date = date;
    _comments = comments;
    _country = country;
    _state = state;
    _city = city;
}

  Astrology.fromJson(dynamic json) {
    _astrologyId = json['astrology_id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _mobile = json['mobile'];
    _birthDate = json['birth_date'];
    _birthTime = json['birth_time'];
    _countryId = json['country_id'];
    _stateId = json['state_id'];
    _cityId = json['city_id'];
    _address = json['address'];
    _timestamp = json['timestamp'];
    _date = json['date'];
    _comments = json['comments'];
    _country = json['country'];
    _state = json['state'];
    _city = json['city'];
  }
  String? _astrologyId;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _mobile;
  String? _birthDate;
  String? _birthTime;
  dynamic _countryId;
  dynamic _stateId;
  dynamic _cityId;
  String? _address;
  String? _timestamp;
  String? _date;
  String? _comments;
  String? _country;
  String? _state;
  String? _city;
Astrology copyWith({  String? astrologyId,
  String? firstName,
  String? lastName,
  String? email,
  String? mobile,
  String? birthDate,
  String? birthTime,
  dynamic countryId,
  dynamic stateId,
  dynamic cityId,
  String? address,
  String? timestamp,
  String? date,
  String? comments,
  String? country,
  String? state,
  String? city,
}) => Astrology(  astrologyId: astrologyId ?? _astrologyId,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  mobile: mobile ?? _mobile,
  birthDate: birthDate ?? _birthDate,
  birthTime: birthTime ?? _birthTime,
  countryId: countryId ?? _countryId,
  stateId: stateId ?? _stateId,
  cityId: cityId ?? _cityId,
  address: address ?? _address,
  timestamp: timestamp ?? _timestamp,
  date: date ?? _date,
  comments: comments ?? _comments,
  country: country ?? _country,
  state: state ?? _state,
  city: city ?? _city,
);
  String? get astrologyId => _astrologyId;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get birthDate => _birthDate;
  String? get birthTime => _birthTime;
  dynamic get countryId => _countryId;
  dynamic get stateId => _stateId;
  dynamic get cityId => _cityId;
  String? get address => _address;
  String? get timestamp => _timestamp;
  String? get date => _date;
  String? get comments => _comments;
  String? get country => _country;
  String? get state => _state;
  String? get city => _city;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['astrology_id'] = _astrologyId;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['birth_date'] = _birthDate;
    map['birth_time'] = _birthTime;
    map['country_id'] = _countryId;
    map['state_id'] = _stateId;
    map['city_id'] = _cityId;
    map['address'] = _address;
    map['timestamp'] = _timestamp;
    map['date'] = _date;
    map['comments'] = _comments;
    map['country'] = _country;
    map['state'] = _state;
    map['city'] = _city;
    return map;
  }

}