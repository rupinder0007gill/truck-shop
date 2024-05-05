import EchartConfig from './echart_config.js';
var echart_default_config = new EchartConfig();

document.addEventListener('turbo:load', function () {
  var echartsLineTotalSales = document.querySelector('.echart-line-total-sales');
  function getFormatter(params) {
    var _params$ = params[0],
      name = _params$.name,
      value = _params$.value;
    var date = new Date(name);
    return "".concat(month_name, " ").concat(date.getDate(), ", ").concat(value);
  }
  if (echartsLineTotalSales) {
    var month_name = echartsLineTotalSales.dataset.chartMonthName;
    var keys = echartsLineTotalSales.dataset.chartKeys;
    var values = echartsLineTotalSales.dataset.chartValues;
    // Get options from data attribute
    var userOptions = echart_default_config.utils.getData(echartsLineTotalSales, 'options');
    var chart = window.echarts.init(echartsLineTotalSales);
    var getDefaultOptions = function getDefaultOptions() {
      return {
        color: echart_default_config.utils.getGrays()['100'],
        tooltip: {
          trigger: 'axis',
          padding: [7, 10],
          backgroundColor: echart_default_config.utils.getGrays()['100'],
          borderColor: echart_default_config.utils.getGrays()['300'],
          textStyle: {
            color: echart_default_config.utils.getGrays()['1100']
          },
          borderWidth: 1,
          formatter: function formatter(params) {
            return getFormatter(params);
          },
          transitionDuration: 0,
          position: function position(pos, params, dom, rect, size) {
            return echart_default_config.getPosition(pos, params, dom, rect, size);
          }
        },
        xAxis: {
          type: 'category',
          data: JSON.parse(keys),
          boundaryGap: false,
          axisPointer: {
            lineStyle: {
              color: echart_default_config.utils.getGrays()['300'],
              type: 'dashed'
            }
          },
          splitLine: {
            show: false
          },
          axisLine: {
            lineStyle: {
              // color: utils.getGrays()['300'],
              color: echart_default_config.utils.rgbaColor('#000', 0.01),
              type: 'dashed'
            }
          },
          axisTick: {
            show: false
          },
          axisLabel: {
            color: echart_default_config.utils.getGrays()['400'],
            formatter: function formatter(value) {
              var date = new Date(value);
              return "".concat(month_name, " ").concat(date.getDate());
            },
            margin: 15
          }
        },
        yAxis: {
          type: 'value',
          axisPointer: {
            show: false
          },
          splitLine: {
            lineStyle: {
              color: echart_default_config.utils.getGrays()['300'],
              type: 'dashed'
            }
          },
          boundaryGap: false,
          axisLabel: {
            show: true,
            color: echart_default_config.utils.getGrays()['400'],
            margin: 15
          },
          axisTick: {
            show: false
          },
          axisLine: {
            show: false
          }
        },
        series: [{
          type: 'line',
          data: JSON.parse(values),
          lineStyle: {
            color: echart_default_config.utils.getColors().primary
          },
          itemStyle: {
            borderColor: echart_default_config.utils.getColors().primary,
            borderWidth: 2
          },
          symbol: 'circle',
          symbolSize: 10,
          smooth: false,
          emphasis: {
            scale: true
          },
          areaStyle: {
            color: {
              type: 'linear',
              x: 0,
              y: 0,
              x2: 0,
              y2: 1,
              colorStops: [{
                offset: 0,
                color: echart_default_config.utils.rgbaColor(echart_default_config.utils.getColors().primary, 0.2)
              }, {
                offset: 1,
                color: echart_default_config.utils.rgbaColor(echart_default_config.utils.getColors().primary, 0)
              }]
            }
          }
        }],
        grid: {
          right: '28px',
          left: '50px',
          bottom: '15%',
          top: '5%'
        }
      };
    };
    echart_default_config.echartSetOption(chart, userOptions, getDefaultOptions);
  }
});
