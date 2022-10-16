class TaskModel {
  final String id;
  final String title;
  final String note;
  final String date;
  final String starttime;
  final String endtime;
  final String assignedTo;
  final String status;

  TaskModel({
    this.id = "",
    this.title = "",
    this.note = "",
    this.date = "",
    this.starttime = "",
    this.endtime = "",
    this.assignedTo = "",
    this.status = "",
  });

  factory TaskModel.fromjson(Map<String, dynamic> json, String id) {
    return TaskModel(
      id: id,
      title: json['title'],
      note: json['note'],
      date: json['date'],
      starttime: json['starttime'],
      endtime: json['endtime'],
      assignedTo: json['assignedTo'],
      status: json['status'],
    );
  }

  Map<String, dynamic> tojson() {
    return {
      'title': title,
      'note': note,
      'date': date,
      'starttime': starttime,
      'endtime': endtime,
      'assignedTo': assignedTo,
      'status': status,
    };
  }
}
