//
//  BM_NetAPIManager.h
//  MBDoctorClient
//
//  Created by 高泽民 on 15/10/30.
//  Copyright © 2015年 zm. All rights reserved.
//

#import "HKAFHTTPSessionManager.h"
#import "AFNetworking.h"

@interface BM_NetAPIManager : NSObject
+ (instancetype)sharedManager;

@end
