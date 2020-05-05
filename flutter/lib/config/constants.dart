import 'package:flutter/material.dart';

const defaultPricePrecision = 4;

const defaultScreenRefreshIntervalSeconds = 0.25;

const defaultInstrumentId = 'BTCUSD';

class NotificationLanguage {
  static const String english = 'english';
  static const String simplifiedChinese = 'simplifiedChinese';
}

class ConditionalType {
  static const String market = 'market';
  static const String limit = 'limit';
}

class ChartTimeIntervalsValues {
  static const String oneMin = '1';
  static const String threeMin = '3';
  static const String fiveMin = '5';
  static const String fifteenMin = '15';
  static const String thirtyMin = '30';
  static const String oneHour = '60';
  static const String fourHours = '240';
  static const String sixHours = '360';
  static const String twelveHours = '720';
  static const String oneDay = '1D';
  static const String oneWeek = '1W';
  static const String oneMonth = '1M';
}

const resendCodeDelay = 60;

class RiskManagerInitials {
  static const takeProfitRoe = 0.05;
  static const stopLossRoe = 0.10;
  static const riskPercent = 0.0025;
}

class FeeRate {
  static const maker = -0.00025;
  static const taker = 0.00075;
}

enum ValueType { quantity, percent, btc, usd }

const depthValues = [0.5, 1.0, 5.0, 10.0];

const leveragesMap = {
  '100.0': [0.0, 1.0, 2.0, 3.0, 5.0, 10.0, 25.0, 50.0, 100.0],
  '66.6': [0.0, 1.0, 2.0, 3.0, 5.0, 10.0, 25.0, 50.0, 66.6],
  '50.0': [0.0, 1.0, 2.0, 3.0, 5.0, 10.0, 25.0, 35.0, 50.0],
  '40.0': [0.0, 1.0, 2.0, 3.0, 5.0, 10.0, 25.0, 33.3, 40.0],
  '33.3': [0.0, 1.0, 2.0, 3.0, 5.0, 10.0, 25.0, 33.3],
  '28.5': [0.0, 1.0, 2.0, 3.0, 5.0, 10.0, 15.0, 20.0, 25.0, 28.5],
  '25.0': [0.0, 1.0, 2.0, 3.0, 5.0, 10.0, 15.0, 20.0, 25.0],
  '22.2': [0.0, 1.0, 2.0, 3.0, 5.0, 10.0, 15.0, 20.0, 22.2],
  '20.0': [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 10.0, 15.0, 20.0],
  '18.1': [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 10.0, 15.0, 18.1],
};

const defaultLeverages = [0.0, 1.0, 2.0, 3.0, 5.0, 10.0, 25.0, 50.0, 100.0];

class ReCaptchaData {
  static const apiKeyExample = '6Lc4A8cUAAAAAGJes5JBGLceFNdjT-_HWggw0uKE';
  static const apiKeyDevelopment = '6LeIxAcTAAAAAJcZVRqyHh71UMIEGNQ_MXjiZKhI';
  static const apiKeyTestnet = '6LdL-aUUAAAAAJp7pRKWFpg6p6y4BFLZHw3A-jcU';
  static const apiKeyMainnet = '6LegWLAUAAAAACuu37Ec5wioduzcmjqxPMvHkmwD';
  static const apiSecret = '6Lc4A8cUAAAAAKwKCqYzE3y4Vj8KoMqvW82k3gYd';
}

class Language {
  static const String en = 'en';
  static const String zh = 'zh';
}

class Currency {
  static const String usd = 'usd';
  static const String cny = 'cny';
}

class AppImages {
  static const images = 'assets/images';

