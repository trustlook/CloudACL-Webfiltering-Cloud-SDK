//
//  ViewController.m
//  Cloudacl SDK
//
//  Created by Seer on 11/14/13.
//  Copyright (c) 2013 Cloudacl. All rights reserved.
//

#import "ViewController.h"
#import "CloudaclAPI.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize resultLbl, urlTxt, submitBtn;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    resultLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 130, 280, 100)];
    resultLbl.lineBreakMode = NSLineBreakByWordWrapping;
    resultLbl.numberOfLines = 5;
    [self.view addSubview:resultLbl];
    
    urlTxt = [[UITextField alloc] initWithFrame:CGRectMake(20, 30, 280, 50)];
    urlTxt.placeholder = @"Put URL here";
    [urlTxt addTarget:self action:@selector(onInput) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:urlTxt];
    
    submitBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [submitBtn setTitle:@"Check" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(callAPI) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.enabled = NO;
    submitBtn.frame = CGRectMake(20, 90, 280, 50);
    [self.view addSubview:submitBtn];
    
}

- (void)callAPI
{
    NSMutableDictionary *myParam = [[NSMutableDictionary alloc] init];
    myParam[@"url"] = [urlTxt text];

    //API will return the parsed data in a NSDictionary
    NSDictionary *result = [CloudaclAPI getCategoryByUrl:myParam];
    
    //Traverse the key-value result
    NSMutableString *output = [[NSMutableString alloc] init];
    for (NSString* key in [result allKeys] ) {
        [output appendString:[NSString stringWithFormat:@"%@ : %@\n", key, [result objectForKey:key]]];
    }
    [resultLbl setText:output];
    
    return;
}

- (void)onInput
{
    submitBtn.enabled = ([urlTxt.text length] > 0);
    return;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
