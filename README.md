# YXWaveView

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Version](https://img.shields.io/cocoapods/v/YXWaveView.svg?style=flat)](http://cocoapods.org/pods/YXWaveView)
[![License](https://img.shields.io/cocoapods/l/YXWaveView.svg?style=flat)](http://cocoapods.org/pods/YXWaveView)
[![Platform](https://img.shields.io/cocoapods/p/YXWaveView.svg?style=flat)](http://cocoapods.org/pods/YXWaveView)

A water wave animation view with a over view float.

## ScreenShot 

![ScreenShot](ScreenShot.gif)

## Installl

#### CocoaPod

`Podfile` add this:

```
platform :ios, '8.0'

pod 'YXWaveView'
```

Run `pod install`

#### Carthage

```
github "yourtion/YXWaveView"
```

## How to use

```swift
// Init
let frame = CGRect(x: 0, y: 50, width: self.view.bounds.size.width, height: 150)
let waterView = YXWaveView(frame: frame, color: UIColor.whiteColor())
waterView.addOverView(avatarView);

// Add OverView
waterView.addOverView(overView);

// Start
waterView.start()

// Stop
waterView.stop()
```

Detail [Demo](YXWaveViewDemo/ViewController.swift)
