import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    // testDevices: testDevice != null ? <String>[testDevice] : null,
    keywords: <String>['technology', 'programming', 'startup', 'devnews'],
    childDirected: true,
    nonPersonalizedAds: false,
  );

  InterstitialAd _interstitialAd;

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: "ca-app-pub-",
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event $event");
      },
    );
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: "ca-app-pub");
    _interstitialAd = createInterstitialAd()..load();
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Theme.of(context).backgroundColor;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffea5e3d),
        elevation: 0,
        title: Text(
          "About",
          style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nexa',
                        color: Colors.white,
                      ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(16),
        color: backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Image(
                image: AssetImage("assets/app_icon.png"),
                height: 200,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Dev2 News is open source Flutter application that using dev.to api to fetch and display articles.",
              style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Nexa',
                        color: Color(0xffea5e3d),
                      ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Icon(Icons.verified_user, color: Color(0xffea5e3d)),
                  SizedBox(width: 8),
                  Text(
                    "Version 1.0",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Nexa',
                        color: Color(0xffea5e3d),
                      ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            RaisedButton(
              onPressed: () {
                launchUrl("https://github.com/matrixjnr/dev2");
              },
              padding: EdgeInsets.zero,
              color: backgroundColor,
              elevation: 0,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.code, color: Color(0xffea5e3d)),
                    SizedBox(width: 8),
                    Text(
                      "Open source 🚀",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Nexa',
                        color: Color(0xffea5e3d),
                      ),
                    )
                  ],
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {
                _interstitialAd?.show();
              },
              padding: EdgeInsets.zero,
              color: backgroundColor,
              elevation: 0,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.brightness_1, color: Color(0xffea5e3d)),
                    SizedBox(width: 8),
                    Text(
                      "Support me 🎗",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Nexa',
                        color: Color(0xffea5e3d),
                      ),
                    )
                  ],
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {
                launchUrl("https://dev.to/matrixjnr");
              },
              padding: EdgeInsets.zero,
              color: backgroundColor,
              elevation: 0,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.favorite, color: Color(0xffea5e3d),),
                    SizedBox(width: 8),
                    Text(
                      "Made with ❤️ by Matrixjnr",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Nexa',
                        color: Color(0xffea5e3d),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
