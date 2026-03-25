import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final String type;
  final String category;
  final String note;
  final double amount;
  final DateTime? createdAt;

  TransactionModel({
    required this.id,
    required this.type,
    required this.category,
    required this.note,
    required this.amount,
    this.createdAt,
  });

  factory TransactionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?; 

    // This helper function handles if 'amount' is an int, double, or String
    double parseAmount(dynamic value) {
      if (value == null) return 0.0;
      if (value is num) return value.toDouble(); // Handles int and double
      if (value is String) return double.tryParse(value) ?? 0.0; // Handles Strings
      return 0.0;
    }

    return TransactionModel(
      id: doc.id,
      type: data?['type'] ?? '',
      category: data?['category'] ?? '',
      note: data?['note'] ?? '',
      amount: parseAmount(data?['amount']), // Using the helper here
      createdAt: (data?['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'type': type,
      'category': category,
      'note': note,
      'amount': amount, 
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }
}