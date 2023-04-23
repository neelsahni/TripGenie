import openai
import json
import requests
from flask import escape

openai.api_key = "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"
API_URL = "https://api.openai.com/v1/engines/davinci-codex/completions"

def fetch_and_generate_response(request):
    request_json = request.get_json()
    if request.args and 'url' in request.args:
        prompt_URL = request.args.get('url')
    elif request_json and 'url' in request_json:
        prompt_URL = request_json['url']
    else:
        return 'Please provide a URL as a query parameter or in JSON format.'

    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {openai.api_key}"
    }

    response = requests.get(prompt_URL)
    if response.ok:
        prompt_text = response.text.strip()
    else:
        raise Exception("Failed to fetch prompt from URL")
    
    data = {
        "prompt": prompt_text,
        "max_tokens": 100,
        "temperature": 0.7,
    }
    response = requests.post(API_URL, headers=headers, json=data)

    if response.ok:
        return response.text
    else:
        raise Exception("Failed to generate response from OpenAI API")