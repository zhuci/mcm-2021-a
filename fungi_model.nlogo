    extensions[py]

    breed [f1s f1]
    breed [f2s f2]
    breed [f3s f3]
    breed [f4s f4]
    breed [f5s f5]
    breed [f6s f6]
    breed [f7s f7]

    ;f1s-own [cur-growth1]
    ;f2s-own [cur-growth2]
    ;f3s-own [cur-growth3]
    ;f4s-own [cur-growth4]
    ;f5s-own [cur-growth5]
    ;f6s-own [cur-growth6]
    ;f7s-own [cur-growth7]

    patches-own [matter-decomp decomp? wait-time time-waited]
    
    turtles-own [rank]
     
    globals [cur-temp cur-moist
    f1color f2color f3color f4color f5color f6color f7color
    brown-hi brown-lo

    decomp-rate1  cur-growth1 cur-growth-rate1 new-growth1 amount-decomp1 temp-at-maxr1 moist-at-maxr1 rank1 max-rate1
    decomp-rate2  cur-growth2 cur-growth-rate2 new-growth2 amount-decomp2 temp-at-maxr2 moist-at-maxr2 rank2 max-rate2
    decomp-rate3  cur-growth3 cur-growth-rate3 new-growth3 amount-decomp3 temp-at-maxr3 moist-at-maxr3 rank3 max-rate3
    decomp-rate4  cur-growth4 cur-growth-rate4 new-growth4 amount-decomp4 temp-at-maxr4 moist-at-maxr4 rank4 max-rate4
    decomp-rate5  cur-growth5 cur-growth-rate5 new-growth5 amount-decomp5 temp-at-maxr5 moist-at-maxr5 rank5 max-rate5
    decomp-rate6  cur-growth6 cur-growth-rate6 new-growth6 amount-decomp6 temp-at-maxr6 moist-at-maxr6 rank6 max-rate6
    decomp-rate7  cur-growth7 cur-growth-rate7 new-growth7 amount-decomp7 temp-at-maxr7 moist-at-maxr7 rank7 max-rate7
    ]


    to setup
    clear-all
    set brown-hi 1
    set brown-lo 0

    ask patches [
        ; patches are ground litter or not
        ifelse random 100 < ground-litter-percent
        [set matter-decomp 0.80 set decomp? true
            set pcolor scale-color brown matter-decomp brown-hi brown-lo] 
        [set decomp? false set matter-decomp 0.20 set pcolor green]
        
        set wait-time 0 
        set time-waited 0
    ]

    set-default-shape turtles "fungi"

    initialize-vars

    sprout-fungi




    reset-ticks
    end

    to go
    calculate-growth-rate
  
    grow-fungi
    fight-fungi
    death-fungi
    decompose
    add-litter



    tick
    ;my-update-plots
    end

    to initialize-vars
    set cur-temp 22
    set cur-moist -0.5

    set cur-growth1 0
    set cur-growth2 0
    set cur-growth3 0
    set cur-growth4 0
    set cur-growth5 0
    set cur-growth6 0
    set cur-growth7 0
    
    calculate-growth-rate
    ;set cur-growth-rate1 1
    ;set cur-growth-rate2 5
    ;set cur-growth-rate3 10
    ;set cur-growth-rate4 15
    ;set cur-growth-rate5 20
    ;set cur-growth-rate6 25
    ;set cur-growth-rate7 30

    set new-growth1 0
    set new-growth2 0
    set new-growth3 0
    set new-growth4 0
    set new-growth5 0
    set new-growth6 0
    set new-growth7 0
  
    set decomp-rate1 0.0180
    set decomp-rate2 0.0474
    set decomp-rate3 0.0153
    set decomp-rate4 0.00878
    set decomp-rate5 0.0987
    set decomp-rate6 0.0598
    set decomp-rate7 0.0345

    set temp-at-maxr1 23.81
    set temp-at-maxr2 28.54
    set temp-at-maxr3 29.23
    set temp-at-maxr4 26.94
    set temp-at-maxr5 30.4
    set temp-at-maxr6 27.3
    set temp-at-maxr7 33.42

    set moist-at-maxr1 -.76
    set moist-at-maxr2 -.428
    set moist-at-maxr3 -.597
    set moist-at-maxr4 -.537
    set moist-at-maxr5 -.26
    set moist-at-maxr6 -.24
    set moist-at-maxr7 -.425

    set rank1 0.374
    set rank2 0.878
    set rank3 0.516
    set rank4 0.278
    set rank5 0.788
    set rank6 0.284
    set rank7 0.634 

    set max-rate1 .768
    set max-rate2 11.89
    set max-rate3 7.08
    set max-rate4 1.31
    set max-rate5 12.16
    set max-rate6 7.55
    set max-rate7 10.65

    set f1color red
    set f2color orange
    set f3color yellow
    set f4color cyan
    set f5color blue
    set f6color violet
    set f7color magenta

    end

    to sprout-fungi
    ask n-of initial-fungi-per-cluster patches with [decomp? and not any? other turtles-here]
    [sprout-f1s 1 [set color red set rank rank1]]

    ask n-of initial-fungi-per-cluster patches with [decomp? and not any? other turtles-here]
    [sprout-f2s 1 [set color orange set rank rank2]]

    ask n-of initial-fungi-per-cluster patches with [decomp? and not any? other turtles-here]
    [sprout-f3s 1 [set color yellow set rank rank3]]

    ask n-of initial-fungi-per-cluster patches with [decomp? and not any? other turtles-here]
    [sprout-f4s 1 [set color cyan set rank rank4]]

    ask n-of initial-fungi-per-cluster patches with [decomp? and not any? other turtles-here]
    [sprout-f5s 1 [set color blue set rank rank5]]

    ask n-of initial-fungi-per-cluster patches with [decomp? and not any? other turtles-here]
    [sprout-f6s 1 [set color violet set rank rank6]]

    ask n-of initial-fungi-per-cluster patches with [decomp? and not any? other turtles-here]
    [sprout-f7s 1 [set color magenta set rank rank7]]

    end

    to calculate-growth-rate
        ifelse cur-temp <= temp-at-maxr1
        [set cur-growth-rate1 3 * (.0224 * cur-temp - .24)]
        [set cur-growth-rate1 3 * (-.0568 * cur-temp + 2.12)]

        ifelse cur-moist <= moist-at-maxr1
        [set cur-growth-rate1 cur-growth-rate1 * (-.443 * cur-moist + .66)]
        [set cur-growth-rate1 cur-growth-rate1 * (.12 * cur-moist + 1.09)]

        ifelse cur-temp <= temp-at-maxr2
        [set cur-growth-rate2 3 * (.451 * cur-temp - .93)*(-.637 * cur-moist + .66)]
        [set cur-growth-rate2 3 * (-1.44 * cur-temp + 52.85)*(.169 * cur-moist + 1.09)]

        ifelse cur-moist <= moist-at-maxr2
        [set cur-growth-rate2 cur-growth-rate2 * (-.796 * cur-moist + .66)]
        [set cur-growth-rate2 cur-growth-rate2 * (.23 * cur-moist + 1.1)]

        ifelse cur-temp <= temp-at-maxr3
        [set cur-growth-rate3 3 * (0.33 * cur-temp - 2.57)*(-.524 * cur-moist + .68)]
        [set cur-growth-rate3 3 * (-1.21 * cur-temp + 42.4)*(.172 * cur-moist + 1.1)]

        ifelse cur-moist <= moist-at-maxr3
        [set cur-growth-rate3 cur-growth-rate3 * (-.541 * cur-moist + .68)]
        [set cur-growth-rate3 cur-growth-rate3 * (.197 * cur-moist + 1.12)]
        
        ifelse cur-temp <= temp-at-maxr4
        [set cur-growth-rate4 3 * (0.0616 * cur-temp - .34)*(-.620 * cur-moist + .67)]
        [set cur-growth-rate4 3 * (-.152 * cur-temp + 5.42)*(.231 * cur-moist + 1.12)]

        ifelse cur-moist <= moist-at-maxr4
        [set cur-growth-rate4 cur-growth-rate4 * (-.637 * cur-moist + .66)]
        [set cur-growth-rate4 cur-growth-rate4 * (.169 * cur-moist + 1.09)]
        
        ifelse cur-temp <= temp-at-maxr5
        [set cur-growth-rate5 3 * (0.438 * cur-temp - 1.11)*(-1.32 * cur-moist + .66)]
        [set cur-growth-rate5 3 * (-1.60 * cur-temp + 60.81)*(.318 * cur-moist + 1.08)]
 
        ifelse cur-moist <= moist-at-maxr5
        [set cur-growth-rate5 cur-growth-rate5 * (-1.32 * cur-moist + .66)]
        [set cur-growth-rate5 cur-growth-rate5 * (.318 * cur-moist + 1.08)]

        ifelse cur-temp <= temp-at-maxr6
        [set cur-growth-rate6 3 * (.423 * cur-temp - 4.62)*(-.443 * cur-moist + .66)]
        [set cur-growth-rate6 3 * (-1.35 * cur-temp + 44.35)*(.12 * cur-moist + 1.09)]

        ifelse cur-moist <= moist-at-maxr6
        [set cur-growth-rate6 cur-growth-rate6 * (-1.47 * cur-moist + .65)]
        [set cur-growth-rate6 cur-growth-rate6 * (.327 * cur-moist + 1.08)]
 
        ifelse cur-temp <= temp-at-maxr7
        [set cur-growth-rate7 3 * (.405 * cur-temp - 3.07)*(-.97 * cur-moist + .66)]
        [set cur-growth-rate7 3 * (-1.27 * cur-temp + 53.01)*(.281 * cur-moist + 1.1)]

        ifelse cur-moist <= moist-at-maxr7
        [set cur-growth-rate7 cur-growth-rate7 * (-.772 * cur-moist + .67)]
        [set cur-growth-rate7 cur-growth-rate7 * (.24 * cur-moist + 1.1)]
    end 
    
    to grow-fungi
    set cur-growth1  cur-growth-rate1 + cur-growth1
    set cur-growth2  cur-growth-rate2 + cur-growth2
    set cur-growth3  cur-growth-rate3 + cur-growth3
    set cur-growth4  cur-growth-rate4 + cur-growth4
    set cur-growth5  cur-growth-rate5 + cur-growth5
    set cur-growth6  cur-growth-rate6 + cur-growth6
    set cur-growth7  cur-growth-rate7 + cur-growth7

    ;f1
    if cur-growth1 > 25 [
    set new-growth1 floor(cur-growth1 / 25)
    set cur-growth1 (cur-growth1 - new-growth1 * 25)
    ask patches with [any? f1s-here]
         [
         ask neighbors with [decomp? and not any? other turtles-here]

              [sprout-f1s 1 [set color f1color]] ;TO-DO: Sprout concentrically?? used to be new-growth
        ]
        set new-growth1 0

    ]

    ;f2
    if cur-growth2 > 25 [
    set new-growth2 floor(cur-growth2 / 25)
    set cur-growth2 (cur-growth2 - new-growth2 * 25)
    ask patches with [any? f2s-here]
         [
         ask neighbors with [decomp? and not any? other turtles-here]

            [sprout-f2s 1 [set color f2color]]
        ]
        set new-growth2 0
    ]

    ;f3
    if cur-growth3 > 25 [
    set new-growth3 floor(cur-growth3 / 25)
    set cur-growth3 (cur-growth3 - new-growth3 * 25)
    ask patches with [any? f3s-here]
         [
         ask neighbors with [decomp? and not any? other turtles-here]

            [sprout-f3s 1 [set color f3color]]
        ]
        set new-growth3 0
    ]

    ;f4
    if cur-growth4 > 25 [
    set new-growth4 floor(cur-growth4 / 25)
    set cur-growth4 (cur-growth4 - new-growth4 * 25)
    ask patches with [any? f4s-here]
         [
         ask neighbors with [decomp? and not any? other turtles-here]

            [sprout-f4s 1 [set color f4color]]
        ]
        set new-growth4 0
    ]

    ;f5
    if cur-growth5 > 25 [
    set new-growth5 floor(cur-growth5 / 25)
    set cur-growth5 (cur-growth5 - new-growth5 * 25)
    ask patches with [any? f5s-here]
         [
         ask neighbors with [decomp? and not any? other turtles-here]

            [sprout-f5s 1 [set color f5color]]
        ]
        set new-growth5 0
    ]

    ;f6
    if cur-growth6 > 25 [
    set new-growth6 floor(cur-growth5 / 25)
    set cur-growth6 (cur-growth5 - new-growth5 * 25)
    ask patches with [any? f6s-here]
         [
         ask neighbors with [decomp? and not any? other turtles-here]

            [sprout-f6s 1 [set color f6color]]
        ]
        set new-growth6 0
    ]

    ;f7
    if cur-growth7 > 25 [
    set new-growth7 floor(cur-growth7 / 25)
    set cur-growth7 (cur-growth7 - new-growth7 * 25)
    ask patches with [any? f7s-here]
         [
         ask neighbors with [decomp? and not any? other turtles-here]

            [sprout-f7s 1 [set color f7color]]
        ]
        set new-growth7 0
    ]

    end

    to fight-fungi
        ask patches with [any? other turtles-here] [;[any? f1s-here] [
            let fight1 one-of turtles-here
            let fight1-rank rank of fight1
            ask neighbors with [any? other turtles-here with [ breed != [ breed ] of fight1]] [
                let fight2 one-of turtles-here
                let fight2-rank rank
                let rank-diff fight1-rank - fight2-rank
                ;if neg do nothing- so each set of turtles fight once
                if rank-diff > 0.7 and rank-diff <= 1 [set wait-time 1]
                if rank-diff > 0.4 and rank-diff <= 0.7 [set wait-time 2]
                if rank-diff > 0.1 and rank-diff <= 0.4[set wait-time 3]
                ;0.1 < rank-diff <= 0.1 [set wait-time 2] do nothing, standstill
            ] 
    

        ]
        set time-waited time-waited + 1
        ask patches [ 
        if time-waited >= wait-time 
        []
        ]

    end

    to add-litter ;only add litter during fall

    end

    to death-fungi ;die if growth rate < 25% of max
        ask f1s [if cur-growth-rate1 < 0.25 * max-rate1 [die]]
        ask f2s [if cur-growth-rate2 < 0.25 * max-rate2 [die]]
        ask f3s [if cur-growth-rate3 < 0.25 * max-rate3 [die]]
        ask f4s [if cur-growth-rate4 < 0.25 * max-rate4 [die]]
        ask f5s [if cur-growth-rate5 < 0.25 * max-rate5 [die]]
        ask f6s [if cur-growth-rate6 < 0.25 * max-rate6 [die]]
        ask f7s [if cur-growth-rate7 < 0.25 * max-rate7 [die]]
    end


    to decompose ;green
    ;cont scaling of brown color? scale-color

    ;f1
    ask patches with [any? f1s-here] [
        let new-decomp matter-decomp * decomp-rate1
        set matter-decomp matter-decomp - new-decomp
        set amount-decomp1 amount-decomp1 + new-decomp
    ]

    ;f2
    ask patches with [any? f2s-here] [
        let new-decomp matter-decomp * decomp-rate2
        set matter-decomp matter-decomp - new-decomp
        set amount-decomp2 amount-decomp2 + new-decomp
    ]

    ;f3
    ask patches with [any? f3s-here] [
        let new-decomp matter-decomp * decomp-rate3
        set matter-decomp matter-decomp - new-decomp
        set amount-decomp3 amount-decomp3 + new-decomp
    ]

    ;f4
    ask patches with [any? f4s-here] [
        let new-decomp matter-decomp * decomp-rate4
        set matter-decomp matter-decomp - new-decomp
        set amount-decomp4 amount-decomp4 + new-decomp
    ]

    ;f5
    ask patches with [any? f5s-here] [
        let new-decomp matter-decomp * decomp-rate5
        set matter-decomp matter-decomp - new-decomp
        set amount-decomp5 amount-decomp5 + new-decomp
    ]

    ;f6
    ask patches with [any? f6s-here] [
        let new-decomp matter-decomp * decomp-rate6
        set matter-decomp matter-decomp - new-decomp
        set amount-decomp6 amount-decomp6 + new-decomp
    ]
  
    ;f7
    ask patches with [any? f7s-here] [
        let new-decomp matter-decomp * decomp-rate7
        set matter-decomp matter-decomp - new-decomp
        set amount-decomp7 amount-decomp7 + new-decomp
    ]

    ask patches with [any? turtles-here] [
        ;update color
        ifelse matter-decomp >= .3
        [set pcolor scale-color brown matter-decomp brown-hi brown-lo]
        [set pcolor green set decomp? false
        ask turtles-here [die]]
    ]

    end

;update the plots ONLY USE FOR SPECIAL COUNTS
;to my-update-plots
  ;set-current-plot-pen "f1s"
  ;plot count f1s

  ;set-current-plot-pen "f2s"
  ;plot count f2s

  ;set-current-plot-pen "wolves"
  ;plot count wolves * 10 ;; scaling factor so plot looks nice

  ;set-current-plot-pen "grass"
  ;plot sum [ grass-amount ] of patches / 50 ;; scaling factor so plot looks nice

;end