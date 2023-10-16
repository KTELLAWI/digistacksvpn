import 'package:flutter/material.dart';
import "/main.dart";

class CustomWidget extends StatelessWidget {
final String titleText;
final String subtitleText;
final Widget roundWidgetWithIcon;

  // ignore: prefer_const_constructors_in_immutables
  CustomWidget ({required this.titleText, required this.subtitleText , required this.roundWidgetWithIcon , super.key});



 
  @override
  Widget build(BuildContext context) {
    sizeScreen = MediaQuery.of(context).size;
    return 
    SizedBox
    (
        width:sizeScreen.width * .46,
        child:Column(
            children:[
                roundWidgetWithIcon,
                const SizedBox(
                    height:7,
                ),
                Text(
                    titleText,
                    style:const TextStyle(
                         fontSize:16,
                                            fontWeight:FontWeight.w600
                    )
                ),
                 const SizedBox(
                    height:7,
                ),
                   Text(
                    subtitleText,
                    style:const TextStyle(
                         fontSize:12,
                                            fontWeight:FontWeight.w600
                    ),
                ),
            ]
        ),

    );
  }
}
