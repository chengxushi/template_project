import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:ff_annotation_route_library/ff_annotation_route_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'common/info/app_color.dart';
import 'page/home/home_page.dart';
import 'route/template_project_route.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ///让状态栏的蒙层变透明
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
  runApp(Route2());
}

class MyApp extends StatelessWidget {
  ///调用 BotToastInit
  final TransitionBuilder botToastBuilder = BotToastInit();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '模板项目',
      theme: ThemeData(
        primarySwatch: Colors.blue, //主题色
        platform: TargetPlatform.iOS, //整体风格
        textTheme: const TextTheme(
          bodyText2: TextStyle(color: AppColor.grey33), //默认字体颜色
        ),
        highlightColor: Colors.transparent,  // 默认点击按钮的颜色
        splashColor: Colors.transparent, //点击水波纹的颜色
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white, //默认Appbar背景颜色
          centerTitle: true, //标题居中
          elevation: 0.0, //Appbar下面景深程度
          iconTheme: IconThemeData(color: Colors.black), //默认返回按钮的颜色
          textTheme: TextTheme( //默认标题title的字体样式
            headline6: TextStyle(
              fontSize: 17,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        scaffoldBackgroundColor: Colors.white, //默认页面的背景颜色
        dividerColor: Colors.grey, //分割线默认颜色
      ),
      home: HomePage(),
      builder: (BuildContext context, Widget? child) {
        child = botToastBuilder(context, child);
        return MediaQuery(
          ///保证文字大小不受手机系统设置影响
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child,
        );
      },
      onGenerateRoute: (RouteSettings settings) {
        return onGenerateRoute(
          settings: settings,
          getRouteSettings: getRouteSettings,
          routeSettingsWrapper: (FFRouteSettings ffRouteSettings) {
            return ffRouteSettings;
          }
        );
      },
      navigatorObservers: <NavigatorObserver>[
        BotToastNavigatorObserver(), //botToast设置
      ],
      localizationsDelegates: [ //国际化
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: <Locale>[
        const Locale('zh', 'CH'), //只设置中文,
        // const Locale('en', 'US'),
      ],
    );
  }
}

/// 路由2.0
class Route2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final FFRouterDelegate _routerDelegate = FFRouterDelegate(
      getRouteSettings: getRouteSettings,
    );

    return MaterialApp.router(
      title: '模板项目',
      theme: ThemeData(
        primarySwatch: Colors.blue, //主题色
        platform: TargetPlatform.iOS, //整体风格
        textTheme: const TextTheme(
          bodyText2: TextStyle(color: AppColor.grey33), //默认字体颜色
        ),
        highlightColor: Colors.transparent,  // 默认点击按钮的颜色
        splashColor: Colors.transparent, //点击水波纹的颜色
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white, //默认Appbar背景颜色
          centerTitle: true, //标题居中
          elevation: 0.0, //Appbar下面景深程度
          iconTheme: IconThemeData(color: Colors.black), //默认返回按钮的颜色
          textTheme: TextTheme( //默认标题title的字体样式
            headline6: TextStyle(
              fontSize: 17,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        scaffoldBackgroundColor: Colors.white, //默认页面的背景颜色
        dividerColor: Colors.grey, //分割线默认颜色
      ),
      routeInformationParser: FFRouteInformationParser(),
      routerDelegate: _routerDelegate,
      builder: BotToastInit(),
      localizationsDelegates: [ //国际化
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: <Locale>[
        const Locale('zh', 'CH'), //只设置中文,
        // const Locale('en', 'US'),
      ],
    );
  }

}
