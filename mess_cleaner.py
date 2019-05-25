#!/usr/bin/python3

import sys, os

def clean_mess(original_filename):

    if not os.path.isfile(original_filename):
        print("File does not exist!!!")
        print("Exiting...")
        sys.exit(1)


    # Original filename splited
    ofs = original_filename.split('_')
    new_filename = ofs[1].replace('ich', 'M') + '_' + ofs[2] + '_' + ofs[3] + '_' + ofs[4] + '.' + ofs[6].split('.')[1]

    folder_name = ofs[3] + '_' + ofs[4]

    if os.path.exists(folder_name):
        print("Directory already exists!!!")
        print("Exiting...")
        sys.exit(1)
    else:
        os.mkdir(folder_name)

    # Moving file
    os.rename(original_filename, folder_name + '/' + original_filename)

    # Renaming file
    os.chdir(folder_name)
    os.rename(original_filename, new_filename)


if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("One argument required!!!")
        sys.exit(1)
    elif len(sys.argv) > 2:
        print("Too much arguments!!!")
        sys.exit(1)
    else:
        clean_mess(sys.argv[1])
