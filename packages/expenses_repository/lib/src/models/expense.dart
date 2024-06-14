import 'package:expenses_repository/expense_repository.dart';

class Expense{
  String expenseID;
  Category category;
  DateTime date;
  int amount;

  Expense({
    required this.expenseID,
    required this.category,
    required this.date,
    required this.amount
    
  });

  static final empty = Expense(
    expenseID: '', 
    category: Category.empty, 
    date: DateTime.now(), 
    amount: 0, 
   
    );


  ExpenseEntity toEntity() {
  return ExpenseEntity(
      expenseID: expenseID,
      category: category,
      date: date,
      amount: amount,
    
    );
}

static Expense fromEntity(ExpenseEntity entity){
  return Expense(
    expenseID: entity.expenseID,
    category: entity.category,
    date: entity.date,
    amount: entity.amount,
  
  );
}
}