import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<DocumentSnapshot<Map<String, dynamic>>> getCurrentUserDocument() async {
  String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  final userDocumentCheck = await FirebaseFirestore.instance
      .collection('users')
      .where('userId', isEqualTo: userId)
      .get();
  if (userDocumentCheck.docs.isNotEmpty) {
    // Assuming 'userId' is unique, retrieve the first matching document
    return userDocumentCheck.docs.first;
  } else {
    // Handle the case when the document is not found
    return FirebaseFirestore.instance.doc('users/NonExistentDocId').get();
  }
}

// //fulname and username derived from here
Future<Map<String, String>> getUserDetails() async {
  try {
    DocumentSnapshot<Map<String, dynamic>> userDocument =
        await getCurrentUserDocument();

    if (userDocument.exists) {
      String fullname = userDocument.data()?['fullname'];
      String username = userDocument.data()?['username'];
      // Now you can use fullname and username as needed
      return {'fullname': fullname, 'username': username};
    } else {
      String fullname = 'deafult name';
      String username = 'default username';
      return {'fullname': fullname, 'username': username};
    }
  } catch (e) {
    print('Error fetching user details: $e');
  }
  return {};
}
