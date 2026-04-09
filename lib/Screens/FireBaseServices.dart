import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Firebaseservices {
  static final Firebaseservices _instance = Firebaseservices._internal();
  factory Firebaseservices() => _instance;
  Firebaseservices._internal();
  final String collection = 'UsersTransactions';

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

 Future<void> saveTransaction({
  required String type,
  required String category,
  required String note,
  required double amount,
  required DateTime createdAt,
}) async {
  try{
    final user = firebaseAuth.currentUser;
  if (user == null) throw Exception('User not logged in');

  // Important: go to subcollection!
  final transactionsRef = firebaseFirestore
      .collection('UsersTransactions')
      .doc(user.uid)
      .collection('transactions');

  // Let Firestore auto-generate document ID
  await transactionsRef.add({
    'note': note.trim(),
    'amount': amount,
    'type': type,
    'category': category,
    'createdAt': FieldValue.serverTimestamp(), // optional but useful
  }
  
  );
  }catch(e){
    throw Exception("Firestore error");
  }
}
 Future<void> updateTransaction({
  required String transactionId,
  required String type,
  required String category,
  required String note,
  required double amount
 }) async {
  final user = firebaseAuth.currentUser;
  if (user == null)  throw Exception('User not logged in');
  try{
    await firebaseFirestore
    .collection('UsersTransactions')
    .doc(user.uid)
    .collection('transactions')
    .doc(transactionId)
    .update({
      'type': type,
      'category':category,
      'note': note,
      'amount': amount,

    });
  }
  catch(e){
    throw Exception('Failled to update transaction: $e');
  }
 }
 Future<void> deleteTransaction(String transactionId) async {
  final userId = FirebaseAuth.instance.currentUser!.uid;

try {
    await FirebaseFirestore.instance
      .collection('UsersTransactions')
      .doc(userId)
      .collection('transactions')
      .doc(transactionId)
      .delete();
} catch (e){
  print(e);
}
}
Future<void> UpdateProfile({
  required String Name,
  required String email,
  required String number,
}) async {
 try{
   String user = FirebaseAuth.instance.currentUser!.uid;
   await FirebaseFirestore.instance.
   collection('User').
   doc(user)
   .update({
    'Name': Name,
    'Email': email,
    'phone': number
   });
 } catch(e){
  throw Exception('Failed to updated detaills!! $e');
 }
}
 
 }

