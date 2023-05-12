import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../bloc/tab_bar/tab_bar_bloc.dart';
import '../router/router.dart';
import '../style/colors.dart';
import '../style/images.dart';
import '../widgets/util/constants.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TabBarBloc>(
      create: (context) => TabBarBloc(),
      child: _RootScreen(),
    );
  }
}

class _RootScreen extends StatelessWidget {
  _RootScreen({Key? key}) : super(key: key);
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBarBloc, TabBarState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            // This is used on android devices that have back button
            if (Navigator.canPop(keys[state.index].currentContext!)) {
              Navigator.of(keys[state.index].currentContext!).pop();
              return false;
            }
            return true;
          },
          child: CupertinoTabScaffold(
            controller: BlocProvider.of<TabBarBloc>(context).controller,
            resizeToAvoidBottomInset: false,
            tabBar: CupertinoTabBar(
              onTap: (index) =>
                  BlocProvider.of<TabBarBloc>(context).checkIndex(index),
              backgroundColor: EPColor.backgroud,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.credit_card),
                  activeIcon: Icon(
                    Icons.credit_card,
                    color:
                        EPColor.orange,
                  ),
                  label: "Kartice",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.event,
                  ),
                  activeIcon: Icon(
                    Icons.event,
                    color:
                        EPColor.orange,
                  ),
                  label: "Dogodki",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person
                  ),
                  activeIcon: Icon(
                    Icons.person,
                    color:
                        EPColor.orange,
                  ),
                  label: "Profil",
                ),
              ],
              inactiveColor: EPColor.primaryContrastingColor,
            ),
            tabBuilder: (context, index) {
              return CupertinoTabView(
                  navigatorKey: keys[index],
                  onGenerateRoute: EPRouter.onGenerateRoute,
                  builder: (context) => pageList[index]);
            },
          ),
        );
      },
    );
  }
}
