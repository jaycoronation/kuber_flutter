/// puja : {"puja_id":"19","puja_name":"Junda / Katha","puja_description":"Flag of Hanuman ji and Shiva Hosting at hindu home, specially in south africa is very well known, devotee also do katha and sometime Bundi path write details note when you book puja.","puja_duration":"3 Hours","puja_amount":"₹ 6000","puja_items":[],"puja_count_user":"","puja_images":[],"timestamp":"1582872165"}
/// success : 1
/// message : "Puja detail found."

class PujaDetailsResponseModel {
  PujaDetailsResponseModel({
      Puja? puja, 
      int? success, 
      String? message,}){
    _puja = puja;
    _success = success;
    _message = message;
}

  PujaDetailsResponseModel.fromJson(dynamic json) {
    _puja = json['puja'] != null ? Puja.fromJson(json['puja']) : null;
    _success = json['success'];
    _message = json['message'];
  }
  Puja? _puja;
  int? _success;
  String? _message;
PujaDetailsResponseModel copyWith({  Puja? puja,
  int? success,
  String? message,
}) => PujaDetailsResponseModel(  puja: puja ?? _puja,
  success: success ?? _success,
  message: message ?? _message,
);
  Puja? get puja => _puja;
  int? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_puja != null) {
      map['puja'] = _puja?.toJson();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// puja_id : "19"
/// puja_name : "Junda / Katha"
/// puja_description : "Flag of Hanuman ji and Shiva Hosting at hindu home, specially in south africa is very well known, devotee also do katha and sometime Bundi path write details note when you book puja."
/// puja_duration : "3 Hours"
/// puja_amount : "₹ 6000"
/// puja_items : []
/// puja_count_user : ""
/// puja_images : []
/// timestamp : "1582872165"

class Puja {
  Puja({
      String? pujaId, 
      String? pujaName, 
      String? pujaDescription, 
      String? pujaDuration, 
      String? pujaAmount, 
      List<dynamic>? pujaItems, 
      String? pujaCountUser, 
      List<dynamic>? pujaImages, 
      String? timestamp,}){
    _pujaId = pujaId;
    _pujaName = pujaName;
    _pujaDescription = pujaDescription;
    _pujaDuration = pujaDuration;
    _pujaAmount = pujaAmount;
    _pujaItems = pujaItems;
    _pujaCountUser = pujaCountUser;
    _pujaImages = pujaImages;
    _timestamp = timestamp;
}

  Puja.fromJson(dynamic json) {
    _pujaId = json['puja_id'];
    _pujaName = json['puja_name'];
    _pujaDescription = json['puja_description'];
    _pujaDuration = json['puja_duration'];
    _pujaAmount = json['puja_amount'];
    if (json['puja_items'] != null) {
      _pujaItems = [];
      json['puja_items'].forEach((v) {
        //_pujaItems?.add(Dynamic.fromJson(v));
      });
    }
    _pujaCountUser = json['puja_count_user'];
    if (json['puja_images'] != null) {
      _pujaImages = [];
      json['puja_images'].forEach((v) {
      //  _pujaImages?.add(Dynamic.fromJson(v));
      });
    }
    _timestamp = json['timestamp'];
  }
  String? _pujaId;
  String? _pujaName;
  String? _pujaDescription;
  String? _pujaDuration;
  String? _pujaAmount;
  List<dynamic>? _pujaItems;
  String? _pujaCountUser;
  List<dynamic>? _pujaImages;
  String? _timestamp;
Puja copyWith({  String? pujaId,
  String? pujaName,
  String? pujaDescription,
  String? pujaDuration,
  String? pujaAmount,
  List<dynamic>? pujaItems,
  String? pujaCountUser,
  List<dynamic>? pujaImages,
  String? timestamp,
}) => Puja(  pujaId: pujaId ?? _pujaId,
  pujaName: pujaName ?? _pujaName,
  pujaDescription: pujaDescription ?? _pujaDescription,
  pujaDuration: pujaDuration ?? _pujaDuration,
  pujaAmount: pujaAmount ?? _pujaAmount,
  pujaItems: pujaItems ?? _pujaItems,
  pujaCountUser: pujaCountUser ?? _pujaCountUser,
  pujaImages: pujaImages ?? _pujaImages,
  timestamp: timestamp ?? _timestamp,
);
  String? get pujaId => _pujaId;
  String? get pujaName => _pujaName;
  String? get pujaDescription => _pujaDescription;
  String? get pujaDuration => _pujaDuration;
  String? get pujaAmount => _pujaAmount;
  List<dynamic>? get pujaItems => _pujaItems;
  String? get pujaCountUser => _pujaCountUser;
  List<dynamic>? get pujaImages => _pujaImages;
  String? get timestamp => _timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['puja_id'] = _pujaId;
    map['puja_name'] = _pujaName;
    map['puja_description'] = _pujaDescription;
    map['puja_duration'] = _pujaDuration;
    map['puja_amount'] = _pujaAmount;
    if (_pujaItems != null) {
      map['puja_items'] = _pujaItems?.map((v) => v.toJson()).toList();
    }
    map['puja_count_user'] = _pujaCountUser;
    if (_pujaImages != null) {
      map['puja_images'] = _pujaImages?.map((v) => v.toJson()).toList();
    }
    map['timestamp'] = _timestamp;
    return map;
  }

}