import 'dart:convert';
/// success : 1
/// message : "Donation details found."
/// donation : {"id":"44","title":null,"reason_for_donation":"","amount":"11","description":null,"first_name":"Jay","last_name":"Mistry","email":"jay.m@coronation.in","country_code":null,"contact_no":"7433036724","is_approved":"1","timestamp":"1697527392","user_id":"160","payment_id":null,"payment_status":"Pending"}

DonationDetailResponseModel donationDetailResponseModelFromJson(String str) => DonationDetailResponseModel.fromJson(json.decode(str));
String donationDetailResponseModelToJson(DonationDetailResponseModel data) => json.encode(data.toJson());
class DonationDetailResponseModel {
  DonationDetailResponseModel({
      num? success, 
      String? message, 
      Donation? donation,}){
    _success = success;
    _message = message;
    _donation = donation;
}

  DonationDetailResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _donation = json['donation'] != null ? Donation.fromJson(json['donation']) : null;
  }
  num? _success;
  String? _message;
  Donation? _donation;
DonationDetailResponseModel copyWith({  num? success,
  String? message,
  Donation? donation,
}) => DonationDetailResponseModel(  success: success ?? _success,
  message: message ?? _message,
  donation: donation ?? _donation,
);
  num? get success => _success;
  String? get message => _message;
  Donation? get donation => _donation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_donation != null) {
      map['donation'] = _donation?.toJson();
    }
    return map;
  }

}

/// id : "44"
/// title : null
/// reason_for_donation : ""
/// amount : "11"
/// description : null
/// first_name : "Jay"
/// last_name : "Mistry"
/// email : "jay.m@coronation.in"
/// country_code : null
/// contact_no : "7433036724"
/// is_approved : "1"
/// timestamp : "1697527392"
/// user_id : "160"
/// payment_id : null
/// payment_status : "Pending"

Donation donationFromJson(String str) => Donation.fromJson(json.decode(str));
String donationToJson(Donation data) => json.encode(data.toJson());
class Donation {
  Donation({
      String? id, 
      dynamic title, 
      String? reasonForDonation, 
      String? amount, 
      dynamic description, 
      String? firstName, 
      String? lastName, 
      String? email, 
      dynamic countryCode, 
      String? contactNo, 
      String? isApproved, 
      String? timestamp, 
      String? userId, 
      dynamic paymentId, 
      String? paymentStatus,}){
    _id = id;
    _title = title;
    _reasonForDonation = reasonForDonation;
    _amount = amount;
    _description = description;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _countryCode = countryCode;
    _contactNo = contactNo;
    _isApproved = isApproved;
    _timestamp = timestamp;
    _userId = userId;
    _paymentId = paymentId;
    _paymentStatus = paymentStatus;
}

  Donation.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _reasonForDonation = json['reason_for_donation'];
    _amount = json['amount'];
    _description = json['description'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _countryCode = json['country_code'];
    _contactNo = json['contact_no'];
    _isApproved = json['is_approved'];
    _timestamp = json['timestamp'];
    _userId = json['user_id'];
    _paymentId = json['payment_id'];
    _paymentStatus = json['payment_status'];
  }
  String? _id;
  dynamic _title;
  String? _reasonForDonation;
  String? _amount;
  dynamic _description;
  String? _firstName;
  String? _lastName;
  String? _email;
  dynamic _countryCode;
  String? _contactNo;
  String? _isApproved;
  String? _timestamp;
  String? _userId;
  dynamic _paymentId;
  String? _paymentStatus;
Donation copyWith({  String? id,
  dynamic title,
  String? reasonForDonation,
  String? amount,
  dynamic description,
  String? firstName,
  String? lastName,
  String? email,
  dynamic countryCode,
  String? contactNo,
  String? isApproved,
  String? timestamp,
  String? userId,
  dynamic paymentId,
  String? paymentStatus,
}) => Donation(  id: id ?? _id,
  title: title ?? _title,
  reasonForDonation: reasonForDonation ?? _reasonForDonation,
  amount: amount ?? _amount,
  description: description ?? _description,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  countryCode: countryCode ?? _countryCode,
  contactNo: contactNo ?? _contactNo,
  isApproved: isApproved ?? _isApproved,
  timestamp: timestamp ?? _timestamp,
  userId: userId ?? _userId,
  paymentId: paymentId ?? _paymentId,
  paymentStatus: paymentStatus ?? _paymentStatus,
);
  String? get id => _id;
  dynamic get title => _title;
  String? get reasonForDonation => _reasonForDonation;
  String? get amount => _amount;
  dynamic get description => _description;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  dynamic get countryCode => _countryCode;
  String? get contactNo => _contactNo;
  String? get isApproved => _isApproved;
  String? get timestamp => _timestamp;
  String? get userId => _userId;
  dynamic get paymentId => _paymentId;
  String? get paymentStatus => _paymentStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['reason_for_donation'] = _reasonForDonation;
    map['amount'] = _amount;
    map['description'] = _description;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['country_code'] = _countryCode;
    map['contact_no'] = _contactNo;
    map['is_approved'] = _isApproved;
    map['timestamp'] = _timestamp;
    map['user_id'] = _userId;
    map['payment_id'] = _paymentId;
    map['payment_status'] = _paymentStatus;
    return map;
  }

}