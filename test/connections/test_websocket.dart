import 'dart:async';

import 'package:foxbit_hiring_test_template/data/helpers/websocket.dart';

class TestFoxbitWebSocket extends FoxbitWebSocket {
  List<String> sendedMessages = [];

  final Map _responses = {
    // ignore: unnecessary_string_escapes
    'PING': '{"m": 0, "i": 0, "n": "Ping", "o": "{\\\"msg\\\":\\\"PONG\\\"}" }',
    // ignore: unnecessary_string_escapes
    'getInstruments':
        '{"m": 0, "i": 0, "n": "getInstruments", "o": "[{\\"OMSId\\":1,\\"InstrumentId\\":1,\\"Symbol\\":\\"BTC/BRL\\",\\"Product1\\":1,\\"Product1Symbol\\":\\"BTC\\",\\"Product2\\":2,\\"Product2Symbol\\":\\"BRL\\",\\"InstrumentType\\":\\"Standard\\",\\"VenueInstrumentId\\":1,\\"VenueId\\":1,\\"SortIndex\\":0,\\"SessionStatus\\":\\"Running\\",\\"PreviousSessionStatus\\":\\"Paused\\",\\"SessionStatusDateTime\\":\\"2020-07-11T01:27:02.851Z\\",\\"SelfTradePrevention\\":true,\\"QuantityIncrement\\":1e-8,\\"PriceIncrement\\":0.001,\\"MinimumQuantity\\":1e-8,\\"MinimumPrice\\":0.001,\\"VenueSymbol\\":\\"BTC/BRL\\",\\"IsDisable\\":false,\\"MasterDataId\\":0,\\"PriceCollarThreshold\\":0,\\"PriceCollarPercent\\":0,\\"PriceCollarEnabled\\":false,\\"PriceFloorLimit\\":0,\\"PriceFloorLimitEnabled\\":false,\\"PriceCeilingLimit\\":0,\\"PriceCeilingLimitEnabled\\":false,\\"CreateWithMarketRunning\\":true,\\"AllowOnlyMarketMakerCounterParty\\":false}]"}',
    // ignore: unnecessary_string_escapes
    'SubscribeLevel1':
        '{"m": 0, "i": 0, "n": "SubscribeLevel1", "o": "{\\\"OMSId\\\":1,\\\"InstrumentId\\\":1,\\\"BestBid\\\":10.1,\\\"BestOffer\\\":20,\\\"LastTradedPx\\\":20,\\\"LastTradedQty\\\":0.1,\\\"LastTradeTime\\\":1614613162,\\\"SessionOpen\\\":130,\\\"SessionHigh\\\":130,\\\"SessionLow\\\":10.1,\\\"SessionClose\\\":10.1,\\\"Volume\\\":0.1,\\\"CurrentDayVolume\\\":0.0005,\\\"CurrentDayNumTrades\\\":1,\\\"CurrentDayPxChange\\\":-119.9,\\\"Rolling24HrVolume\\\":0.0005,\\\"Rolling24NumTrades\\\":1,\\\"Rolling24HrPxChange\\\":-92.2308,\\\"TimeStamp\\\":1614623773}"}',
  };

  @override
  void send(String method, dynamic objectData) {
    prepareMessage(method, objectData);

    final response = _responses[method];
    if (response != null) {
      Timer(const Duration(milliseconds: 50), () {
        onMessage(response);
      });
    }
  }

  @override
  String prepareMessage(String method, dynamic objectData) {
    final String message = super.prepareMessage(method, objectData);
    sendedMessages.add(message);
    return message;
  }
}
