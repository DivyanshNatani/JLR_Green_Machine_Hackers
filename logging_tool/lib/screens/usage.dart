import 'package:flutter/material.dart';
import 'dart:async';
import 'package:usage_stats/usage_stats.dart';
import 'package:permission_handler/permission_handler.dart';

class UsageApp extends StatefulWidget {
  const UsageApp({super.key});

  @override
  State<UsageApp> createState() => _UsageAppState();
}

class _UsageAppState extends State<UsageApp> {
  List<EventUsageInfo> events = [];
  Map<String?, NetworkInfo?> _netInfoMap = Map();

  @override
  void initState() {
    super.initState();

    initUsage();
  }

  Future<void> initUsage() async {
    try {
      print("Hello!!");
      UsageStats.grantUsagePermission();

      DateTime endDate = new DateTime.now();
      DateTime startDate = endDate.subtract(Duration(days: 1));

      print(endDate);
      print(startDate);


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

      for (var i in t) {
        if (double.parse(i.totalTimeInForeground!) > 0) {
          print(
              DateTime.fromMillisecondsSinceEpoch(int.parse(i.firstTimeStamp!))
                  .toIso8601String());

          print(DateTime.fromMillisecondsSinceEpoch(int.parse(i.lastTimeStamp!))
              .toIso8601String());

          print(i.packageName);
          print(DateTime.fromMillisecondsSinceEpoch(int.parse(i.lastTimeUsed!))
              .toIso8601String());
          print(int.parse(i.totalTimeInForeground!) / 1000 / 60);

          print('-----\n');
        }
      }

      this.setState(() {
        events = queryEvents.reversed.toList();
        _netInfoMap = netInfoMap;
      });
    } catch (err) {

      print("In Catch");
      print(err);
    }
  }

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
        body: Column(
          children: [
            Container(
              child: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    bool granted = await Permission.location.isGranted;
                    if(!granted)
                      {
                        PermissionStatus status = await Permission.location.request();
                        if(status == PermissionStatus.granted)
                          {
                            print("Granted");
                          }
                        else{
                          print("Permission not granted");
                        }
                      }
                    else{
                      print("Permission already exist");
                    }

                  },
                  child: Text("Button Text"),
                ),
              ),
            ),

            Container(
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
          ],
        ),
      ),
    );
  }
}
