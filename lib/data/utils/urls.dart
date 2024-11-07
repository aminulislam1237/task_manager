class urls{
  static const String _baseurl ='http://35.73.30.144:2005/api/v1';
  static const String registration = '$_baseurl/Registration';
  static const String login = '$_baseurl/login';
  static const String addnewtask = '$_baseurl/createTask';
  static const String newtasklist = '$_baseurl/listTaskByStatus/New';
  static const String completedtasklist = '$_baseurl/listTaskByStatus/Completed';
  static const String cancelledtasklist = '$_baseurl/listTaskByStatus/Cancelled';
  static const String progresstasklist = '$_baseurl/listTaskByStatus/Progress';
  static const String UpdateProfile = '$_baseurl/ProfileUpdate';
  static const String DeleteTasklist = '$_baseurl/deleteTask';
  static String changeStatus(String taskId, String status) =>
      '$_baseurl/updateTaskStatus/$taskId/$status';
}