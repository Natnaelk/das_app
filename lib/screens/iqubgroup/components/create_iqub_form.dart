import 'package:das_app/helper/keyboard.dart';
import 'package:das_app/models/auth_model.dart';
import 'package:das_app/screens/groups/groups_screen.dart';
import 'package:das_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:das_app/components/default_button.dart';
import 'package:das_app/components/form_error.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class CreateIqubForm extends StatefulWidget {
  static var routeName = '/createIqubForm';

  @override
  _CreateIqubFormState createState() => _CreateIqubFormState();
}

class _CreateIqubFormState extends State<CreateIqubForm> {
  void _createIqub(BuildContext context, String iqubName) async {
    AuthModel _authStream = Provider.of<AuthModel>(context, listen: false);
    String currentUid = _authStream.uid;
    String result =
        await DatabaseService(uid: currentUid).createIqub(currentUid, iqubName);
    if (currentUid.isNotEmpty) {
      Navigator.pushNamed(context, GroupsScreen.routeName);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: kPrimaryColor,
        content: Text("Iqub created successfully"),
        duration: Duration(seconds: 2),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: kPrimaryColor,
        content: Text("error occured please try again"),
        duration: Duration(seconds: 2),
      ));
    }
  }

  TextEditingController cyclecontroller = TextEditingController();
  TextEditingController winAmountcontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController poolAmountcontroller = TextEditingController();
  TextEditingController Namecontroller = TextEditingController();
  TextEditingController startingDatecontroller = TextEditingController();
  TextEditingController bankAccountcontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String Name;
  String startingDate;
  var Cycle;
  String address;
  var winAmount;
  String poolAmount;
  var bankAccount;

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
          padding: EdgeInsets.symmetric(horizontal: (10)),
          children: [
            SizedBox(height: 60),
            Text(
              "Complete the form",
              style: headingStyle,
              textAlign: TextAlign.center,
            ),
            const Text(
              "Complete iqub details",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: (50)),
            buildNameFormField(),
            SizedBox(height: (30)),
            buildstartingDateFormField(),
            SizedBox(height: (30)),
            buildPoolAmountField(),
            SizedBox(height: (30)),
            buildWinAmountField(),
            SizedBox(height: (30)),
            buildCycleFormField(),
            SizedBox(height: (30)),
            buildAddressFormField(),
            SizedBox(height: (20)),
            FormError(errors: errors),
            SizedBox(height: (20)),
            DefaultButton(
                text: "Continue",
                press: () {
                  // (
                  //   cyclecontroller.text,
                  //   bankAccountcontroller.text,
                  //   Namecontroller.text,
                  //   startingDatecontroller.text,
                  //   poolAmountcontroller.text,
                  //   addresscontroller.text,
                  //   winAmountcontroller.text
                  // );
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    KeyboardUtil.hideKeyboard(context);
                    _createIqub(context, Namecontroller.text);
                  } else {
                    print("Error occurd while creating iqub");
                  }
                }),
            SizedBox(height: (40)),
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
        hintText: "Amount of money pooled per cycle",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildWinAmountField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: winAmountcontroller,
      onSaved: (newValue) => winAmount = newValue,
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
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildBankAccountField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: bankAccountcontroller,
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
          hintText: "Enter your address",
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ));
  }

  TextFormField buildCycleFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      controller: cyclecontroller,
      onSaved: (newValue) => Cycle = newValue,
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
        labelText: "Starting date",
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
        hintText: "Enter the name of the iqub",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
