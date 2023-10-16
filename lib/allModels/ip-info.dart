// To parse this JSON data, do
//
//     final ipInfo = ipInfoFromJson(jsonString);

import 'dart:convert';

IpInfo ipInfoFromJson(String str) => IpInfo.fromJson(json.decode(str));

String ipInfoToJson(IpInfo data) => json.encode(data.toJson());

class IpInfo {
  late  final String countryName;
  late  final String regionName;
  late  final String cityName;
  late  final String zipCode;
  late  final String timeZone;
  late  final String internetServiceProvider;
  late  final String query;

    IpInfo({
        required this.countryName,
        required this.regionName,
        required this.cityName,
        required this.zipCode,
        required this.timeZone,
        required this.internetServiceProvider,
        required this.query,
    });

    factory IpInfo.fromJson(Map<String, dynamic> json) => IpInfo(
        countryName: json["countryName"] ?? '',
        regionName: json["regionName"] ?? "",
        cityName: json["city"] ?? "",
        zipCode: json["zip"]  ?? "",
        timeZone: json["timeZone"] ?? "",
        internetServiceProvider: json["isp"] ?? "",
        query: json["query"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "countryName": countryName,
        "regionName": regionName,
        "cityName": cityName,
        "zipCode": zipCode,
        "timeZone": timeZone,
        "internetServiceProvider": internetServiceProvider,
        "query": query,
    };
}
