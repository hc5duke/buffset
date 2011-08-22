Highcharts.setOptions({
  global: {
    useUTC: false
  }
});
var createChart = function(series) {
  var chart = new Highcharts.Chart({
    chart: {
      renderTo: 'container',
      defaultSeriesType: 'line',
      zoomType: 'x',
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
      maxZoom: 24 * 3600000, // 1 day
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
      min: 0,
      plotLines: [{
        value: 0,
        width: 1,
        color: '#808080'
      }]
    },
    plotOptions: {
      series: {
        marker: {
          symbol: 'circle',
          fillColor: '#ffffff',
          lineColor: null,
          lineWidth: 2,
          radius: 3,
        }
      }
    },
    tooltip: {
      formatter: function() {
        return '<b>'+ this.series.name +'</b><br/>'+
          Highcharts.dateFormat('%m-%d %H:%M', this.x) +': '+ this.y +' pushups (' + this.y/20 +' sets of 20)';
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

var createStackedChart = function(categories, series) {
  var chart = new Highcharts.Chart({
    chart: {
      renderTo: 'container',
      defaultSeriesType: 'area',
    },
    title: {
      text: 'Buffness Progress Indicator',
    },
    subtitle: {
      text: 'Source: Buff people',
    },
    xAxis: {
      categories: categories,
      tickmarkPlacement: 'on',
      title: {
        enabled: false
      }
    },
    yAxis: {
      title: {
        text: 'Total Pushups'
      },
      labels: {
        formatter: function() {
          return this.value;
        }
      },
      min: 0
    },
    plotOptions: {
      area: {
        stacking: 'normal',
        lineColor: '#666666',
        lineWidth: 1,
        marker: {
          lineWidth: 1,
          lineColor: '#666666'
        }
      }
    },
    tooltip: {
      formatter: function() {
        return '<b>'+ this.series.name +'</b><br/>'+
          Highcharts.dateFormat('%m-%d %H:%M', this.x) +': '+ this.y +' pushups (' + this.y/20 +' sets of 20)';
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
