import 'dart:ui';

import 'package:covid_application/Services/Utilities/States_Services.dart';
import 'package:covid_application/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {

  TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        //title: Center(child: Text('Track  Country')),
        flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
         // begin: Alignment.topCenter,
         // end: Alignment.bottomCenter,
          colors: <Color>[Color(0xff295270),
                             Color(0xff524175),]),
      ),
    ),
      ),
    
    body: SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
                             Color(0xff295270),
                             Color(0xff524175),
                    ]
          )
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    
                  });
                },
                controller: searchcontroller,
                decoration: InputDecoration(
                  hintText: 'Search with country name..',
                  prefixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  )
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: statesServices.countriesListApi(), 
                builder: (context ,AsyncSnapshot <List<dynamic>> snapshot){
                  if(snapshot.data == null){
                    return ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[700]!,
                          highlightColor: Colors.grey[100]!,
                          
                          child: Column(
                            children: [
                              ListTile(
                                title: Container(height: 10,width: 89,color: Colors.white,),
                                subtitle: Container(height: 10,width: 89,color: Colors.white,),
                                leading: Container(height: 50,width: 50,color: Colors.white,),
                          
                              )
                            ],
                          ),
                        );
                      },
                    );
                    
                  }else{
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];
                        if(searchcontroller.text.isEmpty){
                          return  Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
                                  image:  snapshot.data![index]['countryInfo']['flag'],
                                  name:  snapshot.data![index]['country'],
                                  totalCases:  snapshot.data![index]['cases'],
                                  totalRecovered:  snapshot.data![index]['recovered'],
                                  totalDeaths:  snapshot.data![index]['deaths'],
                                  active:  snapshot.data![index]['active'],
                                  test:  snapshot.data![index]['tests']
                                )));
                              },
                              child: ListTile(
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(snapshot.data![index]['cases'].toString()),
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                ),
                              
                              ),
                            )
                          ],
                        );
                        }else if ( name.toLowerCase().contains(searchcontroller.text.toLowerCase())){
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
                                  image:  snapshot.data![index]['countryInfo']['flag'],
                                  name:  snapshot.data![index]['country'],
                                  totalCases:  snapshot.data![index]['cases'],
                                  totalRecovered:  snapshot.data![index]['recovered'],
                                  totalDeaths:  snapshot.data![index]['deaths'],
                                  active:  snapshot.data![index]['active'],
                                  test:  snapshot.data![index]['tests'],
                                )));
                              },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases'].toString()),
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                  ),
                                
                                ),
                              ),
                            ],
                          );
                        }
                        else{
                          return Container();
                        }
                      },
                    );
                  }
                }
                )
              
              ,)
          
          ],
        ),
      ) 
      ),
    );
  }
}