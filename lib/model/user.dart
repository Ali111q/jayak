class User {
  final int id;
  String name;
  String mobile;
  String image;
  int typeNumber;
  String typeName;
  final String token;

  User(
      {required this.id,
      required this.token,
      required this.name,
      required this.image,
      required this.mobile,
      required this.typeNumber,
      required this.typeName});

  factory User.fromJson(Map<String, dynamic> json, {String? token}) {
    return User(
        id: json['id'],
        token: json['token']??token,
        name: json['name'],
        image: json['image'],
        mobile: json['mobile'],
        typeName: json['type']['type_name'],
        typeNumber: json['type']['type_number']);
  }
}
