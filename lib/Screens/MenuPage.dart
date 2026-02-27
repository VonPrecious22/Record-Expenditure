import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recordexpenditure/Screens/TransactionsDetatils.dart';

class Menupage extends StatefulWidget {
  const Menupage({super.key});

  @override
  State<Menupage> createState() => _MenupageState();
}

class _MenupageState extends State<Menupage> {
  // //Controllers
  // final TextEditingController NoteController = TextEditingController();
  // final TextEditingController AmountController = TextEditingController()

// Add users details
   Future addUserDetails(String Type, String Note, int Amount ) async{
    await FirebaseFirestore.instance.collection('user').add({
      'Type': 'Type',
      'Note': 'Note',
      'Amount': 'Amount',
      
          });
   }
  

  List<Map<String, dynamic>> transactions = [];

  double get totalIncome {
    // Sum of all positive transactions (Income)
    double total = 0;
    for (var tx in transactions) {
      if (tx['amount'] > 0) total += tx['amount'];
    }
    return total;
  }

  double get totalExpenses {
    // Sum of all negative transactions (Expenses)
    double total = 0;
    for (var tx in transactions) {
      if (tx['amount'] < 0) total += -tx['amount'];
    }
    return total;
  }

  double get netBalance => totalIncome - totalExpenses;
  String? selectedItem;
  String ? selectedList;
  final List < String > cashInCategories =[
    'Training Program Fee',
    'Consultation Fee',
    'Software Developement Payment',
    'Website Developement Payment',
    'Mobile App Developement Payment',
    'Digital Marketing Service Fee',
    'Maintainance/Support Fee'
  ];
  final List < String > cashOutCategories = [
    'Office Rent',
    'Internet Subscription',
    'Electricity Bill',
    'Water Bill',
    'Office Cleaning',
    'Salaries',
    'Intern Stipend',
    'Freelance Payment',
    'Bonuses',
    'Staff Welfare',
    'Staff Training'
  ];
    DateTime selectedDate = DateTime.now();
                bool isIncome = false;
                  bool isCashin = false;
                    bool isCashout = false; 

  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;
    final TextEditingController descriptionController =
                    TextEditingController();
    final TextEditingController amountController =
                    TextEditingController();
    return Scaffold(
      backgroundColor: const Color(0xFF0F3B63),
    
      floatingActionButton: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          
          shape: BoxShape.circle
        ),
        child: FloatingActionButton(
          backgroundColor: const Color(0xFF1DA0C1),
          child: const Icon(Icons.add, color: Colors.white),
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: Colors.white,
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
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
                                fontWeight: FontWeight.bold),
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
                            
