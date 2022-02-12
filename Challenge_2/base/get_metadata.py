import requests
import json

metadata_url = 'http://169.254.169.254/latest/'


def get_json(url, arr):
    value = {}
    for item in arr:
        updated_url = url + item
        r = requests.get(updated_url)
        text = r.text
        if item[-1] == "/":
            json_values = r.text.splitlines()
            value[item[:-1]] = get_json(updated_url, json_values)
        elif is_json(text):
            value[item] = json.loads(text)
        else:
            value[item] = text
    return value


def get_metadata():
    first_value = ["meta-data/"]
    result = get_json(metadata_url, first_value)
    return result


def get_metadata_json():
    metadata = get_metadata()
    metadata_json = json.dumps(metadata, indent=4, sort_keys=True)
    return metadata_json


if __name__ == '__main__':
    print(get_metadata_json())