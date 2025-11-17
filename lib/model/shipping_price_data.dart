
// class ShippingPricingData {
//   final PricingInfo? pricingInfo;
//   final ShippingMethodInfo? shippingMethodInfo;
//   final List<Pricing>? pricing;
//   final Order? order;
//
//   ShippingPricingData({
//     this.pricingInfo,
//     this.shippingMethodInfo,
//     this.pricing,
//     this.order,
//   });
//
//   factory ShippingPricingData.fromJson(Map<String, dynamic> json) => ShippingPricingData(
//     pricingInfo: json["pricingInfo"] == null ? null : PricingInfo.fromJson(json["pricingInfo"]),
//     shippingMethodInfo: json["shippingMethodInfo"] == null ? null : ShippingMethodInfo.fromJson(json["shippingMethodInfo"]),
//     pricing: json["pricing"] == null ? [] : List<Pricing>.from(json["pricing"]!.map((x) => Pricing.fromJson(x))),
//     order: json["order"] == null ? null : Order.fromJson(json["order"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "pricingInfo": pricingInfo?.toJson(),
//     "shippingMethodInfo": shippingMethodInfo?.toJson(),
//     "pricing": pricing == null ? [] : List<dynamic>.from(pricing!.map((x) => x.toJson())),
//     "order": order?.toJson(),
//   };
// }
//
// class Order {
//   final int? id;
//   final String? sellerId;
//   final String? buyerId;
//   final dynamic offerId;
//   final String? protectionFee;
//   final String? deliveryProtectionFee;
//   final String? total;
//   final dynamic deliveryCharge;
//   final dynamic parcelId;
//   final int? deliveryId;
//   final String? status;
//   final String? paymentStatus;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final Product? product;
//   final DeliveryInfo? deliveryInfo;
//
//   Order({
//     this.id,
//     this.sellerId,
//     this.buyerId,
//     this.offerId,
//     this.protectionFee,
//     this.deliveryProtectionFee,
//     this.total,
//     this.deliveryCharge,
//     this.parcelId,
//     this.deliveryId,
//     this.status,
//     this.paymentStatus,
//     this.createdAt,
//     this.updatedAt,
//     this.product,
//     this.deliveryInfo,
//   });
//
//   factory Order.fromJson(Map<String, dynamic> json) => Order(
//     id: json["id"],
//     sellerId: json["seller_id"],
//     buyerId: json["buyer_id"],
//     offerId: json["offer_id"],
//     protectionFee: json["protectionFee"],
//     deliveryProtectionFee: json["deliveryProtectionFee"],
//     total: json["total"],
//     deliveryCharge: json["deliveryCharge"],
//     parcelId: json["parcel_id"],
//     deliveryId: json["delivery_id"],
//     status: json["status"],
//     paymentStatus: json["paymentStatus"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     product: json["product"] == null ? null : Product.fromJson(json["product"]),
//     deliveryInfo: json["deliveryInfo"] == null ? null : DeliveryInfo.fromJson(json["deliveryInfo"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "seller_id": sellerId,
//     "buyer_id": buyerId,
//     "offer_id": offerId,
//     "protectionFee": protectionFee,
//     "deliveryProtectionFee": deliveryProtectionFee,
//     "total": total,
//     "deliveryCharge": deliveryCharge,
//     "parcel_id": parcelId,
//     "delivery_id": deliveryId,
//     "status": status,
//     "paymentStatus": paymentStatus,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "product": product?.toJson(),
//     "deliveryInfo": deliveryInfo?.toJson(),
//   };
// }
//
// class DeliveryInfo {
//   final int? id;
//   final String? name;
//   final String? companyName;
//   final String? email;
//   final String? telephone;
//   final String? address;
//   final String? houseNumber;
//   final String? address2;
//   final String? city;
//   final int? servicePointId;
//   final String? country;
//   final String? postalCode;
//
//   DeliveryInfo({
//     this.id,
//     this.name,
//     this.companyName,
//     this.email,
//     this.telephone,
//     this.address,
//     this.houseNumber,
//     this.address2,
//     this.city,
//     this.servicePointId,
//     this.country,
//     this.postalCode,
//   });
//
//   factory DeliveryInfo.fromJson(Map<String, dynamic> json) => DeliveryInfo(
//     id: json["id"],
//     name: json["name"],
//     companyName: json["company_name"],
//     email: json["email"],
//     telephone: json["telephone"],
//     address: json["address"],
//     houseNumber: json["house_number"],
//     address2: json["address_2"],
//     city: json["city"],
//     servicePointId: json["service_point_id"],
//     country: json["country"],
//     postalCode: json["postal_code"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "company_name": companyName,
//     "email": email,
//     "telephone": telephone,
//     "address": address,
//     "house_number": houseNumber,
//     "address_2": address2,
//     "city": city,
//     "service_point_id": servicePointId,
//     "country": country,
//     "postal_code": postalCode,
//   };
// }
//
// class Product {
//   final int? id;
//   final String? userId;
//   final String? productName;
//   final String? status;
//   final String? sellingPrice;
//   final String? category;
//   final int? quantity;
//   final String? description;
//   final String? condition;
//   final String? size;
//   final String? brand;
//   final bool? isNegotiable;
//   final bool? isBoosted;
//   final dynamic boostStartTime;
//   final dynamic boostEndTime;
//   final String? weight;
//   final String? length;
//   final dynamic servicePointId;
//   final String? width;
//   final String? height;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final List<Image>? images;
//   final User? user;
//   final DeliveryInfo? collectionAddress;
//
//   Product({
//     this.id,
//     this.userId,
//     this.productName,
//     this.status,
//     this.sellingPrice,
//     this.category,
//     this.quantity,
//     this.description,
//     this.condition,
//     this.size,
//     this.brand,
//     this.isNegotiable,
//     this.isBoosted,
//     this.boostStartTime,
//     this.boostEndTime,
//     this.weight,
//     this.length,
//     this.servicePointId,
//     this.width,
//     this.height,
//     this.createdAt,
//     this.updatedAt,
//     this.images,
//     this.user,
//     this.collectionAddress,
//   });
//
//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//     id: json["id"],
//     userId: json["user_id"],
//     productName: json["product_name"],
//     status: json["status"],
//     sellingPrice: json["selling_price"],
//     category: json["category"],
//     quantity: json["quantity"],
//     description: json["description"],
//     condition: json["condition"],
//     size: json["size"],
//     brand: json["brand"],
//     isNegotiable: json["is_negotiable"],
//     isBoosted: json["is_boosted"],
//     boostStartTime: json["boost_start_time"],
//     boostEndTime: json["boost_end_time"],
//     weight: json["weight"],
//     length: json["length"],
//     servicePointId: json["service_point_id"],
//     width: json["width"],
//     height: json["height"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
//     user: json["user"] == null ? null : User.fromJson(json["user"]),
//     collectionAddress: json["collectionAddress"] == null ? null : DeliveryInfo.fromJson(json["collectionAddress"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "user_id": userId,
//     "product_name": productName,
//     "status": status,
//     "selling_price": sellingPrice,
//     "category": category,
//     "quantity": quantity,
//     "description": description,
//     "condition": condition,
//     "size": size,
//     "brand": brand,
//     "is_negotiable": isNegotiable,
//     "is_boosted": isBoosted,
//     "boost_start_time": boostStartTime,
//     "boost_end_time": boostEndTime,
//     "weight": weight,
//     "length": length,
//     "service_point_id": servicePointId,
//     "width": width,
//     "height": height,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
//     "user": user?.toJson(),
//     "collectionAddress": collectionAddress?.toJson(),
//   };
// }
//
// class Image {
//   final int? id;
//   final int? productId;
//   final String? image;
//   final DateTime? timestampSecond;
//
//   Image({
//     this.id,
//     this.productId,
//     this.image,
//     this.timestampSecond,
//   });
//
//   factory Image.fromJson(Map<String, dynamic> json) => Image(
//     id: json["id"],
//     productId: json["product_id"],
//     image: json["image"],
//     timestampSecond: json["TimestampSecond"] == null ? null : DateTime.parse(json["TimestampSecond"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "product_id": productId,
//     "image": image,
//     "TimestampSecond": timestampSecond?.toIso8601String(),
//   };
// }
//
// class User {
//   final String? id;
//   final String? firstName;
//   final String? lastName;
//   final String? email;
//   final dynamic image;
//   final String? status;
//   final int? rating;
//   final String? address;
//   final String? currency;
//   final String? phone;
//   final List<String>? roles;
//   final bool? isActive;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final dynamic deletedAt;
//
//   User({
//     this.id,
//     this.firstName,
//     this.lastName,
//     this.email,
//     this.image,
//     this.status,
//     this.rating,
//     this.address,
//     this.currency,
//     this.phone,
//     this.roles,
//     this.isActive,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) => User(
//     id: json["id"],
//     firstName: json["firstName"],
//     lastName: json["lastName"],
//     email: json["email"],
//     image: json["image"],
//     status: json["status"],
//     rating: json["rating"],
//     address: json["address"],
//     currency: json["currency"],
//     phone: json["phone"],
//     roles: json["roles"] == null ? [] : List<String>.from(json["roles"]!.map((x) => x)),
//     isActive: json["isActive"],
//     createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
//     updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
//     deletedAt: json["deletedAt"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "firstName": firstName,
//     "lastName": lastName,
//     "email": email,
//     "image": image,
//     "status": status,
//     "rating": rating,
//     "address": address,
//     "currency": currency,
//     "phone": phone,
//     "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
//     "isActive": isActive,
//     "createdAt": createdAt?.toIso8601String(),
//     "updatedAt": updatedAt?.toIso8601String(),
//     "deletedAt": deletedAt,
//   };
// }
//
// class Pricing {
//   final String? price;
//   final String? currency;
//   final String? toCountry;
//   final List<Breakdown>? breakdown;
//
//   Pricing({
//     this.price,
//     this.currency,
//     this.toCountry,
//     this.breakdown,
//   });
//
//   factory Pricing.fromJson(Map<String, dynamic> json) => Pricing(
//     price: json["price"],
//     currency: json["currency"],
//     toCountry: json["to_country"],
//     breakdown: json["breakdown"] == null ? [] : List<Breakdown>.from(json["breakdown"]!.map((x) => Breakdown.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "price": price,
//     "currency": currency,
//     "to_country": toCountry,
//     "breakdown": breakdown == null ? [] : List<dynamic>.from(breakdown!.map((x) => x.toJson())),
//   };
// }
//
// class Breakdown {
//   final String? type;
//   final String? label;
//   final String? value;
//
//   Breakdown({
//     this.type,
//     this.label,
//     this.value,
//   });
//
//   factory Breakdown.fromJson(Map<String, dynamic> json) => Breakdown(
//     type: json["type"],
//     label: json["label"],
//     value: json["value"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "type": type,
//     "label": label,
//     "value": value,
//   };
// }
//
// class PricingInfo {
//   final double? deliveryCharge;
//   final double? deliveryProtectionFee;
//   final double? productPrice;
//   final double? productProtectionFee;
//   final double? total;
//   final String? currency;
//
//   PricingInfo({
//     this.deliveryCharge,
//     this.deliveryProtectionFee,
//     this.productPrice,
//     this.productProtectionFee,
//     this.total,
//     this.currency,
//   });
//
//   factory PricingInfo.fromJson(Map<String, dynamic> json) => PricingInfo(
//     // deliveryCharge: json["deliveryCharge"]?.toDouble(),
//     // deliveryProtectionFee: json["deliveryProtectionFee"]?.toDouble(),
//     // productPrice: json["productPrice"]?.toDouble(),
//     // productProtectionFee: json["productProtectionFee"]?.toDouble(),
//     // total: json["total"]?.toDouble(),
//     // currency: json["currency"],
//     deliveryCharge: json["deliveryCharge"],
//     deliveryProtectionFee: json["deliveryProtectionFee"],
//     productPrice: json["productPrice"],
//     productProtectionFee: json["productProtectionFee"],
//     total: json["total"],
//     currency: json["currency"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "deliveryCharge": deliveryCharge,
//     "deliveryProtectionFee": deliveryProtectionFee,
//     "productPrice": productPrice,
//     "productProtectionFee": productProtectionFee,
//     "total": total,
//     "currency": currency,
//   };
// }
//
// class ShippingMethodInfo {
//   final int? id;
//   final String? name;
//   final String? carrier;
//   final String? minWeight;
//   final String? maxWeight;
//   final String? servicePointInput;
//   final int? price;
//   final List<Country>? countries;
//
//   ShippingMethodInfo({
//     this.id,
//     this.name,
//     this.carrier,
//     this.minWeight,
//     this.maxWeight,
//     this.servicePointInput,
//     this.price,
//     this.countries,
//   });
//
//   factory ShippingMethodInfo.fromJson(Map<String, dynamic> json) => ShippingMethodInfo(
//     id: json["id"],
//     name: json["name"],
//     carrier: json["carrier"],
//     minWeight: json["min_weight"],
//     maxWeight: json["max_weight"],
//     servicePointInput: json["service_point_input"],
//     price: json["price"],
//     countries: json["countries"] == null ? [] : List<Country>.from(json["countries"]!.map((x) => Country.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "carrier": carrier,
//     "min_weight": minWeight,
//     "max_weight": maxWeight,
//     "service_point_input": servicePointInput,
//     "price": price,
//     "countries": countries == null ? [] : List<dynamic>.from(countries!.map((x) => x.toJson())),
//   };
// }
//
// class Country {
//   final int? id;
//   final String? name;
//   final int? price;
//   final String? iso2;
//   final String? iso3;
//   final dynamic leadTimeHours;
//   final List<PriceBreakdown>? priceBreakdown;
//
//   Country({
//     this.id,
//     this.name,
//     this.price,
//     this.iso2,
//     this.iso3,
//     this.leadTimeHours,
//     this.priceBreakdown,
//   });
//
//   factory Country.fromJson(Map<String, dynamic> json) => Country(
//     id: json["id"],
//     name: json["name"],
//     price: json["price"],
//     iso2: json["iso_2"],
//     iso3: json["iso_3"],
//     leadTimeHours: json["lead_time_hours"],
//     priceBreakdown: json["price_breakdown"] == null ? [] : List<PriceBreakdown>.from(json["price_breakdown"]!.map((x) => PriceBreakdown.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "price": price,
//     "iso_2": iso2,
//     "iso_3": iso3,
//     "lead_time_hours": leadTimeHours,
//     "price_breakdown": priceBreakdown == null ? [] : List<dynamic>.from(priceBreakdown!.map((x) => x.toJson())),
//   };
// }
//
// class PriceBreakdown {
//   final Type? type;
//   final Label? label;
//   final int? value;
//
//   PriceBreakdown({
//     this.type,
//     this.label,
//     this.value,
//   });
//
//   factory PriceBreakdown.fromJson(Map<String, dynamic> json) => PriceBreakdown(
//     type: typeValues.map[json["type"]]!,
//     label: labelValues.map[json["label"]]!,
//     value: json["value"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "type": typeValues.reverse[type],
//     "label": labelValues.reverse[label],
//     "value": value,
//   };
// }
//
// enum Label {
//   LABEL
// }
//
// final labelValues = EnumValues({
//   "Label": Label.LABEL
// });
//
// enum Type {
//   PRICE_WITHOUT_INSURANCE
// }
//
// final typeValues = EnumValues({
//   "price_without_insurance": Type.PRICE_WITHOUT_INSURANCE
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }



