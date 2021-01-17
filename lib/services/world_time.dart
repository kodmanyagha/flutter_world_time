import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String flag;
  String url;
  bool isDaytime;
  String utcOffset;

  WorldTime({this.location, this.flag, this.url, this.utcOffset});

  Future<void> getTime() async {
    try {
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      print(data);

      utcOffset = data['utc_offset'];
      var offset =
          data['utc_offset'].toString().substring(1).split(':').asMap();
      int offsetHour = int.parse(offset[0]);
      int offsetMinute = int.parse(offset[1]);

      //print(offsetHour.toString() + ' ' + offsetMinute.toString());
      //print(datetime + ' ' + offset.toString());

      // create DateTime object
      DateTime now = DateTime.parse(data['datetime']);
      now = now.add(Duration(hours: offsetHour, minutes: offsetMinute));

      isDaytime = (now.hour > 6 && now.hour < 20) ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      time = 'An error occured: ' + e.toString();
    }
  }
}
