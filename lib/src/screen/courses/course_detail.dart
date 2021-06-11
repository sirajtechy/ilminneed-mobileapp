import 'package:flutter/material.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class CourseDetail extends StatefulWidget {
  @override
  _CourseDetailState createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  title: Text("screenTitle"),
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    background: Image.asset(
                      course_detail_bg,
                      fit: BoxFit.cover,
                    ),
                  ),
                  bottom: TabBar(
                    labelColor: konTextInputBorderActiveColor,
                    unselectedLabelColor: konDarkColorD3,
                    indicatorColor: konTextInputBorderActiveColor,
                    labelStyle: buttonTextStyle().copyWith(fontSize: 14),
                    tabs: [
                      Tab(
                        text: "Overview",
                      ),
                      Tab(text: "Lessons"),
                      Tab(text: "Discussion"),
                    ],
                  ),
                ),
                /*SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      labelColor: konTextInputBorderActiveColor,
                      unselectedLabelColor: konDarkColorD3,
                      indicatorColor: konTextInputBorderActiveColor,
                      labelStyle: buttonTextStyle().copyWith(fontSize: 14),
                      tabs: [
                        Tab(text: "Overview",),
                        Tab(text: "Lessons"),
                        Tab(text: "Discussion"),
                      ],
                    ),
                  ),
                  pinned: true,
                ),*/
              ];
            },
            body: Container(
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey[200]))),
              child: TabBarView(
                children: [
                  Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            height: 500,
                            width: double.infinity,
                            color: Colors.redAccent,
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            height: 500,
                            width: double.infinity,
                            color: Colors.blueAccent,
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            height: 500,
                            width: double.infinity,
                            color: Colors.greenAccent,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 500,
                    width: double.infinity,
                  ),
                  Container(
                    height: 500,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // This function show the sliver app bar
  // It will be called in each child of the TabBarView
  SliverAppBar showSliverAppBar(String screenTitle) {
    return SliverAppBar(
      backgroundColor: Colors.purple,
      floating: true,
      pinned: true,
      snap: false,
      title: Text(screenTitle),
      /*bottom: TabBar(
        tabs: [
          Tab(
            icon: Icon(Icons.home),
            text: 'Home',
          ),
          Tab(
            icon: Icon(Icons.settings),
            text: 'Setting',
          )
        ],
      ),*/
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
      length: 2,
      child: TabBarView(children: [
        // This CustomScrollView display the Home tab content
        CustomScrollView(
          slivers: [
            showSliverAppBar('Kindacode Home'),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  labelColor: konTextInputBorderActiveColor,
                  unselectedLabelColor: konDarkColorD3,
                  indicatorColor: konTextInputBorderActiveColor,
                  labelStyle: buttonTextStyle().copyWith(fontSize: 14),
                  tabs: [
                    Tab(
                      text: "Overview",
                    ),
                    Tab(text: "Lessons"),
                  ],
                ),
              ),
              pinned: true,
            ),

            // Anther sliver widget: SliverList
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  height: 400,
                  child: Center(
                    child: Text(
                      'Home Tab',
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ),
                Container(
                  height: 1500,
                  color: Colors.green,
                ),
              ]),
            ),
          ],
        ),

        // This shows the Settings tab content
        CustomScrollView(
          slivers: [
            showSliverAppBar('Settings Screen'),

            // Show other sliver stuff
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  height: 600,
                  color: Colors.blue[200],
                  child: Center(
                    child: Text(
                      'Settings Tab',
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ),
                Container(
                  height: 1200,
                  color: Colors.pink,
                ),
              ]),
            ),
          ],
        )
      ]),
    ));
  }
}
