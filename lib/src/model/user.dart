class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.imageUrl,
    required this.gender,
  });

  String id;
  String firstName;
  String lastName;
  String email;
  String phone;
  String imageUrl;
  String gender;

  String get fullname => this.firstName + " " + this.lastName;

  User.fromJson(Map<String, dynamic> json)
      : id = json[UserKey.login][UserKey.uid] ?? "",
        firstName = json[UserKey.name][UserKey.first] ?? "",
        lastName = json[UserKey.name][UserKey.last] ?? "",
        email = json[UserKey.email] ?? "",
        phone = json[UserKey.phone] ?? "",
        imageUrl = json[UserKey.picture][UserKey.medium] ?? "",
        gender = json[UserKey.gender] ?? "";
}

class UserKey {
  static final login = "login";
  static final uid = "uid";
  static final name = "name";
  static final email = "email";
  static final first = "first";
  static final last = "last";
  static final phone = "phone";
  static final picture = "picture";
  static final medium = "medium";
  static final gender = "gender";

  static final results = "results";
}
