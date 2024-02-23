# Smart Edge Alert

A Flutter package that shows an interrupted smart alert from the top or bottom.

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

## Inspiration 

[https://github.com/mohamed6996/EdgeAlert](https://github.com/mohamed6996/EdgeAlert)

## License

    MIT License
