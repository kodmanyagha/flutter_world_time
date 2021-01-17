import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> locations = [
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
  ];

  void asynExample() async {
    // simulate network request for a username
    String username = await Future.delayed(Duration(seconds: 3), () {
      print('delayed 1 function run');
      return 'ahmet';
    });

    String bio = await Future.delayed(Duration(seconds: 2), () {
      print('delayed 2 function run');
      return 'etobur, yazılımcı ve problemli';
    });

    print('username: $username, bio: $bio');
    print('getData function run');
  }

  @override
  void initState() {
    super.initState();
    print('initState function run');

    //asynExample();
    //print('asynExample() method executed');
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose function run');
  }

  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();

    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDaytime': instance.isDaytime,
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build function run');

    return Scaffold(
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, item) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
            child: Card(
              child: ListTile(
                onTap: () {
                  print(locations[item].location);
                  updateTime(item);
                },
                title: Text(
                    '${locations[item].location} ( ${locations[item].utcOffset} )'),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/${locations[item].flag}'),
                ),
              ),
            ),
          );
        },
      ),
      appBar: AppBar(
        title: Text('Choose Location'),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        elevation: 0,
      ),
    );
  }
}
