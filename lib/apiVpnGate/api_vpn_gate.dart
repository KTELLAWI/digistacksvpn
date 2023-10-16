import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:digistacksvpn/allModels/ip-info.dart';
import 'package:digistacksvpn/allModels/vpn_info.dart';
import 'package:digistacksvpn/appPreferences/app_Preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiVpnGate {
  static Future<List<VpnInfo>> retriveAllAvailableFreeVpnServers() async {
    final List<VpnInfo> vpnServerList = [];

    try {
      final responseFromApi =
          await http.get(Uri.parse("https://www.vpngate.net/api/iphone/"));
      final commaSepratedValuesStrings =
          responseFromApi.body.split("#")[1].replaceAll("*", "");
      List<List<dynamic>> listData =
          const CsvToListConverter().convert(commaSepratedValuesStrings);
      final header = listData[0];
      for (int counter = 1; counter < listData.length - 1; counter++) {
        Map<String, dynamic> jsonData = {};

        for (int innercounter = 0;
            innercounter < header.length;
            innercounter++) {
          jsonData.addAll({
            header[innercounter].toString(): listData[counter][innercounter]
          });
          //  print(jsonData);
          vpnServerList.add(VpnInfo.fromJson(jsonData));
          //print(vpnServerList[0].countryLongName);
        }
      }
    } catch (errMsg) {
      // ignore: avoid_print
      print(errMsg);
      Get.snackbar(
        "Error Message",
        errMsg.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.redAccent.withOpacity(.1),
      );
    }

    vpnServerList.shuffle();
    if (vpnServerList.isNotEmpty) AppPreferences.vpnList = vpnServerList;
    return vpnServerList;
  }

  static Future<void> retriveIPDetails(
      {required Rx<IpInfo> ipInformation}) async {
    try {
      final responseFromApi =
          await http.get(Uri.parse("http://ip-api.com/json/"));
      final dataFromApi = jsonDecode(responseFromApi.body);
      ipInformation.value = IpInfo.fromJson(dataFromApi);
    } catch (errMsg) {
      Get.snackbar(
        "Error Message",
        errMsg.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.redAccent.withOpacity(.1),
      );
    }
  }
}
