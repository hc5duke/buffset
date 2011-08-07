var createChart = function(series) {
  var chart = new Highcharts.Chart({
    chart: {
      renderTo: 'container',
      defaultSeriesType: 'line',
      marginRight: 130,
      marginBottom: 25
    },
    title: {
      text: 'Buffness Progress Indicator',
      x: -20
    },
    subtitle: {
      text: 'Source: Buff people',
      x: -20
    },
    xAxis: {
      type: 'datetime',
      dateTimeLabelFormats: {
        day: '%m-%d',
        week: '%m-%d',
        month: '%y-%m',
        year: '%Y'
      }
    },
    yAxis: {
      title: {
        text: 'Total Pushups'
      },
      plotLines: [{
        value: 0,
        width: 1,
        color: '#808080'
      }]
    },
    plotOptions: {
      series: {
        marker: {
          enabled: false
        }
      }
    },
    tooltip: {
      formatter: function() {
        return '<b>'+ this.series.name +'</b><br/>'+
          Highcharts.dateFormat('%m-%d', this.x) +': '+ this.y +' pushups';
      }
    },
    legend: {
      layout: 'vertical',
      align: 'right',
      verticalAlign: 'top',
      x: -10,
      y: 100,
      borderWidth: 0
    },
    series: series
  });
};
