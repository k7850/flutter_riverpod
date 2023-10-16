import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_04/post_view_model.dart';
import 'package:flutter_riverpod_04/session_provider.dart';

class PostPage extends ConsumerWidget {
  int page;

  PostPage({this.page = 1, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // print("나빌드됨");

    PostModel? model = ref.watch(postProvider);
    if (model == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        body: Column(
          children: [
            AspectRatio(
              aspectRatio: 1 / 1,
              child: Image.network("https://picsum.photos/id/${model.id}/200/200", fit: BoxFit.cover),
            ),
            Text("id : ${model.id}, userId : ${model.userId}, title : ${model.title}"),
            ElevatedButton(
                onPressed: () async {
                  bool isNextPage = await ref.read(postProvider.notifier).change(page);
                  if (isNextPage == true) {
                    print("${page++}페이지");
                  }
                },
                child: Text("값변경")),
            ElevatedButton(
                onPressed: () {
                  ref.read(sessionPrivider).isLogin = true;
                  print("로그인성공");
                },
                child: Text("로그인")),
          ],
        ),
      );
    }
  }
}
