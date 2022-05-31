part of top_nav;

class _CustomAppName extends StatelessWidget {
  const _CustomAppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: AppString.APP_NAME,
      color: kFontColorPallets[1],
      size: 16,
      weight: FontWeight.bold,
    );
  }
}