import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
class ProfilePicture extends StatelessWidget {
  const ProfilePicture({Key? key, this.image, this.pixColor}) : super(key: key);
  final Color? pixColor;
  final String? image;
  @override
  Widget build(BuildContext context) {
    return
      CachedNetworkImage(
        imageUrl: image??"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQfPBILF6HrhlqwYmjyNFb7JiMYB55UTewG7MQBRyQox5aeOGyrCNdv5bVf7fpdAuntpM&usqp=CAU",
        imageBuilder: (context, imageProvider) =>
            Container(
              width: 50.0.w,
              height: 50.0.h,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 5.0, color: pixColor ?? Colors.transparent,),
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: imageProvider, fit: BoxFit.cover),
              ),
            ),
        //placeholder: (context, url) => CircularProgressIndicator(),
        placeholder: (context, url) => SvgPicture.asset('assets/user.svg'),
        errorWidget: (context, url, error) =>
            SvgPicture.asset('assets/user.svg'),
      );
  }}
