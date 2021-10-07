import 'package:flutter/material.dart';
import 'package:gtu_question_paper/app/home/account/account_page.dart';
import 'package:gtu_question_paper/app/home/find_paper/PaperSearch.dart';
import 'package:gtu_question_paper/app/home/material_home_scaffold.dart';
import 'package:gtu_question_paper/app/home/news/Notes_Page.dart';
import 'package:gtu_question_paper/app/home/search_question/SearchQuestion.dart';
import 'package:gtu_question_paper/app/home/tab_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.home;

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.news: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.home: (_) => PaperSearchPage(),
      TabItem.news: (context) => SearchQuestion(),
      // TabItem.news: (context) => NotesPage(),
      TabItem.account: (_) => AccountPage(),
    };
  }

  void _select(TabItem tabItem) {
    if (tabItem == _currentTab) {
      navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentTab]!.currentState!.maybePop(),
      child: MaterialHomeScaffold(
        currentTab: _currentTab,
        onSelectTab: _select,
        widgetBuilders: widgetBuilders,
        navigatorKeys: navigatorKeys,
      ),
    );
  }
}
