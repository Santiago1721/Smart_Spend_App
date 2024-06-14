import 'package:expenses_repository/expense_repository.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_spend2/screens/add_expense/blocks/create_categorybloc/create_category_bloc.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';






import 'package:uuid/uuid.dart';



Future getCategoryCreation(BuildContext context){
    List<String> myCategoriesIcons = [ //lista de los iconos que seran utilizados para
  //ayudar a identificar una categoria
    'bolsadecompra',
    'comidarapida',
    'pastillas',
    'pill_819657',
    
  ];

  return showDialog(  
    
          context: context,
          builder: (ctx){  //desde aqui empiezo a construir la interfaz del icono
          // de + qie aparece para añadir una nueva categoria
          bool isExpanded = false;
          String iconSelected = '';
          Color categoryColor = Colors.green;
                
          TextEditingController categoryNameController = TextEditingController();  //controlador del nombre de la categoria
          TextEditingController categoryIconController = TextEditingController();  //controlador del icono de la categoria
          TextEditingController categoryColorController = TextEditingController(); //controlador del color de la categoria
          
          bool isLoading = false;
          Category category = Category.empty;  

                return BlocProvider.value(
                  value: context.read<CreateCategoryBloc>(),
                  child: StatefulBuilder(
                    builder: (ctx, setState){
                    return BlocListener<CreateCategoryBloc, CreateCategoryState>(
                      listener: (context, state) {
                        if(state is CreateCategorySuccess) {
                          Navigator.pop(ctx, category);
                        } else if(state is CreateCategoryLoading) {
                          setState(() {
                            isLoading == true;
                          });
                        }
                    },
                    child: AlertDialog(
                      title: const Text('Crear una Categoria'
                      ),
                                content: SizedBox(
                                  child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                  
                                  const SizedBox(height: 18,),
                                  TextFormField(
                                          controller: categoryNameController,
                                        // controller: dateController, //controlador de fecha
                                  textAlignVertical: TextAlignVertical.center,
                                        
                                  decoration: InputDecoration(
                                  isDense: true,
                                  filled: true,
                                  fillColor: const Color.fromARGB(255, 13, 117, 28),
                                      
                                  hintText: "Nombre",
                                  border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),//aqui le pongo un borde circular al campo de
                                  borderSide: BorderSide.none,
                                    //texto
                                  ),    
                                      ),
                                    ),
                                      const SizedBox(height: 20,),
                                  TextFormField(
                                    controller: categoryIconController,
                                    onTap: () {
                                      setState(() {
                                    isExpanded = !isExpanded;
                                      });
                                    },
                                      
                                      textAlignVertical: TextAlignVertical.center,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        isDense: true,
                                      filled: true,
                                      suffixIcon: const Icon(CupertinoIcons.chevron_down, size: 12),
                                      fillColor: const Color.fromARGB(255, 13, 117, 28),
                                      hintText: "Icono",
                                      border: OutlineInputBorder(
                                        borderRadius: isExpanded
                                      ? const  BorderRadius.vertical(
                                      top: Radius.circular(12)
                                      )  
                                      : BorderRadius.circular(12),                       //aqui le pongo un borde circular al campo de
                                      borderSide: BorderSide.none,
                                  //texto
                                      ),    
                                    ),
                                  ),
                                  isExpanded
                                  
                                  ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 200,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 13, 109, 37),
                                      borderRadius: BorderRadius.vertical(
                                   bottom: Radius.circular(12)
                                      )
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GridView.builder(
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 3,
                                    crossAxisSpacing: 5
                                                                
                                    ),
                                  itemCount: myCategoriesIcons.length, //aqui muestro los iconos que estan
                                  //almacenados en la carpeta assets, los cuales estan guardados en la variable
                                  //mycategoriesIcons
                                  itemBuilder: (context, int i){
                                    return GestureDetector(   //aqui lo que voy a hacer es que usando la funcion gesture
                                    //detector detecte cuando le selecciones con un click uno de los iconosy que se ponga el 
                                    //borde del icono de color verde
                                    onTap: () {
                                        setState(() {
                                          iconSelected = myCategoriesIcons[i];
                                        });
                                      },
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: iconSelected == myCategoriesIcons[i]  //anidar la funcion de seleccion de
                                            //icono con los iconos en si
                                            ? const Color.fromARGB(255, 223, 215, 7)
                                            : Colors.grey,
                                          ),
                                          borderRadius: BorderRadius.circular(20),
                                          image: DecorationImage(
                                            image: AssetImage(
                                              'asset/${myCategoriesIcons[i]}.png'  //aqui pongo que busque en la carpeta assets
                                              //los iconos que esten dentro de la variable mycategoriesicons y que tengan formato de
                                              //imagen png
                                            )
                                            )
                                        )
                                      ),
                                    );
                                    },
                                    ),
                                    ) ,
                                  )
                                  : Container(),
                                  const SizedBox(height: 20,),
                                  TextFormField(
                                    controller:  categoryColorController,  //con la funcion ontap de mas abajo y ayudandome de la extension
                                  //flutter_colorpicker, le indico al programa que cuando se haga click en el boton de color
                                  //de seleccionar categoria, me habra un panel de seleccion de color RGB
                                    onTap: () {
                                      showDialog(
                                      context: context, 
                                      builder: (ctx2) {
                                  return AlertDialog(
                                  content: Column(
                                    mainAxisSize : MainAxisSize.min,
                                    children: [
                                      
                                      ColorPicker(
                                      pickerColor: categoryColor,
                                      onColorChanged: (value) {
                                        setState(() {   //SELECTOR DE COLOR DE CATEGORIA
                                            categoryColor = value;
                                        }
                                        );
                                      },          
                                      ),
                                      SizedBox(
                                      width: double.infinity,
                                      height: 50,
                                      child: TextButton(
                                  //boton guardar
                                  onPressed: () {
                                    //esto imprime en consola que color se ha seleccionao
                                    Navigator.pop(ctx2);
                                  },
                                  style: TextButton.styleFrom( //estilo del boton
                                    backgroundColor: const Color.fromARGB(255, 17, 87, 178),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)
                                    )
                                ),
                                  child: const Text(
                                    "Aplicar Color",
                                    style: TextStyle(   //estilo del texto del boton
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                    ),
                                  )
                                  ),
                                      )
                                    ],
                                  ),
                                );
                                          
                                                        
                                  }
                                  );
                                },
                                  textAlignVertical: TextAlignVertical.center,
                                  readOnly: true,
                                  
                                  decoration: InputDecoration(
                                  isDense: true,
                                  filled: true,
                                  fillColor: categoryColor,  //aqui pongo la variable de selector de
                                  //color para que se imprima en pantalla
                                  hintText: "Color",
                                  border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),//aqui le pongo un borde circular al campo de
                                  borderSide: BorderSide.none,
                                    //texto
                                    ),    
                                  ),
                                ),
                                const SizedBox(height: 20,),
                                SizedBox(
                                width: double.infinity,
                                height: kToolbarHeight,
                                child: isLoading == true
                                ? const Center(
                                child: CircularProgressIndicator(),
                                )
                                :
                                TextButton(  //boton guardar CATEGORIA
                                onPressed: () {
              
                                  //creamos aqui el objecto de categoria
                                
                                  setState(() {

                                    //aqui creamos el objeto categoria y lo instanciamos con el 
                                  category.categoryId = const Uuid().v1(); //identificador unico de cada categoria agregada
                                  category.name = categoryNameController.text;  //añadir nombre
                                  category.icon = iconSelected;    // añadir icono
                                  category.color = categoryColor.value;  //añadir color
              
                                  });
                          
                                    context.read<CreateCategoryBloc>().add(CreateCategory(category));  //esta funcion lee los datos que le introducimos de categoriay los manda a los create de block
                                    
                                      },
                                    style: TextButton.styleFrom( //estilo del boton
                                    backgroundColor: Color.fromARGB(255, 17, 87, 178),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)
                                    )
                                ),
                                  child: const Text(
                                    "Guardar Categoria",
                                    style: TextStyle(   //estilo del texto del boton
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                    ),
                                   )
                                   ),
                                   )
                                  ],
                                  ),
                                ),
                        ),
                    );
                    },
                  )
                );
        }
        );
}