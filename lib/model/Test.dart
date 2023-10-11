import 'dart:convert';
/// predictions : [{"description":"Pinnacles National Park, California, USA","matched_substrings":[{"length":8,"offset":0}],"place_id":"ChIJn93OiYBDkoAR7kSomO77gps","reference":"ChIJn93OiYBDkoAR7kSomO77gps","structured_formatting":{"main_text":"Pinnacles National Park","main_text_matched_substrings":[{"length":8,"offset":0}],"secondary_text":"California, USA"},"terms":[{"offset":0,"value":"Pinnacles National Park"},{"offset":25,"value":"California"},{"offset":37,"value":"USA"}],"types":["tourist_attraction","park","point_of_interest","establishment"]},{"description":"Pinnacle Hotel Harbourfront, West Hastings Street, Vancouver, BC, Canada","matched_substrings":[{"length":8,"offset":0}],"place_id":"ChIJYyXi7YNxhlQRUxgGSBaVYGc","reference":"ChIJYyXi7YNxhlQRUxgGSBaVYGc","structured_formatting":{"main_text":"Pinnacle Hotel Harbourfront","main_text_matched_substrings":[{"length":8,"offset":0}],"secondary_text":"West Hastings Street, Vancouver, BC, Canada"},"terms":[{"offset":0,"value":"Pinnacle Hotel Harbourfront"},{"offset":29,"value":"West Hastings Street"},{"offset":51,"value":"Vancouver"},{"offset":62,"value":"BC"},{"offset":66,"value":"Canada"}],"types":["lodging","restaurant","food","point_of_interest","establishment"]},{"description":"Pinnacles Desert Discovery Centre, Nambung WA, Australia","matched_substrings":[{"length":8,"offset":0}],"place_id":"ChIJ8UjYb5sm0isRRR8JGC1uK78","reference":"ChIJ8UjYb5sm0isRRR8JGC1uK78","structured_formatting":{"main_text":"Pinnacles Desert Discovery Centre","main_text_matched_substrings":[{"length":8,"offset":0}],"secondary_text":"Nambung WA, Australia"},"terms":[{"offset":0,"value":"Pinnacles Desert Discovery Centre"},{"offset":35,"value":"Nambung"},{"offset":43,"value":"WA"},{"offset":47,"value":"Australia"}],"types":["travel_agency","point_of_interest","establishment"]},{"description":"Pinnacle, NC, USA","matched_substrings":[{"length":8,"offset":0}],"place_id":"ChIJtUenSetJUogRyl_t-fx8nis","reference":"ChIJtUenSetJUogRyl_t-fx8nis","structured_formatting":{"main_text":"Pinnacle","main_text_matched_substrings":[{"length":8,"offset":0}],"secondary_text":"NC, USA"},"terms":[{"offset":0,"value":"Pinnacle"},{"offset":10,"value":"NC"},{"offset":14,"value":"USA"}],"types":["locality","political","geocode"]},{"description":"Cantonment Road, Pinnacle＠Duxton, Singapore","matched_substrings":[{"length":8,"offset":17}],"place_id":"ChIJVSyoe2wZ2jERcL3VxGbPvHs","reference":"ChIJVSyoe2wZ2jERcL3VxGbPvHs","structured_formatting":{"main_text":"Pinnacle＠Duxton","main_text_matched_substrings":[{"length":8,"offset":0}],"secondary_text":"Cantonment Road, Singapore"},"terms":[{"offset":0,"value":"Cantonment Road"},{"offset":17,"value":"Pinnacle＠Duxton"},{"offset":34,"value":"Singapore"}],"types":["point_of_interest","establishment"]}]
/// status : "OK"

Test testFromJson(String str) => Test.fromJson(json.decode(str));
String testToJson(Test data) => json.encode(data.toJson());
class Test {
  Test({
      List<Predictions>? predictions, 
      String? status,}){
    _predictions = predictions;
    _status = status;
}

  Test.fromJson(dynamic json) {
    if (json['predictions'] != null) {
      _predictions = [];
      json['predictions'].forEach((v) {
        _predictions?.add(Predictions.fromJson(v));
      });
    }
    _status = json['status'];
  }
  List<Predictions>? _predictions;
  String? _status;
Test copyWith({  List<Predictions>? predictions,
  String? status,
}) => Test(  predictions: predictions ?? _predictions,
  status: status ?? _status,
);
  List<Predictions>? get predictions => _predictions;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_predictions != null) {
      map['predictions'] = _predictions?.map((v) => v.toJson()).toList();
    }
    map['status'] = _status;
    return map;
  }

}

