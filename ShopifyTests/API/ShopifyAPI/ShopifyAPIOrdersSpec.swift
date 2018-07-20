//
//  ShopifyAPIOrdersSpec.swift
//  ShopifyTests
//
//  Created by Radyslav Krechet on 4/12/18.
//  Copyright © 2018 RubyGarage. All rights reserved.
//

import MobileBuySDK
import Nimble
import Quick
import ShopApp_Gateway

@testable import Shopify

class ShopifyAPIOrdersSpec: ShopifyAPIBaseSpec {
    override func spec() {
        super.spec()
        
        describe("when get order list called") {
            beforeEach {
                self.signIn()
            }
            
            context("if success") {
                it("should return success") {
                    self.clientMock.returnedResponse = try! Storefront.QueryRoot(fields: ["customer": ["orders": ShopifyAPITestHelper.orders]])
                    
                    self.shopifyAPI.getOrders(perPage: 10, paginationValue: nil) { (orders, error) in
                        expect(orders?.first?.id) == ShopifyAPITestHelper.order["id"] as? String
                        expect(error).to(beNil())
                    }
                }
            }
            
            context("if error occured") {
                context("because got error from server") {
                    it("should return error") {
                        let errorExpectation: ErrorExpectation = { _ in
                            self.shopifyAPI.getOrders(perPage: 10, paginationValue: nil) { (orders, error) in
                                expect(orders).to(beNil())
                                expect(error) == ShopAppError.content(isNetworkError: false)
                            }
                        }
                        
                        self.expectError(in: errorExpectation)
                    }
                }
                
                context("because user's status is not login") {
                    it("should return error") {
                        self.signOut()
                        
                        self.shopifyAPI.getOrders(perPage: 10, paginationValue: nil) { (orders, error) in
                            expect(orders).to(beNil())
                            expect(error) == ShopAppError.content(isNetworkError: false)
                        }
                    }
                }
            }
            
            afterEach {
                self.signOut()
            }
        }
        
        describe("when get order called") {
            context("if success response") {
                context("and node exist") {
                    it("should return success") {
                        self.clientMock.returnedResponse = try! Storefront.QueryRoot(fields: ["node": ShopifyAPITestHelper.order])
                        
                        self.shopifyAPI.getOrder(id: "id") { (order, error) in
                            expect(order?.id) == ShopifyAPITestHelper.order["id"] as? String
                            expect(error).to(beNil())
                        }
                    }
                }
                
                context("or doesn't exist") {
                    it("should return error with CriticalError type") {
                        self.clientMock.returnedResponse = try! Storefront.QueryRoot(fields: ["node": NSNull()])
                        
                        self.shopifyAPI.getOrder(id: "id") { (order, error) in
                            expect(order).to(beNil())
                            expect(error) == ShopAppError.critical
                        }
                    }
                }
            }

            context("if error occured") {
                it("should return error") {
                    let errorExpectation: ErrorExpectation = { _ in
                        self.shopifyAPI.getOrder(id: "id") { (order, error) in
                            expect(order).to(beNil())
                            expect(error) == ShopAppError.content(isNetworkError: false)
                        }
                    }

                    self.expectError(in: errorExpectation)
                }
            }
            
            context("if response ans error are nil") {
                it("should return error with ContentError type") {
                    self.clientMock.clear()
                    
                    self.shopifyAPI.getOrder(id: "id") { (order, error) in
                        expect(order).to(beNil())
                        expect(error) == ShopAppError.content(isNetworkError: false)
                    }
                }
            }
        }
    }
}
