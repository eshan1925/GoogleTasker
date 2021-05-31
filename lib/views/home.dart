import 'package:flutter/material.dart';
import 'package:googletasker/views/feedback_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<FeedbackModel> feedbacks = [];
  getFeedbackFromSheet() async {
    var raw = await http.get(Uri.parse("https://bit.ly/3wKY56b"));
    var jsonFeedback = convert.jsonDecode(raw.body);
    print('Jason Feedback:\n $jsonFeedback');
    // feedbacks=jsonFeedback.map((json)=>FeedbackModel.fromJson(json));
    jsonFeedback.forEach((element) {
      print(element);
      FeedbackModel feedbackModel = new FeedbackModel();
      feedbackModel.Sub_code = element['Sub_code'];
      feedbackModel.Assign = element['Assign'];
      feedbackModel.submisssion_time = element['submission_time'];
      feedbackModel.submission_date = element['submission_date'];
      feedbackModel.Timestamp = element['Timestamp'];
      feedbackModel.Type = element['Type'];
      feedbackModel.Work = element['Work'];
      String checker = element['Timestamp'].toString();
      if (checker.length > 0) {
        feedbacks.add(feedbackModel);
      }
    });
    print('length of feedbacks: ${feedbacks.length}');
    // print('$feedbacks');
  }

  @override
  void initState() {
    getFeedbackFromSheet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
        title: Text(
          'Tasks',
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 2,
          ),
        ),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: feedbacks.length,
            itemBuilder: (context, index) {
              return FeedbackTile(
                Sub_code: feedbacks[index].Sub_code,
                Type: feedbacks[index].Type,
                Assign: feedbacks[index].Assign,
                Work: feedbacks[index].Work,
                submission_date: feedbacks[index].submission_date,
                submisssion_time: feedbacks[index].submisssion_time,
              );
            }),
      ),
    );
  }
}

// ignore: must_be_immutable
class FeedbackTile extends StatelessWidget {
  // ignore: non_constant_identifier_names
  var Timestamp;
  // ignore: non_constant_identifier_names
  var Assign;
  // ignore: non_constant_identifier_names
  var Sub_code;
  // ignore: non_constant_identifier_names
  var Type;
  // ignore: non_constant_identifier_names
  var Work;
  // ignore: non_constant_identifier_names
  var submission_date;
  // ignore: non_constant_identifier_names
  var submisssion_time;
  // ignore: non_constant_identifier_names
  FeedbackTile(
      {this.Timestamp,
      this.Assign,
      this.Sub_code,
      this.submission_date,
      this.submisssion_time,
      this.Type,
      this.Work});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                Sub_code,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              child: Text(
                Type,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              child: Text(
                Assign,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        Container(
          child: Text(
            Work,
            style: TextStyle(color: Colors.white),
          ),
        ),
        Container(
          child: Text('Submission Date: $submission_date',style: TextStyle(color: Colors.white),),
        ),
        Container(
          child: Text('Submission Time: $submisssion_time',style: TextStyle(color: Colors.white),),
        )
      ],
    ));
  }
}
