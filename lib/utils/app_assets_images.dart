class AppAssetsImages {
  factory AppAssetsImages() {
    return _singleton;
  }

  AppAssetsImages._internal();

  static final AppAssetsImages _singleton = AppAssetsImages._internal();

  final String appIcon = "assets/images/app_icon.png";
  final String appIconAdmin = "assets/images/app_icon_admin.png";
  final String appIconCustomer = "assets/images/app_icon_customer.png";
  final String appIconVendor = "assets/images/app_icon_vendor.png";
  final String splash = "assets/images/splash.png";
  final String flag = "assets/images/flag.jpg";

  final String bottomNavHome = "assets/images/bottom_nav_home.png";
  final String bottomNavPortfolio = "assets/images/bottom_nav_portfolio.png";
  final String bottomNavCategory = "assets/images/bottom_nav_category.png";
  final String bottomNavHelp = "assets/images/bottom_nav_help.png";
  final String bottomNavShopping = "assets/images/bottom_nav_shopping.png";
  final String bottomNavOrderHistory = "assets/images/bottom_nav_history.png";
  final String bottomNavTruck = "assets/images/bottom_nav_truck.png";
  final String bottomNavDrone = "assets/images/bottom_nav_drone.png";
  final String bottomNavJCB = "assets/images/bottom_nav_jcb.png";

  final String userPlaceholder = "assets/images/default_avatar.png";
  final String imagePlaceholder = "assets/images/image_placeholder.png";
  final String videoPlaceholder = "assets/images/video.png";
}