class ShippingPricingData {
  final PricingInfo? pricingInfo;
  final ShippingMethodInfo? shippingMethodInfo;
  final List<Pricing>? pricing;
  final Order? order;

  ShippingPricingData({
    this.pricingInfo,
    this.shippingMethodInfo,
    this.pricing,
    this.order,
  });

  factory ShippingPricingData.fromJson(Map<String, dynamic> json) => ShippingPricingData(
    pricingInfo: json["pricingInfo"] == null ? null : PricingInfo.fromJson(json["pricingInfo"]),
    shippingMethodInfo: json["shippingMethodInfo"] == null ? null : ShippingMethodInfo.fromJson(json["shippingMethodInfo"]),
    pricing: json["pricing"] == null ? [] : List<Pricing>.from(json["pricing"]!.map((x) => Pricing.fromJson(x))),
    order: json["order"] == null ? null : Order.fromJson(json["order"]),
  );

  Map<String, dynamic> toJson() => {
    "pricingInfo": pricingInfo?.toJson(),
    "shippingMethodInfo": shippingMethodInfo?.toJson(),
    "pricing": pricing == null ? [] : List<dynamic>.from(pricing!.map((x) => x.toJson())),
    "order": order?.toJson(),
  };
}

class Order {
  final int? id;
  final String? sellerId;
  final String? buyerId;
  final dynamic offerId;
  final String? protectionFee;
  final String? deliveryProtectionFee;
  final String? total;
  final dynamic deliveryCharge;
  final dynamic parcelId;
  final int? deliveryId;
  final String? status;
  final String? paymentStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Product? product;
  final DeliveryInfo? deliveryInfo;

