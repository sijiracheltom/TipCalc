# TipCalc

**TipCalc** is a tip calculator application for iOS.

Submitted by: **Siji Rachel Tom**

Time spent: **5** hours spent in total

## User Stories

The following **required** functionality is complete:
* [x] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [x] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [x] UI animations
* [x] Remembering the bill amount across app restarts (if <10mins)
* [x] Using locale-specific currency and currency thousands separators.
* [x] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [x] Provide a way for the user to set a custom tip percent in addition to the predefined set (18%, 20%, 25%)

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

![](http://i.imgur.com/bB6rNwe.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Project Analysis

iOS as a development platform is intuitive and straightforward to dive into. The plethora of features, capabilities and additionally, developer support available to make user experience so seamless and personal is powerful.
While creating apps, I’m used to programmatically setting up views and layout in code. While this is ideal when you need to have total control of deep view hierarchies and runtime optimizations, it can definitely take time to get an initial version done. Storyboard is an easy way to layout and setup UI, and I can see this being very beneficial especially when iterating and rapidly prototyping UI.

iOS uses MVC paradigm, and Storyboard is modeled after this. An Action is a way for the View to communicate to the Controller, while an Outlet enables the Controller to control UI behaviors on the View. For eg. in the Settings view above, the user tapping their choice of the tip selector (segmentedControl) is an action that is communicated to the controller. The controller responds by using the outlet to the custom label entry controls and showing/hiding them appropriately.

Every element in Storyboard has a unique identifier, and this identifier is used when setting up ‘connections’ between elements. Connections can be an Action or an Outlet. Storyboard uses XML to describe the layout, properties and connections of it’s elements.

eg. The main ViewController has this connection: outlet property="billField" destination="4wt-VF-iSY" id="qSp-iA-874"
The outlet itself has a unique id, but the destination here traces back to the id of the bill entry text field. This when translated to code is how the ViewController has a reference to the billField object. 


"Swift uses [Automatic Reference Counting](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html#//apple_ref/doc/uid/TP40014097-CH20-ID49) (ARC), which is not a garbage collector, to manage memory."

To give an example, consider a closure (C) in a class instance (I). The class instance (I) owns the closure, and has a strong reference to the closure (C), thus keeping C’s reference count > 0.

		I ————> C

Let’s assume that the closure (C) modifies a property of the instance (I). To modify the property, the closure (C) has to access the reference to the class instance (I). And it does so by holding on to the reference to the class instance (I). This is a strong reference by default.

		I <———— C
 
Both the class instance and the closure have a strong reference to each other, thus never letting each other be deallocated. This is called a strong reference cycle for closure.

For example in the setCustomPercentControlsHidden function in SettingsViewController.swift file (line 80), we submit an animation-closure for execution. Since the animation-closure modifies self’s custom-tip-entry elements, it’s necessary to define self in a closure list so it’s not captured strongly. (In this case, since I wasn’t sure if self was always guaranteed to be around when the block gets executed by UIKit, I decided to go with the weak reference capture, instead of unowned capture.)


## License

Copyright [2017] [Siji Rachel Tom]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
