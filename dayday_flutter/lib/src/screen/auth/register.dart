import 'package:dayday_flutter/src/controller/user_controller.dart';
import 'package:dayday_flutter/src/screen/auth/intro.dart';
import 'package:dayday_flutter/src/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final userController = Get.put(UserController());
  final RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text;
      final String password = _passwordController.text;
      final String name = _nameController.text;

      bool result = await userController.register(email, name, password);

      if (result) {
        Get.offAll(() => const Intro());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원 가입'),
        backgroundColor: const Color(0xffD4A7FB),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            const SizedBox(height: 50),
            // 이메일 부분
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: '이메일',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '이메일을 입력하세요.';
                }
                if (!emailRegex.hasMatch(value)) {
                  return '이메일 형식에 맞지 않습니다.';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: '비밀번호',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: '이름',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 150,
              height: 50,
              child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffD4A7FB),
                  ),
                  child: const Text('회원 가입',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
