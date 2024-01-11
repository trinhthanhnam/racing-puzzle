import 'package:get/get.dart';

import 'package:gmarket/app/modules/demo/bindings/demo_binding.dart';
import 'package:gmarket/app/modules/demo/views/demo_view.dart';
import 'package:gmarket/app/modules/flashscreen/bindings/flashscreen_binding.dart';
import 'package:gmarket/app/modules/flashscreen/views/flashscreen_view.dart';
import 'package:gmarket/app/modules/petleague.flashscreeen/bindings/petleague_flashscreeen_binding.dart';
import 'package:gmarket/app/modules/petleague.flashscreeen/views/petleague_flashscreeen_view.dart';
import 'package:gmarket/app/modules/petleague.loading/bindings/petleague_loading_binding.dart';
import 'package:gmarket/app/modules/petleague.loading/views/petleague_loading_view.dart';
import 'package:gmarket/app/modules/petleague.lobbyscreen/bindings/petleague_lobbyscreen_binding.dart';
import 'package:gmarket/app/modules/petleague.lobbyscreen/views/petleague_lobbyscreen_view.dart';
import 'package:gmarket/app/modules/petleague.playground/bindings/petleague_playground_binding.dart';
import 'package:gmarket/app/modules/petleague.playground/views/petleague_playground_view.dart';
import 'package:gmarket/app/modules/petleague.quitscreen/bindings/petleague_quitscreen_binding.dart';
import 'package:gmarket/app/modules/petleague.quitscreen/views/petleague_quitscreen_view.dart';
import 'package:gmarket/app/modules/petleague.resultscreen/bindings/petleague_resultscreen_binding.dart';
import 'package:gmarket/app/modules/petleague.resultscreen/views/petleague_resultscreen_view.dart';
import 'package:gmarket/app/modules/saturday/bindings/saturday_binding.dart';
import 'package:gmarket/app/modules/saturday/views/saturday_view.dart';
import 'package:gmarket/app/modules/slash/bindings/slash_binding.dart';
import 'package:gmarket/app/modules/slash/views/slash_view.dart';
import 'package:gmarket/app/modules/snake.game/bindings/snake_game_binding.dart';
import 'package:gmarket/app/modules/snake.game/views/snake_game_view.dart';
import 'package:gmarket/app/modules/snake.lobby/bindings/snake_lobby_binding.dart';
import 'package:gmarket/app/modules/snake.lobby/views/snake_lobby_view.dart';
import 'package:gmarket/app/modules/sunday/bindings/sunday_binding.dart';
import 'package:gmarket/app/modules/sunday/views/sunday_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.FLASHSCREEN;

  static final routes = [
    GetPage(
      name: _Paths.SLASH,
      page: () => SlashView(),
      binding: SlashBinding(),
    ),
    GetPage(
      name: _Paths.SNAKE_LOBBY,
      page: () => SnakeLobbyView(),
      binding: SnakeLobbyBinding(),
    ),
    GetPage(
      name: _Paths.SNAKE_GAME,
      page: () => SnakeGameView(),
      binding: SnakeGameBinding(),
    ),
    GetPage(
      name: _Paths.DEMO,
      page: () => DemoView(),
      binding: DemoBinding(),
    ),
    GetPage(
      name: _Paths.SATURDAY,
      page: () => SaturdayView(),
      binding: SaturdayBinding(),
    ),
    GetPage(
      name: _Paths.SUNDAY,
      page: () => SundayView(),
      binding: SundayBinding(),
    ),
    GetPage(
      name: _Paths.PETLEAGUE_PLAYGROUND,
      page: () => PetleaguePlaygroundView(),
      binding: PetleaguePlaygroundBinding(),
    ),
    GetPage(
      name: _Paths.PETLEAGUE_FLASHSCREEEN,
      page: () => PetleagueFlashscreeenView(),
      binding: PetleagueFlashscreeenBinding(),
    ),
    GetPage(
      name: _Paths.PETLEAGUE_LOADING,
      page: () => PetleagueLoadingView(),
      binding: PetleagueLoadingBinding(),
    ),
    GetPage(
      name: _Paths.PETLEAGUE_LOBBYSCREEN,
      page: () => PetleagueLobbyscreenView(),
      binding: PetleagueLobbyscreenBinding(),
    ),
    GetPage(
      name: _Paths.PETLEAGUE_RESULTSCREEN,
      page: () => PetleagueResultscreenView(),
      binding: PetleagueResultscreenBinding(),
    ),
    GetPage(
      name: _Paths.PETLEAGUE_QUITSCREEN,
      page: () => PetleagueQuitscreenView(),
      binding: PetleagueQuitscreenBinding(),
    ),
    GetPage(
      name: _Paths.FLASHSCREEN,
      page: () => FlashscreenView(),
      binding: FlashscreenBinding(),
    ),
  ];
}
