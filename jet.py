import cv2
import numpy as np
vid = cv2.VideoCapture(0)
  
while(True): 
      
    ret, frame = vid.read()
    gray = cv2.cvtColor(frame,cv2.COLOR_BGR2GRAY) 
    gaussian = cv2.GaussianBlur(gray,(5,5),cv2.BORDER_DEFAULT)
    edges = cv2.Canny(gaussian,50,50,apertureSize = 3)
    lines = cv2.HoughLinesP(edges,1,np.pi/180,15,minLineLength=30,maxLineGap=10)
    print(lines)

    cv2.imshow('frame', edges)
    if cv2.waitKey(1) & 0xFF == ord('q'): 
        break

vid.release()
cv2.destroyAllWindows()
