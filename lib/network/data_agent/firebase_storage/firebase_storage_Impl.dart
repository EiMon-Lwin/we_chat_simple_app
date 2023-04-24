import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:we_chat_simple_app/network/data_agent/firebase_storage/firebase_storage_abst.dart';

import '../../../consts/strings.dart';

class FirebaseStorageImpl extends FirebaseStorageAbst {
  FirebaseStorageImpl._();

  static final FirebaseStorageImpl _singleton = FirebaseStorageImpl._();

  factory FirebaseStorageImpl() => _singleton;

  final _firebaseStorage = FirebaseStorage.instance;

  @override
  Future<String> uploadToFirebaseStorage(File? file) {
    return _firebaseStorage
        .ref(kImagesPath)
        .child(DateTime.now().toString())
        .putFile(file!)
        .then((takeSnapShot) => takeSnapShot.ref.getDownloadURL());
  }
}
