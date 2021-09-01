import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/services/database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FBStorage {
  static FBStorage get instanace => FBStorage();

  // Save Image to Storage
  Future<List> saveUserImageToFirebaseStorage(
      iqubId, userId, userImageFile) async {
    try {
      String filePath = 'paymentImages/$userId';

      try {
        await FirebaseStorage.instance.ref(filePath).putFile(userImageFile);
        String imageURL =
            await FirebaseStorage.instance.ref(filePath).getDownloadURL();
        await DatabaseService(uid: userId)
            .savePaymentInfo(iqubId, userId, imageURL);
      } catch (e) {
        print('upload image exception, code is ${e.code}');
        // e.g, e.code == 'canceled'
      }
    } catch (e) {
      print(e.message);
    }
  }

  // Future<String> sendImageToUserInChatRoom(croppedFile, chatID) async {
  //   try {
  //     String imageTimeStamp = DateTime.now().millisecondsSinceEpoch.toString();
  //     String filePath = 'chatrooms/$chatID/$imageTimeStamp';

  //     try {
  //       await firebase_storage.FirebaseStorage.instance
  //           .ref(filePath)
  //           .putFile(croppedFile);
  //     } on firebase_core.FirebaseException catch (e) {
  //       print('upload image exception, code is ${e.code}');
  //       // e.g, e.code == 'canceled'
  //     }

  //     return await firebase_storage.FirebaseStorage.instance
  //         .ref(filePath)
  //         .getDownloadURL();
  //   } catch (e) {
  //     print(e.message);
  //   }
  // }
}
