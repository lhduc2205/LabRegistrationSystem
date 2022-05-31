part of top_nav;

class _UserInfo extends StatelessWidget {
  const _UserInfo({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RootController>();
    final box = GetStorage();
    final email = box.read(BoxString.EMAIL);
    return Row(
      children: [
        SmallButton(onPressed: () => controller.logout(email), text: 'Đăng xuất', color: kRed,),
      ],
    );
  }
}
