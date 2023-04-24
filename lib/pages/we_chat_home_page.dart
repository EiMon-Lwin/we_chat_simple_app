import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_simple_app/blocs/we_chat_home_page_bloc.dart';
import 'package:we_chat_simple_app/consts/colors.dart';
import 'package:we_chat_simple_app/data/vos/user_vo.dart';
import 'package:we_chat_simple_app/utils/extension.dart';
import 'package:we_chat_simple_app/widgets/easy_text_widget.dart';

import '../consts/dimes.dart';
import '../consts/strings.dart';
import '../utils/images.dart';
import 'conversation_page.dart';

class WeChatHomePage extends StatelessWidget {
  const WeChatHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeChatHomePageBloc(),
      child: Consumer<WeChatHomePageBloc>(
        builder: (context, value, child) =>
            Selector<WeChatHomePageBloc, List<UserVO>>(
          selector: (_, bloc) => bloc.getAllFriends,
          builder: (context, value, child) => Scaffold(
              appBar: AppBar(
                backgroundColor: kGreenColor,
                leading: Container(),
                centerTitle: true,
                title: const Text(kWeChatText),
                actions: const [
                  Icon(Icons.search),
                  SizedBox(
                    width: kSP20x,
                  ),
                  Icon(Icons.add_circle_outline_sharp),
                  SizedBox(
                    width: kSP20x,
                  )
                ],
              ),
              body: (value.isEmpty)
                  ? const Center(
                      child: EasyTextWidget(
                      text: kNoChatsText,
                      textColor: kBlackColor,
                    ))
                  : HomePageItemView(
                      value: value,
                    )),
        ),
      ),
    );
  }
}

class HomePageItemView extends StatelessWidget {
  const HomePageItemView({super.key, required this.value});

  final List<UserVO> value;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
              height: kSP10x,
            ),
        itemCount: value.length,
        itemBuilder: (context, index) {
          return HomePageView(
            value: value[index],
            lastMessage: context.getWeChatHomePageBlocInstance().getLastMessage,
          );
        });
  }
}

class HomePageView extends StatelessWidget {
  const HomePageView({
    super.key,
    required this.value,
    required this.lastMessage,
  });

  final UserVO value;
  final String lastMessage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.navigateToNextScreen(
            context,
            ConversationPage(
              friendUserVO: value,
            ));
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: kGreenColor,
            radius: kCircleAvatarRadius40x,
            backgroundImage: NetworkImage(
                (value.file == null || value.file == "")
                    ? kDefaultImage
                    : value.file ?? kDefaultImage),
          ),
          title: EasyTextWidget(text: value.name ?? '',textColor: kBlackColor,fontWeight: kFontWeightBold,),
          subtitle: EasyTextWidget(text: lastMessage,textColor: kBlackColor,fontWeight: kFontWeightBold,),
        ),
      ),
    );
  }
}
