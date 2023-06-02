// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromMap(jsonString);

import 'dart:convert';

class BannerModel {
  String bannerPrincipal;

  BannerModel({
    required this.bannerPrincipal,
  });

  factory BannerModel.fromJson(String str) =>
      BannerModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BannerModel.fromMap(Map<String, dynamic> json) => BannerModel(
        bannerPrincipal: json["banner_Principal"],
      );

  Map<String, dynamic> toMap() => {
        "banner_Principal": bannerPrincipal,
      };
}
