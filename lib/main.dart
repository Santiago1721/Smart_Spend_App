import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_spend_app/graphic_widget.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Spend',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {


  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late PageController _controller;
  int currentPage = 1;
  
 @override
 void initState(){
  super.initState();

  _controller = PageController(
    initialPage: currentPage, //en que mes quiero que inicie la division
    viewportFraction: 0.5,  //cual es la fraccion que quiero que ocupe cada pagina

  ); 
 }

  Widget _bottomAction(IconData icon){
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Icon(icon),
      ),
      onTap: () {}
    );
  }
    @override

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8.0,
        shape: CircularNotchedRectangle(), //esto hace que el boton de añadir forme un espacio circular para si mismo en la barra inferior
         child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _bottomAction(FontAwesomeIcons.history),
            _bottomAction(FontAwesomeIcons.chartPie),
            SizedBox(width: 50.0,),
            _bottomAction(FontAwesomeIcons.wallet),
            _bottomAction(Icons.settings),

          ],
         ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
      
        child: Icon(Icons.add),
        onPressed: (){},
      ),
      body: _body(),
    );
  }

  Widget _body(){
    return SafeArea(
      child: Column(
        children: <Widget>[
          _selector(),
          _expenses(),
          _graphic(),
          Container(   //este container es el espacio azulito entre el grafico y los widgets de gasto y ganancia
            color: Colors.blueAccent.withOpacity(0.16),
            height: 15.0,
          ),
          _list(),
        ],
        ),
    );
  }
  Widget _pageItem(String nombre, int position){
    var _alignment;

    final selected = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.blueGrey,
    );

      final unselected = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.normal,
      color: Colors.blueGrey.withOpacity(0.4),
    );


    if(position == currentPage){
      _alignment = Alignment.center;
    } else if(position > currentPage){
      _alignment = Alignment.centerRight;
    } else{
      _alignment = Alignment.centerLeft;
    }
    return Align(
      alignment: _alignment,
      child: Text(nombre,
      style: position == currentPage ? selected : unselected,
      ),
    );
  }

  Widget _selector() {  //el selector te permite navegar de manera horizontal entre los meses, asi puedes
  //identificar que gastos/ingresos tuviste en cada mes
    return SizedBox.fromSize(
      size: Size.fromHeight(60.0),
      child: PageView(
        onPageChanged: (newPage){
          setState(() {
            currentPage = newPage;
          });
        },
        controller: _controller,
        children: <Widget>[
          _pageItem('Enero',0),
          _pageItem('Febrero',1),
          _pageItem('Marzo',2),
          _pageItem('Abril',3),
          _pageItem('Mayo',4),
          _pageItem('Junio',5),
          _pageItem('Julio',6),
          _pageItem('Agosto',7),
          _pageItem('Septiembre',8),
          _pageItem('Octubre',9),
          _pageItem('Noviembre',10),
          _pageItem('Diciembre',11),
      ],
      ),
    );
  }

  Widget _expenses(){
    return Column(
      children: <Widget>[
        Text("\$5490,60",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),),
        Text("Total Expenses",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0, color: Colors.green[800]),),
      ],
    );
  }

  Widget _graphic() {
    return Container(
      height: 250.0,
      child: GraphicWidget(),
    );
  }

  Widget _item(IconData icon, String nombre, int percent, double valor){
    return ListTile(
      leading: Icon(icon, size: 32.0),
      title: Text(nombre),
      subtitle: Text("$percent% of expenses",
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.green,
      )),
      trailing: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.8),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("\$$valor",
          style: TextStyle(
            color: Colors.blueAccent,
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ),
        ),
        ),
      ),
    );
  }

  //aqui en la lista  "_list " vamos a poner cada uno de los apartados de gastos y compras que se mostraran debajo
  //del grafico principal, cada uno con su icono, nombre, y descrpcion, las expensas y el gasto o ganancia se pone
  //en el widget _item de arriba.

  Widget _list() {
    return Expanded(
      child: ListView.separated(
        itemCount: 15, //aqui pongo las veces que quiero que aparezca un widget en especifico, en este caso, el que esta
        //dentro de itembuilder
        itemBuilder: (BuildContext context, int index) => _item(FontAwesomeIcons.shoppingCart, "Shopping", 14, 145.11), //aqui se importa la clase item
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.blueAccent.withOpacity(0.15),
            height: 8.0,
            );
        },
      ),
      );
  }
}

