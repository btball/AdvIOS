//
//  ViewController.m
//  Console
//
//  Created by Brian Ball on 12/4/14.
//  Copyright (c) 2014 Brian Ball.
//  Licensed under the Modified BSD Licence (see the supplied License file).
//
#include <stdio.h>
#import "ViewController.h"
#import "version.h"
char *advturn(char*);
char cmd[160] ={0};
char buf[160] = {0};
char inp[160]= {0};
char *rptr = 0;
int histCount = 0;
int first_stop = 0;
#define maxhist 20
char *hist[maxhist+1][160] = {0};
char *command[160] = {0};
NSInteger oldValue;
NSString *html_break = @"<br><br>";
NSMutableString *htmlString;
char *logIO = 0;
int buflen = 160;
int bufptr = 0;  // offset for "next" copy into the buffer
int len = 0;  // Used for the size of what advturn returns to me
int realloc_len = 160; // initial value doesn't matter - this will be computed each time

@interface ViewController ()

- (IBAction)viewLog:(id)sender;
- (IBAction)restart:(id)sender;
- (IBAction)editingChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *myTextField;



@end

@implementation ViewController
@synthesize stepperOutlet;

void advlog (char *logline){
    len = strlen(logline);
    realloc_len = bufptr + len;
    realloc_len = realloc_len + 1;
    logIO = realloc (logIO, realloc_len);
    if (logIO != NULL){
        // We could probably do more here - but for now, if I can't realloc, then we'll just skip logging!
        strcpy(logIO+bufptr, logline);
        bufptr = bufptr + len;
    if (logIO == NULL) {printf("realloc failed, not able to log!\n");}
    }
}
char * advNewGame (void){
    strcpy(cmd, adv_version);
    first_stop = 0;
    return advturn(cmd);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.myTextField becomeFirstResponder];
    oldValue = stepperOutlet.value;
    // First call goes here
    
    histCount = 0;
    logIO = malloc(buflen + 1);  // Initial allocation
    memset(&hist[0], 0, sizeof(hist));
    oldValue = 0;
    stepperOutlet.value = 0;
    stepperOutlet.maximumValue = 0;
    bufptr = 0;
    rptr = advNewGame();
    advlog(rptr+1);
    NSString *htmlString = [NSString stringWithFormat:@"%s",rptr+1];
    [self.webView loadHTMLString:htmlString baseURL:nil];
    self.myTextField.text = @"?";

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // Second and subsequent calls go here ...
    if (first_stop == 1) {
        first_stop = 0;
        histCount = 0;
        memset(&hist[0], 0, sizeof(hist));
        oldValue = 0;
        stepperOutlet.value = 0;
        stepperOutlet.maximumValue = 0;
        bufptr = 0;
        rptr = advNewGame();
        advlog (rptr+1);
        NSString *obuf = [NSString stringWithFormat:@"%s",rptr+1];
        htmlString = [htmlString stringByAppendingString:obuf];
        [self.webView loadHTMLString:htmlString baseURL:nil];
        _myTextField.text = @"?";
        [self.myTextField becomeFirstResponder];
        return YES;
        
    }
    strcpy(inp ,[self.myTextField.text UTF8String]);
// Make sure I don't overflow history
    if (histCount == maxhist){
        int ix = 0;
        while (ix<maxhist){
            strcpy(hist[ix],hist[ix+1]);  // roll off the oldest entry
            ix = ix+1;
        }
        histCount = histCount - 1;
    }
    strcpy(hist[histCount], inp+1);
    advlog("<p style = 'color:red'>");
    advlog(inp);
    advlog("</p>");
    advlog("<br>");
    histCount = histCount +1;
    stepperOutlet.maximumValue = histCount;
    stepperOutlet.value = histCount;
    oldValue = histCount;
    strcpy(cmd, inp+1);
    rptr = advturn(cmd);
    advlog(rptr+1);
    if (*rptr != 'f') {
//        NSString *htmlString = [[NSString alloc] initWithUTF8String:rptr+1];
        NSString *obuf = [NSString stringWithFormat:@"%s",rptr+1];
        NSString *htmlString = @"<p style = 'color:red'>";
        htmlString  =  [htmlString stringByAppendingString:self.myTextField.text];
        htmlString = [htmlString stringByAppendingString:@"</p>"];
        htmlString  = [htmlString stringByAppendingString:html_break];
        htmlString = [htmlString stringByAppendingString:obuf];
        [self.webView loadHTMLString:htmlString baseURL:nil];
        self.myTextField.text = @"?";
        [self.myTextField becomeFirstResponder];
        return YES;
    }
    if (*rptr == 'f') {
        if (first_stop == 0) {
            // First time through display the score and final message
            first_stop = 1;
            NSString *htmlString = [NSString stringWithFormat:@"%s",rptr+1];
            [self.webView loadHTMLString:htmlString baseURL:nil];
            self.myTextField.text = @"?";
            [self.myTextField becomeFirstResponder];
            return YES;
            }
        // Already has the score and final message - time to restart
        histCount = 0;
        memset(&hist[0], 0, sizeof(hist));
        oldValue = 0;
        stepperOutlet.value = 0;
        stepperOutlet.maximumValue = 0;
        bufptr = 0;
        rptr = advNewGame();
        advlog (rptr+1);
        NSString *htmlString = [NSString stringWithFormat:@"%s",rptr+1];
        [self.webView loadHTMLString:htmlString baseURL:nil];
        _myTextField.text = @"?";
        [self.myTextField becomeFirstResponder];
        return YES;
        }
    return YES;
}


#define MAXLENGTH 160

- (BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    BOOL returnKey = [string rangeOfString: @"?"].location != NSNotFound;
    
    return newLength <= MAXLENGTH || returnKey;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)viewLog:(id)sender {

    NSString * displayBuf = [[NSString alloc]init];
//    displayBuf =  [NSString stringWithFormat:@"%s\n",logIO];
    NSString *htmlString = [NSString stringWithFormat:@"%s",logIO];
    [self.webView loadHTMLString:htmlString baseURL:nil];
//    _myConsoleDisplay.text = displayBuf;

}

- (IBAction)restart:(id)sender {
    if (first_stop == 1){
        histCount = 0;
        memset(&hist[0], 0, sizeof(hist));
        oldValue = 0;
        stepperOutlet.value = 0;
        stepperOutlet.maximumValue = 0;
        bufptr = 0;
        rptr = advNewGame();
        advlog (rptr+1);
        NSString *htmlString = [NSString stringWithFormat:@"%s",rptr+1];
        [self.webView loadHTMLString:htmlString baseURL:nil];
        _myTextField.text = @"?";
        [self.myTextField becomeFirstResponder];
        return ;
    }
        strcpy(cmd, "q");
        rptr = advturn(cmd);
        advlog(rptr+1);
        NSString *htmlString = [NSString stringWithFormat:@"%s",rptr+1];
        [self.webView loadHTMLString:htmlString baseURL:nil];
        _myTextField.text = @"?";
    }


- (IBAction)editingChanged:(id)sender {
    if ((strlen([self.myTextField.text UTF8String])) == 0) {
      _myTextField.text = @"?";
    }
}

- (IBAction)stepperAction:(id)sender {
    if (stepperOutlet.value>oldValue) {
        oldValue = oldValue +1;
    }
    
    else {
        oldValue = oldValue - 1;
    }
        strcpy(command, "?");
        strcat(command, hist[oldValue]);
        self.myTextField.text = [NSString stringWithCString:command encoding:[NSString defaultCStringEncoding]];
}
@end
