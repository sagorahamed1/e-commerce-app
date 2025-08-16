// models/country_model.dart
class CountryModel {
  final int countryId;
  final String title;
  final String countryCode;

  CountryModel({
    required this.countryId,
    required this.title,
    required this.countryCode,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      countryId: json['CountryID'],
      title: json['Title'],
      countryCode: json['CountryCode'],
    );
  }
}
