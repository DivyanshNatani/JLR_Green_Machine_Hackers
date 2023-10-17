// // import 'dart:async';
// // import 'dart:io' show Platform;
// // import 'package:flutter/foundation.dart' show kIsWeb;
// // import 'package:flutter/material.dart';
// // import 'package:flutter_tts/flutter_tts.dart';
// //
// //
// // class tts_handle extends StatefulWidget {
// //   @override
// //   _MyAppState createState() => _MyAppState();
// // }
// // enum TtsState { playing, stopped, paused, continued }
// //
// // class _MyAppState extends State<tts_handle> {
// //   late FlutterTts flutterTts;
// //   String? language;
// //   String? engine;
// //   double volume = 0.5;
// //   double pitch = 1.0;
// //   double rate = 0.5;
// //   bool isCurrentLanguageInstalled = false;
// //
// //   String? _newVoiceText;
// //   int? _inputLength;
// //
// //   TtsState ttsState = TtsState.stopped;
// //
// //   get isPlaying => ttsState == TtsState.playing;
// //   get isStopped => ttsState == TtsState.stopped;
// //   get isPaused => ttsState == TtsState.paused;
// //   get isContinued => ttsState == TtsState.continued;
// //
// //   bool get isIOS => !kIsWeb && Platform.isIOS;
// //   bool get isAndroid => !kIsWeb && Platform.isAndroid;
// //   bool get isWindows => !kIsWeb && Platform.isWindows;
// //   bool get isWeb => kIsWeb;
// //
// //   @override
// //   initState() {
// //     super.initState();
// //     initTts();
// //   }
// //
// // //
// // // setState();
// // //
// // // initTts() {
// // //
// // //   flutterTts = FlutterTts();
// // //   flutterTts.setInitHandler(() {
// // //     setState(() {
// // //       print("TTS Initialized");
// // //     });
// // //   });
// // //
// // // }
// // //
// // //
// // // Future getDefaultEngine() async {
// // //   var engine = await flutterTts.getDefaultEngine;
// // //   if (engine != null) {
// // //     print(engine);
// // //   }
// // // }
// // //
// // // Future getDefaultVoice() async {
// // //   var voice = await flutterTts.getDefaultVoice;
// // //   if (voice != null) {
// // //     print(voice);
// // //   }
// // // }
// // //
// // // Future speak() async {
// // //   // await flutterTts.setVolume(volume);
// // //   // await flutterTts.setSpeechRate(rate);
// // //   // await flutterTts.setPitch(pitch);
// // //
// // //   // double volume = 1;
// // //   // double pitch = 1;
// // //   // double rate = 1;
// // //   String _newVoiceText = 'Hello World';
// // //   if (_newVoiceText != null) {
// // //     print('SPEAKING');
// // //     if (_newVoiceText!.isNotEmpty) {
// // //       await flutterTts.speak(_newVoiceText!);
// // //     }
// // //   }
// // // }
//
//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
//
// class TextToSpeechService {
//   final FlutterTts flutterTts = FlutterTts();
//
//   Future speak(String text) async {
//     await flutterTts.speak(text);
//   }
//
//   Future stop() async {
//     await flutterTts.stop();
//   }
// }
//
// // void main() {
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: Text('Text-to-Speech'),
// //         ),
// //         body: Center(
// //           child: ElevatedButton(
// //             onPressed: () {
// //               TextToSpeechService().speak('Hello, how are you?');
// //             },
// //             child: Text('Speak'),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

enum TtsState { playing, stopped, paused, continued }

class tts_handle extends StatefulWidget {

  @override
  _tts_handle createState() => _tts_handle();

  GetTTSHandle()
  {
    return
  }
}

class _tts_handle extends State<tts_handle> {
  late FlutterTts flutterTts;
  String? language;
  String? engine;

  String? _newVoiceText;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;


  @override
  initState() {
    super.initState();
    initTts();
  }

  initTts() {
    flutterTts = FlutterTts();

    _setAwaitOptions();
    _getDefaultEngine();
    _getDefaultVoice();

    flutterTts.setStartHandler(() {
      setState(() {
        print("Playing");
        ttsState = TtsState.playing;
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

  Future _speak() async {
    await flutterTts.setVolume(1);
    await flutterTts.setSpeechRate(1);
    await flutterTts.setPitch(1);

    _newVoiceText = 'Hello Hello Hello';
    if (_newVoiceText != null) {
      if (_newVoiceText!.isNotEmpty) {
        await flutterTts.speak(_newVoiceText!);
      }
    }
  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }
}