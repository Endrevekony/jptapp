import 'dart:convert';
import 'package:jptapp/features/list_items_data/domain/entities/list_items_data.dart';
import 'package:meta/meta.dart';
import 'package:flutter/foundation.dart';


ListItemsDataModel listItemsDataModelFromJson(String str) =>
 ListItemsDataModel(itemDataList: List<ItemDataListModel>.from(jsonDecode(str).map((x)=>
 ItemDataListModel.fromJson(x))));


String listItemsDataModelToJson(ListItemsDataModel model) => 
json.encode(List<dynamic>.from(model.itemDataList.map((x)=> x.toJson())));
class ListItemsDataModel extends ListItemsData {
  final List<ItemDataListModel> itemDataList;
  const ListItemsDataModel({@required this.itemDataList})
      : super(listData: itemDataList);
}

class ItemDataListModel extends ItemData {
  final List<HtmlTagModel> htmlTags;
  final List<PdfLinkModel> pdfLinks;
  final String title;
  const ItemDataListModel({
    @required this.htmlTags,
    @required this.pdfLinks,
    @required this.title,
  }) : super(htmlTags: htmlTags, pdfLinks: pdfLinks, title: title);

  factory ItemDataListModel.fromJson(Map<String, dynamic> json) => ItemDataListModel(
        htmlTags: json["htmlTags"] == null
            ? null
            : List<HtmlTagModel>.from(
                json["htmlTags"].map((x) => HtmlTagModel.fromJson(x))),
        pdfLinks: json["pdfLinks"] == null
            ? null
            : List<PdfLinkModel>.from(
                json["pdfLinks"].map((x) => PdfLinkModel.fromJson(x))),
        title: json["title"] ?? json["title"],
      );

      Map<String, dynamic> toJson() => {
        "htmlTags": htmlTags == null
            ? null
            : List<dynamic>.from(htmlTags.map((x) => x.toJson())),
        "pdfLinks": pdfLinks == null
            ? null
            : List<dynamic>.from(pdfLinks.map((x) => x.toJson())),
        "title": title ?? title,
      };
}

class HtmlTagModel extends HtmlTags {
  const HtmlTagModel({
    @required String html,
    @required String title,
  }) : super(html: html, title: title);

  factory HtmlTagModel.fromJson(Map<String, dynamic> json) => HtmlTagModel(
    html: json["html"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "html": html,
    "title": title,
  };
}

class PdfLinkModel extends PdfLinks {
  const PdfLinkModel({
    @required String link,
    @required String title,
  }) : super(link: link, title: title);

  factory PdfLinkModel.fromJson(Map<String, dynamic> json) => PdfLinkModel(
    link: json["link"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "link": link,
    "title": title,
  };
}