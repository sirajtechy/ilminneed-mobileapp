import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilminneed/helper/resources/images.dart';
import 'package:ilminneed/src/controller/globalctrl.dart' as ctrl;
import 'package:ilminneed/src/model/category.dart';
import 'package:ilminneed/src/model/search_history.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:ilminneed/src/ui_helper/text_styles.dart';
import 'package:ilminneed/src/widgets/search_history_widget.dart';
import 'package:ilminneed/src/widgets/shopping_cart.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  bool _loading = true;
  List<CategoryModel>? _category;

  List<SearchHistory>? _recentsearch;

  _fetchpopular() async {
    var res = await ctrl.getrequest({}, 'search_recent_history');
    if (res != null) {
      List<dynamic> data = res;
      for (int i = 0; i < data.length; i++) {
        setState(() {
          _recentsearch?.add(SearchHistory.fromJson(data[i]));
        });
      }
    }
  }

  _fetchcategory() async {
    setState(() {
      _loading = true;
    });
    var res = await ctrl.getrequest({}, 'categories');
    setState(() {
      _loading = false;
    });
    if (res != null) {
      List<dynamic> data = res;
      for (int i = 0; i < data.length; i++) {
        _category?.add(CategoryModel.fromJson(data[i]));
      }
    } else {
      setState(() {
        _loading = false;
      });
      await ctrl.toastmsg('Error. please try again', 'long');
    }
  }

  @override
  void initState() {
    _fetchpopular();
    _fetchcategory();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Get.offNamed('/', arguments: {'currentTab': 0, 'data': ''});
            },
            child: Icon(Icons.arrow_back, color: Colors.black)),
        elevation: 0,
        backgroundColor: konLightColor1,
        title: Text('Category'),
        titleSpacing: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0, right: 10),
            child: ShoppingCartButtonWidget(),
          )
        ],
      ),
      backgroundColor: konLightColor1,
      body: LoadingOverlay(
        isLoading: _loading,
        color: Colors.white,
        child: Container(
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
                  onTap: () {
                    Get.toNamed('/search');
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.search),
                    hintText: 'Search courses, tutors',
                    hintStyle: mediumTextStyle().copyWith(color: konLightColor),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: !_loading && _category?.length != 0
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _recentsearch?.length != 0
                                ? SearchHistoryWidget(
                                    label: 'Popular Search',
                                    value: _recentsearch,
                                  )
                                : SizedBox(),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 15),
                              child: Wrap(
                                direction: Axis.horizontal,
                                spacing: 20.0,
                                runSpacing: 20.0,
                                children: List.generate(
                                  _category?.length ?? 0,
                                  (index) => InkWell(
                                    onTap: () {
                                      Get.toNamed('/categoryresult',
                                          arguments: {
                                            'id': _category?[index].id,
                                            'name': _category?[index].name
                                          });
                                    },
                                    child: Stack(
                                      alignment: AlignmentDirectional.topCenter,
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Stack(
                                            children: <Widget>[
                                              Hero(
                                                tag: index,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: FadeInImage(
                                                    height: 100,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.5,
                                                    placeholder:
                                                        AssetImage(placeholder),
                                                    image: _category?[index]
                                                                .thumbnail ==
                                                            null
                                                        ? Image.asset(
                                                                placeholder)
                                                            as ImageProvider<
                                                                Object>
                                                        : NetworkImage(
                                                            _category![index]
                                                                .thumbnail!),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 0,
                                                left: 0,
                                                right: 0,
                                                bottom: 0,
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: Text(
                                                      _category?[index] != null
                                                          ? _category![index]
                                                              .name
                                                              .toString()
                                                          : "",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: buttonTextStyle()
                                                          .copyWith(
                                                              fontSize: 18,
                                                              color:
                                                                  konLightColor1),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : !_loading && _category?.length == 0
                          ? Container(
                              child: Center(
                                child: Text(
                                  "No category found",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          : Container(
                              child: Text(''),
                            ),
                ),
              )
            ],
          ),
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
