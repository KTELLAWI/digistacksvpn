// To parse this JSON data, do
//
//     final vpnInfo = vpnInfoFromJson(jsonString);

import 'dart:convert';

VpnInfo vpnInfoFromJson(String str) => VpnInfo.fromJson(json.decode(str));

String vpnInfoToJson(VpnInfo data) => json.encode(data.toJson());

class VpnInfo {
  late  String hostName;
  late  String ip;
  late  int? ping;
  late  int speed;
  late  String countryLongName;
  late  String countryShortName;
  late  int vpnSessionName;
  late  String base64OpenVpnConfigurationData;

    VpnInfo({
        required this.hostName,
        required this.ip,
         this.ping,
        required this.speed,
        required this.countryLongName,
        required this.countryShortName,
        required this.vpnSessionName,
        required this.base64OpenVpnConfigurationData,
    });

    factory VpnInfo.fromJson(Map<String, dynamic> json) => VpnInfo(
        hostName: json["HostName"] ?? "HostName",
        ip: json["IP"] ?? "IP",
        ping: json["Ping"] ?? 0,
        speed: json["Speed"] ?? 0,
        countryLongName: json["CountryLong"] ?? "CountryLong",
        countryShortName: json["CountryShort"] ?? "CountryShort",
        vpnSessionName: json["NumVpnSessions"] ?? 0,
        base64OpenVpnConfigurationData: json["OpenVPN_ConfigData_Base64"] ?? "OpenVPN_ConfigData_Base64",
    );

    Map<String, dynamic> toJson() => {
        "HostName": hostName,
        "IP": ip, 
        "Ping": ping,
        "Speed": speed,
        "CountryLong": countryLongName,
        "CountryShort": countryLongName,
        "NumVpnSessions": vpnSessionName,
        "OpenVPN_ConfigData_Base64": base64OpenVpnConfigurationData,
    };
}
