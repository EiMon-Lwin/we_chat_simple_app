import 'package:flutter/material.dart';
import 'package:we_chat_simple_app/data/apply/wechat_simple_apply.dart';
import 'package:we_chat_simple_app/data/apply/wechat_simple_apply_Impl.dart';
import 'package:we_chat_simple_app/utils/extension.dart';

import '../consts/colors.dart';
import '../consts/dimes.dart';
import '../consts/strings.dart';
import '../utils/images.dart';
import '../widgets/easy_text_widget.dart';
import '../widgets/loading_alret_dialog_widget.dart';
import '../widgets/text_field_widget.dart';
import 'bottom_navigation_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  final WeChatSimpleApply _weChatSimpleApply = WeChatSimpleApplyImpl();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      appBar: AppBar(
        backgroundColor: kGreenColor,
        centerTitle: true,
        title: const EasyTextWidget(text: kLoginString),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: kSP100x),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  kLoginProfileImage,
                  width: kLoginProfileWidth80x,
                  height: kLoginProfileHeight100x,
                ),
                const SizedBox(
                  height: kSP30x,
                ),
                Row(
                  children: [
                    const EasyTextWidget(text: kMailText),
                    const SizedBox(
                      width: kSP53x,
                    ),
                    SizedBox(
                      width: kTextFieldWidth230x,
                      child: TextFieldWidget(
                        hintText: kMailHintText,
                        validator: (value) {
                          if (value?.isEmpty ?? false) {
                            return kValidatorText;
                          }
                          return null;
                        },
                        onChanged: (value) {
                          email = value;
                        },
                        controller: emailController,
                        onTap: () {},
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: kSP30x,
                ),
                Row(
                  children: [
                    const EasyTextWidget(text: kLoginPassword),
                    const SizedBox(
                      width: kSP24x,
                    ),
                    SizedBox(
                      width: kTextFieldWidth230x,
                      child: TextFieldWidget(
                        hintText: kEnterPasswordText,
                        validator: (value) {
                          if (value?.isEmpty ?? false) {
                            return kValidatorText;
                          }
                          return null;
                        },
                        onChanged: (value) {
                          password = value;
                        },
                        controller: passwordController,
                        onTap: () {},
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: kSP200x,
                ),
                MaterialButton(
                  minWidth: kDoneButtonWidth200x,
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => const LoadingAlertDialogWidget(),
                      );
                      _weChatSimpleApply
                          .loginUser(email, password)
                          .then((value) {
                        context.navigateBack(context);
                        context.navigateToNextScreen(
                            context, const BottomNavPage());
                      }).catchError((error) {
                        context.navigateBack(context);

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: EasyTextWidget(
                          text: error.toString(),
                          textColor: kBlackColor,
                        )));
                      });
                    }
                  },
                  color: kGreenColor,
                  height: kMaterialButtonHeight50x,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(kBorderRadiusCircular10x),
                  ),
                  child: const EasyTextWidget(
                    text: kLoginString,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
