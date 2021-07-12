import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class NotesCourseWidget extends StatefulWidget {
  NotesCourseWidget({Key key}) : super(key: key);

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
                Text(
                    'Declarative interfaces for any Apple Devices and Android Devices',
                    softWrap: true,
                    maxLines: 2,
                    style: titleTextStyle().copyWith(color: konDarkColorB1)),
                SizedBox(height: 8),
                Text(
                  'By Siradueen',
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '@ 00:01:23',
                              style: ctaTextStyle()
                                  .copyWith(color: konPrimaryColor2),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.trash,
                                    size: 20,
                                  ),
                                  SizedBox(width: 20),
                                  Icon(
                                    Icons.edit,
                                    size: 20,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 8),
                        Text('Python Variables',
                            softWrap: true,
                            maxLines: 2,
                            style: titleTextStyle()
                                .copyWith(color: konDarkColorB1)),
                        SizedBox(height: 8),
                        Text(
                          'Clean up the base code to make easy',
                          style:
                              smallTextStyle().copyWith(color: konDarkColorD3),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Phasellus vestibulum lorem sed risus ultricie',
                          style: descTextStyle(),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '13 JUN 2021'.toUpperCase(),
                          style: smallTextStyle().copyWith(color: Colors.black),
                        ),
                      ],
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
