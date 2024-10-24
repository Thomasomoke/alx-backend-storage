#!/usr/bin/env python3
import requests
import redis
from functools import wraps
from time import time


# Initialize Redis client
redis_client = redis.Redis()


def cache_page(method):
    """Decorator to cache the result of the function."""
    @wraps(method)
    def wrapper(url: str) -> str:
        cache_key = f"cache:{url}"
        count_key = f"count:{url}"

        # Check if the URL is in the cache
        cached_result = redis_client.get(cache_key)
        if cached_result:
            # Increment access count and return cached result
            redis_client.incr(count_key)
            return cached_result.decode('utf-8')

        # Call the original method if not cached
        response = method(url)
        redis_client.setex(cache_key, 10, response)
        redis_client.incr(count_key)  # Increment access count

        return response

    return wrapper


@cache_page
def get_page(url: str) -> str:
    """Fetch HTML content from a URL."""
    response = requests.get(url)
    response.raise_for_status()  # Raise an error for bad responses
    return response.text


if __name__ == "__main__":
    # Test the get_page function
    url =
    "http://slowwly.robertomurray.co.uk/delay/3000/url/http://example.com"
    print(get_page(url))  # First call, fetches and caches the result
    print(get_page(url))  # Second call, returns cached result
