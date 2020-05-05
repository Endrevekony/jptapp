import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:jptapp/features/open_item/presentation/bloc/pdf_bloc/pdf_bloc.dart';
import 'package:jptapp/features/open_item/presentation/bloc/pdf_bloc/pdf_state.dart';
import 'package:jptapp/features/open_item/presentation/bloc/pdf_bloc/pdf_event.dart';
import 'package:jptapp/injection_container.dart';

class PdfWidget extends StatelessWidget {
  final String link;

  const PdfWidget({Key key, @required this.link}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PdfBloc>(),
      child: BlocBuilder<PdfBloc, PdfState>(
        builder: (context, state) {
          if (state is NoData) {
            BlocProvider.of<PdfBloc>(context).add(GetPdfItem(url: link));
            return Container();
          } else if (state is Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is Loaded) {
            return PDFViewer(document: state.pdfDocument);
          } else if (state is Error) {
            return Center(
              child: Text(state.message),
            );
          }
          return Container();
        },
      ),
    );
  }
}
