class networkResponse{
  final bool isSuccess;
  final int statuscode;
  dynamic responseDate;
  String errormassage;

  networkResponse(required .this.isSuccess, this.statuscode);

}