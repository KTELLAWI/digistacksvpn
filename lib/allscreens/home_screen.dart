// import 'dart:html';

// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables

//import 'dart:math';

import 'package:digistacksvpn/allControllers/controller_home.dart';
import 'package:digistacksvpn/allModels/vpn_status.dart';
import 'package:digistacksvpn/allscreens/available_vpn_servers_location_screen.dart';
import 'package:digistacksvpn/allscreens/connected_network_ip_info.dart';
import 'package:digistacksvpn/allwidgets/timer_widget.dart';
import 'package:digistacksvpn/vpnEngine/vpn_engine.dart';
import 'package:flutter/material.dart';
import '../appPreferences/app_Preferences.dart';
import 'package:get/get.dart';
import "/main.dart";
import 'package:flutter/cupertino.dart';
import '/custom__widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final homeControler = Get.put(ControllerHome());

  // ignore: non_constant_identifier_names
  LocationSelectionBottomNavigation(BuildContext context) {
    return SafeArea(
      child: Semantics(
        button: true,
        child: InkWell(
          onTap: () {
            Get.to(() => AvailableVpnServersLocation());
          },
          child:  ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0), // Adjust the top left radius as needed
          topRight: Radius.circular(20.0), // Adjust the top right radius as needed
        ),
        child:
          Container(
              color:Colors.orangeAccent, //Theme.of(context).bottomNavigationColor,
              padding: EdgeInsets.symmetric(horizontal: sizeScreen.width * .04),
              height: 60,
              child: Row(
                children: [
                  //icon
                  Icon(CupertinoIcons.globe, color: Colors.white, size: 28),

                  //for adding some space
                  SizedBox(width: 10),

                  //text
                  Text(
                    'Change Location',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),

                  //for covering available spacing
                  Spacer(),

                  //icon
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.keyboard_arrow_right_rounded,
                        color: Colors.blue, size: 26),
                  )
                ],
              )),
          // Container(
          //   color: Colors.black,
          //   padding: EdgeInsets.symmetric(
          //       horizontal: sizeScreen.width * 0.04, vertical: 8),
          //   child: const Row(children: [
          //     Icon(CupertinoIcons.flag_circle, color: Colors.white, size: 36),
          //     SizedBox(width: 12),
          //     Text("Select Location",
          //         style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 18,
          //             fontWeight: FontWeight.w400)),
          //     Spacer(),
          //     CircleAvatar(
          //       backgroundColor: Colors.white,
          //       child: Icon(Icons.keyboard_arrow_right,
          //           color: Colors.redAccent, size: 26),
          //     ),
          //   ]),
          // ),
        )
        ),
      ),
    );
  }

  Widget vpnRoundButton() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
      Semantics(
          button: true,
          child: InkWell(
              onTap: () {
                homeControler.connectToVpnNow();
              },
              borderRadius: BorderRadius.circular(100),
              child:  Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:homeControler.getRoundButtonColor.withOpacity(.1)),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: homeControler.getRoundButtonColor.withOpacity(.3)),
                  child: Container(
                    width: sizeScreen.height * .14,
                    height: sizeScreen.height * .14,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: homeControler.getRoundButtonColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //icon
                        Icon(
                          Icons.power_settings_new,
                          size: 28,
                          color: Colors.white,
                        ),

                        SizedBox(height: 4),

                        //text
                        Text(
                          homeControler.getRoundVpnButtonText,
                          style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // Container(
              //     padding: const EdgeInsets.all(18),
              //     decoration: BoxDecoration(
              //         shape: BoxShape.circle,
              //         color: homeControler.getRoundButtonColor.withOpacity(.1)),
              //     child: Container(
              //         padding: const EdgeInsets.all(16),
              //         decoration: BoxDecoration(
              //           shape: BoxShape.circle,
              //           color:
              //               homeControler.getRoundButtonColor.withOpacity(.1),
              //         ),
              //         child: Container(
              //             width: sizeScreen.height * .14,
              //             height: sizeScreen.height * .14,
              //             decoration: BoxDecoration(
              //                 shape: BoxShape.circle,
              //                 color: homeControler.getRoundButtonColor
              //                     .withOpacity(.1)),
              //             child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   // ignore: prefer_const_constructors
              //                   Icon(
              //                     Icons.power_settings_new,
              //                     size: 30,
              //                     color: Colors.white,
              //                   ),
              //                   // ignore: prefer_const_constructors
              //                   SizedBox(height: 10),
              //                   Text(homeControler.getRoundVpnButtonText,
              //                       // ignore: prefer_const_constructors
              //                       style: TextStyle(
              //                         fontSize: 13,
              //                         color: Colors.white,
              //                         fontWeight: FontWeight.w600,
              //                       ))
              //                 ])))
              //                 )
                              )),

      //////Timer
      Container(
        margin:EdgeInsets.only(top:sizeScreen.height * 0.015 , bottom: sizeScreen.height * .02),
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        decoration: BoxDecoration(color: Colors.orangeAccent,
        borderRadius: BorderRadius.circular(16)),
        child: Text(
          homeControler.vpnConnectionState.value == VpnEngine.vpnConnected ? "Not Connected" :
          homeControler.vpnConnectionState.replaceAll("", " ").toUpperCase(),
          style: TextStyle(fontSize: 13, color: Colors.white),
        ),

      ),
      Obx(() => TimerWidget(initTimerNow:homeControler.vpnConnectionState.value== VpnEngine.vpnConnected )),

    ]);
  }




  @override
  Widget build(BuildContext context) {
    sizeScreen = MediaQuery.of(context).size;

    VpnEngine.vpnStageSnapshot().listen((event) {
      homeControler.vpnConnectionState.value = event;
    });

    return Scaffold(
      appBar: CustomAppBar(
        title: Text('VPN APP'),
      ),
   
       // Container(child:
      // AppBar(
      //     title: const Text('Home Screen'),
      //     elevation: 2,
      //     shadowColor: Colors.black,
      //     backgroundColor: Colors.orangeAccent,
      //     leading: IconButton(
      //       onPressed: () {
      //         Get.to(() => ConnectedNetworkIPScreen());
      //       },
      //       icon: const Icon( CupertinoIcons.info),
      //     ),
      //     actions: [
      //       IconButton(
      //         onPressed: () {
      //           Get.changeThemeMode(AppPreferences.isModeDark
      //               ? ThemeMode.light
      //               : ThemeMode.dark);

      //           AppPreferences.isModeDark = !AppPreferences.isModeDark;
      //         },
      //         icon: const Icon(Icons.brightness_2_outlined),
      //       )
      //     ]
          
      //   //)
      
      //   ),
      bottomNavigationBar: LocationSelectionBottomNavigation(context),
      body: Column(
              mainAxisSize: MainAxisSize.max,

        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Obx(
            () => Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              CustomWidget(
                  titleText: homeControler.vpnInfo.value.countryLongName.isEmpty
                      ? "Location"
                      : homeControler.vpnInfo.value.countryLongName,
                  subtitleText: "Free",
                  roundWidgetWithIcon: CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.redAccent,
                    backgroundImage: homeControler
                            .vpnInfo.value.countryLongName.isEmpty
                        ? null
                        : AssetImage(
                            "countryFlags/${homeControler.vpnInfo.value.countryShortName.toLowerCase()}.png"),
                    child: homeControler.vpnInfo.value.countryLongName.isEmpty
                        ? const Icon(
                            Icons.flag_circle,
                            size: 30,
                            color: Colors.white,
                          )
                        : null,
                  )),
              // ignore: prefer_const_constructors
              CustomWidget(
                  titleText: 
                  // homeControler.vpnInfo.value.ping.isEmpty
                  //     ? "60 ms"
                  //     : 
                      "${homeControler.vpnInfo.value.ping} ms",
                  subtitleText: "ping",
                  roundWidgetWithIcon: const CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.black54,
                      child: Icon(
                        Icons.graphic_eq,
                        size: 30,
                        color: Colors.white,
                      ))),
            ]),
          ),
     
          StreamBuilder<VpnStatus?>(
              initialData: VpnStatus(),
              stream: VpnEngine.snapshotVpnStatus(),
              builder: (context, dataSnapshot) {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomWidget(
                          // ignore: unnecessary_string_interpolations
                          titleText: dataSnapshot.data?.byteIn ?? "0 kpbs",
                          subtitleText: "Download",
                          // ignore: prefer_const_constructors
                          roundWidgetWithIcon: CircleAvatar(
                              radius: 32,
                              backgroundColor: Colors.green,
                              // ignore: prefer_const_constructors
                              child: Icon(
                                Icons.arrow_circle_down,
                                size: 30,
                                color: Colors.white,
                              ))),
                      CustomWidget(
                          // ignore: unnecessary_string_interpolations
                          titleText:
                              // ignore: unnecessary_string_interpolations
                              "${dataSnapshot.data?.byteOut ?? '0 kbps'}",
                          subtitleText: "Upload",
                          // ignore: prefer_const_constructors
                          roundWidgetWithIcon: CircleAvatar(
                              radius: 32,
                              backgroundColor: Colors.purple,
                              // ignore: prefer_const_constructors
                              child: Icon(
                                Icons.arrow_circle_up,
                                size: 30,
                                color: Colors.white,
                              ))),
                    ]);
              }
              ),
                   Obx(() => vpnRoundButton()),
        ],
      ),
    );
  }
}
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;

  CustomAppBar({required this.title});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25.0), // Adjust the radius as needed
        bottomRight: Radius.circular(25.0), // Adjust the radius as needed
      ),
      child:   AppBar(
          title: const Text('Home Screen'),
          elevation: 8,
          shadowColor: Colors.black,
          backgroundColor:Colors.orangeAccent, //Theme.of(context).bottomNavigationColor,

          leading: IconButton(
            onPressed: () {
              Get.to(() => ConnectedNetworkIPScreen());
            },
            icon: const Icon( CupertinoIcons.info),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.changeThemeMode(AppPreferences.isModeDark
                    ? ThemeMode.light
                    : ThemeMode.dark);

                AppPreferences.isModeDark = !AppPreferences.isModeDark;
              },
              icon: const Icon(Icons.brightness_2_outlined),
            )
          ]
          
        //)
        ),
    );
  }
}