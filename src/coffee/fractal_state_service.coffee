WebFract3D.factory "FractalStateService", ($rootScope) ->
  fresh_state =
      fractal: 'Mandelbrot'
      r: 0
      i: 0
      size: 4
      divisions: 50
      aspect_ratio: (window.innerWidth-300)/window.innerHeight
      max_iterations: 300
      # For Julias
      jr: 0
      ji: 0

  @reset = () =>
    @state = _.extend {}, fresh_state

  # Make this watchable and set the initial state
  $rootScope.FractalStateService = this
  @reset()
  this
