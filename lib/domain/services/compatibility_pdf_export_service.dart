import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CompatibilityPdfReportData {
  const CompatibilityPdfReportData({
    required this.isRtl,
    required this.appName,
    required this.reportTitle,
    required this.generatedAt,
    required this.participantALabel,
    required this.participantAName,
    required this.participantBLabel,
    required this.participantBName,
    required this.compatibilityLabel,
    required this.compatibilityScore,
    required this.readinessLabel,
    required this.readinessScore,
    required this.verdictTitle,
    required this.verdictHeadline,
    required this.verdictBody,
    required this.nextStepTitle,
    required this.nextStepBody,
    required this.topicsTitle,
    required this.discussionTopics,
    required this.categoryTitle,
    required this.categoryScores,
    required this.archetypeTitle,
    required this.participantAArchetype,
    required this.participantBArchetype,
    required this.participantProfileTitle,
    required this.participantAProfile,
    required this.participantBProfile,
    required this.dynamicsTitle,
    required this.dynamics,
    required this.strengthsTitle,
    required this.strengths,
    required this.risksTitle,
    required this.risks,
    required this.notesTitle,
    required this.notes,
    required this.sessionsTitle,
    required this.sessions,
  });

  final bool isRtl;
  final String appName;
  final String reportTitle;
  final String generatedAt;
  final String participantALabel;
  final String participantAName;
  final String participantBLabel;
  final String participantBName;
  final String compatibilityLabel;
  final int compatibilityScore;
  final String readinessLabel;
  final int readinessScore;
  final String verdictTitle;
  final String verdictHeadline;
  final String verdictBody;
  final String nextStepTitle;
  final String nextStepBody;
  final String topicsTitle;
  final List<String> discussionTopics;
  final String categoryTitle;
  final Map<String, int> categoryScores;
  final String archetypeTitle;
  final String participantAArchetype;
  final String participantBArchetype;
  final String participantProfileTitle;
  final List<String> participantAProfile;
  final List<String> participantBProfile;
  final String dynamicsTitle;
  final List<String> dynamics;
  final String strengthsTitle;
  final List<String> strengths;
  final String risksTitle;
  final List<String> risks;
  final String notesTitle;
  final List<String> notes;
  final String sessionsTitle;
  final List<String> sessions;
}

class CompatibilityPdfExportService {
  Future<void> saveReport(CompatibilityPdfReportData data) async {
    final bytes = await buildPdfBytes(data);
    await Printing.layoutPdf(
      name: '${data.appName}-report.pdf',
      onLayout: (_) async => bytes,
    );
  }

