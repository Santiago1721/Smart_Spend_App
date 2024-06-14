import 'dart:math';

import 'package:expenses_repository/expense_repository.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatelessWidget {
  const MainScreen(this.expenses ,{super.key });

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Container(
            color: Color.fromARGB(255, 34, 77, 33),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(   //primer bola color indigo en la parte superio r izquierda de la pantalla
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.indigo
                          ),
                        ),
                        Icon(CupertinoIcons.person_2_fill,
                        color: Theme.of(context).colorScheme.tertiary,)
                      ],
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bienvenido!', 
                          style: TextStyle(
                            fontSize: 12,
                             fontWeight: FontWeight.bold,
                             color: Theme.of(context).colorScheme.outline
                          ),
                          ),
                        Text(
                        'Santiago',
                        style: TextStyle(
                            fontSize: 20,
                             fontWeight: FontWeight.bold,
                             color: Theme.of(context).colorScheme.onSurface
                             ),
                        ),
                      ],
                    ),
                   
                  ],
                ),
                 IconButton(onPressed: () {},
                icon: const Icon(CupertinoIcons.settings))
              ],
            ),
          ),
          const SizedBox(height: 20,),
          Container(   //este es el widget donde se almacenan los datos de ingresos y gastos
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width / 1.5,
            decoration: BoxDecoration(
               gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
               Theme.of(context).colorScheme.secondary,
                  Theme.of(context).colorScheme.tertiary,
          ],
          transform: const GradientRotation(pi / 4),
        ),
              borderRadius: BorderRadius.circular(30)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Dinero Total',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow
                  ),
                ),
                SizedBox(height: 10,),
                 const Text(
                  '€ 230.00',
                      style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 5, 118, 42)
                  ),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 25,
                            height: 25,
                            decoration: const BoxDecoration(
                              color: Colors.yellow,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(CupertinoIcons.arrow_up,
                              size: 12
                              ),
                              
                            )
                            
                          ),
                          SizedBox(width: 10),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text(
                            'Ingresos',
                                style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow
                            ),
                            ),
                            Text(
                            '€ 780.00',
                                style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 5, 118, 42)
                            ),
                            ),
                            ]
                          )
                        ],
                      ),
                        Row(
                        children: [
                          Container(
                            width: 25,
                            height: 25,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 158, 19, 14),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(CupertinoIcons.arrow_down,
                              size: 12
                              ),
                              
                            )
                            
                          ),
                          SizedBox(width: 10),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text(
                            'Gastos',
                                style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow
                            ),
                            ),
                            Text(
                            '€ 550.00',
                                style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 5, 118, 42)
                            ),
                            ),
                            ]
                          )
                        ],
                      )
                    ],
                  ),
                )
               ],
              ),
             ),
             const SizedBox(height: 30, ), 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Transacciones',
                  style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 5, 118, 42)
                ),
                ),
                 GestureDetector(
                  onTap: () {

                  },
                   child: const Text(
                    'Ver Todas',
                    style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 5, 118, 42)
                                   ),
                                   ),
                 ),
              ],
              ),
              const SizedBox(height: 20,),
              Expanded(
                child: ListView.builder(  //aqui vamos a poner las transacciones hechas por el usuario
                  itemCount: expenses.length,
                  itemBuilder: (context, int i){
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Stack(
                                    alignment: Alignment.center, //esto centra el icono de compra en el
                                    //circulito de transaccion
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Color(expenses[i].category.color),
                                          shape: BoxShape.circle
                                        ),
                                      ),  
                                      Image.asset( 
                                        'asset/${expenses[i].category.icon}.png',
                                        ) 
                                    ],
                                  ),
                                  const SizedBox(width: 6,),
                                      Text(
                                    expenses[i].category.name, //aqui va el nombre de la trnasaccion que se llevo a cabo
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    
                                    ),
                                  ),
                                  //aqui va el precio de la transaccion que se realizo
                                ],
                              ),
                                 Column(
                                    children: [
                                  Text(
                                    "\$${expenses[i].amount}.00",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    
                                    ),
                                  ),
                              
                                  //por su parte aqui va la fecha de la transaccion
                                  Text(
                                    DateFormat("DD/MM/YYYY").format(expenses[i].date),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    
                                    ),
                                  ),
                              
                                    ],
                                  )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  ),
              ),
            ],
          ),
        )
    ); 
  }
}