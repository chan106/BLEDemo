//
//  BLEModel.h
//  BLEDemo
//
//  Created by Guo.JC on 2017/7/8.
//  Copyright © 2017年 Guo.JC. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CBPeripheral;

@interface BLEModel : NSObject

@property (nonatomic, strong) CBPeripheral *peripheral;
@property (nonatomic, strong) NSNumber *rssi;
@property (nonatomic, strong) NSDictionary *advertisementData;

- (instancetype)initWithPeripheral:(CBPeripheral *)peripheral
                              rssi:(NSNumber *)rssi
                 advertisementData:(NSDictionary *)advertisementData;

@end
