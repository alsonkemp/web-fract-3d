WebFract3D.controller 'ControlPanelCtrl', ($scope, $location, $window) ->
  @renderer = new WebFract3D.Renderer()
  _.extend $scope,
    expanded: true
    original_view_state:
      position: x: 0, y: 0, z: -500
      rotation: x: -30, y: 0, z: 0
      size: 800
      # Boolean to drive redraw of the ViewState.
      redraw: true
    original_fractal_state:
      fractal: 'Mandelbrot'
      r: 0
      i: 0
      size: 4
      divisions: 50
      max_iterations: 100
      # For Julias
      jr: 0
      ji: 0
      # Boolean to drive recalc of the fractal
      recalc: true


    # the keypresses when a user is using the control
    # panel trigger the hotkeys, only enable hotkeys
    # when the canvas if focused.
    handleKeypresses: false
    doHandleKeyPresses: -> 
      console.log "doHandleKeyPresses"
      $scope.handleKeyPresses = true
    doNotHandleKeyPresses: ->
      console.log "doNotHandleKeyPresses"
      $scope.handleKeyPresses = false
    handleKeyPress: (evt) ->
      return if not $scope.handleKeyPresses
      ch = String.fromCharCode(evt.keyCode)
      fs = $scope.fractal_state
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
        #when 'j' then fs.fractal = 'julia'

      # Special keys
      switch evt.keyCode
        when 33 then fs.size /= 1.1
        when 34 then fs.size *= 1.1
        when 40 then fs.i -= fs.size * 0.1 # down
        when 38 then fs.i += fs.size * 0.1 # up
        when 37 then fs.r -= fs.size * 0.1 # left
        when 39 then fs.r += fs.size * 0.1 # right


      vs = $scope.view_state
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
      $scope.$digest()

  # Deep watch on both view_state and fractal_state
  # and do a full redraw on changes
  $scope.$watch(
    'view_state',
    (() => 
      $scope.view_state.redraw = true
      @renderer.update($scope.view_state, $scope.fractal_state) if @renderer
    ),
    true)

  $scope.$watch(
    'fractal_state',
    (() =>
      $scope.fractal_state.recalc = true
      @renderer.update($scope.view_state, $scope.fractal_state) if @renderer
      $location.search $scope.fractal_state
    ),true)

  changeFractal = (newFractal) ->
    $scope.fractal_state.fractal = newFractal

  # Special keys need keydown?
  $window.onkeydown = $scope.handleKeyPress
  $window.onkeypress = $scope.handleKeyPress
  $scope.view_state = $scope.original_view_state
  $scope.fractal_state = $scope.original_fractal_state

  #splat on Fractal properties if we have them
  for k, v of $location.search()
    if !isNaN(parseFloat(v)) && isFinite(v)
      $scope.fractal_state[k] = Number(v)
    else 
      $scope.fractal_state[k] = v

