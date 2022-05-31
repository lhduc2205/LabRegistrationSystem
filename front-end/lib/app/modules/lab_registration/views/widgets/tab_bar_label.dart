part of lab_registration;

class _TabBarLabel extends StatelessWidget {
  const _TabBarLabel({
    Key? key,
    required this.tabController,
    required this.onTap,
    required this.activeColor,
  }) : super(key: key);

  final TabController tabController;
  final Function(int) onTap;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LabRegistrationController>();
    return TabBar(
      controller: tabController,
      onTap: onTap,
      labelPadding: const EdgeInsets.symmetric(horizontal: 20),
      isScrollable: true,
      labelColor: activeColor,
      unselectedLabelColor: kFontColorPallets[1],
      indicatorColor: activeColor,
      tabs: [
        const Tab(text: 'Tạo yêu cầu'),
        const Tab(text: 'Tạo yêu cầu bằng Excel'),
        Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Kết quả'),
              const SizedBox(
                width: 5,
              ),
              _QuantityProgress(
                quantity: controller.registration.length.toString(),
                color: Colors.orange,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _QuantityProgress extends StatelessWidget {
  const _QuantityProgress({Key? key, required this.quantity, this.color})
      : super(key: key);

  final String quantity;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: color ?? kPrimary,
        shape: BoxShape.circle,
      ),
      child: Text(
        quantity,
        style: const TextStyle(
          color: kWhite,
          fontSize: 12,
        ),
      ),
    );
  }
}
