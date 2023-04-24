import 'package:we_chat_simple_app/data/vos/user_vo.dart';

import '../../../consts/strings.dart';
import 'firebase_firestore_abst.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFireStoreDataAgentImpl extends FirebaseFireStoreAbst {
  FirebaseFireStoreDataAgentImpl._();

  static final FirebaseFireStoreDataAgentImpl _singleton =
      FirebaseFireStoreDataAgentImpl._();

  factory FirebaseFireStoreDataAgentImpl() => _singleton;

  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  @override
  Future<void> createUser(UserVO userVO) {
    return _firebaseFireStore
        .collection(kRootNodeForUser)
        .doc(userVO.id.toString())
        .set(userVO.toJson());
  }

  @override
  Future<UserVO> getUserVO(String qrCode) {
    return _firebaseFireStore
        .collection(kRootNodeForUser)
        .doc(qrCode)
        .get()
        .asStream()
        .map((event) => UserVO.fromJson(event.data() ?? {}))
        .first;
  }

  @override
  Future<void> setContacts(String qrCode, UserVO userVO) {
    return _firebaseFireStore
        .collection(kRootNodeForUser)
        .doc(qrCode)
        .collection(kContactsPath)
        .doc(userVO.id)
        .set(userVO.toJson());
  }

  @override
  Stream<List<UserVO>> getContactsOfCurrentUser(String currentUserID) {
    return _firebaseFireStore
        .collection(kRootNodeForUser)
        .doc(currentUserID)
        .collection(kContactsPath)
        .snapshots()
        .map((querySnapShot) {
      return querySnapShot.docs.map((e) {
        return UserVO.fromJson(e.data());
      }).toList();
    });
  }
}
