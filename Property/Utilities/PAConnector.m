 

#import "PAConnector.h"
#import "PropertyAdvisorUtilities.h"
#import "AppDelegate.h"
#import "ASIHTTPRequest.h"

@implementation PAConnector

@synthesize RequestStatusCode;
@synthesize ResponseContent;
@synthesize ResponseHeaders;


-(BOOL) SendHttpRequest:(NSString *)message:(NSString *)url:(NSString *)authToken:(NSString *)FormMethod:(NSString *)ContentType

{
    
    if (FormMethod ==NULL || FormMethod==@"") {
        FormMethod=@"POST";
        
    }
    if (ContentType ==NULL || ContentType==@"") {
        ContentType=@"application/json";
        
    }
    AppDelegate *mainDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
  //  if (mainDelegate.GlobalConfigs.IsOnline==false) {
    //    return FALSE;
  //  }
    //send Data
    //  responseData= [[NSMutableData data] retain];
    
    NSURL *   theURL= [NSURL URLWithString:url];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:theURL];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [message length]];   
    
    [request addRequestHeader:@"Content-Type" value:ContentType]; 
    [request addRequestHeader:@"Content-Length" value:msgLength]; 
    // NSLog(@"%@",FormMethod);
    
    [request setRequestMethod:FormMethod]; 
    
    if (authToken !=NULL && authToken!=@"") {
        [request addRequestHeader:@"Authorize" value:authToken ];
        
    }
    
    if (message !=NULL && message!=@"") {
        
        [request appendPostData:[message dataUsingEncoding:NSUTF8StringEncoding]]; 
    }
    [request startSynchronous];  
    // NSLog(@"%d",request.responseStatusCode);
    
    
    //  NSLog(@"%@",url);
    
    
    //  responseString    
    if ([request error]) {
        //  NSLog(@"%@",[[request error]description]);
        return FALSE;
        
    }
    ResponseContent=[NSString stringWithFormat:@"%@",[request responseString]];
    
    ResponseHeaders=  request.responseHeaders;
    // NSLog(@"%@", [ResponseHeaders description]);
    RequestStatusCode = request.responseStatusCode;
    
    return TRUE;
    
}






@end
