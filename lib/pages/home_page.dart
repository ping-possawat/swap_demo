import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swap/constants/app_sizes.dart';
import 'package:swap/constants/ui_strings.dart';
import 'package:swap/controller/home_page_controller.dart';
import 'package:swap/widgets/background.dart';
import 'package:swap/widgets/exchange_card.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({
    Key? key,
  }) : super(key: key);

  Container _buildQuickInput() {
    return Container(
      margin: AppSize.quickInputMargin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [100, 50, 25]
            .map(
              (e) => ElevatedButton(
                onPressed: () {
                  controller.quickInput(e);
                },
                style: ElevatedButton.styleFrom(
                  onPrimary: Get.theme.colorScheme.onSecondary,
                  primary: Get.theme.colorScheme.secondary,
                ),
                child: Text(
                  '$e%',
                  style: Get.textTheme.bodyText2,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: const SizedBox(),
      title: const Text(UiStrings.appTitle),
      centerTitle: true,
      elevation: 0,
    );
  }

  SafeArea _buildBody() {
    return SafeArea(
      child: Padding(
        padding: AppSize.homePagePadding,
        child: Column(
          children: <Widget>[
            const ExchangeCard(),
            const SizedBox(
              height: 10,
            ),
            _buildQuickInput(),
            const Spacer(),
            const Divider(),
            Obx(
              () {
                if (controller.exchangeRate.value != null) {
                  return Text(
                    '1 ${controller.baseSymbol.value} = ${controller.exchangeRate} ${controller.quoteSymbol.value}',
                    style: Get.textTheme.bodyText2!.copyWith(
                      color: const Color(0xffb0b1b1),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  onPrimary: Get.theme.colorScheme.onPrimary,
                  primary: Get.theme.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Continue"),
              ),
            ),
            const SizedBox(
              height: 60,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppbar(),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          const Background(),
          _buildBody(),
        ],
      ),
    );
  }
}
