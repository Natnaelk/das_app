import 'package:das_app/components/custom_surfix_icon.dart';
import 'package:das_app/components/default_button.dart';
import 'package:das_app/components/form_error.dart';
import 'package:das_app/helper/keyboard.dart';
import 'package:das_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:das_app/screens/home/home_screen.dart';
import 'package:das_app/screens/login_success/login_success_screen.dart';
import 'package:das_app/screens/sign_in/sign_in_screen.dart';
import 'package:das_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/src/provider.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController confirmcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool shouldNavigate;

  String email;
  String password;
  bool remember = false;
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Continue",
            press: () async {
              shouldNavigate =
                  await signIn(emailcontroller.text, passcontroller.text);
              if (_formKey.currentState.validate() && shouldNavigate) {
                Navigator.pushNamedAndRemoveUntil(
                    context, HomeScreen.routeName, (route) => false);

                _formKey.currentState.save();

                KeyboardUtil.hideKeyboard(context);
              } else {
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("An error occured, please try again"),
                    backgroundColor: kPrimaryColor));
                //Navigator.pushNamed(context, SignInScreen.routeName);
              }
              // try {
              //   FirebaseAuth.instance.signInWithEmailAndPassword(
              //       email: email, password: password);
              // } catch (e) {
              //   print(e);
              //   var snackbar = SnackBar(
              //       content: Text(
              //     e.toString(),
              //     style: TextStyle(fontSize: 20),
              //   ));
              //   Scaffold.of(context).showSnackBar(snackbar);
              // }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      controller: passcontroller,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: emailcontroller,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
