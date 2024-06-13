part of 'create_expensebloc.dart';

sealed class CreateExpensestate extends Equatable {
  const CreateExpensestate();

  @override
  List<Object> get props => [];

 
  
}

final class CreateExpenseInitial extends CreateExpensestate {}

final class CreateExpenseFailure extends CreateExpensestate {}
final class CreateExpenseLoading extends CreateExpensestate {}
final class CreateExpenseSuccess extends CreateExpensestate {}