import 'dart:convert';
/// puja_list : [{"puja_id":"20","puja_name":"Other","puja_items":"Oil, Mithai, Agarbatti, Dhup, Rice, Coconut","puja_items_pdf":"https://www.panditbookings.com/api/index.php/puja/puja_goods_pdf/20","puja_description":"if is your puja name in not above list pls write the puja name and office / pundit ji will advise ac...","puja_duration":"3 Hours","puja_amount":"₹ 6000","puja_count_user":"","timestamp":"1582872165"},{"puja_id":"19","puja_name":"Junda / Katha","puja_items":"Oil, Mithai, Agarbatti, Dhup, Rice, Coconut","puja_items_pdf":"https://www.panditbookings.com/api/index.php/puja/puja_goods_pdf/19","puja_description":"Flag of Hanuman ji and Shiva Hosting at hindu home, specially in south africa is very well known, de...","puja_duration":"3 Hours","puja_amount":"₹ 6000","puja_count_user":"","timestamp":"1582872165"},{"puja_id":"18","puja_name":"Navchandi","puja_items":"Oil, Mithai, Agarbatti, Dhup, Rice, Coconut","puja_items_pdf":"https://www.panditbookings.com/api/index.php/puja/puja_goods_pdf/18","puja_description":"Pundit ji offer a prayer of Durga ma, with Durga Saptashati (700 verse of mother )....","puja_duration":"3 Hours","puja_amount":"₹ 6000","puja_count_user":"","timestamp":"1582872165"},{"puja_id":"17","puja_name":"Rudrabhisek","puja_items":"Oil, Mithai, Agarbatti, Dhup, Rice, Coconut","puja_items_pdf":"https://www.panditbookings.com/api/index.php/puja/puja_goods_pdf/17","puja_description":"Offering a Milk on Shivlingeam with Rudrastadhyayi Mantra...","puja_duration":"3 Hours","puja_amount":"₹ 6000","puja_count_user":"","timestamp":"1582872165"},{"puja_id":"16","puja_name":"Pratishtha","puja_items":"Oil, Mithai, Agarbatti, Dhup, Rice, Coconut","puja_items_pdf":"https://www.panditbookings.com/api/index.php/puja/puja_goods_pdf/16","puja_description":"this prayer perform when new mandir build and officially open pratishtha, life in deities put by man...","puja_duration":"3 Hours","puja_amount":"₹ 6000","puja_count_user":"","timestamp":"1582872165"},{"puja_id":"15","puja_name":"Sundarkand","puja_items":"Oil, Mithai, Agarbatti, Dhup, Rice, Coconut","puja_items_pdf":"https://www.panditbookings.com/api/index.php/puja/puja_goods_pdf/15","puja_description":"In Hindu home rendering sundarkand at home for Hanuman ji blessing a team of musicians and priest co...","puja_duration":"3 Hours","puja_amount":"₹ 6000","puja_count_user":"","timestamp":"1582872165"},{"puja_id":"14","puja_name":"Grah, Nakshtra and Yog shanti","puja_items":"Oil, Mithai, Agarbatti, Dhup, Rice, Coconut","puja_items_pdf":"https://www.panditbookings.com/api/index.php/puja/puja_goods_pdf/14","puja_description":"People perform this kind prayers after astrological chart reading, pls write in detail, after select...","puja_duration":"3 Hours","puja_amount":"₹ 6000","puja_count_user":"","timestamp":"1582872165"},{"puja_id":"13","puja_name":"Car Puja / New Vehicle or Vahan Puja","puja_items":"Oil, Mithai, Agarbatti, Dhup, Rice, Coconut","puja_items_pdf":"https://www.panditbookings.com/api/index.php/puja/puja_goods_pdf/13","puja_description":"after buying the new vehicle, one should take to temple or priest to offer a prayer for blessings an...","puja_duration":"3 Hours","puja_amount":"₹ 6000","puja_count_user":"","timestamp":"1582872165"},{"puja_id":"12","puja_name":"Wedding ceremony","puja_items":"Oil, Mithai, Agarbatti, Dhup, Rice, Coconut","puja_items_pdf":"https://www.panditbookings.com/api/index.php/puja/puja_goods_pdf/12","puja_description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore ...","puja_duration":"3 Hours","puja_amount":"₹ 6000","puja_count_user":"","timestamp":"1582872165"},{"puja_id":"11","puja_name":"Satyanarayan Katha","puja_items":"Oil, Mithai, Agarbatti, Dhup, Rice, Coconut","puja_items_pdf":"https://www.panditbookings.com/api/index.php/puja/puja_goods_pdf/11","puja_description":"Satyanarayan katha is well known in every hindu home, once a year hindu call a pandit / priest for t...","puja_duration":"3 Hours","puja_amount":"₹ 6000","puja_count_user":"","timestamp":"1582872165"},{"puja_id":"10","puja_name":"Lakshmi puja and Havan","puja_items":"Oil, Mithai, Agarbatti, Dhup, Rice, Coconut","puja_items_pdf":"https://www.panditbookings.com/api/index.php/puja/puja_goods_pdf/10","puja_description":"For prosperity or new office, business one should offer a prayer to Lakshmi Ma...","puja_duration":"3 Hours","puja_amount":"₹ 6000","puja_count_user":"","timestamp":"1582872165"},{"puja_id":"9","puja_name":"Good Health Havan","puja_items":"Oil, Mithai, Agarbatti, Dhup, Rice, Coconut","puja_items_pdf":"https://www.panditbookings.com/api/index.php/puja/puja_goods_pdf/9","puja_description":"When someone is sick at home, hindu always offer a Havan to get well, good health and speedy recover...","puja_duration":"3 Hours","puja_amount":"₹ 6000","puja_count_user":"","timestamp":"1582872165"},{"puja_id":"8","puja_name":"Birthday Havan","puja_items":"Oil, Mithai, Agarbatti, Dhup, Rice, Coconut","puja_items_pdf":"https://www.panditbookings.com/api/index.php/puja/puja_goods_pdf/8","puja_description":"a special Mantra of Shatam Jivam Sharadah chant and Yagna perform for long and healthy life for the ...","puja_duration":"3 Hours","puja_amount":"₹ 6000","puja_count_user":"","timestamp":"1582872165"},{"puja_id":"7","puja_name":"Uttar Kriya / prayer after death","puja_items":"Oil, Mithai, Agarbatti, Dhup, Rice, Coconut","puja_items_pdf":"https://www.panditbookings.com/api/index.php/puja/puja_goods_pdf/7","puja_description":"Prayer for Aatma shanti, some places perform chautha, some places 12days, 13days and some state 16 d...","puja_duration":"3 Hours","puja_amount":"₹ 6000","puja_count_user":"","timestamp":"1582872165"},{"puja_id":"6","puja_name":"Grih Pravesh/ Vastu Puja","puja_items":"Oil, Mithai, Agarbatti, Dhup, Rice, Coconut","puja_items_pdf":"https://www.panditbookings.com/api/index.php/puja/puja_goods_pdf/6","puja_description":"known as New Home Blessings or House warming Prayer, where Pundit / Priest come and bless home to re...","puja_duration":"3 Hours","puja_amount":"₹ 6000","puja_count_user":"","timestamp":"1582872165"},{"puja_id":"5","puja_name":"Suddhi Havan","puja_items":"Oil, Mithai, Agarbatti, Dhup, Rice, Coconut","puja_items_pdf":"https://www.panditbookings.com/api/index.php/puja/puja_goods_pdf/5","puja_description":"after a new baby is born, on 21 days or after 21 days hindu families invite pandit ji to bless the b...","puja_duration":"3 Hours","puja_amount":"₹ 6000","puja_count_user":"","timestamp":"1582872165"},{"puja_id":"3","puja_name":"Ganesh Puja","puja_items":"Oil, Mithai, Agarbatti, Dhup, Rice, Coconut","puja_items_pdf":"https://www.panditbookings.com/api/index.php/puja/puja_goods_pdf/3","puja_description":"The obstacles Remover, Prayer for Ganesh ji offer before every good occasion to begin.\r\n...","puja_duration":"3 Hours","puja_amount":"₹ 6000","puja_count_user":"","timestamp":"1582872165"}]
/// total_count : "17"
/// success : 1
/// message : "puja list found."

