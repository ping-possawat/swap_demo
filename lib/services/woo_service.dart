import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:swap/model/available_token.dart';
import 'package:swap/model/current_holding.dart';
import 'package:swap/model/kline.dart';

class WooService {
  static const String apiKey = 'PnGWD/cf2X1KkS8DNzv2mQ==';
  static const String apiSecret = 'F2ZXR4KTUS7VVSQXETRUZBQMXIB4';
  static const String appId = 'ad81f944-e323-4dd0-84a3-2228596ab8b3';
  static const String basePath = 'https://api.woo.org';
  static const String socketPath = 'wss://wss.woo.org/ws/stream/$appId';

  static final currentTimestamp =
      DateTime.now().millisecondsSinceEpoch.toString();

  Future<http.Response> _getKline(String symbol) async {
    // get Kline
    return await http.get(
        Uri.parse('$basePath/v1/kline/?symbol=$symbol&type=1m'),
        headers: headers(
          query: {'symbol': symbol, 'type': '1m'},
        ));
  }

  Future<double> getExchangeRate({
    required String baseSymbol,
    required String quoteSymbol,
  }) async {
    final String symbol = 'SPOT_${baseSymbol}_$quoteSymbol';
    final http.Response response = await _getKline(symbol);
    if (response.statusCode == 200) {
      // return lastest close price
      return Kline.fromJson(jsonDecode(response.body)).rows.first.close;
    } else {
      final String symbol = 'SPOT_${quoteSymbol}_$baseSymbol';
      final http.Response response = await _getKline(symbol);
      if (response.statusCode == 200) {
        // return lastest invert close price
        return 1 / Kline.fromJson(jsonDecode(response.body)).rows.first.close;
      }
    }
    throw Exception("can't get exchange rate");
  }

  Future<CurrentHolding> getHolding() async {
    return await http
        .get(Uri.parse('$basePath/v1/client/holding'), headers: headers())
        .then((value) {
      return CurrentHolding.fromJson(
        jsonDecode(value.body),
      );
    }).catchError((e) {
      throw e;
    });
  }

  Future<AvailableTokenResponse> getAvailableTokens() async {
    return await http
        .get(Uri.parse('$basePath/v1/public/token'), headers: headers())
        .then((value) {
      return AvailableTokenResponse.fromJson(
        jsonDecode(value.body),
      );
    }).catchError((e) {
      throw e;
    });
  }

  String normalizeRequest({
    Map<String, String>? query,
    Map<String, String>? body,
  }) {
    final map = {...query ?? {}, ...body ?? {}};
    String normalize = '';
    Map.fromEntries(
      map.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)),
    ).forEach((key, value) {
      normalize += '$key=$value&';
    });
    // remove trailing &
    normalize = normalize.isNotEmpty
        ? normalize.substring(0, normalize.length - 1)
        : normalize;
    return '$normalize|$currentTimestamp';
  }

  Map<String, String> headers({
    Map<String, String>? query,
    Map<String, String>? body,
  }) {
    return {
      'x-api-signature':
          signature(apiSecret, normalizeRequest(query: query, body: body)),
      'x-api-timestamp': currentTimestamp,
      'x-api-key': apiKey,
    };
  }

  String signature(String secretKey, String request) {
    List<int> secret = utf8.encode(secretKey);
    var bytes = utf8.encode(request);
    final hmacSha256 = Hmac(sha256, secret);
    return hmacSha256.convert(bytes).toString();
  }
}
