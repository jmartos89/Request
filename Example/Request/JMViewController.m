//
//  JMViewController.m
//  Request
//
//  Created by juan on 04/14/2015.
//  Copyright (c) 2014 juan. All rights reserved.
//

#import "JMViewController.h"

@interface JMViewController ()

@end

@implementation JMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Config request
    _requestLogin = [[Request alloc]init];
    _requestLogin.delegate = self;
    
    //Send a predata for validate ok response
    NSDictionary *expected = @{@"expected1" : @"msg", @"value1" : @"Ok",
                               @"expected2" : @"state", @"value2" : @"1"};
    
    [_requestLogin setExpected:expected];
    
    //Send to url to request
    [_requestLogin setUrl:@"http://example.com/login"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)login{
    NSDictionary *dictionary = @{@"email" : @"myemail", @"pass" : @"mypass"};
    [_requestLogin request:dictionary];
}

#pragma mark - Request delegate
- (void) request:  (id) object{
    Request * request = (Request*) object;
    
    //NSDictionary *data = [request._responseObject objectForKey:@"data"];
    
    if([request isEqual:_requestLogin])
    {
        NSLog(@"Login");
        [[_requestLogin getAlertRequest] show];
    }
}

- (void) noRequest: (id) object{
    Request * request = (Request*) object;
    
    //NSDictionary *data = [request._responseObject objectForKey:@"data"];
    
    if([request isEqual:_requestLogin])
    {
        NSLog(@"Error");
        [[_requestLogin getAlertRequest] show];
    }
}


@end
