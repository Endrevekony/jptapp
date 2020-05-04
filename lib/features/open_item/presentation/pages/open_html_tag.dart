import 'package:flutter/material.dart';
import 'package:jptapp/core/constants/colors.dart';
import 'package:jptapp/features/list_items_data/data/models/list_items_data_model.dart';
import 'package:jptapp/features/open_item/presentation/widgets/html_widget.dart';

class OpenHtmlTag extends StatelessWidget {
  final HtmlTagModel htmlModel;

  const OpenHtmlTag({Key key, @required this.htmlModel}) : super(key: key);

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
        title: Text(htmlModel.title),
      ),
      body: HtmlWidget(html: htmlModel.html),
    );
  }
}
