// To parse this JSON data, do
//
//     final vpnConfiguration = vpnConfigurationFromJson(jsonString);

import 'dart:convert';

VpnConfiguration vpnConfigurationFromJson(String str) => VpnConfiguration.fromJson(json.decode(str));

String vpnConfigurationToJson(VpnConfiguration data) => json.encode(data.toJson());

class VpnConfiguration {
    String username;
    String password;
    String counrtyName;
    String config;

    VpnConfiguration({
        required this.username,
        required this.password,
        required this.counrtyName,
        required this.config,
    });

    factory VpnConfiguration.fromJson(Map<String, dynamic> json) => VpnConfiguration(
        username: json["username"],
        password: json["password"],
        counrtyName: json["counrtyName"],
        config: json["config"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "counrtyName": counrtyName,
        "config": config,
    };
}
