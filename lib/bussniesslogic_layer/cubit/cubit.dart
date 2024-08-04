import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:blocomarahmed/bussniesslogic_layer/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_layer/models/character_model.dart';
import '../../data_layer/web_services/web_services.dart';

class AppCubit extends Cubit<AppState>{

  late WebServices webServices;

  AppCubit(this.webServices):super(InitialAppState());

  static AppCubit get(context)=>BlocProvider.of(context);

  late  Character character;
  late  List<Results> serachCharacter=[];

  bool isSearched=false;

  void getAllData(){
    emit(LoadingGetData());
     webServices.getAllCharacter().then((value){
       character=Character.fromJson(value);
       emit(GetDataSuccessState());

     }).catchError((error){
       print(error.toString());
       emit(GetDataErrorState());
     });

  }
  void  addSearchedItemsToSearchedList(String searchedCharacter,context){
    serachCharacter=[];
    serachCharacter=character.results!.where((character)=>character.name.toLowerCase().startsWith(searchedCharacter)).toList();
    print(searchedCharacter);
    print(searchedCharacter.length);
    emit(GetSearchDataSuccess());

  }
  
  
  
}
