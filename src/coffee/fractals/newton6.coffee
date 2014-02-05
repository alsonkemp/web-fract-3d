class WebFract3D.Fractals.Newton6 extends WebFract3D.Fractals.Newton2
  poles: WebFract3D.Fractals.Base::makePoles 6

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

      # Build numerator z**6-1
      [tempr, tempi] = @complexMultiplication zr, zi, zr, zi
      [tempr, tempi] = @complexMultiplication tempr, tempi, zr, zi
      [numr,   numi] = @complexMultiplication tempr, tempi, tempr, tempi
      numr -= 1

      # Divide by denominator 6*z**5
      [denr, deni] = @complexMultiplication zr, zi, zr, zi
      [denr, deni] = @complexMultiplication denr, deni, zr, zi
      [denr, deni] = @complexMultiplication denr, deni, zr, zi
      [denr, deni] = @complexMultiplication 6*denr, 6*deni, zr, zi
      [z2r,   z2i] = @complexDivision numr, numi, denr, deni

      # Subtract from original
      z2r = zr - z2r
      z2i = zi - z2i
