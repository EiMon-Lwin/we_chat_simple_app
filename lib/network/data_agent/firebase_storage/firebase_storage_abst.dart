import 'dart:io';

abstract class FirebaseStorageAbst {
  Future<String> uploadToFirebaseStorage(File? file);
}
