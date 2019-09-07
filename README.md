<h2><center>RPBannerView</center></h2>

* iOS 9.0+

* Xcode 10.0+

* pod V1.7.0+

* license MIT

![demo1](https://github.com/dengfeng520/RPBannerView/blob/master/demo1.png?raw=true)
![demo2](https://github.com/dengfeng520/RPBannerView/blob/master/demo2.png?raw=true)
![demo3](https://github.com/dengfeng520/RPBannerView/blob/master/demo3.png?raw=true)

<h2>Adding RPBannerView to your project</h2>

**CocoaPods is the recommended way to add RPBannerView to your project.**

**1、Add a pod entry for RPBannerView to your project Podfile**

```
pod 'RPBannerView'
```
or

```
pod 'RPBannerView', :git => 'https://github.com/dengfeng520/RPBannerView'
```

**2、Install the pod by running**

```
pod install
```
<h2>Usage</h2>

```
#import "RPBannerView.h"
```

> warningMode

```
[RPBannerView showWithMode:warningMode body:@"Something went wrong,please try again."];
```
**If you need to add RPBannerView to the current View and display for 2 seconds:**

```
[RPBannerView showWithMode:warningMode body:@"Something went wrong,please try again." isView:self.view isTime:2.5];
```
> perfectionMode

```
[RPBannerView showWithMode:perfectionMode body:@"Read data completion." isView:self.view];
```
>successMode

```
[RPBannerView showWithMode:successMode body:@"Load all data successfully." isView:self.view];
```