# OneAPM

[![CI Status](http://img.shields.io/travis/jieliangma/OneAPM.svg?style=flat)](https://travis-ci.org/jieliangma/OneAPM)
[![Version](https://img.shields.io/cocoapods/v/OneAPM.svg?style=flat)](http://cocoapods.org/pods/OneAPM)
[![License](https://img.shields.io/cocoapods/l/OneAPM.svg?style=flat)](http://cocoapods.org/pods/OneAPM)
[![Platform](https://img.shields.io/cocoapods/p/OneAPM.svg?style=flat)](http://cocoapods.org/pods/OneAPM)

## Usage

Add some codes in your main.m file like this:

```ruby
#import "BLAppDelegate.h"
#import "OneAPM/OneAPM.h"

int main(int argc, char * argv[]) {
	@autoreleasepool {
		[OneAPM startWithApplicationToken:@"token_string_get_from_oneapm"];

		return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
	}
}

```

## Requirements

Minimum iOS Target: 6.0

## Installation

OneAPM is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "OneAPM"
```

## License

OneAPM is available under the MIT license. See the LICENSE file for more info.
