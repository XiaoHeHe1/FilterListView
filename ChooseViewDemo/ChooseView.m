//
//  ChooseView.m
//  ChooseViewDemo
//
//  Created by YYY on 2018/12/27.
//  Copyright © 2018 YYY. All rights reserved.
//

#import "ChooseView.h"
#import "ViewController.h"
#import "EachView.h"
@implementation ChooseView

+ (ChooseView *)makeChooseViewByScreeningViewWithTop:(double)top;{
    ChooseView *chooseView = [[ChooseView alloc]init];
    chooseView.backgroundColor = [UIColor whiteColor];
    chooseView.width = SCREEN_WIDTH;
    chooseView.height = SCREEN_HEIGHT_NEW - top;
 
    UIScrollView *scrollow = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, chooseView.height - 40)];
    [chooseView addSubview:scrollow];
    scrollow.backgroundColor =  [UIColor clearColor];
    
    
    
    
    
    
    
    
    double topX = 0 ;
    for(int i = 0; i < 5 ; i ++){
        NSArray *_listArray = @[@"产品类型",@"产品期限",@"起购金额",@"保本性质",@"币种"];
        NSArray *chList = nil;
        if (i == 0) {
            chList = @[@"全部",@"活期类",@"定期类",@"结构性产品",@"私人银行"];
        }else if (i == 1){
            chList = @[@"全部",@"1-30天",@"31-60天",@"61-90天",@"91-180天",@"181-365天",@"365天+"];
        }else if (i == 2){
            chList = @[@"全部",@"5万以下",@"5-600万",@"10-600万",@"600万+", ];
        }else if (i == 3){
            chList = @[@"全部",@"保本",@"其他", ];
        }else if (i == 4){
            chList = @[@"全部",@"人民币",@"美元",@"英镑",@"港币",@"澳元"];
        }
        EachView *eachView = [EachView makeEachViewWithTitle:_listArray[i] chList:chList ];
        eachView.top = topX;
        eachView.tag = i;
        [scrollow addSubview:eachView];
        eachView.backgroundColor = [UIColor whiteColor];
        
        if (i==4) {
            eachView.height += 50;
        }
        
        topX = eachView.bottom;
    }
    scrollow.contentSize = CGSizeMake(SCREEN_WIDTH, topX + 50);
    
    
    
    
    double thisHeight = 50.0;
    //下面按钮
    UIView *resetBtn = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH, thisHeight- 1)];
    resetBtn.backgroundColor = [UIColor whiteColor];
    [chooseView addSubview:resetBtn];
    resetBtn.bottom = chooseView.height;
    
    scrollow.contentSize = CGSizeMake(SCREEN_WIDTH, topX + thisHeight);

    
    //
    //重置
    //
    UIButton *cleanAllButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2.0, thisHeight)];
    [resetBtn addSubview:cleanAllButton];
    [cleanAllButton setTitle:@"重置" forState:UIControlStateNormal];
    [cleanAllButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [cleanAllButton setBackgroundImage:[UIImage imageNamed:@"White.png"] forState:UIControlStateNormal];
    [cleanAllButton setTapActionWithBlock:^{
        for (int i = 0; i < scrollow.subviews.count; i ++) {
            EachView *seachView = scrollow.subviews[i];
            
            if ([seachView isKindOfClass:[EachView class]]) {
                [seachView makeDefault];
                
            }
        }
    }];
    
 
    //
    //完成
    //
    UIButton *sureButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2.0, 0, SCREEN_WIDTH/2.0, thisHeight)];
    [resetBtn addSubview:sureButton];
    [sureButton setTitle:@"完成" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    resetBtn.userInteractionEnabled = YES;
    [sureButton setTapActionWithBlock:^{
        
        NSMutableDictionary *allParamsDic = [[NSMutableDictionary alloc]initWithCapacity:5];
        
        for (int i = 0; i < scrollow.subviews.count; i ++) {
            EachView *seachView = scrollow.subviews[i];
            
            if ([seachView isKindOfClass:[EachView class]]) {
                NSDictionary *dic = [seachView getPostDic];
                [allParamsDic addEntriesFromDictionary:dic];
            }
        }
        
        //
        //发接口
        //
        NSLog(@"参数%@",allParamsDic);
    }];
    
    return chooseView;
}


@end
