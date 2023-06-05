import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:visuamos/ui/widgets/CommonBottomButton.dart';
import 'package:visuamos/ui/widgets/appBarEveryWhere.dart';
import 'package:visuamos/ui/widgets/customTextFormField.dart';

import '../../data/db/database.dart';

class AddSimpleImage extends StatefulWidget {
  final int imageType;

  const AddSimpleImage({super.key, required this.imageType});

  @override
  State<AddSimpleImage> createState() => _AddSimpleImageState();
}

//TODO: CHANGE APPBAR and button design

class _AddSimpleImageState extends State<AddSimpleImage> {
  final User? user = FirebaseAuth.instance.currentUser;

  late final VisuamosDB _crudStorage;
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController couponController = TextEditingController();

  void init() async {
    _crudStorage = VisuamosDB(dbName: 'visuamosdb.sqlite');
    (widget.imageType == 0)
        ? _crudStorage.open(0, user!.uid)
        : (widget.imageType == 1)
            ? _crudStorage.open(1, user!.uid)
            : _crudStorage.open(2, user!.uid);
  }

  @override
  void initState() {
    init();
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
    return Scaffold(
      appBar: AppBarEveryWhere(
        isIconRequired: true,
        callBackFunc: () {
          //logoutAndPushLoginScreen(context);
        },
        title: (widget.imageType == 0)
            ? 'Balance Slips'
            : (widget.imageType == 1)
                ? 'Bank Statements'
                : 'Dream Checks',
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
                      } else if (('.'
                              .allMatches(amountController.text)
                              .length) >
                          1) {
                        return 'Please enter a valid amount';
                      } else if (!amountController.text.contains(RegExp(
                          "^[0-9]+(([.]?[0-9]*)?|([ ]?[0-9]*[/]?[0-9]*)?)?"))) {
                        return 'Please enter a valid amount';
                      } else if (amountController.text != '') {
                        final temp = amountController.text.split('');
                        temp[0].contains('.');
                        if (temp[0].contains('.')) {
                          return 'Please enter a valid amount';
                        } else if (temp.last == '.') {
                          return 'Please enter a valid amount';
                        }
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
                        title: (widget.imageType == 0)
                            ? const Text(
                                'Generate Balance Slip',
                                textAlign: TextAlign.center,
                              )
                            : (widget.imageType == 1)
                                ? const Text(
                                    'Generate Bank Statement',
                                    textAlign: TextAlign.center,
                                  )
                                : const Text(
                                    'Generate Dream Check',
                                    textAlign: TextAlign.center,
                                  ),
                        bottomButtonCallBackFunc: () async {
                          final isValid = formKey.currentState?.validate();
                          if (isValid == true) {
                            formKey.currentState?.save();

                            var a = await _crudStorage.addImageData(
                              user!.uid,
                              nameController.text,
                              amountController.text,
                              dateController.text,
                              (user?.uid == 'MsWSztJZpLSQBeRfu0yKWhismu22')
                                  ? 1
                                  : 0,
                              //(couponController.text == 'free') ? 1 : 0,
                              couponController.text,
                              widget.imageType,
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
    );
  }
}
