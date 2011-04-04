require 'eventmachine'
require File.dirname(__FILE__) + '/em-websocket/em-websocket'
require 'em-mysqlplus'


EventMachine.run{
  $db = EventMachine::MySQL.new(:host => "localhost", :username => "root", :database => "undercurrents_development")
  
  $channels   = {}
  $webclients = {}
  ws_server = EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 8080, :debug => true) do |ws|
    ws.onopen{|req|
      # Attach this socket to the correct channel.
      path = req["Path"].gsub("/", "")
      if $channels[path].nil?
        $channels[path] = EventMachine::Channel.new
      end
      
      sid = $channels[path].subscribe { |msg| ws.send msg }      
      $webclients[sid] = true

      ws.onmessage do |msg|
      # Here, we should have some kind of command-parser, to allow the gui to query for stuff using the 
      # sockets? Or should that perhaps be done using AJAX?
       $channels[path] << msg
      end

      ws.onclose{
        $channels[path].unsubscribe(sid)
        $webclients.delete(sid)
      }      

    }
  end  
  
}