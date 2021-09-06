import 'package:das_app/helper/keyboard.dart';
import 'package:das_app/models/auth_model.dart';
import 'package:das_app/screens/groups/groups_screen.dart';
import 'package:das_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:das_app/components/default_button.dart';
import 'package:das_app/components/form_error.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';

class CreateIdirForm extends StatefulWidget {
  static var routeName = '/createIdirForm';

  @override
  _CreateIdirFormState createState() => _CreateIdirFormState();
}

class _CreateIdirFormState extends State<CreateIdirForm> {
  void _createIdir(
    BuildContext context,
    String idirName,
    String poolAmount,
    String bankAccount,
    String maxNoOfMembers,
    String address,
  ) async {
    try {
      AuthModel _authStream = Provider.of<AuthModel>(context, listen: false);
      String currentUid = _authStream.uid;
      await DatabaseService().createIdir(
        currentUid,
        idirName,
        poolAmount,
        bankAccount,
        maxNoOfMembers,
        address,
      );
      if (currentUid.isNotEmpty) {
        Navigator.pushNamed(context, GroupsScreen.routeName);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: kPrimaryColor,
          content: Text("Idir created successfully"),
          duration: Duration(seconds: 2),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: kPrimaryColor,
          content: Text("error"),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      print(e);
    }
  }

  TextEditingController maxNoOfMemberscontroller = TextEditingController();
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
  var maxNoOfMembers;
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
              "Complete Idir details",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: (50)),
            buildNameFormField(),
            SizedBox(height: (30)),
            buildPoolAmountField(),
            SizedBox(height: (30)),
            buildAddressFormField(),
            SizedBox(height: (20)),
            buildNoOfMembersField(),
            SizedBox(height: (20)),
            buildBankAccountField(),
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
                    _createIdir(
                      context,
                      Namecontroller.text,
                      poolAmountcontroller.text,
                      bankAccountcontroller.text,
                      maxNoOfMemberscontroller.text,
                      addresscontroller.text,
                    );
                  } else {
                    print("Error occurd while creating Idir");
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

  TextFormField buildNoOfMembersField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: maxNoOfMemberscontroller,
      onSaved: (newValue) => winAmount = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kMaxNoOfMem);

          return null;
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kMaxNoOfMem);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Maximum No of members allowed",
        hintText: "Enter ",
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
          removeError(error: kBankAccount);
          return null;
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kBankAccount);
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
      ),
    );
  }
}
