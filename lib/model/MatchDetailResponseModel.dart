import 'dart:convert';
/// match : {"match_id":"130","first_name":"Jay","last_name":"Mistry","email":"jay.m@coronation.in","mobile":"7433036724","bride_name":"Jay Mistru","bride_surname":"asd","bride_birth_date":"16-10-2023","bride_birth_time":"8:43 PM","bride_country_id":null,"bride_state_id":null,"bride_city_id":null,"bride_address":"Sadar Bazaar, New Delhi, Delhi, India","groom_name":"as","groom_surname":"asd","groom_birth_date":"16-10-2023","groom_birth_time":"8:43 PM","groom_country_id":null,"groom_state_id":null,"groom_city_id":null,"groom_address":"Asda Bedminster, East Street, Bedminster, Bristol, UK","timestamp":"1697469240","date":"16 October, 2023 08:44 PM","comments":"asd","bride_country":"","bride_state":"","bride_city":"","groom_country":"","groom_state":"","groom_city":""}

MatchDetailResponseModel matchDetailResponseModelFromJson(String str) => MatchDetailResponseModel.fromJson(json.decode(str));
String matchDetailResponseModelToJson(MatchDetailResponseModel data) => json.encode(data.toJson());
class MatchDetailResponseModel {
  MatchDetailResponseModel({
      Match? match,}){
    _match = match;
}

  MatchDetailResponseModel.fromJson(dynamic json) {
    _match = json['match'] != null ? Match.fromJson(json['match']) : null;
  }
  Match? _match;
MatchDetailResponseModel copyWith({  Match? match,
}) => MatchDetailResponseModel(  match: match ?? _match,
);
  Match? get match => _match;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_match != null) {
      map['match'] = _match?.toJson();
    }
    return map;
  }

}

/// match_id : "130"
/// first_name : "Jay"
/// last_name : "Mistry"
/// email : "jay.m@coronation.in"
/// mobile : "7433036724"
/// bride_name : "Jay Mistru"
/// bride_surname : "asd"
/// bride_birth_date : "16-10-2023"
/// bride_birth_time : "8:43 PM"
/// bride_country_id : null
/// bride_state_id : null
/// bride_city_id : null
/// bride_address : "Sadar Bazaar, New Delhi, Delhi, India"
/// groom_name : "as"
/// groom_surname : "asd"
/// groom_birth_date : "16-10-2023"
/// groom_birth_time : "8:43 PM"
/// groom_country_id : null
/// groom_state_id : null
/// groom_city_id : null
/// groom_address : "Asda Bedminster, East Street, Bedminster, Bristol, UK"
/// timestamp : "1697469240"
/// date : "16 October, 2023 08:44 PM"
/// comments : "asd"
/// bride_country : ""
/// bride_state : ""
/// bride_city : ""
/// groom_country : ""
/// groom_state : ""
/// groom_city : ""

Match matchFromJson(String str) => Match.fromJson(json.decode(str));
String matchToJson(Match data) => json.encode(data.toJson());
class Match {
  Match({
      String? matchId, 
      String? firstName, 
      String? lastName, 
      String? email, 
      String? mobile, 
      String? brideName, 
      String? brideSurname, 
      String? brideBirthDate, 
      String? brideBirthTime, 
      dynamic brideCountryId, 
      dynamic brideStateId, 
      dynamic brideCityId, 
      String? brideAddress, 
      String? groomName, 
      String? groomSurname, 
      String? groomBirthDate, 
      String? groomBirthTime, 
      dynamic groomCountryId, 
      dynamic groomStateId, 
      dynamic groomCityId, 
      String? groomAddress, 
      String? timestamp, 
      String? date, 
      String? comments, 
      String? brideCountry, 
      String? brideState, 
      String? brideCity, 
      String? groomCountry, 
      String? groomState, 
      String? groomCity,}){
    _matchId = matchId;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _mobile = mobile;
    _brideName = brideName;
    _brideSurname = brideSurname;
    _brideBirthDate = brideBirthDate;
    _brideBirthTime = brideBirthTime;
    _brideCountryId = brideCountryId;
    _brideStateId = brideStateId;
    _brideCityId = brideCityId;
    _brideAddress = brideAddress;
    _groomName = groomName;
    _groomSurname = groomSurname;
    _groomBirthDate = groomBirthDate;
    _groomBirthTime = groomBirthTime;
    _groomCountryId = groomCountryId;
    _groomStateId = groomStateId;
    _groomCityId = groomCityId;
    _groomAddress = groomAddress;
    _timestamp = timestamp;
    _date = date;
    _comments = comments;
    _brideCountry = brideCountry;
    _brideState = brideState;
    _brideCity = brideCity;
    _groomCountry = groomCountry;
    _groomState = groomState;
    _groomCity = groomCity;
}

