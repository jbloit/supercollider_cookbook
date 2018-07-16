// MyClass.sc should be saved in one of these folders:
// dir for user extensions
Platform.userExtensionDir
// dir for all users on the machine
Platform.systemExtensionDir


a= MyClass.new(myProperty:20);
a.instanceMethod;
a.myProperty = 30;
a.myProperty;
a.instanceMethod;
MyClass.classMethod;
