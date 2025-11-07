

class DropOffModel {
  String? id;
  String? userId;
  String? address;
  String? houseNumber;
  String? address2;
  String? city;
  String? country;
  String? postalCode;
  String? countryState;
  String? latitude;
  String? longitude;
  DropOffUser? user;

  DropOffModel({
    this.id,
    this.userId,
    this.address,
    this.houseNumber,
    this.address2,
    this.city,
    this.country,
    this.postalCode,
    this.countryState,
    this.latitude,
    this.longitude,
    this.user,
  });

  factory DropOffModel.fromJson(Map<String, dynamic> json) {
    return DropOffModel(
      id: json['id'],
      userId: json['user_id'],
      address: json['address'],
      houseNumber: json['house_number'],
      address2: json['address_2'],
      city: json['city'],
      country: json['country'],
      postalCode: json['postal_code'],
      countryState: json['country_state'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      user: json['user'] != null ? DropOffUser.fromJson(json['user']) : null,
    );
  }
}

class DropOffUser {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? image;
  String? status;
  String? address;
  String? phone;
  String? currency;

  DropOffUser({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.image,
    this.status,
    this.address,
    this.phone,
    this.currency,
  });

  factory DropOffUser.fromJson(Map<String, dynamic> json) {
    return DropOffUser(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      image: json['image'],
      status: json['status'],
      address: json['address'],
      phone: json['phone'],
      currency: json['currency'],
    );
  }
}
