# Smart Edge Alert

A Flutter package that shows an interrupted smart alert from the top or bottom. The package shows how to use different icons, background colors, font size and duration of the alert.

## Class Documentation

### SmartEdgeAlert
A class responsible for showing the smart alert.


### OverlayView
- A class responsible for managing the overlay view.

### OverlayView.OverlayView
- A factory constructor for creating an instance of the OverlayView class.

### OverlayView.createView
- A static method for creating and displaying the overlay view.

### OverlayView.dismiss
- A static method for dismissing and removing the overlay view.

## How to use Smart Edge Alert

```yaml
# add this line to your dependencies
smart_edge_alert: ^0.1.1
```

```dart
import 'package:smart_edge_alert/smart_edge_alert.dart';
```

```dart
SmartEdgeAlert.show(
  context,
  title: 'Title',
  titleFontSize: 20,
  description: 'Description',
  descriptionFontSize: 16,
  gravity: SmartEdgeAlert.top,
  closeButtonColor: Colors.white,
  duration: SmartEdgeAlert.lengthVeryLong,
);
```

## Example

![SmartEdgeAlert](https://github.com/fenicfelix/smart_edge_alert/blob/main/screenshots/GIF.gif)

## Properties description

Property | Description
--------|------------
context | BuildContext (Not Null) (required)
title   | 'Your title goes here'
titleFontSize   | 'Your title font size goes here'
description   | 'Your description goes here'
descriptionFontSize   | 'Your description font size goes here'
icon    | IconData (Default: Icons.notifications)
backgroundColor | Color() (Default Colors.grey)
duration| SmartEdgeAlert.lengthShort (1 second, Default) or SmartEdgeAlert.lengthLong (2 sec) or SmartEdgeAlert.lengthVeryLong (3 sec)
gravity | SmartEdgeAlert.top(Default) or SmartEdgeAlert.bottom

## Classes

- smart_edge_alert
- smart_edge_alert.OverlayView
- smart_edge_alert.OverlayView.OverlayView
- smart_edge_alert.OverlayView.createView
- smart_edge_alert.OverlayView.dismiss

## Inspiration 

[https://github.com/mohamed6996/EdgeAlert](https://github.com/mohamed6996/EdgeAlert)

## License

    MIT License
