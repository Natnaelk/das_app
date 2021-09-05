import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/services/database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FBStorage {
  static FBStorage get instanace => FBStorage();

  // Save Image to Storage
  Future<String> saveIqubPaymentImageToFirebaseStorage(
      iqubId, userId, userImageFile) async {
    String retVal = "waiting";
    try {
      String filePath = 'IqubpaymentImages/$userId';

      try {
        await FirebaseStorage.instance.ref(filePath).putFile(userImageFile);
        String imageURL =
            await FirebaseStorage.instance.ref(filePath).getDownloadURL();
        await DatabaseService(uid: userId)
            .saveIqubPaymentInfo(iqubId, userId, imageURL);
        retVal = "success";
      } catch (e) {
        retVal = "error";
        print('upload image exception, code is ${e.code}');
        // e.g, e.code == 'canceled'
      }
    } catch (e) {
      retVal = "error";
      print(e.message);
    }
    return retVal;
  }

  Future<String> saveIdirPaymentImageToFirebaseStorage(
      idirId, userId, userImageFile) async {
    String retVal = "waiting";
    try {
      String filePath = 'IdirpaymentImages/$userId';

      try {
        await FirebaseStorage.instance.ref(filePath).putFile(userImageFile);
        String imageURL =
            await FirebaseStorage.instance.ref(filePath).getDownloadURL();
        await DatabaseService(uid: userId)
            .saveIdirPaymentInfo(idirId, userId, imageURL);
        retVal = "success";
      } catch (e) {
        retVal = "error";
        print('upload image exception, code is ${e.code}');
        // e.g, e.code == 'canceled'
      }
    } catch (e) {
      retVal = "error";
      print(e.message);
    }
    return retVal;
  }
}
