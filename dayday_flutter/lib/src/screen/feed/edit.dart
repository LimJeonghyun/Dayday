import 'package:dayday_flutter/src/model/feed_model.dart';
import 'package:dayday_flutter/src/widget/feed_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedEdit extends StatefulWidget {
  final FeedModel model;
  const FeedEdit(this.model, {super.key});

  @override
  State<FeedEdit> createState() => _FeedEditState();
}

class _FeedEditState extends State<FeedEdit> {
  int? fileId;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  var inputDecoration = const InputDecoration(border: OutlineInputBorder());
  var labelTextStyle =
      const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final String title = _titleController.text;
      final String content = _contentController.text;

      bool result =
          await feedController.feedUpdate(widget.model.id!, title, content);
      if (result) {
        Get.until((route) => route.isFirst);
      }
    }
  }

  void initData() async {
    setState(() {
      _titleController.text = widget.model.title ?? '';
      _contentController.text = widget.model.content ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  // void uploadImage() async {
  //   final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  //   if (image == null) return;
  //   int id = await feedController.upload(image.name, image.path);
  //   setState(() {
  //     fileId = id;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('일기 수정하기')),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
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
