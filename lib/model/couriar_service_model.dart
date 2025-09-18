

class CourierServiceModel {
  final int? serviceId;
  final String? serviceName;
  final String? carrierName;
  final int? chargeableWeight;
  final String? transitTimeEstimate;
  final String? sameDayCollectionCutOffTime;
  final bool? isWarehouseService;
  final TotalCost? totalCost;
  final List<OptionalExtra>? servicePriceBreakdown;
  final List<OptionalExtra>? optionalExtras;
  final bool? signatureRequiredAvailable;
  final List<ExpectedLabel>? expectedLabels;
  final List<CollectionOption>? collectionOptions;
  final String? serviceType;

  CourierServiceModel({
    this.serviceId,
    this.serviceName,
    this.carrierName,
    this.chargeableWeight,
    this.transitTimeEstimate,
    this.sameDayCollectionCutOffTime,
    this.isWarehouseService,
    this.totalCost,
    this.servicePriceBreakdown,
    this.optionalExtras,
    this.signatureRequiredAvailable,
    this.expectedLabels,
    this.collectionOptions,
    this.serviceType,
  });

  factory CourierServiceModel.fromJson(Map<String, dynamic> json) => CourierServiceModel(
    serviceId: json["ServiceID"],
    serviceName: json["ServiceName"],
    carrierName: json["CarrierName"],
    chargeableWeight: json["ChargeableWeight"],
    transitTimeEstimate: json["TransitTimeEstimate"],
    sameDayCollectionCutOffTime: json["SameDayCollectionCutOffTime"],
    isWarehouseService: json["IsWarehouseService"],
    totalCost: json["TotalCost"] == null ? null : TotalCost.fromJson(json["TotalCost"]),
    servicePriceBreakdown: json["ServicePriceBreakdown"] == null ? [] : List<OptionalExtra>.from(json["ServicePriceBreakdown"]!.map((x) => OptionalExtra.fromJson(x))),
    optionalExtras: json["OptionalExtras"] == null ? [] : List<OptionalExtra>.from(json["OptionalExtras"]!.map((x) => OptionalExtra.fromJson(x))),
    signatureRequiredAvailable: json["SignatureRequiredAvailable"],
    expectedLabels: json["ExpectedLabels"] == null ? [] : List<ExpectedLabel>.from(json["ExpectedLabels"]!.map((x) => ExpectedLabel.fromJson(x))),
    collectionOptions: json["CollectionOptions"] == null ? [] : List<CollectionOption>.from(json["CollectionOptions"]!.map((x) => CollectionOption.fromJson(x))),
    serviceType: json["ServiceType"],
  );

  Map<String, dynamic> toJson() => {
    "ServiceID": serviceId,
    "ServiceName": serviceName,
    "CarrierName": carrierName,
    "ChargeableWeight": chargeableWeight,
    "TransitTimeEstimate": transitTimeEstimate,
    "SameDayCollectionCutOffTime": sameDayCollectionCutOffTime,
    "IsWarehouseService": isWarehouseService,
    "TotalCost": totalCost?.toJson(),
    "ServicePriceBreakdown": servicePriceBreakdown == null ? [] : List<dynamic>.from(servicePriceBreakdown!.map((x) => x.toJson())),
    "OptionalExtras": optionalExtras == null ? [] : List<dynamic>.from(optionalExtras!.map((x) => x.toJson())),
    "SignatureRequiredAvailable": signatureRequiredAvailable,
    "ExpectedLabels": expectedLabels == null ? [] : List<dynamic>.from(expectedLabels!.map((x) => x.toJson())),
    "CollectionOptions": collectionOptions == null ? [] : List<dynamic>.from(collectionOptions!.map((x) => x.toJson())),
    "ServiceType": serviceType,
  };
}

class CollectionOption {
  final int? collectionOptionId;
  final String? collectionOptionTitle;
  final double? collectionCharge;
  final String? sameDayCollectionCutOffTime;
  final ExpectedLabel? expectedLabel;

