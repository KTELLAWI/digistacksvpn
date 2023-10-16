import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import  "package:digistacksvpn/allModels/vpn_info.dart";
class AppPreferences{

    static late Box boxOfData;

    
    static Future<void> initHive() async{
        await Hive.initFlutter();

        boxOfData = await Hive.openBox("data");


    }

    static bool get isModeDark => boxOfData.get("isDarkMode") ?? false;
    static set isModeDark(bool value)=> boxOfData.put("isDarkMode",value);

    //for saving single selected vpn details

    static VpnInfo get vpnInfoObj => VpnInfo.fromJson(jsonDecode(boxOfData.get('vpn') ?? '{}'));
    static set vpnInfoObj(VpnInfo value) => boxOfData.put('vpn',jsonEncode(value));

// for saving all VPN servers details 

static List<VpnInfo> get vpnList {

    List<VpnInfo>  tempVpnList = [];
    final datavpn = jsonDecode(boxOfData.get("vpnList") ?? "[]");

    for ( var data in datavpn)  {
        tempVpnList.add(VpnInfo.fromJson(data));
    }

    return tempVpnList;
    }


static set vpnList (List<VpnInfo> valuList) => boxOfData.put("vpnList",jsonEncode(valuList));

}