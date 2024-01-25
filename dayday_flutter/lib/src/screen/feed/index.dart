import 'package:dayday_flutter/src/model/feed_model.dart';
import 'package:dayday_flutter/src/screen/feed/show.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedListItem extends StatelessWidget {
  final FeedModel model;
  const FeedListItem(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => FeedShow(model));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 내용
          Expanded(
              child: Container(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(model.title ?? '제목없음',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Text(model.content ?? '내용없음'),
                      const SizedBox(height: 6),
                    ],
                  ))),
        ],
      ),
    );
  }
}
