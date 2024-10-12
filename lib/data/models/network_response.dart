class networkResponse{
  final bool isSuccess;
  final int statuscode;
  dynamic responseDate;
  String errormassage;

  networkResponse({required this.isSuccess, required this.statuscode,this.responseDate,this.errormassage='something went worng'});


}