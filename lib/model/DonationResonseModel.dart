import 'dart:convert';
/// success : 1
/// message : "Donation details saved."
/// lastInsertId : 43

DonationResonseModel donationResonseModelFromJson(String str) => DonationResonseModel.fromJson(json.decode(str));
String donationResonseModelToJson(DonationResonseModel data) => json.encode(data.toJson());
class DonationResonseModel {
  DonationResonseModel({
      num? success, 
      String? message, 
      num? lastInsertId,}){
    _success = success;
    _message = message;
    _lastInsertId = lastInsertId;
}

  DonationResonseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _lastInsertId = json['lastInsertId'];
  }
  num? _success;
  String? _message;
  num? _lastInsertId;
DonationResonseModel copyWith({  num? success,
  String? message,
  num? lastInsertId,
}) => DonationResonseModel(  success: success ?? _success,
  message: message ?? _message,
  lastInsertId: lastInsertId ?? _lastInsertId,
);
  num? get success => _success;
  String? get message => _message;
  num? get lastInsertId => _lastInsertId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    map['lastInsertId'] = _lastInsertId;
    return map;
  }

}