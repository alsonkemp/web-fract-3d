WebFract3D.factory "ViewStateService", ($rootScope) ->
  @state = {}
  fresh_state =
    position: x: 0, y: 40, z: 700
    rotation: x: -30, y: 0, z: 0
    size: 400

  @reset = () =>
    _.extend @state, fresh_state

  # Make this watchable and set the initial state
  $rootScope.ViewStateService = this
  @reset()
  this