PujaListResponseModel pujaListResponseModelFromJson(String str) => PujaListResponseModel.fromJson(json.decode(str));
String pujaListResponseModelToJson(PujaListResponseModel data) => json.encode(data.toJson());
class PujaListResponseModel {
  PujaListResponseModel({
      List<PujaList>? pujaList, 
      String? totalCount, 
      num? success, 
      String? message,}){
    _pujaList = pujaList;
    _totalCount = totalCount;
    _success = success;
    _message = message;
}

  PujaListResponseModel.fromJson(dynamic json) {
    if (json['puja_list'] != null) {
      _pujaList = [];
      json['puja_list'].forEach((v) {
        _pujaList?.add(PujaList.fromJson(v));
      });
    }
    _totalCount = json['total_count'];
    _success = json['success'];
    _message = json['message'];
  }
  List<PujaList>? _pujaList;
  String? _totalCount;
  num? _success;
  String? _message;
PujaListResponseModel copyWith({  List<PujaList>? pujaList,
  String? totalCount,
  num? success,
  String? message,
}) => PujaListResponseModel(  pujaList: pujaList ?? _pujaList,
  totalCount: totalCount ?? _totalCount,
  success: success ?? _success,
  message: message ?? _message,
);
  List<PujaList>? get pujaList => _pujaList;
  String? get totalCount => _totalCount;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_pujaList != null) {
      map['puja_list'] = _pujaList?.map((v) => v.toJson()).toList();
    }
    map['total_count'] = _totalCount;
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// puja_id : "20"
/// puja_name : "Other"
/// puja_items : "Oil, Mithai, Agarbatti, Dhup, Rice, Coconut"
/// puja_items_pdf : "https://www.panditbookings.com/api/index.php/puja/puja_goods_pdf/20"
/// puja_description : "if is your puja name in not above list pls write the puja name and office / pundit ji will advise ac..."
/// puja_duration : "3 Hours"
/// puja_amount : "₹ 6000"
/// puja_count_user : ""
/// timestamp : "1582872165"

