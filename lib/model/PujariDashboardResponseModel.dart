import 'dart:convert';
/// booking : [{"booking_id":"230","username":"Jay Gandhi","email":"jay.g@coronation.in","mobile":"8734944007","country_code":"+27","puja_name":"Other","pickup_by_user":"Yes","pooja_goods_provide_by_user":"Yes","puja_description":"if is your puja name in not above list pls write the puja name and office / pundit ji will advise accordingly","booking_date":"07 November, 2023 11:54 AM","booked_on":"07 November, 2023 11:54 AM"}]
/// count : "1"
/// success : 1
/// message : ""

PujariDashboardResponseModel pujariDashboardResponseModelFromJson(String str) => PujariDashboardResponseModel.fromJson(json.decode(str));
String pujariDashboardResponseModelToJson(PujariDashboardResponseModel data) => json.encode(data.toJson());
class PujariDashboardResponseModel {
  PujariDashboardResponseModel({
      List<Booking>? booking, 
      String? count, 
      num? success, 
      String? message,}){
    _booking = booking;
    _count = count;
    _success = success;
    _message = message;
}

  PujariDashboardResponseModel.fromJson(dynamic json) {
    if (json['booking'] != null) {
      _booking = [];
      json['booking'].forEach((v) {
        _booking?.add(Booking.fromJson(v));
      });
    }
    _count = json['count'];
    _success = json['success'];
    _message = json['message'];
  }
  List<Booking>? _booking;
  String? _count;
  num? _success;
  String? _message;
PujariDashboardResponseModel copyWith({  List<Booking>? booking,
  String? count,
  num? success,
  String? message,
}) => PujariDashboardResponseModel(  booking: booking ?? _booking,
  count: count ?? _count,
  success: success ?? _success,
  message: message ?? _message,
);
  List<Booking>? get booking => _booking;
  String? get count => _count;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_booking != null) {
      map['booking'] = _booking?.map((v) => v.toJson()).toList();
    }
    map['count'] = _count;
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// booking_id : "230"
/// username : "Jay Gandhi"
/// email : "jay.g@coronation.in"
/// mobile : "8734944007"
/// country_code : "+27"
/// puja_name : "Other"
/// pickup_by_user : "Yes"
/// pooja_goods_provide_by_user : "Yes"
/// puja_description : "if is your puja name in not above list pls write the puja name and office / pundit ji will advise accordingly"
/// booking_date : "07 November, 2023 11:54 AM"
/// booked_on : "07 November, 2023 11:54 AM"

Booking bookingFromJson(String str) => Booking.fromJson(json.decode(str));
String bookingToJson(Booking data) => json.encode(data.toJson());
class Booking {
  Booking({
      String? bookingId, 
      String? username, 
      String? email, 
      String? mobile, 
      String? countryCode, 
      String? pujaName, 
      String? pickupByUser, 
      String? poojaGoodsProvideByUser, 
      String? pujaDescription, 
      String? bookingDate, 
      String? bookedOn,}){
    _bookingId = bookingId;
    _username = username;
    _email = email;
    _mobile = mobile;
    _countryCode = countryCode;
    _pujaName = pujaName;
    _pickupByUser = pickupByUser;
    _poojaGoodsProvideByUser = poojaGoodsProvideByUser;
    _pujaDescription = pujaDescription;
    _bookingDate = bookingDate;
    _bookedOn = bookedOn;
}

  Booking.fromJson(dynamic json) {
    _bookingId = json['booking_id'];
    _username = json['username'];
    _email = json['email'];
    _mobile = json['mobile'];
    _countryCode = json['country_code'];
    _pujaName = json['puja_name'];
    _pickupByUser = json['pickup_by_user'];
    _poojaGoodsProvideByUser = json['pooja_goods_provide_by_user'];
    _pujaDescription = json['puja_description'];
    _bookingDate = json['booking_date'];
    _bookedOn = json['booked_on'];
  }
  String? _bookingId;
  String? _username;
  String? _email;
  String? _mobile;
  String? _countryCode;
  String? _pujaName;
  String? _pickupByUser;
  String? _poojaGoodsProvideByUser;
  String? _pujaDescription;
  String? _bookingDate;
  String? _bookedOn;
Booking copyWith({  String? bookingId,
  String? username,
  String? email,
  String? mobile,
  String? countryCode,
  String? pujaName,
  String? pickupByUser,
  String? poojaGoodsProvideByUser,
  String? pujaDescription,
  String? bookingDate,
  String? bookedOn,
}) => Booking(  bookingId: bookingId ?? _bookingId,
  username: username ?? _username,
  email: email ?? _email,
  mobile: mobile ?? _mobile,
  countryCode: countryCode ?? _countryCode,
  pujaName: pujaName ?? _pujaName,
  pickupByUser: pickupByUser ?? _pickupByUser,
  poojaGoodsProvideByUser: poojaGoodsProvideByUser ?? _poojaGoodsProvideByUser,
  pujaDescription: pujaDescription ?? _pujaDescription,
  bookingDate: bookingDate ?? _bookingDate,
  bookedOn: bookedOn ?? _bookedOn,
);
  String? get bookingId => _bookingId;
  String? get username => _username;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get countryCode => _countryCode;
  String? get pujaName => _pujaName;
  String? get pickupByUser => _pickupByUser;
  String? get poojaGoodsProvideByUser => _poojaGoodsProvideByUser;
  String? get pujaDescription => _pujaDescription;
  String? get bookingDate => _bookingDate;
  String? get bookedOn => _bookedOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['booking_id'] = _bookingId;
    map['username'] = _username;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['country_code'] = _countryCode;
    map['puja_name'] = _pujaName;
    map['pickup_by_user'] = _pickupByUser;
    map['pooja_goods_provide_by_user'] = _poojaGoodsProvideByUser;
    map['puja_description'] = _pujaDescription;
    map['booking_date'] = _bookingDate;
    map['booked_on'] = _bookedOn;
    return map;
  }

}