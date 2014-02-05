// Generated by CoffeeScript 1.6.3
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  WebFract3D.Fractals.InvertedMandelbrot = (function(_super) {
    __extends(InvertedMandelbrot, _super);

    function InvertedMandelbrot() {
      _ref = InvertedMandelbrot.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    InvertedMandelbrot.prototype.calculate = function(r, i) {
      var a, zi, zr, _i, _j, _r, _ref1, _ref2, _ref3;
      zr = 0;
      zi = 0;
      _ref1 = this.complexDivision(1, 0, r, i), _r = _ref1[0], _i = _ref1[1];
      for (a = _j = 0, _ref2 = this.fractal_state.max_iterations - 1; 0 <= _ref2 ? _j <= _ref2 : _j >= _ref2; a = 0 <= _ref2 ? ++_j : --_j) {
        _ref3 = this.complexMultiplication(zr, zi, zr, zi), zr = _ref3[0], zi = _ref3[1];
        zr += _r;
        zi += _i;
        if (zr * zr + zi * zi > 4) {
          return [a, zr, zi];
        }
      }
      return [a, zr, zi];
    };

    return InvertedMandelbrot;

  })(WebFract3D.Fractals.Mandelbrot);

}).call(this);
