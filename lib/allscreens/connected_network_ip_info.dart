// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, duplicate_ignore

import 'package:digistacksvpn/allModels/ip-info.dart';
import 'package:digistacksvpn/allModels/network_ip_info.dart';
import 'package:digistacksvpn/allwidgets/network_ip_info_widget.dart';
import 'package:digistacksvpn/apiVpnGate/api_vpn_gate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectedNetworkIPScreen extends StatelessWidget {
  const ConnectedNetworkIPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ipInfo = IpInfo.fromJson({}).obs;
    ApiVpnGate.retriveIPDetails(ipInformation: ipInfo);

    return Scaffold(
      // ignore: prefer_const_constructors
      floatingActionButton: Padding(
        // ignore: prefer_const_constructors
        padding: EdgeInsets.only(
          bottom: 10,
          right: 10,
        ),
        child: FloatingActionButton(
          onPressed: () {
            ipInfo.value = IpInfo.fromJson({});
            ApiVpnGate.retriveIPDetails(ipInformation: ipInfo);
          },
          backgroundColor: Colors.orangeAccent,
          // ignore: prefer_const_constructors
          child: Icon(CupertinoIcons.refresh_circled),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text(
          'IP INFORMATION',
          style: TextStyle(fontSize: 14),
        ),
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: const Icon(Icons.perm_device_info),
        // ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       Get.changeThemeMode(AppPreferences.isModeDark
        //           ? ThemeMode.light
        //           : ThemeMode.dark);

        //       AppPreferences.isModeDark = !AppPreferences.isModeDark;
        //     },
        //     icon: const Icon(Icons.brightness_2_outlined),
        //   )
        // ]
      ),
      body: Obx(() => ListView(
            // ignore: prefer_const_constructors
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.all(3),
            children: [
              // ignore: ip address
              NetworkIpInfoWidget(
                  networkIPInfo: NetworkIpInfo(
                      titleText: 'Ip Address',
                      subTitleText: ipInfo.value.query,
                      iconData: Icon(Icons.my_location_outlined,
                          size: 14, color: Colors.redAccent))),

              ///isp
              NetworkIpInfoWidget(
                  networkIPInfo: NetworkIpInfo(
                      titleText: 'internet Service  Provider',
                      subTitleText: ipInfo.value.internetServiceProvider,
                      iconData: Icon(Icons.account_tree,
                          size: 14, color: Colors.deepOrange))),

              ///location
              ///
              NetworkIpInfoWidget(
                  networkIPInfo: NetworkIpInfo(
                      titleText: "Location",
                      subTitleText: ipInfo.value.countryName.isEmpty
                          ? "Retriving...."
                          : "${ipInfo.value.countryName} ${ipInfo.value.cityName}",
                      iconData: Icon(CupertinoIcons.location_solid,
                          size: 14, color: Colors.green))),

              ///ping
              NetworkIpInfoWidget(
                  networkIPInfo: NetworkIpInfo(
                      titleText: 'Pine Code',
                      subTitleText: ipInfo.value.zipCode,
                      iconData: Icon(CupertinoIcons.map_pin_ellipse,
                          size: 14, color: Colors.redAccent))),

              ///
              ///time zone
              NetworkIpInfoWidget(
                  networkIPInfo: NetworkIpInfo(
                      titleText: 'Ip Address',
                      subTitleText: ipInfo.value.timeZone,
                      iconData: Icon(Icons.share_arrival_time_outlined,
                          size: 14, color: Colors.cyan))),

              ///
            ],
          )),
    );
  }
}
