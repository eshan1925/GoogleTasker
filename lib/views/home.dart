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
    var raw = await http.get(Uri.parse(
        "https://script.googleusercontent.com/macros/echo?user_content_key=C91kSdLbXPoFKAY-YLbdUqioH1YTlbKRTziHd7PbhwweIiNwLEX3c7NHHISHIZq2WizxyKH7LKpY-vwCVdF5as3E9IqOzD7Cm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnArUvaMnv7-LTPDsGvue1k5MSSKDTT_DYxALR5cLZ8Dx90fVoKk_1FEf3j6_7Dht1TaVTN6IJYtJYAzax7T2vzXsScRCUs5fVQ&lib=MdyXkmKV_jn7b4t1pnyxdpJsyNKQVxPkG#b"));
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
        backgroundColor: Colors.blueAccent,
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
  _FeedbackTileState createState() => _FeedbackTileState();
}

class _FeedbackTileState extends State<FeedbackTile> {
  Color Condition(){
    if(widget.Assign=='TASK'){
      return Colors.lightGreen.shade300;
    }
    else{
      return Colors.red.shade300;
    }
  }

  bool checkedValue = false;

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
            Checkbox(value: checkedValue, onChanged: (bool? value) {
              setState(() {
                checkedValue = value!;
              });
            },),
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
