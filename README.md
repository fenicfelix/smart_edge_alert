# Smart Edge Alert

A Flutter package that shows an interrupted smart alert from the top or bottom.

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
smart_edge_alert: ^0.0.1
```

```dart
import 'package:smart_edge_alert/smart_edge_alert.dart';
```

```dart
SmartEdgeAlert.show(
  context,
  title: 'Title',
  description: 'Description',
  gravity: SmartEdgeAlert.TOP,
  closeButtonColor: Colors.white,
  duration: SmartEdgeAlert.LENGTH_VERY_LONG,
);
```

## Properties description

Property | Description
--------|------------
context | BuildContext (Not Null)(required)
title   | 'Your title goes here'
description   | 'Your description goes here'
icon    | IconData (Default: Icons.notifications)
backgroundColor | Color() (Default Colors.grey)
duration| SmartEdgeAlert.LENGTH_SHORT (1 second, Default) or SmartEdgeAlert.LENGTH_LONG (2 sec) or SmartEdgeAlert.LENGTH_VERY_LONG (3 sec)
gravity | SmartEdgeAlert.TOP(Default) or SmartEdgeAlert.BOTTOM

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
