import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_simple_app/blocs/contacts_bloc.dart';
import 'package:we_chat_simple_app/consts/colors.dart';
import 'package:we_chat_simple_app/consts/dimes.dart';
import 'package:we_chat_simple_app/pages/we_chat_home_page.dart';
import 'package:we_chat_simple_app/widgets/easy_text_widget.dart';

import '../consts/strings.dart';
import '../data/vos/user_vo.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ContactsBloc(),
      child: Selector<ContactsBloc, List<UserVO>>(
        selector: (_, bloc) => bloc.contactsList,
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: Container(),
            backgroundColor: kGreenColor,
            title: const EasyTextWidget(
              text: kContactsText,
              fontSize: kFontSize20x,
              fontWeight: FontWeight.bold,
            ),
          ),
          body: (value.isEmpty)
              ? const Center(
                  child: EasyTextWidget(
                  text: kNoContactsText,
                  textColor: kBlackColor,
                ))
              : ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: kSP5x,
                  ),
                  itemCount: value.length,
                  itemBuilder: (context, index) =>
                      HomePageView(value: value[index], lastMessage: ''),
                ),
        ),
      ),
    );
  }
}
