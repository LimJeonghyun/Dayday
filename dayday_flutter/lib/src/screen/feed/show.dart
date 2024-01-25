import 'package:dayday_flutter/src/model/feed_model.dart';
import 'package:dayday_flutter/src/screen/feed/edit.dart';
import 'package:dayday_flutter/src/widget/feed_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedShow extends StatefulWidget {
  final FeedModel feed;

  const FeedShow(this.feed, {super.key});

  @override
  State<FeedShow> createState() => _FeedShowState();
}

class _FeedShowState extends State<FeedShow> {
  bool isMe = false;

  @override
  void initState() {
    super.initState();
    _checkMine();
  }

  _checkMine() async {
    bool result = await feedController.feedShow(widget.feed.id!);
    setState(() {
      isMe = result;
    });
  }

  _edit() {
    Get.to(() => FeedEdit(widget.feed));
  }

  _delete() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('일기 삭제'),
          content: const Text('정말 삭제 하시겠습니다'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () async {
                bool result = await feedController.feedDelete(widget.feed.id!);
                if (result) {
                  Get.until((route) => route.isFirst);
                }
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('일기보기'),
          actions: isMe
              ? [
                  IconButton(
                    onPressed: _delete,
                    icon: const Icon(Icons.delete_outline),
                  ),
                  IconButton(
                    onPressed: _edit,
                    icon: const Icon(Icons.edit_outlined),
                  ),
                ]
              : null),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                    color: Colors.grey[200],
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      widget.feed.title ?? '제목없음',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      widget.feed.content ?? '내용없음',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
