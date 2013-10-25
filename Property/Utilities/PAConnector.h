

#import <Foundation/Foundation.h>


@interface PAConnector: NSObject {
// @public   NSHTTPURLResponse *CurrentHttpResponse ;
    NSString *content;
 @public   NSInteger RequestStatusCode;
   // NSURL *theURL;
 //   NSMutableData *responseData;
    NSMutableString *soapResults;
  //  NSDictionary *ResponseHeaders;
    NSString *ResponseContent;
    
    
}
@property (retain,nonatomic) NSString*  ResponseContent;
@property (readonly,assign) NSInteger RequestStatusCode;
//@property (readonly,assign) NSHTTPURLResponse* CurrentHttpResponse;
@property (readonly,assign)  NSDictionary *ResponseHeaders;
-(BOOL) SendHttpRequest:(NSString *)message:(NSString *)url:(NSString *)authToken:(NSString *)FormMethod:(NSString *)ContentType;
@end
