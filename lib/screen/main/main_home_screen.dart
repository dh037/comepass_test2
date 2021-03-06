import 'package:comepass/components/custom_event_banner.dart';
import 'package:comepass/constants/routes_path.dart';
import 'package:comepass/notifier/main/main_home_notifier.dart';
import 'package:comepass/screen/main/main_screen.dart';
import 'package:comepass/screen/qr_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
// import 'package:qr_flutter/qr_flutter.dart';

import '../../constants/color_code.dart';
import '../../constants/icon_path.dart';
import '../../constants/image_path.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  late MainHomeNotifier _homeNotifier;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homeNotifier = context.read<MainHomeNotifier>();
    _homeNotifier.value = _homeNotifier.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: _homeNotifier.value,
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : content(context);
            }));
  }

  Widget content(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(
          padding: EdgeInsets.only(top: MediaQuery
              .of(context)
              .padding
              .top),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImagePath.mainBgImage), fit: BoxFit.fill)),
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Container(
              padding: EdgeInsets.only(right: 11.w, left: 16.w, top: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(ImagePath.logoTypeDefaultLeft,
                      width: 40.w, height: 23.h),
                  Stack(
                    children: [
                      SvgPicture.asset(IconPath.iconBell,
                          width: 40.w, height: 23.h, color: ColorCode.white),
                      Positioned(
                          top: 0,
                          right: 0,
                          child: SvgPicture.asset(IconPath.iconBadgeDot,
                              width: 4.w, height: 4.h))
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 51.h),
            Container(
              padding: EdgeInsets.only(right: 32.w, left: 17.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            constraints: BoxConstraints(maxWidth: 172.w),
                            child: Text('????????? ??????????????????',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: ColorCode.green40,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w700)),
                          ),
                          SizedBox(width: 4.w),
                          SvgPicture.asset(IconPath.iconLocationBtn,
                              width: 20.w, height: 20.h),
                        ],
                      ),
                      Row(
                        children: [
                          Text('????????????',
                              style: TextStyle(
                                  color: ColorCode.grey50,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                      Text('????????? ',
                          style: TextStyle(
                              color: ColorCode.grey50,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700))
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => QrScreen()));
                    },
                    child: Container(
                      width: 96.w,
                      height: 96.w,
                      decoration: BoxDecoration(
                        color: ColorCode.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: QrImage(
                        data: "12312312",
                        version: 2,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 48.h),
            SizedBox(
              height: 98.h,
              child: PageView.builder(
                  controller: _homeNotifier.pageController,
                  onPageChanged: _homeNotifier.ticketBanner,
                  itemCount: _homeNotifier.ticketList.length,
                  padEnds: false,
                  itemBuilder: (_, index) {
                    return Row(
                      children: [
                        if (index == 0) SizedBox(width: 16.w),
                        Expanded(
                          child: CustomTicketBanner(
                              ticket: _homeNotifier.ticketList[index]),
                        ),
                      ],
                    );
                  }),
            ),
            SizedBox(height: 20.h),
            Consumer<MainHomeNotifier>(
                builder: (BuildContext context, value, Widget? child) =>
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _homeNotifier.ticketList.length,
                              (index) =>
                              Container(
                                width: 6.w,
                                height: 6.w,
                                margin: EdgeInsets.symmetric(horizontal: 5.w),
                                decoration: BoxDecoration(
                                    color:
                                    _homeNotifier
                                        .ticketBannerDotIndicatorIndex ==
                                        index
                                        ? Colors.white
                                        : Color(0xffFFFFFF).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                        ))),
            SizedBox(height: 20.h),
          ]),
        ),
        SizedBox(height: 20.h),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          height: 72.h,
          child: Stack(children: [
            PageView.builder(
                onPageChanged: _homeNotifier.eventBanner,
                itemCount: 10,
                itemBuilder: (_, index) =>
                    Container(
                      child: Center(
                          child: Text(
                            '?????? ${index.toString()}',
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          )),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blueAccent,
                      ),
                    )),
            Positioned(
                bottom: 8.h,
                right: 8.w,
                child: Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color(0xff000000).withOpacity(0.2)),
                    child: Consumer<MainHomeNotifier>(
                      builder: (BuildContext context, value, Widget? child) =>
                          Text.rich(
                            TextSpan(
                                text: _homeNotifier.eventBannerIndex.toString(),
                                // list. length
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: ColorCode.white,
                                    fontWeight: FontWeight.w500),
                                children: [
                                  TextSpan(
                                    text: " / 10 ",
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        color: ColorCode.white.withOpacity(0.5),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  TextSpan(
                                      text: '????????????',
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: ColorCode.white,
                                          fontWeight: FontWeight.w500))
                                ]),
                          ),
                    )))
          ]),
        ),
        SizedBox(height: 20.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '????????? ??????',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp),
              ),
              Text(
                '?????????',
                style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorCode.grey60),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),

        SizedBox(
          height: 172.h,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) =>
                  Row(
                    children: [
                      if (index == 0) SizedBox(width: 17.w),
                      Container(
                        color: Colors.red,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0)),
                              height: 128.w,
                              width: 128.w,
                              child: Image.asset(ImagePath.shopImage,
                                  fit: BoxFit.fill),
                            ),
                            SizedBox(height: 4.h),
                            Text('????????? ????????????',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.sp),
                                textAlign: TextAlign.left),
                            Text('???????????? 58???',
                                style: TextStyle(
                                    fontSize: 12.sp, color: ColorCode.grey60,height: 1.4.sp),
                                textAlign: TextAlign.left)
                          ],
                        ),
                      ),
                      if (index == 4) SizedBox(width: 17.w)
                      // if (index == ~~~.lenght) SizedBox(widgth: 17.w)?????? ?????????
                    ],
                  ),
              separatorBuilder: (context, index) => Container(width: 8.w),
              itemCount: 5),
        ),
        SizedBox(height: 31.h)
      ]),
    );
  }
}
