import 'dart:convert';
/// success : 1
/// message : "3 records found."
/// total_records : "8"
/// records : [{"id":"9","title":"How Hindus Worships","description":"Puja involves offering light, incense, flowers and food to the deities (the gods). During Puja the worshippers will chant mantras, which are prayers and verses from the Hindu holy books. Answer the following questions about this passage in full sentences! 1) What is the Hindu worship of gods and goddesses called?","is_active":"1","is_approved":"0","timestamp":"1677755725","user_id":"1"},{"id":"8","title":"How are the 5 senses used in puja?","description":"Pujas involve the use of all five senses in the ritual: sight, smell, touch, taste, and sound. A puja can be quite an enthralling experience with colourful flowers and fruits, the smell of incense sticks and fragrances, the sounds of conch shells and bells, sacred hymns and songs, etc.","is_active":"1","is_approved":"0","timestamp":"1677755670","user_id":"1"},{"id":"7","title":"Puja is a religious experience","description":"Many Hindus practice the puja, a form of worship in which they experience a moment of connection with a deity, usually through a visual interaction with an image of the god (darshan).","is_active":"1","is_approved":"0","timestamp":"1677755628","user_id":"1"}]

ThoughtsResponseModel thoughtsResponseModelFromJson(String str) => ThoughtsResponseModel.fromJson(json.decode(str));
String thoughtsResponseModelToJson(ThoughtsResponseModel data) => json.encode(data.toJson());
class ThoughtsResponseModel {
  ThoughtsResponseModel({
      num? success, 
      String? message, 
      String? totalRecords, 
      List<Records>? records,}){
    _success = success;
    _message = message;
    _totalRecords = totalRecords;
    _records = records;
}

  ThoughtsResponseModel.fromJson(dynamic json) {
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
ThoughtsResponseModel copyWith({  num? success,
  String? message,
  String? totalRecords,
  List<Records>? records,
}) => ThoughtsResponseModel(  success: success ?? _success,
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

/// id : "9"
/// title : "How Hindus Worships"
/// description : "Puja involves offering light, incense, flowers and food to the deities (the gods). During Puja the worshippers will chant mantras, which are prayers and verses from the Hindu holy books. Answer the following questions about this passage in full sentences! 1) What is the Hindu worship of gods and goddesses called?"
/// is_active : "1"
/// is_approved : "0"
/// timestamp : "1677755725"
/// user_id : "1"

Records recordsFromJson(String str) => Records.fromJson(json.decode(str));
String recordsToJson(Records data) => json.encode(data.toJson());
class Records {
  Records({
      String? id, 
      String? title, 
      String? description, 
      String? isActive, 
      String? isApproved, 
      String? timestamp, 
      String? userId,}){
    _id = id;
    _title = title;
    _description = description;
    _isActive = isActive;
    _isApproved = isApproved;
    _timestamp = timestamp;
    _userId = userId;
}

  Records.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _isActive = json['is_active'];
    _isApproved = json['is_approved'];
    _timestamp = json['timestamp'];
    _userId = json['user_id'];
  }
  String? _id;
  String? _title;
  String? _description;
  String? _isActive;
  String? _isApproved;
  String? _timestamp;
  String? _userId;
Records copyWith({  String? id,
  String? title,
  String? description,
  String? isActive,
  String? isApproved,
  String? timestamp,
  String? userId,
}) => Records(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  isActive: isActive ?? _isActive,
  isApproved: isApproved ?? _isApproved,
  timestamp: timestamp ?? _timestamp,
  userId: userId ?? _userId,
);
  String? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get isActive => _isActive;
  String? get isApproved => _isApproved;
  String? get timestamp => _timestamp;
  String? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['is_active'] = _isActive;
    map['is_approved'] = _isApproved;
    map['timestamp'] = _timestamp;
    map['user_id'] = _userId;
    return map;
  }

}