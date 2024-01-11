// framework include:
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'dart:math';
// app config include:
import '../../../GBS/appconfig/global.dart';
import '../../../GBS/backend/api_service.dart';
// page include:
import '../bindings/slash_binding.dart';

import '../bindings/fruit.dart';
import '../bindings/fruit_part.dart';
import '../bindings/touch_slice.dart';
import '../bindings/slice_painter.dart';

class SlashController extends GetxController {
  //TODO: Implement SlashController

  final count = 0.obs;
  @override
  void onInit() {
    mainGameLoop();
    refreshPosition();
    addMoreFruit();
    super.onInit();
  }

  void mainGameLoop() {
    Future.delayed(Duration(milliseconds: frameRate), mainGameLoop);
    sharpSlice();
    update();
  }

  void addMoreFruit() {
    Future.delayed(Duration(milliseconds: addFruit), addMoreFruit);
    randomFruit();
  }

  void refreshPosition() {
    Future.delayed(Duration(milliseconds: updateRate), refreshPosition);
    effectGravity();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  final int   frameRate = 15;       // 1000/frameRate = refresh speed
  final int   updateRate  = 50;
  final int   addFruit  = 5000;
  TouchSlice touchSlice = TouchSlice(pointsList: [], lifeTime: DateTime.now().millisecond);
  List<Fruit> fruits = [];
  List<FruitPart> fruitParts = [];
  int score = 0;
  status() {
    print("is Android: ${GetPlatform.isAndroid}");
    print("is iOS: ${GetPlatform.isIOS}");
  }



  Widget displayGame(BuildContext context) {
    return GetBuilder(builder: (SlashController controller) {
      return Stack(
          children: getAllElements()
      );
    });
  }

  void randomFruit() {
    fruits.add(new Fruit(
        position: Offset(0, 200),
        width: 80,
        height: 80,
        additionalForce: Offset(5 + Random().nextDouble() * 5, Random().nextDouble() * -10),
        rotation: Random().nextDouble() / 3 - 0.16
    ));
  }

  void effectGravity() {
    for (Fruit fruit in fruits) {
      fruit.applyGravity();
    }
    for (FruitPart fruitPart in fruitParts) {
      fruitPart.applyGravity();
    }

    if (Random().nextDouble() > 0.97) {
      randomFruit();
    }
  }



  List<Widget> getAllElements() {
    List<Widget> widgetsOnStack = [];
    widgetsOnStack.add(getBackground());
    widgetsOnStack.add(getSlice());
    widgetsOnStack.addAll(getSlashedFruit());
    widgetsOnStack.addAll(getFruits());
    widgetsOnStack.add(getGestureDetector());
    widgetsOnStack.add(
        Positioned(
            right: 30,
            top: 30,
            child: RichText(
              text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: "V", style: TextStyle(color: Colors.blue, fontSize: 30, fontWeight: FontWeight.bold,)),
                    TextSpan(text: "ợ ", style: TextStyle(color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold, fontFamily: "DancingScript")),
                    TextSpan(text: "y", style: TextStyle(color: Colors.yellow, fontSize: 30, fontWeight: FontWeight.bold, fontFamily: "DancingScript")),
                    TextSpan(text: "ê", style: TextStyle(color: Colors.blue, fontSize: 30, fontWeight: FontWeight.bold,)),
                    TextSpan(text: "u:  ", style: TextStyle(color: Colors.green, fontSize: 30, fontWeight: FontWeight.bold)),
                    TextSpan(text: "${score}", style: TextStyle(color: Colors.red, fontSize: 35, fontWeight: FontWeight.bold)),
                  ]
              ),
            ),
      )
    );
    return widgetsOnStack;
  }

  Container getBackground() {
    return Container(
      decoration: new BoxDecoration(
          gradient: new RadialGradient(
            stops: [0.2, 1.0],
            colors: [
              Color(0xff76ff5e),
              Color(0xffa4ee96)
            ],
          )
      ),
    );
  }

  sharpSlice() {
    resetSlice();
  }

  Widget getSlice() {
    if (touchSlice.pointsList.isEmpty) {
      return Container();
    }
    update();
    return CustomPaint(
        size: Size.infinite,
        painter: SlicePainter(
          pointsList: touchSlice.pointsList,
        )
    );
  }

  List<Widget> getFruits() {
    List<Widget> list = [];

    for (Fruit fruit in fruits) {
      list.add(
          Positioned(
              top: fruit.position.dy,
              left: fruit.position.dx,
              child: Transform.rotate(
                  angle: fruit.rotation * pi * 2,
                  child: getMelon(fruit)
              )
          )
      );
    }

    return list;
  }

  List<Widget> getSlashedFruit() {
    List<Widget> list = [];

    for (FruitPart fruitPart in fruitParts) {
      list.add(
          Positioned(
              top: fruitPart.position.dy,
              left: fruitPart.position.dx,
              child: getMelonCut(fruitPart)
          )
      );
    }

    return list;
  }

  Widget getMelonCut(FruitPart fruitPart) {
    return Transform.rotate(
        angle: fruitPart.rotation * pi * 2,
        child: Image.asset(
            fruitPart.isLeft ? 'assets/fruit/melon_cut.png': 'assets/fruit/melon_cut_right.png',
            height: 80,
            fit: BoxFit.fitHeight
        )
    );
  }

  Widget getMelon(Fruit fruit) {
    return Image.asset(
        'assets/fruit/melon_uncut.png',
        height: 80,
        fit: BoxFit.fitHeight
    );
  }

  Widget getGestureDetector() {
    return GestureDetector(
        onScaleStart: (details) {
          setNewSlice(details);
        },
        onScaleUpdate: (details) {
          addPointToSlice(details);
          checkCollision();
        },
        onScaleEnd: (details) {
          resetSlice();
        }
    );
  }

  void checkCollision() {
    if (touchSlice == null) {
      return;
    }

    for (Fruit fruit in List.from(fruits)) {
      bool firstPointOutside = false;
      bool secondPointInside = false;

      for (Offset point in touchSlice.pointsList) {
        if (!firstPointOutside&& !fruit.isPointInside(point)) {
          firstPointOutside = true;
          continue;
        }

        if (firstPointOutside && fruit.isPointInside(point)) {
          secondPointInside = true;
          continue;
        }

        if (secondPointInside && !fruit.isPointInside(point)) {
          fruits.remove(fruit);
          turnFruitIntoParts(fruit);
          score += 10;
          break;
        }
      }
    }
  }

  void turnFruitIntoParts(Fruit hit) {
    FruitPart leftFruitPart = FruitPart(
        position: Offset(
            hit.position.dx - hit.width / 8,
            hit.position.dy
        ),
        width: hit.width / 2,
        height: hit.height,
        isLeft: true,
        gravitySpeed: hit.gravitySpeed,
        additionalForce: Offset(hit.additionalForce.dx - 1, hit.additionalForce.dy -5),
        rotation:  hit.rotation
    );

    FruitPart rightFruitPart = FruitPart(
        position: Offset(
            hit.position.dx + hit.width / 4 + hit.width / 8,
            hit.position.dy
        ),
        width: hit.width / 2,
        height: hit.height,
        isLeft: false,
        gravitySpeed: hit.gravitySpeed,
        additionalForce: Offset(hit.additionalForce.dx + 1, hit.additionalForce.dy -5),
        rotation:  hit.rotation
    );

    fruitParts.add(leftFruitPart);
    fruitParts.add(rightFruitPart);
    fruits.remove(hit);
  }

  void resetSlice() {
    int now = DateTime.now().millisecond;
    if((touchSlice.lifeTime - now).abs() > 500)
      touchSlice = TouchSlice(pointsList: [], lifeTime: DateTime.now().millisecond);
  }

  void setNewSlice(details) {
    touchSlice = TouchSlice(pointsList: [details.localFocalPoint], lifeTime: DateTime.now().millisecond);
  }

  void addPointToSlice(ScaleUpdateDetails details) {
    if (touchSlice.pointsList.length > 500) {
      touchSlice.pointsList.removeAt(0);
    }
    touchSlice.pointsList.add(details.localFocalPoint);
  }
}
