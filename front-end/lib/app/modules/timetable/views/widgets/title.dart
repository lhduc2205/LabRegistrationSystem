part of timetable;

class _Title extends StatelessWidget {
  const _Title({
    Key? key,
    this.isAdmin = false,
  }) : super(key: key);

  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController = Get.find();
    final SideBarController sideBarController = Get.find();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Lịch thực hành', style: headingStyle2),
        isAdmin
            ? TextButton(
                onPressed: () {
                  navigationController.navigateTo(labRegistrationPageRoute);
                  sideBarController
                      .changeActiveItemTo(labRegistrationPageDisplayName);
                },
                child: Row(
                  children: const [
                    Text('Lịch đăng ký'),
                    SizedBox(width: 5),
                    Icon(Icons.arrow_right_alt_rounded)
                  ],
                ),
              )
            : ElevatedButton.icon(
                onPressed: () {
                  navigationController.navigateTo(myTimetablePageRoute);
                },
                label: const Text('Lịch của tôi'),
                icon: const Icon(
                  IconlyBold.calendar,
                  color: kWhite,
                ),
                style: defaultButtonStyle(),
              ),
      ],
    );
  }
}
