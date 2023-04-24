import '../../../data/vos/user_vo.dart';

abstract class FirebaseFireStoreAbst {
  Future<void> createUser(UserVO userVO);

  Future<UserVO> getUserVO(String qrCode);

  Future<void> setContacts(String qrCode, UserVO userVO);

  Stream<List<UserVO>> getContactsOfCurrentUser(String currentUserID);
}
