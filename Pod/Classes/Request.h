//
//  Request.m
//  Request
//
//  Created by Juan Martos Caceres on 12/08/14.
//  Copyright (c) Juan Martos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+MD5.h"

/** SVProgressHUD **/
#import "SVProgressHUD.h"

@protocol RequestDelegate <NSObject>
@required
- (void) request: (id) object;
- (void) noRequest: (id) object;
@end

@interface Request : NSObject {
    // Delegate to respond back
    id <RequestDelegate> _delegate;
    
    /** Var and data expected **/
    NSDictionary *_expected;
    
    /** Show alert **/
    /** La alerta solo la mostramos cuando le damos a loguear no cuando intenta loguear solo **/
    Boolean _show;
    
    /** Alerta mientras esta el proceso de verificacion **/
    UIAlertView *_alertViewLog;
    
    /** Variable para controlar si tenemos datos esperados **/
    Boolean _hasExpected;
}

extern NSString *const POST;
extern NSString *const GET;

/** URL to request **/
@property (nonatomic,strong) NSString *_url;
@property (nonatomic,strong) NSString *type;

/** JSON **/
@property (nonatomic,strong) id _responseObject;
@property (nonatomic,strong) id delegate;
@property (nonatomic,strong) NSDictionary *dictionary;

/** HasCache **/
@property Boolean hasCache;

/** More Content Types**/
@property NSArray *contentTypes;

-(void) request: (NSDictionary*) params;
-(void) setExpected:(NSDictionary*)expected;
-(void) setUrl:(NSString*) url;
-(UIAlertView*) getAlertRequest;
-(void) dismissAlertLog;


//Funcion para mandar una imagen
-(void) requestImage: (NSDictionary*) params andImage: (NSData *) img;

//Funcion para mandar un video
-(void) requestVideo: (NSDictionary*) params andVideo: (NSData *) video;

@end

