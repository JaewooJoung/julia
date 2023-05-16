using  QRCoders

url = "https://jaewoojoung.github.io/markdown/"

# decode message from QR code matrix
code = QRCode(url, width=0)
