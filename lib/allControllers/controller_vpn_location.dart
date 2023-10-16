import 'package:digistacksvpn/allModels/vpn_info.dart';
import 'package:digistacksvpn/apiVpnGate/api_vpn_gate.dart';
import 'package:digistacksvpn/appPreferences/app_Preferences.dart';
import 'package:get/get.dart';

class ControllerVpnLocation extends GetxController {
  List<VpnInfo> vpnFreeServerList = AppPreferences.vpnList;
  final RxBool isLoadingNewLocations = false.obs;

  Future<void> retriveVpnInformation() async {
    isLoadingNewLocations.value = true;
    vpnFreeServerList.clear();

    vpnFreeServerList = await ApiVpnGate.retriveAllAvailableFreeVpnServers();
    isLoadingNewLocations.value = false;
  }
}
