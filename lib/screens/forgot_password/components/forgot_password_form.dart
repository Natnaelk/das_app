import 'package:das_app/components/custom_surfix_icon.dart';
import 'package:das_app/components/default_button.dart';
import 'package:das_app/components/form_error.dart';
import 'package:das_app/components/no_account_text.dart';
import 'package:das_app/helper/keyboard.dart';
import 'package:das_app/services/auth.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  void _resetPassword(String email, BuildContext context) async {
    try {
      String _returnString = await Auth().resetPassword(email);
      if (_returnString == "success") {
        Scaffold.of(context).showSnackBar(SnackBar(
          backgroundColor: kPrimaryColor,
          content:
              Text("We've sent an Email verification please check your Email!"),
          duration: Duration(seconds: 5),
        ));
        Future.delayed(Duration(seconds: 5), () {
          Navigator.of(context).pop();
        });
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(
          backgroundColor: kPrimaryColor,
          content: Text(_returnString),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      print(e);
    }
  }

  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String email;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            onSaved: (newValue) => email = newValue,
            onChanged: (value) {
              if (value.isNotEmpty && errors.contains(kEmailNullError)) {
                setState(() {
                  errors.remove(kEmailNullError);
                });
              } else if (emailValidatorRegExp.hasMatch(value) &&
                  errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.remove(kInvalidEmailError);
                });
              }
              return null;
            },
            validator: (value) {
              if (value.isEmpty && !errors.contains(kEmailNullError)) {
                setState(() {
                  errors.add(kEmailNullError);
                });
              } else if (!emailValidatorRegExp.hasMatch(value) &&
                  !errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.add(kInvalidEmailError);
                });
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
            ),
          ),
          SizedBox(height: 30),
          FormError(errors: errors),
          SizedBox(height: 100),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                _resetPassword(email, context);
                KeyboardUtil.hideKeyboard(context);
              }
            },
          ),
          SizedBox(height: 100),
          NoAccountText(),
        ],
      ),
    );
  }
}
