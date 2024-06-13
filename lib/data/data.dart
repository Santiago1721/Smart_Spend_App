import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


//este apartado se crea para almacenar todas las transacciones, estas se visualizan en la pestaña
//"main screen" mediante la variable "myTransactionsData" y al lado de se pone el nombre de cada una
//de las variables, por ejemplo, si queremos visualizar el nombre de una transaccion en especifico se pone
//myTransactionsData[i]['Nombre'], y asi con los demas elementos de la transaccion 

List<Map<String, dynamic>> myTransactionsData = [
  {
    'icon': const FaIcon(FontAwesomeIcons.bagShopping, color: Colors.white),
    'color': Colors.green,
    'name': 'Compra Mercadona' ,
    'totalExpense': '150 €',
    'date': 'Hoy', 
  },

    {
    'icon': const FaIcon(FontAwesomeIcons.burger, color: Colors.white),
    'color': Color.fromARGB(255, 215, 9, 9),
    'name': 'McDonalds' ,
    'MontoTotal': '6 €',
    'date': '27/05/24', 
  },

    {
    'icon': const FaIcon(FontAwesomeIcons.pills, color: Colors.white),
    'color': const Color.fromARGB(255, 76, 76, 81),
    'name': 'Farmacia' ,
    'MontoTotal': '35 €',
    'date': '18/05/24', 
  },

   {
    'icon': const FaIcon(FontAwesomeIcons.pills, color: Colors.white),
    'color': const Color.fromARGB(255, 19, 10, 119),
    'name': 'Farmacia',
    'MontoTotal': '23 €',
    'date': '13/05/24', 
  },

    {
    'icon': const FaIcon(FontAwesomeIcons.xbox, color: Colors.white),
    'color': Colors.green,
    'name': 'Battlefield I' ,
    'MontoTotal': '78 €',
    'date': '01/05/24', 
  },
];