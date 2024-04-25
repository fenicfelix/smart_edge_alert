library smart_edge_alert;

import 'package:flutter/material.dart';

/// SmartEdgeAlert class provides functionality to display an interrupted smart alert from the top or bottom of the screen.
class SmartEdgeAlert {
  /// Duration for short alerts (1 second).
  static const int lengthShort = 1;

  /// Duration for long alerts (3 seconds).
  static const int lengthLong = 3;

  /// Duration for very long alerts (5 seconds).
  static const int lengthVeryLong = 5;

  /// Constant representing the top gravity for displaying alerts.
  static const int top = 1;

  /// Constant representing the bottom gravity for displaying alerts.
  static const int bottom = 2;

  /// Displays a smart alert with the provided parameters.
  ///
  /// The [context] parameter is required and represents the BuildContext where the alert will be displayed.
  /// The [title] parameter is optional and specifies the title of the alert.
  /// The [description] parameter is optional and specifies the description of the alert.
  /// The [backgroundColor] parameter is optional and specifies the background color of the alert.
  /// The [closeButtonColor] parameter is optional and specifies the color of the close button.
  /// The [icon] parameter is optional and specifies the icon to be displayed in the alert.
  /// The [duration] parameter is optional and specifies the duration for which the alert will be displayed.
  /// The [gravity] parameter is optional and specifies the gravity of the alert (top or bottom).
  static void show(
    BuildContext context, {
    String? title,
    double? titleFontSize,
    String? description,
    double? descriptionFontSize,
    Color? backgroundColor,
    Color? closeButtonColor,
    IconData? icon,
    int? duration,
    int? gravity,
  }) {
    OverlayView.createView(
      context,
      title: title,
      titleFontSize: titleFontSize,
      description: description,
      descriptionFontSize: descriptionFontSize,
      duration: duration,
      gravity: gravity,
      backgroundColor: backgroundColor,
      closeButtonColor: closeButtonColor,
      icon: icon,
    );
  }
}

/// OverlayView class manages the creation and dismissal of the overlay alert.
class OverlayView {
  /// Singleton instance of the OverlayView class.
  static final OverlayView _singleton = OverlayView._internal();

  /// Internal constructor for creating a singleton instance of the OverlayView class.
  factory OverlayView() {
    return _singleton;
  }

  /// Internal constructor for creating a singleton instance of the OverlayView class.
  OverlayView._internal();

  /// Represents the current overlay state.
  static OverlayState? _overlayState;

  /// Represents the current overlay entry.
  static OverlayEntry? _overlayEntry;

  /// Indicates whether the overlay alert is currently visible.
  static bool _isVisible = false;

  /// Creates and displays the overlay alert with the provided parameters.
  ///
  /// The [context] parameter is required and represents the BuildContext where the alert will be displayed.
  /// The [title] parameter is optional and specifies the title of the alert.
  /// The [description] parameter is optional and specifies the description of the alert.
  /// The [duration] parameter is optional and specifies the duration for which the alert will be displayed.
  /// The [gravity] parameter is optional and specifies the gravity of the alert (top or bottom).
  /// The [backgroundColor] parameter is optional and specifies the background color of the alert.
  /// The [icon] parameter is optional and specifies the icon to be displayed in the alert.
  /// The [closeButtonColor] parameter is optional and specifies the color of the close button.
  static void createView(BuildContext context,
      {String? title,
      double? titleFontSize,
      String? description,
      double? descriptionFontSize,
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
          titleFontSize: titleFontSize,
          description: description,
          descriptionFontSize: descriptionFontSize,
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

  /// Dismisses the overlay alert.
  static dismiss() async {
    if (!_isVisible) {
      return;
    }
    _isVisible = false;
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

/// SmartEdgeOverlay class represents the visual appearance of the overlay alert.
class SmartEdgeOverlay extends StatefulWidget {
  /// Title of the overlay alert.
  final String? title;

  /// Font size of the title in the overlay alert.
  final double? titleFontSize;

  /// Description of the overlay alert.
  final String? description;

  /// Font size of the description in the overlay alert.
  final double? descriptionFontSize;

  /// Duration for which the overlay alert will be displayed.
  final int? overlayDuration;

  /// Gravity of the overlay alert (top or bottom).
  final int? gravity;

  /// Background color of the overlay alert.
  final Color? backgroundColor;

  /// Color of the close button in the overlay alert.
  final Color? closeButtonColor;

  /// Icon to be displayed in the overlay alert.
  final IconData? icon;

  /// Creates a new instance of SmartEdgeOverlay.
  const SmartEdgeOverlay(
      {Key? key,
      this.title,
      this.titleFontSize,
      this.description,
      this.descriptionFontSize,
      this.overlayDuration,
      this.gravity,
      this.backgroundColor,
      this.closeButtonColor,
      this.icon})
      : super(key: key);

  @override
  State<SmartEdgeOverlay> createState() => _SmartEdgeOverlayState();
}

/// State class for SmartEdgeOverlay widget.
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
              titleFontSize: widget.titleFontSize ?? 20,
              description: widget.description ?? '',
              descriptionFontSize: widget.descriptionFontSize ?? 14,
              iconData: widget.icon ?? Icons.notifications,
              closeButtonColor: widget.closeButtonColor ?? Colors.white),
        ),
      ),
    );
  }
}

/// SmartOverlayWidget class represents the content of the overlay alert.
class SmartOverlayWidget extends StatelessWidget {
  /// Title of the overlay alert.
  final String? title;

  /// Font size of the title in the overlay alert.
  final double? titleFontSize;

  /// Description of the overlay alert.
  final String? description;

  /// Font size of the description in the overlay alert.
  final double? descriptionFontSize;

  /// Icon to be displayed in the overlay alert.
  final IconData? iconData;

  /// Color of the close button in the overlay alert.
  final Color? closeButtonColor;

  /// Creates a new instance of SmartOverlayWidget.
  const SmartOverlayWidget(
      {Key? key,
      this.title,
      this.titleFontSize = 20,
      this.description,
      this.descriptionFontSize = 14,
      this.iconData,
      this.closeButtonColor = Colors.white})
      : super(key: key);

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
              Visibility(
                visible: title != null,
                child: Text(
                  title ?? '',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Visibility(
                visible: description != null,
                child: Text(
                  description ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: descriptionFontSize,
                  ),
                ),
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

/// SmartAnimatedIcon class represents the animated icon displayed in the overlay alert.
class SmartAnimatedIcon extends StatefulWidget {
  /// Icon to be displayed in the overlay alert.
  final IconData? iconData;

  /// Creates a new instance of SmartAnimatedIcon.
  const SmartAnimatedIcon({Key? key, this.iconData}) : super(key: key);

  @override
  State<SmartAnimatedIcon> createState() => _SmartAnimatedIconState();
}

/// State class for SmartAnimatedIcon widget.
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
