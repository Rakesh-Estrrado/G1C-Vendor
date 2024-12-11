import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1c_vendor/ui/bankDetails/bloc/bank_details_bloc.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/CommonButton.dart';
import 'package:g1c_vendor/utils/widgets/CommonTextField.dart';
import 'package:g1c_vendor/utils/widgets/customAppBar2.dart';

import '../profile/bloc/account_bloc.dart';

class BankDetails extends StatefulWidget {
  BankDetails({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
        create: (context) => BankDetailsBloc(), child: BankDetails());
  }

  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  var bankName = TextEditingController();

  var bankAccountNumber = TextEditingController();

  var bankAccountName = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Background(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
              bankName.text = state.bankDetails?.bank??"";
              bankAccountNumber.text = state.bankDetails?.acNo??"";
              bankAccountName.text = state.bankDetails?.acHolder??"";
              return Column(
                children: [
                  CustomAppBar2(title: "Bank Details"),
                  SizedBox(height: 30),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: CommonTextField(
                      labelText: "Bank Name",
                      hintText: "",
                      controller: bankName,
                      onChanged: (val) {},
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: CommonTextField(
                      labelText: "Bank Account Number",
                      hintText: "",
                      controller: bankAccountNumber,
                      onChanged: (val) {},
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: CommonTextField(
                      labelText: "Bank Account Name",
                      hintText: "",
                      controller: bankAccountName,
                      onChanged: (val) {},
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: CommonButton(
                      label: "Update",
                      onTap: () {
                        var name = bankName.text;
                        var accName = bankAccountName.text;
                        var accNumber = bankAccountNumber.text;

                        if(name.isEmpty){
                          showSnackBar(context: context, msg: "Please enter a valid bank name");
                          return;
                        }
                        if(accNumber.isEmpty){
                          showSnackBar(context: context, msg: "Please enter a valid account number");
                          return;
                        }
                        if(accName.isEmpty){
                          showSnackBar(context: context, msg: "Please enter a valid account name");
                          return;
                        }
                        context.read<AccountBloc>().updateBankDetails(name, accName, accNumber);
                      }
                    ),
                  ),
                ],
              );
            },
          ),
        ));
  }
}
