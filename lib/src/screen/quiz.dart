import 'package:flutter/material.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:ilminneed/src/widgets/button.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: konLightColor1,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: konLightColor1,
        leading: Icon(Icons.close),
        titleSpacing: 0,
        title: Text(
          'Course Quiz',
          style:
              buttonTextStyle().copyWith(fontSize: 18, color: konDarkColorB1),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question 1 of 12',
              style: buttonTextStyle()
                  .copyWith(fontSize: 12, color: konDarkBlackColor),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'What is the use of constants ?',
                style: smallTextStyle()
                    .copyWith(fontSize: 18, color: konDarkBlackColor),
              ),
            ),
            Flexible(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return ButtonWidget(
                    value: 'Option ${index + 1}',
                    isActive: index == 1,
                  );
                },
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Icon(
                      Icons.chevron_left_outlined,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      'Back',
                      style:
                          buttonTextStyle().copyWith(color: konDarkBlackColor),
                    ),
                  ),
                  Spacer(),
                  ButtonWidget(
                    value: 'Next',
                    width: 150,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
