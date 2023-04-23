import openai
import json
import requests
from flask import escape

openai.api_key = "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"
API_URL = "https://api.openai.com/v1/engines/davinci/completions"

def gpt_cloud_function(request):
    """Responds to any HTTP request.
    Args:
        request (flask.Request): HTTP request object.
    Returns:
        The response text or any set of values that can be turned into a
        Response object using
        `make_response <http://flask.pocoo.org/docs/1.0/api/#flask.Flask.make_response>`.
    """
    try:
        response = fetch_and_generate_response(request)
        return response
    except Exception as e:
        return str(e)
    

def fetch_and_generate_response(request):
    request_json = request.get_json()
    if request.args and 'input' in request.args:
        prompt_text = request.args.get('input')
    elif request_json and 'input' in request_json:
        prompt_text = request_json['input']
    else:
        return 'Please provide an input string as a query parameter or in JSON format.'

    response = openai.Completion.create(
        model="text-davinci-003",
        prompt=prompt_text,
        max_tokens=300,
        temperature=0,
    )

    if response:
        return json.dumps(response.choices[0].text.strip())
    else:
        raise Exception("Failed to generate response from OpenAI API")