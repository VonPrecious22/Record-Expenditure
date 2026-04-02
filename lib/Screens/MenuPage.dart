import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recordexpenditure/Screens/Color.dart'; 
import 'package:recordexpenditure/Screens/FireBaseServices.dart';
import 'package:recordexpenditure/Screens/TransactionsDetatils.dart';
import 'package:recordexpenditure/Screens/transactionmodel.dart';

class Menupage extends StatefulWidget {
  const Menupage({super.key});

  @override
  State<Menupage> createState() => _MenupageState();
}

class _MenupageState extends State<Menupage> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final Firebaseservices Services = Firebaseservices();
  final FirebaseAuth name = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  void SaveTransaction() async {
    if (_formKey.currentState!.validate()) {
      double amount = double.tryParse(amountController.text) ?? 0.0;
      try {
        await Services.saveTransaction(
        note: descriptionController.text.trim(),
        amount: isIncome ? amount : amount,
        type: isIncome ? "Income" : "Expense",
        category: isIncome ? selectedList ?? "" : selectedItem ?? "",
        createdAt: selectedDate,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Transaction Added"),
          backgroundColor: CustomColor.primaryColor,
        ),
      );
      descriptionController.clear();
      amountController.clear();
      setState(() {
        selectedItem = null;
        selectedList = null;
      });
      setState(() {
        selectedDate = DateTime.now();
      });
      Navigator.pop(context);
    } 
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        
        SnackBar(content: AnimatedContainer(
        
        duration: Duration(microseconds: 2,),
        
        child: Text('Your\'re are offline. Transaction not saved.'))));
        Navigator.pop(context);
    }
    }
  
  }

  final List<String> cashInCategories = [
    'Training Program Fee',
    'Consultation Fee',
    'Software Developement Payment',
    'Website Developement Payment',
    'Mobile App Developement Payment',
    'Digital Marketing Service Fee',
    'Maintainance/Support Fee',
  ];

  final List<String> cashOutCategories = [
    'Office Rent',
    'Internet Subscription',
    'Electricity Bill',
    'Fuel Bill',
    'Water Bill',
    'Office Cleaning',
    'Salaries',
    'Intern Stipend',
    'Freelance Payment',
    'Bonuses',
    'Staff Welfare',
    'Staff Training',
  ];

  DateTime selectedDate = DateTime.now();
  String? selectedItem;
  String? selectedList;
  bool isIncome = false;
  bool isCashin = false;
  bool isCashout = false;

  @override
  // void dispose() {
  //   super.dispose();
  //   descriptionController.dispose();
  //   amountController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
 final screenWidth  = MediaQuery.sizeOf(context).width;
  final screenHeight = MediaQuery.sizeOf(context).height;
  final orientation  = MediaQuery.of(context).orientation;
  final paddingBottom = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      backgroundColor: const Color(0xFF0F3B63),
      floatingActionButton: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: FloatingActionButton(
          backgroundColor: const Color(0xFF1DA0C1),
          child: const Icon(Icons.add, color: Colors.white),
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: Colors.white,
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (context) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: 16,
                    right: 16,
                    top: 20,
                  ),
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Add Transaction",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Text("Type: "),
                              const SizedBox(width: 10),
                              DropdownButton<bool>(
                                value: isIncome,
                                dropdownColor: Colors.white,
                                items: const [
                                  DropdownMenuItem(
                                    value: false,
                                    child: Text("Expense"),
                                  ),
                                  DropdownMenuItem(
                                    value: true,
                                    child: Text("Income"),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    isIncome = value ?? false;
                                    selectedItem = null;
                                  });
                                },
                              ),
                            ],
                          ),
                          if (isIncome)
                            DropdownButtonFormField<String>(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please select a category ";
                                }
                                return null;
                              },
                              dropdownColor: Colors.white,
                              hint: Text('Cash In'),
                              initialValue: selectedList,
                              items: cashInCategories
                                  .map(
                                    (element) => DropdownMenuItem(
                                      value: element,
                                      child: Text(element),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedList = value;
                                });
                              },
                            ),
                          if (!isIncome)
                            DropdownButtonFormField<String>(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "select a category";
                                }
                                return null;
                              },
                              dropdownColor: Colors.white,
                              hint: Text('Cash out'),
                              initialValue: selectedItem,
                              items: cashOutCategories
                                  .map(
                                    (e) => DropdownMenuItem(
                                      
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedItem = value;
                                });
                              },
                            ),
                          SizedBox(height: 30),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "Note is required";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                  controller: descriptionController,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: const Color(0xFF05406F),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: const Color(0xFF05406F),
                                      ),
                                    ),
                                    labelText: "Note",
                                    labelStyle: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black,
                                    ),
                                    hint: Text(
                                      'Enter Note',
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.black,
                                      ),
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "Amount is required";
                                    }
                                    if (double.tryParse(value) == null) {
                                      return "Enter a valid number";
                                    }
                                    return null;
                                  },
                                  controller: amountController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: const Color(0xFF05406F),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: const Color(0xFF05406F),
                                      ),
                                    ),
                                    labelText: "Amount",
                                    labelStyle: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black,
                                    ),
                                    hintText: 'Enter Amount',
                                    hintStyle: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          // Income / Expense selector
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                              ),
                              TextButton(
                                onPressed: () async {
                                  final pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: selectedDate,
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime.now(),
                                  );
                                  if (pickedDate != null) {
                                    setState(() {
                                      selectedDate = pickedDate;
                                    });
                                  }
                                },
                                child: const Text("Select Date"),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1DA0C1),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            onPressed: SaveTransaction,
                            child: const Text("Save Transaction"),
                          ),
                          const SizedBox(height: 20),
                        ],
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // TOP BLUE SECTION
            Container(
              height: 280,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(color: Color(0xFF0F3B63)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Traitz Expenses",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          "TOTAL BALANCE",
                          style: TextStyle(
                            color: Colors.white70,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "FCFA",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          DateTime.now().toIso8601String().split('T').first,
                          style: TextStyle(color: Colors.white60),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // WHITE SECTION
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('UsersTransactions')
                      .doc(FirebaseAuth.instance.currentUser?.uid)
                      .collection('transactions')
                      .orderBy('createdAt', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Error loading transactions"),
                      );
                    }

                    // // ── Improved: show white background + message during long wait ──
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 24),
                            Text(
                              "Loading transactions...",
                              style: TextStyle(fontSize: 16),
                            ),
                          
                          ],
                        ),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text("No transactions yet"));
                    }

                    // 🔥 CALCULATIONS
                    double totalIncome = 0;
                    double totalExpense = 0;
                    for (var doc in snapshot.data!.docs) {
                      double amount = (doc['amount'] ?? 0.0).toDouble();
                      String type = doc['type'];
                      if (type == 'Income') {
                        totalIncome += amount;
                      } else {
                        totalExpense += amount;
                      }
                    }
                    double balance = totalIncome - totalExpense;

                    final transactions = snapshot.data!.docs
                        .map((doc) => TransactionModel.fromFirestore(doc))
                        .toList();

                    return Column(
                      children: [
                        const SizedBox(height: 20),
                        // 🔥 SUMMARY CARDS
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildCard("Income", totalIncome, Colors.green),
                            _buildCard("Expenses", totalExpense, Colors.red),
                            _buildCard("Net", balance, Colors.blue),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "RECENT TRANSACTIONS",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // 🔥 LIST
                        Expanded(
                          child: ListView.builder(
                            itemCount: transactions.length,
                            itemBuilder: (context, index) {
                              final Transaction = transactions[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TransactionsDetails(
                                    note: Transaction.note,
                                        amount: Transaction.amount.toString(),
                                        date: DateTime.now(),
                                        type: Transaction.type,
                                        category: Transaction.category,
                                        transactionId: Transaction.id,
                                    )));
                                },
                                child: Card(
                                  color: Colors.white,
                                  elevation: 4,
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 6,
                                    horizontal: 8,
                                  ),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Transaction.type == "Income"
                                          ? Colors.green
                                          : Colors.red,
                                      child: Icon(
                                        Transaction.type == 'Income'
                                            ? Icons.arrow_upward
                                            : Icons.arrow_downward,
                                      ),
                                    ),
                                    title: Text(
                                      Transaction.note,
                                       maxLines: 1, 
                                       overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "${Transaction.createdAt?.day}/${Transaction.createdAt?.month}/${Transaction.createdAt?.year}",
                                    ),
                                    trailing: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${Transaction.amount} FCFA",
                                          style: TextStyle(
                                            color: Transaction.type == "Income"
                                                ? Colors.green
                                                : Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        GestureDetector(
                                          onTap: () async {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text('Delete'),
                                                  content: Text(
                                                    'Are you sure you want to delete this transaction?',
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context,);
                                                      },
                                                      child: Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        await Firebaseservices()
                                                            .deleteTransaction(
                                                          Transaction.id,
                                                        );
                                                        ScaffoldMessenger.of(
                                                          context,
                                                        ).showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              'Transaction Deleted',
                                                            ),
                                                            backgroundColor: CustomColor.primaryColor,
                                                          ),
                                                        );
                                                        Navigator.pop(context,);
                                                      },
                                                      child: Text(
                                                        'Delete',
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, double amount, Color color) {
    return Container(
      width: 110,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 3),
            spreadRadius: 1,
            color: Colors.black12,
            blurRadius: 3,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
          const SizedBox(height: 6),
          Text(
            "${amount.toStringAsFixed(0)} FCFA",
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }
}