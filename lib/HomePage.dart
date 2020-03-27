import 'package:flutter/material.dart';
import 'package:myapp/data.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'date.dart';

final String appId_ios = "ca-app-pub-2085949826800661~1452923873";
final String appId_android = "ca-app-pub-2085949826800661~4721799638";
final String appUnit_ios = "ca-app-pub-2085949826800661/9239914552";
final String appUnit_android = "ca-app-pub-2085949826800661/1592239260";

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    String adUnit = appUnit_android; //default

    if (Platform.isAndroid){
      FirebaseAdMob.instance.initialize(appId: appId_android);
      adUnit = appUnit_android;
    }else {
      FirebaseAdMob.instance.initialize(appId: appId_android);
      adUnit = appUnit_ios;
    }

    MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['food', 'lunch', 'dinner'],
      testDevices: <String>[],
    );

    BannerAd myBanner = BannerAd(
        adUnitId: adUnit,
        size: AdSize.smartBanner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd event is $event");
        }
    );
    myBanner
    // typically this happens well before the ad is shown
      ..load()
      ..show(
        // Positions the banner ad 60 pixels from the bottom of the screen
        //anchorOffset: 60.0,
        // Positions the banner ad 10 pixels from the center of the screen to the right
        //horizontalCenterOffset: 10.0,
        // Banner Position
        anchorType: AnchorType.bottom,
      );

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          brightness: Brightness.light,
          title: Padding(
            padding: EdgeInsets.only(bottom: 15, top: 5),
            child: Center(
              child: Text(
                  'Weekly Menu',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Dellana',
                      color: Colors.black)
                  ),
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
          padding: EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Date(
                mon: mon(),
                tue: tue(),
                wed: wed(),
                thu: thu(),
                fri: fri(),
              ),
            ],
          ),
        ),
      );
  }
}