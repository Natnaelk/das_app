import 'package:das_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GroupsAppBar extends StatelessWidget {
  const GroupsAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: (20)),
      child: SafeArea(
          maintainBottomViewPadding: true,
          child: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/Settings.svg',
              color: Colors.black.withOpacity(0.6),
            ),
            onPressed: () {},
          )),
    );
  }
}
