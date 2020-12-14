import 'package:flutter/material.dart';

class PriorityLowPage extends StatefulWidget {
  @override
  _PriorityLowPageState createState() => _PriorityLowPageState();
}

class _PriorityLowPageState extends State<PriorityLowPage> {
  var _currentTab = TabItem.one;
  final _navigatorKeys = {
    TabItem.one: GlobalKey<NavigatorState>(),
    TabItem.two: GlobalKey<NavigatorState>(),
    TabItem.three: GlobalKey<NavigatorState>(),
    TabItem.four: GlobalKey<NavigatorState>()
  };

  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentTab].currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentTab != TabItem.one) {
            _selectTab(TabItem.one);
            return false;
          }
        }
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(children: <Widget>[
          _buildOffstageNavigator(TabItem.one),
          _buildOffstageNavigator(TabItem.two),
          _buildOffstageNavigator(TabItem.three),
          _buildOffstageNavigator(TabItem.four)
        ]),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentTab.index,
          onTap: (int index) {
            _selectTab(TabItem.values[index]);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(tabName[TabItem.one]),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.rss_feed),
              title: Text(tabName[TabItem.two]),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              title: Text(tabName[TabItem.three]),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text(tabName[TabItem.four]),
            ),
          ],
          // onTap: (index) => onSelectTab(
          //   TabItem.values[index],
          // ),
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem});

  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  void _push(BuildContext context, {String title = ""}) {
    var routeBuilders = _routeBuilders(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => routeBuilders[TabNavigatorRoutes.detail](context),
      ),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(
    BuildContext context,
  ) {
    return {
      TabNavigatorRoutes.root: (context) => PageN(
            title: tabName[tabItem],
            onPush: (title) => _push(context, title: title),
          ),
      TabNavigatorRoutes.detail: (context) => PageDefault(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name](context),
        );
      },
    );
  }
}

class PageDefault extends StatelessWidget {
  PageDefault({
    this.title = "Page Default",
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$title',
        ),
      ),
      body: Container(),
    );
  }
}

class PageN extends StatelessWidget {
  PageN({this.title, this.onPush});

  final String title;
  final ValueChanged<String> onPush;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            title,
          ),
        ),
        body: InkWell(
          onTap: () => onPush(title),
          child: Container(
            alignment: Alignment.center,
            child: Text("Page$title"),
          ),
        ));
  }
}

enum TabItem { one, two, three, four }

const Map<TabItem, String> tabName = {
  TabItem.one: 'Tab 1',
  TabItem.two: 'Tab 2',
  TabItem.three: 'Tab 3',
  TabItem.four: 'Tab 4'
};

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}
