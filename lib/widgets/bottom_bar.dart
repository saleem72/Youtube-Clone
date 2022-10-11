//

import 'package:flutter/material.dart';

import '../helpers/styling/styling.dart';
import '../models/bottom_bar_item.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    Key? key,
    required this.selectedItem,
    required this.isFullMode,
    required this.onChange,
  }) : super(key: key);
  final BottomBarItem selectedItem;
  final bool isFullMode;
  final Function(BottomBarItem) onChange;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  void _pageHasChanged(BottomBarItem item) {
    widget.onChange.call(item);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 60),
            painter: _BotttomBarPainter(fillColor: Pallet.headerColor),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: widget.isFullMode
                ? Container()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _BottomBarButton(
                        item: BottomBarItem.home,
                        selectedItem: widget.selectedItem,
                        onTap: () => _pageHasChanged(BottomBarItem.home),
                      ),
                      _BottomBarButton(
                        item: BottomBarItem.shorts,
                        selectedItem: widget.selectedItem,
                        onTap: () => _pageHasChanged(BottomBarItem.shorts),
                      ),
                      const SizedBox(width: 60, height: 44),
                      _BottomBarButton(
                        item: BottomBarItem.subscriptions,
                        selectedItem: widget.selectedItem,
                        onTap: () =>
                            _pageHasChanged(BottomBarItem.subscriptions),
                      ),
                      _BottomBarButton(
                        item: BottomBarItem.library,
                        selectedItem: widget.selectedItem,
                        onTap: () => _pageHasChanged(BottomBarItem.library),
                      ),
                    ],
                  ),
          ),
          Center(
            child: Transform.translate(
              offset: const Offset(0, -30),
              child: FloatingActionButton(
                onPressed: () {},
                backgroundColor: Pallet.primaryColor,
                foregroundColor: Colors.white,
                child: const Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomBarButton extends StatelessWidget {
  const _BottomBarButton({
    Key? key,
    required this.item,
    required this.selectedItem,
    required this.onTap,
  }) : super(key: key);

  final BottomBarItem item;
  final BottomBarItem selectedItem;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap.call(),
      child: Container(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        alignment: Alignment.center,
        // color: Colors.amber,
        child: Column(
          children: [
            Image.asset(
              item.icon,
              width: 20,
              height: 20,
              color: selectedItem == item
                  ? Pallet.primaryColor
                  : Pallet.headerIconColor,
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: selectedItem == item
                        ? Pallet.primaryColor
                        : Pallet.headerIconColor,
                  ),
              // style: Topology.bottomBar.copyWith(
              // color: selectedItem == item
              //     ? Pallet.primaryColor
              //     : Pallet.headerIconColor,
              // ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BotttomBarPainter extends CustomPainter {
  final Paint painter;
  _BotttomBarPainter({
    required Color fillColor,
  }) : painter = Paint()..color = fillColor;
  @override
  void paint(Canvas canvas, Size size) {
    final path = _bottomBarShape(size);
    canvas.drawPath(path, painter);
    final strokePaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

Path _bottomBarShape(Size size) {
  var path = Path();
  final double width = size.width;
  final double height = size.height;
  path.moveTo(1.0 * width, 1.0 * height);
  path.lineTo(1.0 * width, 0.0 * height);
  path.lineTo(0.67862 * width, 0.0 * height);
  path.cubicTo(
    0.58566 * width,
    0.0 * height,
    0.59894 * width,
    0.6371 * height,
    0.49801 * width,
    0.62903 * height,
  );

  path.cubicTo(
    0.39708 * width,
    0.62097 * height,
    0.417 * width,
    0.0 * height,
    0.32138 * width,
    0.0 * height,
  );

  path.lineTo(0, 0.0 * height);

  path.lineTo(0, 1.0 * height);
  path.lineTo(1.0 * width, 1.0 * height);
  path.close();
  return path;
}
