import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/DriverLogic/driverBloc.dart';
import 'package:sure_move/Logic/ProviderViewModel/userNotifier.dart';
import 'package:sure_move/Models/companyModel.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/scaffoldMsg.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
class PickCompany extends StatefulWidget {
  const PickCompany({Key? key}) : super(key: key);

  @override
  State<PickCompany> createState() => _PickCompanyState();
}

class _PickCompanyState extends State<PickCompany> {
  Future<List<CompanyModel>>? companyList;
  @override
  void initState() {
    // TODO: implement initState
    companyList = DriversBloc().getCompanyList();
    super.initState();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    companyList = DriversBloc().getCompanyList();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text(kVendorReg.toUpperCase()),),
      body: Consumer<UserNotifier>(
        builder: (context, modal, child) {
        return SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: kMargin),
              child: Column(
                children: [
                  spacing(),
                  Center(child: Text(
                    "Please select a company you want to work under"
                        .toUpperCase(),
                    textAlign: TextAlign.center,
                    style: Theme
                        .of(context)
                        .textTheme
                        .subtitle1,)),
                  spacing(),
                  FutureBuilder(
                      future: companyList,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<CompanyModel>> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  leading: Text("${index + 1}"),
                                  title: Text(snapshot.data![index].companyName.toString()),
                                  trailing: modal.selectedIndex.contains(index)?
                                  IconButton(onPressed: () {modal.removeCompany(index,snapshot.data![index].companyId);},
                                      icon: const Icon(Icons.radio_button_checked))
                                      :IconButton(onPressed: () {modal.addCompany(index,snapshot.data![index].companyId,snapshot.data![index].companyName);},
                                      icon: const Icon(Icons.radio_button_off)),
                                );
                              });
                        }
                        if (snapshot.hasError) {
                          return const Text("Error fetching companies");
                        }
                        return const Center(child: CircularProgressIndicator());
                      }

                  ),

                  GeneralButton(title: kNextBtn, tapStudiesButton: () {
                    if(modal.selectedIndex.isNotEmpty){
                      Navigator.pushNamed(context, licenceScreen);
                    }else{
                      ScaffoldMsg().errorMsg(context, kSelectCompanyError);

                    }
                  })
                ],
              ),
            ),
          );
        }));
  }
}
