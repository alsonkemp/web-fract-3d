WebFract3D.factory "FractalStateService", ($rootScope) ->
  @state = {}
  fresh_state =
      fractal: 'Mandelbrot'
      fractals: [
        'Mandelbrot',
        'MandelbrotPlus',
        'HalfMandelbrot',
        'InvertedMandelbrot',
        'Mandelbrot3',
        'Mandelbrot4',
        'Mandelbrot5',
        'Newton2',
        'Newton3',
        'Newton4',
        'Newton6',
        'Newton10'
        ]
      r: 0
      i: 0
      size: 4
      divisions: 50
      aspect_ratio: (window.innerWidth-300)/window.innerHeight
      max_iterations: 300

  @reset = () =>
    # Don't reset the fractal, though
    f = @state.fractal
    _.extend @state, fresh_state
    @state.fractal = f

  # Make this watchable and set the initial state
  $rootScope.FractalStateService = this
  @reset()
  this
