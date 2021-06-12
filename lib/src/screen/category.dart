import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class Category extends StatelessWidget {
  const Category({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: konLightColor1,
        title: Text('Category'),
        titleSpacing: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: SvgPicture.asset(
              cart,
              height: 20,
            ),
          )
        ],
      ),
      backgroundColor: konLightColor1,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: konLightColor2,
                  borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search),
                  hintText: 'Search course',
                  hintStyle: mediumTextStyle().copyWith(color: konLightColor),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 20.0,
                    runSpacing: 20.0,
                    children: List.generate(
                      10,
                      (index) => Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width / 2.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueAccent,
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: buttonTextStyle()
                                .copyWith(fontSize: 18, color: konLightColor1),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/*[
Container(
height: 80,
width: MediaQuery.of(context).size.width / 2.5,
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(10),
color: Colors.red,
),
),
Container(
height: 80,
width: MediaQuery.of(context).size.width / 2.5,
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(10),
color: Colors.green,
),
),
Container(
height: 80,
width: MediaQuery.of(context).size.width / 2.5,
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(10),
color: Colors.yellow,
),
),
Container(
height: 80,
width: MediaQuery.of(context).size.width / 2.5,
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(10),
color: Colors.orange,
),
),
]*/