  Match.fromJson(dynamic json) {
    _matchId = json['match_id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _mobile = json['mobile'];
    _brideName = json['bride_name'];
    _brideSurname = json['bride_surname'];
    _brideBirthDate = json['bride_birth_date'];
    _brideBirthTime = json['bride_birth_time'];
    _brideCountryId = json['bride_country_id'];
    _brideStateId = json['bride_state_id'];
    _brideCityId = json['bride_city_id'];
    _brideAddress = json['bride_address'];
    _groomName = json['groom_name'];
    _groomSurname = json['groom_surname'];
    _groomBirthDate = json['groom_birth_date'];
    _groomBirthTime = json['groom_birth_time'];
    _groomCountryId = json['groom_country_id'];
    _groomStateId = json['groom_state_id'];
    _groomCityId = json['groom_city_id'];
    _groomAddress = json['groom_address'];
    _timestamp = json['timestamp'];
    _date = json['date'];
    _comments = json['comments'];
    _brideCountry = json['bride_country'];
    _brideState = json['bride_state'];
    _brideCity = json['bride_city'];
    _groomCountry = json['groom_country'];
    _groomState = json['groom_state'];
    _groomCity = json['groom_city'];
  }
  String? _matchId;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _mobile;
  String? _brideName;
  String? _brideSurname;
  String? _brideBirthDate;
  String? _brideBirthTime;
  dynamic _brideCountryId;
  dynamic _brideStateId;
  dynamic _brideCityId;
  String? _brideAddress;
  String? _groomName;
  String? _groomSurname;
  String? _groomBirthDate;
  String? _groomBirthTime;
  dynamic _groomCountryId;
  dynamic _groomStateId;
  dynamic _groomCityId;
  String? _groomAddress;
  String? _timestamp;
  String? _date;
  String? _comments;
  String? _brideCountry;
  String? _brideState;
  String? _brideCity;
  String? _groomCountry;
  String? _groomState;
  String? _groomCity;
Match copyWith({  String? matchId,
  String? firstName,
  String? lastName,
  String? email,
  String? mobile,
  String? brideName,
  String? brideSurname,
  String? brideBirthDate,
  String? brideBirthTime,
  dynamic brideCountryId,
  dynamic brideStateId,
  dynamic brideCityId,
  String? brideAddress,
  String? groomName,
  String? groomSurname,
  String? groomBirthDate,
  String? groomBirthTime,
  dynamic groomCountryId,
  dynamic groomStateId,
  dynamic groomCityId,
  String? groomAddress,
  String? timestamp,
  String? date,
  String? comments,
  String? brideCountry,
  String? brideState,
  String? brideCity,
  String? groomCountry,
  String? groomState,
  String? groomCity,
}) => Match(  matchId: matchId ?? _matchId,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  mobile: mobile ?? _mobile,
  brideName: brideName ?? _brideName,
  brideSurname: brideSurname ?? _brideSurname,
  brideBirthDate: brideBirthDate ?? _brideBirthDate,
  brideBirthTime: brideBirthTime ?? _brideBirthTime,
  brideCountryId: brideCountryId ?? _brideCountryId,
  brideStateId: brideStateId ?? _brideStateId,
  brideCityId: brideCityId ?? _brideCityId,
  brideAddress: brideAddress ?? _brideAddress,
  groomName: groomName ?? _groomName,
  groomSurname: groomSurname ?? _groomSurname,
  groomBirthDate: groomBirthDate ?? _groomBirthDate,
  groomBirthTime: groomBirthTime ?? _groomBirthTime,
  groomCountryId: groomCountryId ?? _groomCountryId,
  groomStateId: groomStateId ?? _groomStateId,
  groomCityId: groomCityId ?? _groomCityId,
  groomAddress: groomAddress ?? _groomAddress,
  timestamp: timestamp ?? _timestamp,
  date: date ?? _date,
  comments: comments ?? _comments,
  brideCountry: brideCountry ?? _brideCountry,
  brideState: brideState ?? _brideState,
  brideCity: brideCity ?? _brideCity,
  groomCountry: groomCountry ?? _groomCountry,
  groomState: groomState ?? _groomState,
  groomCity: groomCity ?? _groomCity,
);
  String? get matchId => _matchId;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get brideName => _brideName;
  String? get brideSurname => _brideSurname;
  String? get brideBirthDate => _brideBirthDate;
  String? get brideBirthTime => _brideBirthTime;
  dynamic get brideCountryId => _brideCountryId;
  dynamic get brideStateId => _brideStateId;
  dynamic get brideCityId => _brideCityId;
  String? get brideAddress => _brideAddress;
  String? get groomName => _groomName;
  String? get groomSurname => _groomSurname;
  String? get groomBirthDate => _groomBirthDate;
  String? get groomBirthTime => _groomBirthTime;
  dynamic get groomCountryId => _groomCountryId;
  dynamic get groomStateId => _groomStateId;
  dynamic get groomCityId => _groomCityId;
  String? get groomAddress => _groomAddress;
  String? get timestamp => _timestamp;
  String? get date => _date;
  String? get comments => _comments;
  String? get brideCountry => _brideCountry;
  String? get brideState => _brideState;
  String? get brideCity => _brideCity;
  String? get groomCountry => _groomCountry;
  String? get groomState => _groomState;
  String? get groomCity => _groomCity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['match_id'] = _matchId;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['bride_name'] = _brideName;
    map['bride_surname'] = _brideSurname;
    map['bride_birth_date'] = _brideBirthDate;
    map['bride_birth_time'] = _brideBirthTime;
    map['bride_country_id'] = _brideCountryId;
    map['bride_state_id'] = _brideStateId;
    map['bride_city_id'] = _brideCityId;
    map['bride_address'] = _brideAddress;
    map['groom_name'] = _groomName;
    map['groom_surname'] = _groomSurname;
    map['groom_birth_date'] = _groomBirthDate;
    map['groom_birth_time'] = _groomBirthTime;
    map['groom_country_id'] = _groomCountryId;
    map['groom_state_id'] = _groomStateId;
    map['groom_city_id'] = _groomCityId;
    map['groom_address'] = _groomAddress;
    map['timestamp'] = _timestamp;
    map['date'] = _date;
    map['comments'] = _comments;
    map['bride_country'] = _brideCountry;
    map['bride_state'] = _brideState;
    map['bride_city'] = _brideCity;
    map['groom_country'] = _groomCountry;
    map['groom_state'] = _groomState;
    map['groom_city'] = _groomCity;
    return map;
  }

}