class WebFract3D.Fractals.Mandelbrot3 extends WebFract3D.Fractals.Base
  calculate: (r,i) ->
    zr = 0
    zi = 0
    for a in [0..@fractal_state.max_iterations-1]
      _zr = zr*zr*zr - 3*zr*zi*zi + r
      _zi = 3*zr*zr*zi - zi*zi*zi + i
      zr = _zr
      zi = _zi
      if zr*zr+zi*zi > 4
        return a
    return a


