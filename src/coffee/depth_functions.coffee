WebFract3D.DepthFunctions =
 Mandelbrot: (fractal, vss) ->
   min = fractal.min_iterations
   max = fractal.max_iterations
   depth = vss.state.size
   (iter) ->
     depth * (0 - Math.log(iter  + 1 - min) / Math.log(max - min))
     #depth * (0 - Math.sqrt((iter - min + 1.0) / (max - min)))
 Newton2: (min, max) ->
   min = fractal.min_iterations
   max = fractal.max_iterations
   (iter) ->
      # return 0.5 - Math.log(iter - min + 1.0) / Math.log(max - min)
      0 - (iter - min + 1.0) / (max - min)

WebFract3D.DepthFunctions.Mandelbrot3 = WebFract3D.DepthFunctions.Mandelbrot
WebFract3D.DepthFunctions.Newton3     = WebFract3D.DepthFunctions.Newton2
WebFract3D.DepthFunctions.Newton4     = WebFract3D.DepthFunctions.Newton2
WebFract3D.DepthFunctions.Newton5     = WebFract3D.DepthFunctions.Newton2
WebFract3D.DepthFunctions.Newton6     = WebFract3D.DepthFunctions.Newton2

