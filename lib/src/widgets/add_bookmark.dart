import 'package:flutter/material.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class AddBookmark extends StatefulWidget {
  const AddBookmark({Key key}) : super(key: key);

  @override
  _AddBookmarkState createState() => _AddBookmarkState();
}

class _AddBookmarkState extends State<AddBookmark> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: konLightColor2,
      appBar: AppBar(
        elevation: 0,
        leading: Icon(Icons.close),
        titleSpacing: 0,
        title: Text('Bookmark',
            style: largeTextStyle().copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: konDarkColorB1)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: GestureDetector(
              onTap: null,
              child: Text(
                'Save',
                style: largeTextStyle().copyWith(
                    fontSize: 16, color: konTextInputBorderActiveColor),
              ),
            ),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Time',
                    style: largeTextStyle()
                        .copyWith(fontWeight: FontWeight.normal, fontSize: 16),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    '01:05:23',
                    style: largeTextStyle().copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: konPrimaryColor1),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      style: largeTextStyle()
                          .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Title',
                          hintStyle: largeTextStyle().copyWith(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      maxLines: 10,
                      style: largeTextStyle()
                          .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Add Notes',
                          hintStyle: smallTextStyle().copyWith(
                            fontSize: 18,
                          )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
