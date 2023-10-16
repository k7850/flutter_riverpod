import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_04/post_repository.dart';
import 'package:flutter_riverpod_04/session_provider.dart';

// 1. 창고 데이터 (model)
// 창고의 데이터가 하나면 객체로 안 하고 창고의 필드로 해도 되지만, 그냥 무조건 객체로 하는 걸로 패턴을 정함
class PostModel {
  int id;
  int userId;
  String title;

  PostModel({required this.id, required this.userId, required this.title});

  PostModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        userId = json["userId"],
        title = json["title"];
}

// 2. 창고 (view model)
class PostViewModel extends StateNotifier<PostModel?> {
  Ref ref;

  // 생성자를 통해 상태를 부모에게 전달
  PostViewModel(super.state, this.ref);

  // 상태 초기화 메서드 (필수)
  void init() async {
    // 통신 코드
    PostModel postModel = await PostRepository().fetchPost(1);
    state = postModel;
  }

  //상태 변경 (로그인 유무)
  Future<bool> change(int page) async {
    SessionUser sessionUser = ref.read(sessionPrivider);

    if (sessionUser.isLogin) {
      PostModel postModel = await PostRepository().fetchPost(page);
      state = postModel; // 이게 없으면 값 변해도 화면에 안그려짐
      return true;
    }
    print("로그인필요");
    return false;
  }
}

// 3. 창고 관리자 (provider)
// 통신이면 FutreProvider를 써야 하지만, 그냥 null로 그려놓고 통신 끝나서 받으면 다시 그리는 방식
// autoDispose : ui가 파괴될때 자동으로 데이터 없애줌
final postProvider = StateNotifierProvider.autoDispose<PostViewModel, PostModel?> // 창고이름, 창고데이터타입
    ((ref) {
  return PostViewModel(null, ref)..init();
});
