import 'package:flutter/material.dart';
import 'package:quela/utils/hex_code.dart';

class BottomNavigationBar extends StatefulWidget {
  BottomNavigationBar({
    Key key,
    this.children = const <Widget>[],
  });

  /// Order is important for the pages that are going to be build
  final List<Widget> children;

  @override
  _BottomNavigationBarState createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBar>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  int _currIndex;

  @override
  void initState() {
    super.initState();
    _currIndex = 1;
    _controller =
        TabController(length: 3, vsync: this, initialIndex: _currIndex)
          ..addListener(_handleChange);
  }

  _handleChange() {
    setState(() {
      _currIndex = _controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This container manages size of the container
    return Container(
      width: 350.0,
      height: 400.0,
      decoration: BoxDecoration(
        color: HexColor("#373447"),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(
          32.0,
        )),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            // Inside of the main card
            margin: EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 4.0,
            ),
            child: Scaffold(
              backgroundColor: HexColor("#373447"),
              bottomNavigationBar: TabBar(
                labelColor: Colors.white,
                indicatorColor: Colors.white,
                isScrollable: true,
                controller: _controller,
                indicator: UnderlineTabIndicator(
                  insets: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 40.0),
                ),
                tabs: <Widget>[
                  Container(width: 70.0, child: Tab(text: "Dashboard")),
                  Container(width: 70.0, child: Tab(text: "Alarm")),
                ],
              ),
              body: TabBarView(
                controller: _controller,
                physics: BouncingScrollPhysics(),
                children: this.widget.children,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 355.1,
              right: 34.0,
              left: 34.0,
            ),
            child: Divider(
              color: Colors.grey,
              height: 2.0,
            ),
          ),
        ],
      ),
    );
  }
}
