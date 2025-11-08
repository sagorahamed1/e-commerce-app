



class CourierServiceModel {
  final int? id;
  final String? name;
  final String? carrier;
  final String? minWeight;
  final String? maxWeight;
  final String? servicePointInput;
  final int? price;
  final List<Country>? countries;

  CourierServiceModel({
    this.id,
    this.name,
    this.carrier,
    this.minWeight,
    this.maxWeight,
    this.servicePointInput,
    this.price,
    this.countries,
  });

  factory CourierServiceModel.fromJson(Map<String, dynamic> json) => CourierServiceModel(
    id: json["id"],
    name: json["name"],
    carrier: json["carrier"],
    minWeight: json["min_weight"],
    maxWeight: json["max_weight"],
    servicePointInput: json["service_point_input"],
    price: json["price"],
    countries: json["countries"] == null ? [] : List<Country>.from(json["countries"]!.map((x) => Country.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "carrier": carrier,
    "min_weight": minWeight,
    "max_weight": maxWeight,
    "service_point_input": servicePointInput,
    "price": price,
    "countries": countries == null ? [] : List<dynamic>.from(countries!.map((x) => x.toJson())),
  };
}

class Country {
  final int? id;
  final String? name;
  final dynamic price;
  final String? iso2;
  final String? iso3;
  final int? leadTimeHours;
  final List<dynamic>? priceBreakdown;

  Country({
    this.id,
    this.name,
    this.price,
    this.iso2,
    this.iso3,
    this.leadTimeHours,
    this.priceBreakdown,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    iso2: json["iso_2"],
    iso3: json["iso_3"],
    leadTimeHours: json["lead_time_hours"],
    priceBreakdown: json["price_breakdown"] == null ? [] : List<dynamic>.from(json["price_breakdown"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "iso_2": iso2,
    "iso_3": iso3,
    "lead_time_hours": leadTimeHours,
    "price_breakdown": priceBreakdown == null ? [] : List<dynamic>.from(priceBreakdown!.map((x) => x)),
  };
}
