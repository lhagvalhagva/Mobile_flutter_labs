import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String username;
  final String password;
  final String email;
  final Name name;
  final Address address;
  final String phone;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.name,
    required this.address,
    required this.phone,
  });
  // JSON-оос User объект үүсгэх
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
    // User объектоос JSON үүсгэх
  Map<String, dynamic> toJson() => _$UserToJson(this);

  // API Response -> List<User>
  static List<User> fromList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => User.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

@JsonSerializable()
class Name {
  final String firstname;
  final String lastname;

  Name({required this.firstname, required this.lastname});

  factory Name.fromJson(Map<String, dynamic> json) => _$NameFromJson(json);
  Map<String, dynamic> toJson() => _$NameToJson(this);
}

@JsonSerializable()
class Address {
  final Geolocation geolocation;
  final String city;
  final String street;
  final int number;
  final String zipcode;

  Address({
    required this.geolocation,
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable()
class Geolocation {
  final String lat;
  final String long;

  Geolocation({required this.lat, required this.long});

  factory Geolocation.fromJson(Map<String, dynamic> json) => _$GeolocationFromJson(json);
  Map<String, dynamic> toJson() => _$GeolocationToJson(this);
}