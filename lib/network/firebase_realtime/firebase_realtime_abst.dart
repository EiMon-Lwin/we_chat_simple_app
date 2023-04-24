import 'package:we_chat_simple_app/data/vos/message_vo.dart';

abstract class FirebaseRealTimeAbst{

  Stream<List<MessageVO>?> getMessageWhileChatting(String currentUserID,String chattingFriendID);

  Future<void> messaging(String currentUserID,String friendUserID,MessageVO messageVO);

  Stream<List<MessageVO>> getAllMessage(String currentUserId,String friendID);


}