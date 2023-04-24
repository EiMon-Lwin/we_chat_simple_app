import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_simple_app/blocs/conversation_page_bloc.dart';
import 'package:we_chat_simple_app/consts/colors.dart';
import 'package:we_chat_simple_app/data/vos/message_vo.dart';
import 'package:we_chat_simple_app/data/vos/user_vo.dart';
import 'package:we_chat_simple_app/utils/extension.dart';
import 'package:we_chat_simple_app/widgets/easy_text_widget.dart';

import '../consts/dimes.dart';
import '../consts/strings.dart';
import '../utils/images.dart';

class ConversationPage extends StatelessWidget {
  const ConversationPage({Key? key, required this.friendUserVO})
      : super(key: key);

  final UserVO friendUserVO;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ConversationPageBloc(friendUserVO.id),
      child: Consumer<ConversationPageBloc>(
        builder: (context, value, child) => (friendUserVO == null)
            ? const EasyTextWidget(text: kSayHiText)
            : Scaffold(
                appBar: AppBar(
                  backgroundColor: kGreenColor,
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: kCircleAvatarRadius20x,
                        backgroundImage: NetworkImage(
                            (friendUserVO.file == null ||
                                    friendUserVO.file == "")
                                ? kDefaultImage
                                : friendUserVO.file ?? kDefaultImage),
                      ),
                      const SizedBox(
                        width: kSP10x,
                      ),
                      EasyTextWidget(
                        text: friendUserVO.name ?? '',
                        fontSize: kFontSize15x,
                      ),
                    ],
                  ),
                  actions: const [
                    Icon(Icons.phone),
                    SizedBox(
                      width: kSP20x,
                    ),
                    Icon(Icons.video_call),
                    SizedBox(
                      width: kSP20x,
                    ),
                    Icon(Icons.info),
                    SizedBox(
                      width: kSP20x,
                    ),
                  ],
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Selector<ConversationPageBloc, List<MessageVO>>(
                          selector: (_, bloc) => bloc.getChattingMessages,
                          builder: (context, value, child) {
                            return ChattingMessageItemView(
                              friendUserVO: friendUserVO,
                              value: value.reversed.toList(),
                            );
                          }),
                    ),
                    TextingMessageItemView(
                      isTexting: context
                          .getConversationPageBlocInstance()
                          .getSendMessage,
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

class ChattingMessageItemView extends StatelessWidget {
  const ChattingMessageItemView({
    super.key,
    required this.friendUserVO,
    required this.value,
  });

  final UserVO friendUserVO;
  final List<MessageVO> value;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      reverse: true,
      separatorBuilder: (context, index) => const SizedBox(
        height: kSP5x,
      ),
      itemCount: value.length,
      itemBuilder: (context, index) {
        String chatMessage = value[index].message ?? '';
        return Row(
          mainAxisAlignment: (value[index].currentUserID != friendUserVO.id)
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                width: (chatMessage.length <= 10)
                    ? kChatContainerWidth90x
                    : (chatMessage.length <= 50)
                        ? kChatContainerWidth150x
                        : kChatContainerWidth200x,
                margin: const EdgeInsets.only(
                    right: kSP10x, bottom: kSP5x, top: kSP5x, left: kSP5x),
                padding: const EdgeInsets.all(kSP10x),
                decoration: BoxDecoration(
                    color: (value[index].currentUserID != friendUserVO.id)
                        ? kCurrentUserTextColor
                        : kFriendTextColor,
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(
                            kChatContainerRadiusCircular15x),
                        bottomLeft: Radius.circular(
                            (value[index].currentUserID != friendUserVO.id)
                                ? kChatContainerRadiusCircular15x
                                : 0),
                        topRight: const Radius.circular(
                            kChatContainerRadiusCircular15x),
                        bottomRight: Radius.circular(
                            (value[index].currentUserID != friendUserVO.id)
                                ? 0
                                : kChatContainerRadiusCircular15x))),
                child: EasyTextWidget(
                  text: chatMessage,
                  fontSize: kChatTextSize20x,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

class TextingMessageItemView extends StatelessWidget {
  const TextingMessageItemView({super.key, required this.isTexting});

  final bool isTexting;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: kSP10x, bottom: kSP5x),
      height: kTextingSpaceHeight60x,
      color: kCurrentUserTextColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: kSP20x,
          ),
          (isTexting)
              ? const Center(child: Icon(Icons.arrow_forward_ios_rounded))
              : const Center(child: Icon(Icons.drag_indicator_outlined)),
          (isTexting)
              ? const SizedBox()
              : const SizedBox(
                  width: kSP20x,
                ),
          (isTexting)
              ? const SizedBox()
              : const Center(child: Icon(Icons.camera_alt_rounded)),
          (isTexting)
              ? const SizedBox()
              : const SizedBox(
                  width: kSP20x,
                ),
          (isTexting)
              ? const SizedBox()
              : const Center(child: Icon(Icons.mic_rounded)),
          (isTexting)
              ? const SizedBox()
              : const SizedBox(
                  width: kSP20x,
                ),
          Expanded(
            child: Container(
              width: (isTexting) ? kTextFieldWidth200x : kTextFieldWidth150x,
              height: kTextFieldHeight50x,
              padding: const EdgeInsets.only(left: kSP10x),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: kBlackColor,
                  ),
                  borderRadius: const BorderRadius.all(
                      Radius.circular(kTextFieldBorderRadius40x))),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(
                      context.getConversationPageBlocInstance().getFocusNode);
                },
                child: TextField(
                  maxLines: kTextFieldMaxLines150,
                  focusNode:
                      context.getConversationPageBlocInstance().getFocusNode,
                  controller: context
                      .getConversationPageBlocInstance()
                      .getMessageTextController,
                  onChanged: (value) => context
                      .getConversationPageBlocInstance()
                      .checkMessage(value),
                  decoration: InputDecoration(
                      hintText: kTextFieldHintText,
                      border: InputBorder.none,
                      suffixIcon: (isTexting)
                          ? const Icon(
                              Icons.search_rounded,
                              color: kBlackColor,
                            )
                          : const Icon(
                              Icons.sentiment_satisfied_alt,
                              color: kBlackColor,
                            )),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: kSP15x,
          ),
          GestureDetector(
              onTap: () {
                context.getConversationPageBlocInstance().sendMessageMethod();
              },
              child: const Padding(
                padding: EdgeInsets.only(right: kSP10x),
                child: Center(child: Icon(Icons.send)),
              ))
        ],
      ),
    );
  }
}
