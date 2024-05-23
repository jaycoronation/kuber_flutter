import 'dart:convert';
/// qualification : ""
/// isSelected : false

QualificationResponseModel qualificationResponseModelFromJson(String str) => QualificationResponseModel.fromJson(json.decode(str));
String qualificationResponseModelToJson(QualificationResponseModel data) => json.encode(data.toJson());
class QualificationResponseModel {
  QualificationResponseModel({
      String? qualification, 
      bool? isSelected,}){
    _qualification = qualification;
    _isSelected = isSelected;
}

  QualificationResponseModel.fromJson(dynamic json) {
    _qualification = json['qualification'];
    _isSelected = json['isSelected'];
  }
  String? _qualification;
  bool? _isSelected;
QualificationResponseModel copyWith({  String? qualification,
  bool? isSelected,
}) => QualificationResponseModel(  qualification: qualification ?? _qualification,
  isSelected: isSelected ?? _isSelected,
);
  String? get qualification => _qualification;
  bool? get isSelected => _isSelected;

  set isSelected(bool? value) {
    _isSelected = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['qualification'] = _qualification;
    map['isSelected'] = _isSelected;
    return map;
  }

}