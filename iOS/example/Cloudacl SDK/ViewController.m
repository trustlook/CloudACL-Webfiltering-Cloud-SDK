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

@synthesize resultLbl, urlTxt;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    resultLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 170, 280, 100)];
    resultLbl.lineBreakMode = NSLineBreakByWordWrapping;
    resultLbl.numberOfLines = 3;
    [self.view addSubview:resultLbl];
    
    urlTxt = [[UITextField alloc] initWithFrame:CGRectMake(20, 30, 280, 50)];
    urlTxt.placeholder = @"Put URL here";
    [self.view addSubview:urlTxt];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [submitBtn setTitle:@"Check" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(callAPI) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.frame = CGRectMake(20, 90, 280, 50);
    [self.view addSubview:submitBtn];
    
}

- (void)callAPI
{
    NSMutableDictionary *myParam = [[NSMutableDictionary alloc] init];
    myParam[@"url"] = [urlTxt text];

    NSString *myResult = [CloudaclAPI getCategoryByUrl:myParam];
    [resultLbl setText:myResult];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
