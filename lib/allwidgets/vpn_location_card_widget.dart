// ignore_for_file: unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'dart:math';

import 'package:digistacksvpn/allControllers/controller_home.dart';
import 'package:digistacksvpn/allModels/vpn_info.dart';
import 'package:digistacksvpn/appPreferences/app_Preferences.dart';
import 'package:digistacksvpn/main.dart';
import 'package:digistacksvpn/vpnEngine/vpn_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VpnLocationCardWidget extends StatelessWidget {
  final VpnInfo vpnInfo;
  // ignore: prefer_const_constructors_in_immutables
  VpnLocationCardWidget({required this.vpnInfo, super.key});

  String formatSpeedbytes(int speedBytes, int decimals) {
    if (speedBytes <= 0) {
      return "0 B";
    }

    const suffixesTitle = ["Bps", "Kbps", "Mbps", "Gbps", "Tbps"];
    var speed = (log(speedBytes) / log(1024)).floor();
    return "${(speedBytes / pow(1024, speed)).toStringAsFixed(decimals)} ${suffixesTitle[speed]}";
  }

  @override
  Widget build(BuildContext context) {
    sizeScreen = MediaQuery.of(context).size;
    final homeControler = Get.find<ControllerHome>();
    return Card(
      elevation: 6,
      color: Colors.lightBlue.withOpacity(0.5),
      margin: EdgeInsets.symmetric(vertical: sizeScreen.height * .01),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          homeControler.vpnInfo.value = vpnInfo;
          AppPreferences.vpnInfoObj = vpnInfo;
          Get.back();
          if (homeControler.vpnConnectionState.value ==
              VpnEngine.vpnConnected) {
            VpnEngine.stopVpn();
            Future.delayed(
                Duration(seconds: 3), () => homeControler.connectToVpnNow());
          } else {
            homeControler.connectToVpnNow();
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          leading: Container(
            padding: EdgeInsets.all(0.5),
            decoration: BoxDecoration(
             // border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.asset(
              "countryFlags/${vpnInfo.countryLongName.toLowerCase()}.png",
              height: 40,
              width: sizeScreen.width * .08,
              fit: BoxFit.contain,
            ),
          ),
          title: Text(vpnInfo.countryShortName),
          subtitle: Row(
            children: [
              Icon(
                Icons.shutter_speed,
                size: 20,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                formatSpeedbytes(vpnInfo.speed, 2),
              )
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                vpnInfo.vpnSessionName.toString(),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).lightTextColor,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                CupertinoIcons.person_2_alt,
                color: Colors.orangeAccent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
