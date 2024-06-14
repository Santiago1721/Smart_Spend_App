
import 'package:flutter/material.dart';
import 'package:smart_spend2/screens/home/stats/charts.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Transaccion',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,

              )
              ,
            ),
            const SizedBox(height: 20,),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              //color: Colors.blue[800],
              child: const MyCharts()
              
            )
          ],
        ),
      ),
    );
  }
}