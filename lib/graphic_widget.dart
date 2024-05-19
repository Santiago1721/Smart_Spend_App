import 'dart:math';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GraphicWidget extends StatefulWidget {
  const GraphicWidget({super.key});

 

  @override
  _GraphicWidgetState createState() => _GraphicWidgetState();
}

class _GraphicWidgetState extends State<GraphicWidget> {
  late List<double> data;

@override
void initState() {
  super.initState();
  var r = Random();
  data = List<double>.generate(30, (i) => r.nextDouble() * 1500);

}

  void _onSelectionChanged(charts.SelectionModel model){
    final selectedDatum = model.selectedDatum;
    var time;
    final measures =  <String, double>{};



    if(selectedDatum.isNotEmpty){
      time = selectedDatum.first.datum;
      selectedDatum.forEach((charts.SeriesDatum datumPair) 
      {
        final displayName = datumPair.series.displayName ?? 'Unknown';
        measures[displayName] = datumPair.datum as double ;
       }); 
    }
    print(time);
    print(measures);
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<double, num>> series = [
      charts.Series<double, int>(
        id: 'Gasto',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (value, index) => index ?? 0,
        measureFn: (value, _) => value,
        data: data,
        strokeWidthPxFn: (_, __) => 4,
        )
    ];

    return charts.LineChart(series, 
    animate: false,
    selectionModels: [
      charts.SelectionModelConfig(
      type: charts.SelectionModelType.info,
      changedListener: _onSelectionChanged,
      )
    ],

    domainAxis: charts.NumericAxisSpec(
      tickProviderSpec: charts.StaticNumericTickProviderSpec(
        [
          charts.TickSpec(0,label: '01'),
          charts.TickSpec(4,label: '05'),
          charts.TickSpec(9,label: '10'),
          charts.TickSpec(14,label: '15'),
          charts.TickSpec(19,label: '20'),
          charts.TickSpec(24,label: '25'),
          charts.TickSpec(29,label: '30'),
        ]
        //el primer numero del tickspec es la posicion en el grafico 
        //donde va a estar el numero que se pone en el label
      )
    ),
    primaryMeasureAxis: charts.NumericAxisSpec(
      tickProviderSpec: charts.BasicNumericTickProviderSpec(
        desiredTickCount: 4,

      ),
    ),
    );
  }
}