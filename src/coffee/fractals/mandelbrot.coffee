class WebFract3D.Fractals.Mandelbrot extends WebFract3D.Fractals.Base
  calculate: (r,i) ->
    zr = 0
    zi = 0
    for a in [0..@fractal_state.max_iterations-1]
      [zr, zi] = @complexMultiplication(zr, zi, zr, zi)
      zr += r
      zi += i
      if zr*zr+zi*zi > 4
        return [a, zr, zi]
    return [a, zr, zi]

