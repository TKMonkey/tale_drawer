import 'package:flutter/material.dart';

import 'deafult_icon_menu.dart';

class TopBarWidget extends StatelessWidget {
  const TopBarWidget({
    Key? key,
    this.iconMenu = const DefaultIconMenuAppBar(),
    this.appBar,
  }) : super(key: key);

  final Widget iconMenu;
  final PreferredSize? appBar;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    double? appBarSize = mediaQuery.padding.top + kToolbarHeight;
    if (appBar != null) {
      appBarSize = appBar?.preferredSize.height;
    }

    print('mediaQuery.padding.top = ${mediaQuery.padding.top}');

    return SizedBox(
      width: size.width,
      height: appBarSize,
      child: Stack(
        children: [
          appBar ?? const _DefaultAppBarWidget(),
          Align(
            alignment: Alignment.centerLeft,
            child: SafeArea(
              bottom: false,
              child: iconMenu,
            ),
          ),
        ],
      ),
    );
  }
}

class _DefaultAppBarWidget extends StatelessWidget {
  const _DefaultAppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ColoredBox(
      color: Theme.of(context).primaryColor,
      child: SizedBox(
        width: size.width,
        child: const SafeArea(
          bottom: false,
          child: Center(
            child: Text(
              'Guillotine Drawer',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
