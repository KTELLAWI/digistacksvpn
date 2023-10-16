// ignore_for_file: prefer_const_constructors

import 'package:digistacksvpn/allControllers/controller_vpn_location.dart';
import 'package:digistacksvpn/allwidgets/vpn_location_card_widget.dart';
import 'package:digistacksvpn/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lottie/lottie.dart';

class AvailableVpnServersLocation extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  AvailableVpnServersLocation({super.key});

  final vpnLocationController = ControllerVpnLocation();

  loadingWidget() {
    return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              SizedBox(
                width: sizeScreen.width /2,
                child:  Lottie.asset('countryFlags/loading.json'), 
              ),
            

              // CircularProgressIndicator(
              //   valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
              // ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Gathering Free VPN Location....",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]));
  }

  noVpnServerFoundWidget() {
    return Center(
      child: Text(
        "No VPNs Found , Try again ",
        style: TextStyle(
          fontSize: 18,
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  vpnAvailableServerData() {
    return ListView.builder(
      itemCount: vpnLocationController.vpnFreeServerList.length,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(3),
      itemBuilder: (BuildContext context, int index) {
        return VpnLocationCardWidget(
            vpnInfo: vpnLocationController.vpnFreeServerList[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (vpnLocationController.vpnFreeServerList.isEmpty) {
      vpnLocationController.retriveVpnInformation();
    }

    return Obx(() => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orangeAccent,
            title: Text(
              // ignore: prefer_interpolation_to_compose_strings
              "Vpn Locations (" +
                  vpnLocationController.vpnFreeServerList.length.toString() +
                  ")",
            ),
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: 10, right: 10),
            child: FloatingActionButton(
              backgroundColor: Colors.orangeAccent,
              child: Icon(CupertinoIcons.refresh_circled,
              size: 40,
              ),
              onPressed: () {
                vpnLocationController.retriveVpnInformation();
              },
            ),
          ),
          body: vpnLocationController.isLoadingNewLocations.value
              ? loadingWidget()
              : vpnLocationController.vpnFreeServerList.isEmpty
                  ? noVpnServerFoundWidget()
                  : vpnAvailableServerData(),
        ));
  }
}
