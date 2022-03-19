import vweb
import json
import net.http

const(
	keys = ['add_key_here']
)

struct App {
	vweb.Context
}

fn (mut app App) spam() vweb.Result {
	key := app.query['key']
	webhook := app.query['webhook']
	message := app.query['message']
	if key in keys {}
	else { return app.text(json.encode({"error": "Invalid Key Entered! "}))}
	if webhook == "" { return app.text(json.encode({"error": "Webhook Is Empty! "}))}
	if message == "" { return app.text(json.encode({"error": "Message Is Empty! "}))}
	if webhook.contains('https://') && webhook.contains('discord.com/api/webhooks/') {
		for {
			data := {
				"content": "$message"
				"username": "Spammed By Cat Api"
				"avatar_url": "https://th.bing.com/th/id/OIP.0WelhmRhSKKsseS07EhOcgHaEo?pid=ImgDet&rs=1"
			}
			payload := json.encode(data)
			http.post_json(webhook, payload) or { return app.text(json.encode({"error": "Failed To Spam Api"}))}
		}
	} else {
		return app.text(json.encode({"error": "Invalid Webhook Entered!"}))
	}
	return app.text('[x] Cat Webhook Spammer Api! \n[x] Usage -> localhost:port/spam/?key=key&webhook=webhook&message=message \n')
}

fn main(){
	vweb.run(&App{}, 8080)
}
