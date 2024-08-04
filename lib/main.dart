import 'package:blocomarahmed/bussniesslogic_layer/cubit/cubit.dart';
import 'package:blocomarahmed/data_layer/web_services/web_services.dart';
import 'package:blocomarahmed/presentaion_layer/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constant/observer.dart';

void main() {

  Bloc.observer = MyBlocObserver();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context)=>AppCubit(WebServices())..getAllData())
      ],
      child:   MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),

      ),
    );
  }
}

