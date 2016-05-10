//
//  StrBool.m
//  e家洁1
//
//  Created by 孙月明 on 16/5/4.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "StrBool.h"

@implementation StrBool

- (BOOL) isBlankString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        
        return YES;
        
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        
        return YES;
        
    }
    
    return NO;
    
}
@end
