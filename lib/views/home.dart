import 'package:flutter/material.dart';
import 'package:googletasker/views/feedback_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
// ignore: import_of_legacy_library_into_null_safe
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<FeedbackModel> feedbacks = <FeedbackModel>[];
  Future<List> getFeedbackFromSheet() async {
    var raw = await http.get(Uri.parse(
        "https://script.google.com/macros/s/AKfycbydFtb3fFBp-Ev2ma4mu99dNcS88PDTUQiGkEYN5Fhztas5RZbOB4cf4hWv1IoHx97J/exec"));
    var jsonFeedback = convert.jsonDecode(raw.body);
    // feedbacks=jsonFeedback.map((json)=>FeedbackModel.fromJson(json));
    jsonFeedback.forEach((element) {
      print(element);
      FeedbackModel feedbackModel = new FeedbackModel();
      feedbackModel.Checkedval = element['Checkedval'];
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
    return feedbacks;
    // print('$feedbacks');
  }

  @override
  void initState() {
    super.initState();
    getFeedbackFromSheet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          launch(
              "https://docs.google.com/forms/d/e/1FAIpQLScoM54rXH3tNDb_EbP3KsG5gqC-1Lg4DPZhY2ntULbkrHNhiA/viewform");
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
        title: Text(
          'Pending Tasks',
          style: TextStyle(
            color: Colors.white,
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
                Checkedval: feedbacks[index].Checkedval,
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
class FeedbackTile extends StatefulWidget {
  // ignore: non_constant_identifier_names
  var Checkedval;
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
      // ignore: non_constant_identifier_names
      {this.Timestamp,
      // ignore: non_constant_identifier_names
      this.Assign,
      // ignore: non_constant_identifier_names
      this.Sub_code,
      // ignore: non_constant_identifier_names
      this.submission_date,
      // ignore: non_constant_identifier_names
      this.submisssion_time,
      // ignore: non_constant_identifier_names
      this.Type,
      // ignore: non_constant_identifier_names
      this.Work,
      this.Checkedval});

  @override
  _FeedbackTileState createState() => _FeedbackTileState();
}

class _FeedbackTileState extends State<FeedbackTile> {
  // ignore: non_constant_identifier_names
  Color Condition() {
    if (widget.Checkedval == false) {
      if (widget.Assign == 'TASK') {
        return Colors.lightGreen.shade300;
      } else {
        return Colors.red.shade300;
      }
    } else {
      return Colors.white12;
    }
  }

  bool checkedValue = false;
  bool ticked() {
    if (widget.Checkedval == true) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 7),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              value: ticked(),
              onChanged: (bool? value) {
                setState(() {
                  checkedValue = !checkedValue;
                });
              },
              checkColor: Colors.black,
              activeColor: Colors.white,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Condition(),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              widget.Sub_code,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                          ),
                          Container(
                            child: Text(
                              widget.Type,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                          ),
                          Container(
                            child: Text(
                              widget.Assign,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          widget.Work,
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Submission Date: ${widget.submission_date}',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Submission Time: ${widget.submisssion_time}',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
