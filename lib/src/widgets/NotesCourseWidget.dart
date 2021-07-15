import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ilminneed/src/model/lessonnote.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class NotesCourseWidget extends StatefulWidget {
  LessonNote lessonnote;
  NotesCourseWidget({Key key,this.lessonnote}) : super(key: key);

  @override
  _NotesCourseWidgetState createState() => _NotesCourseWidgetState();
}

class _NotesCourseWidgetState extends State<NotesCourseWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpansionTile(
            iconColor: Colors.black,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.lessonnote.title.toString(),
                    softWrap: true,
                    maxLines: 2,
                    style: titleTextStyle().copyWith(color: konDarkColorB1)),
                SizedBox(height: 8),
                Text(
                  'By '+widget.lessonnote.instructor_name.toString(),
                  style: smallTextStyle().copyWith(color: konDarkColorD3),
                ),
              ],
            ),
            children: <Widget>[
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                      color: konPrimaryLightColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child:  ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      shrinkWrap: true,
                      primary: false,
                      itemCount: widget.lessonnote.notes.length,
                      separatorBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Divider(color: Colors.grey),
                        );
                      },
                      itemBuilder: (context, index) {
                        return Column (
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row (
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text (
                                  '@ '+widget.lessonnote.notes[index].duration.toString(),
                                  style: ctaTextStyle().copyWith(color: konPrimaryColor2),
                                ),
                                Container(
                                  child: Row (
                                    children: [
                                      Icon (
                                        CupertinoIcons.trash, size: 20,
                                      ),
                                      SizedBox(width: 20),
                                      Icon (
                                        Icons.edit, size: 20,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            //SizedBox(height: 8),
//                            Text(widget.lessonnote.notes[index].note,
//                                softWrap: true,
//                                maxLines: 2,
//                                style: titleTextStyle().copyWith(color: konDarkColorB1)
//                            ),
//                            SizedBox(height: 8),
//                            Text(
//                              'Clean up the base code to make easy',
//                              style: smallTextStyle().copyWith(color: konDarkColorD3),
//                            ),
                            SizedBox(height: 8),
                            Text(
                              widget.lessonnote.notes[index].note.toString(),
                              style: descTextStyle(),
                            ),
//                            SizedBox(height: 8),
//                            Text(
//                              '13 JUN 2021'.toUpperCase(),
//                              style: smallTextStyle().copyWith(color: Colors.black),
//                            ),
                          ],
                        );
                      },
                    ),

                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
