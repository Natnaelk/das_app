import 'dart:io';

import 'package:das_app/constants.dart';
import 'package:das_app/models/auth_model.dart';
import 'package:das_app/screens/idirgroup/roles/member/components/payment_page.dart';
import 'package:das_app/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

class IdirUserImagePicker extends StatefulWidget {
  String idirid;
  IdirUserImagePicker({this.idirid});

  @override
  _IdirUserImagePickerState createState() => _IdirUserImagePickerState();
}

class _IdirUserImagePickerState extends State<IdirUserImagePicker> {
  File _pickedImage;

  void _pickImageGallery() async {
    final pickedImageFile =
        await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _pickedImage = pickedImageFile;
    });
  }

  void _pickImageCamera() async {
    final pickedImageFile =
        await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _pickedImage = pickedImageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _pickedImage != null
              ? SizedBox(
                  height: 400,
                  width: 400,
                  child: _pickedImage != null
                      ? PhotoView(
                          imageProvider: FileImage(_pickedImage),
                          loadingBuilder: (BuildContext context, event) {
                            return Center(child: CircularProgressIndicator());
                          },
                        )
                      : null,
                )
              : Text(
                  'Add receipt',
                  style: TextStyle(fontSize: 20, color: kSecondaryColor),
                ),
          Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                            iconSize: 40,
                            icon: Icon(
                              Icons.photo,
                              color: Colors.cyan[900],
                            ),
                            onPressed: () {
                              _pickImageGallery();
                            }),
                      ]),
                  SizedBox(width: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                            iconSize: 40,
                            icon: Icon(
                              Icons.photo_camera,
                              color: Colors.cyan[900],
                            ),
                            onPressed: () {
                              _pickImageCamera();
                            }),
                      ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                          iconSize: 40,
                          icon: const Icon(
                            Icons.send,
                            color: kPrimaryColor,
                          ),
                          onPressed: () {
                            _saveIdirPaymentImageToFirebaseStorage(
                                context, _pickedImage);
                          }),
                    ],
                  )
                ]),
          ),
        ],
      ),
    );
  }

  void _saveIdirPaymentImageToFirebaseStorage(
      BuildContext context, croppedFile) async {
    AuthModel _authStream = Provider.of<AuthModel>(context, listen: false);
    String currentUid = _authStream.uid;
    try {
      String result = await FBStorage.instanace
          .saveIdirPaymentImageToFirebaseStorage(
              widget.idirid, currentUid, croppedFile);
      if (result == null) {
        CircularProgress();

        const Center(child: Text('Loading'));
      }
      if (result == "success") {
        showAlertDialog(context);
      } else {
        CircularProgress();
      }
    } catch (e) {
      print('Error add user image to storage');
    }
  }

  Widget CircularProgress() {
    return Container(
      child: const CircularProgressIndicator(),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget continueButton = TextButton(
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) =>
                  IdirMemberpaymentPage(idirId: widget.idirid)));
        },
        child: const Text("Ok"));

    AlertDialog alert = AlertDialog(
      title: const Text("Proof of Payment"),
      content: const Text("Receipt sent to admin"),
      actions: [continueButton],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
