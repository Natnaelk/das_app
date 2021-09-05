import 'package:das_app/helper/keyboard.dart';
import 'package:das_app/screens/otp/full_otp.dart';
import 'package:das_app/screens/otp/otp_screen.dart';
import 'package:das_app/screens/sign_in/sign_in_screen.dart';
import 'package:das_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:das_app/components/custom_surfix_icon.dart';
import 'package:das_app/components/default_button.dart';
import 'package:das_app/components/form_error.dart';
import '../../../constants.dart';

class PhoneLogIn extends StatefulWidget {
  @override
  _PhoneLogIn createState() => _PhoneLogIn();
}

class _PhoneLogIn extends State<PhoneLogIn> {
  TextEditingController phonecontroller = TextEditingController();

// sign up user

  final _formKey = GlobalKey<FormState>();

  String phoneNumber;

  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: (100)),
              Text(
                'Phone Verification',
                style: TextStyle(color: kSecondaryColor, fontSize: 20),
              ),
              const SizedBox(height: (80)),
              buildPhoneFormField(),
              const SizedBox(height: (30)),
              FormError(errors: errors),
              const SizedBox(height: (40)),
              DefaultButton(
                  text: "Continue",
                  press: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              OTPScreen(phone: phonecontroller.text),
                        ),
                        (route) => false,
                      );
                      KeyboardUtil.hideKeyboard(context);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      controller: phonecontroller,
      keyboardType: TextInputType.phone,
      maxLength: 10,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length == 10) {
          removeError(error: kShortPhoneError);
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        } else if (value.length < 10) {
          addError(error: kShortPhoneError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Phone",
        hintText: "phone number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
        prefix: Padding(
          padding: EdgeInsets.all(4),
          child: Text('+251'),
        ),
      ),
    );
  }
}
