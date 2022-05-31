import 'package:flutter/material.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';

class UserProfileData {
  final ImageProvider image;
  final String name;
  final String jobDesk;

  const UserProfileData({
    required this.image,
    required this.name,
    required this.jobDesk,
  });
}

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key, required this.data, required this.onPressed})
      : super(key: key);

  final UserProfileData data;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(5),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              _buildImage(),
              const SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_buildName(), _buildJobDesk()],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return CircleAvatar(
      radius: 25,
      backgroundImage: data.image,
    );
  }

  Widget _buildName() {
    return Text(
      data.name,
      style:
          TextStyle(fontWeight: FontWeight.bold, color: kFontColorPallets[0]),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildJobDesk() {
    return Text(
      data.name,
      style:
          TextStyle(fontWeight: FontWeight.w300, color: kFontColorPallets[0]),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
