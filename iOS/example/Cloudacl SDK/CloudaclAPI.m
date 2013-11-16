//
//  CloudaclAPI.m
//  Cloudacl SDK
//
//  Created by Seer on 11/15/13.
//  Copyright (c) 2013 Cloudacl. All rights reserved.
//

#import "CloudaclAPI.h"

@implementation CloudaclAPI

//Your key here
static NSString *API_Key = @"";

+ (NSString*) getCategoryByUrl:(NSMutableDictionary *) param{

    //Init request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    //Trim
    param[@"url"] = [param[@"url"] stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    
    //Add HTTP protocal by default if ommited
    if (![[param[@"url"] substringToIndex:3] isEqualToString: @"http"])
    {
        param[@"url"] = [NSString stringWithFormat:@"http://%@", param[@"url"]];
    }
    
    NSString *url = [NSString stringWithFormat: @"https://api.cloudacl.com/webfiltering-webapp/webapi/webcategories/getCategoryByUrl?url=%@&key=%@", param[@"url"], API_Key];
    [request setURL:[NSURL URLWithString:url]];
    
    //Send request & handle HTTP error
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"HTTP error, code %i", [responseCode statusCode]);
        return nil;
    }
    
    return [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
}


@end
