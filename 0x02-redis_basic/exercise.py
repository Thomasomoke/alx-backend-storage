#!/usr/bin/env python3
import redis
import uuid
from typing import Union, Callable, Optional
from functools import wraps


def count_calls(method: Callable) -> Callable:
    """Decorator to count the number of
    times a method is called."""
    @wraps(method)
    def wrapper(self, *args, **kwargs):
        """Wrap the method to increment the call count."""
        key = method.__qualname__
        self._redis.incr(key)  # Increment the call count in Redis
        return method(self, *args, **kwargs)  # Call the original method

    return wrapper


class Cache:
    def __init__(self):
        """Initialize the Cache instance with a Redis
        client and flush the database."""
        self._redis = redis.Redis()
        self._redis.flushdb()

    @count_calls
    def store(self, data: Union[str, bytes, int, float]) -> str:
        """Store data in Redis with a randomly generated key."""
        key = str(uuid.uuid4())
        self._redis.set(key, data)
        return key

    def get(self, key: str, fn: Optional[Callable] = None) -> Union[
            str, bytes, int, float, None]:
        """Retrieve data from Redis and apply the conversion
        function if provided."""
        value = self._redis.get(key)
        if value is None:
            return None
        if fn:
            return fn(value)
        return value

    def get_str(self, key: str) -> Optional[str]:
        """Retrieve data as a UTF-8 decoded string."""
        return self.get(key, fn=lambda d: d.decode('utf-8'))

    def get_int(self, key: str) -> Optional[int]:
        """Retrieve data as an integer."""
        return self.get(key, fn=int)
