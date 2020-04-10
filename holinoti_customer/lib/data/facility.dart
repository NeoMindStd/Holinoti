import 'dart:convert';

import 'package:holinoti_customer/data/facility_image.dart';
import 'package:holinoti_customer/data/opening_info.dart';

class Facility {
  int code;
  String name;
  String address;
  String phoneNumber;
  String comment;

  /// json 매핑시 제외
  List<OpeningInfo> openingInfo;
  List<FacilityImage> facilityImages;

  Facility({
    this.code = -1,
    this.name,
    this.address = "",
    this.phoneNumber = "",
    this.comment = "",
    this.openingInfo,
  }) {
    openingInfo ??= [];
    facilityImages ??= [];
  }

  factory Facility.fromJson(Map<String, dynamic> json) => Facility(
    code: json['code'] as int,
    name: json['name'] as String,
    address: json['address'] as String,
    phoneNumber: json['phoneNumber'] as String,
    comment: json['comment'] as String,
  );

  Map<String, dynamic> toJson() => {
    'code': code,
    'name': name,
    'address': address,
    'phoneNumber': phoneNumber,
    'comment': comment,
  };

  @override
  String toString() {
    return 'Facility{code: $code, name: $name, address: $address, phoneNumber: $phoneNumber, comment: $comment}';
  }
}

Facility facilityFromJson(String string) =>
    Facility.fromJson(json.decode(string));

String facilityToJson(Facility facility) => json.encode(facility.toJson());