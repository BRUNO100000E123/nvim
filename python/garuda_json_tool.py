import json
import sys

def write_into(data):
    with open('.config/nvim/garuda.json', 'w') as json_file:
        json.dump(data, json_file, indent=4)

def read_from():
    with open('.config/nvim/garuda.json', 'r') as json_file:
        return json.load(json_file)

def create_folder():
    data = read_from()
    data[str(sys.argv[2])] = {}
    write_into(data)

def update_folder():
    data = read_from()
    data[sys.argv[3]] = data.pop(sys.argv[2])
    write_into(data)    

def insert_new_bookmark():
    data = read_from()
    itens = data[sys.argv[2]]
    itens[sys.argv[3]] = sys.argv[4]
    data[sys.argv[2]] = itens
    write_into(data)

def collect_bookmarks():
    return ''

def delete_bookmarks():
    return ''

def move_folders():
    return ''

def delete_folder():
    return ''

match int(sys.argv[1]):
    case 1:
        collect_bookmarks()
    case 2:
        delete_bookmarks()
    case 3:
        move_folders()
    case 4:
        insert_new_bookmark()
    case 5:
        create_folder()
    case 6:
        delete_folder()
    case 7:
        update_folder()
