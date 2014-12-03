//
//  Container+AutoRegister.m
//  CoreMeta
//
//  Created by Scott Ferguson on 12/1/14.
//  Copyright (c) 2014 TrueFit Solutions. All rights reserved.
//


#import "Container+AutoRegister.h"
#import <objc/runtime.h>
#import <dlfcn.h>
#import <mach-o/ldsyms.h>


@implementation Container (AutoRegister)

- (void)autoRegister {
    
    unsigned int count;
    const char **classes;
    Dl_info info;
    
    dladdr(&_mh_execute_header, &info);
    classes = objc_copyClassNamesForImage(info.dli_fname, &count);
    
    for (int i = 0; i < count; i++) {
        Class class = NSClassFromString ([NSString stringWithCString:classes[i] encoding:NSUTF8StringEncoding]);
        
        if ([class conformsToProtocol:@protocol(AutoContainerRegister)]) {
            
           [self registerClass:class];
            
            unsigned int protocolCount;
            Protocol * __unsafe_unretained * protocols = class_copyProtocolList(class, &protocolCount);
            for (int i = 0; i < protocolCount; i++ ) {
                Protocol* protocol = protocols[i];
                if (!protocol_isEqual(protocol, @protocol(AutoContainerRegister))) {
                    [self registerClass:class forProtocol:protocol];
                }
            }
            
            if (protocols != NULL)
                free(protocols);
        }
    }
    
    if (classes != NULL)
        free(classes);
}

@end
