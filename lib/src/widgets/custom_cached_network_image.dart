import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nafcassete/src/widgets/custsom_shimmer.dart';

class DisplayNetworkImage extends StatefulWidget {
  const DisplayNetworkImage({
    Key? key,
    required this.imageUrl,
    this.height, 
    this.width, 
    this.fit,
  }): super(key: key);
      
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;

  @override
  State<DisplayNetworkImage> createState() => _DisplayNetworkImageState();
}

class _DisplayNetworkImageState extends State<DisplayNetworkImage> {

  @override
  Widget build(BuildContext context) {
    return widget.imageUrl == "null" || widget.imageUrl.isEmpty
    ? placeHolder()
    : CachedNetworkImage(
      fit: widget.fit ?? BoxFit.cover,
      width: widget.width,
      height: widget.height,
      imageUrl: widget.imageUrl,
      placeholder: (context, url) => const CustomShimmer(),
      errorWidget: (context, url,_) => placeHolder(),
    );
  }

  placeHolder() {
    return Image.asset(
      "assets/images/logo.png",
      width: widget.width,
      height: widget.height,
      fit: BoxFit.cover,
    );
  }

}