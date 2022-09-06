/// booking : {"booking_id":"1","puja_id":"15","puja_amount":"₹ 6,000","puja_name":"Sundarkand","puja_description":"In Hindu home rendering sundarkand at home for Hanuman ji blessing a team of musicians and priest come and sing sundarkand, this chopai from Ramayan","user_id":"1","username":"Jay Mistry","puja_date":"29 Jul 2022","puja_time":"11:31 PM","puja_day":"Friday","auspicious_description":"","pickup_by_user":"1","pooja_goods_provide_by_user":"0","booked_on":"29 Jul 2022","booking_address":"6R3Q+GWR, Sufi Baug, Mahidharpura, Begampura, Surat, Gujarat 395003, India","email":"jay.m@coronation.in","mobile":"7433036724"}
/// success : 1
/// message : ""

class BookingDetailsResponseModel {
  BookingDetailsResponseModel({
      Booking? booking, 
      int? success, 
      String? message,}){
    _booking = booking;
    _success = success;
    _message = message;
}

  BookingDetailsResponseModel.fromJson(dynamic json) {
    _booking = json['booking'] != null ? Booking.fromJson(json['booking']) : null;
    _success = json['success'];
    _message = json['message'];
  }
  Booking? _booking;
  int? _success;
  String? _message;
BookingDetailsResponseModel copyWith({  Booking? booking,
  int? success,
  String? message,
}) => BookingDetailsResponseModel(  booking: booking ?? _booking,
  success: success ?? _success,
  message: message ?? _message,
);
  Booking? get booking => _booking;
  int? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_booking != null) {
      map['booking'] = _booking?.toJson();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// booking_id : "1"
/// puja_id : "15"
/// puja_amount : "₹ 6,000"
/// puja_name : "Sundarkand"
/// puja_description : "In Hindu home rendering sundarkand at home for Hanuman ji blessing a team of musicians and priest come and sing sundarkand, this chopai from Ramayan"
/// user_id : "1"
/// username : "Jay Mistry"
/// puja_date : "29 Jul 2022"
/// puja_time : "11:31 PM"
/// puja_day : "Friday"
/// auspicious_description : ""
/// pickup_by_user : "1"
/// pooja_goods_provide_by_user : "0"
/// booked_on : "29 Jul 2022"
/// booking_address : "6R3Q+GWR, Sufi Baug, Mahidharpura, Begampura, Surat, Gujarat 395003, India"
/// email : "jay.m@coronation.in"
/// mobile : "7433036724"

class Booking {
  Booking({
      String? bookingId, 
      String? pujaId, 
      String? pujaAmount, 
      String? pujaName, 
      String? pujaDescription, 
      String? userId, 
      String? username, 
      String? pujaDate, 
      String? pujaTime, 
      String? pujaDay, 
      String? auspiciousDescription, 
      String? pickupByUser, 
      String? poojaGoodsProvideByUser, 
      String? bookedOn, 
      String? bookingAddress, 
      String? email, 
      String? mobile,}){
    _bookingId = bookingId;
    _pujaId = pujaId;
    _pujaAmount = pujaAmount;
    _pujaName = pujaName;
    _pujaDescription = pujaDescription;
    _userId = userId;
    _username = username;
    _pujaDate = pujaDate;
    _pujaTime = pujaTime;
    _pujaDay = pujaDay;
    _auspiciousDescription = auspiciousDescription;
    _pickupByUser = pickupByUser;
    _poojaGoodsProvideByUser = poojaGoodsProvideByUser;
    _bookedOn = bookedOn;
    _bookingAddress = bookingAddress;
    _email = email;
    _mobile = mobile;
}

  Booking.fromJson(dynamic json) {
    _bookingId = json['booking_id'];
    _pujaId = json['puja_id'];
    _pujaAmount = json['puja_amount'];
    _pujaName = json['puja_name'];
    _pujaDescription = json['puja_description'];
    _userId = json['user_id'];
    _username = json['username'];
    _pujaDate = json['puja_date'];
    _pujaTime = json['puja_time'];
    _pujaDay = json['puja_day'];
    _auspiciousDescription = json['auspicious_description'];
    _pickupByUser = json['pickup_by_user'];
    _poojaGoodsProvideByUser = json['pooja_goods_provide_by_user'];
    _bookedOn = json['booked_on'];
    _bookingAddress = json['booking_address'];
    _email = json['email'];
    _mobile = json['mobile'];
  }
  String? _bookingId;
  String? _pujaId;
  String? _pujaAmount;
  String? _pujaName;
  String? _pujaDescription;
  String? _userId;
  String? _username;
  String? _pujaDate;
  String? _pujaTime;
  String? _pujaDay;
  String? _auspiciousDescription;
  String? _pickupByUser;
  String? _poojaGoodsProvideByUser;
  String? _bookedOn;
  String? _bookingAddress;
  String? _email;
  String? _mobile;
Booking copyWith({  String? bookingId,
  String? pujaId,
  String? pujaAmount,
  String? pujaName,
  String? pujaDescription,
  String? userId,
  String? username,
  String? pujaDate,
  String? pujaTime,
  String? pujaDay,
  String? auspiciousDescription,
  String? pickupByUser,
  String? poojaGoodsProvideByUser,
  String? bookedOn,
  String? bookingAddress,
  String? email,
  String? mobile,
}) => Booking(  bookingId: bookingId ?? _bookingId,
  pujaId: pujaId ?? _pujaId,
  pujaAmount: pujaAmount ?? _pujaAmount,
  pujaName: pujaName ?? _pujaName,
  pujaDescription: pujaDescription ?? _pujaDescription,
  userId: userId ?? _userId,
  username: username ?? _username,
  pujaDate: pujaDate ?? _pujaDate,
  pujaTime: pujaTime ?? _pujaTime,
  pujaDay: pujaDay ?? _pujaDay,
  auspiciousDescription: auspiciousDescription ?? _auspiciousDescription,
  pickupByUser: pickupByUser ?? _pickupByUser,
  poojaGoodsProvideByUser: poojaGoodsProvideByUser ?? _poojaGoodsProvideByUser,
  bookedOn: bookedOn ?? _bookedOn,
  bookingAddress: bookingAddress ?? _bookingAddress,
  email: email ?? _email,
  mobile: mobile ?? _mobile,
);
  String? get bookingId => _bookingId;
  String? get pujaId => _pujaId;
  String? get pujaAmount => _pujaAmount;
  String? get pujaName => _pujaName;
  String? get pujaDescription => _pujaDescription;
  String? get userId => _userId;
  String? get username => _username;
  String? get pujaDate => _pujaDate;
  String? get pujaTime => _pujaTime;
  String? get pujaDay => _pujaDay;
  String? get auspiciousDescription => _auspiciousDescription;
  String? get pickupByUser => _pickupByUser;
  String? get poojaGoodsProvideByUser => _poojaGoodsProvideByUser;
  String? get bookedOn => _bookedOn;
  String? get bookingAddress => _bookingAddress;
  String? get email => _email;
  String? get mobile => _mobile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['booking_id'] = _bookingId;
    map['puja_id'] = _pujaId;
    map['puja_amount'] = _pujaAmount;
    map['puja_name'] = _pujaName;
    map['puja_description'] = _pujaDescription;
    map['user_id'] = _userId;
    map['username'] = _username;
    map['puja_date'] = _pujaDate;
    map['puja_time'] = _pujaTime;
    map['puja_day'] = _pujaDay;
    map['auspicious_description'] = _auspiciousDescription;
    map['pickup_by_user'] = _pickupByUser;
    map['pooja_goods_provide_by_user'] = _poojaGoodsProvideByUser;
    map['booked_on'] = _bookedOn;
    map['booking_address'] = _bookingAddress;
    map['email'] = _email;
    map['mobile'] = _mobile;
    return map;
  }

}