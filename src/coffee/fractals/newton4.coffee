class WebFract3D.Fractals.Newton4 extends WebFract3D.Fractals.Base
  poles: [[1,0],[-1,0],[0,1],[0,-1]]

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

      # Build numerator z**4-1
      [tempr, tempi] = @complexMultiplication zr, zi, zr, zi
      [tempr, tempi] = @complexMultiplication tempr, tempi, zr, zi
      [numr,   numi] = @complexMultiplication tempr, tempi, zr, zi
      numr -= 1

      # Divide by denominator 4*z**3
      [denr, deni] = @complexMultiplication 4*zr, 4*zi, zr, zi
      [denr, deni] = @complexMultiplication denr, deni, zr, zi
      [z2r,   z2i] = @complexDivision numr, numi, denr, deni

      # Subtract from original
      z2r = zr - z2r
      z2i = zi - z2i
