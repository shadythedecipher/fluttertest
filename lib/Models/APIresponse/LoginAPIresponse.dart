class LoginAPIresponse {
  bool? hasError;
  ResponseObject? responseObject;
  String? successMessage;
  Null? errors;

  LoginAPIresponse(
      {this.hasError, this.responseObject, this.successMessage, this.errors});

  LoginAPIresponse.fromJson(Map<String, dynamic> json) {
    hasError = json['hasError'];
    responseObject = json['responseObject'] != null
        ? new ResponseObject.fromJson(json['responseObject'])
        : null;
    successMessage = json['successMessage'];
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hasError'] = this.hasError;
    if (this.responseObject != null) {
      data['responseObject'] = this.responseObject!.toJson();
    }
    data['successMessage'] = this.successMessage;
    data['errors'] = this.errors;
    return data;
  }
}

class ResponseObject {
  String? token;
  String? email;
  String? firstName;

  ResponseObject({this.token, this.email, this.firstName});

  ResponseObject.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    email = json['email'];
    firstName = json['firstName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    return data;
  }
}