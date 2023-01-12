class User {
  final String user;
  final String phone;
  final DateTime dateTime;

  User({required this.user, required this.phone, required this.dateTime});

  //convert from json
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        user: json['user'], phone: json['phone'], dateTime: json['check-in']);
  }

  //this is the fucntion to convert tojson
  Map<String, dynamic> toJson() =>
      {'name': user, 'phone': phone, 'dateTime': dateTime};
}
