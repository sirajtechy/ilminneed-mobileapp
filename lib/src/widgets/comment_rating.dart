import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';

class CommentRating extends StatelessWidget {
  final String? name, time, comment;
  final double? rating;

  const CommentRating(
      {Key? key, this.name, this.time, this.comment, this.rating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name!,
              style: largeTextStyle()
                  .copyWith(fontSize: 14, color: konDarkColorB1),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                RatingBar.builder(
                  initialRating: rating!,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemSize: 25,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                SizedBox(width: 10),
                Text(
                  time!,
                  style: mediumTextStyle().copyWith(color: konDarkColorD3),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              comment!,
              style: mediumTextStyle()
                  .copyWith(fontSize: 14, color: konDarkColorB2),
            )
          ],
        ),
      ),
    );
  }
}
