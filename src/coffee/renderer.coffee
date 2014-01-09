class WebFract3D.Renderer
  constructor: () ->
    @renderer = new THREE.WebGLRenderer(canvas: $('#canvas')[0])
    @renderer.setSize window.innerWidth, window.innerHeight

    @camera = new THREE.PerspectiveCamera(70, window.innerWidth / window.innerHeight, 1, 1000)

    geometry = new THREE.Geometry()
    @mesh = new THREE.Mesh geometry

    @scene = new THREE.Scene()
    @scene.add @mesh

    #light = new THREE.PointLight( 0xffffff)
    #light.position.set( 0, 0, 300 )

    #@scene.add light
    window.addEventListener "resize", @onWindowResize, false

  onWindowResize: =>
    @camera.aspect = window.innerWidth / window.innerHeight
    @camera.updateProjectionMatrix()
    @renderer.setSize window.innerWidth, window.innerHeight

  redraw: () ->
    console.log "ViewState redraw"

  update: (view_state, fractal_state) =>
    if fractal_state.recalc
      @fractal = new WebFract3D.Fractals[fractal_state.fractal](view_state, fractal_state)
      @scene.remove @mesh

      @mesh = @getNewMesh view_state, fractal_state
      @scene.add @mesh

      fractal_state.recalc = false

    if view_state.redraw
      for v in ['x', 'y', 'z']
        @mesh.rotation[v] = view_state.rotation[v] / 180 * Math.PI
        @mesh.position[v] = view_state.position[v]
      view_state.recalc = false

    @renderer.render @scene, @camera

  getNewMesh: (view_state, fractal_state)->
    geometry = new THREE.Geometry()
    color_f = WebFract3D.ColorFunctions[fractal_state.fractal] view_state, fractal_state, @fractal
    depth_f = WebFract3D.DepthFunctions[fractal_state.fractal] @fractal.min_iterations, @fractal.max_iterations, @fractal

    min = view_state.size / -2
    inc = view_state.size / fractal_state.divisions
    y = min
    v = 0
    # shorthand
    points = @fractal.points
    for _y in [1..fractal_state.divisions]
      x = min
      for _x in [1..fractal_state.divisions]
        buildVertex = (dx,dy) =>
          [i, zr, zi] = points[_y + dy][_x + dx]
          d = depth_f i
          geometry.vertices.push(new THREE.Vector3(x + dx*inc, y + dy*inc,d * view_state.size))
          c = new THREE.Color('0xffffff')
          c.setRGB.apply c, color_f(i, zr, zi)
          f.vertexColors.push c

        # First triangle
        f = new THREE.Face3( v++, v++, v++ )
        buildVertex -1, -1
        buildVertex  0, -1
        buildVertex -1,  0
        geometry.faces.push f

        # Second triangle
        f = new THREE.Face3( v++, v++, v++ )
        buildVertex  0,  0
        buildVertex -1,  0
        buildVertex  0, -1
        geometry.faces.push f

        x += inc
      y += inc
    new THREE.Mesh(
          geometry,
          new THREE.MeshBasicMaterial( { side: THREE.DoubleSide, vertexColors: THREE.VertexColors } ))


