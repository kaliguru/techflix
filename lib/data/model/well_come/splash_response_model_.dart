
import 'package:play_lab/data/model/auth/registration_response_model.dart';

class SplashResponseModel {
  SplashResponseModel({
      String? remark, 
      String? status, 
      Message? message,
      Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  SplashResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'].toString();
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _remark;
  String? _status;
  Message? _message;
  Data? _data;

  String? get remark => _remark;
  String? get status => _status;
  Message? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = _remark;
    map['status'] = _status;
   if(_message!=null){
      map['message'] = _message?.toJson();
    }
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      String? logo, 
      String? favicon,}){
    _logo = logo;
    _favicon = favicon;
}

  Data.fromJson(dynamic json) {
    _logo = json['logo'];
    _favicon = json['favicon'];
  }
  String? _logo;
  String? _favicon;

  String? get logo => _logo;
  String? get favicon => _favicon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['logo'] = _logo;
    map['favicon'] = _favicon;
    return map;
  }

}