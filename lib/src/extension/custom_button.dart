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

class CustomGradientButton extends StatelessWidget {
  const CustomGradientButton({
    Key? key,
    this.height = 50,
    this.width = 200,
    required this.title,
    this.isLoading = false,
    this.titleColor = Colors.white,
    this.startColor,
    this.endColor = Colors.blue,
    required this.onPressed,
  }) : super(key: key);

  final double height;
  final double width;

  final String title;
  final bool isLoading;
  final Color titleColor;
  final Color? startColor;
  final Color endColor;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [startColor ?? Colors.white.withOpacity(0.0), endColor],
            stops: [
              0.0,
              0.6,
            ],
          ),
        ),
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          child: !isLoading
              ? Text(
                  title,
                  style: TextStyle(
                    // backgroundColor: Colors.transparent,
                    color: titleColor,
                  ),
                )
              : CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
        ),
      ),
      onPressed: !isLoading ? onPressed : null,
    );
  }
}

// ignore: must_be_immutable
class BackButtonWithStack extends StatelessWidget {
  BackButtonWithStack({
    Key? key,
    required this.child,
    this.onPop,
    this.title,
  }) : super(key: key);

  final Widget child;
  Function()? onPop;
  String? title;

  @override
  Widget build(BuildContext context) {
    dismiss() {
      Navigator.of(context).pop();
    }

    return Stack(
      children: [
        child,
        Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: AppBar(
            title:
                title != null ? Text(title!) : null, // You can add title here
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: onPop ?? dismiss,
            ),
            backgroundColor: Colors.transparent, //You can make this transparent
            elevation: 0.0, //No shadow
          ),
        ),
      ],
    );
  }
}

class ImageButton extends StatelessWidget {
  const ImageButton({
    Key? key,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  final String imagePath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          imagePath,
          width: 40,
        ),
      ),
    );
  }
}