  static const sunrise1 = '$images/sunrise_1.png';
  static const sunrise2 = '$images/sunrise_2.png';
  static const logo = '$images/logo.svg';
  static const iconAt = '$images/ic_at.svg';
  static const iconPhone = '$images/ic_phone.svg';
  static const iconGoogleAuth = '$images/ic_google_auth.svg';
  static const iconAssets = '$images/ic_assets.svg';
  static const iconHome = '$images/ic_home.svg';
  static const iconMarkets = '$images/ic_markets.svg';
  static const iconTrade = '$images/ic_trade.svg';
  static const iconAccount = '$images/ic_account.svg';
  static const iconSuitcase = '$images/ic_suitcase.svg';
  static const iconHistory = '$images/ic_history.svg';
  static const iconGraph = '$images/ic_graph.svg';
  static const iconBtc = '$images/ic_btc.svg';
  static const iconEth = '$images/ic_eth.svg';
  static const iconXrp = '$images/ic_xrp.svg';
  static const iconBtcPng = '$images/ic_btc.png';
  static const iconEthPng = '$images/ic_eth.png';
  static const iconXrpPng = '$images/ic_xrp.png';
  static const iconUsdtPng = '$images/ic_usdt.png';
  static const iconHelp = '$images/ic_help.svg';
  static const iconInfo = '$images/ic_info.svg';
  static const iconSecurity = '$images/ic_security.svg';
  static const iconSettings = '$images/ic_settings.svg';
  static const iconSuspension = '$images/ic_suspension.svg';
  static const iconLock = '$images/ic_lock.svg';
  static const iconEmail = '$images/ic_email.svg';
  static const iconGesturePassword = '$images/ic_gesture.svg';
  static const iconFingerprintPassword = '$images/ic_fingerprint.svg';
  static const iconLogout = '$images/ic_logout.svg';
  static const badgeGooglePlay = '$images/badge_google_play.svg';
  static const badgeAppStore = '$images/badge_app_store.svg';
  static const qrCode = '$images/image_qr_code.svg';
  static const qrCodeSimple = '$images/image_qr_code_simple.svg';
  static const iconBalance = '$images/ic_balance_history.svg';
  static const iconDeposit = '$images/ic_deposit.svg';
  static const iconWithdraw = '$images/ic_withdraw.svg';
  static const iconRight = '$images/ic_right.svg';
  static const iconTrophy = '$images/ic_trophy.svg';
  static const iconNavbarAccount = '$images/ic_navbar_account.svg';
  static const iconNavbarAccountOn = '$images/ic_navbar_account_on.svg';
  static const iconNavbarAssets = '$images/ic_navbar_assets.svg';
  static const iconNavbarAssetsOn = '$images/ic_navbar_assets_on.svg';
  static const iconNavbarMarkets = '$images/ic_navbar_markets.svg';
  static const iconNavbarMarketsOn = '$images/ic_navbar_markets_on.svg';
  static const iconNavbarTrade = '$images/ic_navbar_trade.svg';
  static const iconNavbarTradeOn = '$images/ic_navbar_trade_on.svg';
  static const iconNavbarHome = '$images/ic_navbar_home.svg';
  static const iconNavbarHomeOn = '$images/ic_navbar_home_on.svg';
  static const iconCircleCheckMark = '$images/ic_circle_check_mark.svg';
  static const iconCircleCheckMarkBlue =
      '$images/ic_circle_check_mark_blue.svg';
  static const iconShare = '$images/ic_share.svg';
  static const iconChat = '$images/ic_chat.svg';
  static const iconHeadphone = '$images/ic_headphone.svg';
  static const iconQuestion = '$images/ic_question.svg';
  static const iconBook = '$images/ic_book.svg';
  static const iconNewsSignal = '$images/ic_news_signal.svg';
  static const iconVolume = '$images/ic_volume.svg';
  static const iconSheet = '$images/ic_sheet.svg';
  static const iconCandles = '$images/ic_candles.svg';
  static const iconFullscreen = '$images/ic_fullscreen.svg';
  static const iconFullscreenOff = '$images/ic_fullscreen_off.svg';
  static const iconMarketDepth = '$images/ic_market_depth.svg';
  static const iconFlag = '$images/ic_flag.svg';
  static const sharePositive = '$images/share_positive.svg';
  static const shareNegative = '$images/share_negative.svg';
  static const arrowUp = '$images/ic_arrow_up.svg';
  static const arrowDown = '$images/ic_arrow_down.svg';
  static const splashBackground = '$images/splash_background.png';
  static const glowDivider = '$images/glow_divider.png';
  static const space1 = '$images/space_1.jpg';
  static const space2 = '$images/space_2.jpg';
  static const space3 = '$images/space_3.jpg';
  static const space4 = '$images/space_4.png';
  static const space5 = '$images/space_5.jpg';
  static const space6 = '$images/space_6.jpg';
  static const space7 = '$images/space_7.png';
}

class AppColors {
  //font
  static const fontMain = Colors.black;
  static const fontButton = Colors.black;
  static const fontError = Color(0xFFFF5D52);

