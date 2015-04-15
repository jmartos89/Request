//
//  JMViewController.h
//  Request
//
//  Created by juan on 04/14/2015.
//  Copyright (c) 2014 juan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Request.h"

@interface JMViewController : UIViewController<RequestDelegate>{
    
    //For example a request for login
    Request *_requestLogin;
}

-(IBAction)login;

@end
