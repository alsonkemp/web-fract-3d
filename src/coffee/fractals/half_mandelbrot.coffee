class WebFract3D.Fractals.MandelbrotPlus extends WebFract3D.Fractals.Mandelbrot
  calculate: (r,i) ->
    zr = 0
    zi = 0
    for a in [0..@fractal_state.max_iterations-1]
      [zr, zi] = @complexMultiplication(zr/2, zi/2, zr, zi)
      zr += r
      zi += i
      if zr*zr+zi*zi > 4
        return [a, zr, zi]
    return [a, zr, zi]

