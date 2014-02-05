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
      var a, zi, zr, _i, _ref1, _ref2;
      zr = 0;
      zi = 0;
      for (a = _i = 0, _ref1 = this.fractal_state.max_iterations - 1; 0 <= _ref1 ? _i <= _ref1 : _i >= _ref1; a = 0 <= _ref1 ? ++_i : --_i) {
        _ref2 = this.complexMultiplication(zr, zi, zr, zi), zr = _ref2[0], zi = _ref2[1];
        zr += r;
        zi += i;
        if (zr * zr + zi * zi > 4) {
          return [a, zr, zi];
        }
      }
      return [a, zr, zi];
    };

    return InvertedMandelbrot;

  })(WebFract3D.Fractals.Base);

}).call(this);
