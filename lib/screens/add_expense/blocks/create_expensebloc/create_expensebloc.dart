import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expenses_repository/expenses_repository.dart';


part 'create_expenseevent.dart';
part 'create_expensestate.dart';


class CreateExpenseBloc extends Bloc<CreateExpenseevent, CreateExpensestate> {
  ExpenseRepository expenseRepository;
  CreateExpenseBloc(this.expenseRepository) : super(CreateExpenseInitial()) {
    on<CreateExpense>((event, emit) async {
      emit(CreateExpenseLoading());
      try{
        await expenseRepository.createExpense(event.expense);
        emit(CreateExpenseSuccess());

      }catch (e) {
        emit(CreateExpenseFailure());
      } 

    
  });
  }

}