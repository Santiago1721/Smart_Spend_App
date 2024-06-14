
import 'package:bloc/bloc.dart';
import 'package:smart_spend2/simple_bloc_observer.dart';

import 'app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';





Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

   const firebaseOptions = FirebaseOptions(
    apiKey: 'AIzaSyCBckrMkIvtrC_JSaF9Ly4Eti7IPWBphM4',
    authDomain: "",
    storageBucket: "",
    appId: '1:150383433986:android:d625a8ed5ff61ee90d4a1b',
    messagingSenderId: '150383433986',
    projectId: 'smart-spend-prototipo-ii',
    
    );
  
  await Firebase.initializeApp( 
        name: 'Proyecto1',
    options: firebaseOptions,
   

  );

  runApp(const MyAppli());

}




  

   
  

 
