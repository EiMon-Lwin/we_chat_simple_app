import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_simple_app/blocs/conversation_page_bloc.dart';
import 'package:we_chat_simple_app/blocs/we_chat_home_page_bloc.dart';

import '../blocs/first_sign_up_bloc.dart';

extension ContentExtension on BuildContext {

  Future navigateToNextScreen(BuildContext context, Widget nextScreen) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => nextScreen));

  void navigateBack(BuildContext context) => Navigator.of(context).pop();

  // Future navigateToNextScreenReplace(BuildContext context, Widget nextPage) =>
  //     Navigator.of(context)
  //         .pushReplacement(MaterialPageRoute(builder: (context) => nextPage));

  FirstSignUpBloc getFirstSignInBlocInstance() => read<FirstSignUpBloc>();

  ConversationPageBloc getConversationPageBlocInstance() =>
      read<ConversationPageBloc>();

  WeChatHomePageBloc getWeChatHomePageBlocInstance() =>
      read<WeChatHomePageBloc>();
}

