class RashiListResponseModel {
  RashiListResponseModel({
    required this.requests,
    required this.success,
    required this.message,
  });
  late final List<Requests> requests;
  late final int success;
  late final String message;

  RashiListResponseModel.fromJson(Map<String, dynamic> json){
    if(json['requests']!= null)
    {
      requests = List.from(json['requests']).map((e)=>Requests.fromJson(e)).toList();
    }
    else
    {
      requests=[];
    }
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['requests'] = requests.map((e)=>e.toJson()).toList();
    _data['success'] = success;
    _data['message'] = message;
    return _data;
  }
}

class Requests {
  Requests({
    required this.requestId,
    required this.motherName,
    required this.fatherName,
    required this.dateOfBirth,
    required this.timeOfBirth,
    required this.placeOfBirth,
    required this.userId,
    required this.country,
    required this.notes,
    required this.email,
    required this.state,
    required this.city,
    required this.childGender,
    required this.date,
    required this.countryName,
    required this.stateName,
    required this.cityName,
  });
  late final String requestId;
  late final String motherName;
  late final String fatherName;
  late final String dateOfBirth;
  late final String timeOfBirth;
  late final String placeOfBirth;
  late final String userId;
  late final String country;
  late final String notes;
  late final String email;
  late final String state;
  late final String city;
  late final String childGender;
  late final String date;
  late final String countryName;
  late final String stateName;
  late final String cityName;

  Requests.fromJson(Map<String, dynamic> json){
    requestId = json['request_id'];
    motherName = json['mother_name'];
    fatherName = json['father_name'];
    dateOfBirth = json['date_of_birth'];
    timeOfBirth = json['time_of_birth'];
    placeOfBirth = json['place_of_birth'];
    userId = json['user_id'];
    notes = json['notes'];
    email = json['email'];
    childGender = json['child_gender'];
    date = json['date'];
    countryName = json['country_name'];
    stateName = json['state_name'];
    cityName = json['city_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['request_id'] = requestId;
    _data['mother_name'] = motherName;
    _data['father_name'] = fatherName;
    _data['date_of_birth'] = dateOfBirth;
    _data['time_of_birth'] = timeOfBirth;
    _data['place_of_birth'] = placeOfBirth;
    _data['user_id'] = userId;
    _data['country'] = country;
    _data['notes'] = notes;
    _data['email'] = email;
    _data['state'] = state;
    _data['city'] = city;
    _data['child_gender'] = childGender;
    _data['date'] = date;
    _data['country_name'] = countryName;
    _data['state_name'] = stateName;
    _data['city_name'] = cityName;
    return _data;
  }
}