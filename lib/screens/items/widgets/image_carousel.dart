import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:new_tablet/models/item_model.dart';
import 'package:new_tablet/services/items_service.dart';

class ImageDialog extends StatefulWidget {
  final List<ItemAttachmentDetail> imgList;

  ImageDialog(this.imgList);

  @override
  State<StatefulWidget> createState() {
    return _ImageDialogState();
  }
}

class _ImageDialogState extends State<ImageDialog> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.close),
        ),
      ),
      CarouselSlider(
        items: widget.imgList.map<Widget>((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      ItemsService.getImage(i.toJson()['attachment.code']),
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(),
        carouselController: _controller,
        options: CarouselOptions(
            viewportFraction: 3.0,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.imgList.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: 12.0,
              height: 12.0,
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white
                      .withOpacity(_current == entry.key ? 0.9 : 0.4)),
            ),
          );
        }).toList(),
      ),
    ]);
  }
}
