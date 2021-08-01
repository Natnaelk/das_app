import 'package:das_app/helper/keyboard.dart';
import 'package:das_app/screens/groups/groups_screen.dart';
import 'package:das_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:das_app/components/custom_surfix_icon.dart';
import 'package:das_app/components/default_button.dart';
import 'package:das_app/components/form_error.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CreateIdirForm extends StatefulWidget {
  static var routeName = '/createIdirForm';

  @override
  _CreateIdirFormState createState() => _CreateIdirFormState();
}

class _CreateIdirFormState extends State<CreateIdirForm> {
  TextEditingController bankAcccontroller = TextEditingController();
  TextEditingController poolAmountcontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController cyclecontroller = TextEditingController();
  TextEditingController Namecontroller = TextEditingController();
  TextEditingController startingDatecontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String Name;
  String startingDate;
  String address;
  String poolAmount;
  dynamic bankAccount;
  dynamic cycle;
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

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
    return Form(
      key: _formKey,
      child: Scaffold(
        body: ListView(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
          children: [
            SizedBox(height: SizeConfig.screenHeight * 0.04),
            Text(
              "Complete the form",
              style: headingStyle,
              textAlign: TextAlign.center,
            ),
            const Text(
              "Complete idir details",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: getProportionateScreenHeight(50)),
            buildNameFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            buildstartingDateFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            buildPoolAmountField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            buildAddressFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            FormError(errors: errors),
            SizedBox(height: getProportionateScreenHeight(40)),
            DefaultButton(
                text: "Continue",
                press: () async {
                  bool shouldNavigate = await signUp(
                    poolAmountcontroller.text,
                    bankAcccontroller.text,
                    Namecontroller.text,
                    startingDatecontroller.text,
                    poolAmountcontroller.text,
                    addresscontroller.text,
                  );
                  if (_formKey.currentState.validate() &&
                      shouldNavigate == true) {
                    _formKey.currentState.save();
                    KeyboardUtil.hideKeyboard(context);
                    Navigator.pushNamed(context, GroupsScreen.routeName);
                  } else {
                    print("Error occurd while signing in");
                  }
                }),
          ],
        ),
      ),
    );
  }

  TextFormField buildPoolAmountField() {
    return TextFormField(
      obscureText: true,
      controller: poolAmountcontroller,
      onSaved: (newValue) => poolAmount = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && poolAmount == poolAmount) {
          removeError(error: kMatchPassError);
        }
        poolAmount = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Pool Amount",
        hintText: "Amount of money pooled per member ",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
        onSaved: (newValue) => address = newValue,
        controller: addresscontroller,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kAddressNullError);
          }
          return null;
        },
        validator: (value) {
          if (value.isEmpty) {
            addError(error: kAddressNullError);
            return "";
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "Address",
          hintText: "Enter the address",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          //   suffixIcon:
          //       CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
        ));
  }

  TextFormField buildstartingDateFormField() {
    return TextFormField(
      onSaved: (newValue) => startingDate = newValue,
      controller: startingDatecontroller,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Starting Date",
        hintText: "Enter the starting date",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      controller: Namecontroller,
      onSaved: (newValue) => Name = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Name",
        hintText: "Enter the name of the Idir",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildCycleFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      controller: cyclecontroller,
      onSaved: (newValue) => cycle = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kCycleNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kCycleNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Cycle",
        hintText: "cycle eg weekly, monthly...",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildBankAccountField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: bankAcccontroller,
      onSaved: (newValue) => bankAccount = newValue,
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
      decoration: const InputDecoration(
        labelText: "Bank Account",
        hintText: "Enter your bank account number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
