//
//  BLETableViewCell.m
//  BLEDemo
//
//  Created by Guo.JC on 2017/7/8.
//  Copyright © 2017年 Guo.JC. All rights reserved.
//

#import "BLETableViewCell.h"
#import "BLEModel.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface BLETableViewCell  ()

@property (weak, nonatomic) IBOutlet UILabel *BLEtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *BLERSSILabel;

@end

@implementation BLETableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(BLEModel *)model{
    _model = model;
    _BLEtitleLabel.text = model.peripheral.name;
    _BLERSSILabel.text = model.rssi.stringValue;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
