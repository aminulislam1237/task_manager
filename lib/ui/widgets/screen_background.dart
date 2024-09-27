
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class screeenbackground extends StatelessWidget {
  const screeenbackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size screensize= MediaQuery.sizeOf(context);

    return Stack(
      children: [
        SvgPicture.asset('assets/images/background.svg',fit: BoxFit.fill,
          height:screensize .height,
          width: screensize.width,
        ),
       SafeArea(child: child),
      ],
    ) ;
  }
}
