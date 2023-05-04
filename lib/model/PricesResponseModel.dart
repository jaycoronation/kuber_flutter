import 'dart:convert';
/// matchmaking_price : "1"
/// astrology_price : "1"
/// rashi_price : "1"

PricesResponseModel pricesResponseModelFromJson(String str) => PricesResponseModel.fromJson(json.decode(str));
String pricesResponseModelToJson(PricesResponseModel data) => json.encode(data.toJson());
class PricesResponseModel {
  PricesResponseModel({
      String? matchmakingPrice, 
      String? astrologyPrice, 
      String? rashiPrice,}){
    _matchmakingPrice = matchmakingPrice;
    _astrologyPrice = astrologyPrice;
    _rashiPrice = rashiPrice;
}

  PricesResponseModel.fromJson(dynamic json) {
    _matchmakingPrice = json['matchmaking_price'];
    _astrologyPrice = json['astrology_price'];
    _rashiPrice = json['rashi_price'];
  }
  String? _matchmakingPrice;
  String? _astrologyPrice;
  String? _rashiPrice;
PricesResponseModel copyWith({  String? matchmakingPrice,
  String? astrologyPrice,
  String? rashiPrice,
}) => PricesResponseModel(  matchmakingPrice: matchmakingPrice ?? _matchmakingPrice,
  astrologyPrice: astrologyPrice ?? _astrologyPrice,
  rashiPrice: rashiPrice ?? _rashiPrice,
);
  String? get matchmakingPrice => _matchmakingPrice;
  String? get astrologyPrice => _astrologyPrice;
  String? get rashiPrice => _rashiPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['matchmaking_price'] = _matchmakingPrice;
    map['astrology_price'] = _astrologyPrice;
    map['rashi_price'] = _rashiPrice;
    return map;
  }

}