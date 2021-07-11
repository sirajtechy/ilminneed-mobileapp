import 'package:flutter/material.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class BookMarkDetail extends StatelessWidget {
  const BookMarkDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: konLightColor1, borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.all(10),
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
                style: largeTextStyle().copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: konTextInputBorderActiveColor),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  '00.10.23',
                  style: largeTextStyle().copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: konTextInputBorderActiveColor),
                ),
              ),
              Spacer(),
              Icon(
                Icons.delete,
                color: konDarkColorB1,
              ),
              SizedBox(
                width: 15,
              ),
              Icon(
                Icons.edit_outlined,
                color: konDarkColorB1,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Python Variables',
                  style: largeTextStyle().copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: konDarkColorB1),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 7),
            width: double.infinity,
            child: Text(
              'Phasellus vestibulum lorem sed risus ultricies tristique nulla aliquet. Vel quam elementum pulvinar etiamnim lobortis scelerisque',
              style: mediumTextStyle().copyWith(
                fontSize: 14,
                color: konDarkColorD3,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
              softWrap: true,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 7),
            width: double.infinity,
            child: Text(
              '13 JUN 2021',
              style: mediumTextStyle().copyWith(
                fontSize: 12,
                color: konDarkColorB2,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
