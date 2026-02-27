class TransactionsDetails{
  final String type;
  final String Category;
  final String Note;
  final String Amount;
  final DateTime date;


TransactionsDetails({
required this.type,
required this.Category, 
required this.Note,
required this.Amount,
required this.date

});
TransactionsDetails copyWith({
String? type,
String? Category,
String? Note,
String? Amount,
DateTime? date
}){
  return TransactionsDetails(
    type: type?? this.type, 
    Category: Category ?? this.Category, 
    Note: Note ?? this.Note, 
    Amount: Amount ?? this.Amount, 
    date: date ?? this.date
    );

}
factory TransactionsDetails.fromMap(Map<String, dynamic> map){
  return TransactionsDetails(
    type: map['type'], 
    Category: map['category'], 
    Note: map['Note'], 
    Amount: map['Amount'], 
    date: map['date']
    );
}
Map <String, dynamic> toMap(){
  return{
    'type': type,
    'category': Category,
    'Note': Note,
    'Amount': Amount,
    'date': date
  };
}
}

