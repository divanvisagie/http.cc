#include <iostream>
#include <cstdlib>
#include <map>
#include <native/native.h>

using namespace std;
using namespace native::http;

typedef void (*createServer_cb)(request&, response&);

class HttpServer {

  private:
    http server;
    createServer_cb http_handler_cb;
    
  public:

    HttpServer(createServer_cb callback){
      http_handler_cb = callback;
    }

    HttpServer listen(std::string ip, int port){
      bool listening = server.listen(ip, port, http_handler_cb);
      
    } 
};

HttpServer* createServer( createServer_cb callback ){

  return new HttpServer(callback);
}

#export HttpServer as HttpServer
#export createServer as createServer