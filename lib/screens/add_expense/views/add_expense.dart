import 'package:expenses_repository/expense_repository.dart';
import 'package:expenses_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:smart_spend2/screens/add_expense/blocks/create_expensebloc/create_expense_bloc.dart';

import 'package:smart_spend2/screens/add_expense/blocks/get_categoryblocks/get_categories_bloc.dart';
import 'package:smart_spend2/screens/add_expense/views/category_creation.dart';
import 'package:uuid/uuid.dart';

import '../blocks/create_expensebloc/create_expense_bloc.dart';

class AddExpenses extends StatefulWidget {
  const AddExpenses({super.key});

  @override
  State<AddExpenses> createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  //estos son los controladores tanto de gastos como de categoria y fecha de gasto

  TextEditingController expensesController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  // DateTime selectDate = DateTime.now();
  late Expense expense;

  bool isLoading = false;

  @override
  void initState() {
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    expense = Expense.empty;
    expense.expenseID = const Uuid().v1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateExpenseBloc, CreateExpensestate>(
      listener: (context, state) {
        if(state is CreateExpenseSuccess){
          Navigator.pop(context,expense);
        } else if(state is CreateExpenseLoading){
          setState(() {
            isLoading = true;
          });
        }
        // TODO: implement listener
      },
      child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: Theme.of(context)
                .colorScheme
                .primary, //color de fondo del cuerpo
            //apartado de añadir gastos
            appBar: AppBar(
              backgroundColor: Theme.of(context)
                  .colorScheme
                  .primary, //color de fondo del appbar del
              //apartado de añadir gastos
            ),
            body: BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
              builder: (context, state) {
                if (state is GetCategoriesSuccess) {
                  return Padding(
                    padding: const EdgeInsets.all(
                        14.0), //pongo el padding para que el contenido no se vea pegado
                    //a la totalidad de la pantalla del dispositivo
                    child: Column(
                      children: [
                        const Text(
                          "Añadir Gastos",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width *
                              0.8, //esto hace que el campo de ingresar
                          //texto solo ocupe un 80% del ancho de la pantalla
                          child: TextFormField(
                            controller:
                                expensesController, //controlador de gastos
                            textAlignVertical: TextAlignVertical
                                .center, //esto alinea el icono del euro
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Color.fromARGB(255, 13, 117, 28),
                              prefixIcon: const Icon(
                                FontAwesomeIcons.euroSign,
                                size: 25,
                              ),
                              hintText: "Precio",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    30), //aqui le pongo un borde circular al campo de
                                borderSide: BorderSide.none,
                                //texto
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller:
                              categoryController, //controlador de categoria
                          textAlignVertical: TextAlignVertical.center,
                          readOnly: true, //esto alinea el icono del euro
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: expense.category == Category.empty
                                  ? Colors.red
                                  : Color(expense.category.color),
                              prefixIcon: expense.category == Category.empty
                                  ? const Icon(
                                      FontAwesomeIcons.list,
                                      size: 25,
                                      color: Colors.green,
                                    )
                                  : Image.asset(
                                      'asset/${expense.category.icon}.png',
                                      scale: 1,
                                    ),
                              suffixIcon: IconButton(
                                  onPressed: () async {
                                    var newCategory =
                                        await getCategoryCreation(context);

                                    setState(() {
                                      state.categories.insert(0,newCategory);
                                    });
                                  },
                                  icon: const Icon(
                                    FontAwesomeIcons.plus,
                                    size: 16,
                                    color: Colors.yellow,
                                  )),
                              hintText: "Categoria",
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(
                                        12)), //aqui le pongo un borde circular al campo de
                                borderSide: BorderSide.none,
                              )),
                          //texto
                        ),
                        Container(
                          height: 200,
                          width: 400,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(12)),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                  itemCount: state.categories.length,
                                  itemBuilder: (context, int i) {
                                    return Card(
                                      child: ListTile(
                                          onTap: () {
                                            setState(() {
                                              expense.category =
                                                  state.categories[i];
                                              categoryController.text =
                                                  expense.category.name;
                                            });
                                          },
                                          leading: Image.asset(
                                            'asset/${state.categories[i].icon}.png',
                                            scale: 3,
                                          ),
                                          title: Text(state.categories[i].name),
                                          tileColor:
                                              Color(state.categories[i].color),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12))),
                                    );
                                  }
                                  )
                                  ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: dateController, //controlador de fecha
                          textAlignVertical: TextAlignVertical.center,
                          readOnly: true,
                          onTap: () async {
                            DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: expense
                                    .date, //aqui añadimos un selector de fecha
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 365)));
                        
                            if (newDate != null) {
                              setState(() {
                                dateController.text =
                                    DateFormat('dd/MM/yyyy').format(newDate);
                                
                                expense.date = newDate;
                              });
                            }
                          }, //esto alinea el icono del euro
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(255, 13, 117, 28),
                            prefixIcon: const Icon(
                              FontAwesomeIcons.calendarDay,
                              size: 25,
                            ),
                            hintText: "Fecha",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  30), //aqui le pongo un borde circular al campo de
                              borderSide: BorderSide.none,
                              //texto
                            ),
                          ),
                        ),
                        const SizedBox(  //separadores
                          height: 40,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: kToolbarHeight,
                          child: isLoading
                          ? const Center(child: CircularProgressIndicator())
                          :
                          TextButton(
                              //boton guardar
                              onPressed: () {
                                setState(() {
                                  expense.amount =
                                      int.parse(expensesController.text);
                                });

                                context
                                    .read<CreateExpenseBloc>()
                                    .add(CreateExpense(expense));
                              },
                              style: TextButton.styleFrom(
                                  //estilo del boton
                                  backgroundColor:
                                      Color.fromARGB(255, 17, 87, 178),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              child: const Text(
                                "Guardar",
                                style: TextStyle(
                                    //estilo del texto del boton
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              )
                              ),
                        )
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          ),
    );
  }
}
