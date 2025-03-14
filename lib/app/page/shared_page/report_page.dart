import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:printing/printing.dart';
import 'package:financeiro_pessoal/app/infra/infra_imports.dart';
import 'package:financeiro_pessoal/app/page/shared_widget/buttons.dart';

String title = '';

class ReportPage extends StatefulWidget {
  final List<String> columns;
  final List<PlutoRow> plutoRows;
  final String title;
  
  const ReportPage({Key? key, required this.columns, required this.plutoRows, required this.title}) : super(key: key);

  @override
  ReportPageState createState() => ReportPageState();
}

class ReportPageState extends State<ReportPage> {
  PrintingInfo? printingInfo;

  @override
  void initState() {
    super.initState();
     _init();
  }

  Future<void> _init() async {
    final info = await Printing.info();
    setState(() {
      printingInfo = info;
    });
  }
  
  @override
  Widget build(BuildContext context) {  
    title = widget.title;
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(title),
          actions: buttonsAppBar(),
        ),
        body: PdfPreview(                    
          maxPageWidth: 800,
          build: (format) => _generateReport(format, widget.columns, widget.plutoRows),
        ),
      ),
    );
  }

  List<Widget> buttonsAppBar() {
    return <Widget>[
      exitButton(),    
      const SizedBox(
        height: 10,
        width: 5,
      )  
    ];
  }
}

Future<Uint8List> _generateReport(PdfPageFormat pageFormat, List<String> columns, final List<PlutoRow> plutoRows) async {
  final report = ReportA4(columns, plutoRows);
  return await report.buildPdf(pageFormat);
}

class ReportA4 { 
  final List<String> columns;
  final List<PlutoRow> plutoRows;

  ReportA4(this.columns, this.plutoRows);

  final PdfColor _baseColor = PdfColors.blue900;
  final PdfColor _accentColor = PdfColors.black;
  final PdfColor _darkColor = PdfColors.blueGrey800;
  final PdfColor _baseTextColor = PdfColors.blue900.luminance < 0.5 ? PdfColors.white : PdfColors.blueGrey800;
  final PdfColor _accentTextColor = PdfColors.blue900.luminance < 0.5 ? PdfColors.white : PdfColors.blueGrey800;

  late pw.MemoryImage _logoImage;
  late pw.MemoryImage _footerImage;

  Future<Uint8List> buildPdf(PdfPageFormat pageFormat) async {
    final doc = pw.Document();

    _logoImage = pw.MemoryImage(
      (await rootBundle.load('assets/images/logotipo.png')).buffer.asUint8List(),
    );
    _footerImage = pw.MemoryImage(
      (await rootBundle.load('assets/images/report_footer.png')).buffer.asUint8List(),
    );

    final fontNormal = await rootBundle.load('assets/fonts/report/roboto-normal.ttf');
    final fontBold = await rootBundle.load('assets/fonts/report/roboto-bold.ttf');
    final fontItalic = await rootBundle.load('assets/fonts/report/roboto-italic.ttf');

    // Add page to the PDF
    doc.addPage(
      pw.MultiPage(
        pageTheme: _buildTheme(
          pageFormat,
          pw.Font.ttf(fontNormal),
          pw.Font.ttf(fontBold),
          pw.Font.ttf(fontItalic),
        ),
        header: _header,
        footer: _footer,
        build: (context) => [
          _contentItems(context),
          pw.SizedBox(height: 20),
          _contentFinalPage(context),
          pw.SizedBox(height: 20),
        ],
      ),
    );

    // Return the PDF file content
    return doc.save();
  }

  pw.PageTheme _buildTheme(PdfPageFormat pageFormat, pw.Font base, pw.Font bold, pw.Font italic) {
    return pw.PageTheme(
      pageFormat: pageFormat,
      theme: pw.ThemeData.withFont(
        base: base,
        bold: bold,
        italic: italic,
      ),
      buildBackground: (context) => pw.FullPage(
        ignoreMargins: true,
        child: pw.Image(_footerImage),
      ),
    );
  }

