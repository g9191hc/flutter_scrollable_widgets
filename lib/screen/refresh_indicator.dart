import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colrs.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';

class RefreshIndicatorScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  RefreshIndicatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'RefreshIndicatorScreen',
      // 새로고침(맨 위에서 아래로 당기기) 했을 때 기다리는 동안 로딩표시
      child: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 3));
        },
        child: ListView(
          children: numbers
              .map(
                (e) => renderContainer(
                    color: rainbowColors[e % rainbowColors.length], index: e),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget renderContainer({
    required Color color,
    required int index,
    double? height,
  }) {
    print(index.toString());

    return Container(
      key: Key(index.toString()),
      height: height ?? 300,
      color: color,
      child: Center(
        child: Text(
          index.toString(),
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
