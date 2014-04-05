mongoose = require 'mongoose'
bcrypt = require 'bcrypt-nodejs'

userSchema = mongoose.schema(

	local:
		email: String
		password: String

	facebook:
		id: String
		token: String
		email: String
		name: String

	twitter:
		id: String
		token: String
		displayName: String
		username: String

	google:
		id: String
		token: String
		email: String
		name: String

)

// Generate a hash from password
userSchema.methods.generateHash = (password) ->
	bcrypt.hashSync password, bcrypt.genSaltSync(8), null

// Password validation
userSchema.methods.validPassword = (password) ->
	bcrypt.compareSync password, @local.password

// Create Model
module.exports = mongoose.model 'User', userSchema