import requests


class IndexLibrary(object):
    def __init__(self, host, port=9200):
        self._host = host
        self._port = port

    def head_index(self, index):
        url = 'http://{host}:{port}/{index}'.format(
            host=self._host, port=self._port, index=index)
        return requests.head(url)

    def get_index(self, index):
        url = 'http://{host}:{port}/{index}'.format(
            host=self._host, port=self._port, index=index)
        return requests.get(url)

    def create_index(self, index, **kwargs):
        url = 'http://{host}:{port}/{index}'.format(
            host=self._host, port=self._port, index=index)
        data = {'settings': {}}
        for k, v in kwargs.items():
            data['settings'][k] = int(v)
        return requests.put(url, json=data)

    def delete_index(self, index):
        url = 'http://{host}:{port}/{index}'.format(
            host=self._host, port=self._port, index=index)
        return requests.delete(url)
