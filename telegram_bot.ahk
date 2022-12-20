; Replace YOUR_BOT_TOKEN with your bot's token
botToken := "YOUR_BOT_TOKEN"

; Replace YOUR_CHAT_ID with the ID of the group chat
chatId := "YOUR_CHAT_ID"

; Variable to keep track of the last message that was processed
lastMessageId := 0

; Function to get the latest messages in the group chat
GetMessages()
{
    url := "https://api.telegram.org/bot" . botToken . "/getUpdates"
    data := "offset=" . lastMessageId . "&chat_id=" . chatId
    response := Get(url, data)
    parseResponse(response)
}

; Function to parse the response from the getUpdates API method
parseResponse(response)
{
    ; Extract the messages from the response
    messages := RegExMatch(response, "\"text\":\"(.*?)\"")

    ; Print the messages
    for i, message in messages
    {
        MsgBox % message1
        lastMessageId := RegExMatch(response, "\"update_id\":(\d+)")
    }
}

; Function to send a message to the group chat
SendMessage(message)
{
    url := "https://api.telegram.org/bot" . botToken . "/sendMessage"
    data := "chat_id=" . chatId . "&text=" . message
    Post(url, data)
}

; Function to send a picture to the group chat
SendPicture(picturePath)
{
    url := "https://api.telegram.org/bot" . botToken . "/sendPhoto"
    data := "chat_id=" . chatId . "&photo=" . picturePath
    Post(url, data)
}

; Example of sending a message to the group chat
SendMessage("Hello, group chat!")

; Example of sending a picture to the group chat
SendPicture("C:\path\to\picture.jpg")
