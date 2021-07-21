import 'package:das_app/components/default_button.dart';
import 'package:das_app/components/form_error.dart';
import 'package:das_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String phoneNo;
  String password;
  bool remember = false;
  final List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Form(
        key: _formKey,
        child: Column(
          children: [
            buildPhoneFormField(),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            buildPasswordFormField(),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Row(
              children: <Widget>[
                Checkbox(
                    value: remember,
                    activeColor: kPrimaryColor,
                    onChanged: (value) {
                      setState(() {
                        remember = value;
                      });
                    }),
                const Text("Remember Me"),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(
                      context, ForgotPasswordScreen.routeName),
                  child: const Text(
                    "Forgot Password",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            FormError(errors: errors),
            DefaultButton(
                text: "Continue",
                press: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                  }
                }),
          ],
        ));
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
        keyboardType: TextInputType.phone,
        onSaved: (newValue) => phoneNo = newValue,
        onChanged: (value) {
          if (value.isNotEmpty && errors.contains(kPhoneNullError)) {
            setState(() {
              errors.remove(kPhoneNullError);
            });
          } else if (value.length == 10 &&
              errors.contains(kInvalidPhoneError)) {
            setState(() {
              errors.remove(kInvalidPhoneError);
            });
          }
          return null;
        },
        validator: (value) {
          if (value.isEmpty && !errors.contains(kPhoneNullError)) {
            setState(() {
              errors.add(kPhoneNullError);
            });
          } else if (value.length != 10 &&
              !errors.contains(kInvalidPhoneError)) {
            setState(() {
              errors.add(kInvalidPhoneError);
            });
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: "Phone",
            hintText: "Enter your phone no",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: Padding(
                padding: EdgeInsets.fromLTRB(
                    0,
                    getProportionateScreenWidth(20),
                    getProportionateScreenWidth(20),
                    getProportionateScreenWidth(20)),
                child: SvgPicture.asset(
                  "assets/icons/Call.svg",
                  height: getProportionateScreenWidth(18),
                ))));
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
        keyboardType: TextInputType.visiblePassword,
        onSaved: (newValue) => password = newValue,
        onChanged: (value) {
          if (value.isNotEmpty && errors.contains(kPassNullError)) {
            setState(() {
              errors.remove(kPassNullError);
            });
          } else if (value.length >= 8 && errors.contains(kShortPassError)) {
            setState(() {
              errors.remove(kShortPassError);
            });
          }
          return null;
        },
        validator: (value) {
          if (value.isEmpty && !errors.contains(kPassNullError)) {
            setState(() {
              errors.add(kPassNullError);
            });
          } else if (value.length < 8 && !errors.contains(kShortPassError)) {
            setState(() {
              errors.add(kShortPassError);
            });
          }
          return null;
        },
        obscureText: true,
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
                ))));
  }
}
