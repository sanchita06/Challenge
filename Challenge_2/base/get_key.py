from get_metadata import get_metadata

def get_key_value(key, var):
    if hasattr(var, 'items'):
        for k, v in var.items():
            if k == key:
                yield v
            if isinstance(v, dict):
                for result in get_key_value(key, v):
                    yield result
            elif isinstance(v, list):
                for d in v:
                    for result in get_key_value(key, d):
                        yield result


def find_key(key):
    metadata = get_metadata()
    return list(get_key_value(key, metadata))


if __name__ == '__main__':
    key = input("What key would you like to find?\n")
    print(find_key(key))