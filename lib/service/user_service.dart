import '../class/event_class.dart';
import '../class/user_color.dart';
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

  Future<Map<String, dynamic>?> colorActions({required String userUid, required UserColor uc, required String action}) async {
    try {
      final Map<String, dynamic>? _res = await this._connect.reqPostServer(
        path: "/users/colors/$action",
        cb: (ReqModel rm) {},
        body: {
          "userUid": userUid,
          "userColor": uc.toJson(),
        },
      );
      assert(_res != null, "server is not connected");
      if (_res == null) return null;
      return _res["data"];
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<Map<String, dynamic>?> eventActions({required String userUid, required Event event, required String action}) async {
    try {
      final Map<String, dynamic>? _res = await this._connect.reqPostServer(
        path: "/users/event/$action",
        cb: (ReqModel rm) {},
        body: {
          "userUid": userUid,
          "event": action == "add" ? event.toJsonAll() : event.toJsonUid(),
        },
      );
      assert(_res != null, "server is not connected");
      if (_res == null) return null;
      return _res["data"];
    } catch (e) {
      print(e);
      throw e;
    }
  }
}