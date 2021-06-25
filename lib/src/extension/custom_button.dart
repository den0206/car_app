import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.height = 50,
    this.width = 200,
    required this.title,
    this.isLoading = false,
    this.titleColor = Colors.white,
    this.backColor = Colors.green,
    required this.onPressed,
  }) : super(key: key);
  final double height;
  final double width;

  final String title;
  final bool isLoading;
  final Color titleColor;
  final Color backColor;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: backColor,
            onPrimary: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: !isLoading
              ? Text(
                  title,
                  style: TextStyle(
                    color: titleColor,
                  ),
                )
              : CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
          onPressed: !isLoading ? onPressed : null),
    );
  }
}

class BackButtonWithStack extends StatelessWidget {
  const BackButtonWithStack({
    Key? key,
    required this.child,
    required this.onPop,
  }) : super(key: key);

  final Widget child;
  final Function() onPop;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: AppBar(
            title: null, // You can add title here
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: onPop,
            ),
            backgroundColor: Colors.transparent, //You can make this transparent
            elevation: 0.0, //No shadow
          ),
        ),
      ],
    );
  }
}
