require 'net/http'

require 'rubygems'
require 'json'

token ||= "184744924:AAHtoruO3uWtxN8HEqbot9iIyyyBvITHeYI"

updateMessages = lambda{
  $messages = Net::HTTP.get(URI('https://api.telegram.org/bot' + token + '/getUpdates'))
  $parsed_m = JSON.parse($messages)
  puts $parsed_m
}

updateMessages.call


#print("\nGib die gewünschte Chat-ID ein: ")
#chat_id = gets.chomp

#print("Gib einen Text ein: ")
#text = gets.chomp
loop do
  if Net::HTTP.get(URI('https://api.telegram.org/bot' + token + '/getUpdates')) != $messages
    updateMessages.call
    if $parsed_m["result"][-1]["message"]["entities"] != nil
    if $parsed_m["result"][-1]["message"]["entities"][0]["type"] == "bot_command"
      sent_text = $parsed_m["result"][-1]["message"]["text"]
      last_chat_id = $parsed_m["result"][-1]["message"]["chat"]["id"]
      
      puts "Received text => " + sent_text
      puts "From => " + last_chat_id.to_s
      
      case sent_text
      when "/ping" then
        puts Net::HTTP.get(URI('https://api.telegram.org/bot' + token + '/sendMessage?text=Pong!&chat_id=' + last_chat_id.to_s))
      when "/wtf" then
        puts Net::HTTP.get(URI('https://api.telegram.org/bot' + token + '/sendMessage?text=We are PortHack, a hacker assembly. We play around with blinking things.&chat_id=' + last_chat_id.to_s))
      end
    end
  end
 end
end
