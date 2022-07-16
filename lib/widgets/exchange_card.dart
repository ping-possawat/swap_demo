import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:swap/constants/app_icon.dart';
import 'package:swap/constants/app_sizes.dart';
import 'package:swap/constants/ui_strings.dart';
import 'package:swap/controller/home_page_controller.dart';

class ExchangeCard extends GetView<HomePageController> {
  const ExchangeCard({
    Key? key,
  }) : super(key: key);

  Align _buildExchangeIcon() {
    return Align(
      alignment: const Alignment(.7, 0),
      child: GestureDetector(
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white,
          child: SvgPicture.asset(
            AppIcon.exchange,
            color: Colors.black,
          ),
        ),
        onTap: () async {
          await controller.swapSymbol();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: AppSize.exchangeCardBorderRadius,
        color: Colors.black.withOpacity(.3),
      ),
      padding: AppSize.exchangeCardPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [_buildYouPay(), _buildExchangeIcon(), _buildYouGet()],
      ),
    );
  }

  Row _buildYouPay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                UiStrings.exchangeCardYouPay,
                style: Get.textTheme.bodyText2,
              ),
              TextField(
                controller: controller.baseTextEditingController,
                style: Get.textTheme.headline1,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                onChanged: controller.onChangeInput,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              Obx(
                () => Text(
                  'BALANCE: ${controller.baseToken.value} ${controller.baseSymbol.value}',
                  style: Get.textTheme.bodyText2,
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Obx(
                () => Image.network(
                  'https://oss.woo.network/static/symbol_logo/${controller.baseSymbol.value}.png',
                  width: 40,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text(controller.baseSymbol.value)),
                  const Text('BEP20'),
                ],
              ),
              IconButton(
                onPressed: () async {
                  final selectedAsset = await Get.toNamed('/assets',
                      arguments: controller.quoteSymbol.value);
                  if (selectedAsset != null) {
                    controller.baseSymbol.value = selectedAsset as String;
                  }
                },
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 20,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Row _buildYouGet() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                UiStrings.exchangeCardYouGet,
              ),
              TextField(
                controller: controller.quoteTextEditingController,
                style: Get.textTheme.headline1,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                onChanged: controller.onChangeOutput,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              Obx(
                () => Text(
                  'BALANCE: ${controller.quoteToken.value} ${controller.quoteSymbol.value}',
                  style: Get.textTheme.bodyText2,
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Obx(
                () => Image.network(
                  'https://oss.woo.network/static/symbol_logo/${controller.quoteSymbol.value}.png',
                  width: 40,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text(controller.quoteSymbol.value)),
                  const Text('BEP20'),
                ],
              ),
              IconButton(
                onPressed: () async {
                  final selectedAsset = await Get.toNamed('/assets',
                      arguments: controller.baseSymbol.value);
                  if (selectedAsset != null) {
                    controller.quoteSymbol.value = selectedAsset as String;
                  }
                },
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 20,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
