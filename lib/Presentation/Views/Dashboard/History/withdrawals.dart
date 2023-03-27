import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sure_move/Logic/AdminLogic/adminBloc.dart';
import 'package:sure_move/Models/historyModels.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/utils/NoDataFound.dart';
import 'package:sure_move/Presentation/utils/formatCurrency.dart';
import 'package:sure_move/Presentation/utils/progressbar.dart';
class WithdrawalHistory extends StatefulWidget {
  const WithdrawalHistory({Key? key}) : super(key: key);

  @override
  State<WithdrawalHistory> createState() => _WithdrawalHistoryState();
}

class _WithdrawalHistoryState extends State<WithdrawalHistory> {
  Future<List<HistoryModel>>? withdrawalList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    withdrawalList = AdminBloc.getWithdrawals("Withdrawal");
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    withdrawalList = AdminBloc.getWithdrawals("Withdrawal");

  }

  Widget _withdrawalList(){
    return FutureBuilder(
        future:withdrawalList,
        builder:( context, AsyncSnapshot<List<HistoryModel>> snapshot){
         if(snapshot.hasData){
           return _withdrawalLists(snapshot.data);
         }
         if(snapshot.hasError){
           return const NoDataFound(title: kError);
         }
         return const ShowProgressIndicator();
        }

    );
  }
  Widget _withdrawalLists(List<HistoryModel>? history) {
      return history!.isEmpty?const NoDataFound(title: kNoWithdrawal): Column(
        children: [
          IntrinsicHeight(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 8.0.sp,vertical: 12.sp),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Date",style:Theme.of(context).textTheme.headline4,),
                    const VerticalDivider(),

                    Text("Amount",style:Theme.of(context).textTheme.headline4,),

                  ],
                ),
              ),
            ),
          ),
       const Divider(),
        Expanded(
        child: ListView(
        children: [
        ListView.builder(
        itemCount: history.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: ( context, index){

          return Column(
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 8.0.sp,vertical: 12.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child: Text(history[index].dateAdded,style: Theme.of(context).textTheme.headline4!.copyWith(color: kLightAshColor),)),
                    //Text(history[index].transaction.toString()),
                    Text("- ${formatCurrency(history[index].amount)}",style: Theme.of(context).textTheme.headline4!.copyWith(color: kRedColor),),

                  ],
                ),
              ),
              const  Divider()
            ],
          );

    })
        ]))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(kWithdrawal),),
    body: Container(
      child: _withdrawalList()
    ));
  }

}
