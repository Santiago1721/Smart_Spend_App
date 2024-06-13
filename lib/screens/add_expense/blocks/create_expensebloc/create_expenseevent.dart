part of 'create_expensebloc.dart';

sealed class CreateExpenseevent extends Equatable {
  const CreateExpenseevent();

  @override
  
  List<Object> get props => [];
}

class CreateExpense extends CreateExpenseevent{
  final Expense expense;

  const CreateExpense(this.expense);

  @override
  List<Object> get props => [expense];
}