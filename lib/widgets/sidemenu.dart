import 'dart:developer';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:newJoyo/pages/monthly_page.dart';
import 'package:newJoyo/pages/pekerjaan_page.dart';
import 'package:newJoyo/pages/daftar_supplier.dart';
import 'package:newJoyo/pages/daftar_pelangan.dart';


import 'package:newJoyo/pages/riwayat_pembelian.dart';
import 'package:newJoyo/pages/stock_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';


final buttonColors = WindowButtonColors(
    iconNormal: const Color.fromARGB(255, 79, 117, 134),
    mouseOver: Colors.teal,
    mouseDown: const Color.fromARGB(255, 79, 117, 134),
    iconMouseOver: Colors.white,
    iconMouseDown: const Color(0xFFFFD500));

final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: const Color.fromARGB(255, 79, 117, 134),
    iconMouseOver: Colors.white);

class WindowButtons extends StatefulWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  _WindowButtonsState createState() => _WindowButtonsState();
}

class _WindowButtonsState extends State<WindowButtons> {
  void maximizeOrRestore() {
    setState(() {
      appWindow.maximizeOrRestore();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      color: Colors.grey.shade900,
      child: Row(
        children: [
          MinimizeWindowButton(colors: buttonColors),
          appWindow.isMaximized
              ? RestoreWindowButton(
                  colors: buttonColors,
                  onPressed: maximizeOrRestore,
                )
              : MaximizeWindowButton(
                  colors: buttonColors,
                  onPressed: maximizeOrRestore,
                ),
          CloseWindowButton(colors: closeButtonColors),
        ],
      ),
    );
  }
}

class Side extends StatefulWidget {
  const Side({
    Key? key,
  }) : super(key: key);

  @override
  _SideState createState() => _SideState();
}

bool mode = true;

class _SideState extends State<Side> {
  PageController page = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   onPressed: () {
      //     objectBox.deleteAllSupplier();

      //     objectBox.deleteAllStock();
      //   },
      // ),
      body: WindowBorder(
        color: const Color.fromARGB(255, 79, 117, 134),
        child: Column(
          children: [
            WindowTitleBarBox(
              child: Row(
                children: [
                  Container(
                      padding: const EdgeInsets.only(left: 15),
                      color: Colors.grey.shade900,
                      child: const Text(
                        'JOYOTOMO',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                            fontStyle: FontStyle.italic),
                      )),
                  Expanded(
                      child: MoveWindow(
                    child: Container(
                      color: Colors.grey.shade900,
                    ),
                  )),
                  const WindowButtons()
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SideMenu(
                    controller: page, showToggle: true,
                    // onDisplayModeChanged: (mode) {
                    //   print(mode);
                    // },
                    style: SideMenuStyle(
                      openSideMenuWidth: 200,
                      toggleColor: Colors.white,
                      displayMode: mode
                          ? SideMenuDisplayMode.open
                          : SideMenuDisplayMode.compact,
                      hoverColor: const Color.fromARGB(255, 128, 129, 131),
                      selectedColor: Colors.grey.shade700,
                      selectedTitleTextStyle:
                          const TextStyle(color: Colors.white),
                      selectedIconColor: Colors.white,
                      unselectedIconColor: Colors.white70,
                      unselectedTitleTextStyle:
                          const TextStyle(color: Colors.white70),

                      backgroundColor: const Color.fromARGB(255, 79, 117, 134),
                      // openSideMenuWidth: 200
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 100,
                            maxWidth: 150,
                          ),
                          child: Image.asset(
                            'images/logo2.png',
                          ),
                        ),
                        const Divider(
                          indent: 8.0,
                          endIndent: 8.0,
                        ),
                      ],
                    ),
                    footer: const Text(
                      '@JOYOTOMO',
                      style: TextStyle(fontSize: 15),
                    ),
                    items: [
                      SideMenuItem(
                        priority: 0,
                        title: 'Daftar Stock',
                        onTap: () {
                          page.jumpToPage(0);
                        },
                        icon: const Icon(Icons.home_work),
                      ),
                      SideMenuItem(
                        priority: 1,
                        title: 'Riwayat Pembelian',
                        onTap: () {
                          page.jumpToPage(1);
                        },
                        icon: const Icon(Icons.shopify_rounded),
                      ),
                      // SideMenuItem(
                      //   priority: 2,
                      //   title: 'Riwayat Pemakaian',
                      //   onTap: () {
                      //     page.jumpToPage(2);
                      //   },
                      //   icon:
                      //       const Icon(Icons.format_textdirection_l_to_r_sharp),
                      // ),
                      SideMenuItem(
                        priority: 2,
                        title: 'Pekerjaan',
                        onTap: () {
                          if (page.page == 2) {
                            page.jumpToPage(5);
                            Future.delayed(
                              const Duration(milliseconds: 100),
                              () {
                                page.jumpToPage(2);
                              },
                            );

                            log('message');
                          } else {
                            page.jumpToPage(2);
                          }
                        },
                        icon: const Icon(Icons.engineering_rounded),
                      ),
                      SideMenuItem(
                        priority: 3,
                        title: 'Daftar Supplier',
                        onTap: () {
                          page.jumpToPage(3);
                        },
                        icon: const Icon(Icons.apartment_sharp),
                      ),
                      SideMenuItem(
                        priority: 4,
                        title: 'Daftar Pelanggan',
                        onTap: () {
                          page.jumpToPage(4);
                        },
                        icon: const Icon(Icons.people_alt),
                      ),
                      SideMenuItem(
                        priority: 5,
                        title: 'Laporan Bulanan',
                        onTap: () {
                          page.jumpToPage(6);
                        },
                        icon: const Icon(Icons.document_scanner_rounded),
                      ),
                    ],
                  ),
                  Expanded(
                    child: PageView(
                      controller: page,
                      children: [
                        const StockPage(),
                        const SupplierPage(),
                        // RiwayatPemakaian(),
                        const CustomerPage(), const DaftarSupplier(),
                        const DaftarPelanggan(),
                        Container(), const MonthlyPagae()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
