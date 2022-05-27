import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotpGalleryPage extends StatefulWidget {
  final List photoList;
  final int index;
  const PhotpGalleryPage(
      {Key? key, required this.photoList, required this.index})
      : super(key: key);
  @override
  _PhotpGalleryPageState createState() => _PhotpGalleryPageState();
}

class _PhotpGalleryPageState extends State<PhotpGalleryPage> {
  int currentIndex = 0;
  late int initialIndex; //初始index
  late int length;
  late int title;
  @override
  void initState() {
    currentIndex = widget.index;
    initialIndex = widget.index;
    length = widget.photoList.length;
    title = initialIndex + 1;
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
      title = index + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title / $length'),
        centerTitle: true,
      ),
      body: Container(
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height,
          ),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              PhotoViewGallery.builder(
                scrollDirection: Axis.horizontal,
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    // imageProvider: NetworkImage(widget.photoList[index]['image']),
                    // initialScale: PhotoViewComputedScale.contained * 1,
                    // heroAttributes: widget.photoList[index]['id'],

                    imageProvider: NetworkImage(widget.photoList[index]),
                    // imageProvider: AssetImage(widget.photoList[index].image),
                    initialScale: PhotoViewComputedScale.contained * 0.8,
                    // heroAttributes:
                    //     PhotoViewHeroAttributes(tag: widget.photoList[index].id),
                    heroAttributes:
                        PhotoViewHeroAttributes(tag: widget.photoList[index]),
                    minScale: PhotoViewComputedScale.contained * 0.8,
                    maxScale: PhotoViewComputedScale.contained * 3.0,
                  );
                },
                itemCount: widget.photoList.length,
                // loadingChild: widget.loadingChild,
                backgroundDecoration: const BoxDecoration(
                  color: Colors.black,
                ),
                pageController:
                    PageController(initialPage: initialIndex), //点进去哪页默认就显示哪一页
                onPageChanged: onPageChanged,
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Image ${currentIndex + 1}",
                  style: const TextStyle(
                      color: Colors.white, fontSize: 17.0, decoration: null),
                ),
              )
            ],
          )),
    );
  }
}
