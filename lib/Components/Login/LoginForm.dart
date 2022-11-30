import 'package:cleanify/Components/custom_surfix_icon.dart';
import 'package:cleanify/Components/default_button_custome_color.dart';
import 'package:cleanify/Screens/Register/RegisterScreens.dart';
import 'package:cleanify/size_config.dart';
import 'package:cleanify/utils/constants.dart';
import 'package:flutter/material.dart';

class SignInform extends StatefulWidget {
  @override
  _SignInForm createState() => _SignInForm();
}

class _SignInForm extends State<SignInform> {
  TextEditingController txtEmail = TextEditingController(),
      txtPassword = TextEditingController();

  FocusNode focusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        buildEmail(),
        SizedBox(
          height: getProportionateScreenHeight(30),
        ),
        buildPassword(),
        SizedBox(
          height: getProportionateScreenHeight(30),
        ),
        DefaultButtonCustomeColor(
          color: kPrimaryColor,
          text: "LOGIN",
          press: () {}, //arahin ke homepage
        ),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RegisterScreen.routeName);
            },
            child: Text(
              "Register if you dont have an account",
              style: TextStyle(decoration: TextDecoration.underline),
            ))
      ],
    ));
  }

  TextFormField buildEmail() {
    return TextFormField(
      controller: txtEmail,
      keyboardType: TextInputType.emailAddress,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'Please enter your email',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
            svgIcon: "assets/icons/User.svg",
          )),
    );
  }

  TextFormField buildPassword() {
    return TextFormField(
      controller: txtPassword,
      obscureText: true,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Password',
          hintText: 'Please enter your password',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
            svgIcon: "assets/icons/Lock.svg",
          )),
    );
  }
}
