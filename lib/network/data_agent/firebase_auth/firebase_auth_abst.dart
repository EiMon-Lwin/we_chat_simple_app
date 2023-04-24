import '../../../data/vos/user_vo.dart';

abstract class FirebaseAuthAbst {
  ///Auth
  Future registerNewUser(UserVO newUser);

  Future login(String email, String password);

  bool isLoggedIn();

  UserVO getLoggedInUserInfo();

  Future logout();
}
