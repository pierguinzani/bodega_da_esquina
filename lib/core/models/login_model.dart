class LoginResponseModel {
  final bool success;
  //Success
  final String token;
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final bool isAdmin;
  final DateTime createdAt;
  final DateTime updatedAt;

  LoginResponseModel(
      {this.success,
      this.token,
      this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.isAdmin,
      this.createdAt,
      this.updatedAt});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json["success"] != null ? json["success"] : false,
      token: json["data"] != null ? json["data"]["token"] : "",
      id: json["data"] != null ? json["data"]["id"] : 0,
      lastName: json["data"] != null ? json["data"]["lastName"] : "",
      firstName: json["data"] != null ? json["data"]["firstName"] : "",
      isAdmin: json["data"] != null
          ? (json["data"]["isAdmin"] != null ? json["data"]["isAdmin"] : false)
          : false,
      // createdAt: json["createdAt"] != null ? json["createdAt"] : "",
      // updatedAt: json["updatedAt"] != null ? json["updatedAt"] : "",
    );
  }
}

class LoginRequestModel {
  String email;
  String password;

  LoginRequestModel({
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email.trim(),
      'password': password.trim(),
    };

    return map;
  }
}
