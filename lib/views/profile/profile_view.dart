import 'dart:io';

import 'package:aimimi/models/user.dart';
import 'package:aimimi/services/auth_service.dart';
import 'package:aimimi/constants/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final user = FirebaseAuth.instance.currentUser;
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<UserGoal> goals = Provider.of<List<UserGoal>>(context);
    List<String> completedGoals = Provider.of<List<String>>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: themeColor,
                  maxRadius: 40,
                  backgroundImage: getBackground(),
                  child: MaterialButton(
                    onPressed: () {
                      getImage();
                      uploadImageToFirebase(context);
                    },
                    child: getText(),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 0, left: 30, right: 0, bottom: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        " " + user.displayName,
                        style: TextStyle(
                          color: monoPrimaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        padding: EdgeInsets.only(
                            top: 10, left: 10, right: 10, bottom: 10),
                        decoration: BoxDecoration(
                          color: backgroundTintedColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Goals  ' + goals.length.toString(),
                          style: TextStyle(
                            color: monoSecondaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.42,
                height: MediaQuery.of(context).size.width * 0.42,
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFEDF7FA),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.42 * 0.3,
                      height: MediaQuery.of(context).size.width * 0.42 * 0.3,
                      decoration: BoxDecoration(
                        color: Color(0xFFA3D2E6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.solidCheckCircle,
                        color: Colors.white,
                        size: 33,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      goals.length.toString(),
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'Ongoing',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: monoSecondaryColor,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.055),
              Container(
                width: MediaQuery.of(context).size.width * 0.42,
                height: MediaQuery.of(context).size.width * 0.42,
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFFCEEE6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.42 * 0.3,
                      height: MediaQuery.of(context).size.width * 0.42 * 0.3,
                      decoration: BoxDecoration(
                        color: Color(0xFFE87E45),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.walking,
                        color: Colors.white,
                        size: 33,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      completedGoals.length.toString(),
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'Completed',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: monoSecondaryColor,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 70),
          SizedBox(
            width: 100,
            child: TextButton(
                onPressed: () async {
                  print(_image);
                  await AuthService().logout();
                },
                style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all<Color>(Colors.transparent),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: monoSecondaryColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Logout",
                      style: TextStyle(
                        color: Color(0xff999999),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  NetworkImage getBackground() {
    if (user.providerData[0].providerId == 'google.com') {
      return NetworkImage(user.photoURL);
    } else {
      return null;
    }
  }

  Text getText() {
    if (user.providerData[0].providerId == 'google.com') {
      return Text('');
    } else {
      return Text(
        user.displayName[0].toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.w700,
        ),
      );
    }
  }

  Future uploadImageToFirebase(BuildContext context) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    String uid = user.uid;
    String fileurl;
    Reference ref = storage.ref().child('uid/DateTime.now().toString()');
    print(_image);
    UploadTask uploadTask = ref.putFile(_image);
    uploadTask.then((res) {
      res.ref.getDownloadURL();
    });
  }
}
