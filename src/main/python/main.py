import time
import string
import cv2
import imutils
import numpy as np
import pytesseract

pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files\Tesseract-OCR\\tesseract'
#3/6/10/11/15/22
f = open('C:/Users/irgal/Desktop/project/Auto-Vision-project/src/main/python/nameFile.txt', 'r')
strr = f.readline()
img = cv2.imread('C:\Auto_Vision\\' + strr, cv2.IMREAD_COLOR)
img = cv2.resize(img, (600, 400))

gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
gray = cv2.bilateralFilter(gray, 30, 15, 15)
edged = cv2.Canny(gray, 30, 600)

contours = cv2.findContours(edged.copy(), cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
contours = imutils.grab_contours(contours)
contours = sorted(contours, key=cv2.contourArea, reverse=True)[:30]
screenCnt = None

for c in contours:

    peri = cv2.arcLength(c, True)
    approx = cv2.approxPolyDP(c, 0.015 * peri, True)

    if len(approx) == 4:
        screenCnt = approx
        break

if screenCnt is None:
    detected = 0
    print("No contour detected")
else:
    detected = 1

if detected == 1:
    cv2.drawContours(img, [screenCnt], -1, (0, 0, 255), 3)

mask = np.zeros(gray.shape, np.uint8)
new_image = cv2.drawContours(mask, [screenCnt], 0, 255, -1, )
new_image = cv2.bitwise_and(img, img, mask=mask)

(x, y) = np.where(mask == 255)
(topx, topy) = (np.min(x), np.min(y))
(bottomx, bottomy) = (np.max(x), np.max(y))
Cropped = gray[topx:bottomx + 1, topy:bottomy + 1]
text = pytesseract.image_to_string(Cropped, config='--psm 8', lang='rus')
i = 1
text=text.translate({ord(c): None for c in string.whitespace})
b=0
for x in range(2):
    text = text.replace(" ", "")
    text = text.replace(".", "")
    text = text.replace(",", "")
    text = text.replace("-", "")
    text = text.replace("/", "")
    text = text.replace("_", "")
    text = text.replace(":", "")
    text = text.replace("  ", "")
    text = text.replace("!", "")
    text = text.replace("|", "")
    text = text.replace("@", "")
    text = text.replace(";", "")
    text = text.replace('"', "")
    text = text.replace('*', "")
    text = text.replace('+', "")
    text = text.replace("'", "")
    text = text.replace("`", "")
    text = text.replace("‘", "")
    text = text.replace("   ", "")
    text = text.replace("(", "")
    text = text.replace(")", "")
    text = text.replace("{", "")
    text = text.replace("}", "")
    text = text.replace("[", "")
    text = text.replace("]", "")
    text = text.replace("?", "")
    text = text.replace(">", "")
    text = text.replace("<", "")
    text = text.replace("$", "")
    text = text.replace("‚", "")
while len(text) <=7 or b>0:
    i += 50
    if i > 200:
        break
    Cropped = gray[topx:bottomx + 1, topy:bottomy + i]
    text = pytesseract.image_to_string(Cropped, config='--psm 8', lang='rus')
    text = text.translate({ord(c): None for c in string.whitespace})
    l = list(text)
    try:
        if l[7] != 0 or l[7] != 1 or l[7] != 2 or l[7] != 3 or l[7] != 4 or l[7] != 5 or l[7] != 6 or l[7] != 7 or l[7] != 8 or l[7] != 9:
            b = 2
    except:
        print("--")
    for x in range(2):
        text = text.replace(" ", "")
        text = text.replace(".", "")
        text = text.replace(",", "")
        text = text.replace("-", "")
        text = text.replace("/", "")
        text = text.replace("_", "")
        text = text.replace(":", "")
        text = text.replace("  ", "")
        text = text.replace("!", "")
        text = text.replace("|", "")
        text = text.replace("@", "")
        text = text.replace(";", "")
        text = text.replace('"', "")
        text = text.replace('*', "")
        text = text.replace('+', "")
        text = text.replace("'", "")
        text = text.replace("`", "")
        text = text.replace("‘", "")
        text = text.replace("   ", "")
        text = text.replace("(", "")
        text = text.replace(")", "")
        text = text.replace("{", "")
        text = text.replace("}", "")
        text = text.replace("[", "")
        text = text.replace("]", "")
        text = text.replace("?", "")
        text = text.replace(">", "")
        text = text.replace("<", "")
        text = text.replace("$", "")
        text = text.replace("‚", "")
        b=b-1
i = len(text) - 9
if i > 0:
    text = text[:-i]
li = list(text)
if li[0] == "0":
    li[0] = 'О'
if li[4] == "0":
    li[4] = 'О'
if li[5] == "0":
    li[5] = 'О'
if li[3] == "Л":
    li[3] = '1'
if li[7] == "А":
    li[7] = '7'
if li[6] == "^":
    li[6] = '1'
text = ''.join(li)
text=text.upper()

print(text)
