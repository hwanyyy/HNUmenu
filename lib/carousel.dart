import 'package:flutter/material.dart';
import 'package:myapp/data.dart';
import 'data.dart';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

class Carousel extends StatefulWidget {
  Carousel({Key key, @required this.data, @required this.loading})
      : super(key: key);

  final List<Menu> data;
  final bool loading;

  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  PageController controller = PageController(initialPage: 0, viewportFraction: 0.80);
  // 오후 9시 ~ 0시 , 0시 ~ 9시 전까지 아침 화면 노출
  dynamic page = 0.0;

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token){
      print('token:'+token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true)
    );
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings)
    {
      print("Settings registered: $settings");
    });
  }

  @override
  void initState() {
    super.initState();
    firebaseCloudMessaging_Listeners();

    if(9 <= DateTime.parse(DateTime.now().toString()).hour && DateTime.parse(DateTime.now().toString()).hour <= 12){  // 오전 9시 ~ 오후 3시 전까지 점심 화면 출력
      controller = PageController(initialPage: 1, viewportFraction: 0.80);
      page = 1.0;
    }else if(12 < DateTime.parse(DateTime.now().toString()).hour && DateTime.parse(DateTime.now().toString()).hour <= 20){   // 오후 12시 ~ 오후 9시 전까지 저녁 화면 노출
      controller = PageController(initialPage: 2, viewportFraction: 0.80);
      page = 2.0;
    }

    controller.addListener(() {
      setState(() {
        page = controller.page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      height: MediaQuery.of(context).size.height / 1.7,
      child: !widget.loading
          ? PageView(
          scrollDirection: Axis.horizontal,
          controller: controller,
          children: widget.data
              .asMap()
              .map((index, menu) => MapEntry(
              index,
              CarouselCard(
                  hacSick: menu,
                  opacity: (1 - (((page - index).abs()).clamp(0.0, 0.5))),
                  scale: (1 - (((page - index).abs() * 0.1).clamp(0.0, 1.0))),
              )))
              .values
              .toList())
          : Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[CircularProgressIndicator()],
      ),
    );
  }
}

class CarouselCard extends StatelessWidget {
  CarouselCard({@required this.hacSick, @required this.scale, @required this.opacity});

  final Menu hacSick;
  final double scale;
  final double opacity;
  final String menu = 'menu';

  @override
  Widget build(BuildContext context) {

    if (hacSick.id["id"] == "breakfast"){
      hacSick.id["id"] = "  조식";
    }else if(hacSick.id["id"] == "lunch"){
      hacSick.id["id"] = "  중식";
    }else if(hacSick.id["id"] == "dinner"){
      hacSick.id["id"] = "  석식";
    }

    return GestureDetector(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
            child: Opacity(
              opacity: opacity,
              child: Text(
                hacSick.id["id"],
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
            ),
          ),
            Expanded(
              child: Transform.scale(
                scale: scale-0.055,
                child: Hero(
                  tag: menu,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(10.0, 10.0), blurRadius: 5.0, spreadRadius: 0.0)],
                          image: DecorationImage(
                            image: AssetImage('assets/image/back.jpg'),
                            fit: BoxFit.fitHeight,
                        )
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(hacSick.id["title"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                            SizedBox(height: 15),
                            Text(hacSick.id["menu1"], style: TextStyle(fontSize: 20)),
                            SizedBox(height: 3),
                            Text(hacSick.id["menu2"], style: TextStyle(fontSize: 20)),
                            SizedBox(height: 3),
                            Text(hacSick.id["menu3"], style: TextStyle(fontSize: 20)),
                            SizedBox(height: 3),
                            Text(hacSick.id["menu4"], style: TextStyle(fontSize: 20)),
                            SizedBox(height: 3),
                            Text(hacSick.id["menu5"], style: TextStyle(fontSize: 20)),
                            SizedBox(height: 3),
                            Text(hacSick.id["menu6"], style: TextStyle(fontSize: 20)),
                            SizedBox(height: 30),
                            Text(hacSick.id["title2"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                            SizedBox(height: 15),
                            Text(hacSick.id["menu7"], style: TextStyle(fontSize: 20)),
                            SizedBox(height: 3),
                            Text(hacSick.id["menu8"], style: TextStyle(fontSize: 20)),
                            SizedBox(height: 3),
                            Text(hacSick.id["menu9"], style: TextStyle(fontSize: 20)),
                            SizedBox(height: 3),
                            Text(hacSick.id["menu10"], style: TextStyle(fontSize: 20)),
                            SizedBox(height: 3),
                            Text(hacSick.id["menu11"], style: TextStyle(fontSize: 20)),
                            SizedBox(height: 3),
                            Text(hacSick.id["menu12"], style: TextStyle(fontSize: 20)),
                          ],
                        ),
                      )
                    ),
                ),
              ),
            ),
          ]),
    );
  }

}