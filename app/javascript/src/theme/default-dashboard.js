/* -------------------------------------------------------------------------- */
/*                                Weekly Sales                                */
/* -------------------------------------------------------------------------- */
document.addEventListener('turbo:load', function () {
  var getPosition = function getPosition(pos, params, dom, rect, size) {
    return {
      top: pos[1] - size.contentSize[1] - 10,
      left: pos[0] - size.contentSize[0] / 2
    };
  };

  var chartDom = document.querySelector('.echart-bar-weekly-sales');
  var keys = chartDom.dataset.chartKeys;
  var values = chartDom.dataset.chartValues;
  console.log(keys);
  console.log(values);
  if(chartDom) {
    var myChart = echarts.init(chartDom);
    var option;
    var data = JSON.parse(values);

    option = {
      tooltip: {
        trigger: 'axis',
        padding: [7, 10],
        formatter: '{b0} : {c0}',
        transitionDuration: 0,
        backgroundColor: "#f9fafd",
        borderColor: "#d8e2ef",
        textStyle: {
          color: "#0b1727"
        },
        borderWidth: 1,
        position: function position(pos, params, dom, rect, size) {
          return getPosition(pos, params, dom, rect, size);
        }
      },
      xAxis: {
        type: 'category',
        data: JSON.parse(keys),
        boundaryGap: false,
        axisLine: {
          show: false
        },
        axisLabel: {
          show: false
        },
        axisTick: {
          show: false
        },
        axisPointer: {
          type: 'none'
        }
      },
      yAxis: {
        type: 'value',
        splitLine: {
          show: false
        },
        axisLine: {
          show: false
        },
        axisLabel: {
          show: false
        },
        axisTick: {
          show: false
        },
        axisPointer: {
          type: 'none'
        }
      },
      series: [{
        type: 'bar',
        showBackground: true,
        backgroundStyle: {
          borderRadius: 10
        },
        barWidth: '5px',
        itemStyle: {
          borderRadius: 10,
          color: "#2c7be5"
        },
        data: data,
        z: 10,
        emphasis: {
          itemStyle: {
            color: "#2c7be5"
          }
        }
      }],
      grid: {
        right: 5,
        left: 10,
        top: 0,
        bottom: 0
      }
    };

    option && myChart.setOption(option);
  }
});
