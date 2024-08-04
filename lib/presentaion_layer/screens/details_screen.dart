import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {

   String ?name;
   String ?status;
   String ?species;
   String ?type;
   String ?gender;
   String ?image;
   int ?id;

  DetailsScreen({
   this.name,
   this.image,
   this.status,
   this.gender,
   this.species,
   this.type,
    this.id
});

  Widget buildSliverAppBar(){
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.grey[800],
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          '${name}',
          style:const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
        background: Hero(
          tag: id.toString(),
          child:Image(
            image: NetworkImage(
              '${image}'
            ),
            fit: BoxFit.cover,
          ),

        ),
      ),

    );
  }

  Widget characterInfo(String title,String value){
    return RichText(
      maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text:TextSpan(
          children:[
             TextSpan(
              text: '${title}',
              style:const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18
              )
            ),
             TextSpan(
                text: '${value}',
                style:const TextStyle(
                    color: Colors.white,
                    fontSize: 18
                )
            )
          ]

        )

    );

  }

  Widget buildDivider(double value){
    return Divider(
      color: Colors.yellow,
      height: 30,
      endIndent:value,
      thickness: 2,
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body:CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(delegate: SliverChildListDelegate(
            [
              Container(
                margin:const EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding:const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    characterInfo('Name : ',name!),
                    buildDivider(310),
                    characterInfo('Status : ',status!),
                    buildDivider(310),
                    characterInfo('Species : ',species!),
                    buildDivider(310),
                    characterInfo('Type : ',type!),
                    buildDivider(310),
                    characterInfo('Gender : ',gender!),
                    buildDivider(310),
                    const SizedBox(
                      height: 200,
                    ),
                  ],
                ),

              ),
              const SizedBox(
                height: 500,
              ),
            ]
          ))

        ],
      ),
    );
  }
}
