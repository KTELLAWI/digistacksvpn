import 'dart:convert';

import 'package:digistacksvpn/allModels/vpn_configuration.dart';
import 'package:digistacksvpn/allModels/vpn_status.dart';
import 'package:flutter/services.dart';

class VpnEngine {
  //native channe;
  static final String eventChanelVpnStage = "vpnState";
  static final String eventChanelVpnStatus = "vpnStatus";
  static final String methodChanelVpnControl = "vpnControl";

  ///Vpn Connection stage sanpshot
  static Stream<String> vpnStageSnapshot() =>
      EventChannel(eventChanelVpnStage).receiveBroadcastStream().cast();

  ///Vpn Connection status sanpshot
  static Stream<VpnStatus?> snapshotVpnStatus() =>
      EventChannel(eventChanelVpnStatus)
          .receiveBroadcastStream()
          .map((eventStatus) => vpnStatusFromJson(jsonDecode(eventStatus)));

  static Future<void> startVpnNow(VpnConfiguration vpnConfiguration) async {
    return MethodChannel(methodChanelVpnControl).invokeMethod("start", {
      "config": vpnConfiguration.config,
      "country": vpnConfiguration.counrtyName,
      "username": vpnConfiguration.username,
      "password": vpnConfiguration.password,
    });
  }

  static Future<void> stopVpnNow()  {
    return MethodChannel(methodChanelVpnControl).invokeMethod("start");
  }

  static Future<void> killSwitchOptionNow()  {
    return MethodChannel(methodChanelVpnControl).invokeMethod("kill_switch");
  }

  static Future<void> refereshStageNow()  {
    return MethodChannel(methodChanelVpnControl).invokeMethod("refresh");
  }

  static Future<String?> getstageNow()  {
    return MethodChannel(methodChanelVpnControl).invokeMethod("stage");
  }

   static Future<bool> isConnectedNow()async{
   return  getstageNow().then((valueStage)=>valueStage!.toLowerCase()== "connected");
   }


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
