class WebFract3D.Fractals.Base
  constructor: (view_state, fractal_state) ->
    @points = []
    @depths = []
    @view_state = view_state
    @fractal_state = fractal_state
    @max_iterations = 0
    @min_iterations = 10000
    @run()

  quittingDistance: 0.01
  calculate: () ->
    if not @alerted
      alert "Base fractal doesn't implement calculate"
    @alerted = true

  run: () ->
    inc = @fractal_state.size / @fractal_state.divisions

    # Loop over i first, then over r
    i = @fractal_state.i - @fractal_state.size/2
    for y in [0..@fractal_state.divisions]
      @points.push []
      r = @fractal_state.r - @fractal_state.size/2
      for x in [0..@fractal_state.divisions]
        [iterations, zr, zi] = @calculate(r,i,@fractal_state)
        @points[y].push [iterations, zr, zi]
        @max_iterations = iterations if iterations > @max_iterations
        @min_iterations = iterations if iterations < @min_iterations
        r += inc
      i += inc

  complexDivision: (numR, numI, denR, denI) ->
    divisor = denR*denR + denI*denI
    return [
      (numR*denR + numI*denI) / divisor,
      (numI*denR - numR*denI) / divisor
    ]

  complexDistance: (r1, i1, r2, i2) ->
    r = r1 - r2
    i = i1 - i2
    return Math.sqrt(r*r + i*i)

  complexMultiplication: (r1, i1, r2, i2) ->
    return [
      r1*r2 - i1*i2,
      r1*i2 + r2*i1
    ]
