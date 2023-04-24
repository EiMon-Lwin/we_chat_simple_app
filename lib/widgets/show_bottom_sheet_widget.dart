import 'package:flutter/material.dart';
import 'package:we_chat_simple_app/utils/extension.dart';
import 'package:we_chat_simple_app/widgets/easy_text_widget.dart';

import '../consts/colors.dart';
import '../consts/dimes.dart';
import '../consts/strings.dart';
import '../pages/sign_up_via_mobile_page.dart';

class ShowBottomSheetWidget extends StatelessWidget {
  const ShowBottomSheetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kShowBottomSContainerHeight230x,
      color: kBlackColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              color: kListTileColor,
              child: Column(
                children:  [
                  ListTile(
                    title: const Center(
                      child: EasyTextWidget(
                        text: kSignInWithMobileText,
                        textColor: kWhiteColor,
                      ),
                    ),
                    onTap: (){
                   context.navigateToNextScreen(context,const SignUPViaMobilePage());
                    },
                  ),
                  const ListTile(
                    title: Center(
                      child: EasyTextWidget(
                        text: kSignInWithFacebookText,
                        textColor: kWhiteColor,
                      ),
                    ),
                  )
                ],
              )),
          const SizedBox(
            height: kSP15x,
          ),
          Container(
            color: kListTileColor,
            child: ListTile(
              title: const Center(
                child: EasyTextWidget(
                  text: kCancelText,
                  textColor: kWhiteColor,
                ),
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
