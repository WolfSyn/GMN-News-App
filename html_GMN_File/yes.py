from flask import Flask, jsonify, request, render_template
import requests
import os

app = Flask(__name__, template_folder='.') 

@app.route('/')
def index():
    return render_template('Main.html')


@app.route('/gaming-news')
def get_news():
    api_key = 'ebafa8a06ba549329d87e94b5fa6a95a'
    category = request.args.get('category', 'games')
    url = f'https://api.rawg.io/api/{category}?key={api_key}'
    response = requests.get(url)
    if response.status_code == 200:
        data = response.json()
        return jsonify(data['results'])
    else:
        return jsonify({'error': 'Unable to fetch news...'}), response.status_code
    
if __name__ == '__main__':
    app.run(debug=True)
