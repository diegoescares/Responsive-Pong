
app.directive 'gamePlayer', ($window) ->
	restrict: 'E'
	templateUrl: 'directives/game-player.directive.html'
	replace: true
	scope:
		game: "="
		spot: "@"
	link: ($scope,$el) ->

		pixelVelocity = 20

		$scope.player =
			score: 0
			position: $window.innerHeight / 2 - 50

		$scope.player.move =

			up: ->

				newPosition = $scope.player.position - pixelVelocity
				newPosition = 0 if newPosition < 0

				$scope.player.position = newPosition
				$scope.$apply()

			down: ->

				newPosition = $scope.player.position + pixelVelocity
				maxPosition = $el[0].offsetHeight - 100
				newPosition = maxPosition if newPosition > maxPosition
					
				$scope.player.position = newPosition
				$scope.$apply()

		$scope.game.players[$scope.spot] = $scope.player

