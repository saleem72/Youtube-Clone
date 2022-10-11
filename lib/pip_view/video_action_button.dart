//

import 'package:flutter/material.dart';

import '../helpers/styling/styling.dart';

class VideoActionButton extends StatelessWidget {
  const VideoActionButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  final String icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => onTap.call(),
        child: Column(
          children: [
            Image.asset(
              icon,
              width: 20,
              height: 20,
              color: Pallet.headerIconColor,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: Topology.caption.copyWith(
                color: Pallet.primaryTextColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
