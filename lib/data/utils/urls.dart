class urls{
  static const String _baseurl ='http://152.42.163.176:2006/api/v1';
  static const String registration = '$_baseurl/Registration';
  static const String login = '$_baseurl/login';
  static const String addnewtask = '$_baseurl/createTask';
  static const String newtasklist = '$_baseurl/listTaskByStatus/New';
  static const String completedtasklist = '$_baseurl/listTaskByStatus/Completed';
  static const String cancelledtasklist = '$_baseurl/listTaskByStatus/Cancelled';
  static const String progresstasklist = '$_baseurl/listTaskByStatus/Progress';
}