import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  String type, name;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      imageFile = File(pickedFile.path);
    });

  }
  bool _loadingScreen = false;
 Future<void> uploadData() async{
   if(imageFile != null){
     setState(() {
       _loadingScreen = true;
     });
     StorageReference firebaseRef = FirebaseStorage.instance
         .ref()
         .child('Images')
         .child('${randomAlphaNumeric(9)}.jpg');
     final StorageUploadTask task = firebaseRef.putFile(imageFile);
     var downloadUrl = await (await task.onComplete).ref.getDownloadURL();
     Map<String,String> mapVar = {
       'type':type,
       'name':name,
       'url':downloadUrl,
     };
     CrudeMethods crudeObj = CrudeMethods();
     crudeObj.uploadData(mapVar).then((result){
       print('done');
      alert(context);
      setState(() {
        type='';
        name='';
      });
     });
   }
 }
  alert(BuildContext context)
{
  return Alert(context: context, title: "Successful", desc: "Image uploaded Successfully").show();
}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              onPressed: (){
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
