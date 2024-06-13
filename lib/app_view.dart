import 'package:expenses_repository/expenses_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_spend2/screens/home/blocks/get_expenses/get_expenses_bloc.dart';
import 'package:smart_spend2/screens/home/views/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Seguimiento de gastos',
      theme: ThemeData(
          colorScheme: const ColorScheme.dark(
              surface: Color.fromARGB(255, 69, 30, 245),
              primary: Color.fromARGB(255, 15, 11, 75),
              secondary: Color.fromARGB(236, 37, 196, 235),
              tertiary: Color.fromARGB(199, 0, 0, 0),
              outline: Colors.grey)),
      home: BlocProvider(
        create: (context) => GetExpensesBloc(
          FirebaseExpenseRepo()
        ),
        child:  const HomeScreen(),
      ),
    );
  }
}
 