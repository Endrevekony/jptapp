import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ListItemsData extends Equatable {
  final List<ItemData> listData;
  const ListItemsData({
    @required this.listData
  });

  @override
  List<Object> get props => [listData];
}

class ItemData extends Equatable {
  final List<HtmlTags> htmlTags;
  final List<PdfLinks> pdfLinks;
  final String title;

  const ItemData({
    @required this.htmlTags,
    @required this.pdfLinks,
    @required this.title,
  });

  @override
  List<Object> get props => [htmlTags, pdfLinks, title];
}

class HtmlTags extends Equatable {
  final String html;
  final String title;

  const HtmlTags({
    @required this.html,
    @required this.title,
  });

  @override
  List<Object> get props => [html, title];
}

class PdfLinks extends Equatable {
  final String link;
  final String title;

  const PdfLinks({
    @required this.link,
    @required this.title,
  });

  @override
  List<Object> get props => [link, title];
}
