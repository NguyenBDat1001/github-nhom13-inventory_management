import 'package:InventorPlus/screens/landing_page.dart';
import 'package:InventorPlus/services/global_metthods.dart';
import 'package:flutter/material.dart';

import 'package:InventorPlus/ui/bottom_bar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final controller = PageController();
  bool isLastPage = false;
  Future IntroPage() async {
    WidgetsFlutterBinding.ensureInitialized();
    final prefs = await SharedPreferences.getInstance();
    final showHome = prefs.getBool("showHome") ?? false;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget buildPage(
          {required Color color,
          required String urlImage,
          required String title,
          required String subtitle,
          required String sub}) =>
      Container(
          color: color,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                urlImage,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              const SizedBox(height: 50),
              Text(
                title,
                style: TextStyle(
                    color: Colors.amber.shade700,
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text.rich(
                  TextSpan(
                      text: subtitle,
                      style: TextStyle(
                          color: Colors.amber.shade700,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: sub,
                            style: const TextStyle(
                                color: Colors.black38, fontSize: 16))
                      ]),
                ),
              )
            ],
          ));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 58),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() => isLastPage = index == 2);
          },
          children: [
            buildPage(
                color: Colors.cyan.shade100,
                urlImage: "assets/images/warehouse-management-system.jpg",
                title: "TỐi ƯU HÓA HOẠT ĐỘNG LƯU TRỮ",
                subtitle: "InventorPlus ",
                sub:
                    '- Quản lý hàng hóa một cách dễ dàng. Theo dõi và kiểm soát hàng tồn kho từ nhập hàng mới đến xuất hàng cho khách hàng. Tận dụng tính năng xem tồn kho thời gian thực để nâng cao hiệu quả quản lý kho của bạn.'),
            buildPage(
                color: Colors.blue.shade100,
                urlImage:
                    "assets/images/warehouse-workers-are-storing-boxes-on-the-rack-vector-21061993.jpg",
                title: "THEO DÕI VÀ KIỂM SOÁT HÀNG HÓA",
                subtitle: "InventorPlus ",
                sub:
                    '- Theo dõi, quản lý và tìm kiếm hàng hóa trong kho một cách dễ dàng. Số lượng hàng, quản lý lô hàng và vị trí lưu trữ được theo dõi, cập nhật và kiểm tra tình trạng và vị trí hàng hóa trong kho của bạn một cách thuận tiện và hiệu quả.'),
            buildPage(
                color: Colors.yellow.shade100,
                urlImage: "assets/images/maxresdefault.jpg",
                title: "TĂNG CƯỜNG ĐỘ CHÍNH XÁC VÀ\nTIẾT KIỆM THỜI GIAN",
                subtitle: "InventorPlus ",
                sub:
                    '- Tối ưu hóa quản lý hàng hóa và tiết kiệm thời gian. Ghi chính xác các giao dịch nhập/xuất hàng qua mã vạch và theo dõi lịch sử kho để giảm thiểu sai sót và mất mát hàng hóa.'),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2)),
                  primary: Colors.white,
                  backgroundColor: Colors.amber.shade700,
                  minimumSize: const Size.fromHeight(58)),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool("showHome", true);
                GlobalMethods.navigateTo(
                    ctx: context, routeName: LandingPage.routeName);
              },
              child: const Text(
                "BẮT ĐẦU",
                style: TextStyle(fontSize: 20),
              ))
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              height: 58,
              decoration: BoxDecoration(
                  color: Colors.amber[700],
                  borderRadius: BorderRadius.circular(2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        primary: Colors.white,
                      ),
                      onPressed: () => controller.jumpToPage(2),
                      child: const Text(
                        "BỎ QUA",
                        style: TextStyle(fontSize: 17),
                      )),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: const WormEffect(
                          spacing: 15,
                          dotColor: Colors.black26,
                          activeDotColor: Colors.white),
                      onDotClicked: (index) => controller.animateToPage(index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn),
                    ),
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        primary: Colors.white,
                      ),
                      onPressed: () => controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut),
                      child: const Text("TIẾP TỤC",
                          style: TextStyle(fontSize: 17)))
                ],
              ),
            ),
    );
  }
}
