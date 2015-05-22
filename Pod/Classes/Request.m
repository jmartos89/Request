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

NSString *const POST = @"post";
NSString *const GET = @"get";

@synthesize _responseObject;
@synthesize _url;

-(void)request: (NSDictionary*) params{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [self setDictionary:params];
    
    /** Comprobamos si tenemos cache para esta peticion **/
    NSArray * cache = [self getCache];
    
    if(cache){
        _responseObject = cache;
        [self.delegate request:self];
    }else{
        if([_type isEqual:POST]){
            [self post:manager];
        }else if([_type isEqual:GET]){
            [self get:manager];
        }
    }
}

-(void) get:(AFHTTPRequestOperationManager *) manager{
    [manager GET:_url parameters:self.dictionary
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [self checkObject:responseObject];
     }failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"El error es: %@", [error description]);
         [self.delegate noRequest:self];
     }];

}

-(void) post:(AFHTTPRequestOperationManager *) manager{
    [manager POST:_url parameters:self.dictionary
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
        [self checkObject:responseObject];
     }failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"El error es: %@", [error description]);
         [self.delegate noRequest:self];
     }];
}

-(void) checkObject: (id) responseObject{
    Boolean complete = false;
    
    if(_hasExpected){
        NSString *expected1 = [NSString stringWithFormat:@"%@",[responseObject objectForKey:[_expected objectForKey:@"expected1"]] ];
        NSString *value1 = [_expected objectForKey:@"value1"];
        NSString *expected2 = [NSString stringWithFormat:@"%@",[responseObject objectForKey:[_expected objectForKey:@"expected2"]] ];
        NSString *value2 = [_expected objectForKey:@"value2"];
        
        if([expected1 isEqualToString:value1] && [expected2 isEqualToString:value2]){
            complete = true;
        }
    }else{
        complete = true;
    }
    
    if(complete){
        _responseObject = responseObject;
        //Guardamos en cache
        [self saveInDisk];
        [self.delegate request:self];
    }else{
        [self.delegate noRequest:self];
    }
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
    _hasExpected = true;
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

#pragma marks - cache
-(void) saveInDisk{
    [_responseObject writeToFile: [self getPath] atomically:YES];
}

-(NSArray*) getCache{
    return [NSArray arrayWithContentsOfFile: [self getPath]];
}

-(NSString*) getPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *path = [NSString stringWithFormat:@"%@.dat", [[NSString stringWithFormat:@"%@%@%@", _url, _type, self.dictionary] MD5Digest]];
    
    return [[paths objectAtIndex:0]
                 stringByAppendingPathComponent:path];
}
@end
