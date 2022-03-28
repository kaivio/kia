from Crypto.Cipher import AES
from Crypto.Hash import SHA256
from Crypto.Random import get_random_bytes


# AES-256-CBC size(32LE), iv, blocks
def cry(text:str, password:str) -> bytes:
    t = text.encode()
    p = password.encode()

    i = get_random_bytes(16)
    k = SHA256.new(i+p).digest()

    n = hex(len(t))[2:]
    n = "0" * (8-len(n)) + n
    s = bytes.fromhex(n)

    f = 32 - len(t) % 32
    if f < 32:
        t = t + b'\x00'*f

    cipher = AES.new(k, AES.MODE_CBC, iv=i)
    b = cipher.encrypt(t)

    return s+i+b


def decry(byte:bytes, password:str) -> str:
    s = byte[0:4]
    i = byte[4:20]
    b = byte[20:]

    p = password.encode()
    k = SHA256.new(i+p).digest()
    cipher = AES.new(k, AES.MODE_CBC, iv=i)
    t = cipher.decrypt(b)

    n = int(s.hex(), 16)

    return t[:n].decode()


from Crypto.Random import random
def test(text):
    p = list("布满了未来的信笺"*random.randint(1,10))
    random.shuffle(p)
    p = ''.join(p)
    cpt = cry(text,p)
    return decry(cpt,p)

for i in range(1020):
    text = '透明色夏天'* i
    text = list("布满了未来的信笺"*random.randint(1,100))
    random.shuffle(text)
    text = ''.join(text)

    detext = test(text)
    ok = text == detext
    print(f'{ok}\t{len(text)}\t{len(detext)}')
    if i < 10:
        print(detext)
