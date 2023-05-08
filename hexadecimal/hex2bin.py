byte_list = []

with open('hello-world.hex', 'r') as file:
    file_text = file.read()
    one_line_text = file_text.replace('\n', ' ')
    one_line_text = one_line_text.removesuffix(' ')
    
    opcode_list = one_line_text.split(' ')
    for opcode in opcode_list:
        byte_list.append(int(opcode, 16))


with open('hello-world.bin', 'wb') as file:
    file.write(bytes(byte_list))

