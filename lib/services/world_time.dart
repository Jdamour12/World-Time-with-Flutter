import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location = ''; //location name for the UI
  String time = ''; //time in that location
  String flag = ''; //url to an asset flag item
  String url = ''; //location url for the api endpoint
  bool? isDayTime; // is day-time or not

  WorldTime({required this.location, required this.flag, required  this.url});

  Future<void> getTime() async {
    //make the request

    try{
      Response response = await get(
  Uri.parse('http://worldtimeapi.org/api/timezone/$url'),
  headers: {'Content-Type': 'application/json'},
);
    Map data = jsonDecode(response.body);
    //print(data);

    //get properties from data
    String datetime =  data['datetime'];
    String offset = data['offset'];
    // print(datetime);
    // print(offset);

    //create DateTime object
    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset)));

    //set the time property
    isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
    time = DateFormat.jm().format(now);
    }
    catch(e){
      print('Error: ${e.toString()}');
      time = 'We caught an error';
    }

    
  }

}
