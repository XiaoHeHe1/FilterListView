//
//  EachView.h
//  ChooseViewDemo
//
//  Created by YYY on 2018/12/27.
//  Copyright © 2018 YYY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EachView : UIView
+ (EachView *)makeEachViewWithTitle:(NSString *)title chList:(NSArray *)list;
- (NSDictionary*)getPostDic;
- (void)makeDefault;
@end

NS_ASSUME_NONNULL_END
