//
//  CloudaclAPI.m
//  Cloudacl SDK
//
//  Created by Seer on 11/15/13.
//  Copyright (c) 2013 Cloudacl. All rights reserved.
//

#import "CloudaclAPI.h"
#import "SBJson.h"

@implementation CloudaclAPI

//Your key here
static NSString *API_Key = @"8e0ec399-3372-4966-9ce0-8277e84f0bfc";
static NSString *Request_Url = @"https://api.cloudacl.com/webapi/getcategory";

+ (NSDictionary*) getCategoryByUrl:(NSMutableDictionary *) param{

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
    
    NSString *url = [NSString stringWithFormat: @"%@?uri=%@&key=%@", Request_Url, param[@"url"], API_Key];
    [request setURL:[NSURL URLWithString:url]];
    
    //Send request & handle HTTP error
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"HTTP error, code %i", [responseCode statusCode]);
        return nil;
    }
    
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    return [jsonParser objectWithData:responseData];
    
    
    //return [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
}


@end
