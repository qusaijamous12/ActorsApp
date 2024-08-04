import 'package:blocomarahmed/bussniesslogic_layer/cubit/cubit.dart';
import 'package:blocomarahmed/bussniesslogic_layer/cubit/state.dart';
import 'package:blocomarahmed/data_layer/models/character_model.dart';
import 'package:blocomarahmed/presentaion_layer/screens/details_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var searchController=TextEditingController();

  bool isSearched=false;

  List<Results> serachList=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar:_myAppBar(),
      body: OfflineBuilder(
        connectivityBuilder: (
             BuildContext context,
            List<ConnectivityResult> connectivity,
            Widget child,
        ){
          final bool connected = !connectivity.contains(ConnectivityResult.none);
          if(connected){
            return buildMyBlocDesign();
          }
          else
            {
              return const Center(child:
               Text(
                'Connect to the network !!! '
              ));

            }
        },
        child: Center(child: CircularProgressIndicator()),
      )


    );

  }

  Widget buildActorImage(Results data){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen(
          name: data.name,
          image: data.image,
          status: data.status,
          species: data.species,
          type: data.type,
          gender: data.gender,
          id: data.id,
        )));
      },
      child: Hero(
        tag:data.id,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(10),
            border: Border.all(
              color: Colors.white,
              width: 5
            )
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,

          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              data.image.isNotEmpty?  FadeInImage(
                height:double.infinity,
                 fit: BoxFit.cover,
                 placeholder:const NetworkImage('https://static.vecteezy.com/system/resources/thumbnails/032/535/291/small_2x/loading-game-icon-png.png'),
                 image: NetworkImage('${data.image}')): const Image(
                height: double.infinity,
                  fit: BoxFit.cover,
                  image: NetworkImage(
                'https://as1.ftcdn.net/v2/jpg/00/95/83/46/1000_F_95834632_CL4kevuB3WZLoX72MB52KTLJqx4qhvQj.jpg',
              )),
              Container(
                width: double.infinity,
                height: 40,
                alignment: AlignmentDirectional.center,
                color: Colors.black.withOpacity(0.6),
                child: Text(
                  '${data.name}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  Widget buildSerachField(context){
    return TextFormField(
      controller: searchController,
      decoration:const InputDecoration(
        labelText: 'Search for actors...',
        border: InputBorder.none

      ),
      onChanged: (value){
        AppCubit.get(context).addSearchedItemsToSearchedList(value, context);

      },

    );
  }

  PreferredSizeWidget _myAppBar(){
    if(isSearched==false){
      return AppBar(
        backgroundColor: Colors.yellow,
        title:const Text(
            'HomeScreen'
        ),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: (){
                setState(() {
                  isSearched=true;
                });
              },
              icon:const Icon(
                Icons.search_rounded,
                color: Colors.black,
              ))
        ],
      );
    }
    else
      {
        return AppBar(
          leading: IconButton(
            onPressed: (){
              isSearched=false;
              setState(() {

              });
            },
            icon:const Icon(
              Icons.navigate_before,
              color: Colors.black,
            ),
          ),
          title: buildSerachField(context),
          backgroundColor: Colors.yellow,
          actions: [
            IconButton(
                onPressed: (){
                  setState(() {
                    isSearched=false;
                  });

                },
                icon:const Icon(
                  Icons.clear,
                  color: Colors.black,
                ))
          ],
        );

      }
  }

  Widget buildMyBlocDesign(){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: BlocConsumer<AppCubit,AppState>(
        listener: (context,state){

        },
        builder: (context,state){
          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  ConditionalBuilder(
                      condition: state is ! LoadingGetData,
                      builder: (context)=>GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.7,
                        children:List.generate(
                            isSearched ==false ?
                            AppCubit.get(context).character.results!.length:
                            AppCubit.get(context).serachCharacter.length,
                                (index)=>isSearched==false?
                            buildActorImage(AppCubit.get(context).character.results![index])
                                :buildActorImage(AppCubit.get(context).serachCharacter[index])) ,

                      ),
                      fallback: (context)=>const Center(
                          child: CircularProgressIndicator(
                            color: Colors.yellow,
                          ))),

                ],
              ),
            ),
          );
        },
      ),
    );
  }

 void  addSearchedItemsToSearchedList(String searchedCharacter,context){
   serachList=AppCubit.get(context).character.results!.where((character)=>character.name.toLowerCase().startsWith(searchedCharacter)).toList();
   setState(() {

   });

 }
}

