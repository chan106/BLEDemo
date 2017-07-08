//
//  BLEModel.m
//  BLEDemo
//
//  Created by Guo.JC on 2017/7/8.
//  Copyright © 2017年 Guo.JC. All rights reserved.
//

#import "BLEModel.h"

@implementation BLEModel

- (instancetype)initWithPeripheral:(CBPeripheral *)peripheral
                              rssi:(NSNumber *)rssi
                 advertisementData:(NSDictionary *)advertisementData{

    if (self = [super init]) {
        self.peripheral = peripheral;
        self.rssi = rssi;
        self.advertisementData = advertisementData;
    }
    return self;
}

@end
