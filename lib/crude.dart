import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';

class CrudeMethods {
  Future uploadData(mapData)async {
    await Firestore.instance.collection('donor').add(mapData).catchError((e){
      print(e);
    });
  }
  Future getData() async
  {
    return await Firestore.instance.collection("donor").snapshots();
  }
  getPhoneNumber(String searchField) async {
    searchField = searchField.trim();
    return await Firestore.instance.collection(
        "donation").where('email', isEqualTo: searchField).getDocuments();
  }
}
