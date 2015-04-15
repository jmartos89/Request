//
//  Request.m
//  Request
//
//  Created by Juan Martos Caceres on 12/08/14.
//  Copyright (c) Juan Martos. All rights reserved.
//

#import "Request.h"
#import <AFNetworking/AFNetworking.h>

@implementation Request

@synthesize _responseObject;
@synthesize _url;

-(void)request: (NSDictionary*) params{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [self setDictionary:params];
    
    AFHTTPRequestOperation *op = [manager POST:_url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    [op setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite){
        
        //long long int x = totalBytesWritten;
        //long long int y = totalBytesExpectedToWrite;
        
    }];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *expected1 = [NSString stringWithFormat:@"%@",[responseObject objectForKey:[_expected objectForKey:@"expected1"]] ];
        NSString *value1 = [_expected objectForKey:@"value1"];
        NSString *expected2 = [NSString stringWithFormat:@"%@",[responseObject objectForKey:[_expected objectForKey:@"expected2"]] ];
        NSString *value2 = [_expected objectForKey:@"value2"];
        
        if([expected1 isEqualToString:value1] && [expected2 isEqualToString:value2]){
            _responseObject = responseObject;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate request:self];
            });
            
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate noRequest:self];
            });
        }
        
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate noRequest:self];
        });
    }];
    
    [op start];
}

-(void)requestImage: (NSDictionary*) params andImage: (NSData *) img{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [self setDictionary:params];
    
    AFHTTPRequestOperation *op = [manager POST:_url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
         [formData appendPartWithFileData:img name:@"file" fileName:@"file.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    [op setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite){
        
        //long long int x = totalBytesWritten;
        //long long int y = totalBytesExpectedToWrite;
        
    }];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *expected1 = [NSString stringWithFormat:@"%@",[responseObject objectForKey:[_expected objectForKey:@"expected1"]] ];
        NSString *value1 = [_expected objectForKey:@"value1"];
        NSString *expected2 = [NSString stringWithFormat:@"%@",[responseObject objectForKey:[_expected objectForKey:@"expected2"]] ];
        NSString *value2 = [_expected objectForKey:@"value2"];
        
        if([expected1 isEqualToString:value1] && [expected2 isEqualToString:value2]){
            _responseObject = responseObject;
            [self.delegate request:self];
            
        }else{
            [self.delegate noRequest:self];
        }
        
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate noRequest:self];
        });
    }];
    
    [op start];
}

-(void) requestVideo: (NSDictionary*) params andVideo: (NSData *) video{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [self setDictionary:params];
    
    AFHTTPRequestOperation *op = [manager POST:_url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:video name:@"file" fileName:@"file.mp4" mimeType:@"video/mp4"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    [op setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite){
        //long long int x = totalBytesWritten;
        //long long int y = totalBytesExpectedToWrite;
    }];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *expected1 = [NSString stringWithFormat:@"%@",[responseObject objectForKey:[_expected objectForKey:@"expected1"]] ];
        NSString *value1 = [_expected objectForKey:@"value1"];
        NSString *expected2 = [NSString stringWithFormat:@"%@",[responseObject objectForKey:[_expected objectForKey:@"expected2"]] ];
        NSString *value2 = [_expected objectForKey:@"value2"];
        
        if([expected1 isEqualToString:value1] && [expected2 isEqualToString:value2]){
            _responseObject = responseObject;
            [self.delegate request:self];
            
        }else{
            [self.delegate noRequest:self];
        }

       
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    [op start];
}

-(void)setExpected:(NSDictionary*)expected{
    _expected = expected;
}

-(void) setUrl:(NSString*) url{
    _url = url;
}


-(UIAlertView*) getAlertRequest{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Peticion"
                                                      message:@"Se ha realizado correctamente"
                                                     delegate:nil
                                            cancelButtonTitle:@"Entendido"
                                            otherButtonTitles:nil];
    
    return message;
}

-(void) showAlertLog{
    _alertViewLog = [[UIAlertView alloc] initWithTitle:@"Peticion"
                                                      message:@"Ha habido un error"
                                                     delegate:nil
                                            cancelButtonTitle:@"Entendido"
                                            otherButtonTitles:nil];
    
    [_alertViewLog show];
}

-(void) dismissAlertLog{
    [_alertViewLog dismissWithClickedButtonIndex:-1 animated:YES];
}

@end
