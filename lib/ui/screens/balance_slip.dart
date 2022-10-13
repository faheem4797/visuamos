import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:visuamos/data/db/database.dart';
import 'package:visuamos/data/models/simpleImageData.dart';
import 'package:visuamos/ui/screens/BalanceSlipWidget.dart';
import 'package:visuamos/ui/screens/balance_slip_form.dart';
import 'package:visuamos/ui/widgets/appBarEveryWhere.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../data/db/databaseHelper.dart';
import '../colors/colors.dart';
import '../widgets/CommonBottomButton.dart';
import '../widgets/customTextFormField.dart';

class BalanceSlips extends StatefulWidget {
  const BalanceSlips({super.key});

  @override
  State<BalanceSlips> createState() => _BalanceSlipsState();
}

class _BalanceSlipsState extends State<BalanceSlips> {
  late final VisuamosDB _crudStorage;
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController couponController = TextEditingController();

  @override
  void initState() {
    _crudStorage = VisuamosDB(dbName: 'visuamosdb.sqlite');
    _crudStorage.open(0);
    super.initState();
  }

  @override
  void dispose() {
    _crudStorage.close();
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
        appBar: AppBarEveryWhere(
          title: 'Balance Slips',
          isIconRequired: true,
          callBackFunc: () {},
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<SimpleImageData>>(
                  stream: _crudStorage.all,
                  builder: (context, snapshot) {
                    print(snapshot.data?.length);
                    print(snapshot.data);
                    if (snapshot.data == null) {
                      print('in here bruv');
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('No data added yet'),
                      );
                    } else if (snapshot.data!.isNotEmpty) {
                      return Container(
                          padding: const EdgeInsets.all(5),
                          child: SingleChildScrollView(
                            child: FittedBox(
                              child: DataTable(
                                columns: [
                                  DataColumn(
                                    label: Text(
                                      'Name',
                                      style: TextStyle(fontSize: 20.sp),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Amount',
                                      style: TextStyle(fontSize: 20.sp),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Date',
                                      style: TextStyle(fontSize: 20.sp),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      '',
                                      style: TextStyle(fontSize: 20.sp),
                                    ),
                                  ),
                                ],
                                rows: snapshot.data!
                                    .map(
                                      (data) => DataRow(
                                        cells: [
                                          DataCell(Text(
                                            data.name,
                                            style: TextStyle(fontSize: 17.sp),
                                          )),
                                          DataCell(Text(
                                            data.amount,
                                            style: TextStyle(fontSize: 17.sp),
                                          )),
                                          DataCell(Text(
                                            data.date,
                                            style: TextStyle(fontSize: 17.sp),
                                          )),
                                          DataCell(
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.r),
                                                    ),
                                                    primary: black,
                                                    textStyle: TextStyle(
                                                        fontSize: 20.sp,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BalanceSlipWidget(
                                                              date: data.date,
                                                              amount:
                                                                  data.amount,
                                                            )),
                                                  );
                                                },
                                                child: const Text('Preview')),
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ));
                    } else {
                      print('in this section');
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: CommonBottomButton(
                title: 'Add a Balance Slip',
                bottomButtonCallBackFunc: () async {
                  await customModalBottomSheet(context);
                  //          Navigator.push(
                  //          context,
                  //        MaterialPageRoute(
                  //          builder: (context) => const BalanceSlipForm()),
                  //  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  customModalBottomSheet(BuildContext context) async {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBarEveryWhere(
          isIconRequired: true,
          callBackFunc: () {},
          title: 'Balance Slips',
        ),
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
