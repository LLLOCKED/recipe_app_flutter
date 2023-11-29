import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_app/screens/favorite_screen.dart';
import 'package:recipe_app/screens/scaner_screen.dart';
import 'package:recipe_app/widgets/app_icon.dart';
import 'package:recipe_app/widgets/large_text.dart';

import 'package:recipe_app/widgets/search_panel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFinished = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/cook-face-svgrepo-com.svg',
                        height: 40.0,
                        width: 40.0,
                      ),
                      const LargeText(
                        text: "Scan-n-Cook",
                        color: Colors.black87,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      AppIcon(
                          icon: Icons.favorite,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FavoriteScreen()),
                            );
                          }),
                      // SizedBox(
                      //   width: 10.w,
                      // ),
                      // AppIcon(icon: Icons.person, onPressed: () {}),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20).r,
              child: Container(
                  height: 180.h,
                  width: 1.sw,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://i.pinimg.com/564x/53/67/fc/5367fc8d1aa4c53bc412c397c501d73b.jpg"),
                        fit: BoxFit.cover),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(40)),
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
                            const Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
                          ],
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(20).r,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Get your Recipes Easier with AR Food Scaner",
                              style: Theme.of(context).textTheme.displaySmall,
                              maxLines: 3,
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ScanerScreen()),
                                    );
                                  },
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0.r),
                                      )),
                                      padding:
                                          MaterialStatePropertyAll<EdgeInsets>(
                                              const EdgeInsets.all(13).r),
                                      backgroundColor:
                                          const MaterialStatePropertyAll<Color>(
                                              Colors.yellow)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.qr_code_scanner_sharp,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: 10.r,
                                      ),
                                      const Text("Scan now",
                                          style: TextStyle(
                                            color: (Colors.black),
                                          )),
                                    ],
                                  )))
                        ],
                      ),
                    ),
                  ) // Foreground widget here
                  ),
            ),
            const Expanded(child: SizedBox()),
            const SearchPanel()
          ],
        )));
  }
}
