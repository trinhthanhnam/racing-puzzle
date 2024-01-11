import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'BaseGameElement.dart';

class GSpritePortAnimate extends BaseGamePortElement {
  SpriteAnimationComponent theSprite = SpriteAnimationComponent();
  late String source;
  double flexibleSize = 100;
  bool isLoadByWidth = true;
  bool loop = true;
  double displayWidth = 0;
  double displayHeight = 0;
  double ratio = 1;

  double get getWidth => (theSprite.size.x);
  void set setWidth(double w) => (theSprite.size.x = w);
  double get getHeight => (theSprite.size.y);
  void set setHeight(double h) => (theSprite.size.y = h);
  double step;
  int frame;
  GSpritePortAnimate(this.source, this.frame, this.step, this.flexibleSize, this.isLoadByWidth, this.loop) {
    init();
  }

  void init() async {
    if(isLoadByWidth == true)
      await loadingAnimationSpriteByWidth();
    else
      await loadingAnimationSpriteByHeight();
  }

  Future<void> loadingAnimationSpriteByWidth() async {
    var spriteSheet = await Flame.images.load(source);
    var width = spriteSheet.width / frame;
    var height = spriteSheet.height.toDouble();
    this.ratio = height / width;
    displayWidth = flexibleSize * screenSize.Block;
    displayHeight = displayWidth * ratio;
    position.x = 0;
    position.y = 0;
    SpriteAnimationData configData = SpriteAnimationData.sequenced(amount: frame, stepTime: step, textureSize: Vector2(width,height));
    var spriteSize = Vector2(displayWidth, displayHeight);
    this.theSprite = SpriteAnimationComponent.fromFrameData(spriteSheet, configData)
                ..x =  position.x
                ..y =  position.y
                ..size = spriteSize;
    this.theSprite.animation!.loop = this.loop;
  }

  Future<void> loadingAnimationSpriteByHeight() async {
    var spriteSheet = await Flame.images.load(source);
    var width = spriteSheet.width / frame;
    var height = spriteSheet.height.toDouble();
    this.ratio = height / width;
    displayHeight = flexibleSize * screenSize.Block;
    displayWidth = displayHeight / ratio;
    position.x = 0;
    position.y = 0;
    SpriteAnimationData configData = SpriteAnimationData.sequenced(amount: frame, stepTime: step, textureSize: Vector2(width,height));
    var spriteSize = Vector2(displayWidth, displayHeight);
    theSprite = SpriteAnimationComponent.fromFrameData(spriteSheet, configData)
      ..x = position.x
      ..y = position.y
      ..size = spriteSize;
    this.theSprite.animation!.loop = this.loop;
  }

  void render(Canvas canvas) {
    canvas.save();
    theSprite.render(canvas);
    canvas.restore();
  }

  void syncPosition(Vector2 newPos) {
    if(position == newPos) {
      return;
    }
    position.x = newPos.x;
    position.y = newPos.y;
    theSprite.position.x = position.x;
    theSprite.position.y = position.y;
  }

  void movePosition(Vector2 distance) {
    position.x += distance.x;
    position.y += distance.y;
    theSprite.position.x += distance.x;
    theSprite.position.y += distance.y;
    syncPosition(position);
  }

  void update(double t){
    theSprite.update(t);
    ratio = displayHeight / displayWidth;
    // print("GBSSpriteAnimation update called!");
  }

  void resetAnimation() {
    if(theSprite.animation == null) return;
    // getSprite!.animation!.currentIndex = 0;
    getSprite!.animation!.frames!.first;
  }
  void syncAnimation(int f) {
    if(theSprite.animation == null) return;
    // getSprite!.animation!.currentIndex = 0;
    getSprite!.animation!.frames!.first;
  }
  void updateScreenSize(double phoneWidth, double phoneHeight) {
    if(phoneWidth == screenSize.phoneX && phoneHeight == screenSize.phoneY) return;
    screenSize.update(phoneWidth, phoneHeight);
    // print("GBSSpriteAnimate level screen size updated with: Width: ${phoneWidth} - Height: ${phoneHeight}");
  }
}

const double WIDTH_RATIO = 900;
const double HEIGHT_RATIO = 1600;