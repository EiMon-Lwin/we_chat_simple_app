import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_simple_app/utils/extension.dart';
import 'package:we_chat_simple_app/utils/file_picker.dart';
import 'package:we_chat_simple_app/widgets/easy_text_widget.dart';
import 'package:we_chat_simple_app/widgets/text_field_widget.dart';

import '../blocs/first_sign_up_bloc.dart';
import '../consts/colors.dart';
import '../consts/dimes.dart';
import '../consts/strings.dart';
import 'email_page.dart';

class SignUPViaMobilePage extends StatelessWidget {
  const SignUPViaMobilePage({Key? key}) : super(key: key);

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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const EasyTextWidget(text: kSignUpByPhoneNumber),
                      const SizedBox(
                        height: kSP20x,
                      ),
                      Selector<FirstSignUpBloc, File?>(
                        selector: (_, bloc) => bloc.getSelectedFile,
                        builder: (context, selectedFile, child) =>
                            GestureDetector(
                          onTap: () {
                            getSelectedFile().then((value) {
                              context
                                  .getFirstSignInBlocInstance()
                                  .selectFile(value);
                            });
                          },
                          child: Selector<FirstSignUpBloc, String?>(
                            selector: (_, bloc) => bloc.getSelectedFilePath,
                            builder: (context, value, child) {
                              if (value != null) {
                                return Image.file(selectedFile!,
                                    width: kProfileWidth100x,
                                    height: kProfileHeight130x,
                                    fit: BoxFit.cover);
                              }
                              return Container(
                                color: kWhiteColor,
                                width: kProfileWidth100x,
                                height: kProfileHeight130x,
                                child: const Icon(
                                  Icons.camera,
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: kSP30x,
                  ),
                  NameTextFieldItemView(
                    prefixText: kNameText,
                    controller: context
                        .getFirstSignInBlocInstance()
                        .getNameTextFieldController,
                    hintText: kEnterNameText,
                  ),
                  const SizedBox(
                    height: kSP10x,
                  ),
                  RegionTextFieldItemView(
                    prefixText: kRegionText,
                    controller: context
                        .getFirstSignInBlocInstance()
                        .getRegionTextFieldController,
                    hintText: kChooseRegionText,
                  ),
                  const SizedBox(
                    height: kSP10x,
                  ),
                  PhoneTextFieldItemView(
                    prefixText: kPhoneText,
                    hintText: kEnterPhoneNumberText,
                    controller: context
                        .getFirstSignInBlocInstance()
                        .getPhoneTextFieldController,
                  ),
                  const SizedBox(
                    height: kSP10x,
                  ),
                  PasswordTextFieldItemView(
                    prefixText: kPasswordText,
                    hintText: kEnterPasswordText,
                    controller: context
                        .getFirstSignInBlocInstance()
                        .getPasswordTextFieldController,
                  ),
                  const SizedBox(
                    height: kSP40x,
                  ),
                  ReadAndAcceptItemView(
                    globalKey: bloc.getGlobalKey,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ReadAndAcceptItemView extends StatelessWidget {
  const ReadAndAcceptItemView({
    super.key,
    required this.globalKey,
  });

  final GlobalKey<FormState> globalKey;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: kAcceptBoxWidth290x,
      child: Selector<FirstSignUpBloc, bool>(
        selector: (_, bloc) => bloc.getIsAccept,
        builder: (context, value, child) => Column(
          children: [
            SizedBox(
              width: kAcceptBoxWidth290x,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.getFirstSignInBlocInstance().isReadAndAccept();
                    },
                    child: Icon(
                      Icons.check_circle_outline_rounded,
                      color: (value == false) ? kWhiteColor : kGreenColor,
                    ),
                  ),
                  const SizedBox(
                      width: kAcceptBoxWidth250x,
                      child: EasyTextWidget(text: kAcceptText))
                ],
              ),
            ),
            const SizedBox(
              height: kSP30x,
            ),
            const SizedBox(
                width: kAcceptBoxWidth290x,
                child: EasyTextWidget(text: kExpressionText)),
            const SizedBox(
              height: kSP30x,
            ),
            MaterialButton(
              color: (value == false) ? kGreyColor : kGreenColor,
              height: kMaterialButtonHeight50x,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kBorderRadiusCircular10x),
              ),
              onPressed: () {
                if (globalKey.currentState?.validate() ?? false) {
                  (value == false)
                      ? context.navigateBack(context)
                      : context.navigateToNextScreen(
                          context,
                          EmailPage(
                            file: context
                                .getFirstSignInBlocInstance()
                                .getSelectedFile,
                            userName:
                                context.getFirstSignInBlocInstance().getName,
                            countryName: context
                                    .getFirstSignInBlocInstance()
                                    .getSelectedCountry ??
                                '',
                            phNoNum: context
                                    .getFirstSignInBlocInstance()
                                    .getPhoneCode ??
                                '',
                            password: context
                                .getFirstSignInBlocInstance()
                                .getPassword,
                          ));
                }
              },
              child: const EasyTextWidget(
                text: kAcceptAndContinueText,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PasswordTextFieldItemView extends StatelessWidget {
  const PasswordTextFieldItemView(
      {super.key,
      required this.prefixText,
      required this.hintText,
      required this.controller});

  final String prefixText;
  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        EasyTextWidget(text: prefixText),
        const SizedBox(
          width: kSP30x,
        ),
        SizedBox(
          width: kTextFieldWidth230x,
          child: Selector<FirstSignUpBloc, bool>(
            selector: (_, bloc) => bloc.getIsVisibility,
            builder: (context, value, child) => TextFormField(
              controller: controller,
              style: const TextStyle(color: kWhiteColor),
              obscureText: value,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(color: kGreyColor),
                suffixIcon: GestureDetector(
                  onTap: () {
                    context.getFirstSignInBlocInstance().setVisibility();
                  },
                  child: (value == true)
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                ),
              ),
              validator: (value) {
                if (value?.isEmpty ?? false) {
                  return kValidatorText;
                }
                if (value!.length < 6) {
                  return kPasswordValidator;
                }
                return null;
              },
              onChanged: (String value) {
                context.getFirstSignInBlocInstance().setPassword = value;
              },
            ),
          ),
        )
      ],
    );
  }
}

class PhoneTextFieldItemView extends StatelessWidget {
  const PhoneTextFieldItemView(
      {super.key,
      required this.prefixText,
      required this.hintText,
      required this.controller});

  final String prefixText;
  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        EasyTextWidget(text: prefixText),
        const SizedBox(
          width: kSP53x,
        ),
        SizedBox(
          width: kTextFieldWidth230x,
          child: TextFieldWidget(
            validator: (value) {
              if (value?.isEmpty ?? false) {
                return kValidatorText;
              }
              if ((value?.length ?? 0) >= 5 && (value?.length ?? 0) <= 9) {
                return kPhoneUnValidateText;
              }
              return null;
            },
            onChanged: (String value) {
              context.getFirstSignInBlocInstance().setPhoneCode = value;
            },
            controller: controller,
            hintText: hintText,
            onTap: () {},
          ),
        )
      ],
    );
  }
}

