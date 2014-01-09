class WebFract3D.Fractals.Newton3 extends WebFract3D.Fractals.Base
  poles: [[1,0],[-0.5, 0.866025404],[-0.5, -0.866025404]]

  calculate: (r,i) ->
    zr  = 10
    zi  = 10
    z2r = r
    z2i = i
    # loop forever.  Return when happy.
    for a in [0..100000000]
      if a > (@fractal_state.max_iterations-1) or
         @complexDistance(zr, zi, z2r, z2i) < @quittingDistance
        return [a, zr, zi]
      zr = z2r
      zi = z2i

      # Build numerator z**3-1
      [tempr, tempi] = @complexMultiplication zr, zi, zr, zi
      [numr,   numi] = @complexMultiplication tempr, tempi, zr, zi
      numr -= 1

      # Divide by denominator 3*z**2
      [denr, deni] = @complexMultiplication 3*zr, 3*zi, zr, zi
      [z2r,   z2i] = @complexDivision numr, numi, denr, deni

      # Subtract from original
      z2r = zr - z2r
      z2i = zi - z2i
