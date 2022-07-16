import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swap/constants/app_fonts.dart';
import 'package:swap/model/available_token.dart';
import 'package:swap/services/woo_service.dart';

class AssetPage extends StatelessWidget {
  const AssetPage(
      {Key? key, required this.unselectableAsset, required this.wooService})
      : super(key: key);

  final String unselectableAsset;
  final WooService wooService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Asset'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<AvailableTokenResponse>(
                future: wooService.getAvailableTokens(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        if (snapshot.data!.rows[index].balanceToken !=
                            unselectableAsset) {
                          final Token token = snapshot.data!.rows[index];
                          return ListTile(
                            onTap: () {
                              Get.back<String>(result: token.balanceToken);
                            },
                            title: Text(
                              token.balanceToken,
                              style: AppFonts.textTheme.bodyText1!
                                  .copyWith(color: Colors.black),
                            ),
                            subtitle: Text(
                              token.fullname,
                              style: AppFonts.textTheme.bodyText1!
                                  .copyWith(color: Colors.black),
                            ),
                            leading: Image.network(
                                'https://oss.woo.network/static/symbol_logo/${token.balanceToken}.png'),
                          );
                        }
                        return const SizedBox();
                      },
                      itemCount: snapshot.data!.rows.length,
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
