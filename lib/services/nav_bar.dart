import "package:customer/screens/booking_slot/book_slot.dart";
import "package:customer/screens/booking_slot/selected_slot.dart";
import "package:customer/screens/home_screen/home_screen.dart";
import "package:customer/screens/order/product_live_order.dart";
import "package:customer/utils/app_assets_images.dart";
import "package:flutter/material.dart";
import "package:get/get_state_manager/src/rx_flutter/rx_disposable.dart";
import "package:persistent_bottom_nav_bar/persistent_tab_view.dart";

class ProvidedStylesExample extends GetxService {
  late PersistentTabController _controller;
  late bool _hideNavBar;

  void initState() {
    _controller = PersistentTabController();
    _hideNavBar = false;
  }

  List<Widget> _buildScreens() => <Widget>[
        const HomeScreen(),
        Container(),
        BookSlot(),
        const SelectedSlot(),
    const ProductLivePendingOrder(),
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() =>
      <PersistentBottomNavBarItem>[
        PersistentBottomNavBarItem(
          icon: Image.asset(AppAssetsImages.Home),
          title: "Home",
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: Image.asset(AppAssetsImages.primary),
          title: "Search",
          activeColorPrimary: Colors.teal,
          inactiveColorPrimary: Colors.grey,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
            initialRoute: "/",
            routes: <String, WidgetBuilder>{
              "/first": (final BuildContext context) => Container(),
              "/second": (final BuildContext context) => Container(),
            },
          ),
        ),
        PersistentBottomNavBarItem(
          icon: Image.asset(AppAssetsImages.tractor_1),
          title: "Add",
          activeColorPrimary: Colors.blueAccent,
          inactiveColorPrimary: Colors.grey,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
            initialRoute: "/",
            routes: <String, WidgetBuilder>{
              "/first": (final BuildContext context) => Container(),
              "/second": (final BuildContext context) => Container(),
            },
          ),
        ),
        PersistentBottomNavBarItem(
          icon: Image.asset(AppAssetsImages.whatsapp),
          title: "Messages",
          activeColorPrimary: Colors.deepOrange,
          inactiveColorPrimary: Colors.grey,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
            initialRoute: "/",
            routes: <String, WidgetBuilder>{
              "/first": (final BuildContext context) => Container(),
              "/second": (final BuildContext context) => Container(),
            },
          ),
        ),
        PersistentBottomNavBarItem(
          icon: Image.asset(AppAssetsImages.bag),
          title: "Settings",
          activeColorPrimary: Colors.indigo,
          inactiveColorPrimary: Colors.grey,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
            initialRoute: "/",
            routes: <String, WidgetBuilder>{
              "/first": (final BuildContext context) => Container(),
              "/second": (final BuildContext context) => Container(),
            },
          ),
        ),
      ];

  Widget build(final BuildContext context) => Scaffold(
        body: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          resizeToAvoidBottomInset: true,
          navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
              ? 0.0
              : kBottomNavigationBarHeight,
          bottomScreenMargin: 0,
          backgroundColor: Colors.grey.shade300,
          hideNavigationBar: _hideNavBar,
          decoration: const NavBarDecoration(colorBehindNavBar: Colors.indigo),
          itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 400),
            curve: Curves.bounceOut,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
          ),
          navBarStyle: NavBarStyle
              .style19, // Choose the nav bar style with this property
        ),
      );
}

// ----------------------------------------- Custom Style ----------------------------------------- //

class CustomNavBarWidget extends StatelessWidget {
  const CustomNavBarWidget(
    this.items, {required this.selectedIndex,
        required this.onItemSelected, super.key,
  });

  final int selectedIndex;
  final List<PersistentBottomNavBarItem> items;
  final ValueChanged<int> onItemSelected;

  Widget _buildItem(
          final PersistentBottomNavBarItem item, final bool isSelected,) =>
      Container(
        alignment: Alignment.center,
        height: kBottomNavigationBarHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: IconTheme(
                data: IconThemeData(
                    size: 26,
                    color: isSelected
                        ? (item.activeColorSecondary ?? item.activeColorPrimary)
                        : item.inactiveColorPrimary ??
                        item.activeColorPrimary,),
                child: isSelected ? item.icon : item.inactiveIcon ?? item.icon,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Material(
                type: MaterialType.transparency,
                child: FittedBox(
                    child: Text(
                  "Item",
                  style: TextStyle(
                      color: isSelected
                          ? (item.activeColorSecondary ??
                              item.activeColorPrimary)
                          : item.inactiveColorPrimary,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,),
                ),),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(final BuildContext context) => Container(
        color: Colors.white,
        child: SizedBox(
          width: double.infinity,
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.map((final PersistentBottomNavBarItem item) {
              final int index = items.indexOf(item);
              return Flexible(
                child: GestureDetector(
                  onTap: () {
                    onItemSelected(index);
                  },
                  child: _buildItem(item, selectedIndex == index),
                ),
              );
            }).toList(),
          ),
        ),
      );
}
