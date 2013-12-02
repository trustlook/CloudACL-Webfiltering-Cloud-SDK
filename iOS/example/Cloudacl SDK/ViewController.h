//
//  ViewController.h
//  Cloudacl SDK
//
//  Created by Seer on 11/14/13.
//  Copyright (c) 2013 Cloudacl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    UILabel *resultLbl;
    UITextField *urlTxt;
    UIButton *submitBtn;
}
@property (nonatomic, retain) UILabel *resultLbl;
@property (nonatomic, retain) UITextField *urlTxt;
@property (nonatomic, retain) UIButton *submitBtn;

@end