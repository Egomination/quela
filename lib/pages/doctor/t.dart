import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class TimeSeriesRangeAnnotationMarginChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  TimeSeriesRangeAnnotationMarginChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(seriesList, animate: animate, behaviors: [
      charts.RangeAnnotation([
        charts.RangeAnnotationSegment(
            15, 20, charts.RangeAnnotationAxisType.measure,
            startLabel: 'M1 Start',
            endLabel: 'M1 End',
            labelAnchor: charts.AnnotationLabelAnchor.end,
            color: charts.MaterialPalette.gray.shade300),
      ], defaultLabelPosition: charts.AnnotationLabelPosition.margin),
    ]);
  }
}
