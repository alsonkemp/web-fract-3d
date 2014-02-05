class WebFract3D.Fractals.Newton2 extends WebFract3D.Fractals.Base
  colorFunction: WebFract3D.Fractals.Base::newtonColorFunction
  poles: [[1, 0], [-1,0]]

  calculate: (r,i) ->
    zr  = 10
    zi  = 10
    z2r = r
    z2i = i
    # loop forever.  Return when happy.
    for a in [0..100000000]
      if a > (@fractal_state.max_iterations-1)
        return [a, zr, zi]
      if @complexDistance(zr, zi, z2r, z2i) < @quittingDistance
        return [a, zr, zi]
      zr = z2r
      zi = z2i

      # Build numerator
      [numr, numi] = @complexMultiplication(zr, zi, zr, zi)
      numr -= 1

      # Divide by denominator
      [z2r, z2i] = @complexDivision numr, numi, 2*zr, 2*zi

      # Subtract from original
      z2r = zr - z2r
      z2i = zi - z2i
