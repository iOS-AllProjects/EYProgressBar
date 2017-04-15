EYProgressBar
==================

Custom progress bar written in swift 3.  
Fully customisable, comes in different styles! 

Screenshots
----
<a href="https://imgflip.com/gif/1lyqkg"><img src="https://i.imgflip.com/1lyqkg.gif" title="made at imgflip.com"/></a>
<a href="https://imgflip.com/gif/1m0zyp"><img src="https://i.imgflip.com/1m0zyp.gif" title="made at imgflip.com"/></a>

Install
-------

##### Requirements

- iOS 10.0+
- Swift 3.0+

##### Manual

Copy & paste `CustomProgressBar.swift` and `Extensions.swift` in your project
Create your own xib file and link the outlets 

##### CocoaPods 

[CocoaPods](https://cocoapods.org/) is a dependency manager for Cocoa projects. You can install it with the following command:

```
$ gem install cocoapods
```

To integrate EYProgressBar into your Xcode project using CocoaPods, specify it in your ```Podfile```:

```
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/iOS-AllProjects/EYProgressBar.git'

platform :ios, '10.0'
use_frameworks!

target '<Your Target Project Name>' do
pod 'EYProgressBar', '0.1.0'
end

```
<b>Or</b>

```
source 'https://github.com/iOS-AllProjects/EYProgressBar.git'

platform :ios, '10.0'
use_frameworks!
```

Usage
-----

Drag a `UIView` into your storyboard! Change the class to `CustomProgressBar`. The view will be updated! 


### Edit Dash Property Style according to preference!

``` swift
   backgroundCircleLayer.lineDashPattern = layerBackgroundDash ? [2,6] : nil
   //The first number specifies dash length
   //The second number specifies space length between dashes 
```
### In storyboard Edit the following properties! 

##### For the UIView
Background Color. 
Image.
Title. 
Value.

##### For both Layers
LayerWidth

##### For background Layer
Layer Background Color.
Layer Background Dash.

##### For progress Layer
Layer Progress Color.

##### For node Layer
Node Color.
Node Width.

##### For the values
Slider Minimum Value
Slider Maximum Value

### Create an Outlet for the Control! 

``` swift
    @IBOutlet weak var tracker: CustomProgressBar! 
```

### Access Properties of your Outlet and modify to your needs! 

``` swift
    //Example
    tracker.sliderTextField = "\(tracker.value)"

```

And that's it! 
