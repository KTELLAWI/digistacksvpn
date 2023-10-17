// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:ui';

import 'package:digistacksvpn/allModels/vpn_config.dart';
import 'package:digistacksvpn/allModels/vpn_info.dart';
import 'package:digistacksvpn/appPreferences/app_Preferences.dart';
import 'package:digistacksvpn/vpnEngine/vpn_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControllerHome extends GetxController {
  final Rx<VpnInfo> vpnInfo = AppPreferences.vpnInfoObj.obs;
  final vpnConnectionState = VpnEngine.vpnDisconnected.obs;

  void connectToVpnNow() async {
    if (vpnInfo.value.base64OpenVpnConfigurationData.isEmpty) {
      Get.snackbar("Country/Locataion", "Please select the country");
      return;
    }
    if (vpnConnectionState.value == VpnEngine.vpnDisconnected) {
      final dataConfigVpn = Base64Decoder().convert(vpnInfo.value.base64OpenVpnConfigurationData);
      final configuration = const Utf8Decoder().convert(dataConfigVpn);

      // ignore: non_constant_identifier_names
      final vpnConfiguration = VpnConfig(
          username: "vpn",
          password: "vpn",
          config: configuration, country: vpnInfo.value.countryLongName,);

      await VpnEngine.startVpn(vpnConfiguration);
    } else {
      await VpnEngine.stopVpn();
    }
  }

  Color get getRoundButtonColor {
    switch (vpnConnectionState.value) {
      case VpnEngine.vpnDisconnected:
        return Colors.orangeAccent;
      case VpnEngine.vpnConnected:
        return Colors.green;
      default:
        return Colors.orangeAccent;
    }
  }

  String get getRoundVpnButtonText {
    switch (vpnConnectionState.value) {
      case VpnEngine.vpnDisconnected:
        return "Tap to Connect";
      case VpnEngine.vpnConnected:
        return "Disconnect";
      default:
        return "Connecting";
    }
  }
}
