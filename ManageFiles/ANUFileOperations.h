//
//  ANUFileOperations.h
//  ManageFiles
//
//  Created by Anuja on 9/14/14.
//  Copyright (c) 2014 AnujAroshA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANUFileOperations : NSObject

- (BOOL)checkFileInPath:(NSString *)relativeFilePath;
- (BOOL)createFileinPath:(NSString *)relativePath withName:(NSString *)fileName;
- (NSString *)readFileInPath:(NSString *)relativeFilePath;
- (BOOL)deleteFileInPath:(NSString *)relativeFilePath;

@end
