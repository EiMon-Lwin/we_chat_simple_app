import 'package:we_chat_simple_app/data/apply/wechat_simple_apply.dart';
import 'package:we_chat_simple_app/data/vos/message_vo.dart';
import 'package:we_chat_simple_app/data/vos/user_vo.dart';
import 'package:we_chat_simple_app/network/data_agent/firebase_auth/firebase_auth_impl.dart';

import '../../network/data_agent/firebase_auth/firebase_auth_abst.dart';
import '../../network/data_agent/firebase_firestore/firebase_firestore_abst.dart';
import '../../network/data_agent/firebase_firestore/firebase_firestore_impl.dart';
import '../../network/firebase_realtime/firebase_realtime_Impl.dart';
import '../../network/firebase_realtime/firebase_realtime_abst.dart';

class WeChatSimpleApplyImpl extends WeChatSimpleApply {
  WeChatSimpleApplyImpl._();

  static final WeChatSimpleApplyImpl _singleton = WeChatSimpleApplyImpl._();

  factory WeChatSimpleApplyImpl() => _singleton;

  final FirebaseAuthAbst _authAbst = FirebaseAuthImpl();
  final FirebaseFireStoreAbst _firebaseFireStore =
      FirebaseFireStoreDataAgentImpl();
  final FirebaseRealTimeAbst _firebaseRealTime = FirebaseRealtimeImpl();

  @override
  Future registerNewUser(UserVO newUser) {
    return _authAbst.registerNewUser(newUser);
  }

  @override
  Future loginUser(String email, String password) {
    return _authAbst.login(email, password);
  }

  @override
  UserVO getUserInfoFromCurrentUser() {
    return _authAbst.getLoggedInUserInfo();
  }

  @override
  Future logOut() {
    return _authAbst.logout();
  }

  @override
  Future<UserVO?> getUserVO(String qrCode) {
    return _firebaseFireStore.getUserVO(qrCode);
  }

  @override
  Future<void> setContacts(String qrCode, UserVO userVO) {
    return _firebaseFireStore.setContacts(qrCode, userVO);
  }

  @override
  Stream<List<UserVO>?> getContactsOfCurrentUser(String currentUserID) {
    return _firebaseFireStore.getContactsOfCurrentUser(currentUserID);
  }

  @override
  Stream<List<MessageVO>?> getMessageWhileChatting(
      String currentUserID, String chattingFriendID) {
    return _firebaseRealTime.getMessageWhileChatting(
        currentUserID, chattingFriendID);
  }

  @override
  Future<void> messaging(
      String currentUserID, String friendID, MessageVO messageVO) {
    return _firebaseRealTime.messaging(currentUserID, friendID, messageVO);
  }

  @override
  Stream<List<MessageVO>> getAllMessage(String currentUserId, String friendID) {
    return _firebaseRealTime.getAllMessage(currentUserId, friendID);
  }
}
