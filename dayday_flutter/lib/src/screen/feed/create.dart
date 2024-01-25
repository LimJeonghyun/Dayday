import 'package:dayday_flutter/src/controller/feed_controller.dart';
import 'package:dayday_flutter/src/widget/image_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedCreate extends StatefulWidget {
  const FeedCreate({super.key});

  @override
  State<FeedCreate> createState() => _FeedCreateState();
}

class _FeedCreateState extends State<FeedCreate> {
  final feedController = Get.put(FeedController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final String title = _titleController.text;
      final String content = _contentController.text;

      bool result = await feedController.feedCreate(title, content);

      if (result) {
        Get.back();
      }
    }
  }

  var inputDecoration = const InputDecoration(border: OutlineInputBorder());
  TextStyle labelTextStyle =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('오늘의 일기 쓰기')),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            // Column(
            //   children: [
            //     Text()
            //   ],
            // ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Text('제목', style: labelTextStyle),
                TextFormField(
                    controller: _titleController, decoration: inputDecoration),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Text('내용', style: labelTextStyle),
                TextFormField(
                  maxLines: 5,
                  decoration: inputDecoration,
                  controller: _contentController,
                ),
                const SizedBox(height: 20),
              ],
            ),
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffD4A7FB),
              ),
              child: const Text(
                '작성 완료',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
