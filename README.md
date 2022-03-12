# SteganographyCryptography_VHDL
Enhance Data Security with Combination of Cryptography and Steganography Techniques, on FPGA

This system has two main components:

1- Steganography Encoder

![encoder](https://github.com/SabaFathi/SteganographyCryptography_VHDL/blob/main/images/stego_encoder.JPG?raw=true)

This component receives sensitive data and a cover image and hides the data inside the cover.
Users can choose the "security level". If set to "1", data will be encrypted and then hidden. If set to "0", plain data will be hidden.

The structural modeling is as follows:

![encoder structural](https://github.com/SabaFathi/SteganographyCryptography_VHDL/blob/main/images/stego_encoder_structural.JPG?raw=true)

2- Steganography Decoder

![decoder](https://github.com/SabaFathi/SteganographyCryptography_VHDL/blob/main/images/stego_decoder.JPG?raw=true)

This component does the same work but in opposite direction

The structural modeling is as follows:

![decoder structural](https://github.com/SabaFathi/SteganographyCryptography_VHDL/blob/main/images/stego_decoder_structural.JPG?raw=true)


**Later, the encryption method changed to a simplified version of AES.**
