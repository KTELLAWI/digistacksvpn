import 'package:digistacksvpn/allModels/network_ip_info.dart';
import 'package:digistacksvpn/main.dart';
import 'package:flutter/material.dart';

class NetworkIpInfoWidget extends StatelessWidget {
  final NetworkIpInfo networkIPInfo;
  const NetworkIpInfoWidget({required this.networkIPInfo, super.key});

  @override
  Widget build(BuildContext context) {
    sizeScreen = MediaQuery.of(context).size;

    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: sizeScreen.height * .01),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: Icon(networkIPInfo.iconData.icon,size: networkIPInfo.iconData.size ?? 28,),
        title: Text(networkIPInfo.titleText),
        subtitle: Text(networkIPInfo.subTitleText),
      
      
      ),

    );
  }
}
