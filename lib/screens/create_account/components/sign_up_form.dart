import 'package:das_app/screens/otp/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:das_app/components/custom_surfix_icon.dart';
import 'package:das_app/components/default_button.dart';
import 'package:das_app/components/form_error.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String fullName;
  String userName;
  String phoneNo;
  String password;
  String conform_password;
  String address;
  bool remember = false;
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
          child: Column(children: <Widget>[
        buildFullNameFormField(),
        SizedBox(height: getProportionateScreenHeight(30)),
        buildUserNameFormField(),
        SizedBox(height: getProportionateScreenHeight(30)),
        buildPasswordFormField(),
        SizedBox(height: getProportionateScreenHeight(30)),
        buildConformPassFormField(),
        SizedBox(height: getProportionateScreenHeight(30)),
        buildAddressFormField(),
        SizedBox(height: getProportionateScreenHeight(30)),
        buildPhoneFormField(),
        SizedBox(height: getProportionateScreenHeight(30)),
        FormError(errors: errors),
        SizedBox(height: getProportionateScreenHeight(40)),
        DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState.validate()) {
                Navigator.pushNamed(context, OtpScreen.routeName);
              }
            }),
      ])),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
        obscureText: true,
        onSaved: (newValue) => conform_password = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kPassNullError);
          } else if (value.isNotEmpty && password == conform_password) {
            removeError(error: kMatchPassError);
          }
          conform_password = value;
        },
        validator: (value) {
          if (value.isEmpty) {
            addError(error: kPassNullError);
            return "";
          } else if ((password != value)) {
            addError(error: kMatchPassError);
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Confirm Password",
          hintText: "Re-enter your password",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Padding(
              padding: EdgeInsets.fromLTRB(
                  0,
                  getProportionateScreenWidth(20),
                  getProportionateScreenWidth(20),
                  getProportionateScreenWidth(20)),
              child: SvgPicture.asset(
                "assets/icons/Lock.svg",
                height: getProportionateScreenWidth(18),
                color: kPrimaryColor,
              )),
        ));
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
        obscureText: true,
        onSaved: (newValue) => password = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kPassNullError);
          } else if (value.length >= 8) {
            removeError(error: kShortPassError);
          }
          password = value;
        },
        validator: (value) {
          if (value.isEmpty) {
            addError(error: kPassNullError);
            return "";
          } else if (value.length < 8) {
            addError(error: kShortPassError);
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Password",
          hintText: "Enter your password",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Padding(
              padding: EdgeInsets.fromLTRB(
                  0,
                  getProportionateScreenWidth(20),
                  getProportionateScreenWidth(20),
                  getProportionateScreenWidth(20)),
              child: SvgPicture.asset(
                "assets/icons/Lock.svg",
                height: getProportionateScreenWidth(18),
                color: kPrimaryColor,
              )),
        ));
  }

  TextFormField buildUserNameFormField() {
    return TextFormField(
        keyboardType: TextInputType.name,
        onSaved: (newValue) => userName = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kUserNameNullError);
          } else if (value.length > 4 && value.length < 15) {
            removeError(error: kInvalidUserNameError);
          }
          return null;
        },
        validator: (value) {
          if (value.isEmpty) {
            addError(error: kUserNameNullError);
            return "";
          } else if (value.length >= 4 && value.length > 15) {
            addError(error: kInvalidUserNameError);
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "User Name",
          hintText: "Enter your user name",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Padding(
              padding: EdgeInsets.fromLTRB(
                  0,
                  getProportionateScreenWidth(20),
                  getProportionateScreenWidth(20),
                  getProportionateScreenWidth(20)),
              child: SvgPicture.asset(
                "assets/icons/User.svg",
                height: getProportionateScreenWidth(18),
                color: kPrimaryColor,
              )),
        ));
  }

  TextFormField buildFullNameFormField() {
    return TextFormField(
        keyboardType: TextInputType.name,
        onSaved: (newValue) => fullName = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kFullNameNullError);
          }
        },
        validator: (value) {
          if (value.isEmpty) {
            addError(error: kFullNameNullError);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Full Name",
          hintText: "Enter your full name",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Padding(
              padding: EdgeInsets.fromLTRB(
                  0,
                  getProportionateScreenWidth(20),
                  getProportionateScreenWidth(20),
                  getProportionateScreenWidth(20)),
              child: SvgPicture.asset(
                "assets/icons/User.svg",
                height: getProportionateScreenWidth(18),
                color: kPrimaryColor,
              )),
        ));
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
        onSaved: (newValue) => address = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kAddressNullError);
          }
        },
        validator: (value) {
          if (value.isEmpty) {
            addError(error: kAddressNullError);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Address",
          hintText: "Enter your address",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Padding(
              padding: EdgeInsets.fromLTRB(
                  0,
                  getProportionateScreenWidth(20),
                  getProportionateScreenWidth(20),
                  getProportionateScreenWidth(20)),
              child: SvgPicture.asset(
                "assets/icons/Location point.svg",
                height: getProportionateScreenWidth(18),
                color: kPrimaryColor,
              )),
        ));
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
        keyboardType: TextInputType.phone,
        onSaved: (newValue) => phoneNo = newValue,
        onChanged: (value) {
          if (value.isNotEmpty && errors.contains(kPhoneNullError)) {
            errors.remove(kPhoneNullError);
          } else if (value.length == 10 &&
              errors.contains(kInvalidPhoneError)) {
            errors.remove(kInvalidPhoneError);
          }
          return null;
        },
        validator: (value) {
          if (value.isEmpty && !errors.contains(kPhoneNullError)) {
            errors.add(kPhoneNullError);
            return "";
          } else if (value.length != 10 &&
              !errors.contains(kInvalidPhoneError)) {
            errors.add(kInvalidPhoneError);
            return "";
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "Phone",
          hintText: "Enter your phone no",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Call.svg"),
        ));
  }
}
