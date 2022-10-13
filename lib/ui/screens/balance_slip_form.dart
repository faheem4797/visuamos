import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:visuamos/data/db/databaseHelper.dart';
import 'package:visuamos/data/models/simpleImageData.dart';
import 'package:visuamos/ui/widgets/AppBarEveryWhere.dart';
import 'package:visuamos/ui/widgets/commonBottomButton.dart';

import '../../data/db/database.dart';
import '../widgets/customTextFormField.dart';

class BalanceSlipForm extends StatefulWidget {
  const BalanceSlipForm({super.key});

  @override
  State<BalanceSlipForm> createState() => _BalanceSlipFormState();
}

class _BalanceSlipFormState extends State<BalanceSlipForm> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController couponController = TextEditingController();
  late final VisuamosDB _crudStorage;

  @override
  void initState() {
    _crudStorage = VisuamosDB(dbName: 'visuamosdb.sqlite');

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    dateController.dispose();
    couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      controller: nameController,
                      hintText: 'Enter your name here',
                      labelText: 'Name',
                      validator: (value) {
                        if (nameController.text == '') {
                          return 'Please enter a name';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      hintText: 'Enter the amount here',
                      labelText: 'Amount',
                      controller: amountController,
                      textInputType: TextInputType.number,
                      validator: (value) {
                        if (amountController.text == '') {
                          return 'Please enter an amount';
                        } else if (amountController.text
                            .contains(RegExp('[a-zA-Z]'))) {
                          return 'Please enter a valid amount';
                        } else if (!amountController.text.contains(RegExp(
                            "^[0-9]+(([.]?[0-9]*)?|([ ]?[0-9]*[/]?[0-9]*)?)?"))) {
                          return 'Please enter a valid amount';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                        controller: dateController,
                        hintText: 'Enter date here',
                        labelText: 'Date',
                        readOnly: true,
                        validator: (value) {
                          if (dateController.text == '') {
                            return 'Please enter a date';
                          } else {
                            return null;
                          }
                        },
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101));
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('dd-MM-yyyy').format(pickedDate);
                            setState(() {
                              dateController.text = formattedDate;
                            });
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      controller: couponController,
                      hintText: 'Enter your coupon here',
                      labelText: 'Coupon',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: CommonBottomButton(
                          title: 'Generate Balance Slip',
                          bottomButtonCallBackFunc: () async {
                            final isValid = formKey.currentState?.validate();
                            if (isValid == true) {
                              formKey.currentState?.save();
                              var a = await _crudStorage.addImageData(
                                nameController.text,
                                amountController.text,
                                dateController.text,
                                couponController.text,
                                0,
                              );
                              print(a);
                              setState(() {
                                nameController.clear();
                                amountController.clear();
                                dateController.clear();
                                couponController.clear();
                              });
                              Navigator.pop(context);
                            } else {
                              print('now 2');
                            }
                          }),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
