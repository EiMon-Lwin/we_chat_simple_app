import 'package:flutter/material.dart';
import 'package:we_chat_simple_app/consts/colors.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({Key? key,required this.hintText,this.obscureText=false, required this.validator, required this.onChanged,required this.controller, required this.onTap}) : super(key: key);

 final String hintText;
 final bool obscureText;
 final Function(String? value) validator;
 final Function(String value) onChanged;
 final Function onTap;
 final TextEditingController controller;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: ()=> onTap(),
      style: const TextStyle(color: kWhiteColor),
      validator: (value)=>validator(value),
      onChanged: (value)=> onChanged(value),
      obscureText: obscureText,
     controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: kGreyColor)
      ),
    );
  }
}
