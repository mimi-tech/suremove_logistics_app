import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/AdminLogic/adminBloc.dart';
import 'package:sure_move/Models/DashboardModel/totalEarningModel.dart';
import 'package:sure_move/Models/driversModel.dart';
import 'package:sure_move/Models/userModel.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Views/Dashboard/Widgets/earningConstructors.dart';
import 'package:sure_move/Presentation/Views/Dashboard/Widgets/headers.dart';
import 'package:sure_move/Presentation/utils/NoDataFound.dart';
import 'package:sure_move/Presentation/utils/progressbar.dart';
import 'package:sure_move/Providers/driverProvider.dart';
import 'package:sure_move/Providers/userProvider.dart';
class AllWeeklyEarnings extends StatefulWidget {
  const AllWeeklyEarnings({Key? key}) : super(key: key);

  @override
  State<AllWeeklyEarnings> createState() => _AllWeeklyEarningsState();
}

class _AllWeeklyEarningsState extends State<AllWeeklyEarnings> {
  Future<List <EarningModel>> ?  earningsList;
  var items;
  var companyDetails;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NewUser user = Provider.of<UserProvider>(context,listen: false).user;
    DriverModel driver = Provider.of<DriverProvider>(context,listen: false).driver;
    earningsList  =  AdminBloc.getWeeklyEarnings(user,driver.driverId);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    NewUser user = Provider.of<UserProvider>(context,listen: false).user;
    DriverModel driver = Provider.of<DriverProvider>(context,listen: false).driver;
    earningsList  =  AdminBloc.getWeeklyEarnings(user,driver.driverId);
  }

  Widget _earningList(){
    return FutureBuilder(
        future: earningsList,
        builder: (BuildContext context, AsyncSnapshot<List<EarningModel>> snapshot){
          if(snapshot.hasData){
            return _earningsList(snapshot.data);
          }
          if(snapshot.hasError){
            return const NoDataFound(title: kError);
          }
          return const ShowProgressIndicator();
        }
    );
  }

  Widget _earningsList(List<EarningModel>? earnings){
    return earnings!.isEmpty?const NoDataFound(title: kNoEarnings):Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              ListView.builder(
                  itemCount: earnings.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: ( context, index){
                    items = earnings[index].item;
                    companyDetails = earnings[index].companyDetails;
                    return Column(
                      children: [
                        spacing(),
                        Card(
                          child: Column(children:  [
                            EarningConstructor(
                                dateString: earnings[index].createdAt,
                                itemSize: items["size"].toString(),
                                itemQuantity:items["number"].toString(),
                                itemName: items["name"].toString(),
                                company: companyDetails["name"],
                                paymentMethod: earnings[index].methodOfPayment,
                                deliveryFee: earnings[index].driverAmount,
                                contributorFee: earnings[index].contributorAmount,
                                partnerFee:earnings[index].partnerAmount,
                                ownerFee: earnings[index].ownerAmount,
                                total: earnings[index].totalAmount

                            )
                          ],),
                        )
                      ],
                    );
                  }
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kWhiteColor,
          automaticallyImplyLeading: false,
          title: const AnalysisHeaders(),),
        body:_earningList()
    );
  }

}
