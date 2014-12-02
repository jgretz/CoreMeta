//
//  Container+AutoRegister.h
//  CoreMeta
//
//  Created by Scott Ferguson on 12/1/14.
//  Copyright (c) 2014 TrueFit Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Container.h"
#import "AutoContainerRegister.h"

@interface Container (AutoRegister)

// Registers any class that conforms to the AutoContainerRegister protocol with the container
-(void)autoRegister;

@end
