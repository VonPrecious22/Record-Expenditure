// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recordexpenditure/Screens/Color.dart';
import 'package:recordexpenditure/Screens/CustomWidget.dart';
import 'package:recordexpenditure/Screens/FireBaseServices.dart';

class TransactionsDetails extends StatefulWidget {
  final String note;
  final String amount;
  final DateTime date;
  final String type;
  final String category;
  final String transactionId;

  const TransactionsDetails({
    super.key,
    required this.note,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
    required this.transactionId,
  });

  @override
  State<TransactionsDetails> createState() => _TransactionsDetailsState();
}

class _TransactionsDetailsState extends State<TransactionsDetails> {
  // Define controllers
  late final TextEditingController typeController = TextEditingController(text: widget.type);
  late final TextEditingController categoryController = TextEditingController(text: widget.category);
  late final TextEditingController noteController = TextEditingController(text: widget.note);
  late final TextEditingController amountController =TextEditingController(text: widget.amount);

  // @override
  // void initState() {
  //   super.initState();
  //   // Initialize controllers with the passed widget values
  //   typeController = TextEditingController(text: widget.type);
  //   categoryController = TextEditingController(text: widget.category);
  //   noteController = TextEditingController(text: widget.note);
  //   amountController = TextEditingController(text: widget.amount);
  // }

  @override
  void dispose() {
    typeController.dispose();
    categoryController.dispose();
    noteController.dispose();
    amountController.dispose();
    super.dispose();
  }

  Future<void> editTransaction() async {
    final firebaseservices = Firebaseservices();
    try {
      await firebaseservices.updateTransaction(
        transactionId: widget.transactionId,
        type: typeController.text.trim(),
        note: noteController.text.trim(),
        category: categoryController.text.trim(),
        amount: double.tryParse(amountController.text) ?? 0.0,
      );
    } catch (e) {
      print("Error occur while updating the transactions$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
          child: ListView(
            children: [
              // --- TYPE FIELD ---
              const Text(
                'Type',
                style: TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: typeController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: CustomColor.primaryColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: CustomColor.primaryColor),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),

              const SizedBox(height: 14),

              // --- CATEGORY FIELD ---
              const Text(
                'Category',
                style: TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: categoryController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: CustomColor.primaryColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: CustomColor.primaryColor),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),

              const SizedBox(height: 14),

              // --- NOTE FIELD ---
              const Text(
                'Note',
                style: TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: noteController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: CustomColor.primaryColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: CustomColor.primaryColor),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),

              const SizedBox(height: 14),

              // --- AMOUNT FIELD ---
              const Text(
                'Amount',
                style: TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: CustomColor.primaryColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: CustomColor.primaryColor),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),

              const SizedBox(height: 14),

              // --- DATE DISPLAY ---
              const Text(
                'Date',
                style: TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1, color: CustomColor.primaryColor),
                  color: Colors.white,
                ),
                child: ListTile(
                  title: Text(
                    widget.date.toIso8601String().split('T').first,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 70),

              // --- UPDATE BUTTON ---
              CustomButton(
                text: 'Update',
                ontap: () async {
                  try {
                    await editTransaction();
                    if (mounted) {
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Transaction Updated Successfully!'),
                        backgroundColor: CustomColor.primaryColor,),
                      );
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failled to update transaction'),
                        backgroundColor: CustomColor.primaryColor,),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}