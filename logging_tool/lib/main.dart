import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:usage_stats/usage_stats.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:weather/weather.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<EventUsageInfo> events = [];
  Map<String?, NetworkInfo?> _netInfoMap = Map();

  @override
  void initState() {
    super.initState();

    initUsage();
  }

  Future<void> initUsage() async {
    try {
      UsageStats.grantUsagePermission();

      DateTime endDate = new DateTime.now();
      String? date;
      DateTime startDate;
      try{
        final response=await http.get(Uri.parse("http://172.18.127.167:8000/programUsed/"));
        if(response.statusCode == 201 || response.statusCode == 200)
          {
            Map<String, String> json = Map.castFrom(jsonDecode(response.body));
            String? date = json['last_time_saved'];
            startDate = DateTime.parse(date!);
          }
        else{
          print("=========GET UNSUCCESSFUL=====");
          print(response.body);
          startDate = endDate.subtract(Duration(days: 1));
        }
      }
      catch(e){
        print("I am in exception!!!");
        print(e);
        startDate = endDate.subtract(Duration(days: 1));
      }

      print("Enddate: ${endDate}");
      // DateTime startDate = endDate.subtract(Duration(days: 1));

      List<EventUsageInfo> queryEvents =
          await UsageStats.queryEvents(startDate, endDate);
      List<NetworkInfo> networkInfos = await UsageStats.queryNetworkUsageStats(
        startDate,
        endDate,
        networkType: NetworkType.all,
      );

      Map<String?, NetworkInfo?> netInfoMap = Map.fromIterable(networkInfos,
          key: (v) => v.packageName, value: (v) => v);

      List<UsageInfo> t = await UsageStats.queryUsageStats(startDate, endDate);

      List<Map<String, String?>> jsonMap=[];
      for (var i in t) {
        if (double.parse(i.totalTimeInForeground!) > 0) {
          print("Package Name: ${i.packageName}");

          print(
              "FirstTimeStamp: ${DateTime.fromMillisecondsSinceEpoch(int.parse(i.firstTimeStamp!)).toIso8601String()}");

          print(
              "LastTimeStamp: ${DateTime.fromMillisecondsSinceEpoch(int.parse(i.lastTimeStamp!)).toIso8601String()}");

          print(
              "lastTimeUsed: ${DateTime.fromMillisecondsSinceEpoch(int.parse(i.lastTimeUsed!)).toIso8601String()}");
          print(
              "Total Time in foreground: ${int.parse(i.totalTimeInForeground!) / 1000 / 60}");

          print('-----\n');

          jsonMap.add(<String, String?>{
            'last_time_saved': endDate.toString(),
            'package_name': i.packageName,
            'first_time_stamp': DateTime.fromMillisecondsSinceEpoch(
                int.parse(i.firstTimeStamp!))
                .toIso8601String(),
            'last_time_stamp': DateTime.fromMillisecondsSinceEpoch(
                int.parse(i.lastTimeStamp!))
                .toIso8601String(),
            'last_time_used': DateTime.fromMillisecondsSinceEpoch(
                int.parse(i.lastTimeUsed!))
                .toIso8601String(),
            'time_in_foreground':
            (int.parse(i.totalTimeInForeground!) / 1000 / 60)
                .toString(),
          });


        }
      }

      try {
        final response = await http.post(
          Uri.parse("http://172.18.127.167:8000/programUsed/"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(jsonMap),
        );

        if (response.statusCode == 201) {
          print("=========SUCCESSFUL=====");
          print(response.body);
        } else {
          print("=========POST UNSUCCESSFUL=====");
          print(response.body);
        }
      } catch (e) {
        print('ERROR ${e}');
      }

      this.setState(() {
        print("I am under state");
        events = queryEvents.reversed.toList();
        _netInfoMap = netInfoMap;
      });
    } catch (err) {
      print(err);
    }
  }

  // Future<String> getLocation(){
  //
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Usage Stats"), actions: [
          IconButton(
            onPressed: UsageStats.grantUsagePermission,
            icon: Icon(Icons.settings),
          )
        ]),
        body: Container(
          child: RefreshIndicator(
            onRefresh: initUsage,
            child: ListView.separated(
              itemBuilder: (context, index) {
                var event = events[index];
                var networkInfo = _netInfoMap[event.packageName];
                return ListTile(
                  title: Text(events[index].packageName!),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Last time used: ${DateTime.fromMillisecondsSinceEpoch(int.parse(events[index].timeStamp!)).toIso8601String()}"),
                      networkInfo == null
                          ? Text("Unknown network usage")
                          : Text("Received bytes: ${networkInfo.rxTotalBytes}\n" +
                              "Transfered bytes : ${networkInfo.txTotalBytes}"),
                    ],
                  ),
                  trailing: Text(events[index].eventType!),
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: events.length,
            ),
          ),
        ),
      ),
    );
  }
}
