import 'dart:ui';
import 'package:flame/components.dart';
import 'BaseGameElement.dart';

class GSpritePort extends BaseGamePortElement {
  late SpriteComponent theSprite;
  late String source;
  bool isLoadByWidth = true;
  double flexHeight = HEIGHT_RATIO;
  double displayH = 0;
  double displayW = 0;
  double ratio = 1;
  double get getWidth => (theSprite.size.x);
  void set setWidth(double w) => (theSprite.size.x = w);
  double get getHeight => (theSprite.size.y);
  void set setHeight(double h) => (theSprite.size.y = h);
  double get getPosX => (position.x);
  void set setPosX(double x) => (position.x = x);
  double get getPosY => (theSprite.size.y);
  void set setPosY(double y) => (position.y = y);
  void setPosition(Vector2 v) => (position = v);
  Vector2 get getPosition => (position);
  void setSize(Vector2 s) => (theSprite.size = s);
  Vector2 get getSize => (theSprite.size);
  GSpritePort(this.source, this.flexHeight, this.isLoadByWidth) {
    if(source == '' && flexHeight >= HEIGHT_RATIO)
      source = "background/bg001.png";
    theSprite = SpriteComponent();
    try {
      reload();
    } catch (e) {}

  }

  void reload () async {
    if (isLoadByWidth == true) await loadingSpriteByWidth();
    else await loadingSpriteByHeight();
  }

  void update(double t) {
    ratio = displayH / displayW;
  }

  Future<void> loadingSpriteByHeight() async {
    var image;
    try {
      image = await Sprite.load(source);
    } catch (e) {}
    // double w = 0;
    // double h = 0;
    // try {
    //   w = image.image.width.toDouble();
    //   h = image.image.height.toDouble();
    //
    // } catch (e) {}
    this.ratio = image.image.height / image.image.width;
    // double renderWidth = screenSize.screenX;
    double renderHeight = screenSize.screenY;
    // print("Sprite loaded. Width: ${t.image.width} - "
    //     "Height: ${h} - "
    //     "Scale: ${ ((renderWidth/w)*10000).round()/100 }% - "
    //     "Render Width: ${renderWidth} - "
    //     "Render Height: ${renderHeight}");
    displayH = flexHeight * screenSize.blockVertical;
    if(displayH > renderHeight) displayH = renderHeight;
    displayW = displayH / ratio;
    var size = Vector2(displayW, displayH);
    var pos = Vector2 ( position.x , position.y );
    theSprite = SpriteComponent(position: pos, size: size, sprite: image,);
  }

  Future<void> loadingSpriteByWidth() async {
    var image;
    try {
      image = await Sprite.load(source);
    } catch (e) {}
    // double w = 0;
    // double h = 0;
    // try {
    //   w = image.image.width.toDouble();
    //   h = image.image.height.toDouble();
    //
    // } catch (e) {}
    this.ratio = image.image.height / image.image.width;
    // double renderWidth = screenSize.screenX;
    double renderWidth = screenSize.screenY;
    // print("Sprite loaded. Width: ${t.image.width} - "
    //     "Height: ${h} - "
    //     "Scale: ${ ((renderWidth/w)*10000).round()/100 }% - "
    //     "Render Width: ${renderWidth} - "
    //     "Render Height: ${renderHeight}");
    displayW = flexHeight * screenSize.blockHorizontal;
    if(displayW > renderWidth) displayW = renderWidth;
    displayH = displayW * ratio;
    var size = Vector2(displayW, displayH);
    var pos = Vector2 ( position.x , position.y );
    theSprite = SpriteComponent(position: pos, size: size, sprite: image,);
  }


  void render(Canvas canvas) {
    theSprite.position.x = position.x;
    theSprite.position.y = position.y;
    canvas.save();
    theSprite.render(canvas);
    canvas.restore();
  }

  void updateScreenSize(double phoneWidth, double phoneHeight) {
    screenSize.update(phoneWidth, phoneHeight);
    // print("GBSSprite level screen size updated with: Width: ${phoneWidth} - Height: ${phoneHeight}");
    // reload();
  }
}

const double WIDTH_RATIO = 900;
const double HEIGHT_RATIO = 1600;