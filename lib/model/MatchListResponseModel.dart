class MatchListResponseModel {
  MatchListResponseModel({
    required this.matches,
  });
  late final List<Matches> matches;

  MatchListResponseModel.fromJson(Map<String, dynamic> json){

    if(json['matches']!= null)
    {
      matches = List.from(json['matches']).map((e)=>Matches.fromJson(e)).toList();
    }
    else
    {
      matches=[];
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['matches'] = matches.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Matches {
  Matches({
    required this.matchId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.brideName,
    required this.brideSurname,
    required this.brideBirthDate,
    required this.brideBirthTime,
    this.brideCountryId,
    this.brideStateId,
    this.brideCityId,
    required this.brideAddress,
    required this.groomName,
    required this.groomSurname,
    required this.groomBirthDate,
    required this.groomBirthTime,
    this.groomCountryId,
    this.groomStateId,
    this.groomCityId,
    required this.groomAddress,
    required this.timestamp,
    required this.date,
    required this.comments,
    required this.brideCountry,
    required this.brideState,
    required this.brideCity,
    required this.groomCountry,
    required this.groomState,
    required this.groomCity,
  });
  late final String matchId;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String mobile;
  late final String brideName;
  late final String brideSurname;
  late final String brideBirthDate;
  late final String brideBirthTime;
  late final Null brideCountryId;
  late final Null brideStateId;
  late final Null brideCityId;
  late final String brideAddress;
  late final String groomName;
  late final String groomSurname;
  late final String groomBirthDate;
  late final String groomBirthTime;
  late final Null groomCountryId;
  late final Null groomStateId;
  late final Null groomCityId;
  late final String groomAddress;
  late final String timestamp;
  late final String date;
  late final String comments;
  late final String brideCountry;
  late final String brideState;
  late final String brideCity;
  late final String groomCountry;
  late final String groomState;
  late final String groomCity;

  Matches.fromJson(Map<String, dynamic> json){
    matchId = json['match_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    brideName = json['bride_name'];
    brideSurname = json['bride_surname'];
    brideBirthDate = json['bride_birth_date'];
    brideBirthTime = json['bride_birth_time'];
    brideCountryId = null;
    brideStateId = null;
    brideCityId = null;
    brideAddress = json['bride_address'];
    groomName = json['groom_name'];
    groomSurname = json['groom_surname'];
    groomBirthDate = json['groom_birth_date'];
    groomBirthTime = json['groom_birth_time'];
    groomCountryId = null;
    groomStateId = null;
    groomCityId = null;
    groomAddress = json['groom_address'];
    timestamp = json['timestamp'];
    date = json['date'];
    comments = json['comments'];
    brideCountry = json['bride_country'];
    brideState = json['bride_state'];
    brideCity = json['bride_city'];
    groomCountry = json['groom_country'];
    groomState = json['groom_state'];
    groomCity = json['groom_city'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['match_id'] = matchId;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['email'] = email;
    _data['mobile'] = mobile;
    _data['bride_name'] = brideName;
    _data['bride_surname'] = brideSurname;
    _data['bride_birth_date'] = brideBirthDate;
    _data['bride_birth_time'] = brideBirthTime;
    _data['bride_country_id'] = brideCountryId;
    _data['bride_state_id'] = brideStateId;
    _data['bride_city_id'] = brideCityId;
    _data['bride_address'] = brideAddress;
    _data['groom_name'] = groomName;
    _data['groom_surname'] = groomSurname;
    _data['groom_birth_date'] = groomBirthDate;
    _data['groom_birth_time'] = groomBirthTime;
    _data['groom_country_id'] = groomCountryId;
    _data['groom_state_id'] = groomStateId;
    _data['groom_city_id'] = groomCityId;
    _data['groom_address'] = groomAddress;
    _data['timestamp'] = timestamp;
    _data['date'] = date;
    _data['comments'] = comments;
    _data['bride_country'] = brideCountry;
    _data['bride_state'] = brideState;
    _data['bride_city'] = brideCity;
    _data['groom_country'] = groomCountry;
    _data['groom_state'] = groomState;
    _data['groom_city'] = groomCity;
    return _data;
  }
}