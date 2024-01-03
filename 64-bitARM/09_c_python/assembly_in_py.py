from ctypes import c_char_p, c_int, CDLL, create_string_buffer


lib_upper = CDLL('libup.so')
lib_upper.my_to_upper.argtypes = [c_char_p, c_char_p]
lib_upper.my_to_upper.restype = c_int
instr = create_string_buffer(b'This is a test!')
outstr = create_string_buffer(250)
strlen = lib_upper.my_to_upper(instr, outstr)
print(instr.value.decode())
print(outsr.value.decode())
print(f'len: {strlen}')
