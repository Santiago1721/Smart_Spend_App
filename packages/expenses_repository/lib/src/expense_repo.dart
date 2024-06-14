import '../expense_repository.dart';


 abstract class ExpenseRepository {

  Future<void> createCategory(Category category);

  Future<List<Category>> getCategory() async {
    return<Category>[];
  }

  Future<void> createExpense(Expense expense);

   Future<List<Expense>> getExpenses() async {
    print("Fetching expenses..."); // Log para depuración
    return <Expense>[]; // Asegurarse de que no retorne null
  }
}
  




