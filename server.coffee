// Module dependencies
express  = require 'express'
mongoose = require 'mongoose'
redis		 = require 'connect-redis'
configDB = require './config/database.coffee'
app 		 = express()
port 		 = process.env.PORT || 8080
passport = require 'passport'
flash		 = require 'connect-flash'

// Establish DB Connection
mongoose.connect(configDB.url)

// Use Passport configuration
require('./config/passport')(passport)

// Set render engine
app.engine "hamlc", require("haml-coffee").__express

// All Environments
app.configure ->
	app.set 'view engine', 'hamlc'
	app.set 'views', "#{__dirname}/views"
	app.use express.favicon()
	app.use express.logger()
	app.use express.bodyDecoder()
	app.use express.cookieDecoder()
	app.use express.session(
		secret: "thisissomerandomsecretstring"
	)
	app.use app.router
	// Passport configuration
	app.use passport.initialize()
	app.use passport.session()
	app.use flash()

// Development
app.configure 'development', ->
	app.use express.errorHandler(
		dumpExceptions: true
		showStack: true
	)

// Production
app.configure 'production', ->
	app.use express.errorHandler()

// Locate Routes
require('./app/routes.coffee')(app, passport)

// Launch Server
app.listen(port)
console.log 'This application is running on port ' + port