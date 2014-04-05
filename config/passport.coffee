LocalStrategy = require('passport-local').Strategy
User = require '../app/models/user.coffee'

module.exports = (passport) ->
	
	// Initialize Passport Session
	passport.serializeUser (user, done) ->
		done null, user.id
		return

	passport.deserializeUser (id, done) ->
		User.findById id, (err, user) ->
			done err, user
			return
		return

	// Local Signup
	passport.use 'local-signup', new LocalStrategy(
		usernameField: 'email'
		passwordField: 'password'
		passReqToCallback: true
	, (req, email, password, done) ->
		process.nextTick ->
			User.findOne
				"local.email": email
			, (err, user) ->
				return done(err) if err

				if user
					done null, false, req.flash("signupMessage", "This email is already taken.")
				else
					newUser = new User()

					newUser.local.email = email
					newUser.local.password = newUser.generateHash(password)

					newUser.save (err) ->
						throw err if err
						done null, newUser

				return
			return
		return
	)

	// Local Login
	passport.use "local-login", new LocalStrategy(
		usernameField: "email"
		passwordField: "password"
		passReqToCallback: true
	, (req, email, password, done) ->
		User.findOne
			"local.email": email
		, (err, user) ->
			return done(err) if err
			return done(null, false, req.flash("loginMessage", "No user found.")) unless user
			return done(null, false, req.flash("loginMessage", "Wrong password!")) unless user.validPassword(password)
			done null, user
			
		return
	)