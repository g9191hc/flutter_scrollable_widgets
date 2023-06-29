import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colrs.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';

class ListViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  ListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appbarTitle: 'ListViewScreen',
      scaffoldBody: renderSeperated()
    );
  }

  // SingleChildScrollView처럼 한번에 모든 요소들을 렌더링 함
  Widget renderDefault() {
    return ListView(
      children: numbers
          .map((e) => renderContainer(
              color: rainbowColrs[e % rainbowColrs.length], index: e))
          .toList(),
    );
  }

  // 화면 근처의 요소만 렌더링 및 유지함
  Widget renderBuilder() {
    return ListView.builder(
      //itemCount가 없으면 인덱스 제한 없이 무제한 늘어남
      itemCount: 100,
      itemBuilder: (context, index) {
        return renderContainer(
            color: rainbowColrs[index % rainbowColrs.length], index: index);
      },
    );
  }

  // ListView.builder + 각 요소 사이에 위젯 추가. 요소간 간격 또는 일정 요소마다 광고배너 추가 등에 사용
  Widget renderSeperated(){
    return ListView.separated(
      //itemCount가 없으면 인덱스 제한 없이 무제한 늘어남
      itemCount: 100,
      itemBuilder: (context, index) {
        return renderContainer(
            color: rainbowColrs[index % rainbowColrs.length], index: index);
      },
      separatorBuilder: (BuildContext context, int index) {
        index += 1;
        if(index % 5 == 0)
          return renderContainer(
            color: Colors.black,
            index: index,
            height: 100,
          );
        return Container();
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