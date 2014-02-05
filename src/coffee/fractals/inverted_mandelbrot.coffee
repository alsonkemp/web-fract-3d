class WebFract3D.Fractals.InvertedMandelbrot extends WebFract3D.Fractals.Mandelbrot
  calculate: (r,i) ->
    zr = 0
    zi = 0
    [_r,_i] = @complexDivision(1,0,r,i)
    for a in [0..@fractal_state.max_iterations-1]
      [zr, zi] = @complexMultiplication(zr, zi, zr, zi)
      zr += _r
      zi += _i
      if zr*zr+zi*zi > 4
        return [a, zr, zi]
    return [a, zr, zi]

