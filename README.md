# YXWaveView

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Version](https://img.shields.io/cocoapods/v/YXWaveView.svg?style=flat)](http://cocoapods.org/pods/YXWaveView)
[![License](https://img.shields.io/cocoapods/l/YXWaveView.svg?style=flat)](http://cocoapods.org/pods/YXWaveView)
[![Platform](https://img.shields.io/cocoapods/p/YXWaveView.svg?style=flat)](http://cocoapods.org/pods/YXWaveView)

A water wave animation view with a over view float.

## Installl

### CocoaPod

`Podfile` add this:

```
platform :ios, '8.0'

pod 'YXWaveView'
```

Run `pod install`

### Carthage

```
github "yourtion/YXWaveView"
```

## Use

### Init

```swift
let frame = CGRect(x: 0, y: 50, width: self.view.bounds.size.width, height: 150)
let waterView = YXWaveView(frame: frame, color: UIColor.whiteColor())
waterView.addOverView(avatarView);
```

### Add OverView

```swift
waterView.addOverView(overView);
```

### Start

```swift
waterView.start()
```

### Stop

```swift
waterView.stop()
```

see [Demo](YXWaveViewDemo/ViewController.swift)