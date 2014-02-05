WebFract3D.factory "RendererService", ($rootScope, $location,
                                      ViewStateService, FractalStateService)->

  onWindowResize = =>
    @camera.aspect = window.innerWidth / window.innerHeight
    @camera.updateProjectionMatrix()
    @webgl_renderer.setSize window.innerWidth, window.innerHeight

  @recalc = () =>
    if not FractalStateService.state.fractal
      return
    @fractal = new WebFract3D.Fractals[FractalStateService.state.fractal](
                     ViewStateService, FractalStateService)
    @scene.remove @mesh

    @mesh = @getNewMesh()
    @scene.add @mesh
    @redraw()

    # Set the URL to reflect the state (minus the fractals list)
    _search = _.extend {}, FractalStateService.state
    delete _search['fractals']
    $location.search(_search)

  @redraw = () =>
    vss = ViewStateService.state
    for v in ['x', 'y', 'z']
      @mesh.rotation[v] = vss.rotation[v] / 180 * Math.PI
      @camera.position[v] = vss.position[v]
    @webgl_renderer.render @scene, @camera

  @getNewMesh = ()->
    fss = FractalStateService.state
    vss = ViewStateService.state

    geometry = new THREE.Geometry()

    aspect_ratio = (window.innerWidth-300) / window.innerHeight
    ymin = vss.size / -2
    yinc = vss.size / fss.divisions
    xmin = ymin * aspect_ratio
    xinc = yinc * aspect_ratio
    y = ymin
    v = 0
    # shorthand
    points = @fractal.points
    for _y in [1..fss.divisions]
      x = xmin
      for _x in [1..fss.divisions]
        buildVertex = (dx,dy) =>
          [i, zr, zi] = points[_y + dy][_x + dx]
          d = @fractal.depthFunction i
          geometry.vertices.push(new THREE.Vector3(x + dx*xinc, y + dy*yinc, d))
          c = new THREE.Color('0xffffff')
          c.setRGB.apply c, @fractal.colorFunction(i, zr, zi)
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

        x += xinc
      y += yinc
    new THREE.Mesh(
          geometry,
          new THREE.MeshBasicMaterial( { side: THREE.DoubleSide, vertexColors: THREE.VertexColors } ))

  #build the WebGL renderer
  @webgl_renderer = new THREE.WebGLRenderer(canvas: $('#canvas')[0])
  @webgl_renderer.setSize window.innerWidth-300, window.innerHeight

  @camera = new THREE.PerspectiveCamera(45, window.innerWidth / window.innerHeight, 1, 2000)
  geometry = new THREE.Geometry()
  @mesh = new THREE.Mesh geometry

  @scene = new THREE.Scene()
  @scene.add @mesh
  @scene.add @camera

  window.addEventListener "resize", @onWindowResize, false

  $rootScope.$watch("FractalStateService.state", @recalc, true)
  $rootScope.$watch("ViewStateService.state",    @redraw, true)
  this