  pw.Widget _header(pw.Context context) {
    return pw.Column(
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Expanded(
              child: pw.Column(
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  pw.Container(
                    alignment: pw.Alignment.center,
                    padding: const pw.EdgeInsets.only(bottom: 8, right: 30),
                    height: 120,
                    child: pw.Image(_logoImage),
                  ),
                ],
              ),
            ),
            pw.Expanded(
              child: pw.Column(
                children: [
                  pw.Container(
                    height: 50,
                    padding: const pw.EdgeInsets.only(left: 0),
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Text(
                      title,
                      style: pw.TextStyle(
                        color: _baseColor,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  pw.Container(
                    decoration: pw.BoxDecoration(
                      borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
                      color: _accentColor,
                    ),
                    padding: const pw.EdgeInsets.only(left: 40, top: 10, bottom: 10, right: 20),
                    alignment: pw.Alignment.centerLeft,
                    height: 35,
                    child: pw.DefaultTextStyle(
                      style: pw.TextStyle(
                        color: _accentTextColor,
                        fontSize: 12,
                      ),
                      child: pw.GridView(
                        crossAxisCount: 2,
                        children: [
                          pw.Text('report_date'.tr),
                          pw.Text(Util.formatDate(DateTime.now())),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (context.pageNumber > 1) pw.SizedBox(height: 20)
      ],
    );
  }

  pw.Widget _footer(pw.Context context) {
    return pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.end,
      children: [
        _contentFooter(context), 
        pw.Row( 
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
            pw.Text(
              '${'report_footer_page'.tr}${context.pageNumber}/${context.pagesCount}',
              style: const pw.TextStyle(
                fontSize: 12,
                color: PdfColors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }

  pw.Widget _contentItems(pw.Context context) {
    final tableHeaders = columns.sublist(0, columns.length < 4 ? columns.length : 4);

    return pw.TableHelper.fromTextArray(
      defaultColumnWidth: const pw.FixedColumnWidth(1),
      border: null,
      columnWidths: {
          0:  const pw.FixedColumnWidth(0.2),
          // 1: pw.FractionColumnWidth(tableHeaders[1].length.toDouble()/20),
          // 2: pw.FractionColumnWidth(tableHeaders[2].length.toDouble()/20),
          // 3: pw.FractionColumnWidth(tableHeaders[3].length.toDouble()/20),
        },      
      headerAlignment: pw.Alignment.topLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
        color: _baseColor,
      ),
      headerHeight: 20,
      cellHeight: 20,
      headerStyle: pw.TextStyle(
        color: _baseTextColor,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: pw.TextStyle(
        color: _accentColor,
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: _accentColor,
            width: .5,
          ),
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String?>>.generate(
        plutoRows.length,
        (row) => List<String?>.generate(
          tableHeaders.length,
          (col) { 
            if (plutoRows[row].cells.values.toList()[col].value.runtimeType == DateTime) {
              return Util.formatDate(plutoRows[row].cells.values.toList()[col].value);
            } else {
              return plutoRows[row].cells.values.toList()[col].value.toString();
            }
          }
        ),
      ),
    );
  }

  pw.Widget _contentFinalPage(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'report_final_page_some_message'.tr,
                style: pw.TextStyle(
                  color: _darkColor,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Container(
                margin: const pw.EdgeInsets.only(top: 20, bottom: 8),
                child: pw.Text(
                  'report_company_name'.tr,
                  style: pw.TextStyle(
                    color: _baseColor,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Text(
                'report_company_data'.tr,
                style: pw.TextStyle(
                  fontSize: 8,
                  lineSpacing: 5,
                  color: _darkColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _contentFooter(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border(top: pw.BorderSide(color: _accentColor)),
                ),
                padding: const pw.EdgeInsets.only(top: 10, bottom: 4),
                child: pw.Text(
                  'report_footer_title'.tr,
                  style: pw.TextStyle(
                    fontSize: 12,
                    color: _baseColor,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Text(
                'report_footer_text'.tr,
                textAlign: pw.TextAlign.justify,
                style: pw.TextStyle(
                  fontSize: 6,
                  lineSpacing: 2,
                  color: _darkColor,
                ),
              ),
            ],
          ),
        ),
        pw.Expanded(child: pw.SizedBox(),
        ),
      ],
    );
  }
}
