import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse, Document;

Future<void> fetchLiveCricketScores() async {
  print('CCCCCCCCCCCCCCCCCCCCCCCCC');
  final response = await http.get(Uri.parse('http://livescore-api.com/api-client/scores/live.json?key=IShST35gkD8W5vWe&secret=SPNtywfjNcxAfgTX8aP1eViyyquEWrTO'));
  if (response.statusCode == 200) {
    print(response.body);
    final document = parse(response.body);
    print(document.text);
    final liveScoreElements = document.querySelectorAll('.cb-col.cb-col-100.cb-ltst-wgt-hdr');
    for (var element in liveScoreElements) {
        print(element.text);
      }

      } else {
    throw Exception('Failed to load live cricket scores');
  }
}

