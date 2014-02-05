class WebFract3D.Fractals.Newton10 extends WebFract3D.Fractals.Newton2
  poles: WebFract3D.Fractals.Base::makePoles 10

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

      # Build numerator z**10-1
      [tempr, tempi] = @complexMultiplication zr, zi, zr, zi  # 1+1
      [tempr, tempi] = @complexMultiplication tempr, tempi, zr, zi # 2+1
      [tempr, tempi] = @complexMultiplication tempr, tempi, zr, zi # 3+1
      [tempr, tempi] = @complexMultiplication tempr, tempi, zr, zi # 4+1
      [numr,   numi] = @complexMultiplication tempr, tempi, tempr, tempi # 5+5
      numr -= 1

      # Divide by denominator 10*z**9
      [denr, deni] = @complexMultiplication zr, zi, zr, zi # 1+1
      [denr, deni] = @complexMultiplication denr, deni, zr, zi # 2+1
      [denr, deni] = @complexMultiplication denr, deni, zr, zi # 3+1
      [denr, deni] = @complexMultiplication denr, deni, denr, deni # 4+4
      [denr, deni] = @complexMultiplication 10*denr, 10*deni, zr, zi # 8+1
      [z2r,   z2i] = @complexDivision numr, numi, denr, deni

      # Subtract from original
      z2r = zr - z2r
      z2i = zi - z2i
