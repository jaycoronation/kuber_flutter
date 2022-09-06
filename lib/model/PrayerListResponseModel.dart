/// prayers : [{"prayer_id":"1","prayer":"sickness"},{"prayer_id":"2","prayer":"New born baby"},{"prayer_id":"3","prayer":"Marrige breaking"},{"prayer_id":"4","prayer":"Healing"},{"prayer_id":"5","prayer":"trauma"},{"prayer_id":"6","prayer":"suicidal thoughts"}]
/// success : 1
/// message : ""

class PrayerListResponseModel {
  PrayerListResponseModel({
      List<Prayers>? prayers, 
      int? success, 
      String? message,}){
    _prayers = prayers;
    _success = success;
    _message = message;
}

  PrayerListResponseModel.fromJson(dynamic json) {
    if (json['prayers'] != null) {
      _prayers = [];
      json['prayers'].forEach((v) {
        _prayers?.add(Prayers.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<Prayers>? _prayers;
  int? _success;
  String? _message;
PrayerListResponseModel copyWith({  List<Prayers>? prayers,
  int? success,
  String? message,
}) => PrayerListResponseModel(  prayers: prayers ?? _prayers,
  success: success ?? _success,
  message: message ?? _message,
);
  List<Prayers>? get prayers => _prayers;
  int? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_prayers != null) {
      map['prayers'] = _prayers?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// prayer_id : "1"
/// prayer : "sickness"

class Prayers {
  Prayers({
      String? prayerId, 
      String? prayer,}){
    _prayerId = prayerId;
    _prayer = prayer;
}

  Prayers.fromJson(dynamic json) {
    _prayerId = json['prayer_id'];
    _prayer = json['prayer'];
  }
  String? _prayerId;
  String? _prayer;
Prayers copyWith({  String? prayerId,
  String? prayer,
}) => Prayers(  prayerId: prayerId ?? _prayerId,
  prayer: prayer ?? _prayer,
);
  String? get prayerId => _prayerId;
  String? get prayer => _prayer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['prayer_id'] = _prayerId;
    map['prayer'] = _prayer;
    return map;
  }

}