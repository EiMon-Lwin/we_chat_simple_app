import 'package:flutter/cupertino.dart';
import 'package:we_chat_simple_app/data/vos/user_vo.dart';

import '../data/apply/wechat_simple_apply.dart';
import '../data/apply/wechat_simple_apply_Impl.dart';

class WeChatHomePageBloc extends ChangeNotifier {
  bool _isDispose = false;

  UserVO? currentUser;

  List<String> friendsUserID = [];
  final List<UserVO> _friends = [];

  String _lastMessage = '';

  ///Instance
  final WeChatSimpleApply _weChatSimpleApply = WeChatSimpleApplyImpl();

  ///Getter
  String get getLastMessage => _lastMessage;

  List<UserVO> get getAllFriends => _friends;

  WeChatHomePageBloc() {
    currentUser = _weChatSimpleApply.getUserInfoFromCurrentUser();
    String currentUserID = currentUser?.id ?? '';

    _weChatSimpleApply.getContactsOfCurrentUser(currentUserID).listen((event) {
      var temp = event ?? [];
      for (var friendVO in temp) {
        _friends.add(friendVO);
        notifyListeners();
      }
      for (var friend in _friends) {
        _weChatSimpleApply
            .getAllMessage(currentUserID, friend.id ?? '')
            .listen((event) {
          _lastMessage = event.last.message ?? '';
          notifyListeners();
        });
      }
    });
  }

  @override
  void notifyListeners() {
    if (!_isDispose) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _isDispose = true;
  }
}
