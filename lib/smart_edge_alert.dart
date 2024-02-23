library smart_edge_alert;

import 'package:flutter/material.dart';

class SmartEdgeAlert {
  static const int lengthShort = 1; //1 seconds
  static const int lengthLong = 2; // 2 seconds
  static const int lenghVeryLong = 3; // 3 seconds

  static const int top = 1;
  static const int bottom = 2;

  static void show(
    BuildContext context, {
    String? title,
    String? description,
    Color? backgroundColor,
    Color? closeButtonColor,
    IconData? icon,
    int? duration,
    int? gravity,
  }) {
    OverlayView.createView(context,
        title: title,
        description: description,
        duration: duration,
        gravity: gravity,
        backgroundColor: backgroundColor,
        closeButtonColor: closeButtonColor,
        icon: icon);
  }
}

class OverlayView {
  static final OverlayView _singleton = OverlayView._internal();

  factory OverlayView() {
    return _singleton;
  }

  OverlayView._internal();

  static OverlayState? _overlayState;
  static OverlayEntry? _overlayEntry;
  static bool _isVisible = false;

  static void createView(BuildContext context,
      {String? title,
      String? description,
      int? duration,
      int? gravity,
      Color? backgroundColor,
      IconData? icon,
      Color? closeButtonColor}) {
    _overlayState = Navigator.of(context).overlay!;

    if (!_isVisible) {
      _isVisible = true;

      _overlayEntry = OverlayEntry(builder: (context) {
        return SmartEdgeOverlay(
          title: title,
          description: description ?? '',
          overlayDuration: duration ?? SmartEdgeAlert.lengthShort,
          gravity: gravity ?? SmartEdgeAlert.top,
          backgroundColor: backgroundColor ?? Colors.grey,
          icon: icon ?? Icons.notifications,
          closeButtonColor: closeButtonColor ?? Colors.white,
        );
      });

      _overlayState?.insert(_overlayEntry!);
    }
  }

  static dismiss() async {
    if (!_isVisible) {
      return;
    }
    _isVisible = false;
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

class SmartEdgeOverlay extends StatefulWidget {
  const SmartEdgeOverlay(
      {super.key,
      this.title,
      this.description,
      this.overlayDuration,
      this.gravity,
      this.backgroundColor,
      this.closeButtonColor,
      this.icon});

  final String? title;
  final String? description;
  final int? overlayDuration;
  final int? gravity;
  final Color? backgroundColor;
  final Color? closeButtonColor;
  final IconData? icon;

  @override
  State<SmartEdgeOverlay> createState() => _SmartEdgeOverlayState();
}

class _SmartEdgeOverlayState extends State<SmartEdgeOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Tween<Offset> _positionTween;
  late Animation<Offset> _positionAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 750));

    if (widget.gravity == 1) {
      _positionTween =
          Tween<Offset>(begin: const Offset(0.0, -1.0), end: Offset.zero);
    } else {
      _positionTween = Tween<Offset>(
          begin: const Offset(0.0, 1.0), end: const Offset(0.0, 0));
    }

    _positionAnimation = _positionTween.animate(
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));

    _controller.forward();

    listenToAnimation();
  }

  listenToAnimation() async {
    _controller.addStatusListener((listener) async {
      if (listener == AnimationStatus.completed) {
        await Future.delayed(Duration(seconds: widget.overlayDuration ?? 1));
        _controller.reverse();
        await Future.delayed(const Duration(milliseconds: 700));
        OverlayView.dismiss();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double bottomHeight = MediaQuery.of(context).padding.bottom;

    return Positioned(
      top: widget.gravity == 1 ? 0 : null,
      bottom: widget.gravity == 2 ? 0 : null,
      child: SlideTransition(
        position: _positionAnimation,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(
              20,
              widget.gravity == 1 ? statusBarHeight + 20 : bottomHeight + 20,
              20,
              widget.gravity == 1 ? 20 : 35),
          color: widget.backgroundColor,
          child: SmartOverlayWidget(
              title: widget.title ?? '',
              description: widget.description ?? '',
              iconData: widget.icon ?? Icons.notifications,
              closeButtonColor: widget.closeButtonColor ?? Colors.white),
        ),
      ),
    );
  }
}

class SmartOverlayWidget extends StatelessWidget {
  final String? title;
  final String? description;
  final IconData? iconData;
  final Color? closeButtonColor;

  const SmartOverlayWidget(
      {super.key,
      this.title = '',
      this.description = '',
      this.iconData,
      this.closeButtonColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Row(
        children: <Widget>[
          SmartAnimatedIcon(iconData: iconData),
          const Padding(padding: EdgeInsets.only(right: 15)),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              title == null
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        title ?? '',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
              description == null
                  ? Container()
                  : Text(
                      description ?? '',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    )
            ],
          )),
          GestureDetector(
            onTap: () {
              OverlayView.dismiss();
            },
            child: Icon(
              Icons.close,
              color: closeButtonColor,
            ),
          ),
        ],
      ),
    );
  }
}

class SmartAnimatedIcon extends StatefulWidget {
  final IconData? iconData;
  const SmartAnimatedIcon({super.key, this.iconData});

  @override
  State<SmartAnimatedIcon> createState() => _SmartAnimatedIconState();
}

class _SmartAnimatedIconState extends State<SmartAnimatedIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        lowerBound: 0.8,
        upperBound: 1.1,
        duration: const Duration(milliseconds: 600));

    _controller.forward();
    listenToAnimation();
  }

  listenToAnimation() async {
    _controller.addStatusListener((listener) async {
      if (listener == AnimationStatus.completed) {
        _controller.reverse();
      }
      if (listener == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: Icon(
        widget.iconData,
        size: 35,
        color: Colors.white,
      ),
      builder: (context, widget) =>
          Transform.scale(scale: _controller.value, child: widget),
    );
  }
}
