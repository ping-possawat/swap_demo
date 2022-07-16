import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swap/model/current_holding.dart';
import 'package:swap/services/woo_service.dart';

class HomePageController extends GetxController {
  late TextEditingController baseTextEditingController;
  late TextEditingController quoteTextEditingController;
  RxString baseSymbol = 'BTC'.obs;
  RxString quoteSymbol = 'ETH'.obs;
  Rxn<CurrentHolding> currentHolding = Rxn<CurrentHolding>();

  RxDouble baseToken = RxDouble(0);
  RxDouble quoteToken = RxDouble(0);
  RxnDouble exchangeRate = RxnDouble();

  final WooService wooService;
  HomePageController({required this.wooService});

  Future<void> getAsset() async {
    await wooService.getHolding().then(
      (value) {
        currentHolding.value = value;
        baseToken.value = currentHolding.value?.holding[baseSymbol.value] ?? 0;
        quoteToken.value =
            currentHolding.value?.holding[quoteSymbol.value] ?? 0;
      },
    );
  }

  Future<void> swapSymbol() async {
    final String temp = baseSymbol.value;
    baseSymbol.value = quoteSymbol.value;
    quoteSymbol.value = temp;
    _resetValue();
    await getAsset();
  }

  void _resetValue() {
    // reset YOUPAY and YOUGET value
    baseTextEditingController.clear();
    quoteTextEditingController.clear();
  }

  void quickInput(int percent) {
    if (currentHolding.value != null &&
        currentHolding.value!.holding[baseSymbol.value] != null) {
      baseTextEditingController.value = TextEditingValue(
        text: (currentHolding.value!.holding[baseSymbol.value]! * percent / 100)
            .toString(),
      );
      onChangeInput(
          (currentHolding.value!.holding[baseSymbol.value]! * percent / 100)
              .toString());
    }
  }

  void onChangeOutput(String? value) {
    if (exchangeRate.value != null) {
      baseTextEditingController.text =
          (double.parse(quoteTextEditingController.text) / exchangeRate.value!)
              .toString();
    }
  }

  void onChangeInput(String? value) {
    if (exchangeRate.value != null) {
      quoteTextEditingController.text =
          (double.parse(baseTextEditingController.text) * exchangeRate.value!)
              .toString();
    }
  }

  Future<void> getExchangeRate() async {
    exchangeRate.value = await wooService.getExchangeRate(
        baseSymbol: baseSymbol.value, quoteSymbol: quoteSymbol.value);
  }

  @override
  void onInit() {
    baseTextEditingController = TextEditingController();
    quoteTextEditingController = TextEditingController();
    baseSymbol.listen((_) async {
      await getExchangeRate();
      baseToken.value = currentHolding.value?.holding[baseSymbol.value] ?? 0;
    });
    quoteSymbol.listen((_) async {
      await getExchangeRate();
      quoteToken.value = currentHolding.value?.holding[quoteSymbol.value] ?? 0;
    });
    super.onInit();
  }

  @override
  void onReady() {
    unawaited(getAsset());
    Timer.periodic(const Duration(seconds: 10), (timer) {
      unawaited(getExchangeRate());
    });
    super.onReady();
  }
}
