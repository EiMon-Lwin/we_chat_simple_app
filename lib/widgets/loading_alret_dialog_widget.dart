
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_chat_simple_app/widgets/easy_text_widget.dart';

import '../consts/colors.dart';
import '../consts/dimes.dart';
import '../consts/strings.dart';

class LoadingAlertDialogWidget extends StatelessWidget {
  const LoadingAlertDialogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          CircularProgressIndicator(),
          SizedBox(
            width: kSP20x,
          ),
          EasyTextWidget(
            text: kLoadingText,
            fontSize: kFontSize20x,
            textColor: kGreenColor,
          )
        ],
      ),

    );
  }
}