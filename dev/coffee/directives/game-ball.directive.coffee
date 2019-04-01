
app.directive 'gameBall', ($timeout,$window) ->
	restrict: 'E'
	templateUrl: 'directives/game-ball.directive.html'
	replace: true
	scope:
		game: "="
	link: ($scope,$el) ->


		$scope.game.ball = 
			size: $el[0].offsetWidth
			velocity: 8
			pixelAument: 2

			position:
				x: 0
				y: 0

			direction:
				x: 1
				y: 1

			reset: ->
				this.position.x = $window.innerWidth / 2 - this.size / 2
				this.position.y = $window.innerHeight / 2 -this.size / 2
				this.moving = false
				$timeout ->
					$scope.game.ball.moving = true
				,1000

			move: ->


				# Case: lose in X // add score

				if this.position.x < 0 - this.size - 50
					$scope.game.players.right.score++
					$scope.game.ball.reset()
					this.direction.x = 1

				if this.position.x > $window.innerWidth + 50
					$scope.game.players.left.score++
					$scope.game.ball.reset()
					this.direction.x = -1 


				# Case: bounce in Y

				if this.position.y < 0
					this.direction.y = 1

				if this.position.y > $window.innerHeight - this.size
					this.direction.y = -1


				# Case: bounce in racket

				lp = $scope.game.players.left.position
				rp = $scope.game.players.right.position

				if (this.position.x <= 60 && this.position.x >= 50) && (this.position.y > lp && this.position.y < lp + 100)
					this.direction.x = 1

				if (this.position.x <= ($window.innerWidth-50-this.size) && this.position.x >= ($window.innerWidth-60-this.size)) && (this.position.y > rp && this.position.y < rp + 100)
					this.direction.x = -1


				# New position for ball

				newPosX = this.position.x + this.pixelAument * this.direction.x
				newPosY = this.position.y + this.pixelAument * this.direction.y

				if this.moving
					this.position.x = newPosX
					this.position.y = newPosY

				$timeout ->
					$scope.game.ball.move()
				, $scope.game.ball.velocity


		$scope.game.ball.reset()
		$scope.game.ball.move()


