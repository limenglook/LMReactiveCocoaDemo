//
//  UITableViewCell+LM.h
//  LMCategory
//
//  Created by 李蒙 on 15/7/27.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (LM)

+ (instancetype)lm_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
