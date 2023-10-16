// 창고 데이터
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionUser {
  String? jwt;
  bool isLogin;

  SessionUser({this.isLogin = false});
}

// 창고
// 화면 변경 없을땐 안만들어도 되니까 패스

// 창고 관리자
final sessionPrivider = Provider<SessionUser>((ref) {
  return SessionUser();
});