  Order({
    this.id,
    this.sellerId,
    this.buyerId,
    this.offerId,
    this.protectionFee,
    this.deliveryProtectionFee,
    this.total,
    this.deliveryCharge,
    this.parcelId,
    this.deliveryId,
    this.status,
    this.paymentStatus,
    this.createdAt,
    this.updatedAt,
    this.product,
    this.deliveryInfo,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    sellerId: json["seller_id"],
    buyerId: json["buyer_id"],
    offerId: json["offer_id"],
    protectionFee: json["protectionFee"],
    deliveryProtectionFee: json["deliveryProtectionFee"],
    total: json["total"],
    deliveryCharge: json["deliveryCharge"],
    parcelId: json["parcel_id"],
    deliveryId: json["delivery_id"],
    status: json["status"],
    paymentStatus: json["paymentStatus"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
    deliveryInfo: json["deliveryInfo"] == null ? null : DeliveryInfo.fromJson(json["deliveryInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "seller_id": sellerId,
    "buyer_id": buyerId,
    "offer_id": offerId,
    "protectionFee": protectionFee,
    "deliveryProtectionFee": deliveryProtectionFee,
    "total": total,
    "deliveryCharge": deliveryCharge,
    "parcel_id": parcelId,
    "delivery_id": deliveryId,
    "status": status,
    "paymentStatus": paymentStatus,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "product": product?.toJson(),
    "deliveryInfo": deliveryInfo?.toJson(),
  };
}

class DeliveryInfo {
  final int? id;
  final String? name;
  final String? companyName;
  final String? email;
  final String? telephone;
  final String? address;
  final String? houseNumber;
  final String? address2;
  final String? city;
  final int? servicePointId;
  final String? country;
  final String? postalCode;

  DeliveryInfo({
    this.id,
    this.name,
    this.companyName,
    this.email,
    this.telephone,
    this.address,
    this.houseNumber,
    this.address2,
    this.city,
    this.servicePointId,
    this.country,
    this.postalCode,
  });

  factory DeliveryInfo.fromJson(Map<String, dynamic> json) => DeliveryInfo(
    id: json["id"],
    name: json["name"],
    companyName: json["company_name"],
    email: json["email"],
    telephone: json["telephone"],
    address: json["address"],
    houseNumber: json["house_number"],
    address2: json["address_2"],
    city: json["city"],
    servicePointId: json["service_point_id"],
    country: json["country"],
    postalCode: json["postal_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "company_name": companyName,
    "email": email,
    "telephone": telephone,
    "address": address,
    "house_number": houseNumber,
    "address_2": address2,
    "city": city,
    "service_point_id": servicePointId,
    "country": country,
    "postal_code": postalCode,
  };
}

class Product {
  final int? id;
  final String? userId;
  final String? productName;
  final String? status;
  final String? sellingPrice;
  final String? category;
  final int? quantity;
  final String? description;
  final String? condition;
  final String? size;
  final String? brand;
  final bool? isNegotiable;
  final bool? isBoosted;
  final dynamic boostStartTime;
  final dynamic boostEndTime;
  final String? weight;
  final String? length;
  final dynamic servicePointId;
  final String? width;
  final String? height;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Image>? images;
  final User? user;
  final DeliveryInfo? collectionAddress;

  Product({
    this.id,
    this.userId,
    this.productName,
    this.status,
    this.sellingPrice,
    this.category,
    this.quantity,
    this.description,
    this.condition,
    this.size,
    this.brand,
    this.isNegotiable,
    this.isBoosted,
    this.boostStartTime,
    this.boostEndTime,
    this.weight,
    this.length,
    this.servicePointId,
    this.width,
    this.height,
    this.createdAt,
    this.updatedAt,
    this.images,
    this.user,
    this.collectionAddress,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    userId: json["user_id"],
    productName: json["product_name"],
    status: json["status"],
    sellingPrice: json["selling_price"],
    category: json["category"],
    quantity: json["quantity"],
    description: json["description"],
    condition: json["condition"],
    size: json["size"],
    brand: json["brand"],
    isNegotiable: json["is_negotiable"],
    isBoosted: json["is_boosted"],
    boostStartTime: json["boost_start_time"],
    boostEndTime: json["boost_end_time"],
    weight: json["weight"],
    length: json["length"],
    servicePointId: json["service_point_id"],
    width: json["width"],
    height: json["height"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    collectionAddress: json["collectionAddress"] == null ? null : DeliveryInfo.fromJson(json["collectionAddress"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "product_name": productName,
    "status": status,
    "selling_price": sellingPrice,
    "category": category,
    "quantity": quantity,
    "description": description,
    "condition": condition,
    "size": size,
    "brand": brand,
    "is_negotiable": isNegotiable,
    "is_boosted": isBoosted,
    "boost_start_time": boostStartTime,
    "boost_end_time": boostEndTime,
    "weight": weight,
    "length": length,
    "service_point_id": servicePointId,
    "width": width,
    "height": height,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
    "user": user?.toJson(),
    "collectionAddress": collectionAddress?.toJson(),
  };
}

class Image {
  final int? id;
  final int? productId;
  final String? image;
  final DateTime? timestampSecond;

  Image({
    this.id,
    this.productId,
    this.image,
    this.timestampSecond,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"],
    productId: json["product_id"],
    image: json["image"],
    timestampSecond: json["TimestampSecond"] == null ? null : DateTime.parse(json["TimestampSecond"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "image": image,
    "TimestampSecond": timestampSecond?.toIso8601String(),
  };
}

class User {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final dynamic image;
  final String? status;
  final int? rating;
  final String? address;
  final String? currency;
  final String? phone;
  final List<String>? roles;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.image,
    this.status,
    this.rating,
    this.address,
    this.currency,
    this.phone,
    this.roles,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    image: json["image"],
    status: json["status"],
    rating: json["rating"],
    address: json["address"],
    currency: json["currency"],
    phone: json["phone"],
    roles: json["roles"] == null ? [] : List<String>.from(json["roles"]!.map((x) => x)),
    isActive: json["isActive"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    deletedAt: json["deletedAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "image": image,
    "status": status,
    "rating": rating,
    "address": address,
    "currency": currency,
    "phone": phone,
    "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
    "isActive": isActive,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "deletedAt": deletedAt,
  };
}

class Pricing {
  final String? price;
  final String? currency;
  final String? toCountry;
  final List<Breakdown>? breakdown;

  Pricing({
    this.price,
    this.currency,
    this.toCountry,
    this.breakdown,
  });

  factory Pricing.fromJson(Map<String, dynamic> json) => Pricing(
    price: json["price"],
    currency: json["currency"],
    toCountry: json["to_country"],
    breakdown: json["breakdown"] == null ? [] : List<Breakdown>.from(json["breakdown"]!.map((x) => Breakdown.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "price": price,
    "currency": currency,
    "to_country": toCountry,
    "breakdown": breakdown == null ? [] : List<dynamic>.from(breakdown!.map((x) => x.toJson())),
  };
}

class Breakdown {
  final String? type;
  final String? label;
  final dynamic value;

  Breakdown({
    this.type,
    this.label,
    this.value,
  });

  factory Breakdown.fromJson(Map<String, dynamic> json) => Breakdown(
    type: json["type"],
    label: json["label"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "label": label,
    "value": value,
  };
}

class PricingInfo {
  final double? deliveryCharge;
  final double? deliveryProtectionFee;
  final double? productPrice;
  final double? productProtectionFee;
  final double? total;
  final String? currency;

  PricingInfo({
    this.deliveryCharge,
    this.deliveryProtectionFee,
    this.productPrice,
    this.productProtectionFee,
    this.total,
    this.currency,
  });

  factory PricingInfo.fromJson(Map<String, dynamic> json) => PricingInfo(
    deliveryCharge: json["deliveryCharge"]?.toDouble(),
    deliveryProtectionFee: json["deliveryProtectionFee"]?.toDouble(),
    productPrice: json["productPrice"]?.toDouble(),
    productProtectionFee: json["productProtectionFee"]?.toDouble(),
    total: json["total"]?.toDouble(),
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "deliveryCharge": deliveryCharge,
    "deliveryProtectionFee": deliveryProtectionFee,
    "productPrice": productPrice,
    "productProtectionFee": productProtectionFee,
    "total": total,
    "currency": currency,
  };
}

class ShippingMethodInfo {
  final int? id;
  final String? name;
  final String? carrier;
  final String? minWeight;
  final String? maxWeight;
  final String? servicePointInput;
  final int? price;
  final List<Country>? countries;

  ShippingMethodInfo({
    this.id,
    this.name,
    this.carrier,
    this.minWeight,
    this.maxWeight,
    this.servicePointInput,
    this.price,
    this.countries,
  });

  factory ShippingMethodInfo.fromJson(Map<String, dynamic> json) => ShippingMethodInfo(
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
  final double? price;
  final String? iso2;
  final String? iso3;
  final int? leadTimeHours;
  final List<Breakdown>? priceBreakdown;

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
    price: json["price"]?.toDouble(),
    iso2: json["iso_2"],
    iso3: json["iso_3"],
    leadTimeHours: json["lead_time_hours"],
    priceBreakdown: json["price_breakdown"] == null ? [] : List<Breakdown>.from(json["price_breakdown"]!.map((x) => Breakdown.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "iso_2": iso2,
    "iso_3": iso3,
    "lead_time_hours": leadTimeHours,
    "price_breakdown": priceBreakdown == null ? [] : List<dynamic>.from(priceBreakdown!.map((x) => x.toJson())),
  };
}
