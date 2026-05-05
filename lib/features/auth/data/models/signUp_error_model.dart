class SignupErrorModel {
  List<String>? message;
  String? error;
  int? statusCode;

  SignupErrorModel({this.message, this.error, this.statusCode});

  SignupErrorModel.fromJson(Map<String, dynamic> json) {
    message = json['message'].cast<String>();
    error = json['error'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    data['statusCode'] = this.statusCode;
    return data;
  }
}
