//
//  WeakStrongMacro.h
//  FunCorpAnatolyTestProject
//
//  Created by Анатолий Карельский on 07.09.18.
//  Copyright © 2018 steelhaus. All rights reserved.
//

#ifndef WeakStrongMacro_h
#define WeakStrongMacro_h

#define weakify __weak __typeof(self) weakSelf = self;

#define strongify \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong __typeof(weakSelf) self = weakSelf; \
_Pragma("clang diagnostic pop")

#endif /* WeakStrongMacro_h */
