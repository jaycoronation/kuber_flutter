import 'dart:convert';
/// success : 1
/// message : "1 records found."
/// total_records : "1"
/// records : [{"id":"2","title":"Lorem\nipsum","reason_for_donation":"Gift","amount":"15000","description":"lorem","first_name":"Priya","last_name":"Khatri","email":"priya@coronation.in","contact_no":"9033629230","is_approved":"1","timestamp":"1689859214","user_id":"31"}]

DonationListResponseModel donationListResponseModelFromJson(String str) => DonationListResponseModel.fromJson(json.decode(str));
String donationListResponseModelToJson(DonationListResponseModel data) => json.encode(data.toJson());
class DonationListResponseModel {
  DonationListResponseModel({
      num? success, 
      String? message, 
      String? totalRecords, 
      List<Records>? records,}){
    _success = success;
    _message = message;
    _totalRecords = totalRecords;
    _records = records;
}

  DonationListResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _totalRecords = json['total_records'];
    if (json['records'] != null) {
      _records = [];
      json['records'].forEach((v) {
        _records?.add(Records.fromJson(v));
      });
    }
  }
  num? _success;
  String? _message;
  String? _totalRecords;
  List<Records>? _records;
DonationListResponseModel copyWith({  num? success,
  String? message,
  String? totalRecords,
  List<Records>? records,
}) => DonationListResponseModel(  success: success ?? _success,
  message: message ?? _message,
  totalRecords: totalRecords ?? _totalRecords,
  records: records ?? _records,
);
  num? get success => _success;
  String? get message => _message;
  String? get totalRecords => _totalRecords;
  List<Records>? get records => _records;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    map['total_records'] = _totalRecords;
    if (_records != null) {
      map['records'] = _records?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "2"
/// title : "Lorem\nipsum"
/// reason_for_donation : "Gift"
/// amount : "15000"
/// description : "lorem"
/// first_name : "Priya"
/// last_name : "Khatri"
/// email : "priya@coronation.in"
/// contact_no : "9033629230"
/// is_approved : "1"
/// timestamp : "1689859214"
/// user_id : "31"

Records recordsFromJson(String str) => Records.fromJson(json.decode(str));
String recordsToJson(Records data) => json.encode(data.toJson());
class Records {
  Records({
      String? id, 
      String? title, 
      String? reasonForDonation, 
      String? amount, 
      String? description, 
      String? firstName, 
      String? lastName, 
      String? email, 
      String? contactNo, 
      String? isApproved, 
      String? timestamp, 
      String? userId,}){
    _id = id;
    _title = title;
    _reasonForDonation = reasonForDonation;
    _amount = amount;
    _description = description;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _contactNo = contactNo;
    _isApproved = isApproved;
    _timestamp = timestamp;
    _userId = userId;
}

  Records.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _reasonForDonation = json['reason_for_donation'];
    _amount = json['amount'];
    _description = json['description'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _contactNo = json['contact_no'];
    _isApproved = json['is_approved'];
    _timestamp = json['timestamp'];
    _userId = json['user_id'];
  }
  String? _id;
  String? _title;
  String? _reasonForDonation;
  String? _amount;
  String? _description;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _contactNo;
  String? _isApproved;
  String? _timestamp;
  String? _userId;
Records copyWith({  String? id,
  String? title,
  String? reasonForDonation,
  String? amount,
  String? description,
  String? firstName,
  String? lastName,
  String? email,
  String? contactNo,
  String? isApproved,
  String? timestamp,
  String? userId,
}) => Records(  id: id ?? _id,
  title: title ?? _title,
  reasonForDonation: reasonForDonation ?? _reasonForDonation,
  amount: amount ?? _amount,
  description: description ?? _description,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  contactNo: contactNo ?? _contactNo,
  isApproved: isApproved ?? _isApproved,
  timestamp: timestamp ?? _timestamp,
  userId: userId ?? _userId,
);
  String? get id => _id;
  String? get title => _title;
  String? get reasonForDonation => _reasonForDonation;
  String? get amount => _amount;
  String? get description => _description;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get contactNo => _contactNo;
  String? get isApproved => _isApproved;
  String? get timestamp => _timestamp;
  String? get userId => _userId;

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
    map['contact_no'] = _contactNo;
    map['is_approved'] = _isApproved;
    map['timestamp'] = _timestamp;
    map['user_id'] = _userId;
    return map;
  }

}