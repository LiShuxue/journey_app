import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:journey_app/utils/dio_config.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with AutomaticKeepAliveClientMixin {
  // 页面内容详情
  dynamic _detail;
  bool isLoading = true;

  Future<dynamic> getDetailInfo() async {
    try {
      Response response = await dio.get('/blog-api/common/homeInfo');
      dynamic data = response.data['data'];
      var imageUrl = data['one']['imageUrl'].replaceAll(
          'https://image.wufazhuce.com/', 'https://lishuxue.site/oneinfo/');
      var text = data['one']['text'];
      var wea = data['weather'];
      var address = data['address'];

      var info = {
        'imageUrl': imageUrl,
        'text': text,
        'wea': wea,
        'address': address,
      };

      setState(() {
        _detail = info;
        isLoading = false;
      });
    } on DioException catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    getDetailInfo();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE), // 整个页面的背景
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              // 水平方向有个padding
              padding: const EdgeInsets.symmetric(horizontal: 7.0),
              // 页面所有的内容从上到下排列
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    // 用width: double.infinity, 填充父元素的空间。也可以用Row，里面用Expanded来充满。
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF8F8F8),
                      // borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    // 这个container中元素也是从上到下排列
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                            '${_detail['address']['city']} ${_detail['address']['district']}',
                            style: const TextStyle(color: Color(0xFF6D6D6D))),
                        const SizedBox(height: 10),
                        Text('今日天气：${_detail['wea']['observe']['weather']}',
                            style: const TextStyle(color: Color(0xFF6D6D6D))),
                        const SizedBox(height: 10),
                        Text('${_detail['wea']['observe']['degree']}',
                            style: const TextStyle(color: Color(0xFF6D6D6D))),
                        const SizedBox(height: 10),
                        Text('${_detail['wea']['tips']['observe']['0']}',
                            style: const TextStyle(color: Color(0xFF6D6D6D))),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),

                  // 创建一个具有特定宽高比的元素
                  AspectRatio(
                    aspectRatio: 1.5,
                    child: Image(
                      image: NetworkImage(_detail['imageUrl']),
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
                    child: Center(
                      child: Text(
                        _detail['text'],
                        style: const TextStyle(color: Color(0xFF6D6D6D)),
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