  Future<Uint8List> buildPdfBytes(CompatibilityPdfReportData data) async {
    final document = pw.Document();
    final regularFont = pw.Font.ttf(
      await rootBundle.load('assets/fonts/arial.ttf'),
    );
    final boldFont = pw.Font.ttf(
      await rootBundle.load('assets/fonts/arialbd.ttf'),
    );
    final logoBytes = (await rootBundle.load(
      'assets/images/app_logo.png',
    )).buffer.asUint8List();
    final logo = pw.MemoryImage(logoBytes);

    document.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(28),
          textDirection: data.isRtl
              ? pw.TextDirection.rtl
              : pw.TextDirection.ltr,
          theme: pw.ThemeData.withFont(base: regularFont, bold: boldFont),
        ),
        build: (context) => [
          _buildHeader(data, logo),
          pw.SizedBox(height: 18),
          _buildOverview(data),
          pw.SizedBox(height: 14),
          _buildSection(
            title: data.verdictTitle,
            children: [
              _paragraph(data.verdictHeadline, isBold: true),
              pw.SizedBox(height: 6),
              _paragraph(data.verdictBody),
            ],
          ),
          pw.SizedBox(height: 14),
          _buildSection(
            title: data.nextStepTitle,
            children: [
              _paragraph(data.nextStepBody),
              if (data.discussionTopics.isNotEmpty) ...[
                pw.SizedBox(height: 10),
                _subheading(data.topicsTitle),
                pw.SizedBox(height: 6),
                ...data.discussionTopics.map(_bullet),
              ],
            ],
          ),
          pw.SizedBox(height: 14),
          _buildSection(
            title: data.categoryTitle,
            children: [
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.grey300),
                columnWidths: const {
                  0: pw.FlexColumnWidth(3),
                  1: pw.FlexColumnWidth(1),
                },
                children: [
                  for (final entry in data.categoryScores.entries)
                    pw.TableRow(
                      children: [
                        _tableCell(entry.key, isHeader: false),
                        _tableCell('${entry.value}%', isHeader: false),
                      ],
                    ),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 14),
          _buildSection(
            title: data.archetypeTitle,
            children: [
              _pairRow(data.participantAName, data.participantAArchetype),
              pw.SizedBox(height: 8),
              _pairRow(data.participantBName, data.participantBArchetype),
            ],
          ),
          pw.SizedBox(height: 14),
          _buildSection(
            title: '${data.participantAName} ${data.participantProfileTitle}',
            children: data.participantAProfile.map(_bullet).toList(),
          ),
          pw.SizedBox(height: 14),
          _buildSection(
            title: '${data.participantBName} ${data.participantProfileTitle}',
            children: data.participantBProfile.map(_bullet).toList(),
          ),
          pw.SizedBox(height: 14),
          _buildSection(
            title: data.dynamicsTitle,
            children: data.dynamics.map(_bullet).toList(),
          ),
          pw.SizedBox(height: 14),
          _buildSection(
            title: data.strengthsTitle,
            children: data.strengths.map(_bullet).toList(),
          ),
          pw.SizedBox(height: 14),
          _buildSection(
            title: data.risksTitle,
            children: data.risks.map(_bullet).toList(),
          ),
          pw.SizedBox(height: 14),
          _buildSection(
            title: data.notesTitle,
            children: data.notes.map(_bullet).toList(),
          ),
          pw.SizedBox(height: 14),
          _buildSection(
            title: data.sessionsTitle,
            children: data.sessions.map(_bullet).toList(),
          ),
        ],
      ),
    );

    return document.save();
  }

  pw.Widget _buildHeader(CompatibilityPdfReportData data, pw.MemoryImage logo) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(18),
      decoration: pw.BoxDecoration(
        color: PdfColor.fromHex('#EAF7F7'),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            width: 54,
            height: 54,
            padding: const pw.EdgeInsets.all(6),
            decoration: pw.BoxDecoration(
              color: PdfColors.white,
              borderRadius: pw.BorderRadius.circular(8),
            ),
            child: pw.Image(logo, fit: pw.BoxFit.contain),
          ),
          pw.SizedBox(width: 14),
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _paragraph(data.appName, isBold: true, fontSize: 18),
                pw.SizedBox(height: 4),
                _paragraph(data.reportTitle, isBold: true, fontSize: 14),
                pw.SizedBox(height: 4),
                _paragraph(data.generatedAt, fontSize: 11),
              ],
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildOverview(CompatibilityPdfReportData data) {
    return pw.Row(
      children: [
        pw.Expanded(
          child: _metricCard(
            data.compatibilityLabel,
            '${data.compatibilityScore}%',
          ),
        ),
        pw.SizedBox(width: 12),
        pw.Expanded(
          child: _metricCard(data.readinessLabel, '${data.readinessScore}%'),
        ),
      ],
    );
  }

  pw.Widget _metricCard(String label, String value) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(14),
      decoration: pw.BoxDecoration(
        color: PdfColors.white,
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          _paragraph(label, fontSize: 11),
          pw.SizedBox(height: 6),
          _paragraph(value, isBold: true, fontSize: 18),
        ],
      ),
    );
  }

  pw.Widget _buildSection({
    required String title,
    required List<pw.Widget> children,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        color: PdfColors.white,
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          _paragraph(title, isBold: true, fontSize: 14),
          pw.SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }

  pw.Widget _pairRow(String label, String value) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(flex: 2, child: _paragraph(label, isBold: true)),
        pw.SizedBox(width: 10),
        pw.Expanded(flex: 3, child: _paragraph(value)),
      ],
    );
  }

  pw.Widget _tableCell(String value, {required bool isHeader}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: _paragraph(value, isBold: isHeader, fontSize: 11),
    );
  }

  pw.Widget _subheading(String text) {
    return _paragraph(text, isBold: true, fontSize: 12);
  }

  pw.Widget _bullet(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 6),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('• '),
          pw.Expanded(child: _paragraph(text)),
        ],
      ),
    );
  }

  pw.Widget _paragraph(
    String text, {
    bool isBold = false,
    double fontSize = 12,
  }) {
    return pw.Text(
      text,
      style: pw.TextStyle(
        fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
        fontSize: fontSize,
      ),
    );
  }
}
