import 'package:dayday_flutter/src/screen/auth/login.dart';
import 'package:dayday_flutter/src/screen/auth/register.dart';
import 'package:dayday_flutter/src/screen/feed/create.dart';
import 'package:flutter/material.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    const SizedBox(height: 150),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('asset/golden.png',
                            width: 200, height: 200),
                        const SizedBox(height: 20),
                        const Text(
                          'DayDay',
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // 시작하기를 클릭하면 회원가입 창으로 이동
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Login(),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffD4A7FB),
                        ),
                        child: const Text(
                          '로그인',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // 시작하기를 클릭하면 회원가입 창으로 이동
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Register(),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffD4A7FB),
                        ),
                        child: const Text(
                          '회원가입',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ))));
  }
}
