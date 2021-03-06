//
// Created by Maciej Oczko on 16.11.2015.
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Eureka

@testable
import TDDWorkshop

final class PollViewControllerSpec: QuickSpec {
    override func spec() {
        var sut: PollViewController!

        beforeEach() {
            let storyboard = UIStoryboard(name: "Poll", bundle: nil)
            let viewController = storyboard.instantiateViewControllerWithIdentifier("Poll")
            if let nc = viewController as? NavigationController {
                sut = nc.topViewController as! PollViewController
            } else {
                sut = viewController as! PollViewController
            }
        }

        afterEach {
            sut = nil
        }

        describe("default initialization") {

            it("should have a title") {
                expect(sut.title).to(equal("Feedback"))
            }

            it("should have z poll builder") {
                expect(sut.pollBuilder).toNot(beNil())
            }

            it("should have poll manager") {
                expect(sut.pollManager).toNot(beNil())
            }

            it("should validator factory") {
                expect(sut.validatorFactory).toNot(beNil())
            }
        }

        describe("behavior") {
            var pollSender: PollManagerFake!
            var pollBuilder: PollBuilder!

            beforeEach {
                pollSender = PollManagerFake()
                pollBuilder = PollBuilder()
                sut.pollManager = pollSender
                sut.pollBuilder = pollBuilder
            }

            describe("navigation item configuration") {

                var navigationController: UINavigationController!

                beforeEach {
                    navigationController = UINavigationController(rootViewController: sut)
                }

                afterEach {
                    navigationController = nil
                }

                // About `sut.view`:
                // To simulate normal view controller life cycle you can call the `view` property on it.
                // It's equal to call `loadView()` and `viewDidLoad()` method.

                it("should set navigation item") {
                    pollSender.pollAlreadySent = false
                    let _ = sut.view
                    sut.viewWillAppear(false)
                    expect(sut.navigationItem.rightBarButtonItem).toNot(beNil())
                }

                it("should nil out navigation item") {
                    pollSender.pollAlreadySent = true
                    let _ = sut.view
                    sut.viewWillAppear(false)
                    expect(sut.navigationItem.rightBarButtonItem).to(beNil())
                }

            }

            describe("sending poll") {

                var navigationController: UINavigationController!

                beforeEach {
                    navigationController = UINavigationController(rootViewController: sut)
                    pollSender.pollAlreadySent = false
                    sut.sendPoll()
                }

                afterEach {
                    navigationController = nil
                }

                it("should send poll with sender") {
                    expect(pollSender.didCallSendPoll).to(beTrue())
                }

                it("should nil out button item") {
                    expect(sut.navigationItem.rightBarButtonItem).to(beNil())
                }

            }
        }

        describe("validation factory usage for name") {
            var factory: ValidationFactoryFake!
            var validator: ValidatorFake!

            beforeEach {
                validator = ValidatorFake()
                factory = ValidationFactoryFake(validator: validator)
                sut.validatorFactory = factory
                sut.loadView()
                sut.viewDidLoad()

                sut.simulateTextInput(forRowWithType: .Text, text: "the string")
            }

            it("should validate text with proper validator") {
                expect(validator.didCallValidateText).to(beTrue())
            }
        }
    }
}

