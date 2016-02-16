//
//  Login.m
//  Optica
//
//  Created by Juan Martos Caceres on 12/08/14.
//  Copyright (c) 2014 Sopinet. All rights reserved.
//

#import "Request.h"

@implementation Request

@synthesize _responseObject;
@synthesize _url;

-(Request*) init{
    self = [super init];
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    return self;
}

-(void)request: (NSDictionary*) params{
    [self setDictionary:params];
    
    [self.manager POST:_url parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
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

         
     }failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
     }];
}

/*
-(void)requestImage: (NSDictionary*) params andImage: (NSData *) img{
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:_url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:img name:@"file" fileName:@"file.jpg" mimeType:@"image/jpeg"];
        
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSProgress *progress = nil;
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", [error description]);
        } else {
            NSLog(@"%@ %@", response, responseObject);
        }
    }];
    
    [uploadTask resume];

}
 
 */

-(void)requestImage: (NSDictionary*) params andImage: (NSData *) img{
    [self setDictionary:params];
    
    AFHTTPRequestOperation *op = [self.manager POST:_url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
         [formData appendPartWithFileData:img name:@"file" fileName:@"file.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    [op setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite){
        
        //long long int x = totalBytesWritten;
        //long long int y = totalBytesExpectedToWrite;
        
        //NSLog(@"x = %lld@ y = %lld",x, y);
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

-(void) requestVideo: (NSDictionary*) params andVideo: (NSData *) video { 
    [self setDictionary:params];
    
    AFHTTPRequestOperation *op = [self.manager POST:_url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:video name:@"file" fileName:@"file.mp4" mimeType:@"video/mp4"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    [op setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite){
        long long int x = totalBytesWritten;
        long long int y = totalBytesExpectedToWrite;
        
        NSString *identifier = [params objectForKey:@"msgid"];

        int porcentage = [[NSNumber numberWithInt:(((int)x*100)/(int)y)] intValue];
        
        if(porcentage %5 == 0){
            [self.delegate updateVideo:identifier porcentage:(int)porcentage];
            
        }
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


-(UIAlertView*) getAlert{
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
