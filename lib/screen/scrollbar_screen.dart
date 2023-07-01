import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colrs.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';

class ScrollbarScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  ScrollbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appbarTitle: 'ScrollbarScreen',
      //Scrollbar위젯으로 감싸면 우측에 스크롤이 보임
      //다만 builder리스트는 그 크기를 처음에 알 수 없으므로, Scrollbar로 감싸도 스크롤바가 나타나지 않음
      scaffoldBody: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: numbers
                .map(
                  (e) => renderContainer(
                    color: rainbowColors[e % rainbowColors.length],
                    index: e,
                  ),
                )
                .toList(),
          ),
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
