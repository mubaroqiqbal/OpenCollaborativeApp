import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:github/github.dart';
import 'package:credibook_test_app/base_var/const_color.dart';
import 'package:credibook_test_app/data/model/open_collective_user.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:url_launcher/url_launcher.dart';

class Body extends StatefulWidget {

  final OpenCollectiveUser user;

  Body({Key key, this.user});

  @override
  _BodyState createState() => _BodyState(user: user);
}

class _BodyState extends State<Body> {
  GlobalKey previewContainer = new GlobalKey();

  final OpenCollectiveUser user;

  String now;
  int originalSize = 800;

  String imgBase64;

  Image _image2;

  _BodyState({Key key, this.user});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RepaintBoundary(
            key: previewContainer,
            child: Card(
              margin: EdgeInsets.all(5),
              child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 75,
                            width: 75,
                            child: CircleAvatar(
                              child: user.image!=null?
                              Image.network(user.image) :
                              Container(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(user.lastTransactionAmount!=null?user.lastTransactionAmount.toString()+" "+user.currency:"0", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                Text("Last Contribute"),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(user.totalAmountDonated!=null?user.totalAmountDonated.toString()+" "+user.currency:"0", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                Text("Contributed"),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      user.name!=null?
                      Row(
                        children: [
                          Expanded(
                            child: Text(user.name, style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                        ],
                      ) : Container(),
                      SizedBox(
                        height: 15,
                      ),
                      user.description!=null?
                      Row(
                        children: [
                          Expanded(
                            child: Text(user.description),
                          ),
                        ],
                      ) : Container(),
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (await canLaunch(user.profile)) {
                            await launch(user.profile);
                          } else {
                            throw 'Could not launch $user.profile';
                          }
                        },
                        child: Text("Visit profile".toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent),),
                      )
                    ],
                  )
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            height: 40,
            child: RaisedButton(
              color: buttonColor,
              onPressed: _shareImages,
              child: Text("Share via Whatsapp", style: TextStyle(color: Colors.white),),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _shareImages() async {
    try {
      RenderRepaintBoundary boundary = previewContainer.currentContext.findRenderObject();
      double pixelRatio = originalSize / MediaQuery.of(context).size.width;

      ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
      ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      setState(() {
        imgBase64= Base64Codec().encode(pngBytes);
      });

      FlutterShareMe().shareToWhatsApp(msg: "check this out", base64Image: "data:image/jpeg;base64," + imgBase64);
    } catch (e) {
      debugPrint('error: $e');
    }
  }

}