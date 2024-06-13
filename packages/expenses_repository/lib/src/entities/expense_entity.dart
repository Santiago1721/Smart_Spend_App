
import 'package:expenses_repository/expenses_repository.dart';



class ExpenseEntity{

  String expenseID;
  Category category;
  DateTime date;
  int amount;

  ExpenseEntity({
    required this.expenseID,
    required this.category,
    required this.date,
    required this.amount
    
  });

  
  Map<String, Object?> toDocument(){
    return {
      'expenseID': expenseID,
      'category': category.toEntity().toDocument(),  //no podemos enviar objetos directamente a firebase
      'date': date,
      'amount': amount,
     
    };
    
  }

  static ExpenseEntity fromDocument(Map<String, dynamic> doc){
    return ExpenseEntity(
        expenseID: doc['expenseID'],
        category: Category.fromEntity(CategoryEntity.fromDocument(doc['category'])),
        date: (doc['date']).toDate(),
        amount: doc['amount'],
    );
  }

}