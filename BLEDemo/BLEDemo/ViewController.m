//
//  ViewController.m
//  BLEDemo
//
//  Created by Guo.JC on 2017/7/8.
//  Copyright © 2017年 Guo.JC. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "BLEModel.h"
#import "BLETableViewCell.h"

#pragma mark - 蓝牙服务及属性
#define         kServiceUUID                                        @"0001"
#define         kWriteUUID                                          @"0002"
#define         kNotifyUUID                                         @"0003"
#define         kReadMacUUID                                        @"0004"

@interface ViewController ()<CBCentralManagerDelegate, CBPeripheralDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) CBCentralManager *manager;
@property (nonatomic, strong) CBPeripheral *peripheral;
@property (nonatomic, strong) NSMutableArray *allPeripheral;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) CBCharacteristic *readCharacteristic;     //读取数据特性
@property (nonatomic, strong) CBCharacteristic *writeCharacteristic;    //写数据特性
@property (nonatomic, strong) CBCharacteristic *readMACCharacteristic;  //读取mac地址特性

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup{
    
    _manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
    _allPeripheral = [NSMutableArray array];
    
}

#pragma mark - - - - - -管理中心代理 - - - - - - - - -

#pragma mark 【2】监测蓝牙状态
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state){
        case CBManagerStateUnknown:
            NSLog(@"蓝牙-未知");
            break;
        case CBManagerStateUnsupported:
            NSLog(@"蓝牙-不支持");
            break;
        case CBManagerStateUnauthorized:
            NSLog(@"蓝牙-未授权");
            break;
        case CBManagerStatePoweredOff:{///蓝牙关闭
            NSLog(@"蓝牙-已关闭");
        }
            break;
        case CBManagerStateResetting:
            NSLog(@"蓝牙-复位");
            break;
        case CBManagerStatePoweredOn:{///蓝牙打开
            NSLog(@"蓝牙-已打开");
        }
            break;
    }
}

#pragma mark 【3】发现外部设备
- (void)centralManager:(CBCentralManager *)central
 didDiscoverPeripheral:(CBPeripheral *)peripheral
     advertisementData:(NSDictionary *)advertisementData
                  RSSI:(NSNumber *)RSSI{
    BLEModel *model = [[BLEModel alloc] initWithPeripheral:peripheral rssi:RSSI advertisementData:advertisementData];
    [_allPeripheral addObject:model];
}

#pragma mark 【4】连接外部蓝牙设备
- (void)connectToPeripheral:(CBPeripheral *)peripheral{
    if (!peripheral) {
        return;
    }
    [_manager connectPeripheral:peripheral options:nil];
}

#pragma mark 【5】连接外部蓝牙设备成功
- (void)centralManager:(CBCentralManager *)central
  didConnectPeripheral:(CBPeripheral *)peripheral{
    
}

#pragma mark 【6】连接外部蓝牙设备失败
- (void)centralManager:(CBCentralManager *)central
didFailToConnectPeripheral:(CBPeripheral *)peripheral
                 error:(NSError *)error{
    
}

#pragma mark 【7】蓝牙外设连接断开，自动重连
- (void)centralManager:(CBCentralManager *)central
didDisconnectPeripheral:(CBPeripheral *)peripheral
                 error:(NSError *)error{
    
}

#pragma mark - - - - - -外设代理 - - - - - - - - - 
#pragma mark 【1】寻找蓝牙服务
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    
    if(error){
        NSLog(@"外围设备寻找服务过程中发生错误，错误信息：%@",error.localizedDescription);
    }
    
    CBUUID *serviceUUID=[CBUUID UUIDWithString:kServiceUUID];
    for (CBService *service in peripheral.services) {
        
        if([service.UUID isEqual:serviceUUID]){
            [peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:kNotifyUUID],[CBUUID UUIDWithString:kWriteUUID],[CBUUID UUIDWithString:kReadMacUUID]] forService:service];
        }
    }
}

#pragma mark 【2】寻找蓝牙服务中的特性
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    if (error) {//报错直接返回退出
        NSLog(@"didDiscoverCharacteristicsForService error : %@", [error localizedDescription]);
        return;
    }
    for (CBCharacteristic *characteristic in service.characteristics)
    {
        
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:kNotifyUUID]]){
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            self.readCharacteristic = characteristic;
        }
        
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:kWriteUUID]]) {
            self.writeCharacteristic = characteristic;
        }
        
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:kReadMacUUID]]) {
            self.readMACCharacteristic = characteristic;
        }
    }
    if (_readCharacteristic && _writeCharacteristic) {
        
    }
}

#pragma mark 【8】直接读取特征值被更新后
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    __weak __typeof(self) weakSelf = self;
    
    if (error) {
        NSLog(@"更新特征值时发生错误，错误信息：%@",error.localizedDescription);
        return;
    }
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _allPeripheral.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BLETableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BLETableViewCell" forIndexPath:indexPath];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
