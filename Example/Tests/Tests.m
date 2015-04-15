//
//  RequestTests.m
//  RequestTests
//
//  Created by juan on 04/14/2015.
//  Copyright (c) 2014 juan. All rights reserved.
//

#import <Specta/Specta.h> // #import "Specta.h" if you're using libSpecta.a
#import "Request.h"

SpecBegin(Request)
describe(@"Request", ^{
    	__block Request *request;
    
     	beforeEach(^{
             request = [[Request alloc] init];
           });
    
     	it(@"can be created", ^{
         		expect(request).toNot.beNil();
         	});
    
     	it(@"has an expected dictionary", ^{
            NSDictionary * dictionary = @{@"dict":@"dict"};
            request.dictionary = dictionary;
            expect(request.dictionary).to.equal(dictionary);
        });
    
     	/*it(@"has an Item Property", ^{
         		Item *item = [[Item alloc] init];
         		tagging.item = item;
         		expect(tagging.item).to.equal(item);
         	});*/
 	
     	afterEach(^{
         		request = nil;
         	});
     });

 SpecEnd

/*SharedExamplesBegin(MySharedExamples)
// Global shared examples are shared across all spec files.

sharedExamplesFor(@"foo", ^(NSDictionary *data) {
    __block id bar = nil;
    beforeEach(^{
        bar = data[@"bar"];
    });
    it(@"should not be nil", ^{
        XCTAssertNotNil(bar);
    });
});

SharedExamplesEnd

SpecBegin(Thing)

describe(@"Thing", ^{
    sharedExamplesFor(@"another shared behavior", ^(NSDictionary *data) {
        // Locally defined shared examples can override global shared examples within its scope.
    });
    
    beforeAll(^{
        // This is run once and only once before all of the examples
        // in this group and before any beforeEach blocks.
    });
    
    beforeEach(^{
        // This is run before each example.
    });
    
    it(@"should do stuff", ^{
        // This is an example block. Place your assertions here.
    });
    
    it(@"should do some stuff asynchronously", ^{
        waitUntil(^(DoneCallback done) {
            // Async example blocks need to invoke done() callback.
            done();
        });
    });
    
    itShouldBehaveLike(@"a shared behavior", @{@"key" : @"obj"});
    
    itShouldBehaveLike(@"another shared behavior", ^{
        // Use a block that returns a dictionary if you need the context to be evaluated lazily,
        // e.g. to use an object prepared in a beforeEach block.
        return @{@"key" : @"obj"};
    });
    
    describe(@"Nested examples", ^{
        it(@"should do even more stuff", ^{
            // ...
        });
    });
    
    pending(@"pending example");
    
    pending(@"another pending example", ^{
        // ...
    });
    
    afterEach(^{
        // This is run after each example.
    });
    
    afterAll(^{
        // This is run once and only once after all of the examples
        // in this group and after any afterEach blocks.
    });
});

SpecEnd*/