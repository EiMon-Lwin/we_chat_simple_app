import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:we_chat_simple_app/consts/colors.dart';
import 'package:we_chat_simple_app/consts/dimes.dart';
import 'package:we_chat_simple_app/data/apply/wechat_simple_apply_Impl.dart';
import 'package:we_chat_simple_app/data/vos/user_vo.dart';
import 'package:we_chat_simple_app/pages/first_sign_in_page.dart';
import 'package:we_chat_simple_app/pages/qr_scanner_page.dart';
import 'package:we_chat_simple_app/utils/extension.dart';
import 'package:we_chat_simple_app/widgets/easy_text_widget.dart';

import '../consts/strings.dart';
import '../data/apply/wechat_simple_apply.dart';

class QrPage extends StatefulWidget {
   const QrPage({Key? key}) : super(key: key);

  @override
  State<QrPage> createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {

  final WeChatSimpleApply _weChatSimpleApply=WeChatSimpleApplyImpl();

  UserVO? _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser=_weChatSimpleApply.getUserInfoFromCurrentUser();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        backgroundColor: kGreenColor,
        centerTitle: true,
        title: const EasyTextWidget(
          text: kQrCodeText,fontSize: kFontSize20x,

        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kSP25x),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: FloatingActionButton(
                  onPressed: (){
                    context.navigateToNextScreen(context,QrScannerPage(currentUser: _currentUser,));
                  },
                  backgroundColor: kGreenColor,
                  child: const Icon(Icons.qr_code_scanner),
                ),

              ),
              const SizedBox(height: kSP150x,),
              QrImage(data: _currentUser?.id?? '',
              size: kQrImageSize200x,
              ),
              const SizedBox(height: kSP130x,),
              LogOutButtonItemView(weChatSimpleApply: _weChatSimpleApply),




            ],
          ),
        ),

      ),

    );
  }
}

class LogOutButtonItemView extends StatelessWidget {
  const LogOutButtonItemView({
    super.key,
    required WeChatSimpleApply weChatSimpleApply,
  }) : _weChatSimpleApply = weChatSimpleApply;

  final WeChatSimpleApply _weChatSimpleApply;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: kGreenColor,
      onPressed: (){
      _weChatSimpleApply.logOut();
     context.navigateToNextScreen(context, const FirstSignInPage());
      },
      child: Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(Icons.logout,color: kWhiteColor,),
        SizedBox(width: kSP10x,),
        EasyTextWidget(text: kLogOutText,textColor: kWhiteColor,)
      ],
    ),

    );
  }
}
