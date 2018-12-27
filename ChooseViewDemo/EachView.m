//
//  EachView.m
//  ChooseViewDemo
//
//  Created by YYY on 2018/12/27.
//  Copyright © 2018 YYY. All rights reserved.
//

#import "EachView.h"
#import "ViewController.h"
@implementation EachView

+ (EachView *)makeEachViewWithTitle:(NSString *)title chList:(NSArray *)list;{
    
    EachView *view = [[EachView alloc]init];
    view.width = SCREEN_WIDTH;
    //
    //左上title
    //
    NSString *titleS = title;
    MyLabel *left = [[MyLabel alloc]initWithFrame:CGRectZero bgColor:[UIColor clearColor] title:titleS titleCollor:[UIColor grayColor] fontSize:13 * SCALE_FONT  cornerRadius:0];
    [left sizeToFit];
    left.top = 15;
    left.left = 20;
    [view addSubview:left];
    

    NSArray *btnNames = list;
    for(int i = 0 ; i < btnNames.count; i ++){
        //
        //下方按钮
        //
        UIButton *amtButton = [[UIButton alloc]init];
        [amtButton setTitle:[NSString stringWithFormat:@"%@%@",btnNames[i],@""] forState:UIControlStateNormal];
        amtButton.titleLabel.font = [UIFont systemFontOfSize:15];
        amtButton.titleLabel.numberOfLines = 0;

        amtButton.tag = 100 + i;
        
        if (i == 0) {
            [view setSelectedStyle:amtButton];
        }else{
            [view setdeSelectedStyle:amtButton];
        }
        
        //
        //除去两边空白的平均宽度
        //
        float width = (SCREEN_WIDTH - 10 * 2) / 3.0 ;
        
        amtButton.frame = CGRectMake(10 + width * (i % 3) ,
                                     (left.bottom + 5 + 1 * HEIGHT_SCALE + (i / 3) * 40 * HEIGHT_SCALE) ,
                                     width - 10,
                                     30);
        __block UIButton *weakAmtButton = amtButton;

        [amtButton setTapActionWithBlock:^{
            //
            //设置选中与不选中
            //
            [view setSelectedStyle:weakAmtButton];

            for (UIButton *but in view.subviews) {
                if ((but.tag > 99)  && (but != amtButton)) {
                    [view setdeSelectedStyle:but];
                }
            }
        }];
        [view addSubview:amtButton];
        view.height = amtButton.bottom;
    }
    
    
    return view;
}
//
//默认样式
//
- (void)makeDefault{
    for (UIButton *but in self.subviews) {
        if ([but isKindOfClass:[UIButton class]]) {
            if ( but.tag  == 100) {
                [self setSelectedStyle:but];
            }else{
                [self setdeSelectedStyle:but];
            }
        }
        
        
    }
}
//
//选中样式
//
- (void)setSelectedStyle:(UIButton *)amtButton{

    amtButton.selected = YES;

    [amtButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    amtButton.layer.borderColor = [UIColor blueColor].CGColor;
    [amtButton setBackgroundColor:[UIColor blueColor]];
    amtButton.layer.borderWidth = 0.5;
    amtButton.layer.cornerRadius = 2;
}
//
//未选中样式
//
- (void)setdeSelectedStyle:(UIButton *)amtButton{

    amtButton.selected = NO;;

    amtButton.layer.borderWidth = 0.5;
    amtButton.layer.cornerRadius = 2;
    [amtButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    amtButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [amtButton setBackgroundColor:[UIColor lightGrayColor]];
    
    
}
//
//获取请求参数 每个btn对应不同的参数
//
- (NSDictionary*)getPostDic{
    
    NSDictionary * _lastDictionary = @{@"全部"        :@"0",
                                       @"活期类"       :@"huoqi",
                                       @"定期类"       :@"dingqi",
                                       @"结构性产品"     :@"jiegou",
                                       @"私人银行"      :@"siren",
                                       
                                       @"全部"             :@"0",
                                       @"1-30天"          :@"1",
                                       @"31-60天"        :@"2",
                                       @"61-90天"        :@"3",
                                       @"91-180天"       :@"4",
                                       @"181-365天"      :@"5",
                                       @"365天+"         :@"12",

                                       @"全部"        :@"0",
                                       @"5万以下"      :@"4",
                                       @"5-600万"        :@"5",
                                       @"10-600万"       :@"10",
                                       @"600万+"         :@"600",
                                       
                                       @"全部":@"0",
                                       @"保本":@"bao",
                                       @"其他":@"other",
                                     
                                       
                                       @"全部"        :@"0",
                                       @"人民币"       :@"rmb",
                                       @"美元"        :@"my",
                                       @"英镑"        :@"yb",
                                       @"港币"        :@"gb",
                                       @"澳元"        :@"ay",
                                       };
    
    //
    //寻找当前选中的按钮
    //
    NSString *title = @"";
    for (UIButton *btn in self.subviews) {
        if ([btn isKindOfClass:[UIButton class]] && btn.selected == YES) {
            title = btn.titleLabel.text;
        }
    }

    NSDictionary *thisDic = nil;
    
    @try{
        //
        //当前选中的条件
        //
        if (self.tag == 0) {
            thisDic = @{@"type":_lastDictionary[title]};
        }else if (self.tag == 1){
            thisDic = @{@"date":_lastDictionary[title]};
        }else if (self.tag == 2){
            thisDic = @{@"start":_lastDictionary[title]};
        }else if (self.tag == 3){
            thisDic = @{@"baobenxingzhi":_lastDictionary[title]};
            
        }else if (self.tag == 4){
            thisDic = @{@"currency":_lastDictionary[title]};
            
        }
    }
    @catch(NSException *ex){
        NSLog(@"崩溃了");
    }
    @finally{
        return thisDic;
        
    }
    
    
    
}
@end
