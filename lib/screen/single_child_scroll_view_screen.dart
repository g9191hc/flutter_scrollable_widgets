import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colrs.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';

class SingleChildScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  SingleChildScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appbarTitle: 'SingleChildScrollView',
      scaffoldBody: renderPerformance(),
    );
  }

  //1. 7가지 색상 기본 렌더링
  Widget renderSimple() {
    return SingleChildScrollView(
      child: Column(
        children:
            rainbowColors.map((color) => renderContainer(color: color)).toList(),
      ),
    );
  }

  //2. 화면을 넘어가지 않아도 스크롤 가능하게 함 (+Physics)
  Widget renderWithPhysics() {
    return SingleChildScrollView(
      //Physics
      //리스트가 화면을 넘어가지 않아도 스크롤이 가능하게 : AlwaysScrollabledScrollPhysics()
      //리스트가 화면을 넘어가도 스크롤이 안 되게 : NeverScrollabledScrollPhysics()
      //iOS기본값 : BouncingScrollPhysics() - 리스트 최상단에서 아래로 당기면 뒤(스케폴드) 배경색이 보이면서 튕기는 모션
      //Android기본값 : ClampingScrollPhysics() - 최상단에서 움직이지 않음
      physics: AlwaysScrollableScrollPhysics(),
      //리스트가 화면을 넘어가지 않으면서 스크롤이 가능하면, 스크롤시 마지막(맨 아래)위젯이 잘리게 되는데
      //이것을  방지하려면, 자르기(Clip)을 none으로 만들어야 함
      clipBehavior: Clip.none,
      child: Column(
        children: [
          renderContainer(color: Colors.red),
          renderContainer(color: Colors.yellow),
          renderContainer(color: Colors.black),
        ],
      ),
    );
  }

  //3. SingleChildScrollView의 퍼포먼스
  //리스트의 모든 위젯을 다 렌더링하므로 비효율적
  Widget renderPerformance() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: numbers
            .map((e) => renderContainer(
                  color: rainbowColors[e % rainbowColors.length],
                  index: e,
                ))
            .toList(),
      ),
    );
  }

  Widget renderContainer({
    required Color color,
    int? index,
  }) {
    if (index != null) print(index.toString());

    return Container(
      height: 300,
      color: color,
    );
  }
}
