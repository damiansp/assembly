from ctypes import c_char_p, c_int, CDLL, create_string_buffer


lib_upper = CDLL('./lib/libup.dylib')
lib_upper.my_to_upper.argtypes = [c_char_p, c_char_p]
lib_upper.my_to_upper.restype = [c_int]
in_str = create_string_buffer(b'This is a test!')
out_str = create_string_buffer(250)
str_len = lib_upper.my_to_upper(in_str, out_str)
print(in_str.value)
print(out_str.value)
print(f'len: {str_len}')
