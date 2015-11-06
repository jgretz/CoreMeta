CoreMeta
============
CoreMeta is a lightweight framework written in Swift that provides Inversion of Control and Dependency Injection for iOS apps.

Written for [Truefit](http://www.truefit.io) mainly by [Josh Gretz](http://www.gretzlab.com). You can take a look at [iOS Conf](https://github.com/jgretz/iosconf) to see an example project.

Getting Started
-----------
### Overview
You can learn more about IOC / DI out on the [internet](https://en.wikipedia.org/wiki/Inversion_of_control), but in general, its an approach that allows your code to be decoupled 

### Installation
#### As a Cocoa Pod
[![Version](https://img.shields.io/cocoapods/v/CoreMeta.svg?style=flat)](http://cocoapods.org/pods/CoreMeta)
[![License](https://img.shields.io/cocoapods/l/CoreMeta.svg?style=flat)](http://cocoapods.org/pods/CoreMeta)
[![Platform](https://img.shields.io/cocoapods/p/CoreMeta.svg?style=flat)](http://cocoapods.org/pods/CoreMeta)

CoreMeta is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```
pod "CoreMeta"
```

#### As a submodule
+ You can clone this repo down and add it as a submodule to your existing git project. I tend to like to stick all of my submodules in a submodules folder.

```
$ git submodule add https://github.com/jgretz/CoreMeta.git
```

+ Open your project, and drag CoreMeta.xcodeproj into your project tree
+ Add CoreMeta as a linked framework:
	+ Click on your project in the tree
	+ Select the general tab
	+ Scroll down to Linked Frameworks and Libraries
	+ Click on the plus sign
	+ Select CoreMeta.framework from the list

### Writing an injectable class and/or protocol
Unfortunately, Swift has yet to catch up when it comes to introspection (or frankly even begin it at all). As such, we still need to rely on the introspection methods that come with NSObject. This means that you will need to derive your classes from NSObject, and mark your protocols with @objc.

### Choosing a container pattern
In general, I have found that you will have one container per project and you want this container to be a shared single instance. Although it does break encapsulation a litt, if you accept this approach, there are some nice syntatic sugar methods I can provide that make the configuration code very readable. This is a trade off, I and my team, are generally willing to make.

That said, I don't want to paint you into that corner, so CMContainer implements CMContainerProtocol. You can then choose to manually create your container, and have it inject itself only to the objects whom you choose to expose the property on.

### Configuring the container
Once instantiated (whether using the singleton the framework provides or your own), you need to configure the container. Although you can ask the container for an object of any type and it will create it for you, it will only inject the classes and protocols that you have configured. 

#### Class Registration
To register a class to be configured, you can call register on the container:

```
container.registerClass(Foo.self)
```

alternatively if you are using the singleton container, you can register the class in a way that I find more readable: 

```
Foo.register()
```

Additionally, there are method overloads to tell the container to cache the object (useful for repositories and other stateful objects) and to provide the container with a closure to execute after everytime the object is created.

#### Protocol Registration
If you prefer to use protocols to decouple your code (see [SOLID](https://en.wikipedia.org/wiki/SOLID_(object-oriented_design))), CoreMeta supports that too. You will need to inform the container which class implements each protocol that you intend for the container to inject.

To define this:

```
container.registerClassAsProtocol(Foo.self, p: Bar.self)
```

or alternatively

```
Foo.registerClassAsProtocol(Bar.self)
```

#### Type Redirection
Sometimes it is useful to ask for a base type and receive back a derived class instance. For example, you may have a slightly different implementation of a class for iPhone and iPad, but the majority of the logic is the same. You can at configuration time, tell the container to return the proper implementation for the base class request.

```
container.registerClassAsClass(iPadFoo.self, replacedClass: Foo.self)
```

or alternatively

```
iPadFoo.registerClassAsClass(Foo.self)
```

#### Autoregistration
As an alternative to having a single class that contains all of the registration info (which is what I generally prefer), you can have each class declare that it should be registered by implementing the CMContainerAutoRegister protocol. 

You then simply need to call the autoregister method on the container you are using

### Creating an object
The vast majority of times the container will be creating objects for you will be to inject them into other objects. That said, there are times when you need to manually create an object (whether it be the first object in a chain or for some reason you want the lifetime scope of an instance to be constrained). 

The following are a couple examples of code to create an object (apply to your situation as applicable):

```
let foo = container.objectForType(Foo.self)
```

```
let foo:Foo = container.objectForType()
```

```
let foo:Foo = Foo.object()
```

A quick note on protocols, since I can't guarantee that you have configured the protocol, I have to return it as an Optional. This does mean you need to unwrap it.

```
let foo = container.objectForProtocol(Bar.self)!
```

```
let foo = NSObject.objectForProtocol(Bar.self)!
```

### Property Injection
Having the container inject the properties onto an object is pretty straight forward. Any property that meets the following criteria will be injected:

+ Declared as var
+ Class / Protocol implements NSObject / @objc
+ Class / Protocol is registered with the container

### Injection into an existing object
Any object that derives from NSObject can also be injected after it is instantiated. This mainly comes into play if you want to inject UIViewControllers and are using Storyboards.

Here are a couple of examples:

```
container.inject(foo)
```
```
foo.inject()
```

### Caching an object
There are times when you want to have a single instance of an object in memory and have all objects that need to access it to get that same object (repositories, settings, configuration, etc). Without using IOC / DI, you end up either have a ton of singleton objects or worse static globals all over the place. This is one of the great places CoreMeta can help you decouple your code.

Here are couple of examples of caching objects:

+ On Registration: by marking the class with ```cache: true```, the container will automatically cache the first instance of that class it creates.
+ After creation, you can put an object into the container by calling put: ```container.put()``` or ```foo.put()```

Other Thoughts:
----------
### Why Property Injection?
Often in IOC / DI discussions, you will find many who favor constructor injection to property injection. CoreMeta though, only supports property injection. I plan on writing a longer blog article on this topic, but in short here is the reasoning.

Although Swift and Objective-C don't have traditional constructors, they do generally use the init pattern (which in fact is enforced by Swift at compile time). Unfortunately although the introspection framework does allow the ability to find these methods, it does not record the types of the parameters at compile time. This means all the container (or any class) is told about the parameter list for a method is if the parameter is an object, struct, or value type. This means we can't match based on the current container configuration. Although, I did consider doing something with a naming convention, it just felt too hacky so I decided not to attempt it.

### Branches
Master has been updated to new Swift version of CoreMeta. This version was a complete rewrite (although I stole a lot of concepts from v1 obviously). Along the way, I added tests, class name prefixes, bug fixes and a protocol for the container itself. I also tried to write it in a way to reduce the need to cast everything 

If you are looking for the original version that was written in objective-c, you can find it in the [v1.0-objc branch](https://github.com/jgretz/CoreMeta/tree/v1.0-objc)

License
=========

Copyright 2011 TrueFit Solutions

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.