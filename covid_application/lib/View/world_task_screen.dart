import 'package:covid_application/Models/world_states_Model.dart';
import 'package:covid_application/Services/Utilities/States_Services.dart';
import 'package:covid_application/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({Key? key}) : super(key: key);

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen> with TickerProviderStateMixin{
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this)..repeat();

    @override
  
  void dispose(){
    super.dispose();
    _controller.dispose();
  }

  

  final colorList = <Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246)
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
     return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 18,
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
                
                child:Container(
           decoration: BoxDecoration(
             gradient: LinearGradient(
               colors: [
                        Color(0xff295270),
                        Color(0xff524175),
               ])
           ),
       child: Column(
         children: [
           SizedBox(height: 18,),
           FutureBuilder(
             future:statesServices.fetchWorldStatesRecords(),
            builder:(context,AsyncSnapshot <WorldStatesModel> snapshot) {
             if(snapshot.data == null){
               return Expanded(
                 flex: 1,
                 child: SpinKitFadingCircle(
                   color: Colors.white,
                   size: 50.0,
                   controller : _controller,
                 ),
               );
             }else{
               return Column(
                 children: [
                   PieChart(
                               dataMap: {
               "Total" : double.parse(snapshot.data!.cases!.toString()),
               "Recovered" : double.parse(snapshot.data!.recovered.toString()),
               "Deaths" : double.parse(snapshot.data!.deaths.toString()),
                               },
                               chartValuesOptions: ChartValuesOptions(
               showChartValuesInPercentage: true,
                               ),
                               chartType: ChartType.ring, 
                               colorList: colorList,
                               chartRadius: MediaQuery.of(context).size.width / 3.2,
                               legendOptions: LegendOptions(
               legendPosition: LegendPosition.left
                               ),
                               animationDuration: const Duration(microseconds: 1200),
                               
                               ),
                             Padding(
                               padding: const EdgeInsets.only(top: 40,left: 10,right: 10,bottom: 5),
                               child: Card(
               child: Column(
                 children: [
                   ReusableRow(title: 'Total', value: snapshot.data!.cases!.toString()),
                   ReusableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                   ReusableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                   ReusableRow(title: 'Active', value: snapshot.data!.active.toString()),
                   ReusableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
                   ReusableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                 ],
               ),
                               ),
                             ),
                             Padding(
                               padding: const EdgeInsets.only(top: 30,left: 10,right: 10,bottom: 5),
                               child: SizedBox(
                                 height: 50,
                                 width: 330,
                                 child: Container(
                                   margin: EdgeInsets.all(1),
      
          // or margin: EdgeInsets.only(left:10, right:10),
      
                                   child: ElevatedButton(
                                                     onPressed: (){
                                                       Navigator.push(context, MaterialPageRoute(builder: (context)=>const CountriesListScreen()));
                                   
                                                     },
                                                      
                                    child: Text('Track Countries' , style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                    
                                    style: ElevatedButton.styleFrom(
                                                     backgroundColor: Colors.green.shade500,
                                                     foregroundColor: Colors.white,
                                                     
                                    ),
                                    
                                    ),
                                 ),
                               ),
                             ),
               
               
                 ],
               );
             }
            }
            ),
              
              
           
           
         ],
       ),
                )),
    );
  }
}
// ignore: must_be_immutable
class ReusableRow extends StatelessWidget {

  String title, value;
 ReusableRow({Key? key , required this.title,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10,bottom: 5,left: 10,right: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
              Text(value,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),

            ],
          ),
          SizedBox(height: 7),
          Divider()
        ],
      ),
    );
  }
}