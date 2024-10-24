#!/usr/bin/env python3
"""
cache class in __init__ method,store an instance
of Redis client and flush the instance
"""
import redis
import uuid
from typing import Union
"""importing relevant
modules
"""


class Cache:
    def __init__(self):
        """Initialize the Cache instance with
        a redis client and flush db
        """
        self._redis = redis.Redis()
        self._redis.flushdb()

    def store(self, data: Union[str, bytes, int, float]) -> str:
        """store data in Redis with a randomly generated key"""
        key = str(uuid.uuid4())
        self._redis.set(key, data)
        return key
