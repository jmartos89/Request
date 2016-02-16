//
//  Login.h
//  Optica
//
//  Created by Juan Martos Caceres on 12/08/14.
//  Copyright (c) 2014 Sopinet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@protocol RequestDelegate <NSObject>
@required
- (void) request: (id) object;
- (void) noRequest: (id) object;
- (void) updateVideo: (NSString*) identifier porcentage:(int) porcentage;
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
}

/** URL to Login **/
@property (nonatomic,strong) NSString *_url;
/** JSON **/
@property (nonatomic,strong) id _responseObject;
@property (nonatomic,strong) id delegate;
@property (nonatomic,strong) NSDictionary *dictionary;
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

-(Request*) init;
-(void) request: (NSDictionary*) params;
-(void) setExpected:(NSDictionary*)expected;
-(void) setUrl:(NSString*) url;
-(void) dismissAlertLog;


//Funcion para mandar una imagen
-(void) requestImage: (NSDictionary*) params andImage: (NSData *) img;

//Funcion para mandar un video
-(void) requestVideo: (NSDictionary*) params andVideo: (NSData *) video;

@end

