part of top_nav;

class _CustomIconButton extends StatelessWidget {
  const _CustomIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.radius,
    this.color,
  }) : super(key: key);
  final IconData icon;
  final double? radius;
  final Color? color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: color ?? kFontColorPallets[1],
      ),
      splashRadius: radius ?? 25,
    );
  }
}