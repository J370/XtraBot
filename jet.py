import cv2
import numpy as np
vid = cv2.VideoCapture(0)

while(True):

    ret, frame = vid.read()
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    gaussian = cv2.GaussianBlur(gray, (5, 5), cv2.BORDER_DEFAULT)
    edges = cv2.Canny(gaussian, 50, 50, apertureSize=3)
    lines = cv2.HoughLinesP(edges, 1, np.pi/180, 15,
                            minLineLength=30, maxLineGap=10)
    for x in range(0, len(lines)):
        for x1, y1, x2, y2 in lines[x]:
            cv2.line(frame, (x1, y1), (x2, y2), (0, 255, 0), 2)

    cv2.imshow('frame', frame)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

vid.release()
cv2.destroyAllWindows()
