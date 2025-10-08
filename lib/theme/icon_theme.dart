import 'package:tsb_mini/package_mode.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppIcons {
  // Heroicons and SVG icons
  static const home = HeroIcons.home;
  static const list = HeroIcons.queueList;
  static const qrCode = HeroIcons.qrCode;
  static const gift = HeroIcons.gift;
  static const user = HeroIcons.userCircle;
  static const backButton = HeroIcons.chevronLeft;
  static const filter = HeroIcons.funnel;
  static const transfer = FontAwesomeIcons.arrowRightArrowLeft;
  static const reward = HeroIcons.giftTop;
  static const search = HeroIcons.magnifyingGlass;
  static const bus = FontAwesomeIcons.bus;

  static const String busSvgPath = "assets/icon/bus.svg";
  static const String transferSvgPath = "assets/icon/transfer.svg";
  static const String rewardSvgPath = "assets/icon/reward.svg";
  static const String heartSvgPath = "assets/icon/heart.svg";
  static const String filterSvgPath = "assets/icon/filter.svg";
  static const String homeSvgPath = "assets/icon/home.svg";
  static const String exitSvgPath = "assets/icon/exit.svg";
  static const String logPngPath = "assets/icon/log.png";
  static const String transitionSvgPath = "assets/icon/transiton.svg";
  static const String exchangeSvgPath = "assets/icon/exchange.svg";
  static const String impactSvgPath = "assets/icon/impact.svg";
  static const String houseSvgPath = "assets/icon/house.svg";
  static const String scanSvgPath = "assets/icon/scan.svg";
  static const String scanPngPath = "assets/icon/scan.png";
  static const String tierIconPath = "assets/icon/tier.png";
  static const String favouriteIconPath = "assets/icon/favourite.png";
  static const String rewardIconPath = "assets/reward/reward.png";

  static const String brownIconPath = "assets/tier/brown.png";
  static const String silverdIconPath = "assets/tier/silver.png";
  static const String goldIconPath = "assets/tier/gold.png";
  static const String diamondIconPath = "assets/tier/diamond.png";

  static const String scanMerchantPngPath = "asstes/icon/scan_merchant.png";
  static const String flashLightPngPath = "assets/icon/flash_light.png";

  static const String ticketPngPath = "assets/icon/ticket.png";

  static const String allPngPath = "assets/icon/all_icon.png";
  static const String drinkPngPath = "assets/icon/drink_icon.png";
  static const String foodPngPath = "assets/icon/food_icon.png";
  static const String shoppingPngPath = "assets/icon/shopping_icon.png";
  static const String fashionPngPath = "assets/icon/fashion_icon.png";

  // Optional: Helper method to create a HeroIcon widget with size/color
  // *********Normal using HeroIcon and FontAwesomeIcon*********
  //home
  static Widget homeIcon({Color? color, double size = 24}) {
    return HeroIcon(home, color: color, size: size);
  }

  //list
  static Widget listIcon({Color? color, double size = 24}) {
    return HeroIcon(list, color: color, size: size);
  }

  //qrcode
  static Widget qrCodeIcon({Color? color, double size = 24}) {
    return HeroIcon(qrCode, color: color, size: size);
  }

  //gift
  static Widget giftIcon({Color? color, double size = 24}) {
    return HeroIcon(gift, color: color, size: size);
  }

  //user
  static Widget userIcon({Color? color, double size = 24}) {
    return HeroIcon(user, color: color, size: size);
  }

  //backbutton
  static Widget backButtonIcon({Color? color, double size = 24}) {
    return HeroIcon(backButton, color: color, size: size);
  }

  //filterIcon
  static Widget filterIcon({Color? color, double size = 24}) {
    return HeroIcon(filter, color: color, size: size);
  }

  //transferIcon
  static Widget transferIcon({Color? color, double size = 24}) {
    return FaIcon(transfer, color: color, size: size);
  }

  //rewardIcon
  static Widget rewardIcon({Color? color, double size = 24}) {
    return HeroIcon(reward, color: color, size: size);
  }

  //serachIcon
  static Widget searchIcon({Color? color, double size = 24}) {
    return HeroIcon(search, color: color, size: size);
  }

  //Bus Icon
  static Widget busIcon({Color? color, double size = 24}) {
    return FaIcon(bus, color: color, size: size);
  }

  // *********SVG icons: Application of All SVG icon*************
  //HeartImgIcon
  static Widget heartSvgIcon({double size = 24, Color? color}) {
    return PackageAssets.svg(
      heartSvgPath,
      width: size,
      height: size,
      // colorFilter: color != null
      //     ? ColorFilter.mode(color, BlendMode.srcIn)
      //     : null,
      color: color,
    );
  }

  //ScanImgIcon
  static Widget scanPngIcon({double size = 24}) {
    return PackageAssets.image(scanPngPath, width: size, height: size);
  }

  //BusSvg Icon
  static Widget busSvgIcon({double size = 28, Color? color}) {
    return PackageAssets.svg(
      busSvgPath,
      width: size,
      height: size,
      color: color,
    );
  }

  //TransferSvgIcon
  static Widget transferSvgIcon({double size = 28, Color? color}) {
    return PackageAssets.svg(
      transferSvgPath,
      width: size,
      height: size,
      color: color,
    );
  }

  //RewardSvgIcon
  static Widget rewardSvgIcon({double size = 28, Color? color}) {
    return PackageAssets.svg(
      rewardSvgPath,
      width: size,
      height: size,
      color: color,
    );
  }

  //FilterSvgIcon
  static Widget filterSvgIcon({double size = 18, Color? color}) {
    return PackageAssets.svg(
      filterSvgPath,
      width: size,
      height: size,
      color: color,
    );
  }

  //homeSvgIcon
  static Widget homeSvgIcon({double size = 24, Color? color}) {
    return PackageAssets.svg(
      homeSvgPath,
      width: size,
      height: size,
      color: color,
    );
  }

  //logSvgIcon
  static Widget logSvgIcon({double size = 24, Color? color}) {
    return PackageAssets.image(
      logPngPath,
      width: size,
      height: size,
      color: color,
    );
  }

  //transtionIcon
  static Widget transitionSvgIcon({double size = 28, Color? color}) {
    return PackageAssets.svg(
      transitionSvgPath,
      width: size,
      height: size,
      color: color,
    );
  }

  //ExchangeIcon
  static Widget exchangeSvgIcon({double size = 28, Color? color}) {
    return PackageAssets.svg(
      exchangeSvgPath,
      width: size,
      height: size,
      color: color,
    );
  }

  //TierSvg Icon
  static Widget tierPngIcon({double size = 22, Color? color}) {
    return PackageAssets.image(
      tierIconPath,
      width: size,
      height: size,
      color: color,
    );
  }

  //TierSvg Icon
  static Widget ticketPngIcon({double size = 20, Color? color}) {
    return PackageAssets.image(
      ticketPngPath,
      width: size,
      height: size,
      color: color,
    );
  }

  static Widget allPngIcon({double size = 28, Color? color}) {
    return PackageAssets.image(
      allPngPath,
      width: size,
      height: size,
      color: color,
    );
  }

  static Widget drinkPngIcon({double size = 28, Color? color}) {
    return PackageAssets.image(
      drinkPngPath,
      width: size,
      height: size,
      color: color,
    );
  }

  static Widget foodPngIcon({double size = 28, Color? color}) {
    return PackageAssets.image(
      foodPngPath,
      width: size,
      height: size,
      color: color,
    );
  }

  static Widget shoppingPngIcon({double size = 28, Color? color}) {
    return PackageAssets.image(
      shoppingPngPath,
      width: size,
      height: size,
      color: color,
    );
  }

  static Widget fashionPngIcon({double size = 28, Color? color}) {
    return PackageAssets.image(
      fashionPngPath,
      width: size,
      height: size,
      color: color,
    );
  }
}
