import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/Views/Admin/DrawerComponents/Company/companyConstructor.dart';
class AllCompanies extends StatelessWidget {
  const AllCompanies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: CompanyConstructors(
        companyName: "Sure move Logistics",
        fullName: "Amazing grace",
        phoneNumber: "+24345443434",
        dateString: "",
        profileImage: "",
        companyAddress: "943b djehr ekfhejf jkejhf",
      ),
    );
  }
}
