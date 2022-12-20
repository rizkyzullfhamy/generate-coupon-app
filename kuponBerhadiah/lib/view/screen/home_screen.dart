import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kuponberhadiah/model/kupon.dart';
import 'package:kuponberhadiah/view_model/home_state.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeState? state;

  @override
  Widget build(BuildContext context) {
    state = Provider.of<HomeState>(context);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: width,
            height: width * 0.3,
            decoration: BoxDecoration(
              color: Colors.blue.shade500,
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: width * 0.18),
                  child: SizedBox(
                    width: width,
                    child: Row(
                      children: [
                        SizedBox(
                          width: width * 0.05,
                        ),
                        const Text(
                          "Welcome to my app",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(height: width * 0.35),
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          removeBottom: false,
                          removeLeft: false,
                          removeRight: false,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Column(
                                  children: [
                                    SizedBox(height: width * 0.05),
                                    SvgPicture.asset(
                                        "assets/images/voucher_coupon.svg",
                                        width: width * 0.5),
                                    SizedBox(height: width * 0.05),
                                    InkWell(
                                        onTap: () => state!.mainProcess(),
                                        child: Container(
                                          width: 150.0,
                                          height: 40.0,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8.0),
                                            color: Colors.blue,
                                          ),
                                          child: const Text("Generate Coupon",
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white)),
                                        )),
                                    state!.flagGenerateCoupon? SizedBox(height: width * 0.02) : Container(),
                                    state!.flagGenerateCoupon?
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                              onTap: () => state!.getDataPrize(),
                                              child: Container(
                                                width: 150.0,
                                                height: 40.0,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  color: Colors.green,
                                                ),
                                                child: const Text("Get Data Coupon Prize",
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight: FontWeight.w400,
                                                        color: Colors.white)),
                                              )),
                                          SizedBox(width: width * 0.02),
                                          InkWell(
                                              onTap: () => state!.getDataZonk(),
                                              child: Container(
                                                width: 150.0,
                                                height: 40.0,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  color: Colors.pink,
                                                ),
                                                child: const Text("Get Data Coupon Zonk",
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight: FontWeight.w400,
                                                        color: Colors.white)),
                                              )),
                                    ]) : Container(),
                                    Container(
                                      margin: const EdgeInsets.all(10),
                                      padding: EdgeInsets.symmetric(vertical: width * 0.02),
                                      width: width,
                                      decoration: BoxDecoration(
                                        color: Colors.blue.shade500,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 20.0, child: Text("Total prize : " + state!.convertToIdr(state!.totalGift, 2), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12.0))),
                                          SizedBox(height: 20.0, child: Text("Total coupons with prizes is : ${state!.numberOfCouponsWithGift} pieces", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12.0))),
                                          SizedBox(height: 20.0, child: Text("Total coupons without prizes is : ${state!.numberOfCouponWithoutGift} pieces", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12.0))),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Center(
                                child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: width *0.02, vertical: width * 0.02),
                                child: Column(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Coupon details here  : ", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: Colors.black)),
                                    (state!.flagGetPrize && state!.listCouponPerBoxWithGift.isNotEmpty)|| (state!.flagGetZonk && state!.listCouponPerBoxWithoutGift.isNotEmpty)?
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                        itemCount: state!.flagGetPrize? state!.listCouponPerBoxWithGift.length : state!.flagGetZonk? state!.listCouponPerBoxWithoutGift.length : 0 ,
                                        itemBuilder: (BuildContext context, int index){
                                          return cardCouponPerBox(context,
                                            dataList: state!.flagGetPrize? state!.listCouponPerBoxWithGift[index] : state!.flagGetZonk? state!.listCouponPerBoxWithoutGift[index] : state!.listCouponPerBox[index],
                                            index: index,
                                          );
                                        }
                                    ) : Center(child: Column(children: [
                                      SizedBox(height: width * 0.05,),
                                      const Text("Is empty, do get coupons (zonk/prize)!, ", style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: Colors.black)),
                                    ],),),
                                  ],
                                )
                              ),
                              ),
                            ],
                          ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  cardCouponPerBox(BuildContext context, {List<Coupon>? dataList, int index = 0, }){
    return Padding(
    padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width * 0.02),
      child : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 0.1 ,
            child: Text("BOX COUPON =>  $index  => ${dataList!.length} pieces", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12.0),),
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: dataList.length,
              itemBuilder: (BuildContext context, int ii){
            return Text("Kupon - $ii : ${dataList[ii].numberCoupon} => ${dataList[ii].noted}");
          }),
      ],
      ),
    );
  }
}
