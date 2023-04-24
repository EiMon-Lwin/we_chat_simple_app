import 'package:we_chat_simple_app/data/vos/message_vo.dart';

import '../vos/user_vo.dart';

abstract class WeChatSimpleApply {
  Future registerNewUser(UserVO newUser);

  Future loginUser(String email, String password);

  UserVO getUserInfoFromCurrentUser();

  Future logOut();

  Future<UserVO?> getUserVO(String qrCode);

  Future<void> setContacts(String qrCode, UserVO userVO);

  Stream<List<UserVO>?> getContactsOfCurrentUser(String currentUserID);

  Stream<List<MessageVO>?> getMessageWhileChatting(
      String currentUserID, String chattingFriendID);

  Future<void> messaging(
      String currentUserID, String friendID, MessageVO messageVO);

  Stream<List<MessageVO>> getAllMessage(String currentUserId, String friendID);
}
