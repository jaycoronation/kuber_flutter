class AstrologyListResponseModel {
  AstrologyListResponseModel({
    required this.astrology,
  });
  late final List<Astrology> astrology;

  AstrologyListResponseModel.fromJson(Map<String, dynamic> json){
    if(json['astrology']!= null){
      astrology = List.from(json['astrology']).map((e)=>Astrology.fromJson(e)).toList();
    }else{
      astrology =[];
    }
  }

  Map<String, dynamic> toJson() {

    final _data = <String, dynamic>{};
    if( _data['astrology'] != null){
      _data['astrology'] = astrology.map((e)=>e.toJson()).toList();
    }else{
      _data['astrology'] = [];
    }

    return _data;
  }
}

class Astrology {
  Astrology({
    required this.astrologyId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.birthDate,
    required this.birthTime,
    required this.countryId,
    required this.stateId,
    required this.cityId,
    required this.address,
    required this.timestamp,
    required this.notes,
    required this.date,
    required this.comments,
    required this.country,
    required this.state,
    required this.countryCode,
    required this.city,
  });
  late final String astrologyId;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String mobile;
  late final String birthDate;
  late final String birthTime;
  late final String countryId;
  late final String stateId;
  late final String cityId;
  late final String address;
  late final String timestamp;
  late final String notes;
  late final String date;
  late final String comments;
  late final String country;
  late final String state;
  late final String countryCode;
  late final String city;

  Astrology.fromJson(Map<String, dynamic> json){
    astrologyId = json['astrology_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    birthDate = json['birth_date'];
    birthTime = json['birth_time'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    address = json['address'];
    timestamp = json['timestamp'];
    notes = json['notes'];
    date = json['date'];
    comments = json['comments'];
    country = json['country'];
    state = json['state'];
    countryCode = json['country_code'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['astrology_id'] = astrologyId;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['email'] = email;
    _data['mobile'] = mobile;
    _data['birth_date'] = birthDate;
    _data['birth_time'] = birthTime;
    _data['country_id'] = countryId;
    _data['state_id'] = stateId;
    _data['city_id'] = cityId;
    _data['address'] = address;
    _data['timestamp'] = timestamp;
    _data['notes'] = notes;
    _data['date'] = date;
    _data['comments'] = comments;
    _data['country'] = country;
    _data['state'] = state;
    _data['country_code'] = countryCode;
    _data['city'] = city;
    return _data;
  }
}