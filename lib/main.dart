import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swap/constants/app_fonts.dart';
import 'package:swap/constants/app_theme.dart';
import 'package:swap/controller/home_page_controller.dart';
import 'package:swap/pages/asset_page/asset_page.dart';
import 'package:swap/pages/home_page.dart';
import 'package:swap/services/woo_service.dart';

void main() {
  runApp(const SwapApp());
}

// Initial Services
class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(WooService(), permanent: true);
  }
}

class SwapApp extends StatelessWidget {
  const SwapApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Swap Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: AppColorScheme.lightThemeColor,
        textTheme: AppFonts.textTheme,
        backgroundColor: AppColorScheme.lightThemeColor.background,
      ),
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(
        colorScheme: AppColorScheme.darkThemeColor,
        textTheme: AppFonts.textTheme,
        backgroundColor: AppColorScheme.darkThemeColor.background,
      ),
      initialBinding: AppBindings(),
      getPages: [
        GetPage(
          name: '/',
          page: () => const HomePage(),
          binding: BindingsBuilder.put(
            () => HomePageController(
              wooService: Get.find<WooService>(),
            ),
          ),
        ),
        GetPage(
          name: '/assets',
          page: () {
            final String args = Get.arguments;
            return AssetPage(
              unselectableAsset: args,
              wooService: Get.find<WooService>(),
            );
          },
        ),
      ],
      initialRoute: '/',
    );
  }
}
