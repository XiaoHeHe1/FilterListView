//
//  ViewController.m
//  ChooseViewDemo
//
//  Created by YYY on 2018/12/27.
//  Copyright © 2018 YYY. All rights reserved.
//

#import "ViewController.h"
#import "ChooseView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ChooseView *chooseView = [ChooseView makeChooseViewByScreeningViewWithTop:0];
    [self.view addSubview:chooseView];
}


@end