  //
  static const background = Color(0xFF121128);
  static const backgroundLight = Color(0xFF1E1D33);
  static const backgroundLight5 = Color(0xFF1a193a);
  static const backgroundLight10 = Color(0xFF22204c);
  static const backgroundLight20 = Color(0xFF322f70);
  static const backgroundWithWhiteFiveOverlay = Color(0xFF1F1D34);
  static const backgroundWithTwoOverlay = Color(0xFF17162C);
  static const backgroundDialog = Color(0xFF212430);
  static const blue = Color(0xFF007AFF);
  static const blueOpacity80 = Color(0xcc007AFF);
  static const red = Color(0xFFFF5D52);
  static const redOpacity54 = Color(0x8aFF5D52);
  static const redOpacity50 = Color(0xbbFF5D52); // incorrect?
  static const redOpacity80 = Color(0xccFF5D52);
  static const green = Color(0xFF27AE60);
  static const greenOpacity80 = Color(0xcc27AE60);
  static const greenLight = Color(0xFF00B865);
  static const greenLightOpacity54 = Color(0x8a00B865);
  static const greenLightOpacity50 = Color(0xbb00B865); // incorrect?
  static const greyLightMiddle = const Color(0xffbbbbbb);
  static const greyLight = const Color(0xffdddddd);
  static const greyLightVery = const Color(0xffeeeeee);

  static const blueTransparent = Color(0x77007AFF);

  /// Use [white2] or [white3] instead for app background colors
  @deprecated
  static const white5 = Color(0x0DFFFFFF);
  static const white3 = Color(0x08FFFFFF);
  static const white2 = Color(0x05FFFFFF);
  static const white4 = Color(0x0AFFFFFF);
}

class AppSize {
  static const fontMicro = 8.0;
  static const fontSmallVery = 10.0;
  static const fontSmall = 12.0;
  static const fontRegular = 14.0;
  static const fontNormal = 16.0;
  static const fontNormalBig = 18.0;
  static const fontMedium = 20.0;
  static const fontBig = 24.0;
  static const fontBigExtra = 30.0;
  static const fontHuge = 36.0;

  static const paddingMicro = 4.0;
  static const paddingSmall = 8.0;
  static const paddingMedium = 12.0;
  static const paddingNormal = 16.0;
  static const paddingBig = 24.0;
  static const paddingBigExtra = 30.0;
  static const paddingHuge = 36.0;

  static const buttonHeight = 40.0;
  static const buttonHeightSmall = 32.0;
  static const buttonWidth = 180.0;
}

class Vertical extends Padding {
  const Vertical.micro() : super(padding: AppPadding.topMicro);

  const Vertical.small() : super(padding: AppPadding.topSmall);

  const Vertical.medium() : super(padding: AppPadding.topMedium);

  const Vertical.normal() : super(padding: AppPadding.topNormal);

  const Vertical.big() : super(padding: AppPadding.topBig);

  const Vertical.huge() : super(padding: AppPadding.topHuge);
}

class Horizontal extends Padding {
  const Horizontal.micro() : super(padding: AppPadding.rightMicro);

  const Horizontal.small() : super(padding: AppPadding.rightSmall);

  const Horizontal.medium() : super(padding: AppPadding.rightMedium);

  const Horizontal.normal() : super(padding: AppPadding.rightNormal);

  const Horizontal.big() : super(padding: AppPadding.rightBig);

  const Horizontal.huge() : super(padding: AppPadding.rightHuge);
}

class AppPadding extends EdgeInsets {
  ///
  static const _micro = AppSize.paddingMicro;
  static const _small = AppSize.paddingSmall;
  static const _normal = AppSize.paddingNormal;
  static const _medium = AppSize.paddingMedium;
  static const _big = AppSize.paddingBig;
  static const _huge = AppSize.paddingHuge;

  // all
  static const allZero = const EdgeInsets.all(0.0);
  static const allMicro = const EdgeInsets.all(_micro);
  static const allSmall = const EdgeInsets.all(_small);
  static const allMedium = const EdgeInsets.all(_medium);
  static const allNormal = const EdgeInsets.all(_normal);
  static const allBig = const EdgeInsets.all(_big);
  static const allHuge = const EdgeInsets.all(_huge);

  // bottom
  static const bottomMicro = const EdgeInsets.only(bottom: _micro);
  static const bottomSmall = const EdgeInsets.only(bottom: _small);
  static const bottomNormal = const EdgeInsets.only(bottom: _normal);
  static const bottomMedium = const EdgeInsets.only(bottom: _medium);
  static const bottomBig = const EdgeInsets.only(bottom: _big);
  static const bottomHuge = const EdgeInsets.only(bottom: _huge);

