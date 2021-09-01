import 'dart:io';

import 'package:das_app/constants.dart';
import 'package:das_app/models/auth_model.dart';
import 'package:das_app/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

class UserImagePicker extends StatefulWidget {
  String iqubid;
  UserImagePicker({this.iqubid});

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
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
              : Text('add receipt'),

          // CircleAvatar(
          //   radius: 100,
          //   backgroundImage:
          //       _pickedImage != null ? FileImage(_pickedImage) : null,
          // ),
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
                          icon: Icon(
                            Icons.send,
                            color: kPrimaryColor,
                          ),
                          onPressed: () {
                            _saveUserImageToFirebaseStorage(
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

  Future<void> _saveUserImageToFirebaseStorage(
      BuildContext context, croppedFile) async {
    AuthModel _authStream = Provider.of<AuthModel>(context, listen: false);
    String currentUid = _authStream.uid;
    try {
      await FBStorage.instanace.saveUserImageToFirebaseStorage(
          widget.iqubid, currentUid, croppedFile);
      Navigator.of(context).pop();
    } catch (e) {
      print('Error add user image to storage');
    }
  }
}
