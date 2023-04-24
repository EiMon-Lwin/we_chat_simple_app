import 'package:we_chat_simple_app/data/vos/user_vo.dart';
import 'package:we_chat_simple_app/network/data_agent/firebase_firestore/firebase_firestore_impl.dart';

import 'firebase_auth_abst.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../firebase_firestore/firebase_firestore_abst.dart';

class FirebaseAuthImpl extends FirebaseAuthAbst {
  FirebaseAuthImpl._();

  static final FirebaseAuthImpl _singleton = FirebaseAuthImpl._();

  factory FirebaseAuthImpl() => _singleton;

  var auth = FirebaseAuth.instance;
  final FirebaseFireStoreAbst _fireStoreDataAgentImpl =
      FirebaseFireStoreDataAgentImpl();

  @override
  UserVO getLoggedInUserInfo() {
    return UserVO(
        auth.currentUser?.uid,
        auth.currentUser?.displayName,
        auth.currentUser?.email,
        auth.currentUser?.phoneNumber,
        '',
        '',
        auth.currentUser?.photoURL);
  }

  @override
  bool isLoggedIn() {
    // TODO: implement isLoggedIn
    throw UnimplementedError();
  }

  @override
  Future login(String email, String password) {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future logout() {
    return auth.signOut();
  }

  @override
  Future registerNewUser(UserVO newUser) {
    return auth
        .createUserWithEmailAndPassword(
            email: newUser.email ?? '', password: newUser.password ?? '')
        .then((userCredential) {
      User? user = userCredential.user;
      if (user != null) {
        user.updateDisplayName(newUser.name).then((value) {
          final User? user = auth.currentUser;
          newUser.id = user?.uid;
          _fireStoreDataAgentImpl.createUser(newUser);
        });
      }
    });
  }
}
