import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class PdfEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPdfItem extends PdfEvent {
  final String url;

  GetPdfItem({@required this.url});

  @override
  List<Object> get props => [url];
}
