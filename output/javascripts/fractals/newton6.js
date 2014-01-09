// Generated by CoffeeScript 1.6.3
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  WebFract3D.Fractals.Newton6 = (function(_super) {
    __extends(Newton6, _super);

    function Newton6() {
      _ref = Newton6.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Newton6.prototype.poles = [[1, 0], [0.5, 0.866025404], [0.5, -0.866025404], [-1, 0], [-0.5, 0.866025404], [-0.5, -0.866025404]];

    Newton6.prototype.calculate = function(r, i) {
      var a, deni, denr, numi, numr, tempi, tempr, z2i, z2r, zi, zr, _i, _ref1, _ref2, _ref3, _ref4, _ref5, _ref6, _ref7, _ref8;
      zr = 10;
      zi = 10;
      z2r = r;
      z2i = i;
      for (a = _i = 0; _i <= 100000000; a = ++_i) {
        if (a > (this.fractal_state.max_iterations - 1) || this.complexDistance(zr, zi, z2r, z2i) < this.quittingDistance) {
          return [a, zr, zi];
        }
        zr = z2r;
        zi = z2i;
        _ref1 = this.complexMultiplication(zr, zi, zr, zi), tempr = _ref1[0], tempi = _ref1[1];
        _ref2 = this.complexMultiplication(tempr, tempi, zr, zi), tempr = _ref2[0], tempi = _ref2[1];
        _ref3 = this.complexMultiplication(tempr, tempi, tempr, tempi), numr = _ref3[0], numi = _ref3[1];
        numr -= 1;
        _ref4 = this.complexMultiplication(zr, zi, zr, zi), denr = _ref4[0], deni = _ref4[1];
        _ref5 = this.complexMultiplication(denr, deni, zr, zi), denr = _ref5[0], deni = _ref5[1];
        _ref6 = this.complexMultiplication(denr, deni, zr, zi), denr = _ref6[0], deni = _ref6[1];
        _ref7 = this.complexMultiplication(6 * denr, 6 * deni, zr, zi), denr = _ref7[0], deni = _ref7[1];
        _ref8 = this.complexDivision(numr, numi, denr, deni), z2r = _ref8[0], z2i = _ref8[1];
        z2r = zr - z2r;
        z2i = zi - z2i;
      }
    };

    return Newton6;

  })(WebFract3D.Fractals.Base);

}).call(this);
