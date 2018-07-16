// A class definition. Inherits from Object by default.
// Save this some place where SuperCollider can find it,
// dir for user extensions
// Platform.userExtensionDir
// dir for all users on the machine
// Platform.systemExtensionDir

MyClass {

	// Instance properties
	// prefixing with "<" creates a getter
	// prefixing with ">" creates a setter
	// prefixing with "<>" creates both
	var <>myProperty;

	*new {|myProperty=10|
		^super.newCopyArgs(myProperty);
	}

	// Methods prefixed with "*" are class methods
	*classMethod {
		|myArg=123|

		// prefix with "^" to return a value. If none, returns the object.
		^(myArg*2);
	}

	instanceMethod {
		|myArg=321|
		^((myArg*2) + myProperty);
	}
}