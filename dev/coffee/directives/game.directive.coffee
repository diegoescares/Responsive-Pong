
app.directive 'game', ($document,$window) -> 
	restrict: 'E'
	templateUrl: 'directives/game.directive.html'
	replace: true
	link: ($scope,el) ->

		# Game main object

		$scope.game = 
			players: {}
			playing: false


		# Grid

		$scope.grid = []

		for i in [1..50]
			$scope.grid.push true


		# Keydown event

		$document[0].onkeydown = (e) ->

			switch e.key
				when "w"         then $scope.game.players.left.move.up()
				when "s"         then $scope.game.players.left.move.down()
				when "ArrowUp"   then $scope.game.players.right.move.up()
				when "ArrowDown" then $scope.game.players.right.move.down()
