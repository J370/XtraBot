import cv2
vid = cv2.VideoCapture(0)
  
while(True): 
      
    ret, frame = vid.read()
    gray = cv2.cvtColor(frame,cv2.COLOR_BGR2GRAY) 
    edges = cv2.Canny(gray,50,150,apertureSize = 3)

    cv2.imshow('frame', edges)
    if cv2.waitKey(1) & 0xFF == ord('q'): 
        break

vid.release()
cv2.destroyAllWindows()
