class PrayerRequestListResponseModel {
  PrayerRequestListResponseModel({
    required this.requests,
    required this.success,
    required this.message,
  });

  late final List<Requests> requests;
  late final int success;
  late final String message;

  PrayerRequestListResponseModel.fromJson(Map<String, dynamic> json) {

    if (json['requests'] != null)
    {
      requests = List.from(json['requests']).map((e) => Requests.fromJson(e)).toList();
    } else {
      requests = [];
    }
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['requests'] = requests.map((e) => e.toJson()).toList();
    _data['success'] = success;
    _data['message'] = message;
    return _data;
  }
}

class Requests {
  Requests({
    required this.name,
    required this.mobile,
    required this.requestId,
    required this.notes,
    required this.surname,
    required this.dateOfBirth,
    required this.userId,
    required this.email,
    required this.prayerId,
    required this.prayer,
    required this.countryCode,
  });

  late final String name;
  late final String mobile;
  late final String requestId;
  late final String notes;
  late final String surname;
  late final String dateOfBirth;
  late final String userId;
  late final String email;
  late final String prayerId;
  late final String prayer;
  late final String countryCode;

  Requests.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    mobile = json['mobile'] ?? "";
    requestId = json['request_id'];
    notes = json['notes'];
    surname = json['surname'] ?? "";
    dateOfBirth = json['date_of_birth'];
    userId = json['user_id'];
    email = json['email'];
    prayerId = json['prayer_id'] ?? "";
    prayer = json['prayer'] ?? "";
    countryCode = json['country_code'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['mobile'] = mobile;
    _data['request_id'] = requestId;
    _data['notes'] = notes;
    _data['surname'] = surname;
    _data['date_of_birth'] = dateOfBirth;
    _data['user_id'] = userId;
    _data['email'] = email;
    _data['prayer_id'] = prayerId;
    _data['prayer'] = prayer;
    _data['country_code'] = countryCode;
    return _data;
  }
}
