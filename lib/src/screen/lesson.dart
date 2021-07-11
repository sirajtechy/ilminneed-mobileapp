import 'package:flutter/material.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:ilminneed/src/widgets/bookmark_detail.dart';
import 'package:ilminneed/src/widgets/lesson_bottom_value.dart';
import 'package:ilminneed/src/widgets/lesson_content_details.dart';
import 'package:ilminneed/src/widgets/lesson_content_header.dart';
import 'package:ilminneed/src/widgets/message.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({Key key}) : super(key: key);

  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _tabIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      setState(() {
        _tabIndex = _tabController.index;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabIndex() {
    setState(() {});
  }

  _getFABWidget() {
    switch (_tabIndex) {
      case 0:
        return FloatingActionButton(
          backgroundColor: konTextInputBorderActiveColor,
          onPressed: () {
            showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                builder: (context) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Text(
                                'More',
                                style: buttonTextStyle().copyWith(
                                    fontSize: 24, color: konDarkColorB1),
                              ),
                              Spacer(),
                              Icon(Icons.close)
                            ],
                          ),
                        ),
                        LessonBottomWidget(
                            value: 'Resources', icon: Icons.download_outlined),
                        LessonBottomWidget(
                            value: 'Certificate', icon: Icons.shield),
                        LessonBottomWidget(value: 'Share', icon: Icons.reply),
                      ],
                    ),
                  );
                });
          },
          child: Icon(Icons.more_vert),
        );
      case 1:
        return FloatingActionButton(
          backgroundColor: konTextInputBorderActiveColor,
          onPressed: () {
            showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                isScrollControlled: true,
                builder: (context) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Icon(Icons.close),
                              Text(
                                '@ 11.06',
                                style: buttonTextStyle()
                                    .copyWith(color: konPrimaryColor1),
                              ),
                              Spacer(),
                              Text(
                                'Save',
                                style: smallTextStyle().copyWith(
                                    color: konTextInputBorderActiveColor,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: TextFormField(
                            //expands: true,
                            //autofocus: true,
                            maxLines: null,
                          ),
                        )
                      ],
                    ),
                  );
                });
          },
          child: Icon(Icons.more_vert),
        );
      default:
        return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              child: Center(
                child: Text('Video Preview'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Declarative interface for any apple devices',
                softWrap: true,
                style: largeTextStyle().copyWith(
                    color: konDarkColorB1, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'By Adil Basha',
                style: smallTextStyle().copyWith(color: konDarkColorD3),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: TabBar(
                labelPadding: EdgeInsets.symmetric(vertical: 5),
                controller: _tabController,
                indicatorColor: konTextInputBorderActiveColor,
                unselectedLabelStyle:
                    smallTextStyle().copyWith(color: konDarkColorB1),
                labelStyle: buttonTextStyle().copyWith(color: konDarkColorB1),
                tabs: <Widget>[
                  Text('Content'),
                  Text('Notes'),
                  Text('Q&A'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  Container(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 25),
                            child: LessonContentHeaderWidget(
                                value: 'Section 1: Introduction')),
                        LessonContentDetailsWidget(
                          isActive: true,
                          value: 'Configuration',
                          children: [
                            Text('1/2',
                                style: mediumTextStyle()
                                    .copyWith(color: konDarkColorD3)),
                            SizedBox(width: 5),
                            Text(
                              '.',
                              style: mediumTextStyle()
                                  .copyWith(color: konDarkColorD3),
                            ),
                            SizedBox(width: 5),
                            Text(
                              '114 mins',
                              style: mediumTextStyle()
                                  .copyWith(color: konDarkColorD3),
                            ),
                          ],
                        ),
                        LessonContentDetailsWidget(
                          isActive: false,
                          value: 'Lesson Names',
                          children: [
                            Text('1/2',
                                style: mediumTextStyle()
                                    .copyWith(color: konDarkColorD3)),
                            SizedBox(width: 5),
                            Text(
                              '.',
                              style: mediumTextStyle()
                                  .copyWith(color: konDarkColorD3),
                            ),
                            SizedBox(width: 5),
                            Text(
                              '114 mins',
                              style: mediumTextStyle()
                                  .copyWith(color: konDarkColorD3),
                            ),
                          ],
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 25),
                            child: LessonContentHeaderWidget(
                                value: 'Section 2: Names')),
                        LessonContentDetailsWidget(
                          isActive: false,
                          value: 'Configuration',
                          children: [
                            Text('1/2',
                                style: mediumTextStyle()
                                    .copyWith(color: konDarkColorD3)),
                            SizedBox(width: 5),
                            Text(
                              '.',
                              style: mediumTextStyle()
                                  .copyWith(color: konDarkColorD3),
                            ),
                            SizedBox(width: 5),
                            Text(
                              '114 mins',
                              style: mediumTextStyle()
                                  .copyWith(color: konDarkColorD3),
                            ),
                          ],
                        ),
                        LessonContentDetailsWidget(
                          isActive: false,
                          value: 'Lesson Names',
                          children: [
                            Text('1/2',
                                style: mediumTextStyle()
                                    .copyWith(color: konDarkColorD3)),
                            SizedBox(width: 5),
                            Text(
                              '.',
                              style: mediumTextStyle()
                                  .copyWith(color: konDarkColorD3),
                            ),
                            SizedBox(width: 5),
                            Text(
                              '114 mins',
                              style: mediumTextStyle()
                                  .copyWith(color: konDarkColorD3),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Color(0xffF6F5FF),
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return BookMarkDetail();
                      },
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 7),
                            itemCount: 5,
                            itemBuilder: (BuildContext context, int index) {
                              return MessagesWidget(
                                isAuthor: index == 0,
                              );
                            },
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 15),
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      color: Color(0xffF6F5FF),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: TextFormField(
                                    style: smallTextStyle()
                                        .copyWith(color: konDarkColorB1),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        suffixIcon: Container(
                                          margin: EdgeInsets.only(right: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.attachment_outlined,
                                                color: konDarkColorD3,
                                              ),
                                              SizedBox(width: 15),
                                              Icon(
                                                Icons.camera_alt_outlined,
                                                color: konDarkColorD3,
                                              ),
                                            ],
                                          ),
                                        ),
                                        hintText: 'Write your question here',
                                        hintStyle: smallTextStyle()
                                            .copyWith(color: konLightColor3)),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: konTextInputBorderActiveColor),
                                child: Icon(
                                  Icons.mic_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
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
      floatingActionButton: _getFABWidget(),
    );
  }
}
