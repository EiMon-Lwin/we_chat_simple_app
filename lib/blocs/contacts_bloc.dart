import 'package:flutter/material.dart';

import '../data/apply/wechat_simple_apply.dart';
import '../data/apply/wechat_simple_apply_Impl.dart';
import '../data/vos/user_vo.dart';

class ContactsBloc extends ChangeNotifier {
  bool _dispose = false;

  ///State Variable
  List<UserVO> contactsList = [];
  UserVO? currentUser;

  ///State Instance

  final WeChatSimpleApply _weChatSimpleApply = WeChatSimpleApplyImpl();

  ContactsBloc() {
    currentUser = _weChatSimpleApply.getUserInfoFromCurrentUser();
    var currentUserID = currentUser?.id;

    _weChatSimpleApply.getContactsOfCurrentUser(currentUserID!).listen((event) {
      contactsList = event ?? [];
      notifyListeners();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _dispose = true;
  }

  @override
  void notifyListeners() {
    if (!_dispose) {
      super.notifyListeners();
    }
  }
}
