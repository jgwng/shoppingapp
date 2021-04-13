import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:io';

import 'package:shoppingapp/models/review.dart';

class StorageRepository {
  final Reader read;

  StorageRepository({this.read});

  Future<void> uploadPicture(Review review) async{
    for(int i=0;i<review.attachedImage.length;i++){
      String fileName = review.attachedImage[i].split("/").last;
      Reference ref = FirebaseStorage.instance.ref().child('review/${review.createdAt}').child(fileName);
      UploadTask uploadTask = ref.putFile(File(review.attachedImage[i]));
      await uploadTask.whenComplete(() => null);
      await  ref.getDownloadURL();
    }
  }
}