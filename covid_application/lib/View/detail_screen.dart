import 'package:covid_application/View/world_task_screen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailScreen extends StatefulWidget {
  String image,name;
  int totalCases , totalDeaths, totalRecovered,active,test;
   DetailScreen(
    {required this.image, 
     required this.name, 
     required this.totalCases, 
     required this.totalDeaths,
     required this.totalRecovered,
     required this.active,
     required this.test
});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.name)),
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
                             Color(0xff295270),
                             Color(0xff524175),
                    ]
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.067),
                child: Card(
                  child: Column(
                    children: [
                SizedBox(height: 50,),
                ReusableRow(title: 'Cases', value: widget.totalCases.toString()),
                ReusableRow(title: 'Recovered', value: widget.totalRecovered.toString()),
                ReusableRow(title: 'Deaths', value: widget.totalDeaths.toString()),
                ReusableRow(title: 'Active', value: widget.active.toString()),
                ReusableRow(title: 'Tests', value: widget.test.toString()),
                
                    ],
                  ),
                ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                )
                
                
              ],
            )
          ],
        ),
      ),
    );
  }
}