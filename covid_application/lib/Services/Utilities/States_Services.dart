import 'package:covid_application/Models/world_states_Model.dart';
import 'package:covid_application/Services/Utilities/App_Url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StatesServices{
  Future <WorldStatesModel> fetchWorldStatesRecords() async{
    final response = await http.get(Uri.parse(AppUrl.worldStateApi));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    }else{
      throw Exception('Failed to load data');
    }
  }

  Future <List<dynamic>> countriesListApi() async{
    final response = await http.get(Uri.parse(AppUrl.countriesApi));
    var data;
    if(response.statusCode == 200){
      data = jsonDecode(response.body);
      return data;
  }else{
    throw Exception('Failed to load data');
  }


}
}