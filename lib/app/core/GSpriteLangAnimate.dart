import 'dart:math';
import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'BaseGameElement.dart';

class GSpriteLangAnimate extends BaseGameLangElement {
  SpriteAnimationComponent? getSprite;
  Image? spriteSheet;
  String? source;
  double flexibleSize = 100;
  double x = 0;
  double y = 0;
  double ratio = 1;
  double displayWidth = 0;
  double displayHeight = 0;
  double get getWidth => (getSprite!.size.x);
  void set setWidth(double w) => (getSprite!.size.x = w);
  double get getHeight => (getSprite!.size.y);
  void set setHeight(double h) => (getSprite!.size.y = h);
  double get getPosX => (getSprite!.position.x);
  void set setPosX(double x) => (getSprite!.position.x = x);
  double get getPosY => (getSprite!.size.y);
  void set setPosY(double y) => (getSprite!.position.y = y);
  void setPosition(Vector2 v) => (getSprite!.position = v);
  Vector2 get getPosition => (getSprite!.position);
  void setSize(Vector2 s) => (getSprite!.size = s);
  Vector2 get getSize => (getSprite!.size);
  double step;
  int frame;
  GSpriteLangAnimate(this.source, this.frame, this.step, this.flexibleSize) {
    if(source == '') {
      source = "avatar/dog2/dog2.png";
      frame = 10;
      step = 300;
    }
    getSprite = new SpriteAnimationComponent();
    init();
  }

  void init() async {
    await loadingAnimationSprite();
  }

  Future<void> loadingAnimationSprite() async {
    spriteSheet = await Flame.images.load(source!);
    var width = spriteSheet!.width / frame;
    var height = spriteSheet!.height.toDouble();
    this.ratio = height / width;
    displayHeight = flexibleSize * screenSize.blockVertical;
    displayWidth = displayHeight / ratio;
    var r = new Random();
    var posX = 10 + r.nextDouble() * screenSize.screenX / 1.1;
    var posY = 10 + r.nextDouble() * screenSize.screenY / 1.1;
    // List<SpriteComponent?> list = [1,2,3,4,5,6,7,8,9,10,11,12,13].map((e) => GBSSprite('', 50).getSprite).toList();
    SpriteAnimationData configData = SpriteAnimationData.sequenced(amount: frame, stepTime: step, textureSize: Vector2(width,height));
    var spriteSize = Vector2(displayWidth, displayHeight);
    getSprite = SpriteAnimationComponent.fromFrameData(spriteSheet!, configData)
                ..x = posX
                ..y = posY
                ..size = spriteSize;
  }

  void render(Canvas canvas) {
    canvas.save();
    getSprite!.render(canvas);
    canvas.restore();
  }

  void update(double t){
    getSprite!.update(t);
    ratio = displayHeight / displayWidth;
    // print("GBSSpriteAnimation update called!");
  }

  void resetAnimation() {
    // getSprite!.animation!.currentIndex = 0;
    getSprite!.animation!.frames!.first;
  }

  void updateScreenSize(double phoneWidth, double phoneHeight) {
    screenSize.update(phoneWidth, phoneHeight);
    // print("GBSSpriteAnimate level screen size updated with: Width: ${phoneWidth} - Height: ${phoneHeight}");
  }
}

const double WIDTH_RATIO = 1600;
const double HEIGHT_RATIO = 900;