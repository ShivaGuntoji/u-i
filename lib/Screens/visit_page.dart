import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helping_hands/Screens/Welcome/welcome_screen.dart';
import 'package:helping_hands/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:helping_hands/crude.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class VisitPage extends StatefulWidget {
  @override
  _VisitPageState createState() => _VisitPageState();
}

class _VisitPageState extends State<VisitPage> {
  File imageFile;
  String number;
  String type, name;
  var user = "";
  final picker = ImagePicker();
  final auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      imageFile = File(pickedFile.path);
    });
  }

  bool _loadingScreen = false;
  Future<void> uploadData() async {
    if (imageFile != null) {
      setState(() {
        _loadingScreen = true;
      });
      StorageReference firebaseRef = FirebaseStorage.instance
          .ref()
          .child('Images')
          .child('${randomAlphaNumeric(9)}.jpg');
      final StorageUploadTask task = firebaseRef.putFile(imageFile);
      var downloadUrl = await (await task.onComplete).ref.getDownloadURL();
      await setUserName();
//     var queryRes =[];
//     CrudeMethods objCrude = CrudeMethods();
//     await objCrude.getPhoneNumber(user).then((QuerySnapshot docs){
//       for(int i =0 ; i <docs.documents.length;++i)
//         {
//            queryRes.add(docs.documents[i].data);
//         }
//     },);
//     var number,userDonor;
//     queryRes.forEach((element) {
//       setState(() {
//         number=element['mobile'];
//         userDonor=element['name'];
//       });
//     },);
//     print('here user $userDonor and $num()');
      await getDet();
      CrudeMethods crudeObj = CrudeMethods();
       QuerySnapshot numberData = crudeObj.getPhoneNumber(user);
      setState(() {
        number= numberData.documents[0].data['mobile'];
      });
      Map<String, String> mapVar = {
        'type': type,
        'name': name,
        'url': downloadUrl,
        'user': user,
        'searchIndex': type[0].toLowerCase(),
        'number':number,
      };
      crudeObj.uploadData(mapVar).then((result) {
        print('done');
        print('user is $user');
        alert(context);
        setState(() {
          type = '';
          name = '';
        });
      });
    }
  }

  getDet() async {
    var user = await FirebaseAuth.instance.currentUser();
    var userQuery = Firestore.instance
        .collection('donation')
        .where('email', isEqualTo: user)
        .limit(1);
    userQuery.getDocuments().then((data) {
      if (data.documents.length > 0) {
        print('here the document is ${data.documents[0]}');
        setState(() {
          number = data.documents[0].data['mobile'];
        });
      }
      else{
        print('\n\n\n not found');
      }
    });

    print('here number $number');
  }

  alert(BuildContext context) {
    return Alert(
            context: context,
            title: "Successful",
            desc: "Image uploaded Successfully")
        .show();
  }

  void setUserName() async {
    try {
      FirebaseUser user1 = await auth.currentUser();
      if (user1 != null) {
        loggedInUser = user1;
        setState(() {
          user = loggedInUser.email.toString();
        });
        print(user);
        print('the above is user name');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: FlatButton(
              child: Icon(Icons.arrow_back),
              onPressed: () {
                auth.signOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => WelcomeScreen()));
              },
            ),
          ),
          resizeToAvoidBottomPadding: false,
          body: SingleChildScrollView(
            child: Container(
              // margin: EdgeInsets.only(top:10),
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: imageFile != null
                        ? Container(
                            margin: EdgeInsets.all(14),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                child: Image.file(
                                  imageFile,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        : Container(
                            width: double.infinity,
                            margin: EdgeInsets.all(14),
                            height: MediaQuery.of(context).size.height * 0.35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kPrimaryLightColor,
                            ),
                            child: Icon(
                              Icons.add_a_photo,
                              size: 28,
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: new BorderSide(
                                  color: Colors.black, width: 20)),
                          labelText: 'Product Type',
                          labelStyle: TextStyle(fontSize: 20)),
                      onChanged: (value) {
                        setState(() {
                          type = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: new BorderSide(
                                  color: Colors.black, width: 20)),
                          labelText: 'Name',
                          labelStyle: TextStyle(fontSize: 20)),
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: Container(
            margin: EdgeInsets.only(bottom: 30),
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton(
              onPressed: () {
                uploadData();
              },
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Icon(Icons.add),
              ),
            ),
          )),
    );
  }
}
