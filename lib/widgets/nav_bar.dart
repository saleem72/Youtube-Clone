//

import 'package:flutter/material.dart';

import '../helpers/styling/styling.dart';
import '../models/user.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    Key? key,
    this.onCast,
    this.onNotifications,
    this.onSearch,
  }) : super(key: key);

  final Function? onNotifications;
  final Function? onCast;
  final Function? onSearch;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 74,
      padding: const EdgeInsets.only(top: 34, left: 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: Pallet.headerIconColor,
            backgroundImage: NetworkImage(User.currentUser.imageUrl),
          ),
          const SizedBox(width: 8),
          const Text(
            'YouTube',
            style: Topology.title,
          ),
          Expanded(child: Container()),
          InkWell(
            onTap: () {
              if (onNotifications != null) {
                onNotifications!.call();
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.notifications_outlined,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (onCast != null) {
                onCast!.call();
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.cast,
                size: 20,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (onSearch != null) {
                onSearch!.call();
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.search,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
