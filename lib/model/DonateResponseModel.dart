import 'dart:convert';
/// price : ""
/// isSelected : ""

DonateResponseModel donateResponseModelFromJson(String str) => DonateResponseModel.fromJson(json.decode(str));
String donateResponseModelToJson(DonateResponseModel data) => json.encode(data.toJson());
class DonateResponseModel {
  DonateResponseModel({
      String? price, 
      bool? isSelected,}){
    _price = price;
    _isSelected = isSelected;
}

  DonateResponseModel.fromJson(dynamic json) {
    _price = json['price'];
    _isSelected = json['isSelected'];
  }
  String? _price;
  bool? _isSelected;
DonateResponseModel copyWith({  String? price,
  bool? isSelected,
}) => DonateResponseModel(  price: price ?? _price,
  isSelected: isSelected ?? _isSelected,
);

  set isSelected(bool? value) {
    _isSelected = value;
  }

  String? get price => _price;
  bool? get isSelected => _isSelected;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['price'] = _price;
    map['isSelected'] = _isSelected;
    return map;
  }

}