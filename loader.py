#!/usr/bin/env python

from zipfile import ZipFile
import json
import urllib2
import os

ZIP_PATH = os.environ["ZIP_PATH"]
BASE_URL = os.environ["BASE_URL"]

assert ZIP_PATH, "No zip path"
assert BASE_URL, "No base URL"


def read_zip (path):
    zfile = ZipFile(path, 'r')
    return (json.loads(zfile.read(name))
            for name in zfile.namelist()
            if name.endswith(".json"))


def call_http (entity, item):
    url = "%s/%s/new" % (BASE_URL, entity)
    data = json.dumps(item)
    resp = urllib2.urlopen(url, data)
    assert resp.getcode() == 200, str(item)


def load_data (data):
    entity = data.keys()[0]
    items = data[entity]
    for item in items:
        call_http(entity, item)


def main ():
    for data in read_zip(ZIP_PATH):
        load_data(data)


if __name__ == "__main__":
    main()
