import 'package:das_app/components/custom_surfix_icon.dart';
import 'package:das_app/screens/login_success/login_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:das_app/components/default_button.dart';
import 'package:das_app/components/form_error.dart';
import 'package:das_app/components/no_account_text.dart';
import 'package:das_app/size_config.dart';

import '../../../constants.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Please enter your phone and we will send \nyou a verificaton code",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              const ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  const ForgotPassForm({Key key}) : super(key: key);

  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String phone;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.phone,
            onSaved: (newValue) => phone = newValue,
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
            decoration: const InputDecoration(
              labelText: "Phone",
              hintText: "Enter Your Phone number",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Call.svg"),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState.validate()) {
                // for future construction
                Navigator.pushNamed(context, LoginSuccessScreen.routeName);
              }
            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          const NoAccountText(),
        ],
      ),
    );
  }
}
