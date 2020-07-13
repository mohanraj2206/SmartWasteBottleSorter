(define (problem bottlesortingproblem) (:domain objectdetection )

(:objects 
rgbSensewhite1 rgbSensegreen1 rgbSensebrown1 motor3 motordef1 
)

(:init
   

    (rgbSensebrown rgbSensebrown1)
    (motor motor3)
    (motordef motordef1)
    
    
)

(:goal (and (rotate motor3)(deflect motordef1))
           
     
)


)