import '../repos/connect.dart';

class UserService {
  Connect _connect = Connect();

  Future<void> getUserColors({required String userUid}) async {
    try {
      var _res = await this._connect.reqGetServer(path: "/users/data?uid=${userUid}", cb: (ReqModel rm) {});
      print("getting user colors");
      print(_res);
    } catch (e) {
      print(e);
      throw e;
    }
  }
}