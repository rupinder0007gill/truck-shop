function camelize(str) {
  var text = str.replace(/[-_\s.]+(.)?/g, function (match, capture) {
    if (capture) {
      return capture.toUpperCase();
    }
    return '';
  });
  return "".concat(text.substr(0, 1).toLowerCase()).concat(text.substr(1));
};
/* ----------------------------- Colors function ---------------------------- */

function hexToRgb(hexValue) {
  var hex;
  hexValue.indexOf('#') === 0 ? hex = hexValue.substring(1) : hex = hexValue;
  // Expand shorthand form (e.g. "03F") to full form (e.g. "0033FF")
  var shorthandRegex = /^#?([a-f\d])([a-f\d])([a-f\d])$/i;
  var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex.replace(shorthandRegex, function (m, r, g, b) {
    return r + r + g + g + b + b;
  }));
  return result ? [parseInt(result[1], 16), parseInt(result[2], 16), parseInt(result[3], 16)] : null;
};

class EchartConfig {  
  start() {
    document.addEventListener("turbo:load", function() {
      var wrapper = document.querySelector('.echart-config')
      if(wrapper) {
        this.initialize()
      }
    }.bind(this))
  }

  initialize() {
    
    this.camelize();
  }

  
  getData(el, data) {
    try {
      return JSON.parse(el.dataset[this.camelize(data)]);
    } catch (e) {
      return el.dataset[camelize(data)];
    }
  };

  
  rgbaColor() {
    var color = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : '#fff';
    var alpha = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : 0.5;
    return "rgba(".concat(hexToRgb(color), ", ").concat(alpha, ")");
  };

  getColor(name) {
    var dom = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : document.documentElement;
    return getComputedStyle(dom).getPropertyValue("--falcon-".concat(name)).trim();
  };
  getColors(dom) {
    return {
      primary: this.getColor('primary', dom),
      secondary: this.getColor('secondary', dom),
      success: this.getColor('success', dom),
      info: this.getColor('info', dom),
      warning: this.getColor('warning', dom),
      danger: this.getColor('danger', dom),
      light: this.getColor('light', dom),
      dark: this.getColor('dark', dom),
      white: this.getColor('white', dom),
      black: this.getColor('black', dom),
      emphasis: this.getColor('emphasis-color', dom)
    };
  };

  getGrays(dom) {
    return {
      100: this.getColor('gray-100', dom),
      200: this.getColor('gray-200', dom),
      300: this.getColor('gray-300', dom),
      400: this.getColor('gray-400', dom),
      500: this.getColor('gray-500', dom),
      600: this.getColor('gray-600', dom),
      700: this.getColor('gray-700', dom),
      800: this.getColor('gray-800', dom),
      900: this.getColor('gray-900', dom),
      1000: this.getColor('gray-1000', dom),
      1100: this.getColor('gray-1100', dom)
    };
  };

  getPosition(pos, params, dom, rect, size) {
    return {
      top: pos[1] - size.contentSize[1] - 10,
      left: pos[0] - size.contentSize[0] / 2
    };
  };
  echartSetOption(chart, userOptions, getDefaultOptions) {
    var themeController = document.body;
    // Merge user options with lodash
    chart.setOption(window._.merge(getDefaultOptions(), userOptions));
    themeController.addEventListener('clickControl', function (_ref19) {
      var control = _ref19.detail.control;
      if (control === 'theme') {
        chart.setOption(window._.merge(getDefaultOptions(), userOptions));
      }
    });
  };
  utils = {
    // docReady: docReady,
    getData: this.getData,
    getGrays: this.getGrays,
    rgbaColor: this.rgbaColor,
    getColors: this.getColors,
    getColor: this.getColor,
  };
}

// Export the variable
export default EchartConfig