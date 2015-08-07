//
//  UITableViewCell+LM.m
//  LMCategory
//
//  Created by 李蒙 on 15/7/27.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "UITableViewCell+LM.h"

@implementation UITableViewCell (LM)

+ (instancetype)lm_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
}

@end
