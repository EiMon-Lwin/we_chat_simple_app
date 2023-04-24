import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:we_chat_simple_app/data/vos/message_vo.dart';
import 'package:we_chat_simple_app/network/firebase_realtime/firebase_realtime_abst.dart';

import '../../consts/strings.dart';

class FirebaseRealtimeImpl extends FirebaseRealTimeAbst {
  FirebaseRealtimeImpl._();

  static final FirebaseRealtimeImpl _singleton = FirebaseRealtimeImpl._();

  factory FirebaseRealtimeImpl() => _singleton;

  final _firebaseRealtime = FirebaseDatabase.instance.ref();

  @override
  Stream<List<MessageVO>?> getMessageWhileChatting(
      String currentUserID, String chattingFriendID) {
    return _firebaseRealtime
        .child(kMessageRootNode)
        .child(currentUserID)
        .child(chattingFriendID)
        .onValue
        .map((event) {
      return event.snapshot.children.map((e) {
        return MessageVO.fromJson(Map<String, dynamic>.from(e.value as Map));
      }).toList();
    });
  }

  @override
  Future<void> messaging(
      String currentUserID, String friendUserID, MessageVO messageVO) {
    return _firebaseRealtime
        .child(kMessageRootNode)
        .child(currentUserID)
        .child(friendUserID)
        .child(messageVO.id.toString())
        .set(messageVO.toJson());
  }

  @override
  Stream<List<MessageVO>> getAllMessage(String currentUserId, String friendID) {
    return _firebaseRealtime
        .child(kMessageRootNode)
        .child(currentUserId)
        .child(friendID)
        .onValue
        .map((event) {
      return event.snapshot.children.map((e) {
        return MessageVO.fromJson(Map<String, dynamic>.from(e.value as Map));
      }).toList();
    });
  }
}
