import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colrs.dart';

class CustomScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  CustomScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ListView를 포함한 scrollableWidget은 무한한 공간을 차지할 수 있기 때문에
      // child가 아닌 Column처럼 children 리스트에 scrollableWidget을 넣는 경우에는
      // 각 scrollabledWidget을 반드시 Expanded로 감싸서 영역을 한정 해 줘야 함
      body: CustomScrollView(
        slivers: [
          //스크롤 가능한 앱바
          renderSliverAppBar(),
          renderCount(),
        ],
      )
    );
  }

  SliverAppBar renderSliverAppBar(){
    return SliverAppBar(
      //앱바가 사라지지 않고 고정됨. 기본값 false
      pinned : false,
      //리스트 중간에서 살짝 올렸을 때 앱바가 노출될지 여부. 기본값 false
      floating: true,
      //앱바높이 이하로 움직여도 앱바가 완전히 나타나고 완전히 사라짐. 기본값 false, floating이 true여야 사용 가능
      snap : true,
      //리스트 맨 위에서 더 당기면 앱바가 늘어남. 리스트 한계를 넘어가면 상위위젯이 보일때만 기능함(=기본값으로는 IOS(boundcing physics)에만 기능함)
      stretch: true,
      //앱바의 전체 높이
      expandedHeight: 200,
      //리스트 중간에서 앱바를 닫을 때 (앱바의 내용이 앱바 전체를 차지 하지 않을 경우) 앱바의 내용 자체도 밀려 올라가기 시작하는 위치
      //(위로부터의 크기임. 즉 expandedheight와 크기가 비슷할 수록 거의 동시에 내용도 밀려 올라감)
      collapsedHeight: 150,
      //앱바 전체를 차지함
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(
          'asset/img/image_1.jpg',
          fit: BoxFit.cover,
        ),
        title: Text('FlexibleSpace'),
      ),
      title: Text('CustomScrollViewScreen'),
    );
  }

  SliverList renderChildSliverList() {
    return SliverList(
      //ListView, SingledChildScrollView와 유사
      delegate: SliverChildListDelegate(
        numbers
            .map((e) => renderContainer(
                color: rainbowColors[e % rainbowColors.length], index: e))
            .toList(),
      ),
    );
  }

  SliverList renderBuilderSliverList() {
    return SliverList(
      //ListView.builder와 유사
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return renderContainer(
            color: rainbowColors[index % rainbowColors.length],
            index: index,
          );
        },
        //ListViewt.builder의 itemCount와 동일
        childCount: 100,
      ),
    );
  }

  //GridView-Count와 유사
  SliverGrid renderCount() {
    return SliverGrid(
      //Sliver~Delegate
      delegate: SliverChildListDelegate(
        numbers
            .map(
              (e) => renderContainer(
                color: rainbowColors[e % rainbowColors.length],
                index: e,
              ),
            )
            .toList(),
      ),
      // SliverGridDelegate~
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    );
  }

  //GridView-Extent와 유사
  SliverGrid renderExtent() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        childCount: 100,
        (context, index) {
          return renderContainer(
            color: rainbowColors[index % rainbowColors.length],
            index: index,
          );
        },
      ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        maxCrossAxisExtent: 250,
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
