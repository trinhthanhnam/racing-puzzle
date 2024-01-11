import 'dart:ui';

class TouchSlice {
  TouchSlice({
    required this.pointsList,
    required this.lifeTime
  });
  List<Offset> pointsList;
  int lifeTime;
}