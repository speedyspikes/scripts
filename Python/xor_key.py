# Given hex-encoded ciphertext
hex_ciphertext = input("Enter the hex-encoded ciphertext: ")

# Convert from hex to bytes
ciphertext = bytes.fromhex(hex_ciphertext)

# Use "crypto{" as the known plaintext to determine the XOR key
known_plaintext = input("Enter the known plaintext: ").encode()
key = bytearray()

# Extract the repeating XOR key
for i in range(len(known_plaintext)):
    key.append(ciphertext[i] ^ known_plaintext[i])

# print("Recovered key (before extension):", key.decode(errors="ignore"))  # Print the key before extension

# Allow the user to modify the derived key
key_input = input(f"Derived key is '{key.decode(errors='ignore')}'. Press Enter to keep it or modify: ")
if key_input:
    key = bytearray(key_input.encode())

# Extend the key to match the full ciphertext length
full_key = (key * (len(ciphertext) // len(key) + 1))[:len(ciphertext)]

# Decrypt the full ciphertext
decrypted_flag = bytes([c ^ k for c, k in zip(ciphertext, full_key)])
print("Decrypted flag:", decrypted_flag.decode(errors="ignore"))  # Print the decrypted flag