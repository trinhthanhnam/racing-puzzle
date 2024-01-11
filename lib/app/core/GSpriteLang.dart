import 'dart:math';
import 'dart:ui';
import 'package:flame/components.dart';
import 'BaseGameElement.dart';

class GSpriteLang extends BaseGameLangElement {
  SpriteComponent? getSprite;
  String? source;
  double flexibleSize = WIDTH_RATIO;
  double displayW = 0;
  double displayH = 0;
  double ratio = 1;
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
  GSpriteLang(this.source, this.flexibleSize) {
    if(source == '' && flexibleSize >= WIDTH_RATIO)
      source = "background/bg001.png";
    getSprite = SpriteComponent();
    try {
      reload();
    } catch (e) {}

  }

  void reload () async {
    if(flexibleSize >= WIDTH_RATIO) {
      await loadingBackground();
    } else {
      await loadingSprite();
    }
  }

  Future<void> loadingSprite() async {
    var t;
    try {
    t = await Sprite.load(source!);
    } catch (e) {}
    double w = 0;
    double h = 0;
    try {
      w = t.image.width.toDouble();
      h = t.image.height.toDouble();

    } catch (e) {}
    this.ratio = t.image.height / t.image.width;
    double renderWidth = screenSize.screenX;
    double renderHeight = screenSize.screenY;

    // print("Sprite loaded. Width: ${t.image.width} - "
    //     "Height: ${h} - "
    //     "Scale: ${ ((renderWidth/w)*10000).round()/100 }% - "
    //     "Render Width: ${renderWidth} - "
    //     "Render Height: ${renderHeight}");
    displayH = flexibleSize * screenSize.blockVertical;
    if(displayH > renderHeight) displayH = renderHeight;
    displayW = displayH / ratio;
    var size = Vector2(displayW, displayH);
    var r = new Random();
    var posX = 10 + r.nextDouble() * screenSize.screenX / 1.1;
    var posY = 10 + r.nextDouble() * screenSize.screenY / 1.1;
    var pos = Vector2 ( posX, posY );
    getSprite = SpriteComponent(position: pos, size: size, sprite: t,);
  }

  Future<void> loadingBackground() async {
    var t = await Sprite.load(source!);
    var w = t.image.width;
    var h = t.image.height;
    double ratio = t.image.height / t.image.width;
    double renderWidth = screenSize.screenX;
    double renderHeight = screenSize.screenY;
    displayW = renderWidth;
    displayH = renderHeight;
    if(w < renderWidth && h < renderHeight) {
      // print("Resize source image");
      displayH = renderHeight;
      displayW = renderHeight * ratio;
    } else if (w < renderWidth) {
      // print("Resize source image");
      displayH = renderHeight;
      displayW = renderHeight * ratio;
    } else if (h < renderHeight) {
      // print("Resize source image");
      displayH = renderHeight;
      displayW = renderHeight * ratio;
    }
    // print("Background loaded. Width: ${t.image.width} - "
    //     "Height: ${h} - "
    //     "Scale: ${ ((renderWidth/w)*10000).round()/100 }% - "
    //     "Render Width: ${renderWidth} - "
    //     "Render Height: ${renderHeight}");
    var size = Vector2 ( displayW, displayH );
    // var pos = Vector2 ( screenSize.posX, screenSize.posY );
    var pos = Vector2 ( 0, 0 ); // background alway load fullscreen
    getSprite = SpriteComponent(position: pos, size: size, sprite: t,);
  }

  void render(Canvas canvas) {
    canvas.save();
    getSprite!.render(canvas);
    canvas.restore();
  }
  void update(double t) {
    ratio = displayH / displayW;
  }
  void updateScreenSize(double phoneWidth, double phoneHeight) {
    screenSize.update(phoneWidth, phoneHeight);
    // print("GBSSprite level screen size updated with: Width: ${phoneWidth} - Height: ${phoneHeight}");
    // reload();
  }
}

const double WIDTH_RATIO = 1600;
const double HEIGHT_RATIO = 900;