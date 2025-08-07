class ServiceException implements Exception{
  ServiceException.create(this._msg);
  String _msg;
  String getMsg() => _msg;
}

class ApiException implements Exception {
  ApiException.create(this._msg,this._code);
  String _msg;
  int _code = 0;
  int getCode() => _code;
  String getMsg() => _msg;
}