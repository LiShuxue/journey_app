import 'package:flutter/material.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE), // 整个页面的背景
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0), // 水平方向有个padding
        // 页面所有的内容从上到下排列
        child: Column(
          children: [
            // 第一个内容是占满整个行的Row，里面用Expanded才能充满。也可以将Container中用width: double.infinity, 填充父元素的空间。
            Row(
              children: [
                Expanded(
                  // 真正的元素，是这个container
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFF8F8F8),
                      // borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    // 这个container中元素也是从上到下排列
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 10),
                        Text('1', style: TextStyle(color: Color(0xFF6D6D6D))),
                        SizedBox(height: 10),
                        Text('2', style: TextStyle(color: Color(0xFF6D6D6D))),
                        SizedBox(height: 10),
                        Text('3', style: TextStyle(color: Color(0xFF6D6D6D))),
                        SizedBox(height: 10),
                        Text('4', style: TextStyle(color: Color(0xFF6D6D6D))),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // 创建一个具有特定宽高比的元素
            AspectRatio(
              aspectRatio: 1.5,
              child: Image.network(
                'https://lishuxue.site/oneinfo/Fl2gqK0p25pAaKlKrV0CNXA-OlxQ',
                fit: BoxFit.cover,
              ),
            ),

            // 创建一个粗的线条
            Container(
              height: 10.0,
              width: double.infinity, // 填充父元素的空间，相当于width 100%
              color: const Color(0xFF6D6D6D),
            ),

            // 文本区域
            Container(
              padding: const EdgeInsets.all(6),
              color: const Color(0xFFDADADA),
              // 上下左右居中
              child: const Center(
                child: Text(
                  '车和人一样，总要有些瑕疵，才能轻松上路，才能放心托付。人生不全然是在红灯变成绿灯的同时就要向前冲。',
                  style: TextStyle(fontSize: 14, color: Color(0xFF6D6D6D)),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // 创建一个粗的线条
            Container(
              height: 10.0,
              width: double.infinity, // 填充父元素的空间，相当于width 100%
              color: const Color(0xFF6D6D6D),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
