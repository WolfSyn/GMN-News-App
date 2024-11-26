import requests
import json
import random

# Replace with your GameSpot API
API_KEY = "93b1c0cfd2ecca30289fb1ae6fe1d48c31069aec"
BASE_URL = "https://www.gamespot.com/api"
HEADERS = {"User-Agent": "GameSpotAPI/1.0"}

def fetch_latest_news():
    """
    Fetches data from the GameSpot API about articles
    """
    endpoint = f"{BASE_URL}/articles/"
    params = {
        "api_key": API_KEY,
        "format": "json",
        "limit": 10, # Number of results to fetch
        "sort": "publish_date:desc" # Sort by publish date (latest published)
    }

    try:
        response = requests.get(endpoint, headers=HEADERS, params=params)
        response.raise_for_status() # check for HTTP errors
        data = response.json()

        # Extract relevant detail from the response
        news_articles = []
        for article in data.get("results", []):
            article_info = {
                "title": article.get("title"),
                "publish_date": article.get("publish_date"),
                "author": article.get("author"),
                "url": article.get("url"),
                "summary": article.get("deck") # short summary
            }
            news_articles.append(article_info)

        return news_articles

    except requests.exceptions.RequestException as e:
        print(f"Error fetching data: {e}")
        return None

def main():
    news = fetch_latest_news()
    if news:
        print("Latest News from GMN News:")
        for idx, article in enumerate(news, start=1):
            print(f"\nArticle {idx}:")
            print(f"Title: {article['title']}")
            print(f"Published Date: {article['publish_date']}")
            print(f"Author(s): {article['author']}")
            print(f"URL: {article['url']}")
            print(f"Summary: {article['summary']}")
            print(f"----------------------------------------------")
        else:
            print("Failed to fetch the latest news articles.")

if __name__ == "__main__":
    main()