  CollectionOption({
    this.collectionOptionId,
    this.collectionOptionTitle,
    this.collectionCharge,
    this.sameDayCollectionCutOffTime,
    this.expectedLabel,
  });

  factory CollectionOption.fromJson(Map<String, dynamic> json) => CollectionOption(
    collectionOptionId: json["CollectionOptionID"],
    collectionOptionTitle: json["CollectionOptionTitle"],
    collectionCharge: json["CollectionCharge"]?.toDouble(),
    sameDayCollectionCutOffTime: json["SameDayCollectionCutOffTime"],
    expectedLabel: json["ExpectedLabel"] == null ? null : ExpectedLabel.fromJson(json["ExpectedLabel"]),
  );

  Map<String, dynamic> toJson() => {
    "CollectionOptionID": collectionOptionId,
    "CollectionOptionTitle": collectionOptionTitle,
    "CollectionCharge": collectionCharge,
    "SameDayCollectionCutOffTime": sameDayCollectionCutOffTime,
    "ExpectedLabel": expectedLabel?.toJson(),
  };
}

class ExpectedLabel {
  final String? labelRole;
  final String? labelFormat;
  final String? labelGenerateStatus;
  final List<AvailableSize>? availableSizes;

  ExpectedLabel({
    this.labelRole,
    this.labelFormat,
    this.labelGenerateStatus,
    this.availableSizes,
  });

  factory ExpectedLabel.fromJson(Map<String, dynamic> json) => ExpectedLabel(
    labelRole: json["LabelRole"],
    labelFormat: json["LabelFormat"],
    labelGenerateStatus: json["LabelGenerateStatus"],
    availableSizes: json["AvailableSizes"] == null ? [] : List<AvailableSize>.from(json["AvailableSizes"]!.map((x) => AvailableSize.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "LabelRole": labelRole,
    "LabelFormat": labelFormat,
    "LabelGenerateStatus": labelGenerateStatus,
    "AvailableSizes": availableSizes == null ? [] : List<dynamic>.from(availableSizes!.map((x) => x.toJson())),
  };
}

class AvailableSize {
  final Size? size;

  AvailableSize({
    this.size,
  });

  factory AvailableSize.fromJson(Map<String, dynamic> json) => AvailableSize(
    size: sizeValues.map[json["Size"]]!,
  );

  Map<String, dynamic> toJson() => {
    "Size": sizeValues.reverse[size],
  };
}

enum Size {
  A4,
  THERMAL
}

final sizeValues = EnumValues({
  "A4": Size.A4,
  "Thermal": Size.THERMAL
});

class OptionalExtra {
  final String? code;
  final String? description;
  final double? cost;

  OptionalExtra({
    this.code,
    this.description,
    this.cost,
  });

  factory OptionalExtra.fromJson(Map<String, dynamic> json) => OptionalExtra(
    code: json["Code"],
    description: json["Description"],
    cost: json["Cost"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Description": description,
    "Cost": cost,
  };
}

class TotalCost {
  final double? totalCostNetWithCollection;
  final double? totalCostNetWithoutCollection;
  final double? totalCostGrossWithCollection;
  final double? totalCostGrossWithoutCollection;

  TotalCost({
    this.totalCostNetWithCollection,
    this.totalCostNetWithoutCollection,
    this.totalCostGrossWithCollection,
    this.totalCostGrossWithoutCollection,
  });

  factory TotalCost.fromJson(Map<String, dynamic> json) => TotalCost(
    totalCostNetWithCollection: json["TotalCostNetWithCollection"]?.toDouble(),
    totalCostNetWithoutCollection: json["TotalCostNetWithoutCollection"]?.toDouble(),
    totalCostGrossWithCollection: json["TotalCostGrossWithCollection"]?.toDouble(),
    totalCostGrossWithoutCollection: json["TotalCostGrossWithoutCollection"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "TotalCostNetWithCollection": totalCostNetWithCollection,
    "TotalCostNetWithoutCollection": totalCostNetWithoutCollection,
    "TotalCostGrossWithCollection": totalCostGrossWithCollection,
    "TotalCostGrossWithoutCollection": totalCostGrossWithoutCollection,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
