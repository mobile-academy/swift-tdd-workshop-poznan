# Code style

## Header files

Use only two line header:

```
//
//  Copyright © 2015 Mobile Academy. All rights reserved.
//

```

## Class template

Class template proposal:
```swift
class Foo {
	//MARK: Constants

	let key = "FOO BAR 123"

	//MARK: Properties

	var foo: String?

	//MARK: Initialisers

	init() {

	}

	//MARK: Public methods

	func doSomethingWith(foo: Sting) -> Bool {
		return false
	}

	//MARK: Private methods

	func someCalculation() -> Int {
		return 1+1
	}

}
```

## Spec template

Spec template proposal:

```swift
import Quick
import Nimble

@testable
import TDDWorkshop

class PhotoStreamViewControllerSpec: QuickSpec {
    override func spec() {
        describe("PhotoStreamViewController") {
            var photoStreamViewController: PhotoStreamViewController!

            beforeEach {
                photoStreamViewController = PhotoStreamViewController()
            }

            it("should work") {
                expect(true) == true
            }
        }
    }
}

```

## Spec helpers

Add suffix `Fake` to the class fake, e.g `Foo` should have `FooFake`.

## Variables in tests

We have to decide how to define variables in specs: optionals vs implicitly unwrapped optionals, e.g:
```swift
beforeEach {
	var foo: Bar?
}
```
vs.
```swift
beforeEach {
	var foo: Bar!
}
```

## License

Copyright © 2015 Mobile Academy. All rights reserved.