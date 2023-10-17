import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

enum TtsState { playing, stopped, paused, continued }

class BackScreen extends StatefulWidget {
  const BackScreen({super.key});

  @override
  State<BackScreen> createState() => _BackScreenState();
}

class _BackScreenState extends State<BackScreen> with TickerProviderStateMixin {

  List<String> app_decider = ["assets/maps.png", "assets/Contacts.png", "assets/spotify.png"];

  // Query from User: Hey whats latest in Euro 2024
  String first_conversation = 'Hey! Do you want to head to the Gaydon office?';

  // Query from Car:
  String second_conversation = 'Spain Qualified for Euro 2024';

  int dialouge_context=0;

  final TtsState _ttsState = TtsState.stopped;
  late FlutterTts flutterTts;

  @override
  Widget build(BuildContext context) {
    initTts();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title:Center(
            child: Text('Home Screen Widget'),
          ),
          backgroundColor: Colors.black54,

        ),
        body:  Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.blueAccent,
                      child: Center(
                        // child: Text(
                        //   app_decider[1],
                        //   textAlign: TextAlign.center,
                        //   style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                        // ),
                        child: Image(image: AssetImage(app_decider[1]), height: 200),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.deepPurpleAccent,
                      child: Center(
                        // child: Text(
                        //   app_decider[2],
                        //   textAlign: TextAlign.center,
                        //   style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                        // ),
                        child: Image(image: AssetImage(app_decider[2]), height: 200),
                      ),
                    ),
                  )
                ],
              ),
              color: Colors.black12,
              constraints: BoxConstraints.expand(),
            ),
          ),
          Expanded(
            child: Container(
              child: InkWell(
                child: Center(
                    child: Image(image: AssetImage(app_decider[0]), height: 400)
                ),
                onTap: () => changeScript(context)
              ),
              color: Colors.amberAccent,
              constraints: BoxConstraints.expand(),
            ),
          ),
        ],
      ),
    ),
    ),
    );
  }

  initTts() {
    flutterTts = FlutterTts();

    _setAwaitOptions();
    _getDefaultEngine();
    _getDefaultVoice();

    flutterTts.setStartHandler(() {
      setState(() {
        print("Playing");
      });
    });

    flutterTts.setInitHandler(() {
      setState(() {
        print("TTS Initialized");
      });
    });
  }

  Future _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }

  Future _getDefaultVoice() async {
    var voice = await flutterTts.getDefaultVoice;
    if (voice != null) {
      print(voice);
    }
  }

  Future _speak(String text) async {
    await flutterTts.setVolume(1);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1);

    String newVoiceText = 'Hello Hello Hello';
    if (newVoiceText != null) {
      if (newVoiceText!.isNotEmpty) {
        await flutterTts.speak(text);
      }
    }
  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future<void> _dialogBuilder(BuildContext context, String text1) {
    print("Click");
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(text1, style: TextStyle(fontSize: 30),),
      // content: Text(text2, style: TextStyle(fontSize: 20),),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'No'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'Yes'),
          child: const Text('OK'),
        ),
      ],
    ),
  );

  }


  Future<void> _loaderBuilder(BuildContext context) {
    print("Click");

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          SpinKitSquareCircle(
            color: Colors.white,
            size: 50.0,
            controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200),  ),

          )
    );
  }

    void changeScript(BuildContext context) async{
    print("dialouge_context ${dialouge_context}");
    switch(dialouge_context) {
      case 0: _dialogBuilder(context, first_conversation);
      _speak(first_conversation);
      break;
      case 1: _dialogBuilder(context,  second_conversation);
      _speak(second_conversation);
      break;
      case 2: function2(context);
      break;

    }
    dialouge_context++;

   // var duration = const Duration(seconds: 10);
   // sleep(duration);
   // _dialogBuilder(context, "We have noticed you want App 1 back. Would you like to replace?", 1);

  }

void function2(BuildContext context) async{
  _loaderBuilder(context);
  Future.delayed(Duration(seconds: 3), () {
    Navigator.pop(context);
    setState(() {
      app_decider[1] = "assets/goal.png";
    });
  });

  // Navigator.pop(context, 'Yes');
}

}




