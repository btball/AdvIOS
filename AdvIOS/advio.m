//
//  advio.c
//  adv770
//
//  Created by Brian Ball on 12/4/14.
//  Copyright (c) 2014 Brian Ball.
//  Licensed under the Modified BSD Licence (see the supplied License file).
//

#include "advio.h"
#import <Foundation/Foundation.h>
NSFileManager *filemgr;
NSString *dataFile;
NSString *docsDir;
NSArray *dirPaths;
char * advopen (const char * filename, const char * mode){
    char * ret;
    NSFileManager *filemgr;
    NSString *dataFile;
    NSString *docsDir;
    NSArray *dirPaths;
    
    filemgr = [NSFileManager defaultManager];
    
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    dataFile = [docsDir
                stringByAppendingPathComponent: [NSString stringWithCString:filename encoding:NSUTF8StringEncoding]];
    char *ptr = [dataFile cStringUsingEncoding:NSUTF8StringEncoding];
    ret = fopen(ptr, mode);
    if (ret == NULL) {
        printf("\n fopen returned NULL errno = %d\n", errno);
    }
    return ret;
}
int advunlink (const char * filename){
    NSFileManager *filemgr;
    NSString *dataFile;
    NSString *docsDir;
    NSArray *dirPaths;
    int ret;
    filemgr = [NSFileManager defaultManager];
    
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    dataFile = [docsDir
                stringByAppendingPathComponent: [NSString stringWithCString:filename encoding:NSUTF8StringEncoding]];
    char *ptr = [dataFile cStringUsingEncoding:NSUTF8StringEncoding];
    ret = unlink(ptr);
    if (ret != 0) {printf("unlink non-zero return ""%d %s \n", errno, filename);}
    return ret;
}
int advclose (const char * filename){
    int ret;
    ret = fclose(filename);
    return ret;
    
}
char * advopendir (const char * dirname){
    char * ret;
    NSFileManager *filemgr;
    NSString *docsDir;
    NSArray *dirPaths;
    char *dataFile;
    
    filemgr = [NSFileManager defaultManager];
    
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    dataFile = [docsDir cStringUsingEncoding:NSUTF8StringEncoding];
    ret = opendir(dataFile);
    if (ret == NULL) {
        printf("\n opendir returned NULL !\n");
        printf("errno = ");
        printf("%d",errno);
    }
    return ret;
    
}
struct dirent *advreaddir(DIR *dirp) {

    return readdir(dirp);

}
