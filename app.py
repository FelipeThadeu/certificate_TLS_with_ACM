arquivo2 = open("VPNconfig.ovpn", "a")


with open("clientvpn.ovpn") as file:
    for line in file:
        print(line)
        arquivo2.write(line)
        if line == "</ca>\n":
            arquivo2.write("\n")
            arquivo2.write("<cert>\n")
            with open("certificates/client.crt") as file2:
                c = 0
                for line2 in file2:
                    c += 1
                    if c > 64:
                        arquivo2.write(line2)
                arquivo2.write("</cert>\n")
                arquivo2.write("\n")
                arquivo2.write("<key>\n")
                with open("certificates/client.key") as file3:
                    for line3 in file3:
                        arquivo2.write(line3)
                    arquivo2.write("</key>\n")