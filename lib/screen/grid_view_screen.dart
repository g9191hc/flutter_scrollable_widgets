import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colrs.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';

class GridViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  GridViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appbarTitle: 'GridViewScreen',
      scaffoldBody: renderBuilder(),
    );
  }

  Widget renderCount() {
    return GridView.count(
      //가로간격
      crossAxisSpacing: 12.0,
      //세로간격
      mainAxisSpacing: 12.0,
      //가로 갯수,
      crossAxisCount: 2,
      children: numbers
          .map((e) => renderContainer(
              color: rainbowColors[e % rainbowColors.length], index: e))
          .toList(),
    );
  }

  Widget renderBuilder() {
    return GridView.builder(
      //가로 갯수 지정 : SliverGridDelegateWithFixedCrossAxisCount()
      //기기의 화면크기에 따라 각 요소의 크기가 결정 됨
      //가로 최대너비 지정 : Sliver
      //각 요소가 최대너비를 넘지 않는 선에서 가장 큰 크기로 가로를 균등배분
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
      ),
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
    );
  }

  Widget renderContainer({
    required Color color,
    required int index,
    double? height,
  }) {
    print(index.toString());

    return Container(
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
