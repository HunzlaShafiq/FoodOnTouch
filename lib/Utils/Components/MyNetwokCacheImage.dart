
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class MyNetworkCacheImage extends StatelessWidget {

  final imageUrl;
  final double height;
  final double width;
  final boxFit;
  const MyNetworkCacheImage({super.key,required this.imageUrl, required this.height, required this.width, this.boxFit =null});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        height: height,
        width: width,
        fit: boxFit,
        errorWidget: (context,val,object){
          return Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.black.withOpacity(.05),
            ),

          );
        },
        progressIndicatorBuilder:
            (context, value, downloadedProgress) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: height,
              width: width,
              decoration:
              BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.black.withOpacity(.04)),
            ),
          );
        },
        imageUrl:imageUrl
    );
  }
}
