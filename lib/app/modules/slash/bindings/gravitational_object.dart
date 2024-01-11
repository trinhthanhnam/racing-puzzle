import 'dart:ui';

abstract class GravitationalObject {
  GravitationalObject({
    required this.position,
    this.gravitySpeed = 0.0,
    this.additionalForce = const Offset(0,0),
    this.rotation = 0
  });

  Offset position;
  double gravitySpeed;
  double _gravity = 2.0;
  Offset additionalForce;
  double rotation;

  void applyGravity() {
    gravitySpeed += _gravity;
    position = Offset(
        position.dx + additionalForce.dx,
        position.dy + gravitySpeed + additionalForce.dy
    );
  }
}