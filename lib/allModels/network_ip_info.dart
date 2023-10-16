// To parse this JSON data, do
//
//     final networkIpInfo = networkIpInfoFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

NetworkIpInfo networkIpInfoFromJson(String str) => NetworkIpInfo.fromJson(json.decode(str));

String networkIpInfoToJson(NetworkIpInfo data) => json.encode(data.toJson());

class NetworkIpInfo {
    final String titleText;
    final String subTitleText;
    final Icon iconData;

    NetworkIpInfo({
        required this.titleText,
        required this.subTitleText,
        required this.iconData,
    });

    factory NetworkIpInfo.fromJson(Map<String, dynamic> json) => NetworkIpInfo(
        titleText: json["titleText"],
        subTitleText: json["subTitleText"],
        iconData: json["iconData"],
    );

    Map<String, dynamic> toJson() => {
        "titleText": titleText,
        "subTitleText": subTitleText,
        "iconData": iconData,
    };
}
