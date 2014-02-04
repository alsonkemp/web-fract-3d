WebFract3D.controller 'ControlPanelCtrl', ($scope, $location, $window,
    ViewStateService, FractalStateService, RendererService, $rootScope) ->
  _.extend $scope,
    # Need to reference these in the $scope so the view gets them
    fractal_state: FractalStateService.state
    view_state: ViewStateService.state

    # the keypresses when a user is using the control
    # panel trigger the hotkeys, only enable hotkeys
    # when the canvas if focused.
    handleKeypresses: false
    doHandleKeyPresses:    -> $scope.handleKeyPresses = true
    doNotHandleKeyPresses: -> $scope.handleKeyPresses = false
    handleKeyPress: (evt) ->
      return if not $scope.handleKeyPresses
      ch = String.fromCharCode(evt.keyCode)
      fs = FractalStateService.state
      switch ch
        when '['
          fs.divisions /= 2
          fs.divisions = 8 if fs.divisions < 8
        when ']' then fs.divisions *= 2
        when '1' then changeFractal('Mandelbrot')
        when '2' then changeFractal('Mandelbrot3')
        when '3' then changeFractal('Newton2')
        when '4' then changeFractal('Newton3')
        when '5' then changeFractal('Newton4')
        when '6' then changeFractal('Newton6')

      # Special keys
      switch evt.keyCode
        when 33 then fs.size /= 1.1
        when 34 then fs.size *= 1.1
        when 40 then fs.i -= fs.size * 0.1 # down
        when 38 then fs.i += fs.size * 0.1 # up
        when 37 then fs.r -= fs.size * 0.1 # left
        when 39 then fs.r += fs.size * 0.1 # right

      vs = ViewStateService.state
      switch ch
        when '*' then vs.position.z -= 1
        when '/' then vs.position.z += 1
        when 'i' then vs.rotation.x -= 2.0
        when 'k' then vs.rotation.x += 2.0
        when 'j' then vs.rotation.y += 2.0
        when 'l' then vs.rotation.y -= 2.0
        when 'u' then vs.rotation.z += 2.0
        when 'o' then vs.rotation.z -= 2.0
      # Need to digest explicitly since this event was not handled
      # by Angular
      $rootScope.$digest()

  changeFractal = (newFractal) ->
    # Set initial state
    ViewStateService.reset()
    FractalStateService.reset()

    FractalStateService.fractal = newFractal

  # Special keys need keydown?
  $window.onkeydown = $scope.handleKeyPress
  $window.onkeypress = $scope.handleKeyPress

  #splat on Fractal properties if they're in the URL
  for k, v of $location.search()
    if !isNaN(parseFloat(v)) && isFinite(v)
      FractalStateService.state[k] = Number(v)
    else 
      FractalStateService.state[k] = v
