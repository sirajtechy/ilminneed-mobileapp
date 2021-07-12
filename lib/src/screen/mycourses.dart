import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:ilminneed/src/widgets/CompletedCourseWidget.dart';
import 'package:ilminneed/src/widgets/InProgressCourseWidget.dart';
import 'package:ilminneed/src/widgets/NotesCourseWidget.dart';
import 'package:ilminneed/src/widgets/SavedCourseWidget.dart';
import 'package:ilminneed/src/widgets/shopping_cart.dart';

class MyCourses extends StatefulWidget {
  @override
  _MyCoursesState createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _tabIndex = 0;

  @override
  void initState() {
    _tabController =
        TabController(length: 4, initialIndex: _tabIndex, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _tabIndex = _tabController.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = 100;
    final double itemWidth = size.width / 2;
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        color: Colors.white,
        child: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            snap: true,
            floating: true,
            pinned: true,
            automaticallyImplyLeading: false,
            leading: new InkWell(
                onTap: () {
                  Get.offAllNamed('/', arguments: 0);
                },
                child: Icon(Icons.arrow_back, color: Colors.black)),
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text('My Courses'),
            titleSpacing: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0, right: 10),
                child: ShoppingCartButtonWidget(),
              )
            ],
            expandedHeight: 430,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Padding(
                padding: const EdgeInsets.only(bottom: 0, left: 15, right: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 0),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        color: konLightColor4,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(color: Colors.white),
                          children: [
                            TextSpan(
                              text: "2h 5m of learning\n",
                              style: ctaTextStyle()
                                  .copyWith(color: konDarkColorB1),
                            ),
                            TextSpan(
                              text: "This Week",
                              style: button2TextStyle()
                                  .copyWith(color: konDarkColorB2),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 10, bottom: 0),
                      padding: EdgeInsets.only(
                          top: 0, bottom: 20, left: 15, right: 15),
                      decoration: BoxDecoration(
                        color: konLightColor4,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        childAspectRatio: (itemWidth / itemHeight),
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                    color: Colors.grey.withOpacity(0.2)),
                                bottom: BorderSide(
                                    color: Colors.grey.withOpacity(0.3)),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image(image: AssetImage(hat)),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('12', style: largeTextStyle()),
                                    Text('My Courses', style: buttonTextStyle())
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                    color: Colors.grey.withOpacity(0.2)),
                                bottom: BorderSide(
                                    color: Colors.grey.withOpacity(0.3)),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image(image: AssetImage(clock)),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('12h 4m', style: largeTextStyle()),
                                    Text('Learned time',
                                        style: buttonTextStyle())
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                    color: Colors.grey.withOpacity(0.2)),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image(image: AssetImage(quiz)),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('12', style: largeTextStyle()),
                                    Text('Quiz Attended',
                                        style: buttonTextStyle())
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                    color: Colors.grey.withOpacity(0.2)),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image(image: AssetImage(certificate)),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('12', style: largeTextStyle()),
                                    Text('Certificates',
                                        style: buttonTextStyle())
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottom: TabBar(
              controller: _tabController,
              isScrollable: false,
              labelColor: konLightColor1,
              unselectedLabelColor: konBlackColor,
              labelPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(0), // Creates border
                  color: konPrimaryColor2),
              tabs: [
                Tab(text: 'In Progress'),
                Tab(text: 'Saved'),
                Tab(text: 'Completed'),
                Tab(text: 'Notes'),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Offstage(
                offstage: 0 != _tabIndex,
                child: Column(
                  children: <Widget>[
                    ListView.separated(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      shrinkWrap: true,
                      primary: false,
                      itemCount: 12,
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 10);
                      },
                      itemBuilder: (context, index) {
                        return InProgressCourseWidget();
                      },
                    ),
                  ],
                ),
              ),
              Offstage(
                offstage: 1 != _tabIndex,
                child: Column(
                  children: <Widget>[
                    ListView.separated(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      shrinkWrap: true,
                      primary: false,
                      itemCount: 12,
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 10);
                      },
                      itemBuilder: (context, index) {
                        return SavedCourseWidget();
                      },
                    ),
                  ],
                ),
              ),
              Offstage(
                offstage: 2 != _tabIndex,
                child: Column(
                  children: <Widget>[
                    ListView.separated(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      shrinkWrap: true,
                      primary: false,
                      itemCount: 12,
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 10);
                      },
                      itemBuilder: (context, index) {
                        return CompletedCourseWidget();
                      },
                    ),
                  ],
                ),
              ),
              Offstage(
                offstage: 3 != _tabIndex,
                child: Column(
                  children: <Widget>[
                    ListView.separated(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      shrinkWrap: true,
                      primary: false,
                      itemCount: 12,
                      separatorBuilder: (context, index) {
                        return Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Divider(color: Colors.grey),
                        );
                      },
                      itemBuilder: (context, index) {
                        return NotesCourseWidget();
                      },
                    ),
                  ],
                ),
              )
            ]),
          )
        ]),
      ),
    );
  }
}
