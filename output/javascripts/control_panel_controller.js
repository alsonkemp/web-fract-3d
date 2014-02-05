// Generated by CoffeeScript 1.6.3
(function() {
  WebFract3D.controller('ControlPanelCtrl', function($scope, $location, $window, ViewStateService, FractalStateService, RendererService, $rootScope) {
    var k, v, _ref,
      _this = this;
    _.extend($scope, {
      fractal_state: FractalStateService.state,
      view_state: ViewStateService.state,
      handleKeypresses: false,
      doHandleKeyPresses: function() {
        return $scope.handleKeyPresses = true;
      },
      doNotHandleKeyPresses: function() {
        return $scope.handleKeyPresses = false;
      },
      handleKeyPress: function(evt) {
        var ch, fs, vs;
        if (!$scope.handleKeyPresses) {
          return;
        }
        ch = String.fromCharCode(evt.keyCode);
        fs = FractalStateService.state;
        switch (ch) {
          case '[':
            fs.divisions /= 2;
            if (fs.divisions < 8) {
              fs.divisions = 8;
            }
            break;
          case ']':
            fs.divisions *= 2;
        }
        switch (evt.keyCode) {
          case 33:
            fs.size /= 1.1;
            break;
          case 34:
            fs.size *= 1.1;
            break;
          case 40:
            fs.i -= fs.size * 0.1;
            break;
          case 38:
            fs.i += fs.size * 0.1;
            break;
          case 37:
            fs.r -= fs.size * 0.1;
            break;
          case 39:
            fs.r += fs.size * 0.1;
        }
        vs = ViewStateService.state;
        switch (ch) {
          case '*':
            vs.position.z -= 1;
            break;
          case '/':
            vs.position.z += 1;
            break;
          case 'i':
            vs.rotation.x -= 2.0;
            break;
          case 'k':
            vs.rotation.x += 2.0;
            break;
          case 'j':
            vs.rotation.y += 2.0;
            break;
          case 'l':
            vs.rotation.y -= 2.0;
            break;
          case 'u':
            vs.rotation.z += 2.0;
            break;
          case 'o':
            vs.rotation.z -= 2.0;
        }
        return $rootScope.$digest();
      }
    });
    $window.onkeydown = $scope.handleKeyPress;
    $window.onkeypress = $scope.handleKeyPress;
    _ref = $location.search();
    for (k in _ref) {
      v = _ref[k];
      if (!isNaN(parseFloat(v)) && isFinite(v)) {
        FractalStateService.state[k] = Number(v);
      } else {
        FractalStateService.state[k] = v;
      }
    }
    return $rootScope.$watch('FractalStateService.state.fractal', function() {
      ViewStateService.reset();
      if (!FractalStateService.state.fractal) {
        return FractalStateService.reset();
      }
    });
  });

}).call(this);
