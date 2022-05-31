part of login;

class _LogoHeader extends StatelessWidget {
  const _LogoHeader({
    Key? key,
    this.width = 120,
    this.height = 120
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImageRasterPath.CTULogo,
      width: width,
      height: height,
    );
  }
}