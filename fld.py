import cv2
# define a video capture object 
vid = cv2.VideoCapture(0)
  
while(True): 
      
    ret, frame = vid.read()
    grayimg = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    fld = cv2.ximgproc.createFastLineDetector()
    lines = fld.detect(grayimg)
    img = fld.drawSegments(grayimg,lines)

    cv2.imshow('frame', img)
    if cv2.waitKey(1) & 0xFF == ord('q'): 
        break

vid.release()
cv2.destroyAllWindows()
