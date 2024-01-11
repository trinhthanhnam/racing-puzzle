import 'dart:ui';
import 'package:flame/events.dart';
import 'package:flame/input.dart';

import 'SpriteAnimation.dart';
import '../modules/petleague/component/landscape/GBackgroundFullLangScroll.dart';
import '../modules/petleague/component/other/GPlayButtonPort.dart';
import '../modules/petleague/component/landscape/GBackgroundFullLand.dart';
import 'SpriteBasic.dart';
import 'BaseGameElement.dart';

class DemoRun extends BaseGameLangElement {
  late BackGroundFullLang? background;
  late BackGroundLangScroll background1;
  late GPlayButtonPort button;
  late BackGroundLangScroll background2;
  late SpriteBasic bird1;
  late SpriteBasic bird2;
  late SpriteAnimation abird1;
  late SpriteAnimation abird2;
  late SpriteAnimation runner1;
  late SpriteAnimation runner2;
  late SpriteAnimation rabit1;
  late SpriteAnimation cat1;
  int current = DateTime.now().millisecond;
  double currentRate = 30;
  double speed = 1;
  int status = 0;
  List<BaseGameLangElement> listAllElement = [];
  List<SpriteAnimation> listAnimation = [];
  DemoRun() {
    background1 = new BackGroundLangScroll('saturday/background1.png');
    background2 = new BackGroundLangScroll('saturday/background2.png');
    bird1 = new SpriteBasic("saturday/player/bird1/tile000.png", 79);
    bird2 = new SpriteBasic("saturday/player/bird2/tile000.png", 79);
    abird1 = new SpriteAnimation("saturday/player/bird1/bird1.png", 13, 150, 150);
    abird2 = new SpriteAnimation("saturday/player/bird2/bird2.png", 14, 150, 150);
    runner1 = new SpriteAnimation("saturday/player/runner1/runner1.png", 16, 80, 250);
    runner2 = new SpriteAnimation("saturday/player/runner2/runner2.png", 8, 200, 150);
    rabit1 = new SpriteAnimation("saturday/player/rabit1/rabit1.png", 8, 200, 100);
    cat1 = new SpriteAnimation("saturday/player/cat1/cat1.png", 8, 200, 350);
    listAllElement.addAll([
      background1,
      background2,
      bird1,
      bird2,
      abird1,
      abird2,
      runner1,
      runner2,
      rabit1,
      cat1,
    ]);
    listAnimation.addAll([
      abird1,
      abird2,
      runner1,
      runner2,
      rabit1,
      cat1,
    ]);
  }
  @override
  void render(Canvas canvas) {
    canvas.save();
    if(status == 0) renderLobbyScreen(canvas);
    else if(status == 1)  renderPlayScreen(canvas);
    else  renderEmtpyScreen(canvas);
    canvas.restore();
    this.update(0);
  }
  @override
  void update(double t) {
    refreshRate(t);

  }
  void refreshRate(double rate) {
    int i = DateTime.now().millisecond;
    double r = (1000 / rate).roundToDouble();
    currentRate = r;
    if( (i - current).abs() > r ){
      for(var i in listAllElement) {
        i.update(rate);
      }
      current = i;
    }
  }
  void renderLobbyScreen(Canvas canvas) {
    background1.render(canvas);
    button.render(canvas);
  }
  void renderPlayScreen(Canvas canvas) {
    background2.render(canvas);
    for(var i in listAnimation) {
      i.render(canvas);
    }
  }
  void renderEmtpyScreen(Canvas canvas) {
    background1.render(canvas);
  }
  @override
  void resize(Size s) {
  }
  void demoRunTapDown(TapDownInfo tap) {
    beginRun();
    checkSelected(tap);
  }
  void beginRun() {
    if(status == 0)
      status = 1;
  }
  void checkSelected(TapDownInfo details) {
    // player.moveForward();
    for(var i in listAnimation) {
      i.isSelected(details);
    }
  }
  void updateScreenSize(double phoneWidth, double phoneHeight) {
    screenSize.update(phoneWidth, phoneHeight);
    for(var i in listAllElement) {
      i.updateScreenSize(phoneWidth, phoneHeight);
    }
  }
}