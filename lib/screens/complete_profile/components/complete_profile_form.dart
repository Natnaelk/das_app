// import 'package:flutter/material.dart';
// import 'package:das_app/components/custom_surfix_icon.dart';
// import 'package:das_app/components/default_button.dart';
// import 'package:das_app/components/form_error.dart';
// import 'package:das_app/screens/otp/otp_screen.dart';

// import '../../../constants.dart';
// import '../../../size_config.dart';

// class CompleteProfileForm extends StatefulWidget {
//   @override
//   _CompleteProfileFormState createState() => _CompleteProfileFormState();
// }

// class _CompleteProfileFormState extends State<CompleteProfileForm> {
//   final _formKey = GlobalKey<FormState>();
//   final List<String> errors = [];

//   void addError({String error}) {
//     if (!errors.contains(error))
//       setState(() {
//         errors.add(error);
//       });
//   }

//   void removeError({String error}) {
//     if (errors.contains(error))
//       setState(() {
//         errors.remove(error);
//       });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           buildFirstNameFormField(),
//           SizedBox(height: getProportionateScreenHeight(30)),
//           buildLastNameFormField(),
//           SizedBox(height: getProportionateScreenHeight(30)),
//           buildPhoneNumberFormField(),
//           SizedBox(height: getProportionateScreenHeight(30)),
//           buildAddressFormField(),
//           FormError(errors: errors),
//           SizedBox(height: getProportionateScreenHeight(40)),
//           DefaultButton(
//             text: "continue",
//             press: () {
//               if (_formKey.currentState.validate()) {
                
//                 Navigator.pushNamed(context, OtpScreen.routeName);
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }

  
// }
