class UserModel {
  String name, email, mobile_number, password;

  UserModel(
      {required this.name, required this.password, required this.email, required this.mobile_number});

  factory UserModel.fromJson (Map<String, dynamic> json){
    return UserModel(
        name: json['name'] ?? '',
        password: json['password'] ?? '',
        email: json['email'] ?? '',
        mobile_number: json['mobile_number'] ?? json['mobile_no'] ?? json['mob_no'] ?? '');
  }
}