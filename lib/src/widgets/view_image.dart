import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';
import 'package:photo_view/photo_view.dart';

class ViewImage extends StatefulWidget {
  final String? url;

  const ViewImage({Key? key, this.url}) : super(key: key);

  @override
  _ViewImageState createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(onTap:(){ Get.back(); },child: Icon(Icons.arrow_back, color: konLightColor1)),
        backgroundColor: Colors.black,
      ),
      body: GestureDetector(
        child: Container(
            child: PhotoView(
              imageProvider: NetworkImage(widget.url!),
        )
        ),
      ),
    );
  }
}