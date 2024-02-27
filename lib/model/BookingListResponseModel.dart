  /// booking_list : [{"booking_address":"Corporate Rd, Prahlad Nagar, Ahmedabad, Gujarat 380015, India","puja_id":"6","booking_id":"9","email":"jay.m@coronation.in","mobile":"7433036724","puja_name":"Grih Pravesh/ Vastu Puja","puja_short_description":"known as New Home Blessings or House warming Prayer, where Pundit / Priest come and bless home to re...","pickup_by_user":"","pooja_goods_provide_by_user":"1","auspicious_description":"","puja_description":"known as New Home Blessings or House warming Prayer, where Pundit / Priest come and bless home to remove all negativity and Vastu Dosh, that day yajman enter in home with deities and Kumbha ( Clay pot Kalash )","puja_duration":"3 Hours","puja_amount":"₹ 6000","puja_date":"10 Aug 2022","puja_time":"07:31 PM","puja_day":"Wednesday","booked_on":"01 Aug 2022"},{"booking_address":"6R3Q+GWR, Sufi Baug, Mahidharpura, Begampura, Surat, Gujarat 395003, India","puja_id":"15","booking_id":"1","email":"jay.m@coronation.in","mobile":"7433036724","puja_name":"Sundarkand","puja_short_description":"In Hindu home rendering sundarkand at home for Hanuman ji blessing a team of musicians and priest co...","pickup_by_user":"1","pooja_goods_provide_by_user":"","auspicious_description":"","puja_description":"In Hindu home rendering sundarkand at home for Hanuman ji blessing a team of musicians and priest come and sing sundarkand, this chopai from Ramayan","puja_duration":"3 Hours","puja_amount":"₹ 6000","puja_date":"29 Jul 2022","puja_time":"11:31 PM","puja_day":"Friday","booked_on":"29 Jul 2022"}]
/// total_count : "2"
/// success : 1
/// message : "bookings list found."

class BookingListResponseModel {
  BookingListResponseModel({
      List<BookingList>? bookingList,
    dynamic? totalCount,
      int? success, 
      String? message,}){
    _bookingList = bookingList;
    _totalCount = totalCount;
    _success = success;
    _message = message;
}

  BookingListResponseModel.fromJson(dynamic json) {
    if (json['booking_list'] != null) {
      _bookingList = [];
      json['booking_list'].forEach((v) {
        _bookingList?.add(BookingList.fromJson(v));
      });
    }
    _totalCount = json['total_count'];
    _success = json['success'];
    _message = json['message'];
  }
  List<BookingList>? _bookingList;
  dynamic? _totalCount;
  int? _success;
  String? _message;
BookingListResponseModel copyWith({  List<BookingList>? bookingList,
  dynamic? totalCount,
  int? success,
  String? message,
}) => BookingListResponseModel(  bookingList: bookingList ?? _bookingList,
  totalCount: totalCount ?? _totalCount,
  success: success ?? _success,
  message: message ?? _message,
);
  List<BookingList>? get bookingList => _bookingList;
  dynamic? get totalCount => _totalCount;
  int? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_bookingList != null) {
      map['booking_list'] = _bookingList?.map((v) => v.toJson()).toList();
    }
    map['total_count'] = _totalCount;
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// booking_address : "Corporate Rd, Prahlad Nagar, Ahmedabad, Gujarat 380015, India"
/// puja_id : "6"
/// booking_id : "9"
/// email : "jay.m@coronation.in"
/// mobile : "7433036724"
/// puja_name : "Grih Pravesh/ Vastu Puja"
/// puja_short_description : "known as New Home Blessings or House warming Prayer, where Pundit / Priest come and bless home to re..."
/// pickup_by_user : ""
/// pooja_goods_provide_by_user : "1"
/// auspicious_description : ""
/// puja_description : "known as New Home Blessings or House warming Prayer, where Pundit / Priest come and bless home to remove all negativity and Vastu Dosh, that day yajman enter in home with deities and Kumbha ( Clay pot Kalash )"
/// puja_duration : "3 Hours"
/// puja_amount : "₹ 6000"
/// puja_date : "10 Aug 2022"
/// puja_time : "07:31 PM"
/// puja_day : "Wednesday"
/// booked_on : "01 Aug 2022"

class BookingList {
  BookingList({
      String? bookingAddress, 
      String? pujaId, 
      String? bookingId, 
      String? email, 
      String? mobile, 
      String? pujaName, 
      String? pujaShortDescription, 
      String? pickupByUser, 
      String? poojaGoodsProvideByUser, 
      String? auspiciousDescription, 
      String? pujaDescription, 
      String? pujaDuration, 
      String? pujaAmount, 
      String? pujaDate, 
      String? pujaTime, 
      String? pujaDay, 
      num? isreviewdone,
      String? bookedOn,}){
    _bookingAddress = bookingAddress;
    _pujaId = pujaId;
    _bookingId = bookingId;
    _email = email;
    _mobile = mobile;
    _pujaName = pujaName;
    _pujaShortDescription = pujaShortDescription;
    _pickupByUser = pickupByUser;
    _poojaGoodsProvideByUser = poojaGoodsProvideByUser;
    _auspiciousDescription = auspiciousDescription;
    _pujaDescription = pujaDescription;
    _pujaDuration = pujaDuration;
    _pujaAmount = pujaAmount;
    _pujaDate = pujaDate;
    _pujaTime = pujaTime;
    _pujaDay = pujaDay;
    _bookedOn = bookedOn;
    _isReviewDone = isreviewdone;
}

