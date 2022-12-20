import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:kuponberhadiah/model/kupon.dart';
import 'package:sprintf/sprintf.dart';

class HomeState extends ChangeNotifier{
  BuildContext? context;
  double totalGift = 0;
  int numberOfCouponsWithGift = 0;
  int numberOfCouponWithoutGift = 0;
  bool flagGenerateCoupon = false;
  bool flagGetPrize = false;
  bool flagGetZonk = false;
  List<List<Coupon>> listCouponPerBox = <List<Coupon>>[];
  List<List<Coupon>> listCouponPerBoxWithGift = <List<Coupon>>[];
  List<List<Coupon>> listCouponPerBoxWithoutGift = <List<Coupon>>[];

  mainProcess() async{
    await createCouponsPerBox(numberOfBox: 10, numberOfCoupon: 1000);     // CREATE COUPON PER BOX ACAK
    for(int i = 0; i < listCouponPerBox.length; i++){
      await distributionCouponGiftPerBox(dataList: listCouponPerBox[i], ii: i);
    }
    verifyTotalGiftAndNumberOfCouponWithGift();
    flagGenerateCoupon = true;
    flagGetZonk = false;
    flagGetPrize = false;
    Fluttertoast.showToast(
        msg: "Generate Coupon is successful!",
        backgroundColor: Colors.black,
        textColor: Colors.white);
  }

  getDataZonk(){
    flagGetZonk = true;
    flagGetPrize = false;
    Fluttertoast.showToast(
        msg: "GET Coupon Zonk!",
        backgroundColor: Colors.black,
        textColor: Colors.white);
    notifyListeners();
  }

  getDataPrize(){
    flagGetZonk = false;
    flagGetPrize = true;
    Fluttertoast.showToast(
        msg: "GET Coupon Prize!",
        backgroundColor: Colors.black,
        textColor: Colors.white);
    notifyListeners();
  }
  createCouponsPerBox({int numberOfBox = 0, int numberOfCoupon = 0}){
    listCouponPerBoxWithGift.clear();
    listCouponPerBoxWithoutGift.clear();
    listCouponPerBox.clear();
    for(int i = 0; i < numberOfBox; i++){
      List<Coupon> listPerBox = <Coupon>[];
      listPerBox = generateCouponWithRange(min: numberOfCoupon*i, max: numberOfCoupon*(i+1), lotsCoupon: numberOfCoupon);
      listCouponPerBox.add(listPerBox);
    }
  }

  distributionCouponGiftPerBox({required List<Coupon> dataList, int ii = 0}){
    List<Coupon> tmpList = dataList;
    List<Coupon> listCouponGift = <Coupon>[];
    List<Coupon> listCouponTrash = <Coupon>[];
    Random rnd = Random();
    String noted = "";
    int typeNominal = 0;
    double nominal = 0;
    int idBox = 0;
    int count = 1;
    String? element;
    while(true) {
      int index = rnd.nextInt(tmpList.length);
      element = tmpList[index].numberCoupon;

        if (count >= 1 && count <= 5) {
          noted = "Hadiah Senilai Rp. 100.000";
          typeNominal = 1;
          idBox = ii;
          nominal = 100000;
        } else if (count > 5 && count <= 15) {
          noted = "Hadiah Senilai Rp. 50.000";
          typeNominal = 2;
          idBox = ii;
          nominal = 50000;
        } else if (count > 15 && count <= 40) {
          noted = "Hadiah Senilai Rp. 20.000";
          typeNominal = 3;
          idBox = ii;
          nominal = 20000;
        } else if (count > 40 && count <= 90) {
          noted = "Hadiah Senilai Rp. 10.000";
          typeNominal = 4;
          idBox = ii;
          nominal = 10000;
        } else if (count > 90 && count <= 190) {
          noted = "Hadiah Senilai Rp. 5.000";
          typeNominal = 5;
          idBox = ii;
          nominal = 5000;
        }

        listCouponGift.add(Coupon(element, nominal, typeNominal, idBox, noted));
        tmpList.removeAt(index);

        if (count >= 190) {
          for (int i = 0; i < tmpList.length; i++) {
            tmpList[i].nominal = 0;
            tmpList[i].typeNominal = 0;
            tmpList[i].idBox = ii;
            tmpList[i].noted = "Anda Belum Beruntung";
          }
          listCouponTrash = tmpList;
          break;
        }
        count++;
    }

    listCouponPerBoxWithGift.add(listCouponGift);
    listCouponPerBoxWithGift.length;
    listCouponPerBoxWithoutGift.add(listCouponTrash);
  }

  verifyTotalGiftAndNumberOfCouponWithGift(){
    totalGift = 0;
    numberOfCouponsWithGift = 0;
    numberOfCouponWithoutGift = 0;
    for(int i = 0; i < listCouponPerBoxWithGift.length; i++){
      numberOfCouponsWithGift += listCouponPerBoxWithGift[i].length;
      for(int j = 0; j < listCouponPerBoxWithGift[i].length; j++){
        totalGift += listCouponPerBoxWithGift[i][j].nominal!;
      }
    }

    for(int i = 0; i < listCouponPerBoxWithoutGift.length; i++){
      numberOfCouponWithoutGift += listCouponPerBoxWithoutGift[i].length;
    }

    notifyListeners();
  }

  List<Coupon> generateCouponWithRange({int min = 0, int max = 0, int lotsCoupon = 0}){
    Set<int> setOfInts = {};
    Random rnd = Random();
    List<Coupon> listCoupon = <Coupon>[];
    while(true) {
      setOfInts.add(min + rnd.nextInt(max - min) + 1);
      if(setOfInts.length == lotsCoupon){
        break;
      }
    }
    for (var dat in setOfInts){
      String serialNumb = sprintf("%05d",[dat]);
      listCoupon.add(Coupon(serialNumb, 0, 0, 0, ""));
    }
    return listCoupon;
  }

  printCoupon({required List<Coupon> dataList}){
    for(int i = 0; i < dataList.length; i++){
      debugPrint("NOMER KUPON : ${dataList[i].numberCoupon}");
    }
    debugPrint("LENGTH COUPON : ${dataList.length}");
  }

  String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }

}