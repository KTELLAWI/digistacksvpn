// // To parse this JSON data, do
// //
// //     final vpnStatus = vpnStatusFromJson(jsonString);

// import 'dart:convert';

// VpnStatus vpnStatusFromJson(String str) => VpnStatus.fromJson(json.decode(str));

// String vpnStatusToJson(VpnStatus data) => json.encode(data.toJson());

// class VpnStatus {
//     String? byteIn;
//     String? byteOut;
//     String? durationTime;
//     String? lastPacketReceive;

//     VpnStatus({
//          this.byteIn,
//          this.byteOut,
//          this.durationTime,
//          this.lastPacketReceive,
//     });

//     factory VpnStatus.fromJson(Map<String, dynamic> json) => VpnStatus(
//         byteIn: json["byte_in"],
//         byteOut: json["byte_out"],
//         durationTime: json["duration"],
//         lastPacketReceive: json["last_packet_receive"],
//     );

//     Map<String, dynamic> toJson() => {
//         "byte_in": byteIn,
//         "byte_out": byteOut,
//         "duration": durationTime,
//         "last_packet_receive": lastPacketReceive,
//     };
// }
class VpnStatus {
  VpnStatus({this.duration, this.lastPacketReceive, this.byteIn, this.byteOut});

  String? duration;
  String? lastPacketReceive;
  String? byteIn;
  String? byteOut;

  factory VpnStatus.fromJson(Map<String, dynamic> json) => VpnStatus(
        duration: json['duration'],
        lastPacketReceive: json['last_packet_receive'],
        byteIn: json['byte_in'],
        byteOut: json['byte_out'],
      );

  Map<String, dynamic> toJson() => {
        'duration': duration,
        'last_packet_receive': lastPacketReceive,
        'byte_in': byteIn,
        'byte_out': byteOut
      };
}