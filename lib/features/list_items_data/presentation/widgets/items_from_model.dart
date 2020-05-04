import 'package:flutter/material.dart';
import 'package:jptapp/features/list_items_data/data/models/list_items_data_model.dart';
import 'package:jptapp/features/open_item/presentation/pages/open_html_tag.dart';
import 'package:jptapp/features/open_item/presentation/pages/open_pdf_page.dart';

class ItemsFromModel {
  List<Widget> getItemsFromModel(ItemDataModel item, context) {
    final htmlItems = getHtmlLinks(item.htmlTags, context);
    final pdfItems = getPdfLinks(item.pdfLinks, context);
    final items = htmlItems + pdfItems;
    return items;
  }

  List<Widget> getHtmlLinks(List<HtmlTagModel> item, context) {
    final htmlItems = <Widget>[];
    for (var i = 0; i < item.length; i++) {
      htmlItems.add(
        ListTile(
          title: Text(item[i].title),
          leading: Icon(Icons.http),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => OpenHtmlTag(
                  htmlModel: item[i],
                ),
              ),
            );
          },
        ),
      );
    }
    return htmlItems;
  }

  List<Widget> getPdfLinks(List<PdfLinkModel> item, context) {
    final pdfItems = <Widget>[];
    for (var i = 0; i < item.length; i++) {
      pdfItems.add(
        ListTile(
          title: Text(item[i].title),
          leading: Icon(Icons.picture_as_pdf),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => OpenPdfPage(
                  pdfModel: item[i],
                ),
              ),
            );
          },
        ),
      );
    }
    return pdfItems;
  }
}
