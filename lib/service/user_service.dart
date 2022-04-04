import '../repos/connect.dart';

class UserService {
  Connect _connect = Connect();

  Future<void> getUserColors({required int userUid}) async {
    try {
      await this._connect.reqGetServer(path: "users?uid=${userUid}", cb: (ReqModel rm) {});
    } catch (e) {
      print(e);
      throw e;
    }
  }
}