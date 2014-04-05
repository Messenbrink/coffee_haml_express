// Setup AngularJS application
mean = angular.module("mean", [])

// Routes
mean.config ($routeProvider) ->

	$routeProvider.when '/login',
		templateUrl: '../../views/templates/login.hamlc'
		controller: 'LoginController'
	return

	$routeProvider.when '/signup',
		templateUrl: '../../views/templates/signup.hamlc'
		controller: 'SignupController'
	return

	$routeProvider.when '/profile',
		templateUrl: '../../views/templates/profile.hamlc'
		controller: 'ProfileController'
	return

	$routeProvider.otherwise redirectTo: '/login'

// Controllers
mean.controller 'LoginController', ($scope) ->
	$scope.credentials =
		email: ""
		password: ""

mean.controller 'SignupController', ($scope) ->
	$scope.credentials =
		email: ""
		password: ""

mean.controller 'ProfileController', ($scope) ->