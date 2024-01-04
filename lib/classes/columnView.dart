import 'package:flutter/material.dart';
import 'package:hiremeinindiaapp/corporateconsole.dart';

import '../classes/language_constants.dart';
import '../widgets/customcard.dart';
import '../widgets/textstylebutton.dart';

final class ColumnView extends StatelessWidget {
  Widget? child;
  final Function()? onPressed;
  IconData? icon;

  ColumnView({
    super.key,
    this.onPressed,
    this.icon,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomCard(
                  color: Color.fromARGB(255, 153, 51, 49),
                  title1: translation(context).noOfCandidates,
                  title2: '200',
                ),
              ),
              SizedBox(
                width: 60,
              ),
              Expanded(
                child: CustomCard(
                  color: Color.fromARGB(255, 14, 75, 206),
                  title1: translation(context).blueColler,
                  title2: '100',
                ),
              ),
              SizedBox(
                width: 60,
              ),
              Expanded(
                child: CustomCard(
                  color: Color.fromARGB(228, 178, 186, 178),
                  title1: translation(context).greyColler,
                  title2: '100',
                ),
              ),
              SizedBox(
                width: 60,
              ),
              Expanded(
                child: CustomCard(
                  color: Color.fromARGB(223, 251, 217, 84),
                  title1: translation(context).curatedCandidates,
                  title2: '50',
                ),
              ),
              SizedBox(
                width: 60,
              ),
              Expanded(
                child: CustomCard(
                  color: Color.fromARGB(224, 92, 181, 95),
                  title1: translation(context).selectedCandidates,
                  title2: '50',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CorporateConsole()),
                    );
                  },
                ),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 2,
                ),
              ],
              borderRadius: BorderRadius.circular(1),
              border: Border.all(color: Colors.black12),
              color: Colors.white,
            ),
            child: DataTable(
              headingRowColor: MaterialStateColor.resolveWith(
                  (states) => Color.fromARGB(255, 104, 104, 208)),
              columns: [
                DataColumn(
                    label: Text(
                  translation(context).candidates,
                  style: CustomTextStyle.nameOfHeading,
                )),
                DataColumn(
                    label: Text(translation(context).verified,
                        style: CustomTextStyle.nameOfHeading)),
                DataColumn(
                    label: Text(translation(context).qualification,
                        style: CustomTextStyle.nameOfHeading)),
                DataColumn(
                    label: Text(translation(context).jobClassification,
                        style: CustomTextStyle.nameOfHeading)),
                DataColumn(
                    label: Text(translation(context).jobClassifications,
                        style: CustomTextStyle.nameOfHeading)),
                DataColumn(
                    label: Text(translation(context).label,
                        style: CustomTextStyle.nameOfHeading)),
                DataColumn(
                    label: Text(translation(context).noOfDaysOpen,
                        style: CustomTextStyle.nameOfHeading)),
                DataColumn(
                    label: Text(translation(context).cvDoc,
                        style: CustomTextStyle.nameOfHeading)),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text(
                    'xxxxxxxxxxxxxxx',
                    style: CustomTextStyle.nameOflist,
                  )),
                  DataCell(Text(
                    '',
                    style: CustomTextStyle.nameOflist,
                  )),
                  DataCell(Text(
                    'xxxxxxxxxxxxxxx',
                    style: CustomTextStyle.nameOflist,
                  )),
                  DataCell(Text(
                    'Senior plumber',
                    style: CustomTextStyle.nameOflist,
                  )),
                  DataCell(Text(
                    'Senior plumber',
                    style: CustomTextStyle.nameOflist,
                  )),
                  DataCell(Text(
                    'blue',
                    style: CustomTextStyle.nameOflist,
                  )),
                  DataCell(Text(
                    '60',
                    style: CustomTextStyle.nameOflist,
                  )),
                  DataCell(Text(
                    'xxxxxxxxxxxxxxx',
                    style: CustomTextStyle.nameOflist,
                  )),
                ]),
              ],
            ),
          ),
          SizedBox(
            height: 75,
          ),
        ],
      ),
    );
  }
}