PujaList pujaListFromJson(String str) => PujaList.fromJson(json.decode(str));
String pujaListToJson(PujaList data) => json.encode(data.toJson());
class PujaList {
  PujaList({
      String? pujaId, 
      String? pujaName, 
      String? pujaItems, 
      String? pujaItemsPdf, 
      String? pujaDescription, 
      String? pujaDuration, 
      String? pujaAmount, 
      String? pujaCountUser, 
      String? timestamp,}){
    _pujaId = pujaId;
    _pujaName = pujaName;
    _pujaItems = pujaItems;
    _pujaItemsPdf = pujaItemsPdf;
    _pujaDescription = pujaDescription;
    _pujaDuration = pujaDuration;
    _pujaAmount = pujaAmount;
    _pujaCountUser = pujaCountUser;
    _timestamp = timestamp;
}

  PujaList.fromJson(dynamic json) {
    _pujaId = json['puja_id'];
    _pujaName = json['puja_name'];
    _pujaItems = json['puja_items'];
    _pujaItemsPdf = json['puja_items_pdf'];
    _pujaDescription = json['puja_description'];
    _pujaDuration = json['puja_duration'];
    _pujaAmount = json['puja_amount'];
    _pujaCountUser = json['puja_count_user'];
    _timestamp = json['timestamp'];
  }
  String? _pujaId;
  String? _pujaName;
  String? _pujaItems;
  String? _pujaItemsPdf;
  String? _pujaDescription;
  String? _pujaDuration;
  String? _pujaAmount;
  String? _pujaCountUser;
  String? _timestamp;
PujaList copyWith({  String? pujaId,
  String? pujaName,
  String? pujaItems,
  String? pujaItemsPdf,
  String? pujaDescription,
  String? pujaDuration,
  String? pujaAmount,
  String? pujaCountUser,
  String? timestamp,
}) => PujaList(  pujaId: pujaId ?? _pujaId,
  pujaName: pujaName ?? _pujaName,
  pujaItems: pujaItems ?? _pujaItems,
  pujaItemsPdf: pujaItemsPdf ?? _pujaItemsPdf,
  pujaDescription: pujaDescription ?? _pujaDescription,
  pujaDuration: pujaDuration ?? _pujaDuration,
  pujaAmount: pujaAmount ?? _pujaAmount,
  pujaCountUser: pujaCountUser ?? _pujaCountUser,
  timestamp: timestamp ?? _timestamp,
);
  String? get pujaId => _pujaId;
  String? get pujaName => _pujaName;
  String? get pujaItems => _pujaItems;
  String? get pujaItemsPdf => _pujaItemsPdf;
  String? get pujaDescription => _pujaDescription;
  String? get pujaDuration => _pujaDuration;
  String? get pujaAmount => _pujaAmount;
  String? get pujaCountUser => _pujaCountUser;
  String? get timestamp => _timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['puja_id'] = _pujaId;
    map['puja_name'] = _pujaName;
    map['puja_items'] = _pujaItems;
    map['puja_items_pdf'] = _pujaItemsPdf;
    map['puja_description'] = _pujaDescription;
    map['puja_duration'] = _pujaDuration;
    map['puja_amount'] = _pujaAmount;
    map['puja_count_user'] = _pujaCountUser;
    map['timestamp'] = _timestamp;
    return map;
  }

}