class RegionTextFieldItemView extends StatelessWidget {
  const RegionTextFieldItemView(
      {super.key,
      required this.prefixText,
      required this.controller,
      required this.hintText});

  final String prefixText;
  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        EasyTextWidget(text: prefixText),
        const SizedBox(
          width: kSP48x,
        ),
        Selector<FirstSignUpBloc, String?>(
          selector: (_, bloc) => bloc.getSelectedCountry,
          builder: (BuildContext context, value, Widget? child) => SizedBox(
              width: kTextFieldWidth230x,
              child: TextFieldWidget(
                onChanged: (value) {
                  context.getFirstSignInBlocInstance().setSelectedCountry =
                      value;
                },
                controller: controller,
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    return kCountryValidatorText;
                  }
                  return null;
                },
                hintText: hintText,
                onTap: () {
                  context
                      .getFirstSignInBlocInstance()
                      .openCountryPicker(context);
                },
              )),
        )
      ],
    );
  }
}

class NameTextFieldItemView extends StatelessWidget {
  const NameTextFieldItemView({
    super.key,
    required this.prefixText,
    required this.controller,
    required this.hintText,
  });

  final String prefixText;
  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        EasyTextWidget(text: prefixText),
        const SizedBox(
          width: kSP53x,
        ),
        SizedBox(
          width: kTextFieldWidth230x,
          child: TextFieldWidget(
            controller: controller,
            hintText: hintText,
            validator: (value) {
              if (value?.isEmpty ?? false) {
                return kValidatorText;
              }
              return null;
            },
            onChanged: (value) {
              context.getFirstSignInBlocInstance().setName = value;
            },
            onTap: () {},
          ),
        )
      ],
    );
  }
}
