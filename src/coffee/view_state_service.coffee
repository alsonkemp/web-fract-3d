WebFract3D.factory "ViewStateService", ($rootScope) ->
  fresh_state =
    position: x: 0, y: -100, z: 800
    rotation: x: -40, y: 0, z: 0
    size: 800

  @reset = () =>
    @state = _.extend {}, fresh_state

  # Make this watchable and set the initial state
  $rootScope.ViewStateService = this
  @reset()
  this
