//
//  BLETableViewCell.h
//  BLEDemo
//
//  Created by Guo.JC on 2017/7/8.
//  Copyright © 2017年 Guo.JC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BLEModel;

@interface BLETableViewCell : UITableViewCell

@property (nonatomic, strong) BLEModel *model;

@end
