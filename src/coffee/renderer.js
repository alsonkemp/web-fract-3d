// Generated by CoffeeScript 1.6.3
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  WebFract3D.Renderer = (function() {
    function Renderer() {
      this.update = __bind(this.update, this);
      this.onWindowResize = __bind(this.onWindowResize, this);
      var geometry;
      this.renderer = new THREE.WebGLRenderer({
        canvas: $('#canvas')[0]
      });
      this.renderer.setSize(window.innerWidth, window.innerHeight);
      this.camera = new THREE.PerspectiveCamera(70, window.innerWidth / window.innerHeight, 1, 1000);
      geometry = new THREE.Geometry();
      this.mesh = new THREE.Mesh(geometry);
      this.scene = new THREE.Scene();
      this.scene.add(this.mesh);
      window.addEventListener("resize", this.onWindowResize, false);
    }

    Renderer.prototype.onWindowResize = function() {
      this.camera.aspect = window.innerWidth / window.innerHeight;
      this.camera.updateProjectionMatrix();
      return this.renderer.setSize(window.innerWidth, window.innerHeight);
    };

    Renderer.prototype.redraw = function() {
      return console.log("ViewState redraw");
    };

    Renderer.prototype.update = function(view_state, fractal_state) {
      var v, _i, _len, _ref;
      if (fractal_state.recalc) {
        this.fractal = new WebFract3D.Fractals[fractal_state.fractal](view_state, fractal_state);
        this.scene.remove(this.mesh);
        this.mesh = this.getNewMesh(view_state, fractal_state);
        this.scene.add(this.mesh);
        fractal_state.recalc = false;
      }
      if (view_state.redraw) {
        _ref = ['x', 'y', 'z'];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          v = _ref[_i];
          this.mesh.rotation[v] = view_state.rotation[v] / 180 * Math.PI;
          this.mesh.position[v] = view_state.position[v];
        }
        view_state.recalc = false;
      }
      return this.renderer.render(this.scene, this.camera);
    };

    Renderer.prototype.getNewMesh = function(view_state, fractal_state) {
      var buildVertex, color_f, depth_f, f, geometry, inc, min, points, v, x, y, _i, _j, _ref, _ref1, _x, _y,
        _this = this;
      geometry = new THREE.Geometry();
      color_f = WebFract3D.ColorFunctions[fractal_state.fractal](view_state, fractal_state, this.fractal);
      depth_f = WebFract3D.DepthFunctions[fractal_state.fractal](this.fractal.min_iterations, this.fractal.max_iterations, this.fractal);
      min = view_state.size / -2;
      inc = view_state.size / fractal_state.divisions;
      y = min;
      v = 0;
      points = this.fractal.points;
      for (_y = _i = 1, _ref = fractal_state.divisions; 1 <= _ref ? _i <= _ref : _i >= _ref; _y = 1 <= _ref ? ++_i : --_i) {
        x = min;
        for (_x = _j = 1, _ref1 = fractal_state.divisions; 1 <= _ref1 ? _j <= _ref1 : _j >= _ref1; _x = 1 <= _ref1 ? ++_j : --_j) {
          buildVertex = function(dx, dy) {
            var c, d, i, zi, zr, _ref2;
            _ref2 = points[_y + dy][_x + dx], i = _ref2[0], zr = _ref2[1], zi = _ref2[2];
            d = depth_f(i);
            geometry.vertices.push(new THREE.Vector3(x + dx * inc, y + dy * inc, d * view_state.size));
            c = new THREE.Color('0xffffff');
            c.setRGB.apply(c, color_f(i, zr, zi));
            return f.vertexColors.push(c);
          };
          f = new THREE.Face3(v++, v++, v++);
          buildVertex(-1, -1);
          buildVertex(0, -1);
          buildVertex(-1, 0);
          geometry.faces.push(f);
          f = new THREE.Face3(v++, v++, v++);
          buildVertex(0, 0);
          buildVertex(-1, 0);
          buildVertex(0, -1);
          geometry.faces.push(f);
          x += inc;
        }
        y += inc;
      }
      return new THREE.Mesh(geometry, new THREE.MeshBasicMaterial({
        side: THREE.DoubleSide,
        vertexColors: THREE.VertexColors
      }));
    };

    return Renderer;

  })();

}).call(this);