  BookingList.fromJson(dynamic json) {
    _bookingAddress = json['booking_address'];
    _pujaId = json['puja_id'];
    _bookingId = json['booking_id'];
    _email = json['email'];
    _mobile = json['mobile'];
    _pujaName = json['puja_name'];
    _pujaShortDescription = json['puja_short_description'];
    _pickupByUser = json['pickup_by_user'];
    _poojaGoodsProvideByUser = json['pooja_goods_provide_by_user'];
    _auspiciousDescription = json['auspicious_description'];
    _pujaDescription = json['puja_description'];
    _pujaDuration = json['puja_duration'];
    _pujaAmount = json['puja_amount'];
    _pujaDate = json['puja_date'];
    _pujaTime = json['puja_time'];
    _pujaDay = json['puja_day'];
    _bookedOn = json['booked_on'];
    _isReviewDone = json['isreviewdone'];
  }
  String? _bookingAddress;
  String? _pujaId;
  String? _bookingId;
  String? _email;
  String? _mobile;
  String? _pujaName;
  String? _pujaShortDescription;
  String? _pickupByUser;
  String? _poojaGoodsProvideByUser;
  String? _auspiciousDescription;
  String? _pujaDescription;
  String? _pujaDuration;
  String? _pujaAmount;
  String? _pujaDate;
  String? _pujaTime;
  String? _pujaDay;
  String? _bookedOn;
  num? _isReviewDone;
BookingList copyWith({  String? bookingAddress,
  String? pujaId,
  String? bookingId,
  String? email,
  String? mobile,
  String? pujaName,
  String? pujaShortDescription,
  String? pickupByUser,
  String? poojaGoodsProvideByUser,
  String? auspiciousDescription,
  String? pujaDescription,
  String? pujaDuration,
  String? pujaAmount,
  String? pujaDate,
  String? pujaTime,
  String? pujaDay,
  String? bookedOn,
  num? isReviewDone,
}) => BookingList(  bookingAddress: bookingAddress ?? _bookingAddress,
  pujaId: pujaId ?? _pujaId,
  bookingId: bookingId ?? _bookingId,
  email: email ?? _email,
  mobile: mobile ?? _mobile,
  pujaName: pujaName ?? _pujaName,
  pujaShortDescription: pujaShortDescription ?? _pujaShortDescription,
  pickupByUser: pickupByUser ?? _pickupByUser,
  poojaGoodsProvideByUser: poojaGoodsProvideByUser ?? _poojaGoodsProvideByUser,
  auspiciousDescription: auspiciousDescription ?? _auspiciousDescription,
  pujaDescription: pujaDescription ?? _pujaDescription,
  pujaDuration: pujaDuration ?? _pujaDuration,
  pujaAmount: pujaAmount ?? _pujaAmount,
  pujaDate: pujaDate ?? _pujaDate,
  pujaTime: pujaTime ?? _pujaTime,
  pujaDay: pujaDay ?? _pujaDay,
  bookedOn: bookedOn ?? _bookedOn,
  isreviewdone: isReviewDone ?? _isReviewDone,
);
  String? get bookingAddress => _bookingAddress;
  String? get pujaId => _pujaId;
  String? get bookingId => _bookingId;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get pujaName => _pujaName;
  String? get pujaShortDescription => _pujaShortDescription;
  String? get pickupByUser => _pickupByUser;
  String? get poojaGoodsProvideByUser => _poojaGoodsProvideByUser;
  String? get auspiciousDescription => _auspiciousDescription;
  String? get pujaDescription => _pujaDescription;
  String? get pujaDuration => _pujaDuration;
  String? get pujaAmount => _pujaAmount;
  String? get pujaDate => _pujaDate;
  String? get pujaTime => _pujaTime;
  String? get pujaDay => _pujaDay;
  String? get bookedOn => _bookedOn;
  num? get isReviewDone => _isReviewDone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['booking_address'] = _bookingAddress;
    map['puja_id'] = _pujaId;
    map['booking_id'] = _bookingId;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['puja_name'] = _pujaName;
    map['puja_short_description'] = _pujaShortDescription;
    map['pickup_by_user'] = _pickupByUser;
    map['pooja_goods_provide_by_user'] = _poojaGoodsProvideByUser;
    map['auspicious_description'] = _auspiciousDescription;
    map['puja_description'] = _pujaDescription;
    map['puja_duration'] = _pujaDuration;
    map['puja_amount'] = _pujaAmount;
    map['puja_date'] = _pujaDate;
    map['puja_time'] = _pujaTime;
    map['puja_day'] = _pujaDay;
    map['booked_on'] = _bookedOn;
    map['isreviewdone'] = _isReviewDone;
    return map;
  }

}