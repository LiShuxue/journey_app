import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE), // 整个页面的背景
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0), // 水平方向有个padding
        child: SingleChildScrollView(
          // 页面所有的内容从上到下排列
          child: Column(
            children: [
              Container(
                width: double.infinity, // 填充父元素的空间，相当于width 100%
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                // 这个container中元素也是从上到下排列
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text('关于我', style: TextStyle(fontSize: 16)),
                    // 创建一个细的线条
                    Container(
                      height: 1.0,
                      width: double.infinity, // 填充父元素的空间，相当于width 100%
                      color: const Color(0xFF6D6D6D),
                    ),

                    const SizedBox(height: 10),
                    const Text('前端工程师',
                        style: TextStyle(color: Color(0xFF6D6D6D))),
                    const SizedBox(height: 10),
                    const Text('熟悉Vue，React，移动开发，混合开发',
                        style: TextStyle(color: Color(0xFF6D6D6D))),
                    const SizedBox(height: 10),
                    const Text('热爱编程，喜欢探索，追求技术',
                        style: TextStyle(color: Color(0xFF6D6D6D))),
                    const SizedBox(height: 30),

                    const Text('联系我', style: TextStyle(fontSize: 16)),
                    // 创建一个细的线条
                    Container(
                      height: 1.0,
                      width: double.infinity, // 填充父元素的空间，相当于width 100%
                      color: const Color(0xFF6D6D6D),
                    ),

                    const SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Email: ',
                            style: TextStyle(color: Color(0xFF6D6D6D)),
                          ),
                          TextSpan(
                            text: '1149926505@qq.com',
                            style: const TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launchUrl(
                                    Uri.parse('mailto:1149926505@qq.com'));
                              },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Blog: ',
                            style: TextStyle(color: Color(0xFF6D6D6D)),
                          ),
                          TextSpan(
                            text: 'https://lishuxue.site',
                            style: const TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launchUrl(Uri.parse('https://lishuxue.site'));
                              },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Github: ',
                            style: TextStyle(color: Color(0xFF6D6D6D)),
                          ),
                          TextSpan(
                            text: 'https://github.com/LiShuxue',
                            style: const TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launchUrl(
                                    Uri.parse('https://github.com/LiShuxue'));
                              },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity, // 填充父元素的空间，相当于width 100%
                decoration: const BoxDecoration(
                  color: Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                // 这个container中元素也是从上到下排列
                child: const Image(
                  image: NetworkImage(
                      'https://cdn.lishuxue.site/resume/images/MyWechat.png'),
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
