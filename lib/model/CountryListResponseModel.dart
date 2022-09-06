class CountryListResponseModel {
  CountryListResponseModel({
      required this.name,
      required this.dialCode,
      required this.code,});

  CountryListResponseModel.fromJson(dynamic json) {
    name = json['name'];
    dialCode = json['dial_code'];
    code = json['code'];
  }
  String name = "";
  String dialCode = "";
  String code = "";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['dial_code'] = dialCode;
    map['code'] = code;
    return map;
  }

}