

class FeedbackModel{
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
  FeedbackModel({this.Checkedval,this.Timestamp,this.Assign,this.Sub_code,this.submission_date,this.submisssion_time,this.Type,this.Work});
  
  factory FeedbackModel.fromJson(dynamic json){
    return FeedbackModel(
      Checkedval: "${json['Checkedval']}",
      Timestamp: "${json['Timestamp']}",
      Assign: "${json['Assign']}",
      Sub_code: "${json['Sub_code']}",
      Type: "${json['Type']}",
      Work: "${json['Work']}",
      submission_date: "${json['submission_date']}",
      submisssion_time: "${json['submission_time']}",
    );
  }
  Map toJson()=> {
    "CheckedVal":Checkedval,
    "TimeStamp": Timestamp,
    "Assign": Assign,
    "Sub_code":Sub_code,
    "Type": Type,
    "Work": Work,
    "submission_date": submission_date,
    "submission_time": submisssion_time,
  };
}

