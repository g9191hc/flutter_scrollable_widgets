import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colrs.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';

//순서 변경 가능
//순서 변경을 위해 요소별 고유의 키 추가해야 함
class ReorderableListViewScreen extends StatefulWidget {
  const ReorderableListViewScreen({super.key});

  @override
  State<ReorderableListViewScreen> createState() =>
      _ReorderableListViewScreenState();
}

class _ReorderableListViewScreenState extends State<ReorderableListViewScreen> {
  List<int> numbers = List.generate(100, (index) => index);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appbarTitle: 'ReorderableListViewScreen',
      scaffoldBody: renderBuilder(),
    );
  }

  Widget renderBuilder(){
    return ReorderableListView.builder(
      itemBuilder: (context, index) {
        //builder에서는 필요하거나 변경된 요소만 새로 그리고 유지함
        //setState로 numbers의 값을 변경하는 것이므로, index가 아니라 index에 해당하는 numbers의 값를 사용해야 반영이 됨
        return renderContainer(color: rainbowColrs[numbers[index] % rainbowColrs.length], index: numbers[index]);
      },
      itemCount: 100,
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          final item = numbers.removeAt(oldIndex);
          if (newIndex > oldIndex) newIndex -= 1;

          numbers.insert(newIndex, item);
        });
      },
    );
  }

  Widget renderDefault() {
    return ReorderableListView(
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          final item = numbers.removeAt(oldIndex);
          if (newIndex > oldIndex) newIndex -= 1;

          numbers.insert(newIndex, item);
        });
      },
      children: numbers
          .map((e) => renderContainer(
                color: rainbowColrs[e % rainbowColrs.length],
                index: e,
              ))
          .toList(),
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
