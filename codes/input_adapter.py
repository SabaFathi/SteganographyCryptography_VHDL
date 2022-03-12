import re

file_directory = input("enter absolute path of directory file:\n")
file_input_name = input("enter name of input file:\n")
# file_output_name = input("enter name of output file:\n")
file_output_name = "test_data.txt"

file_input_path = file_directory + "\\" + file_input_name
file_output_path = file_directory + "\\" + file_output_name

file_input = open(file_input_path, "r")
file_output = open(file_output_path, "w")

headers = file_input.readline() + file_input.readline() + file_input.readline() + file_input.readline()
print(headers)

for line in file_input:
    line = re.sub("\s+", "\n", line)
    file_output.write(line)

file_input.close()
file_output.close()
