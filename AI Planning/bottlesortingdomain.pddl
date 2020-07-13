(define (domain objectdetection)
    (:predicates
      
        (motor ?motor1)
        (rotate ?motor1)
        (motordef ?motor2)
        (deflect ?motor2)
        (rgbSensewhite ?rgb1 )
        (colordetectwhite ?rgb1 )
        (rgbSensegreen ?rgb2 )
        (colordetectgreen ?rgb2 )
        (rgbSensebrown ?rgb3 )
        (colordetectbrown ?rgb3 )
        (peizo ?peizo)
        (vibration ?peizo)
        (lightsensor ?light)
        (clean ?light)
        
    )
    
    
    (:action RGBsensor_white
        :parameters (?rgb1)
        :precondition (and  (rgbSensewhite ?rgb1)  (not(colordetectwhite ?rgb1)))
        :effect (colordetectwhite ?rgb1)
    )
    
    (:action RGBsensor_green
        :parameters (?rgb2)
        :precondition (and  (rgbSensegreen ?rgb2)  (not(colordetectgreen ?rgb2)))
        :effect (colordetectgreen ?rgb2)
    )
    
    (:action RGBsensor_brown
        :parameters (?rgb3)
        :precondition (and  (rgbSensebrown ?rgb3)  (not(colordetectbrown ?rgb3)))
        :effect (colordetectbrown ?rgb3)
    )
    
    
    
    (:action rotateDisc_1
        :parameters (?motor1 ?rgb1 ?rgb2 ?rgb3 ?peizo ?light)
        :precondition (and  (motor ?motor1) (not(rotate ?motor1))
                            (or (rgbSensewhite ?rgb1) (colordetectwhite ?rgb1) (rgbSensegreen ?rgb2) (colordetectgreen ?rgb2) (rgbSensebrown ?rgb3) (colordetectbrown ?rgb3)
                            (peizo ?peizo) (vibration ?peizo) (lightsensor ?light)(clean ?light) 
                            )
                      )
        :effect (rotate ?motor1)
    )
    
    
    (:action deflect_1
        :parameters (?motor2 ?rgb1 ?rgb2 ?rgb3 ?peizo)
        :precondition (and (motordef ?motor2)(not(deflect ?motor2))
                      (or (rgbSensewhite ?rgb1) (colordetectwhite ?rgb1) (rgbSensegreen ?rgb2) (colordetectgreen ?rgb2) (rgbSensebrown ?rgb3) (colordetectbrown ?rgb3) (peizo ?peizo)(vibration ?peizo)
                      )  
                      )
        :effect (deflect ?motor2)
    )
    
    
    (:action vibration_1
        :parameters (?motor1 ?peizo)
        :precondition (and  (motor ?motor1) (not(rotate ?motor1))
                            (peizo ?peizo) (vibration ?peizo)
                      )
        :effect (rotate ?motor1)
    )
    
    (:action clean_1
        :parameters (?motor1 ?light)
        :precondition (and  (motor ?motor1) (not(rotate ?motor1))
                            (lightsensor ?light)(clean ?light)
                      )
        :effect (rotate ?motor1)
    )
    
   
    
    
    
    
    )