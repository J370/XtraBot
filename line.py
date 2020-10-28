from cv2 import cv2
import numpy as np
vid = cv2.VideoCapture(0)

while(True): 

    ret, frame = vid.read()
    #frame = cv2.imread('rope2.jpg')

    gray = cv2.cvtColor(frame,cv2.COLOR_BGR2GRAY) 
    gaussian = cv2.GaussianBlur(frame, (5, 5), cv2.BORDER_DEFAULT)
    edges = cv2.Canny(gaussian,50,150,apertureSize = 3)

    # get center of img
    width  = frame.shape[1]
    midwidth = width // 2
    height = frame.shape[0]
    midheight = height // 2
    
    lines = cv2.HoughLinesP(edges,1,np.pi/180,150,minLineLength=250,maxLineGap=10000)
    if(lines is not None):
        x1sum, y1sum, x2sum, y2sum = 0, 0, 0, 0
        for x in range(0, len(lines)):
            for x1, y1, x2, y2 in lines[x]:
                if(y1 < midheight):
                    x2sum += x1
                    y2sum += y1
                    x1sum += x2
                    y1sum += y2
                else:
                    x2sum += x2
                    y2sum += y2
                    x1sum += x1
                    y1sum += y1

            cv2.line(frame, (x1, y1), (x2, y2), (0, 0, 255), 2)
            
        x1sum //= len(lines)
        x2sum //= len(lines)
        y1sum //= len(lines)
        y2sum //= len(lines)

        avgx = (x1sum+x2sum)//2

        if(avgx < midwidth -50):
            print(-1)
        elif(avgx > midwidth + 50):
            print(1)
        else:
            print(0)

        cv2.line(frame, (x1sum, y1sum), (x2sum, y2sum), (0, 255, 0), 2)
        cv2.circle(frame, ((x1sum+x2sum)//2, (y1sum+y2sum)//2), 2, (255,0,0), thickness=cv2.FILLED)

    cv2.circle(frame, (int(midwidth), int(midheight)), 2, (0,255,0), thickness=cv2.FILLED)

    cv2.imshow('frame', frame)
    if cv2.waitKey(1) & 0xFF == ord('q'): 
        break

vid.release()
cv2.destroyAllWindows()
