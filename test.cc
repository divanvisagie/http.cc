#include <iostream>
#include <native/native.h>

using namespace native::http;

#require "./lib/http.cc" as http

void handler(request& req, response& res){
  res.set_status(200);
  res.set_header("Content-Type", "text/plain");
  res.end("C++ FTW\n");
}

int main(int argc, char* argv[]) {

  http.HttpServer *s = http.createServer(&handler);

  s->listen("0.0.0.0", 8080);

  return 0;
}