/// description : "Pinnacles National Park, California, USA"
/// matched_substrings : [{"length":8,"offset":0}]
/// place_id : "ChIJn93OiYBDkoAR7kSomO77gps"
/// reference : "ChIJn93OiYBDkoAR7kSomO77gps"
/// structured_formatting : {"main_text":"Pinnacles National Park","main_text_matched_substrings":[{"length":8,"offset":0}],"secondary_text":"California, USA"}
/// terms : [{"offset":0,"value":"Pinnacles National Park"},{"offset":25,"value":"California"},{"offset":37,"value":"USA"}]
/// types : ["tourist_attraction","park","point_of_interest","establishment"]

Predictions predictionsFromJson(String str) => Predictions.fromJson(json.decode(str));
String predictionsToJson(Predictions data) => json.encode(data.toJson());
class Predictions {
  Predictions({
      String? description, 
      List<MatchedSubstrings>? matchedSubstrings, 
      String? placeId, 
      String? reference, 
      StructuredFormatting? structuredFormatting, 
      List<Terms>? terms, 
      List<String>? types,}){
    _description = description;
    _matchedSubstrings = matchedSubstrings;
    _placeId = placeId;
    _reference = reference;
    _structuredFormatting = structuredFormatting;
    _terms = terms;
    _types = types;
}

  Predictions.fromJson(dynamic json) {
    _description = json['description'];
    if (json['matched_substrings'] != null) {
      _matchedSubstrings = [];
      json['matched_substrings'].forEach((v) {
        _matchedSubstrings?.add(MatchedSubstrings.fromJson(v));
      });
    }
    _placeId = json['place_id'];
    _reference = json['reference'];
    _structuredFormatting = json['structured_formatting'] != null ? StructuredFormatting.fromJson(json['structured_formatting']) : null;
    if (json['terms'] != null) {
      _terms = [];
      json['terms'].forEach((v) {
        _terms?.add(Terms.fromJson(v));
      });
    }
    _types = json['types'] != null ? json['types'].cast<String>() : [];
  }
  String? _description;
  List<MatchedSubstrings>? _matchedSubstrings;
  String? _placeId;
  String? _reference;
  StructuredFormatting? _structuredFormatting;
  List<Terms>? _terms;
  List<String>? _types;
Predictions copyWith({  String? description,
  List<MatchedSubstrings>? matchedSubstrings,
  String? placeId,
  String? reference,
  StructuredFormatting? structuredFormatting,
  List<Terms>? terms,
  List<String>? types,
}) => Predictions(  description: description ?? _description,
  matchedSubstrings: matchedSubstrings ?? _matchedSubstrings,
  placeId: placeId ?? _placeId,
  reference: reference ?? _reference,
  structuredFormatting: structuredFormatting ?? _structuredFormatting,
  terms: terms ?? _terms,
  types: types ?? _types,
);
  String? get description => _description;
  List<MatchedSubstrings>? get matchedSubstrings => _matchedSubstrings;
  String? get placeId => _placeId;
  String? get reference => _reference;
  StructuredFormatting? get structuredFormatting => _structuredFormatting;
  List<Terms>? get terms => _terms;
  List<String>? get types => _types;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['description'] = _description;
    if (_matchedSubstrings != null) {
      map['matched_substrings'] = _matchedSubstrings?.map((v) => v.toJson()).toList();
    }
    map['place_id'] = _placeId;
    map['reference'] = _reference;
    if (_structuredFormatting != null) {
      map['structured_formatting'] = _structuredFormatting?.toJson();
    }
    if (_terms != null) {
      map['terms'] = _terms?.map((v) => v.toJson()).toList();
    }
    map['types'] = _types;
    return map;
  }

}

/// offset : 0
/// value : "Pinnacles National Park"

Terms termsFromJson(String str) => Terms.fromJson(json.decode(str));
String termsToJson(Terms data) => json.encode(data.toJson());
class Terms {
  Terms({
      num? offset, 
      String? value,}){
    _offset = offset;
    _value = value;
}

