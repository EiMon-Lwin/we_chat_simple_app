import 'dart:core';

import 'package:flutter/material.dart';
import 'package:we_chat_simple_app/data/apply/wechat_simple_apply_Impl.dart';
import 'package:we_chat_simple_app/data/vos/user_vo.dart';

import '../data/apply/wechat_simple_apply.dart';
import '../data/vos/message_vo.dart';

class ConversationPageBloc extends ChangeNotifier {
  ///variables
  bool _dispose = false;

  List<MessageVO> _messages = [];

  UserVO? currentUser;
  UserVO? friendVO;

  String friendID = '';
  String currentUserID = '';

  bool _sendMessage = false;

  String _message = '';
  final String _lastMessage = '';

  final TextEditingController _textEditingController = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  ///Getter
  bool get isDispose => _dispose;

  bool get getSendMessage => _sendMessage;

  String get getLastMessage => _lastMessage;

  TextEditingController get getMessageTextController => _textEditingController;

  FocusNode get getFocusNode => _focusNode;

  List<MessageVO> get getChattingMessages => _messages;

  ///Instance
  final WeChatSimpleApply _weChatSimpleApply = WeChatSimpleApplyImpl();

  ConversationPageBloc(friendID) {
    this.friendID = friendID;
    UserVO? authUser = _weChatSimpleApply.getUserInfoFromCurrentUser();
    currentUserID = authUser.id ?? '';
    _weChatSimpleApply
        .getUserVO(currentUserID)
        .then((value) => currentUser = value);

    _weChatSimpleApply.getUserVO(friendID).then((value) => friendVO = value);

    _weChatSimpleApply
        .getMessageWhileChatting(currentUserID, friendID)
        .listen((event) {
      _messages = event ?? [];
      notifyListeners();
    });
  }

  void sendMessageMethod() {
    MessageVO messageVO = MessageVO(
      _message,
      currentUserID,
      DateTime.now().microsecondsSinceEpoch.toString(),
      currentUser?.name,
      currentUser?.file,
    );

    _weChatSimpleApply.messaging(currentUserID, friendID, messageVO);
    _weChatSimpleApply.messaging(friendID, currentUserID, messageVO);

    _sendMessage = false;
    _textEditingController.clear();
    notifyListeners();
  }

  void checkMessage(String text) {
    if (text.isNotEmpty) {
      _sendMessage = true;
    } else {
      _sendMessage = false;
    }
    _message = text;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _dispose = true;
    _textEditingController.dispose();
    _focusNode.dispose();
  }

  @override
  void notifyListeners() {
    if (!_dispose) {
      super.notifyListeners();
    }
  }
}
