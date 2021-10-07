import 'package:flutter/material.dart';

enum TabItem { home, news, account }

class TabItemData {
  const TabItemData({required this.title, required this.icon});

  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.home: TabItemData(title: 'Home', icon: Icons.home),
    TabItem.news:
        // TabItemData(title: 'Notes', icon: Icons.notifications_active_rounded),
        TabItemData(title: 'Solution', icon: Icons.search),
    TabItem.account: TabItemData(title: 'Account', icon: Icons.person),
  };
}
