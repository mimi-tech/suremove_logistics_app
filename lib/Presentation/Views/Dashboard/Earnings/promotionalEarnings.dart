import 'package:flutter/material.dart';
import 'package:sure_move/Logic/AdminLogic/adminBloc.dart';
import 'package:sure_move/Models/DashboardModel/referralModel.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/utils/NoDataFound.dart';
import 'package:sure_move/Presentation/utils/profilePicture.dart';
import 'package:sure_move/Presentation/utils/progressbar.dart';
class PromotionalEarning extends StatefulWidget {
  const PromotionalEarning({Key? key}) : super(key: key);

  @override
  State<PromotionalEarning> createState() => _PromotionalEarningState();
}

class _PromotionalEarningState extends State<PromotionalEarning> {
  Future<List<ReferralModel>>? referralList;
  var fullName = '';
  @override
  void initState() {
    super.initState();
    referralList = AdminBloc.onPromotionalEarningRequested();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    referralList = AdminBloc.onPromotionalEarningRequested();
  }

  Widget _referralList() {
    return FutureBuilder(
        future: referralList,
        builder: (BuildContext context, AsyncSnapshot<List<ReferralModel>> snapshot) {
          if (snapshot.hasData) {
            return _referralsList(snapshot.data!);
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Unable to fetch your referrals at the moment."));
          }
          return const ShowProgressIndicator();
        });
  }

  Widget _referralsList(final List<ReferralModel> referral) {
    return referral.isEmpty?const NoDataFound(title:kNoReferral):Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              ListView.builder(
                  itemCount: referral.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                        leading: ProfilePicture(
                            image: referral[index].profileImageUrl),
                        title: Text("${referral[index].firstName} ${referral[index].lastName}", style: Theme.of(context).textTheme.headline1,),
                        subtitle: Text(referral[index].date.toString())

                    );
                  })

            ],),
        ),
      ],
    );
  }

    @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: const Text(kReferrialEarnings),),
        body: _referralList()
    );

        }
      }
