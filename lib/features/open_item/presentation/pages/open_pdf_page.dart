import 'package:flutter/material.dart';
import 'package:jptapp/core/constants/colors.dart';
import 'package:jptapp/features/list_items_data/data/models/list_items_data_model.dart';
import 'package:jptapp/features/open_item/presentation/widgets/pdf_widget.dart';

class OpenPdfPage extends StatelessWidget {
  final PdfLinkModel pdfModel;

  const OpenPdfPage({Key key, @required this.pdfModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context, false),
        ),
        centerTitle: true,
        backgroundColor: MyColors.appBarColor,
        title: Text(pdfModel.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.file_download,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: PdfWidget(link: pdfModel.link),
    );
  }


}
