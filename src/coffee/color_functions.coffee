WebFract3D.ColorFunctions =
  Mandelbrot: (view_state, fractal_state) ->
    (iter) ->
      if iter == fractal_state.max_iterations
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

  Newton2: (view_state, fractal_state, fractal) ->
    blank = [0,0,0]
    colors = [
      [1.0,0.0,0.0],
      [0.0,1.0,0.0],
      [0.0,0.0,1.0],
      [0.5,0.5,0.0],
      [0.0,0.5,0.5],
      [0.5,0.0,0.5]
    ]
    closeDistance = 0.01
    (iter, zr, zi) ->
      for p, idx in fractal.poles
        r = p[0] - zr
        i = p[1] - zi
        if Math.sqrt(r*r + i*i) < closeDistance
          return colors[idx]
      return blank

WebFract3D.ColorFunctions.Mandelbrot3 = WebFract3D.ColorFunctions.Mandelbrot
WebFract3D.ColorFunctions.Newton3     = WebFract3D.ColorFunctions.Newton2
WebFract3D.ColorFunctions.Newton4     = WebFract3D.ColorFunctions.Newton2
WebFract3D.ColorFunctions.Newton5     = WebFract3D.ColorFunctions.Newton2
WebFract3D.ColorFunctions.Newton6     = WebFract3D.ColorFunctions.Newton2

