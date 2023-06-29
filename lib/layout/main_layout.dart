import 'package:flutter/material.dart';

// 모든 페이지에 공통적으로 적용 할 레이아웃을 지정한 클래스
// 여기서는 모든 페이지에 앱바를 추가 함

class MainLayout extends StatelessWidget {
  final String appbarTitle;
  final Widget scaffoldBody;

  const MainLayout({
    super.key,
    required this.appbarTitle,
    required this.scaffoldBody,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appbarTitle,
        ),
      ),
      body: scaffoldBody,
    );
  }
}