                            dropdownColor: Colors.white,
                            hint: Text('Cash In'),
                            value: selectedList,          
                            items: cashInCategories.map((Element) => DropdownMenuItem(
                              
                              value: Element,
                              child: Text(Element),
                            
                            ))
                            .toList(),
                            onChanged: (value){
                              setState(() {
                                selectedList = value;
                              },);
                            }),
                            if(!isIncome)
                            DropdownButtonFormField<String>(
                              dropdownColor: Colors.white,
                              hint: Text('Cash out'),
                              value: selectedItem,
                              
                              items: cashOutCategories.map((e)=> DropdownMenuItem(
                                value: e,
                                child: Text(e),)).toList(), onChanged: (value){
                                  setState(() {
                                    selectedItem = value;
                                  },);
                                }),
                         
                       SizedBox(height: 30,),
                          TextField(
                            keyboardType: TextInputType.text,
                            controller: descriptionController,
                            decoration:  InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color:const Color(0xFF05406F), )
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: const Color(0xFF05406F),)
                              ),
                              labelText: "Note",labelStyle: TextStyle(fontStyle: FontStyle.italic, color: Colors.black),
                              hint: Text('Enter Note',style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black),),
                              border: OutlineInputBorder(
                                
                              ),
                            ),
                          ),
            
                          const SizedBox(height: 15),
            
                          TextFormField(
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            decoration:  InputDecoration(
                               enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color:const Color(0xFF05406F,
                              ),
                                
                                 )
                              ),
                              focusedBorder: OutlineInputBorder(
                                
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: const Color(0xFF05406F),)
                              ),
                              labelText: "Amount",labelStyle: TextStyle(fontStyle: FontStyle.italic,color: Colors.black),
                              hintText: 'Enter Amount',hintStyle: TextStyle(fontStyle: FontStyle.italic,color: Colors.black),
                              
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
                            onPressed: () {
                              String description = descriptionController.text;
                              double amount =
                                  double.tryParse(amountController.text) ?? 0;
            
                              if (description.isEmpty || amount <= 0) return;
            
                              setState(() {
                                transactions.add({
                                  'description': description,
                                  'amount': isIncome ? amount : -amount,
                                  'date': selectedDate,
                                  'type': isIncome ? "Income" : "Expense",
                                  'category': isIncome ? selectedList : selectedItem,
                                });
                              });
            
                              Navigator.pop(context);
                            },
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
              decoration: const BoxDecoration(
                color: Color(0xFF0F3B63),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
    
                  const SizedBox(height: 20),
    
                  const Text(
                    "Traitz Expenses",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
    
                  const SizedBox(height: 40),
    
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          "TOTAL BALANCE",
                          style: TextStyle(
                              color: Colors.white70,
                              letterSpacing: 1),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "${netBalance.toStringAsFixed(0)} FCFA",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 38,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                         Text(
                          "${DateTime.now().toIso8601String().split('T').first}",
                          style: TextStyle(
                              color: Colors.white60),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
    
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 110,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
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
                              const Text('Income'),
                              const SizedBox(height: 6),
                              Text('${totalIncome.toStringAsFixed(0)} FCFA',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green)),
                            ],
                          ),
                        ),
    
                        // Expenses
                        Container(
                          width: 110,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
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
                              const Text('Expenses'),
                              const SizedBox(height: 6),
                              Text('${totalExpenses.toStringAsFixed(0)} FCFA',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red)),
                            ],
                          ),
                        ),
    
                        // Net
                        Container(
                          width: 110,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
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
                              const Text('Net'),
                              const SizedBox(height: 6),
                              Text('${netBalance.toStringAsFixed(0)} FCFA',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue)),
                            ],
                          ),
                        ),
                      ],
                    ),
    
                    const SizedBox(height: 20),
    
                    const Text(
                      "RECENT TRANSACTIONS",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
    
                    const SizedBox(height: 15),
    
                    // Transaction list
                    Expanded(
                      child: transactions.isEmpty
                          ? const Center(
                              child: Text(
                                "No transactions yet",
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          : ListView.builder(
                              itemCount: transactions.length,
                              itemBuilder: (context, index) {
                                final tx = transactions[index];
    
                                return GestureDetector(
                                  onTap: () {
                                    final note = tx['description'];
                                    final amount = tx['amount'].toString();
                                    final date = tx['date'];
                                    final type = tx['type'];
                                    final Category = tx['category'];
                                    print(' this is the note $amount');
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Transactionsdetatils(
                                       Note: note, 
                                       amount: amount,
                                        date: date,
                                        type: type,
                                        Category: Category,
                                        
                                        )));
                                  },
                                  child: Card(
                                    elevation: 4,
                                    margin: const EdgeInsets.symmetric(vertical: 6),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Container(
                                      color: Colors.white,
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: tx['amount'] < 0
                                              ? Colors.red.shade100
                                              : Colors.green.shade100,
                                          child: Icon(
                                            tx['amount'] < 0
                                                ? Icons.arrow_upward
                                                : Icons.arrow_downward,
                                            color: tx['amount'] < 0
                                                ? Colors.red
                                                : Colors.green,
                                                
                                          ),
                                        ),
                                        title: Text(
                                          
                                          tx['description'],
                                          style: const TextStyle(
                                          
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        subtitle: Text(
                                          "${tx['date'].day}/${tx['date'].month}/${tx['date'].year}",
                                        ),
                                        trailing: Text(
                                          "${tx['amount'] < 0 ? '-' : '+'} ${tx['amount'].abs().toStringAsFixed(0)} FCFA",
                                          style: TextStyle(
                                            color: tx['amount'] < 0
                                                ? Colors.red
                                                : Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}