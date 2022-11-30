import 'package:cleanify/Components/custom_surfix_icon.dart';
import 'package:cleanify/Components/default_button_custome_color.dart';
import 'package:cleanify/Screens/Login/LoginScreens.dart';
import 'package:cleanify/Screens/Register/RegisterScreens.dart';
import 'package:cleanify/size_config.dart';
import 'package:cleanify/utils/constants.dart';
import 'package:flutter/material.dart';

class SignUpform extends StatefulWidget {
  @override
  _SignUpForm createState() => _SignUpForm();
}

class _SignUpForm extends State<SignUpform> {
  TextEditingController txtEmail = TextEditingController(),
                        txtUsername = TextEditingController(),
                        txtPassword = TextEditingController(),
                        txtFullname = TextEditingController(),
                        txtPhonenumber = TextEditingController(),
                        txtAddress = TextEditingController();

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

        buildUsername(),
        SizedBox(
          height: getProportionateScreenHeight(30),
        ),

        buildPassword(),
        SizedBox(
          height: getProportionateScreenHeight(30),
        ),

        buildFullname(),
        SizedBox(
          height: getProportionateScreenHeight(30),
        ),

        buildPhoneNumber(),
        SizedBox(
          height: getProportionateScreenHeight(30),
        ),

        buildAddress(),
        SizedBox(
          height: getProportionateScreenHeight(30),
        ),

        DefaultButtonCustomeColor(
          color: kPrimaryColor,
          text: "Register",
          press: () {}, //masih bingung ini kmn yaa??
        ),
        SizedBox(
          height: 20,
        ),

        GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, LoginScreen.routeName);
            },
            child: Text(
              "Login if you already have an account",
              style: TextStyle(decoration: TextDecoration.underline),
            )),

        SizedBox(
          height: 20,
        ),
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

  TextFormField buildUsername() {
    return TextFormField(
      controller: txtUsername,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Username',
          hintText: 'Please enter your username',
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

  TextFormField buildFullname() {
    return TextFormField(
      controller: txtFullname,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Full Name',
          hintText: 'Please enter your full name',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
            svgIcon: "assets/icons/User.svg",
          )),
    );
  }

  TextFormField buildPhoneNumber() {
    return TextFormField(
      controller: txtPhonenumber,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Phone Number',
          hintText: 'Please enter your phone number',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
            svgIcon: "assets/icons/Phone.svg",
          )),
    );
  }

  TextFormField buildAddress() {
    return TextFormField(
      controller: txtAddress,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Address',
          hintText: 'Please enter your address',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
            svgIcon: "assets/icons/Location point.svg",
          )),
    );
  }
}
