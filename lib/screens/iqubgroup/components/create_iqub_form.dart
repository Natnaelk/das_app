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
  void _createIqub(
      BuildContext context,
      String iqubName,
      String poolAmount,
      DateTime startingDate,
      String bankAccount,
      String maxNoOfMembers,
      String address,
      String type) async {
    AuthModel _authStream = Provider.of<AuthModel>(context, listen: false);
    String currentUid = _authStream.uid;
    String result = await DatabaseService(uid: currentUid).createIqub(
        currentUid,
        iqubName,
        poolAmount,
        bankAccount,
        maxNoOfMembers,
        address,
        type);
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

  TextEditingController maxNoOfMemberscontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController poolAmountcontroller = TextEditingController();
  TextEditingController Namecontroller = TextEditingController();
  TextEditingController Typecontroller = TextEditingController();
  TextEditingController bankAccountcontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String Name;
  DateTime startingDate = DateTime.now();
  int maximumNoOfMembers;
  String address;
  var winAmount;
  String poolAmount;
  var bankAccount;
  String type;

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
            buildPoolAmountField(),
            SizedBox(height: (30)),
            buildNoOfMembersField(),
            SizedBox(height: (30)),
            buildAddressFormField(),
            SizedBox(height: (20)),
            buildBankAccountField(),
            SizedBox(height: (20)),
            buildTypeField(),
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
                    _createIqub(
                        context,
                        Namecontroller.text,
                        poolAmountcontroller.text,
                        startingDate,
                        bankAccountcontroller.text,
                        maxNoOfMemberscontroller.text,
                        addresscontroller.text,
                        Typecontroller.text);
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
      controller: poolAmountcontroller,
      onSaved: (newValue) => poolAmount = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPoolAmount);
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPoolAmount);
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

  TextFormField buildTypeField() {
    return TextFormField(
      controller: Typecontroller,
      onSaved: (newValue) => type = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPoolAmount);
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPoolAmount);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Iqub Type",
        hintText: " supported - Weekly, Monthly ",
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
        hintText: "Enter the name of the iqub",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
