//
//  CoreMeta.h
//  CoreMeta
//
//  Created by Andrew Holt on 9/10/15.
//  Copyright © 2015 truefitsolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for CoreMeta.
FOUNDATION_EXPORT double CoreMetaVersionNumber;

//! Project version string for CoreMeta.
FOUNDATION_EXPORT const unsigned char CoreMetaVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <CoreMeta/PublicHeader.h>

#include "NSObject+IOC.h"
#include "NSObject+KVO.h"
#include "NSObject+Binding.h"
#include "NSObject+Perform.h"
#include "NSObject+Properties.h"

#include "NSString+Helpers.h"
#include "NSArray+Helpers.h"
#include "NSDictionary+Helpers.h"

#include "PropertyInfo.h"
#include "NSData+Base64.h"
#include "Reflection.h"
#include "Container.h"
#include "ContainerConvention.h"
#include "IdiomContainerConvention.h"