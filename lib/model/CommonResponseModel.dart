/// success : 1
/// message : "OTP has been sent to your mobile number!"

class CommonResponseModel {
  CommonResponseModel({
      int? success, 
      String? message,}){
    _success = success;
    _message = message;
}

  CommonResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
  }
  int? _success;
  String? _message;
CommonResponseModel copyWith({  int? success,
  String? message,
}) => CommonResponseModel(  success: success ?? _success,
  message: message ?? _message,
);
  int? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}