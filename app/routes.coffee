// Routes
module.exports = (app, passport) ->
	
	app.get '/', (req, res) ->
		res.render 'index.jade'
		return

	app.post '/login', passport.authenticate("local-login",
		successRedirect: '/profile'
		failureRedirect: '/login'
		failureFlash: true
	)

	app.post '/signup', passport.authenticate("local-signup",
		successRedirect: "/profile"
		failureRedirect: "/signup"
		failureFlash: true
	)

	app.get '/profile', isLoggedIn, (req, res) ->
		res.render 'profile.jade',
			user: req.user
		return

	app.get '/logout', (req, res) ->
		req.logout()
		res.redirect '/'
		return

// Middleware configuration
isLoggedIn = (req, res, next) ->
	return next() if req.isAuthenticated
	res.redirect '/'
	return