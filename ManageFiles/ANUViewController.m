//
//  ANUViewController.m
//  ManageFiles
//
//  Created by Anuja on 9/14/14.
//  Copyright (c) 2014 AnujAroshA. All rights reserved.
//

#import "ANUViewController.h"
#import "ANUAppConstants.h"
#import "ANUFileOperations.h"

static NSString const *TAG = @"ANUViewController";

@interface ANUViewController () {
    ANUFileOperations *fileOperations;
    NSString *dirName;
    NSString *fileName;
    NSString *relativeFilePath;
}

@end

@implementation ANUViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	if (debugEnable) NSLog(@"%@ * viewDidLoad", TAG);
    
    // The memory used for instance variables is allocated when the object is first created (through alloc)
    fileOperations = [ANUFileOperations alloc];
    ANUAppConstants *appConstants = [ANUAppConstants alloc];
    
    // Access instance variables using as getters
    dirName = [appConstants baseDirectoryPath];
    fileName = [appConstants creatingFileName];
    
    relativeFilePath = [NSString stringWithFormat:@"%@/%@", dirName, fileName];
}

/**
 * Create a file in given location, if there is no relevant file already exists
 *
 * \param sender UIButton for execute file create functions
 */
- (IBAction)createAction:(UIButton *)sender {
    if (debugEnable) NSLog(@"%@ * createAction", TAG);
    
    BOOL isFileExists = [fileOperations checkFileInPath:relativeFilePath];

    if (isFileExists) {
        _placeHolderLabel.text = @"File Exists";
        
    } else {
        BOOL fileCreated = [fileOperations createFileinPath:dirName withName:fileName];

        if (fileCreated) {
            _placeHolderLabel.text = @"File Created";
        } else {
            _placeHolderLabel.text = @"File Not Created";
        }
    }
}

/**
 * Read the file in given location
 *
 * \param sender UIButton for execute file read functions
 */
- (IBAction)readAction:(UIButton *)sender {
    if (debugEnable) NSLog(@"%@ * readAction", TAG);
    
    BOOL isFileExists = [fileOperations checkFileInPath:relativeFilePath];
    
    if (isFileExists) {

        NSString *fileContent = [fileOperations readFileInPath:relativeFilePath];
        
        if (fileContent != nil && fileContent.length != 0) {
            _placeHolderLabel.text = fileContent;
        } else {
            _placeHolderLabel.text = @"There Is No Content";
        }
        
    } else {
        _placeHolderLabel.text = @"File Is Not Exists";
    }
}

/**
 * Delete the file in given location
 *
 * \param sender UIButton for execute file delete functions
 */
- (IBAction)deleteAction:(UIButton *)sender {
    if (debugEnable) NSLog(@"%@ * deleteAction", TAG);
    
    BOOL isFileExists = [fileOperations checkFileInPath:relativeFilePath];
    
    if (isFileExists) {
        BOOL isFileDeleted = [fileOperations deleteFileInPath:relativeFilePath];
        
        if (isFileDeleted) {
            _placeHolderLabel.text = @"File Deleted";
        } else {
            _placeHolderLabel.text = @"File Is Not Deleted";
        }
        
    } else {
        _placeHolderLabel.text = @"File Is Not Exists";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
