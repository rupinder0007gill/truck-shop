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
  if(chartDom) {
    var myChart = echarts.init(chartDom);
    var option;
    var data = [120, 200, 150, 80, 70, 110, 120];

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
        data: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
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
