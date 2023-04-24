import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_simple_app/pages/login_page.dart';
import 'package:we_chat_simple_app/pages/we_chat_home_page.dart';
import 'package:we_chat_simple_app/utils/extension.dart';
import 'package:we_chat_simple_app/widgets/easy_text_widget.dart';

import '../blocs/first_sign_up_bloc.dart';
import '../consts/colors.dart';
import '../consts/dimes.dart';
import '../consts/strings.dart';
import '../widgets/loading_alret_dialog_widget.dart';
import '../widgets/text_field_widget.dart';
import 'bottom_navigation_page.dart';

class EmailPage extends StatelessWidget {
  const EmailPage(
      {Key? key,
      this.file,
      required this.userName,
      required this.countryName,
      required this.phNoNum,
      required this.password})
      : super(key: key);

  final File? file;
  final String userName;
  final String countryName;
  final String phNoNum;
  final String password;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FirstSignUpBloc>(
      create: (context) => FirstSignUpBloc(),
      child: Consumer<FirstSignUpBloc>(
        builder: (context, bloc, child) => Form(
          key: bloc.getGlobalKey,
          child: Scaffold(
            backgroundColor: kBlackColor,
            appBar: AppBar(
              backgroundColor: kBlackColor,
              leading: GestureDetector(
                child: const Icon(Icons.close),
                onTap: () => context.navigateBack(context),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: kSP100x),
                height: kEmailBoxSizeHeight500x,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const EasyTextWidget(
                      text: kEnterMailText,
                      fontSize: kFontSize16x,
                    ),
                    const SizedBox(
                      height: kSP20x,
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
                              context.getFirstSignInBlocInstance().setEmail =
                                  value;
                            },
                            controller: context
                                .getFirstSignInBlocInstance()
                                .getEmailTextFieldController,
                            onTap: () {},
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: kSP350x,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: kSP80x),
                      child: MaterialButton(
                        minWidth: kDoneButtonWidth200x,
                        onPressed: () {
                          if (bloc.getGlobalKey.currentState?.validate() ??
                              false) {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) =>
                                  const LoadingAlertDialogWidget(),
                            );
                            context
                                .getFirstSignInBlocInstance()
                                .register(userName, phNoNum, countryName,
                                    password, file)
                                .then((value) {
                              context.navigateBack(context);
                              context.navigateToNextScreen(
                                  context, const LoginPage());
                            }).catchError((error) {
                              context.navigateBack(context);

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
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
                          text: kDoneText,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