  Terms.fromJson(dynamic json) {
    _offset = json['offset'];
    _value = json['value'];
  }
  num? _offset;
  String? _value;
Terms copyWith({  num? offset,
  String? value,
}) => Terms(  offset: offset ?? _offset,
  value: value ?? _value,
);
  num? get offset => _offset;
  String? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['offset'] = _offset;
    map['value'] = _value;
    return map;
  }

}

/// main_text : "Pinnacles National Park"
/// main_text_matched_substrings : [{"length":8,"offset":0}]
/// secondary_text : "California, USA"

StructuredFormatting structuredFormattingFromJson(String str) => StructuredFormatting.fromJson(json.decode(str));
String structuredFormattingToJson(StructuredFormatting data) => json.encode(data.toJson());
class StructuredFormatting {
  StructuredFormatting({
      String? mainText, 
      List<MainTextMatchedSubstrings>? mainTextMatchedSubstrings, 
      String? secondaryText,}){
    _mainText = mainText;
    _mainTextMatchedSubstrings = mainTextMatchedSubstrings;
    _secondaryText = secondaryText;
}

  StructuredFormatting.fromJson(dynamic json) {
    _mainText = json['main_text'];
    if (json['main_text_matched_substrings'] != null) {
      _mainTextMatchedSubstrings = [];
      json['main_text_matched_substrings'].forEach((v) {
        _mainTextMatchedSubstrings?.add(MainTextMatchedSubstrings.fromJson(v));
      });
    }
    _secondaryText = json['secondary_text'];
  }
  String? _mainText;
  List<MainTextMatchedSubstrings>? _mainTextMatchedSubstrings;
  String? _secondaryText;
StructuredFormatting copyWith({  String? mainText,
  List<MainTextMatchedSubstrings>? mainTextMatchedSubstrings,
  String? secondaryText,
}) => StructuredFormatting(  mainText: mainText ?? _mainText,
  mainTextMatchedSubstrings: mainTextMatchedSubstrings ?? _mainTextMatchedSubstrings,
  secondaryText: secondaryText ?? _secondaryText,
);
  String? get mainText => _mainText;
  List<MainTextMatchedSubstrings>? get mainTextMatchedSubstrings => _mainTextMatchedSubstrings;
  String? get secondaryText => _secondaryText;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['main_text'] = _mainText;
    if (_mainTextMatchedSubstrings != null) {
      map['main_text_matched_substrings'] = _mainTextMatchedSubstrings?.map((v) => v.toJson()).toList();
    }
    map['secondary_text'] = _secondaryText;
    return map;
  }

}

/// length : 8
/// offset : 0

MainTextMatchedSubstrings mainTextMatchedSubstringsFromJson(String str) => MainTextMatchedSubstrings.fromJson(json.decode(str));
String mainTextMatchedSubstringsToJson(MainTextMatchedSubstrings data) => json.encode(data.toJson());
class MainTextMatchedSubstrings {
  MainTextMatchedSubstrings({
      num? length, 
      num? offset,}){
    _length = length;
    _offset = offset;
}

  MainTextMatchedSubstrings.fromJson(dynamic json) {
    _length = json['length'];
    _offset = json['offset'];
  }
  num? _length;
  num? _offset;
MainTextMatchedSubstrings copyWith({  num? length,
  num? offset,
}) => MainTextMatchedSubstrings(  length: length ?? _length,
  offset: offset ?? _offset,
);
  num? get length => _length;
  num? get offset => _offset;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['length'] = _length;
    map['offset'] = _offset;
    return map;
  }

}

/// length : 8
/// offset : 0

MatchedSubstrings matchedSubstringsFromJson(String str) => MatchedSubstrings.fromJson(json.decode(str));
String matchedSubstringsToJson(MatchedSubstrings data) => json.encode(data.toJson());
class MatchedSubstrings {
  MatchedSubstrings({
      num? length, 
      num? offset,}){
    _length = length;
    _offset = offset;
}

  MatchedSubstrings.fromJson(dynamic json) {
    _length = json['length'];
    _offset = json['offset'];
  }
  num? _length;
  num? _offset;
MatchedSubstrings copyWith({  num? length,
  num? offset,
}) => MatchedSubstrings(  length: length ?? _length,
  offset: offset ?? _offset,
);
  num? get length => _length;
  num? get offset => _offset;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['length'] = _length;
    map['offset'] = _offset;
    return map;
  }

}