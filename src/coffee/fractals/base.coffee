# Storing commonly used functions on the base object...
# Should probably create seperate base classes...
class WebFract3D.Fractals.Base
  constructor: (view_state_service, fractal_state_service) ->
    @points = []
    @depths = []
    @view_state = view_state_service.state
    @fractal_state = fractal_state_service.state
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

  makePoles: (num) ->
    poles = []
    for n in [0...num]
      rot = 2 * Math.PI * n / num
      poles.push [Math.cos(rot), Math.sin(rot)]
    poles

  # These should not be here.  TODO: Factor them out.
  depthFunction: (iter) ->
    @view_state.size \
    * (0.5 - Math.log(iter  + 1 - @min_iterations) \
    / Math.log(@max_iterations - @min_iterations))

  mandelColorFunction: (iter) ->
    if iter == @fractal_state.max_iterations
      [0,0,0]
    else if (iter % 120 < 20)
      [0.2+(iter % 120)/25.0, 0, 0]
    else if ( ((iter % 120) >= 20) && ((iter % 120) <40) )
      [1, 0.2+(iter % 120)/25, 0, 0]
    else if ( ((iter % 120) >= 40) && ((iter % 120) <60) )
      [1.0-((iter%120)-40)/20, 1, 0]
    else if ( ((iter % 120) >= 60) && ((iter % 120) <80) )
      [0, 1, 0.2+((iter%120)-60)/25]
    else if ( ((iter % 120) >= 80) && ((iter % 120) <100) )
      [0, 1-((iter%120)-80)/20, 1]
    else
      [0, 0, 1-((iter%120)-100)/20]

  newtonColors: [
      [0.0,0.0,0.0],
      [1.0,0.0,0.0],
      [0.0,1.0,0.0],
      [0.0,0.0,1.0],
      [1.0,1.0,0.0],
      [0.0,1.0,1.0],
      [1.0,0.0,1.0],
      [1.0,1.0,0.5],
      [0.5,1.0,1.0],
      [1.0,0.5,1.0]
      [0.7,0.7,1.0]
    ]
  newtonCloseDistance: 0.01
  newtonColorFunction: (iter, zr, zi) ->
      for p, idx in @poles
        r = p[0] - zr
        i = p[1] - zi
        if Math.sqrt(r*r + i*i) < @newtonCloseDistance
          return @newtonColors[idx+1]
      return @newtonColors[0]
