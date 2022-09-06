/// address : [{"address_id":"6","first_name":"","last_name":"","address1":"tedt California 95043, USA","address2":"","address3":"","landmark":"","city":"Paicines","country_name":null,"state_name":null,"city_name":null,"country":"United States","state":"California","zipcode":"95043","contact_no":""}]
/// success : 1
/// message : "1 addresses found."

class AddressListResponseModel {
  AddressListResponseModel({
      List<Address>? address, 
      num? success, 
      String? message,}){
    _address = address;
    _success = success;
    _message = message;
}

  AddressListResponseModel.fromJson(dynamic json) {
    if (json['address'] != null) {
      _address = [];
      json['address'].forEach((v) {
        _address?.add(Address.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<Address>? _address;
  num? _success;
  String? _message;
AddressListResponseModel copyWith({  List<Address>? address,
  num? success,
  String? message,
}) => AddressListResponseModel(  address: address ?? _address,
  success: success ?? _success,
  message: message ?? _message,
);
  List<Address>? get address => _address;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_address != null) {
      map['address'] = _address?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// address_id : "6"
/// first_name : ""
/// last_name : ""
/// address1 : "tedt California 95043, USA"
/// address2 : ""
/// address3 : ""
/// landmark : ""
/// city : "Paicines"
/// country_name : null
/// state_name : null
/// city_name : null
/// country : "United States"
/// state : "California"
/// zipcode : "95043"
/// contact_no : ""

class Address {
  Address({
      String? addressId, 
      String? firstName, 
      String? lastName, 
      String? address1, 
      String? address2, 
      String? address3, 
      String? landmark, 
      String? city, 
      dynamic countryName, 
      dynamic stateName, 
      dynamic cityName, 
      String? country, 
      String? state, 
      String? zipcode, 
      String? contactNo,}){
    _addressId = addressId;
    _firstName = firstName;
    _lastName = lastName;
    _address1 = address1;
    _address2 = address2;
    _address3 = address3;
    _landmark = landmark;
    _city = city;
    _countryName = countryName;
    _stateName = stateName;
    _cityName = cityName;
    _country = country;
    _state = state;
    _zipcode = zipcode;
    _contactNo = contactNo;
}

  Address.fromJson(dynamic json) {
    _addressId = json['address_id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _address1 = json['address1'];
    _address2 = json['address2'];
    _address3 = json['address3'];
    _landmark = json['landmark'];
    _city = json['city'];
    _countryName = json['country_name'];
    _stateName = json['state_name'];
    _cityName = json['city_name'];
    _country = json['country'];
    _state = json['state'];
    _zipcode = json['zipcode'];
    _contactNo = json['contact_no'];
  }
  String? _addressId;
  String? _firstName;
  String? _lastName;
  String? _address1;
  String? _address2;
  String? _address3;
  String? _landmark;
  String? _city;
  dynamic _countryName;
  dynamic _stateName;
  dynamic _cityName;
  String? _country;
  String? _state;
  String? _zipcode;
  String? _contactNo;
Address copyWith({  String? addressId,
  String? firstName,
  String? lastName,
  String? address1,
  String? address2,
  String? address3,
  String? landmark,
  String? city,
  dynamic countryName,
  dynamic stateName,
  dynamic cityName,
  String? country,
  String? state,
  String? zipcode,
  String? contactNo,
}) => Address(  addressId: addressId ?? _addressId,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  address1: address1 ?? _address1,
  address2: address2 ?? _address2,
  address3: address3 ?? _address3,
  landmark: landmark ?? _landmark,
  city: city ?? _city,
  countryName: countryName ?? _countryName,
  stateName: stateName ?? _stateName,
  cityName: cityName ?? _cityName,
  country: country ?? _country,
  state: state ?? _state,
  zipcode: zipcode ?? _zipcode,
  contactNo: contactNo ?? _contactNo,
);
  String? get addressId => _addressId;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get address1 => _address1;
  String? get address2 => _address2;
  String? get address3 => _address3;
  String? get landmark => _landmark;
  String? get city => _city;
  dynamic get countryName => _countryName;
  dynamic get stateName => _stateName;
  dynamic get cityName => _cityName;
  String? get country => _country;
  String? get state => _state;
  String? get zipcode => _zipcode;
  String? get contactNo => _contactNo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address_id'] = _addressId;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['address1'] = _address1;
    map['address2'] = _address2;
    map['address3'] = _address3;
    map['landmark'] = _landmark;
    map['city'] = _city;
    map['country_name'] = _countryName;
    map['state_name'] = _stateName;
    map['city_name'] = _cityName;
    map['country'] = _country;
    map['state'] = _state;
    map['zipcode'] = _zipcode;
    map['contact_no'] = _contactNo;
    return map;
  }

}