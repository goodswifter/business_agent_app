import 'package:flutter/material.dart';

//结算界面

class SettlementInfoPage extends StatefulWidget {
  const SettlementInfoPage({Key? key}) : super(key: key);

  @override
  State<SettlementInfoPage> createState() => _SettlementInfoPageState();
}

class _SettlementInfoPageState extends State<SettlementInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            //缩放到最小时是否需要悬停到顶部
            pinned: true,
            // 想下滚动显示 向上 跟随影藏
            floating: true,
            elevation: 0.0,
            // leading: IconButton(
            //   icon: Image.asset(
            //     "images/navi_back_images.png",
            //     fit: BoxFit.cover,
            //     // color: Colors.white,
            //   ),
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            // ),
            //自定义title
            title: Container(
              child: Text(
                "结算",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff333333),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            //缩放的最大高度，必须要设置了才会有缩放的效果
            // expandedHeight: 250.0,
            // flexibleSpace: FlexibleSpaceBar(
            //   //标题是否居中
            //   centerTitle: true,
            //   //标题padding
            //   titlePadding: const EdgeInsets.all(10),
            //   //背景缩放模式 CollapseMode.pin//背景跟着一起往上滚,CollapseMode.none//背景不动
            //   collapseMode: CollapseMode.parallax,
            //   background: Image.network(
            //     'https://tse4-mm.cn.bing.net/th/id/OIP-C.E-4fLhTRC4aG-RvqTAO_dwHaE8?w=251&h=180&c=7&r=0&o=5&dpr=2&pid=1.7',
            //     fit: BoxFit.cover,
            //   ),
            //   title: const Text('万物生长'),
            // ),
          ),
        ],
      ),
    );
  }
}
