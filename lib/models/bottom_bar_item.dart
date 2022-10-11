//

import '../helpers/styling/styling.dart';

enum BottomBarItem { home, shorts, subscriptions, library }

extension BottomBarItems on BottomBarItem {
  String get icon {
    switch (this) {
      case BottomBarItem.home:
        return Assets.home;
      case BottomBarItem.shorts:
        return Assets.video;
      case BottomBarItem.subscriptions:
        return Assets.play;
      case BottomBarItem.library:
        return Assets.library;
    }
  }

  String get label {
    switch (this) {
      case BottomBarItem.home:
        return 'Home';
      case BottomBarItem.shorts:
        return 'Shorts';
      case BottomBarItem.subscriptions:
        return 'Subscriptions';
      case BottomBarItem.library:
        return 'Library';
    }
  }

  static List<BottomBarItem> allCases = [
    BottomBarItem.home,
    BottomBarItem.shorts,
    BottomBarItem.subscriptions,
    BottomBarItem.library,
  ];
}
