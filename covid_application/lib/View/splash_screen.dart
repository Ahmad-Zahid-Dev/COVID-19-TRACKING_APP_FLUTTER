import 'package:covid_application/View/world_task_screen.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{


  @override
  void initState() {
    super.initState();
    new Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder:(context) => WorldStateScreen()),
            ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              
               Center(
                child: Container(
                  width: 150,
                  height: 150,
                  child: Image.asset('images/virus.png')
                  )
                  ),
                  SizedBox(height: 25,),
                 Text('   COVID-19 \n Tracker App',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
              
          ],
          ),
        ),
      ),
    );
  }
}
