//
//  ANUFileOperations.m
//  ManageFiles
//
//  Created by Anuja on 9/14/14.
//  Copyright (c) 2014 AnujAroshA. All rights reserved.
//

#import "ANUFileOperations.h"
#import "ANUAppConstants.h"

static NSString const *TAG = @"ANUFileOperations";

@implementation ANUFileOperations

/**
 * Getting the Application Documents file path
 *
 * @return NSString - Absolute path of the Documents directory
 */
- (NSString *)documentsDirectoryPath {
    if (debugEnable) NSLog(@"%@ * documentsDirectoryPath", TAG);
    
    /*
     * Creates a list of directory search paths
     *
     * NSDocumentDirectory = searching for Documents directory
     * NSUserDomainMask = inside user's home directory
     * YES = Expandind tilde into it's real path
     */
    NSArray *directoryPathsArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    if (debugEnable) NSLog(@"%@ # directoryPathsArray = %@", TAG, directoryPathsArray);
    
    NSString *documentsDirectory = [directoryPathsArray objectAtIndex:0];
//    if (debugEnable) NSLog(@"%@ # documentsDirectory = %@", TAG, documentsDirectory);
    
    return documentsDirectory;
}

/**
 * Check existency of a given file
 *
 * \param relativeFilePath Relative path of the file
 *
 * @return BOOL whether file exists or not
 */
- (BOOL)checkFileInPath:(NSString *)relativeFilePath {
    if (debugEnable) NSLog(@"%@ * checkFileInPath", TAG);
    
    NSString *absoluteFilePath = [NSString stringWithFormat:@"%@/%@", [self documentsDirectoryPath], relativeFilePath];

    BOOL fileExistency = [[NSFileManager defaultManager] fileExistsAtPath:absoluteFilePath];
    
    return fileExistency;
}

/**
 * Create a file with the given name inside given directory
 *
 * \param relativePath Directories hirarchy that file should create
 * \param fileName Name of the creating file
 *
 * @return BOOL Successibility of file creation
 */
- (BOOL)createFileinPath:(NSString *)relativePath withName:(NSString *)fileName {
    if (debugEnable) NSLog(@"%@ * createFile: name", TAG);

    NSString *creatingDirPath = [NSString stringWithFormat:@"%@/%@/", [self documentsDirectoryPath], relativePath];
    
    /*
     * Create directory in the given path
     * If there are subdirectories mentioned in given path, create those too
     * The creating directory gets default attributes
     */
    [[NSFileManager defaultManager] createDirectoryAtPath:creatingDirPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSError *errorWritingFile;
    NSString *fileContent = @"Never give up";
    NSString *absFilePath = [NSString stringWithFormat:@"%@%@", creatingDirPath, fileName];
    
    // Write the content to the file in the given path using given encoding system
    BOOL fileCreateSuccessibility = [fileContent writeToFile:absFilePath atomically:YES encoding:NSUTF8StringEncoding error:&errorWritingFile];
    
    return fileCreateSuccessibility;
}

/**
 * Read the file content in the given path
 *
 * \param relativeFilePath FIle path relative to Documents directory
 *
 * @return NSString File content as string value
 */
- (NSString *)readFileInPath:(NSString *)relativeFilePath {
    if (debugEnable) NSLog(@"%@ * readFileInPath", TAG);
    
    NSString *absoluteFilePath = [NSString stringWithFormat:@"%@/%@", [self documentsDirectoryPath], relativeFilePath];
    
    NSError *readingError;
    
    NSString *fileContent = [NSString stringWithContentsOfFile:absoluteFilePath encoding:NSUTF8StringEncoding error:&readingError];

    return fileContent;
}

/**
 * Delete file in the given path
 * 
 * \param relativeFilePath FIle path relative to Documents directory
 *
 * @return BOOL Whether file deleted or not
 */
- (BOOL)deleteFileInPath:(NSString *)relativeFilePath {
    if (debugEnable) NSLog(@"%@ * deleteFileInPath", TAG);
    
    NSString *absoluteFilePath = [NSString stringWithFormat:@"%@/%@", [self documentsDirectoryPath], relativeFilePath];
    
    // If the given path is a directory, the contents of the will be removed recursively
    BOOL isFileDeleted = [[NSFileManager defaultManager] removeItemAtPath:absoluteFilePath error:nil];
    
    return isFileDeleted;
}

@end
