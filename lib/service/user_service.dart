import '../repos/connect.dart';

class UserService {
  Connect _connect = Connect();

  Future<Map<String, dynamic>?> getUserColors({required String userUid}) async {
    try {
      final Map<String, dynamic>? _res = await this._connect.reqGetServer(path: "/users/data?uid=${userUid}", cb: (ReqModel rm) {});
      assert(_res != null, "server is not connected");
      if (_res == null) return null;
      return _res["data"];
    } catch (e) {
      print(e);
      throw e;
    }
  }
}