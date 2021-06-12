import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/helper/resources/strings.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:ilminneed/src/widgets/comments.dart';

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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            child: Text(
                              'UI/UX Design',
                              style: smallTextStyle()
                                  .copyWith(color: konDarkColorB1),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Text(
                              'Declarative interfaces for any Apple Devices.. ',
                              softWrap: true,
                              style: largeTextStyle().copyWith(
                                  color: konDarkColorB1,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: ratingColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '4.5',
                                        style: smallTextStyle().copyWith(
                                            fontSize: 12,
                                            color: konLightColor1),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 1.0, left: 3),
                                        child: Icon(
                                          Icons.star,
                                          size: 13,
                                          color: konLightColor1,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '1200 Ratings',
                                  style: smallTextStyle()
                                      .copyWith(color: konDarkColorD3),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Text(
                              'Last update 16.12.2020',
                              style: smallTextStyle()
                                  .copyWith(color: konDarkColorD3),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Text(
                              '1200 Students learning',
                              style: smallTextStyle()
                                  .copyWith(color: konDarkColorD3),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '₹ ',
                                  style: largeTextStyle().copyWith(
                                      fontSize: 22, color: konPrimaryColor1),
                                ),
                                Text(
                                  '1200',
                                  style: largeTextStyle().copyWith(
                                      fontSize: 22, color: konPrimaryColor1),
                                ),
                                Spacer(),
                                Icon(Icons.share),
                                SizedBox(
                                  width: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(Icons.bookmark_border),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
                            color: konLightColor2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  child: Icon(Icons.arrow_back),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 15,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Shamshudeen',
                                            style: buttonTextStyle().copyWith(
                                                fontSize: 18,
                                                color: konDarkColorB1,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'IT Expert',
                                        style: mediumTextStyle().copyWith(
                                            fontSize: 14,
                                            color: konDarkColorD3),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    'Follow',
                                    style: buttonTextStyle().copyWith(
                                        fontSize: 16,
                                        color: konTextInputBorderActiveColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: ExpansionTile(
                              title: Text(
                                'About the course',
                                style: buttonTextStyle().copyWith(
                                    fontSize: 16, color: konDarkColorB1),
                              ),
                              expandedCrossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: ListView(
                                    shrinkWrap: true,
                                    children: [
                                      Text(
                                        '14hrs . 12 Lessons',
                                        style: buttonTextStyle().copyWith(
                                            fontSize: 12,
                                            color: konLightColor3),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        ABOUT_ME,
                                        style: smallTextStyle()
                                            .copyWith(color: konDarkColorB2),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'What will you get',
                                        style: buttonTextStyle().copyWith(
                                            fontSize: 16,
                                            color: konDarkColorB1),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 5),
                                        child: Row(
                                          children: [
                                            MyBullet(),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              'Course certificate',
                                              style: smallTextStyle().copyWith(
                                                  color: konDarkColorB2),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 5),
                                        child: Row(
                                          children: [
                                            MyBullet(),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              'Course certificate',
                                              style: smallTextStyle().copyWith(
                                                  color: konDarkColorB2),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: ExpansionTile(
                              title: Text(
                                'Feedback',
                                style: buttonTextStyle().copyWith(
                                    fontSize: 16, color: konDarkColorB1),
                              ),
                              expandedCrossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: ListView.separated(
                                      primary: false,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Comments();
                                      },
                                      separatorBuilder: (context, index) {
                                        return Divider(
                                          color: konDarkColorB4,
                                          thickness: 1,
                                        );
                                      },
                                      itemCount: 5),
                                )
                              ],
                            ),
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
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
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

class MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 5.0,
      width: 5.0,
      decoration: new BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}
