import 'package:flutter/material.dart';
import 'package:we_chat_simple_app/consts/colors.dart';
import 'package:we_chat_simple_app/pages/login_page.dart';
import 'package:we_chat_simple_app/utils/extension.dart';

import '../consts/dimes.dart';
import '../consts/strings.dart';
import '../utils/images.dart';
import '../widgets/show_bottom_sheet_widget.dart';

class FirstSignInPage extends StatelessWidget {
  const FirstSignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(kWeChatFinalImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: kSP60x,
                  ),
                  MaterialButton(
                    onPressed: () {
                      context.navigateToNextScreen(context, const LoginPage());
                    },
                    color: kGreenColor,
                    child: const Text(kLoginString),
                  ),
                  const SizedBox(
                    width: kSP50x,
                  ),
                  MaterialButton(
                    onPressed: () {
                      var sheetController = scaffoldKey.currentState
                          ?.showBottomSheet(
                              (context) => const ShowBottomSheetWidget());
                      sheetController?.closed.then((value) => {});
                    },
                    color: kWhiteColor,
                    child: const Text(kSignUpString),
                  ),
                ],
              ),
              const SizedBox(
                height: kSP50x,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
