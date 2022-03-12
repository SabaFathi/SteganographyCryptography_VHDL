
file_directory = input("enter absolute path of directory file:\n")
# file_input_name = input("enter name of input file:\n")
file_input_name = "test_out.txt"
file_output_name = input("enter name of output file:\n")
file_header1 = input("enter header 1\n")
file_header2 = input("enter header 2(width hight)\n")
file_header3 = input("enter header 3(max value of pixels)\n")

file_input_path = file_directory + "\\" + file_input_name
file_output_path = file_directory + "\\" + file_output_name

file_input = open(file_input_path, "r")
file_output = open(file_output_path, "w")

file_output.write(file_header1 + "\n")
file_output.write(file_header2 + "\n")
file_output.write(file_header3 + "\n")

file_input.readline()
file_input.readline()

for line in file_input:
    file_output.write(line)

file_input.close()
file_output.close()
