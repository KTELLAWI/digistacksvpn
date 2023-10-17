// import 'dart:convert';

// import 'package:digistacksvpn/allModels/vpn_configuration.dart';
// import 'package:digistacksvpn/allModels/vpn_status.dart';
// import 'package:flutter/services.dart';

// class VpnEngine {
//   //native channe;
//   static final String eventChanelVpnStage = "vpnState";
//   static final String eventChanelVpnStatus = "vpnStatus";
//   static final String methodChanelVpnControl = "vpnControl";

//   ///Vpn Connection stage sanpshot
//   static Stream<String> vpnStageSnapshot() =>
//       EventChannel(eventChanelVpnStage).receiveBroadcastStream().cast();

//   ///Vpn Connection status sanpshot
//   static Stream<VpnStatus?> snapshotVpnStatus() =>
//       EventChannel(eventChanelVpnStatus)
//           .receiveBroadcastStream()
//           .map((eventStatus) => vpnStatusFromJson(jsonDecode(eventStatus)));

//   static Future<void> startVpnNow(VpnConfiguration vpnConfiguration) async {
//     return MethodChannel(methodChanelVpnControl).invokeMethod("start", {
//       "config": vpnConfiguration.config,
//       "country": vpnConfiguration.counrtyName,
//       "username": vpnConfiguration.username,
//       "password": vpnConfiguration.password,
//     });
//   }

//   static Future<void> stopVpnNow()  {
//     return MethodChannel(methodChanelVpnControl).invokeMethod("start");
//   }

//   static Future<void> killSwitchOptionNow()  {
//     return MethodChannel(methodChanelVpnControl).invokeMethod("kill_switch");
//   }

//   static Future<void> refereshStageNow()  {
//     return MethodChannel(methodChanelVpnControl).invokeMethod("refresh");
//   }

//   static Future<String?> getstageNow()  {
//     return MethodChannel(methodChanelVpnControl).invokeMethod("stage");
//   }

//    static Future<bool> isConnectedNow()async{
//    return  getstageNow().then((valueStage)=>valueStage!.toLowerCase()== "connected");
//    }


//  ///All Stages of connection
//   static const String vpnConnected = "connected";
//   static const String vpnDisconnected = "disconnected";
//   static const String vpnWaitConnection = "wait_connection";
//   static const String vpnAuthenticating = "authenticating";
//   static const String vpnReconnect = "reconnect";
//   static const String vpnNoConnection = "no_connection";
//   static const String vpnConnecting = "connecting";
//   static const String vpnPrepare = "prepare";
//   static const String vpnDenied = "denied";




// }


import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:digistacksvpn/allModels/vpn_status.dart';
import 'package:digistacksvpn/allModels/vpn_config.dart';

class VpnEngine {
  ///Channel to native
  static final String _eventChannelVpnStage = "vpnStage";
  static final String _eventChannelVpnStatus = "vpnStatus";
  static final String _methodChannelVpnControl = "vpnControl";

  ///Snapshot of VPN Connection Stage
  static Stream<String> vpnStageSnapshot() =>
      EventChannel(_eventChannelVpnStage).receiveBroadcastStream().cast();

  ///Snapshot of VPN Connection Status
  static Stream<VpnStatus?> vpnStatusSnapshot() =>
      EventChannel(_eventChannelVpnStatus)
          .receiveBroadcastStream()
          .map((event) => VpnStatus.fromJson(jsonDecode(event)))
          .cast();

  ///Start VPN easily
  static Future<void> startVpn(VpnConfig vpnConfig) async {
    // log(vpnConfig.config);
    return MethodChannel(_methodChannelVpnControl).invokeMethod(
      "start",
      {
        "config": vpnConfig.config,
        "country": vpnConfig.country,
        "username": vpnConfig.username,
        "password": vpnConfig.password,
      },
    );
  }

  ///Stop vpn
  static Future<void> stopVpn() =>
      MethodChannel(_methodChannelVpnControl).invokeMethod("stop");

  ///Open VPN Settings
  static Future<void> openKillSwitch() =>
      MethodChannel(_methodChannelVpnControl).invokeMethod("kill_switch");

  ///Trigger native to get stage connection
  static Future<void> refreshStage() =>
      MethodChannel(_methodChannelVpnControl).invokeMethod("refresh");

  ///Get latest stage
  static Future<String?> stage() =>
      MethodChannel(_methodChannelVpnControl).invokeMethod("stage");

  ///Check if vpn is connected
  static Future<bool> isConnected() =>
      stage().then((value) => value?.toLowerCase() == "connected");

  ///All Stages of connection
  static const String vpnConnected = "connected";
  static const String vpnDisconnected = "disconnected";
  static const String vpnWaitConnection = "wait_connection";
  static const String vpnAuthenticating = "authenticating";
  static const String vpnReconnect = "reconnect";
  static const String vpnNoConnection = "no_connection";
  static const String vpnConnecting = "connecting";
  static const String vpnPrepare = "prepare";
  static const String vpnDenied = "denied";
}