  // bottom left
  static const bottomLeftNormal =
      const EdgeInsets.only(bottom: _normal, left: _normal);

  // bottom right
  static const bottomRightBig =
      const EdgeInsets.only(bottom: _big, right: _big);
  static const bottomRightNormal = const EdgeInsets.only(
    bottom: _normal,
    right: _normal,
  );

  // left
  static const leftMicro = const EdgeInsets.only(left: _micro);
  static const leftSmall = const EdgeInsets.only(left: _small);
  static const leftNormal = const EdgeInsets.only(left: _normal);
  static const leftMedium = const EdgeInsets.only(left: _medium);
  static const leftBig = const EdgeInsets.only(left: _big);
  static const leftHuge = const EdgeInsets.only(left: _huge);

  // top
  static const topMicro = const EdgeInsets.only(top: _micro);
  static const topSmall = const EdgeInsets.only(top: _small);
  static const topMedium = const EdgeInsets.only(top: _medium);
  static const topNormal = const EdgeInsets.only(top: _normal);
  static const topBig = const EdgeInsets.only(top: _big);
  static const topHuge = const EdgeInsets.only(top: _huge);

  // right
  static const rightMicro = const EdgeInsets.only(right: _micro);
  static const rightSmall = const EdgeInsets.only(right: _small);
  static const rightMedium = const EdgeInsets.only(right: _medium);
  static const rightNormal = const EdgeInsets.only(right: _normal);
  static const rightBig = const EdgeInsets.only(right: _big);
  static const rightHuge = const EdgeInsets.only(right: _huge);

  // horizontal
  static const horizontalMicro = const EdgeInsets.symmetric(horizontal: _micro);
  static const horizontalSmall = const EdgeInsets.symmetric(horizontal: _small);
  static const horizontalMedium =
      const EdgeInsets.symmetric(horizontal: _medium);
  static const horizontalNormal =
      const EdgeInsets.symmetric(horizontal: _normal);
  static const horizontalBig = const EdgeInsets.symmetric(horizontal: _big);
  static const horizontalHuge = const EdgeInsets.symmetric(horizontal: _huge);

  // vertical
  static const verticalMicro = const EdgeInsets.symmetric(vertical: _micro);
  static const verticalSmall = const EdgeInsets.symmetric(vertical: _small);
  static const verticalMedium = const EdgeInsets.symmetric(vertical: _medium);
  static const verticalNormal = const EdgeInsets.symmetric(vertical: _normal);
  static const verticalBig = const EdgeInsets.symmetric(vertical: _big);
  static const verticalHuge = const EdgeInsets.symmetric(vertical: _huge);

  // except
  static const exceptRightBig = const AppPadding.exceptRight(_big);
  static const exceptRightNormal = const AppPadding.exceptRight(_normal);
  static const exceptRightSmall = const AppPadding.exceptRight(_small);

  static const exceptBottomNormal = const AppPadding.exceptBottom(_normal);
  static const exceptBottomMedium = const AppPadding.exceptBottom(_medium);
  static const exceptBottomBig = const AppPadding.exceptBottom(_big);
  static const exceptBottomHuge = const AppPadding.exceptBottom(_huge);

  static const exceptTopNormal = const AppPadding.exceptTop(_normal);
  static const exceptTopMedium = const AppPadding.exceptTop(_medium);
  static const exceptTopSmall = const AppPadding.exceptTop(_small);
  static const exceptTopBig = const AppPadding.exceptTop(_big);

  ///
  const AppPadding.bottom(double value) : super.only(bottom: value);

  const AppPadding.top(double value) : super.only(top: value);

  const AppPadding.right(double value) : super.only(right: value);

  const AppPadding.left(double value) : super.only(left: value);

  const AppPadding.all(double value) : super.all(value);

  const AppPadding.horizontal(double value)
      : super.symmetric(horizontal: value);

  const AppPadding.vertical(double value) : super.symmetric(vertical: value);

  const AppPadding.exceptRight(double value)
      : super.fromLTRB(value, value, 0.0, value);

  const AppPadding.exceptTop(double value)
      : super.fromLTRB(value, 0.0, value, value);

  const AppPadding.exceptBottom(double value)
      : super.fromLTRB(value, value, value, 0.0);
}
